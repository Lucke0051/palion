import 'package:flutter/material.dart';
import 'package:palion/widgets/list/abstract_section.dart';

class CustomSection extends AbstractSection {
  final Widget child;

  CustomSection({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
