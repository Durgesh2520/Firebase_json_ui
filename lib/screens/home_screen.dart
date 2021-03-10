import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:json_app/model/model.dart';
import 'package:json_app/screens/login_screen.dart';
import 'package:http/http.dart' as http;



class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String url;
  List data = [];
  var response;
  bool isLoading = true;

  List<Welcome2> welcome2 = [];

  Future<List<Welcome2>> getUsers() async {
    url = "https://jsonplaceholder.typicode.com/todos";
    response = await http.get(url);
    data = json.decode(response.body);

    setState(() {
      welcome2 = data.map((json) => Welcome2.fromJson(json)).toList();
      isLoading = false;
    });

    return welcome2;
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: Text("Home Screen"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  LoginScreen()));
            });
          }),
        ],
      ),
      body: isLoading == true
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: welcome2.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(welcome2[index].title),

              ),
            );
          },
        ),
      ),
    );
  }
}

