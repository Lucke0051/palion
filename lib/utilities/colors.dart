import 'package:flutter/material.dart';

class PalionColors {
  final Color grayIcon;
  final Color itemPressed;
  final Color border;
  final Color background;
  final Color groupSubtitle;
  final Color tile;
  final Color pressedTile;

  PalionColors._({
    required this.grayIcon,
    required this.itemPressed,
    required this.border,
    required this.background,
    required this.groupSubtitle,
    required this.tile,
    required this.pressedTile,
  });

  factory PalionColors.from(final BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return PalionColors.light(context);
    } else {
      return PalionColors.dark(context);
    }
  }

  factory PalionColors.light(final BuildContext context) => PalionColors._(
        grayIcon: const Color(0xFFC7C7CC),
        itemPressed: const Color(0xFFD9D9D9),
        border: const Color.fromRGBO(49, 44, 51, 1),
        background: const Color(0xFFEFEFF4),
        groupSubtitle: const Color(0xFF777777),
        tile: const Color.fromRGBO(28, 28, 30, 1),
        pressedTile: const Color.fromRGBO(230, 229, 235, 1),
      );

  factory PalionColors.dark(final BuildContext context) => throw UnimplementedError();
}

/*
import 'dart:ui';

const Color mediumGrayColor = Color(0xFFC7C7CC);
const Color itemPressedColor = Color(0xFFD9D9D9);
const Color borderColor = Color(0xFFBCBBC1);
const Color borderLightColor = Color.fromRGBO(49, 44, 51, 1);
const Color backgroundGray = Color(0xFFEFEFF4);
const Color groupSubtitle = Color(0xFF777777);
const Color iosTileDarkColor = Color.fromRGBO(28, 28, 30, 1);
const Color iosPressedTileColorDark = Color.fromRGBO(44, 44, 46, 1);
const Color iosPressedTileColorLight = Color.fromRGBO(230, 229, 235, 1);
*/
