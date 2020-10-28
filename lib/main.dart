import 'package:cleaner_app/helpers/custom_page_transition_builder.dart';
import 'package:cleaner_app/screens/screens.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Cleaner App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            },
          ),
        ),
        home: HomeScreen(),
      ),
      providers: [
        ChangeNotifierProvider(create: (buildContext) => DrawerStateProvider()),
        ChangeNotifierProvider(create: (buildContext) => RoomsProvider()),
      ],
    );
  }
}
