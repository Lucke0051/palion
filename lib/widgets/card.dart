import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palion/palion.dart';

class PalionCard extends StatelessWidget {
  const PalionCard({required this.builder, Key? key}) : super(key: key);
  final Widget Function(BuildContext) builder;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PalionTheme.of(context).cardBackground,
      borderRadius: BorderRadius.circular(9),
      elevation: 1,
      shadowColor: CupertinoColors.systemGrey6,
      child: builder(context),
    );
  }

  factory PalionCard.icon(final Widget prefix, final String label) {
    return PalionCard(
      builder: (BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconTheme(
              data: IconThemeData(
                size: 26,
                color: PalionTheme.of(context).cardContent,
              ),
              child: prefix,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: PalionTheme.of(context).cardContent, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
