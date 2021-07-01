import 'package:flutter/material.dart';
import '../provider/auth.dart';
import './home_screen.dart';
import './auth_screen.dart';

class Appdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          padding: EdgeInsets.fromLTRB(2, 100, 2, 10),
          children: <Widget>[
            Divider(),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
              onLongPress: () {},
            ),
            Divider(),
            ListTile(
              title: Text('DashBoard'),
              leading: Icon(Icons.dashboard),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Homescreen.route);
              },
            ),
            ListTile(
                title: Text('Sign out'),
                leading: Icon(Icons.logout),
                onTap: () {
                  Navigator.of(context).pop();
                }),
          ]),
    );
  }
}
