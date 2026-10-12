import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.child, this.backgroundColor, super.key});
  final Widget child;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: backgroundColor,
    body: SafeArea(
      // DD-12 default: safe areas wrap the content, not the page background.
      child: FocusTraversalGroup(child: child),
    ),
  );
}
