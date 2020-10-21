import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';
import 'package:cleaner_app/widgets/widgets.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool displayTabletLayout = MediaQuery.of(context).size.width > 500;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(
          width: 220,
          height: 50,
          margin: EdgeInsets.only(left: 32),
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Consts.secondaryBlack,
          ),
          child: Row(
            children: [
              Icon(Icons.search),
              SizedBox(width: 8),
              Text('Search...'),
            ],
          ),
        ),
        backgroundColor: Consts.blackLight,
        toolbarHeight: 80,
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
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Welcome back ',
                        style: TextStyle(
                          color: Consts.textGrey,
                          fontSize: 20,
                        )),
                    TextSpan(
                      text: 'Harrison',
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
            SizedBox(height: 32),
            SelectDropDownRow(),
            SizedBox(height: 32),
            RoomTable()
          ],
        ),
      ),
      drawer: displayTabletLayout ? null : AppDrawer(),
    );
  }
}
