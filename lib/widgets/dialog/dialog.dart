import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palion/palion.dart';
import 'package:palion/widgets/icon_button.dart';

enum PalionDialogType {
  popup,
  fullscreen,
}

class PalionDialog<T> extends StatelessWidget {
  const PalionDialog({
    required this.dialogType,
    this.actions,
    this.content,
    required this.title,
    this.leading,
    this.trailing,
    this.autoCloseButton,
    this.barrierDismissable = true,
    Key? key,
  }) : super(key: key);
  final PalionDialogType dialogType;
  final List<Widget>? actions;
  final String title;
  final Widget? content;
  final List<Widget>? leading;
  final Widget? trailing;
  final String? autoCloseButton;
  final bool barrierDismissable;

  Widget buildFullscreen(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(title),
            trailing: trailing,
            padding: autoCloseButton != null ? const EdgeInsetsDirectional.only(end: 16) : null,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (autoCloseButton != null)
                  PalionIconButton(
                    icon: const Icon(CupertinoIcons.chevron_back),
                    onTap: () => Navigator.pop(context),
                    size: 30,
                  ),
                if (leading != null) ...leading!,
              ],
            ),
          ),
          if (content != null)
            SliverToBoxAdapter(
              child: content,
            ),
        ],
      ),
      bottomNavigationBar: actions != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              ),
            )
          : null,
    );
  }

  Widget buildPopup(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actions: autoCloseButton != null
          ? [
              if (actions != null) ...actions!,
              PalionButton.large(label: autoCloseButton!, onPressed: () => Navigator.pop(context)),
            ]
          : actions,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title),
              if (leading != null) ...leading!,
            ],
          ),
          if (trailing != null) trailing!,
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
    List<Widget>? actions,
    Widget? content,
    required String title,
    List<Widget>? leading,
    Widget? trailing,
    String? autoCloseButton,
    bool barrierDismissable = true,
  }) {
    final Size screenSize = MediaQuery.of(context).size;
    if (screenSize.width > 500) {
      return PalionDialog(
        dialogType: PalionDialogType.popup,
        actions: actions,
        content: content,
        title: title,
        leading: leading,
        trailing: trailing,
        autoCloseButton: autoCloseButton,
        barrierDismissable: barrierDismissable,
      );
    } else {
      return PalionDialog(
        dialogType: PalionDialogType.fullscreen,
        actions: actions,
        content: content,
        title: title,
        leading: leading,
        trailing: trailing,
        autoCloseButton: autoCloseButton,
        barrierDismissable: barrierDismissable,
      );
    }
  }

  Future<T?> show(BuildContext context) async {
    switch (dialogType) {
      case PalionDialogType.popup:
        return showDialog<T>(context: context, builder: (BuildContext context) => build(context), barrierDismissible: barrierDismissable);
      case PalionDialogType.fullscreen:
        return Navigator.push<T>(context, MaterialPageRoute(builder: (BuildContext context) => build(context)));
    }
  }
}
