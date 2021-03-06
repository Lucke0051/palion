import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palion/palion.dart';

enum PalionDialogType {
  popup,
  fullscreen,
}

class PalionDialog extends StatelessWidget {
  const PalionDialog({
    this.actions,
    this.content,
    required this.title,
    this.leading,
    this.trailing,
    this.autoCloseButton,
    this.backButtonOnFull = false,
    this.insetPadding = const EdgeInsets.only(top: 5),
    Key? key,
  }) : super(key: key);
  final List<Widget>? actions;
  final String title;
  final Widget? content;
  final List<Widget>? leading;
  final Widget? trailing;
  final String? autoCloseButton;
  final EdgeInsets insetPadding;
  final bool backButtonOnFull;

  Widget buildFullscreen(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(title),
            trailing: trailing != null ? trailing! : null,
            padding: autoCloseButton != null || backButtonOnFull ? const EdgeInsetsDirectional.only(end: 16) : null,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (autoCloseButton != null || backButtonOnFull)
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
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: actions != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    for (Widget action in actions!)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: action,
                      ),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget buildPopup(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      insetPadding: insetPadding,
      contentPadding: EdgeInsets.zero,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final PalionDialogTypeProvider? typeProvider = PalionDialogTypeProvider.maybeOf(context);
    switch (typeProvider != null ? typeProvider.dialogType : PalionDialogType.popup) {
      case PalionDialogType.popup:
        return buildPopup(context);
      case PalionDialogType.fullscreen:
        return buildFullscreen(context);
    }
  }

  static Future<T?> show<T>(BuildContext context, {required Widget dialog, PalionDialogType? dialogType, bool barrierDismissible = true}) {
    dialogType ??= MediaQuery.of(context).size.width > 500 ? PalionDialogType.popup : PalionDialogType.fullscreen;
    switch (dialogType) {
      case PalionDialogType.popup:
        return showDialog<T>(
          context: context,
          builder: (BuildContext context) => PalionDialogTypeProvider(dialogType: dialogType!, child: dialog),
          barrierDismissible: barrierDismissible,
        );
      case PalionDialogType.fullscreen:
        return Navigator.push<T>(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => PalionDialogTypeProvider(dialogType: dialogType!, child: dialog),
          ),
        );
    }
  }
}

class PalionDialogTypeProvider extends InheritedWidget {
  const PalionDialogTypeProvider({Key? key, required this.dialogType, required Widget child}) : super(key: key, child: child);
  final PalionDialogType dialogType;

  @override
  bool updateShouldNotify(PalionDialogTypeProvider oldWidget) => false;

  static PalionDialogTypeProvider of(BuildContext context) {
    final PalionDialogTypeProvider? inherited = context.dependOnInheritedWidgetOfExactType<PalionDialogTypeProvider>();
    if (inherited != null) return inherited;
    throw Exception("No PalionDialogTypeProvider was found in tree.");
  }

  static PalionDialogTypeProvider? maybeOf(BuildContext context) {
    final PalionDialogTypeProvider? inherited = context.dependOnInheritedWidgetOfExactType<PalionDialogTypeProvider>();
    return inherited;
  }
}
