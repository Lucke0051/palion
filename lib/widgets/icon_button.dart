import 'package:flutter/cupertino.dart';
import 'package:palion/palion.dart';

class PalionIconButton extends StatefulWidget {
  final Widget icon;
  final Color? color;
  final double size;
  final void Function()? onTap;

  const PalionIconButton({
    Key? key,
    required this.icon,
    this.color,
    this.size = 24,
    this.onTap,
  }) : super(key: key);

  @override
  PalionIconButtonState createState() => PalionIconButtonState();
}

class PalionIconButtonState extends State<PalionIconButton> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _tapped = true),
      onTapUp: (_) => setState(() => _tapped = false),
      onTapCancel: () => setState(() => _tapped = false),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: IconTheme(
          data: IconThemeData(
            color: _tapped
                ? Color.alphaBlend(PalionTheme.of(context).tapOverlay, widget.color ?? PalionTheme.of(context).active)
                : (widget.color ?? PalionTheme.of(context).active),
            size: widget.size,
          ),
          child: widget.icon,
        ),
      ),
    );
  }
}
