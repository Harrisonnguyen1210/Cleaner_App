import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/helpers/error_dialog.dart';
import 'package:cleaner_app/route_names.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final _drawerItemData = const [
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
    {'icon': Icons.logout, 'title': 'LOGOUT', 'route': RouteNames.logout}
  ];
  AppDrawer({Key key, this.navigatorKey}) : super(key: key);

  Widget _buildDrawerItem(int index, DrawerStateProvider drawerStateProvider, BuildContext context) {
    return Container(
      color: drawerStateProvider.getCurrentDrawer == index
          ? Consts.primaryBlue
          : Consts.secondaryBlack,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (drawerStateProvider.canBeNavigated) {
              drawerStateProvider.setCurrentDrawer(index);
              navigatorKey.currentState.pushNamedAndRemoveUntil(
                  _drawerItemData[index]['route'], (_) => false);
            } else if (drawerStateProvider.getCurrentDrawer == 0) {
              ErrorDialog.showErrorDialog(context, Consts.pleaseFinishCleaning);
            }
          },
          child: Container(
            height: 80,
            child: Center(
              child: ListTile(
                selected: drawerStateProvider.getCurrentDrawer == index,
                leading: Icon(
                  _drawerItemData[index]['icon'],
                  color: drawerStateProvider.getCurrentDrawer == index
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
    final drawerStateProvider = Provider.of<DrawerStateProvider>(context);
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
                .map((mapEntry) =>
                    _buildDrawerItem(mapEntry.key, drawerStateProvider, context))
                .toList()
          ],
        ),
      ),
    );
  }
}
