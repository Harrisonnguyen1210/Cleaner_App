import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/route_names.dart';
import 'package:flutter/material.dart';
import 'package:cleaner_app/screens/screens.dart';
import 'package:cleaner_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreeenState createState() => _HomeScreeenState();
}

class _HomeScreeenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final bool displayTabletLayout = MediaQuery.of(context).size.width > 500;
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Row(
        children: [
          if (displayTabletLayout) Container(width: screenSize.width * 0.2, child: AppDrawer(navigatorKey: Consts.navigatorKey)),
          Expanded(
            child: Navigator(
              key: Consts.navigatorKey,
              initialRoute: RouteNames.overview,
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case RouteNames.overview:
                    return MaterialPageRoute(
                        builder: (context) => OverviewScreen(),
                        settings: settings);
                    break;
                  case RouteNames.cleaning:
                    return MaterialPageRoute(
                        builder: (context) => CleaningScreen(),
                        settings: settings);
                    break;
                  case RouteNames.profile:
                    return MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                        settings: settings);
                    break;
                  case RouteNames.report:
                    return MaterialPageRoute(
                        builder: (context) => ReportScreen(),
                        settings: settings);
                    break;
                  case RouteNames.about:
                    return MaterialPageRoute(
                        builder: (context) => AboutScreen(),
                        settings: settings);
                    break;
                  case RouteNames.logout:
                    return MaterialPageRoute(
                        builder: (context) => LogoutScreen(),
                        settings: settings);
                    break;
                  default:
                    return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
