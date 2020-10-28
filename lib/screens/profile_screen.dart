import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:cleaner_app/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool displayTabletLayout = MediaQuery.of(context).size.width > 500;
    final screenSize = MediaQuery.of(context).size;
    final roomsProvider = Provider.of<RoomsProvider>(context);
    final assignedRooms = roomsProvider.rooms;    

    return Scaffold(
      appBar: CustomAppBar.getAppBar(null),
      drawer: displayTabletLayout ? null : AppDrawer(),
      //Use CustomScrollView to fix content not fill entire screen issue
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(48.0, 64.0, 48.0, 48.0),
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
                      padding: EdgeInsets.only(left: 48),
                      child: ProfileForm(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
