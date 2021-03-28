import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ethio_cinema_frontend/pages/screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_validator/form_validator.dart';

import 'package:ethio_cinema_frontend/models/user.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  final User user;
  UserProfilePage({@required this.user});
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool gotAccessToChange = false;
  bool canEdit = false;

  PickedFile _pickedFile;
  final ImagePicker _imagePicker = new ImagePicker();
  final TextEditingController _userFullNameEditingController =
      new TextEditingController();

  final TextEditingController _userEmailEditingController =
      new TextEditingController();

  final TextEditingController _userPhoneEditingController =
      new TextEditingController();

  final TextEditingController _userPasswordEditingController =
      new TextEditingController();

  // final TextEditingController _userProfilePictureEditingController =
  //     new TextEditingController();

  @override
  void initState() {
    super.initState();
    _userFullNameEditingController.value =
        TextEditingValue(text: widget.user.fullname);
    _userEmailEditingController.value =
        TextEditingValue(text: widget.user.email);
    _userPasswordEditingController.value =
        TextEditingValue(text: widget.user.password);
    _userPhoneEditingController.value =
        TextEditingValue(text: widget.user.phone);
    // _userProfilePictureEditingController.value =
    // TextEditingValue(text: widget.user.profilePicture);
  }

  @override
  Widget build(BuildContext context) {
    UserBloc userBloc = BlocProvider.of<UserBloc>(context);

    GlobalKey<FormState> _form = GlobalKey<FormState>();

    void _validate() {
      _form.currentState.validate();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: const Color(0xffdedede),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 30.0),
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 0, 5),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffe8e8e8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: TextFormField(
                          controller: _userFullNameEditingController,
                          validator: ValidationBuilder()
                              .minLength(5)
                              .maxLength(20)
                              .build(),
                          onChanged: (value) {
                            _validate();
                          },
                          decoration: InputDecoration(
                              labelText: "Username",
                              hintStyle: TextStyle(fontSize: 15),
                              // border: InputBorder.none,
                              contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 0, 5),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffe8e8e8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: TextFormField(
                          controller: _userEmailEditingController,
                          validator: ValidationBuilder().email().build(),
                          onChanged: (value) {
                            _validate();
                          },
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              labelText: "E-mail",
                              contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0)),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 0, 5),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 0, 5),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xfff2f2f2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )),
                      child: TextFormField(
                        controller: _userPasswordEditingController,
                        validator: ValidationBuilder()
                            .minLength(8)
                            .maxLength(20)
                            .build(),
                        onChanged: (value) {
                          _validate();
                        },
                        obscureText: !gotAccessToChange,
                        readOnly: !canEdit,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 15),
                          labelText: "Password",
                          contentPadding: EdgeInsets.fromLTRB(50, 5, 0, 0),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: canEdit
                                ? null
                                : () {
                                    String passChecker = "";
                                    return showDialog(
                                        context: context,
                                        builder: (context) {
                                          String invalidpass = "";

                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                            //String confirmPassHelperText = "";
                                            final TextEditingController
                                                _userPassCheckerController =
                                                new TextEditingController();
                                            return AlertDialog(
                                              title: Column(
                                                children: [
                                                  Text("Confirm Password"),
                                                ],
                                              ),
                                              content: Form(
                                                child: TextFormField(
                                                  controller:
                                                      _userPassCheckerController,
                                                  decoration: InputDecoration(
                                                      helperText: invalidpass,
                                                      helperStyle: TextStyle(
                                                          color: Colors
                                                              .redAccent)),
                                                  onChanged: (value) =>
                                                      passChecker = value,
                                                ),
                                              ),
                                              actions: [
                                                FlatButton(
                                                  child: Text("Confirm"),
                                                  onPressed: () {
                                                    if (passChecker ==
                                                        widget.user.password) {
                                                      setState(() {
                                                        gotAccessToChange =
                                                            !gotAccessToChange;
                                                        canEdit = !canEdit;
                                                        refreshPage();
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        invalidpass =
                                                            "Try Again!!!";
                                                        _userPassCheckerController
                                                                .value =
                                                            TextEditingValue(
                                                                text: "");
                                                      });
                                                    }
                                                  },
                                                )
                                              ],
                                            );
                                          });
                                        });
                                  },
                          ),
                        ),
                      ),
                    ),
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
                                // if (_form.currentState.validate()) {
                                //   return showDialog(
                                //       context: context,
                                //       child: AlertDialog(
                                //         actions: [
                                //           FlatButton(
                                //             onPressed: () =>
                                //                 Navigator.of(context)
                                //                     .pop(false),
                                //             child: Text("OK"),
                                //           )
                                //         ],
                                //       ));
                                // }
                              },
                              textColor: Colors.black45,
                              child: Text(
                                "EDIT",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff13c7ff),
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                              onPressed: () {
                                return (showDialog(
                                      context: context,
                                      builder: (context) => new AlertDialog(
                                        title: new Text('Are you sure?'),
                                        content: new Text(
                                            'Do you want to delete this Entry?'),
                                        actions: <Widget>[
                                          new FlatButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: new Text('No'),
                                          ),
                                          new FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                        content: Text(
                                                            "Account Successfuly Deleted "),
                                                        actions: [
                                                          FlatButton(
                                                            child: Text("OK"),
                                                            onPressed: () =>
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false),
                                                          )
                                                        ],
                                                      ));

                                              userBloc
                                                  .add(UserDelete(widget.user));
                                              BlocProvider.of<
                                                          AuthenticationBloc>(
                                                      context)
                                                  .add(UserLoggedOut());
                                              Navigator.of(context).popUntil(
                                                  ModalRoute.withName(
                                                      SignInPage.routeName));
                                            },
                                            child: new Text('Yes'),
                                          ),
                                        ],
                                      ),
                                    )) ??

                                    // if (_form.currentState.validate()) {
                                    //   return showDialog(
                                    //       context: context,
                                    //       child: AlertDialog(
                                    //         actions: [
                                    //           FlatButton(
                                    //             onPressed: () =>
                                    //                 Navigator.of(context)
                                    //                     .pop(false),
                                    //             child: Text("OK"),
                                    //           )
                                    //         ],
                                    //       ));
                                    // }

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyBookings()));
                              },
                              textColor: Colors.black45,
                              child: Text(
                                "DELETE ACCOUNT",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void refreshPage() {
    setState(() {});
  }
}
