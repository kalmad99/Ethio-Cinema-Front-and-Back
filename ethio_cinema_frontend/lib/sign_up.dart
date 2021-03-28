import 'dart:io';

import 'package:ethio_cinema_frontend/repository/repository.dart';
import 'package:ethio_cinema_frontend/sign_in.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'models/model.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';

class SignupForm extends StatelessWidget {
  BuildContext context;
  SignupForm({
    this.context,
  });
  @override
  Widget build(BuildContext context) {
    final authService =
        RepositoryProvider.of<AuthenticationRepository>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final userRepo = RepositoryProvider.of<UserRepository>(context);
    return Container(
      alignment: Alignment.center,
      child: BlocProvider<UserBloc>(
        create: (context) => UserBloc(
            userRepository: userRepo,
            authenticationBloc: authBloc,
            authenticationRepository: authService),
        child: SignUpPage(),
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  static const String routeName = "/signUp";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  PickedFile _pickedFile;
  String name = "";
  String password = "";
  String email = "";

  final ImagePicker _imagePicker = new ImagePicker();

  GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool _validate() {
    return _form.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: const Color(0xffdedede),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 8.0),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Form(
                      key: _form,
                      child: Column(
                        children: [
                          InkWell(
                            child: CircleAvatar(
                              radius: 80.0,
                              backgroundImage: _pickedFile == null
                                  ? AssetImage("assets/profile.png")
                                  : FileImage(File(_pickedFile.path)),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => chooseImageSource()));
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffe8e8e8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                validator: ValidationBuilder()
                                    .minLength(5)
                                    .maxLength(20)
                                    .build(),
                                onChanged: (value) {
                                  name = value;
                                  // _validate();
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 15),
                                    hintText: "Username",
                                    // border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(50, 0, 0, 0)),
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffe8e8e8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                validator: ValidationBuilder().email().build(),
                                onChanged: (value) {
                                  email = value;
                                  // _validate();
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 15),
                                    hintText: "E-mail",
                                    // border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(50, 0, 0, 0)),
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xffe8e8e8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                validator: ValidationBuilder().phone().build(),
                                onChanged: (value) {
                                  //_validate();
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 15),
                                    hintText: "Phone",
                                    // border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(50, 0, 0, 0)),
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xfff2f2f2),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextFormField(
                                validator: ValidationBuilder()
                                    .minLength(8)
                                    .maxLength(20)
                                    .build(),
                                onChanged: (value) {
                                  password = value;
                                  // _validate();
                                },
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 15),
                                    hintText: "Password",
                                    // border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(50, 0, 0, 0)),
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff13c7ff),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (_validate()) {
                                        BlocProvider.of<UserBloc>(context)
                                            .add(UserCreate(
                                          User(
                                              fullname: name,
                                              email: email,
                                              password: password),
                                        ));

                                        Navigator.of(context).popUntil(
                                            ModalRoute.withName(
                                                SignInPage.routeName));

                                        //Navigator.of(context).pop();
                                      }
                                    },
                                    textColor: Colors.black45,
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget chooseImageSource() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Choose Profile Image Source",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton.icon(
                icon: Icon(
                  Icons.camera,
                  size: 30,
                ),
                label: Text("From Camera"),
                onPressed: () {
                  getImage(ImageSource.camera);
                },
              ),
              FlatButton.icon(
                icon: Icon(
                  Icons.image,
                  size: 30,
                ),
                label: Text("From Gallery"),
                onPressed: () {
                  getImage(ImageSource.gallery);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  void getImage(ImageSource _imageSource) async {
    final _image = await _imagePicker.getImage(source: _imageSource);
    setState(() {
      _pickedFile = _image;
    });
  }
}
