import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/helpers/custom_dialog.dart';
import 'package:cleaner_app/helpers/error_dialog.dart';
import 'package:cleaner_app/models/models.dart';
import 'package:cleaner_app/route_names.dart';
import 'package:cleaner_app/services/providers/auth_provider.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _form = GlobalKey<FormState>();
  var _checkBoxStatus = false;
  final List<String> overviewList = [
    'Everything is cleaned ',
    'Patialy cleaned',
    'Uncleaned due to some reason'
  ];
  String _overviewValue;
  var _isLoading = false;
  var _report = Report(
    roomId: '',
    cleanerId: '',
    overview: '',
    comments: '',
    cleanSuccessful: false,
  );

  void _navigateToOverviewScreen(BuildContext context) {
    final drawerStateProvider =
        Provider.of<DrawerStateProvider>(context, listen: false);
    drawerStateProvider.setCurrentDrawer(0);
    Consts.navigatorKey.currentState
        .pushNamedAndRemoveUntil(RouteNames.overview, (_) => false);
  }

  void _submitReport() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    setState(() {
      _isLoading = true;
    });
    _form.currentState.save();
    _report = Report(
      roomId: _report.roomId,
      cleanerId: authProvider.cleaner.id,
      comments: _report.comments,
      overview: _report.overview,
      cleanSuccessful: _checkBoxStatus,
    );
    try {
      await ReportProvider().submitCleaningReport(_report).then((_) {
        setState(() {
          _isLoading = false;
        });
        CustomDialog.showCustomDialog(context, 'Report submited',
            () => _navigateToOverviewScreen(context));
      });
    } catch (error) {
      ErrorDialog.showErrorDialog(context, error.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool displayTabletLayout = MediaQuery.of(context).size.width > 500;
    final Room currentRoom = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: CustomAppBar.getAppBar(null),
      drawer: displayTabletLayout ? null : AppDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Form(
            key: _form,
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
                        initialValue:
                            currentRoom != null ? currentRoom.name : null,
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
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Please provide room number';
                          return null;
                        },
                        onSaved: (value) {
                          _report = Report(
                            roomId: currentRoom != null
                                ? currentRoom.id
                                : _report.roomId,
                            cleanerId: _report.cleanerId,
                            comments: _report.comments,
                            overview: _report.overview,
                            cleanSuccessful: _report.cleanSuccessful,
                          );
                        },
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
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Consts.grey4,
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null) return 'Please select an overview';
                          return null;
                        },
                        hint: Text('Select overview'),
                        value: _overviewValue,
                        items: overviewList
                            .map((overview) => DropdownMenuItem(
                                  value: overview,
                                  child: Text(overview),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _overviewValue = value;
                          });
                        },
                        onSaved: (value) {
                          _report = Report(
                            roomId: _report.roomId,
                            cleanerId: _report.cleanerId,
                            comments: _report.comments,
                            overview: value,
                            cleanSuccessful: _report.cleanSuccessful,
                          );
                        },
                      ),
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
                        onSaved: (value) {
                          _report = Report(
                            roomId: _report.roomId,
                            cleanerId: _report.cleanerId,
                            comments: value,
                            overview: _report.overview,
                            cleanSuccessful: _report.cleanSuccessful,
                          );
                        },
                      ),
                      SizedBox(height: 48),
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Consts.primaryBlue),
                              ),
                            )
                          : ButtonTheme(
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
                                onPressed: _submitReport,
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
