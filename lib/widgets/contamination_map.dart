import 'package:cleaner_app/services/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContaminationMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final singleRoomProvider =
        Provider.of<SingleRoomProvider>(context, listen: false);
    final screenSize = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: screenSize.height * 0.4,
        width: double.infinity,
        child: Image.memory(singleRoomProvider.imageData, fit: BoxFit.cover),
      ),
    );
  }
}
