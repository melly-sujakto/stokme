import 'package:flutter/material.dart';
import 'package:ui_kit/theme/colors.dart';

enum CircularProgressType {
  standart,
  fullPage,
}

class CircularProgress extends StatelessWidget {
  final CircularProgressType type;
  const CircularProgress({super.key}) : type = CircularProgressType.standart;

  const CircularProgress.fullPage({super.key})
      : type = CircularProgressType.fullPage;

  @override
  Widget build(BuildContext context) {
    if (type == CircularProgressType.fullPage) {
      return Container(
        color: CustomColors.black.withOpacity(0.5),
        child: centerCircular(),
      );
    }
    return centerCircular();
  }
}

Widget centerCircular() {
  return Center(
    child: CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation(
        CustomColors.secondary.c80,
      ),
      backgroundColor: CustomColors.secondary.c50,
    ),
  );
}
