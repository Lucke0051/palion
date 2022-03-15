import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PalionDialogType {
  popup,
  fullscreen,
}

class PalionDialog<T> extends StatelessWidget {
  const PalionDialog({
    required this.dialogType,
    required this.actions,
    this.content,
    required this.title,
    this.scrollable = false,
    this.leading,
    this.trailing,
    Key? key,
  }) : super(key: key);
  final PalionDialogType dialogType;
  final List<Widget> actions;
  final String title;
  final Widget? content;
  final bool scrollable;
  final List<Widget>? leading;
  final List<Widget>? trailing;

  Widget buildFullscreen(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverNavigationBar(
          largeTitle: Text(title),
        ),
      ],
    );
  }

  Widget buildPopup(BuildContext context) {
    return AlertDialog(
      actions: actions,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title),
            ],
          ),
          if (trailing != null) Row(
            mainAxisSize: MainAxisSize.min,
            children: trailing!,
          ),
        ],
      ),
      content: content,
      insetPadding: const EdgeInsets.only(top: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (dialogType) {
      case PalionDialogType.popup:
        return buildPopup(context);
      case PalionDialogType.fullscreen:
        return buildFullscreen(context);
    }
  }

  factory PalionDialog.auto(
    BuildContext context, {
    required List<Widget> actions,
    Widget? content,
    required String title,
    bool scrollable = false,
    List<Widget>? leading,
    List<Widget>? trailing,
  }) {
    final Size screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 600) {
      return PalionDialog(
        dialogType: PalionDialogType.popup,
        actions: actions,
        content: content,
        title: title,
        scrollable: scrollable,
        leading: leading,
        trailing: trailing,
      );
    } else {
      return PalionDialog(
        dialogType: PalionDialogType.fullscreen,
        actions: actions,
        content: content,
        title: title,
        scrollable: scrollable,
        leading: leading,
        trailing: trailing,
      );
    }
  }

  Future<T?> show(BuildContext context) async {
    switch (dialogType) {
      case PalionDialogType.popup:
        return showDialog<T>(context: context, builder: (BuildContext context) => build(context));
      case PalionDialogType.fullscreen:
        return Navigator.push<T>(context, MaterialPageRoute(builder: (BuildContext context) => build(context)));
    }
  }
}
