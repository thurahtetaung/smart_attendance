import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_attendance/components/rounded_button.dart';
import 'package:smart_attendance/services/auth.dart';
import 'package:smart_attendance/shared/constants.dart';
import 'package:smart_attendance/shared/loading.dart';
import 'dart:io';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String name = '';
  String error = '';
  int year = 1;
  int roll = 1;
  String major = 'EcE';
  final ImagePicker _picker = ImagePicker();
  File _image;
  Future getImage() async {
    final pickedFile =
        await _picker.getImage(source: ImageSource.camera, maxHeight: 480.0);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        //print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  var _majors = [
    'EcE',
    'C',
    'CEIT',
    'Tex',
    'Che',
    'McE',
    'Mech',
    'Met',
    'Mn',
    'Arch',
    'EP',
    'PE'
  ];
  var _years = [1, 2, 3, 4, 5, 6];

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: kPrimaryLightColor[200],
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              elevation: 0,
              title: Text('Sign up to Your Class'),
              actions: [
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter your year',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16),
                          ),
                          DropdownButton<int>(
                            items: _years
                                .map((int dropDownIntItem) =>
                                    DropdownMenuItem<int>(
                                      value: dropDownIntItem,
                                      child: Text('$dropDownIntItem'),
                                    ))
                                .toList(),
                            onChanged: (int newIntValueSelected) {
                              setState(() {
                                year = newIntValueSelected;
                              });
                            },
                            value: year,
                          ),
                          Padding(padding: EdgeInsets.only(right: 1))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter your major',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16),
                          ),
                          DropdownButton<String>(
                            items: _majors
                                .map((String dropDownStringItem) =>
                                    DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(dropDownStringItem),
                                    ))
                                .toList(),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                major = newValueSelected;
                              });
                            },
                            value: major,
                          ),
                          Padding(padding: EdgeInsets.only(right: 1))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Roll Number',
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter your roll number' : null,
                        onChanged: (val) {
                          setState(() {
                            roll = int.parse(val);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your full name',
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter your name' : null,
                        onChanged: (val) {
                          setState(() {
                            name = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email.' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextFormField(
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                        ),
                        validator: (val) => val.length < 6
                            ? 'Password must be longer than 6 characters.'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RoundedButton(
                      text: 'Take Picture',
                      press: getImage,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    RoundedButton(
                      text: "Register",
                      press: () async {
                        print(_image);
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result;

                          if (_image == null) {
                            result = null;
                          } else {
                            result = await _auth.registerWithEmailAndPassword(
                                email: email,
                                password: password,
                                name: name,
                                major: major,
                                year: year,
                                roll: roll,
                                img: _image);
                          }

                          if (result == null) {
                            if (_image == null) {
                              setState(() {
                                error =
                                    'You need to take a picture to register.';
                                loading = false;
                              });
                            } else {
                              setState(() {
                                error =
                                    'Could not register with those credentials.';
                                loading = false;
                              });
                            }
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ));
  }
}
