import 'package:flutter/material.dart';

class ModalComponents extends StatelessWidget {
  const ModalComponents(
      {super.key, required this.icon, this.body, this.action});

  final Widget icon;
  final Widget? body;
  final Widget? action;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: icon,
            ),
            const SizedBox(
              height: 16,
            ),
            body ?? const SizedBox(),
            action ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
