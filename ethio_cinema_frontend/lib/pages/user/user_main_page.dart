import 'package:ethio_cinema_frontend/models/model.dart';

import 'package:ethio_cinema_frontend/pages/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserMainPage extends StatefulWidget {
  @override
  _UserMainPageState createState() => _UserMainPageState();

  static final String routeName = "UserMainPage";
}

class _UserMainPageState extends State<UserMainPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  Future<bool> _onWillPop() async {
    if (tabController.index != 0) {
      tabController.index = 0;
      return null;
    }
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit this App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => SystemNavigator.pop(),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60), child: CustomAppBar()),
        body: TabBarView(
          controller: tabController,
          children: [
/*
            Center(
              child: Text("Movies",
              style: TextStyle(
                fontSize: 72.0
              ),
              ),
            ),
*/

            UserMovieListPage(),
            // Center(
            //   child: Text(
            //     "Cinemas",
            //     style: TextStyle(fontSize: 72.0),
            //   ),
            // ),
            UserCinemaList(),
            UserProfilePage(
              user: User(
                  fullname: "Danny Terefe",
                  email: "dannyboy9917@gmail.com",
                  password: "Dadusha99",
                  phone: "0944194561"),
            ),
          ],
        ),

/*
        Container(
          color: const Color(0xffdedede),
          child: Center(
            child: Text("Home",
              style: TextStyle(
                  fontSize: 72.0
              ),),
          ),
        ),
*/
        bottomNavigationBar: TabBar(
          indicatorColor: const Color(0xff13c7ff),
          controller: tabController,
          tabs: [
            Tab(
              icon: Icon(
                Icons.movie,
                color: const Color(0xff13c7ff),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.location_city,
                color: const Color(0xff13c7ff),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.info,
                color: const Color(0xff13c7ff),
              ),
            ),
          ],
        ),
        //CustomBottomNavigationBar("home"),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
      ),
    );
  }
}
