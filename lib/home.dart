import 'package:flutter/material.dart';
import 'package:model_class/CreateUser.dart';
import 'Userlist.dart';
import 'Visitorlist.dart';
import 'CreateVisitor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const VisitorList()));
                },
                child: Text("Visitor List")
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserList()),
                );
              },
              child: const Text("User List"),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateUser()),
                );
              },
              child: const Text("Create User"),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateVisitor()),
                );
              },
              child: const Text("Create Visitor"),
            ),
            SizedBox(height: 15),
          ],
        ),
      )
    );
  }
}
