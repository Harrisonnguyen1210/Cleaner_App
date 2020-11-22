import 'package:cleaner_app/consts.dart';
import 'package:cleaner_app/services/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContaminationMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final singleRoomProvider =
        Provider.of<SingleRoomProvider>(context, listen: false);
    final imageData = singleRoomProvider.imageData;
    final screenSize = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: screenSize.height * 0.4,
        width: double.infinity,
        child: imageData != null
            ? Image.memory(imageData, fit: BoxFit.contain)
            : Stack(
              fit: StackFit.expand,
                alignment: Alignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Consts.grey4,
                      BlendMode.modulate,
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/no_heatmap_placeholder.jpg'),
                    ),
                  ),
                  Positioned(
                    bottom: 48,
                    child: Text(
                      'No contamination map available',
                      style: TextStyle(
                        fontSize: 30,
                        color: Consts.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
