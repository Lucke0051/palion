import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palion/utilities/colors.dart';

class PalionButton extends StatelessWidget {
  final Widget? leading;
  final String label;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;
  final BorderRadius borderRadius;
  final void Function() onPressed;
  final double spaceBetween;
  final TextStyle textStyle;
  final IconThemeData iconTheme;
  final double minSize;
  final Color? color;

  const PalionButton._({
    Key? key,
    required this.label,
    this.leading,
    this.padding,
    this.alignment = Alignment.center,
    this.borderRadius = const BorderRadius.all(Radius.circular(9)),
    this.spaceBetween = 10,
    this.textStyle = const TextStyle(color: CupertinoColors.white),
    this.iconTheme = const IconThemeData(color: CupertinoColors.white),
    this.minSize = 40,
    this.color,
    required this.onPressed,
  }) : super(key: key);

  factory PalionButton.text({
    Key? key,
    required String label,
    AlignmentGeometry alignment = Alignment.center,
    required void Function() onPressed,
    Color? color,
  }) =>
      PalionButton._(
        key: key,
        alignment: alignment,
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        label: label,
        spaceBetween: 0,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: color ?? CupertinoColors.activeBlue),
        minSize: 30,
        color: Colors.transparent,
      );

  factory PalionButton.small({
    Key? key,
    Widget? leading,
    required String label,
    AlignmentGeometry alignment = Alignment.center,
    required void Function() onPressed,
    Color? color,
    Color? textColor,
  }) =>
      PalionButton._(
        key: key,
        alignment: alignment,
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(1000),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        leading: leading,
        label: label,
        spaceBetween: 5,
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor ?? CupertinoColors.white),
        iconTheme: const IconThemeData(color: CupertinoColors.white, size: 22),
        minSize: 30,
        color: color,
      );

  factory PalionButton.medium({
    Key? key,
    Widget? leading,
    required String label,
    AlignmentGeometry alignment = Alignment.center,
    required void Function() onPressed,
    Color? color,
    Color? textColor,
  }) =>
      PalionButton._(
        key: key,
        alignment: alignment,
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(1000),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        leading: leading,
        label: label,
        spaceBetween: 5,
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor ?? CupertinoColors.white),
        iconTheme: const IconThemeData(color: CupertinoColors.white, size: 22),
        minSize: 35,
        color: color,
      );

  factory PalionButton.large({
    Key? key,
    Widget? leading,
    required String label,
    AlignmentGeometry alignment = Alignment.center,
    required void Function() onPressed,
    Color? color,
    Color? textColor,
  }) =>
      PalionButton._(
        key: key,
        alignment: alignment,
        onPressed: onPressed,
        borderRadius: BorderRadius.circular(9),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        leading: leading,
        label: label,
        spaceBetween: 5,
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor ?? CupertinoColors.white),
        iconTheme: const IconThemeData(color: CupertinoColors.white, size: 24),
        minSize: 45,
        color: color,
      );

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: color ?? PalionTheme.of(context).active,
      minSize: minSize,
      padding: padding,
      alignment: alignment,
      onPressed: onPressed,
      borderRadius: borderRadius,
      child: leading != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconTheme(
                  data: iconTheme,
                  child: leading!,
                ),
                SizedBox(
                  width: spaceBetween,
                ),
                Text(
                  label,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          : Text(label, style: textStyle, textAlign: TextAlign.center),
    );
  }
}
