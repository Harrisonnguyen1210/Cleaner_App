import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/widgets.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool _checkBoxStatus = false;

  @override
  Widget build(BuildContext context) {
    final bool displayTabletLayout = MediaQuery.of(context).size.width > 500;

    return Scaffold(
      appBar: CustomAppBar.getAppBar(null),
      drawer: displayTabletLayout ? null : AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Form(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fill your report',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 48),
                      Text(
                        'Room number:',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Consts.primaryBlue,
                              width: 4.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Consts.grey4,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      Text(
                        'Room overview:',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      ReportDropDown(),
                      SizedBox(height: 48),
                      Text(
                        'Comments:',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(500),
                        ],
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: 10,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Consts.primaryBlue,
                              width: 4.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Consts.grey4,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      ButtonTheme(
                        height: 60,
                        minWidth: double.infinity,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(
                              color: Consts.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          color: Consts.primaryBlue,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 32),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 108),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          'Contamination index:',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: 100,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6),
                          ],
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Consts.primaryBlue,
                                width: 4.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Consts.grey4,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.only(left: 3),
                        child: Text(
                          'Clean successful?',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 13),
                      Transform.scale(
                        scale: 2.0,
                        child: Checkbox(
                          activeColor: Consts.primaryBlue,
                          value: _checkBoxStatus,
                          onChanged: (value) {
                            setState(() {
                              _checkBoxStatus = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
