import 'bloc/authentication_bloc.dart';
import 'bloc/bloc.dart';
import 'models/user.dart';
import 'repository/authentication_repository.dart';
import 'sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';

class AuthForm extends StatelessWidget {
  BuildContext context;
  AuthForm({
    this.context,
  });
  @override
  Widget build(BuildContext context) {
    final authService =
        RepositoryProvider.of<AuthenticationRepository>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Container(
      alignment: Alignment.center,
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authService),
        child: SignInPage(),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  static const String routeName = "/";
  String username = "";
  String password = "";
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool _validate() {
    return _form.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    String helperMessage = "";
    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: const Color(0xffdedede),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 50, 0.0, 80.0),
                      child: Image(
                        image: AssetImage("assets/logo.png"),
                        height: 100.0,
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffe8e8e8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              hintText: "Email",
                              // border: InputBorder.none,
                              contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                          onChanged: (value) {
                            username = value;
                          },
                          validator: ValidationBuilder()
                              .minLength(
                                  5, "Username Must be at least 5 characters")
                              .maxLength(
                                  20, "Username Must be atmost 20 characters")
                              .build(),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffe8e8e8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 15),
                              hintText: "Password",
                              // border: InputBorder.none,
                              contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0)),
                          obscureText: true,
                          validator: ValidationBuilder()
                              .minLength(
                                  8, "Password Must be at least 8 characters")
                              .maxLength(
                                  20, "Password Must be at most 20 characters")
                              .build(),
                          onChanged: (value) {
                            password = value;
                          },
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                              onPressed: () {
                                // if (_validate()) {
                                //   if (checkCredentials(
                                //           username, password, context) ==
                                //       "admin") {
                                //     Navigator.of(context)
                                //         .pushNamed(AdminMainPage.routeName);
                                //   } else
                                //     Navigator.of(context)
                                //         .pushNamed(UserMainPage.routeName);
                                // }
                                if (_validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      LoginInWithEmailButtonPressed(
                                          user: User.login(
                                              email: username,
                                              password: password)));
                                }
                              },
                              textColor: Colors.black45,
                              child: Text("Sign In"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color(0xff13c7ff),
                                borderRadius: BorderRadius.circular(10)),
                            child: MaterialButton(
                              onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage())),
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  String checkCredentials(
      String username, String password, BuildContext context) {
    if (username == "admin" && password == "admin1234") return "admin";
    return "user";
  }
}
