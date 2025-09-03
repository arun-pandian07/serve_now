import 'package:flutter/material.dart';
import 'package:model_class/visitor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'visitor1.dart' ;

class CreateVisitor extends StatefulWidget {
  final Visitor1? visitorData;
  const CreateVisitor({super.key, this.visitorData});

  @override
  State<CreateVisitor> createState() => _CreateVisitorState();
}

class _CreateVisitorState extends State<CreateVisitor> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  bool selectedStatus = false;

  bool isEditMode = false;

  @override
  void initState() {
    super.initState();

       if (widget.visitorData != null) {
      isEditMode = true;
      // //nameController.text = widget.visitorData!.data. ?? "";
      // emailController.text = widget.visitorData!.email ?? "";
      // phoneController.text = widget.visitorData!.phoneNumber ?? "";
      // selectedStatus = widget.visitorData!.status ?? false;
    }
  }

  Future<void> createVisitor() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final url = Uri.parse("https://bleapi.corpfield.com/addVisitors");

    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final body = jsonEncode({
        "userName": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phoneNumber": phoneController.text.trim(),
        "status": selectedStatus.toString(),
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Visitor created successfully!")),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> updateVisitor() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    final url = Uri.parse("https://bleapi.corpfield.com/editVisitor");

    try {
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final body = jsonEncode({
        // "visitorId": widget.visitorData!.visitorId,
        // "visitorUserUuid": widget.visitorData!.visitorUserUuid,
        "userName": nameController.text.trim(),
        "email": emailController.text.trim(),
        "phoneNumber": phoneController.text.trim(),
        "status": selectedStatus,
      });

      final response = await http.put(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Visitor updated successfully!")),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update visitor: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating visitor: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? "Edit Visitor" : "Create Visitor"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isEditMode ? 'Update Visitor Details' : 'Enter Visitor Details',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),

                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter visitor name' : null,
                ),
                SizedBox(height: 15),

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter visitor email' : null,
                ),
                SizedBox(height: 15),

                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: TextStyle(color: Colors.blue),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter phone number' : null,
                ),
                SizedBox(height: 15),

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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (isEditMode) {
                        updateVisitor();
                      } else {
                        createVisitor();
                      }
                    }
                  },
                  child: Text(isEditMode ? 'Update Visitor' : 'Create Visitor'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
