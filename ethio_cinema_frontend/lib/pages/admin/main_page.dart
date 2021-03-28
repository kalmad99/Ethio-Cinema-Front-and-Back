import 'package:ethio_cinema_frontend/pages/admin/admin_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ethio_cinema_frontend/pages/screen.dart';

class AdminMainPage extends StatefulWidget {
  AdminMainPage({Key key}) : super(key: key);
  static final String routeName = "AdminMainPage";

  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final List<String> paths = [
    "Admin/Movies",
    "Admin/Cinemas",
  ];
  String currentpath;

  @override
  void initState() {
    currentpath = paths[0];
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(changepath);
    super.initState();
  }

  void changepath() {
    setState(() {
      currentpath = paths[tabController.index];
    });
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
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AdminCustomAppBar(
              title: currentpath,
            )),
        body: TabBarView(
          controller: tabController,
          children: [
            MoviesListPage(),
            // Center(
            //   child: Text(
            //     "Cinemas",
            //     style: TextStyle(fontSize: 72.0),
            //   ),
            // ),
            CinemaListTrial(),
          ],
        ),

        bottomNavigationBar: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              icon: Icon(
                Icons.movie,
                color: Colors.blue,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.theaters_rounded,
                color: Colors.blue,
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
