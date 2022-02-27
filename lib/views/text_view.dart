import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  final String _message;

  TextView(this._message);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Text(
        _message,
        key: ValueKey<String>(_message),
        style: const TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
