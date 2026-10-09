import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      // DD-12 default: safe areas wrap the content, not the page background.
      child: FocusTraversalGroup(child: child),
    ),
  );
}
