import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/route_names.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:cleaner_app/widgets/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  void _navigateToOverviewScreen(BuildContext context) {
    final drawerStateProvider =
        Provider.of<DrawerStateProvider>(context, listen: false);

    drawerStateProvider.setCurrentDrawer(0);
    Consts.navigatorKey.currentState
        .pushNamedAndRemoveUntil(RouteNames.overview, (_) => false);
  }

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
                              'https://cdn5.vectorstock.com/i/thumb-large/85/94/person-gray-photo-placeholder-man-silhouette-sign-vector-23838594.jpg'),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        CustomButton(
                          title: 'Assigned: ${assignedRooms.length} rooms',
                          onPress: () => _navigateToOverviewScreen(context),
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
