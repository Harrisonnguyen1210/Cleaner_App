import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/data/data.dart';
import 'package:cleaner_app/widgets/profile_form.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool displayTabletLayout = MediaQuery.of(context).size.width > 500;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: displayTabletLayout ? null : AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(48.0, 80.0, 48.0, 48.0),
        child: Row(
          children: [
            Container(
              width: screenSize.width * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 120.0,
                    backgroundImage: NetworkImage(
                        'https://i1.wp.com/psych2go.net/wp-content/uploads/2014/08/91df642880432da28c563dfc45fa57f5.jpg?fit=640%2C400&ssl=1'),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  ButtonCleaning(
                    title: 'Assigned: ${assignedRooms.length} rooms',
                  )
                ],
              ),
            ),
            VerticalDivider(
              indent: 0,
              endIndent: screenSize.height * 0.5,
              color: Consts.grey4,
              thickness: 5,
              width: 5,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 48), child: ProfileForm()),
            ),
          ],
        ),
      ),
    );
  }
}
