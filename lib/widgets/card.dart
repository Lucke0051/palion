import 'package:flutter/cupertino.dart';

class PalionCard extends StatelessWidget {
  const PalionCard({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: CupertinoColors.lightBackgroundGray,
        boxShadow: const [
          BoxShadow(
            color: CupertinoColors.tertiarySystemFill,
            spreadRadius: 5,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  factory PalionCard.icon(final Widget prefix, final String label) {
    return PalionCard(
      child: SizedBox(
        height: 30,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: IconTheme(
                data: const IconThemeData(
                  size: 24,
                  color: CupertinoColors.secondaryLabel,
                ),
                child: prefix,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: CupertinoColors.secondaryLabel),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
