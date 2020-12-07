import 'package:cleaner_app/helpers/custom_dialog.dart';
import 'package:cleaner_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class LogoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar.getAppBar(null, context),
        body: Stack(
          children: [
            Align(
              child: CustomButton(
                title: 'Logout',
                onPress: () {
                  CustomDialog.showCustomDialog(
                    context,
                    'Do you want to logout?',
                    () => Phoenix.rebirth(context),
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height / 7,
                padding: EdgeInsets.only(bottom: 32.0),
                child: Image(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/LEVITEZER_LOGO.png',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
