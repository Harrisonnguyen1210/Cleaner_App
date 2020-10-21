import 'package:flutter/material.dart';

import '../models/models.dart';

class SelectDropDownRow extends StatefulWidget {
  @override
  _SelectDropDownRowState createState() => _SelectDropDownRowState();
}

class _SelectDropDownRowState extends State<SelectDropDownRow> {
  final List<Hospital> hospitalList = [
    Hospital(name: 'Helsinki Hospital'),
    Hospital(name: 'Espoo hospital'),
    Hospital(name: 'Vantaa hospital'),
  ];

  final List<String> floorList = ['1', '2', '3'];

  final List<String> buildingList = ['1', '2', '3'];

  Map<String, dynamic> filterOptions = {
    'hospital': null,
    'building': null,
    'floor': null
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 50,
          width: 250,
          padding: EdgeInsets.all(8),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('Select hospital'),
              value: filterOptions['hospital'],
              items: hospitalList
                  .map((hospital) => DropdownMenuItem(
                        value: hospital.name,
                        child: Text(hospital.name),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  filterOptions['hospital'] = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 100),
        Container(
          height: 50,
          width: 250,
          padding: EdgeInsets.all(8),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('Select building'),
              value: filterOptions['building'],
              items: buildingList
                  .map((building) => DropdownMenuItem(
                        value: building,
                        child: Text('Building ' + building),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  filterOptions['building'] = value;
                });
              },
            ),
          ),
        ),
        SizedBox(width: 100),
        Container(
          height: 50,
          width: 250,
          padding: EdgeInsets.all(8),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.0, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('Select floor'),
              value: filterOptions['floor'],
              items: floorList
                  .map((floor) => DropdownMenuItem(
                        value: floor,
                        child: Text('Floor ' + floor),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  filterOptions['floor'] = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
