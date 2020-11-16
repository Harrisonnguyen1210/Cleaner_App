import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/helpers/error_dialog.dart';
import 'package:cleaner_app/route_names.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomTable extends StatefulWidget {
  @override
  _RoomTableState createState() => _RoomTableState();
}

class _RoomTableState extends State<RoomTable> {
  List<bool> selected;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    final roomsProvider = Provider.of<RoomsProvider>(context, listen: false);
    roomsProvider.resetFilter();
    roomsProvider.fetchAssignedRooms().then((roomList) {
      selected = List<bool>.generate(
        roomList.length,
        (index) => false,
      );
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      ErrorDialog.showErrorDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final roomsProvider = Provider.of<RoomsProvider>(context);
    final assignedRooms = roomsProvider.rooms;

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Consts.primaryBlue),
            ),
          )
        : Container(
            width: double.infinity,
            height: screenSize.height / 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                headingTextStyle: TextStyle(
                  color: Consts.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
                dataRowHeight: 60,
                showCheckboxColumn: false,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('Room name'),
                  ),
                  DataColumn(
                    label: Text('Last clean'),
                  ),
                  DataColumn(
                    label: Text('Status'),
                  ),
                  DataColumn(label: SizedBox.shrink()),
                ],
                rows: List<DataRow>.generate(
                  assignedRooms.length,
                  (index) => DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      // All rows will have the same selected color.
                      if (states.contains(MaterialState.selected))
                        return Consts.primaryBlue;
                      // Even rows will have a grey color.
                      if (index % 2 == 0) return Consts.grey6;
                      // Use default value for other states and odd rows.
                      return null;
                    }),
                    cells: [
                      DataCell(Text(assignedRooms[index].name)),
                      DataCell(
                        Text(assignedRooms[index].lastCleaned ??
                            '2020-10-21 14:02:13'),
                      ),
                      DataCell(
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: assignedRooms[index].contaminationColor),
                        ),
                      ),
                      DataCell(
                        selected[index]
                            ? RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                elevation: 0,
                                child: Text(
                                  'Details',
                                  style: TextStyle(color: Consts.primaryBlue),
                                ),
                                color: Consts.white,
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      RouteNames.cleaning,
                                      arguments: assignedRooms[index]);
                                })
                            : SizedBox(width: 88.0),
                      )
                    ],
                    selected: selected[index],
                    onSelectChanged: (bool value) {
                      setState(() {
                        selected = List<bool>.generate(
                            assignedRooms.length, (index) => false);
                        selected[index] = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          );
  }
}
