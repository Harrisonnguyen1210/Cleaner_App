import 'dart:typed_data';

import 'package:cleaner_app/consts.dart';
import 'package:flutter/material.dart';

class ContaminationMap extends StatelessWidget {
  final Uint8List imageData;
  final Uint8List imageCleaningData;
  final Uint8List floorImage;

  const ContaminationMap(
      {Key key, this.imageData, this.imageCleaningData, this.floorImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
        color: Consts.activityBackground,
      ),
      height: screenSize.height * 0.4,
      width: double.infinity,
      child: imageData != null
          ? Stack(
              fit: StackFit.expand,
              children: [
                Image.memory(
                  imageData,
                  fit: BoxFit.contain,
                  gaplessPlayback: true,
                ),
                imageCleaningData != null
                    ? ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.greenAccent,
                          BlendMode.modulate,
                        ),
                        child: Image.memory(
                          imageCleaningData,
                          fit: BoxFit.contain,
                          gaplessPlayback: true,
                        ))
                    : SizedBox.shrink(),
                floorImage != null
                    ? Image.memory(
                        floorImage,
                        fit: BoxFit.contain,
                        gaplessPlayback: true,
                      )
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/no_heatmap_placeholder.jpg',
                      ),
                    ),
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
    );
  }
}
