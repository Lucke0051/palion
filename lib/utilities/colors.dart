import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PalionTheme extends InheritedWidget {
  final Color tile;
  final Color selectedTile;
  final Color tileContent;
  final Color selectedTileContent;
  final Color tileContentInactive;
  final Color sidebarBackground;
  final Color sidebarBorderColor;
  final Color canvas;
  final Color itemCategoryItemBorder;
  final Color primaryColor;
  final Color active;
  final Color tapOverlay;
  final Color cardBackground;
  final Color cardContent;

  const PalionTheme({
    required final this.tile,
    required final this.selectedTile,
    required final this.tileContent,
    required final this.selectedTileContent,
    required final this.tileContentInactive,
    required final this.sidebarBackground,
    required final this.sidebarBorderColor,
    required final this.canvas,
    required final this.itemCategoryItemBorder,
    required final this.primaryColor,
    required final this.active,
    required final this.tapOverlay,
    required final this.cardBackground,
    required final this.cardContent,
    final Key? key,
    required final Widget child,
  }) : super(child: child, key: key);

  PalionTheme copyWith({
    final Color? tile,
    final Color? selectedTile,
    final Color? tileContent,
    final Color? selectedTileContent,
    final Color? tileContentInactive,
    final Color? sidebarBackground,
    final Color? sidebarBorderColor,
    final Color? canvas,
    final Color? itemCategoryItemBorder,
    final Color? primaryColor,
    final Color? active,
    final Color? tapOverlay,
    final Color? cardBackground,
    final Color? cardContent,
    final Key? key,
  }) =>
      PalionTheme(
        tile: tile ?? this.tile,
        selectedTile: selectedTile ?? this.selectedTile,
        tileContent: tileContent ?? this.tileContent,
        selectedTileContent: selectedTileContent ?? this.selectedTileContent,
        tileContentInactive: tileContentInactive ?? this.tileContentInactive,
        sidebarBackground: sidebarBackground ?? this.sidebarBackground,
        sidebarBorderColor: sidebarBorderColor ?? this.sidebarBorderColor,
        canvas: canvas ?? this.canvas,
        itemCategoryItemBorder: itemCategoryItemBorder ?? this.itemCategoryItemBorder,
        primaryColor: primaryColor ?? this.primaryColor,
        active: active ?? this.active,
        tapOverlay: tapOverlay ?? this.tapOverlay,
        cardBackground: cardBackground ?? this.cardBackground,
        cardContent: cardContent ?? this.cardContent,
        child: child,
      );

  factory PalionTheme.light({required final Widget child}) => PalionTheme(
        tile: Colors.transparent,
        selectedTile: CupertinoColors.activeBlue,
        tileContent: CupertinoColors.label,
        selectedTileContent: CupertinoColors.white,
        tileContentInactive: CupertinoColors.inactiveGray,
        sidebarBackground: CupertinoColors.secondarySystemBackground,
        sidebarBorderColor: CupertinoColors.systemGrey5,
        canvas: CupertinoColors.systemBackground,
        itemCategoryItemBorder: CupertinoColors.systemGrey4,
        primaryColor: Colors.blue,
        active: CupertinoColors.activeBlue,
        tapOverlay: Colors.white24,
        cardBackground: CupertinoColors.secondarySystemBackground,
        cardContent: CupertinoColors.label,
        child: child,
      );

  @override
  bool updateShouldNotify(PalionTheme oldWidget) => true;

  static PalionTheme of(BuildContext context) {
    final PalionTheme? inherited = context.dependOnInheritedWidgetOfExactType<PalionTheme>();
    if (inherited != null) return inherited;
    throw Exception("No PalionTheme was found in tree.");
  }
}
