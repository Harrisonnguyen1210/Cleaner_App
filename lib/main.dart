import 'package:cleaner_app/helpers/custom_page_transition_builder.dart';
import 'package:cleaner_app/screens/login_screen.dart';
import 'package:cleaner_app/screens/screens.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Phoenix(child: MyApp()));
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
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) =>
              authProvider.isAuth ? HomeScreen() : LoginScreen(),
        ),
      ),
      providers: [
        ChangeNotifierProvider(create: (buildContext) => AuthProvider()),
        ChangeNotifierProvider(create: (buildContext) => DrawerStateProvider()),
        ChangeNotifierProxyProvider<AuthProvider, RoomsProvider>(
          create: (buildContext) => RoomsProvider(),
          update: (buildContext, authProvider, roomsProvider) => roomsProvider
            ..updateCleanerId(
                authProvider.cleaner != null ? authProvider.cleaner.id : null),
        ),
        ChangeNotifierProvider(create: (buildContext) => HospitalsProvider()),
      ],
    );
  }
}
