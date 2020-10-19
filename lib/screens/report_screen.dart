import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool displayTabletLayout = MediaQuery.of(context).size.width > 500;

    return Scaffold(
      body: Text('Report Screen'),
      drawer: displayTabletLayout ? null : AppDrawer(),
    );
  }
}
