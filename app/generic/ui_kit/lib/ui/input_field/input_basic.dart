import 'package:flutter/material.dart';
import 'package:ui_kit/common/constants/layout_dimen.dart';
import 'package:ui_kit/theme/colors.dart';
import 'package:ui_kit/utils/screen_utils.dart';

class InputBasic extends StatefulWidget {
  const InputBasic({
    super.key,
    required this.labelText,
    this.controller,
    this.focusNode,
  });

  final String labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  State<InputBasic> createState() => _InputBasicState();
}

class _InputBasicState extends State<InputBasic> {
  late final TextEditingController textEditingController;
  late final FocusNode focusNode;

  @override
  void initState() {
    textEditingController = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO(Melly): improve with proper height
    return Padding(
      padding: EdgeInsets.all(LayoutDimen.dimen_16.w),
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: CustomColors.neutral.c95,
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
            borderSide: BorderSide(
              color: CustomColors.secondary.c60,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
            borderSide: BorderSide(color: CustomColors.neutral.c95),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: CustomColors.neutral.c60,
            fontSize: LayoutDimen.dimen_18.minSp,
          ),
        ),
      ),
    );
  }
}