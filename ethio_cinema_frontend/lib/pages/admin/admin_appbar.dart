import 'package:ethio_cinema_frontend/bloc/bloc.dart';
import 'package:ethio_cinema_frontend/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCustomAppBar extends StatefulWidget {
  final String title;

  AdminCustomAppBar({this.title});

  @override
  _AdminCustomAppBarState createState() => _AdminCustomAppBarState();
}

class _AdminCustomAppBarState extends State<AdminCustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Text(widget.title),
      actions: plainappbar(),
      /*[
        InkWell(
          child: ShaderMask(
            child: Image(
                image: AssetImage("assets/search.png")),
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [const Color(0xff000000), const Color(0xff000000)],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchPage())),
        ),
        InkWell(
          child: ShaderMask(
            child: Image(
                image: AssetImage("assets/my_cart.png")),
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [const Color(0xff000000), const Color(0xff000000)],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
          ),
          onTap: (){},
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0,0,15.0,0),
          child: InkWell(
            child: GestureDetector(
              child: CircleAvatar(
                backgroundColor: const Color(0xff13c7ff),
                child: Stack(
                  children: [
                    Center(child: IconButton(icon: Icon(Icons.add), onPressed: (){}))
                  ],
                ),
              ),
            ),
          ),
        )
      ],*/
    );
  }

  List<Widget> plainappbar() {
    return [
      PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
        ),
        onSelected: handleClick,
        itemBuilder: (BuildContext context) {
          return {'Logout'}.map((String choice) {
            return PopupMenuItem<String>(
              value: choice,
              child: SizedBox(width: 100, child: Text(choice)),
            );
          }).toList();
        },
      ),
      //   IconButton(
      //       icon: Icon(
      //         Icons.shopping_cart,
      //         color: Colors.black,
      //         size: 30,
      //       ),
      //       onPressed: () {
      //         Navigator.push(
      //             context, MaterialPageRoute(builder: (context) => MyBookings()));
      //       }),
      //   Padding(
      //       padding: const EdgeInsets.fromLTRB(8.0, 0, 15.0, 0),
      //       child: InkWell(
      //           child: GestureDetector(
      //         child: CircleAvatar(
      //           radius: 15,
      //           backgroundColor: const Color(0xff000000),
      //           child: Stack(children: [
      //             Center(
      //               child: IconButton(
      //                   icon: Icon(
      //                     Icons.person_outline,
      //                     size: 15,
      //                     color: Colors.white,
      //                   ),
      //                   onPressed: () {
      //                     Navigator.push(
      //                         context,
      //                         MaterialPageRoute(
      //                             builder: (context) => UserProfilePage(
      //                                   user: User(
      //                                       fullname: "Danny Terefe",
      //                                       email: "dannyboy9917@gmail.com",
      //                                       password: "Dadusha99",
      //                                       phone: "0944194561"),
      //                                 )));
      //                   }),
      //             ),
      //           ]),
      //         ),
      //       )))
    ];
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        BlocProvider.of<AuthenticationBloc>(context).add(UserLoggedOut());
        Navigator.of(context)
            .popUntil(ModalRoute.withName(SignInPage.routeName));
        break;
    }
  }
}
