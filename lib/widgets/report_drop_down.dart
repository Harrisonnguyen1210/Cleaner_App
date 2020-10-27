import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class ReportDropDown extends StatefulWidget {
  @override
  _ReportDropDownState createState() => _ReportDropDownState();
}

class _ReportDropDownState extends State<ReportDropDown> {
  final List<String> overviewList = [
    'Everything is cleaned ',
    'Patialy cleaned',
    'Uncleaned due to some reason'
  ];

  String _overviewValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Consts.textGrey),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
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
        ),
      ),
    );
  }
}
