import 'package:flutter/material.dart';
import 'package:cleaner_app/widgets/widgets.dart';

class OverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool displayTabletLayout = MediaQuery.of(context).size.width > 500;

    return Scaffold(
      body: Text('Overview Screen'),
      drawer: displayTabletLayout ? null : AppDrawer(),
    );
  }
}
