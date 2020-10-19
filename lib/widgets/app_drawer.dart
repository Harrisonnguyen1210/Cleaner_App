import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/route_names.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const AppDrawer({Key key, this.navigatorKey}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int _selectedIndex = 0;

  final _drawerItemData = [
    {
      'icon': Icons.desktop_windows,
      'title': 'OVERVIEW',
      'route': RouteNames.overview,
    },
    {
      'icon': Icons.person,
      'title': 'PROFILE',
      'route': RouteNames.profile,
    },
    {
      'icon': Icons.assignment,
      'title': 'REPORT',
      'route': RouteNames.report,
    },
  ];

  void _onSelectedItem(int index) {
    setState(() {
      _selectedIndex = index;
      widget.navigatorKey.currentState
          .pushReplacementNamed(_drawerItemData[index]['route']);
    });
  }

  Widget _buildDrawerItem(int index) {
    return Container(
      color:
          _selectedIndex == index ? Consts.primaryBlue : Consts.secondaryBlack,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onSelectedItem(index),
          child: Container(
            height: 80,
            child: Center(
              child: ListTile(
                selected: _selectedIndex == index,
                leading: Icon(
                  _drawerItemData[index]['icon'],
                  color: _selectedIndex == index
                      ? Consts.white
                      : Consts.primaryBlue,
                ),
                title: Text(
                  _drawerItemData[index]['title'],
                  style: TextStyle(color: Consts.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Consts.secondaryBlack,
        child: Column(
          children: [
            Container(
              height: 80,
              child: Center(
                child: ListTile(
                  leading: Icon(
                    Icons.menu,
                    color: Consts.primaryBlue,
                  ),
                  title: Text(
                    'MENU',
                    style: TextStyle(color: Consts.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            ..._drawerItemData
                .asMap()
                .entries
                .map((mapEntry) => _buildDrawerItem(mapEntry.key))
                .toList()
          ],
        ),
      ),
    );
  }
}
