import 'package:flutter/material.dart';
import 'package:ui_kit/theme/colors.dart';

enum CircularProgressType {
  standart,
  fullPage,
}

class LoadingCircular extends StatelessWidget {
  final CircularProgressType type;
  const LoadingCircular({super.key}) : type = CircularProgressType.standart;

  const LoadingCircular.fullPage({super.key})
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
