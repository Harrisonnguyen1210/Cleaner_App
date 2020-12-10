import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/helpers/error_dialog.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:cleaner_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;

  Map<String, String> _authData = {
    'name': '',
  };

  void _loginUser(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.authenticate(_authData['name']);
    } catch (error) {
      ErrorDialog.showErrorDialog(context, error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenPadding = MediaQuery.of(context).padding;

    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Consts.primaryBlue),
                ),
              )
            : Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.25,
                      ),
                      Container(
                        height: 80.0,
                        child: Text(
                          'SPOTLESS',
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 200,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                style: TextStyle(fontSize: 20),
                                keyboardType: TextInputType.name,
                                onSaved: (name) {
                                  _authData['name'] = name;
                                },
                                validator: (name) {
                                  if (name.isEmpty) {
                                    return 'Invalid name!';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Cleaner\'s name',
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
                              SizedBox(
                                height: 48,
                              ),
                              CustomButton(
                                title: 'Login',
                                onPress: () => _loginUser(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height -
                            screenSize.height * 0.25 -
                            80 -
                            200 -
                            screenSize.height / 10 -
                            screenPadding.top -
                            screenPadding.bottom -
                            32,
                      ),
                      Container(
                        height: screenSize.height / 10,
                        child: Image(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            'assets/images/LEVITEZER_LOGO.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
