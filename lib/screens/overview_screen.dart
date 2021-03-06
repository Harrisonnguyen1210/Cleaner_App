import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/services/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:cleaner_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool displayTabletLayout = MediaQuery.of(context).size.width > 500;

    return Scaffold(
      appBar: CustomAppBar.getAppBar(
        SizedBox.shrink(),
        context,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(48, 48, 48, 48),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Rooms Overview',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Consumer<AuthProvider>(
                builder: (buildContext, authProvider, child) => RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'Welcome back ',
                          style: TextStyle(
                            color: Consts.textGrey,
                            fontSize: 20,
                          )),
                      TextSpan(
                        text: authProvider.cleaner.name,
                        style: TextStyle(
                          color: Consts.primaryBlue,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            SelectDropDownRow(),
            SizedBox(height: 32),
            Expanded(child: RoomTable())
          ],
        ),
      ),
      drawer: displayTabletLayout ? null : AppDrawer(),
    );
  }
}
