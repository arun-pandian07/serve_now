import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'rolls.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'user.dart' as user;
import 'Userlist.dart';

class CreateUser extends StatefulWidget {
  final user.Content? userData;
  const CreateUser({super.key, this.userData});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  List<Data> roles = [];
  String? selectedRoleName;
  int? selectedRoleId;
  bool selectedStatus = false;
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    fetchRoles();
    if (widget.userData != null) {
      isEditMode = true;
      fnameController.text = widget.userData!.firstName ?? "";
      lnameController.text = widget.userData!.lastName?.toString() ?? "";
      emailController.text = widget.userData!.email ?? "";
      selectedRoleName = widget.userData!.role;
      selectedRoleId = widget.userData!.roleId?.toInt();
      selectedStatus = widget.userData!.status ?? false;
    }
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickFromSource(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _pickFromSource(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickFromSource(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Camera permission denied")),
        );
        return;
      }
    } else {
      var status = await Permission.photos.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gallery permission denied")),
        );
        return;
      }
    }
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 75,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> fetchRoles() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final url = Uri.parse("https://bleapi.corpfield.com/get_all_roles");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        Rolls rolls = Rolls.fromJson(jsonResponse);
        setState(() {
          roles = rolls.data ?? [];
        });
      }
    } catch (e) {
      print("Error fetching roles: $e");
    }
  }

  Future<void> createUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final url = Uri.parse("https://bleapi.corpfield.com/createUser");
    try {
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.fields['firstName'] = fnameController.text.trim();
      request.fields['lastName'] = lnameController.text.trim();
      request.fields['email'] = emailController.text.trim();
      request.fields['password'] = passwordController.text.trim();
      request.fields['roleId'] = selectedRoleId.toString();
      request.fields['status'] = selectedStatus.toString();
      if (_imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profileImage', _imageFile!.path),
        );
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User created successfully!")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserList()),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to create user: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error creating user: $e")),
      );
    }
  }

  Future<void> updateUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final url = Uri.parse("https://bleapi.corpfield.com/editUser");
    try {
      var request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = 'Bearer $token';

      // Use internalUserId field key as per your data model/backend
      request.fields['internalUserId'] = widget.userData!.internalUserId.toString();

      request.fields['firstName'] = fnameController.text.trim();
      request.fields['lastName'] = lnameController.text.trim();
      request.fields['email'] = emailController.text.trim();

      if (passwordController.text.isNotEmpty) {
        request.fields['password'] = passwordController.text.trim();
      }
      request.fields['roleId'] = selectedRoleId.toString();
      request.fields['status'] = selectedStatus.toString();

      if (_imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profileImage', _imageFile!.path),
        );
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User updated successfully!")),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update user: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating user: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? "Edit User" : "Create User"),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                      _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? const Icon(Icons.add_a_photo, color: Colors.black54)
                          : null,
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: fnameController,
                    decoration: const InputDecoration(
                      labelText: "First Name",
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter your First name' : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: lnameController,
                    decoration: const InputDecoration(
                      labelText: "Last Name",
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter your Last name' : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter your Email' : null,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (!isEditMode && value!.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  DropdownButtonFormField<String>(
                    value: selectedRoleName,
                    hint: const Text("Select Role"),
                    items: roles.map((role) {
                      return DropdownMenuItem<String>(
                        value: role.roleName,
                        child: Text(role.roleName ?? ""),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRoleName = value;
                        final role =
                        roles.firstWhere((r) => r.roleName == value);
                        selectedRoleId = role.roleId?.toInt();
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  SwitchListTile(
                    title: Text(
                      selectedStatus ? "Active" : "Inactive",
                      style: const TextStyle(fontSize: 16),
                    ),
                    value: selectedStatus,
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (selectedRoleId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select role & status"),
                            ),
                          );
                          return;
                        }
                        if (isEditMode) {
                          updateUser();
                        } else {
                          createUser();
                        }
                      }
                    },
                    child: Text(isEditMode ? "Update User" : "Create User"),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}