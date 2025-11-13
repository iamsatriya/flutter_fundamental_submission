import 'package:flutter/material.dart';

enum AppButtonType { primary, secondary }

class AppButton extends StatelessWidget {
  final Widget child;
  final void Function() onPressed;
  final AppButtonType? type;

  const AppButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.type = AppButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    Color foregroundColor = type == AppButtonType.primary
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onTertiary;

    Color backgroundColor = type == AppButtonType.primary
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.tertiary;

    return FilledButton(
      onPressed: onPressed,
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(foregroundColor),
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
      ),
      child: child,
    );
  }
}
