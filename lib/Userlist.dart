import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'user.dart' as user;
import 'createUser.dart';
import 'home.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  user.User? userData;
  List<user.Content> users = [];
  bool loader = false;

  String? token1;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      loader = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    setState(() {
      token1 = token;
    });

    if (token == null) {
      showSnackBar("No token found, redirecting to login...");
      return;
    }

    final url = Uri.parse('https://bleapi.corpfield.com/getUserList');

    final requestBody = {
      "pageNumber": 0,
      "pageSize": 10,
      "searchKey": "",
      "sortField": "",
      "sortMethod": ""
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        setState(() {
          loader = false;
        });
        final jsonData = jsonDecode(response.body);
        final parsedUser = user.User.fromJson(jsonData);
        print(parsedUser);
        setState(() {
          userData = parsedUser;
        });
      } else {
        setState(() {
          loader = false;
        });
        showSnackBar("Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        loader = false;
      });
      showSnackBar("Exception: $e");
    }
  }

  Future<void> deleteUser(num? internalUserId, int index) async {
    if (internalUserId == null) {
      showSnackBar("User ID not found");
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      showSnackBar("No token found, please login again.");
      return;
    }

    final response = await http.delete(
      Uri.parse('https://bleapi.corpfield.com/deleteUser/$internalUserId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
       fetchData();
      showSnackBar("User deleted successfully");
    } else {
      showSnackBar("Failed to delete user: ${response.body}");
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User list"),
          leading: IconButton(
      icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), 
        child:  loader == true?Center(child: CircularProgressIndicator(),) :
        userData == null || userData?.data?.content == null
            ? const Center(child:
        Text("No data found"))
            : ListView.builder(
          itemCount: userData?.data?.content?.length ?? 0,
          itemBuilder: (context, index) {
            final user1 = userData?.data?.content?[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: (user1?.profileImageUrl != null &&
                      user1?.profileImageUrl!.isNotEmpty)
                      ? NetworkImage(
                  "https://bleapi.corpfield.com/getFileStream?filename="+
                      user1?.profileImageUrl,
                  headers: {
                    'Authorization':
                    'Bearer $token1',
                  },
                )
                      : null,
                  child: (user1?.profileImageUrl == null ||
                      user1?.profileImageUrl!.isEmpty)
                      ? const Icon(Icons.person)
                      : null,
                ),
                title: Text(
                  "${user1?.firstName ?? ''} ${user1?.lastName ?? ''}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email: ${user1?.email ?? 'N/A'}"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: "Delete user",
                  onPressed: () async {
                    await deleteUser(user1?.internalUserId?.toInt(), index);
                  },
                ),
                onTap: () async {
                  final updated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreateUser(userData: user1),
                    ),
                  );

                  if (updated == true) {
                    fetchData();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}