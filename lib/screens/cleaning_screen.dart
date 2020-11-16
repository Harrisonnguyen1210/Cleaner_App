import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/models/models.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class CleaningScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Room currentRoom = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: Consts.cleaningScreenKey,
      appBar: CustomAppBar.getAppBar(Text(currentRoom.name)),
      body: ChangeNotifierProvider(
        create: (buildContext) => SingleRoomProvider(currentRoom),
        child: CleaningScreenContent(),
      ),
    );
  }
}
