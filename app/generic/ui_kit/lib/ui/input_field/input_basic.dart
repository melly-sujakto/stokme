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
    this.obscureText = false,
    this.useSearchIcon = false,
    this.onChanged,
    this.margin,
  });

  final String labelText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool useSearchIcon;
  final void Function(String)? onChanged;

  /// if [margin] is null, default value is
  /// EdgeInsets.symmetric(horizontal: LayoutDimen.dimen_16.w)
  final EdgeInsets? margin;

  @override
  State<InputBasic> createState() => _InputBasicState();
}

class _InputBasicState extends State<InputBasic> {
  late final TextEditingController textEditingController;
  late final FocusNode focusNode;
  late bool visibilityText;

  @override
  void initState() {
    textEditingController = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    visibilityText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.margin ??
          EdgeInsets.symmetric(
            horizontal: LayoutDimen.dimen_16.w,
          ),
      height: LayoutDimen.dimen_56.h,
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        obscureText: visibilityText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: LayoutDimen.dimen_10.w,
            vertical: LayoutDimen.dimen_5.h,
          ),
          filled: true,
          fillColor: CustomColors.neutral.c95,
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
            borderSide: BorderSide(
              color: CustomColors.secondary.c50,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(LayoutDimen.dimen_10.w),
            borderSide: BorderSide(color: CustomColors.neutral.c95),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: CustomColors.neutral.c60,
            fontSize: focusNode.hasFocus
                ? LayoutDimen.dimen_14.minSp
                : LayoutDimen.dimen_18.minSp,
          ),
          prefixIcon: widget.useSearchIcon
              ? Image.asset(
                  'assets/icons/search_icon.png',
                  width: LayoutDimen.dimen_24.w,
                  fit: BoxFit.fitWidth,
                )
              : null,
          suffixIcon: widget.obscureText
              ? InkWell(
                  onTap: () {
                    setState(() {
                      visibilityText = !visibilityText;
                    });
                  },
                  child: Icon(
                    visibilityText ? Icons.visibility_off : Icons.visibility,
                    color: CustomColors.neutral.c60,
                  ),
                )
              : null,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
