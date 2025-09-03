import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'CreateVisitor.dart';
import 'model.dart' as model;
import 'user.dart' as user;
import 'Userlist.dart';
import 'home.dart';

class VisitorList extends StatefulWidget {
  const VisitorList({super.key});

  @override
  State<VisitorList> createState() => _VisitorListState();
}

class _VisitorListState extends State<VisitorList> {
  model.Model? modelData;
  List<model.Content> visitors = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      print("No token found, redirecting to login...");
      return;
    }

    final url = Uri.parse('https://bleapi.corpfield.com/getVisitorsList');

    final requestBody = {
      "pageNumber": 0,
      "pageSize": 5,
      "searchKey": "",
      "sortField": "",
      "sortMethod": "",
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

      print('Raw response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        final parsedModel = model.Model.fromJson(jsonData);

        setState(() {
          modelData = parsedModel;
          visitors = parsedModel.data?.content ?? [];
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  Future<void> deleteUser(num? visitorID, int index) async {
    if (visitorID == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content:Text("Visitor ID not found")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text("No token found, please login again.")),
      );
      return;
    }

    final response = await http.delete(
      Uri.parse('https://bleapi.corpfield.com/deleteVisitors/$visitorID'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      fetchData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text("Visitor deleted successfully")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content:Text("Failed to delete visitor: ${response.body}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Visitor list"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: modelData == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: visitors.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final visitor = visitors[index];
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(visitor.userName ?? 'No Name'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email: ${visitor.email}"),
                                Text("Phone: ${visitor.phoneNumber}"),
                                Text("ID: ${visitor.visitorId}"),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                await deleteUser(visitor.visitorId?.toInt(), index);
                              },
                              icon: Icon(Icons.delete),
                            ),

                            onTap: () async {
                            //   final updated = await Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => CreateVisitor(visitorData: visitor),
                            //     ),
                            //   );
                            //
                            //   //
                            //   if (updated == true) {
                            //     fetchData();
                            //   }
                            },
                          )

                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
