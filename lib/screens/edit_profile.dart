import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_app/screens/login_screen.dart';
import 'package:json_app/services/authenticationService.dart';


class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _key = GlobalKey<FormState>();

  final AuthenticationService _auth = AuthenticationService();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _locationController = TextEditingController();


  bool isLoading = false;
  File _imageFile = null;
  @override
  Widget build(BuildContext context) {
    Future pickImage() async {
      var file = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imageFile = file;
      });

    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: Text("Edit Profile"),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (_) =>
                  LoginScreen()));
            });
          }),
        ],
      ),
      body: isLoading? Center(
          child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Form(
              key: _key,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                ))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.white,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.camera,
                                size: 30.0,
                              ),
                              onPressed: () {
                                pickImage();
                              },
                            ),
                          )),
                    ],
                  ),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return value.length > 0 ? null : "Enter valid Name";
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Name",
                        labelText: "Name",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) {
                      return value.length < 10
                          ? "Enter valid Mobile"
                          : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Mobile Number",
                        labelText: "Mobile Number",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      return value.contains("@")
                          ? null
                          : "Enter valid Email";
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Email",
                        labelText: "Email",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return value.length > 6
                          ? null
                          : "Password must be 6 characters";
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _locationController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      return value.length > 0 ? null : "Enter valid location";
                    },
                    decoration: InputDecoration(
                        hintText: "Enter Your Location",
                        labelText: "Location",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),),
        ),
      ),
    );
  }
}