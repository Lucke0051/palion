import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PalionColors {
  final Color tile;
  final Color selectedTile;
  final Color tileContent;
  final Color selectedTileContent;
  final Color tileContentInactive;
  final Color sidebarBackground;
  final Color sidebarBorderColor;
  final Color canvas;
  final Color itemCategoryItemBorder;

  PalionColors._({
    required this.tile,
    required this.selectedTile,
    required this.tileContent,
    required this.selectedTileContent,
    required this.tileContentInactive,
    required this.sidebarBackground,
    required this.sidebarBorderColor,
    required this.canvas,
    required this.itemCategoryItemBorder,
  });

  factory PalionColors.from(final BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light) {
      return PalionColors.light(context);
    } else {
      return PalionColors.dark(context);
    }
  }

  factory PalionColors.light(final BuildContext context) => PalionColors._(
        tile: Colors.transparent,
        selectedTile: CupertinoColors.activeBlue,
        tileContent: CupertinoColors.label,
        selectedTileContent: CupertinoColors.white,
        tileContentInactive: CupertinoColors.inactiveGray,
        sidebarBackground: CupertinoColors.secondarySystemBackground,
        sidebarBorderColor: CupertinoColors.systemGrey5,
        canvas: CupertinoColors.systemBackground,
        itemCategoryItemBorder: CupertinoColors.systemGrey4,
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
