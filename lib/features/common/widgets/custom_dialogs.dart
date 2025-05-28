import 'package:flutter/material.dart';

Future<void> showSuccessDialog(BuildContext context, String message) async {
  await showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Okay'),
            ),
          ],
        ),
  );
}

Future<void> showErrorDialog(BuildContext context, String message) async {
  await showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Okay'),
            ),
          ],
        ),
  );
}
