import 'dart:typed_data';

import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class ContaminationMap extends StatelessWidget {
  final Uint8List imageData;
  final Uint8List imageCleaningData;

  const ContaminationMap({Key key, this.imageData, this.imageCleaningData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: screenSize.height * 0.4,
        width: double.infinity,
        child: imageData != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.memory(imageData, fit: BoxFit.contain, gaplessPlayback: true),
                  imageCleaningData != null
                      ? ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.greenAccent,
                            BlendMode.modulate,
                          ),
                          child: Image.memory(imageCleaningData,
                              fit: BoxFit.contain))
                      : SizedBox.shrink(),
                ],
              )
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
