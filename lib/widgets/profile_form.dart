import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/services/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _phoneTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _emailTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneTextController.text = '0123456789';
    _addressTextController.text = '1874  Ferrell Street, Finland';
    _emailTextController.text = 'abc@gmail.com';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (buildContext, authProvider, child) => Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              authProvider.cleaner.name,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Cleaner at Helsinki Hospital',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Consts.textGrey,
              ),
            ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Phone number:',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.number,
                    controller: _phoneTextController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Consts.primaryBlue,
                          width: 4.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Consts.grey4,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Email:',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTextController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Consts.primaryBlue,
                          width: 4.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Consts.grey4,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Address:',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    style: TextStyle(fontSize: 20),
                    keyboardType: TextInputType.streetAddress,
                    controller: _addressTextController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Consts.primaryBlue,
                          width: 4.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Consts.grey4,
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
