// Automatic FlutterFlow imports
import '../../utils/theme.dart';
import '/backend/backend.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  CustomMainButton({
    Key? key,
    this.width,
    this.height,
    this.onPressed,
    this.onDisabledPressed,
    this.radios,
    this.textSize,
    this.textColor,
    this.active = true,
    this.padding,
    required this.buttonText,
  }) : super(key: key);

  double? padding;

  double? width;
  double? height;
  double? radios;
  double? textSize;

  Color? textColor;

  bool active;
  // final Future<dynamic> Function()? onPressed;
  final Function()? onPressed;
  final Function()? onDisabledPressed;

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: ElevatedButton(
        onPressed: active ? onPressed : onDisabledPressed ?? () {},
        style: ElevatedButton.styleFrom(
            // backgroundColor: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radios ?? 20))),
        child: Ink(
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(radios ?? 20)),
          child: Padding(
            padding: width == null
                ? EdgeInsets.only(left: 8.0, right: 8)
                : EdgeInsets.zero,
            child: Container(
              width: width,
              height: height,
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
                child:
                    Text(buttonText, style: AppTypography.buttonTextS(context)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
