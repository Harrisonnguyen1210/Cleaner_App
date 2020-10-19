import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/route_names.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const AppDrawer({Key key, this.navigatorKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Consts.secondaryBlack,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.menu,
                color: Consts.primaryBlue,
              ),
              title: Text(
                'MENU',
                style: TextStyle(color: Consts.white),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.desktop_windows,
                color: Consts.primaryBlue,
              ),
              title: Text(
                'OVERVIEW',
                style: TextStyle(color: Consts.white),
              ),
              onTap: () => navigatorKey.currentState
                  .pushReplacementNamed(RouteNames.overview),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Consts.primaryBlue,
              ),
              title: Text(
                'PROFILE',
                style: TextStyle(color: Consts.white),
              ),
              onTap: () => navigatorKey.currentState
                  .pushReplacementNamed(RouteNames.profile),
            ),
            ListTile(
              leading: Icon(
                Icons.assignment,
                color: Consts.primaryBlue,
              ),
              title: Text(
                'REPORT',
                style: TextStyle(color: Consts.white),
              ),
              onTap: () => navigatorKey.currentState
                  .pushReplacementNamed(RouteNames.report),
            ),
          ],
        ),
      ),
    );
  }
}
