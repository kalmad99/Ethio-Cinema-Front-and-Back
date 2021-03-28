import 'package:ethio_cinema_frontend/pages/user/about_us_page.dart';

import 'package:ethio_cinema_frontend/bloc/authentication_bloc.dart';
import 'package:ethio_cinema_frontend/bloc/authentication_event.dart';
import 'package:ethio_cinema_frontend/pages/screen.dart';
import 'package:ethio_cinema_frontend/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffdedede),
      automaticallyImplyLeading: false,
      elevation: 0,
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
      IconButton(
          icon: Icon(
            Icons.search,
            color: const Color(0xff13c7ff),
            size: 30,
          ),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SearchPage()))),
      PopupMenuButton<String>(
        icon: Icon(
          Icons.more_vert,
          color: const Color(0xff13c7ff),
        ),
        onSelected: handleClick,
        itemBuilder: (BuildContext context) {
          return {'Logout', 'About Us'}.map((String choice) {
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
      //         color: Colors.const Color(0xff13c7ff),,
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
      case 'About Us':
        Navigator.of(context).pushNamed(AboutUs.routeName);
        break;
    }
  }
}
