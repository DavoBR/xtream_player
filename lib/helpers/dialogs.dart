import 'package:flutter/material.dart';

Future<void> alert({
  required BuildContext context,
  required String title,
  Widget content = const SizedBox.shrink(),
  String textConfirm = 'Aceptar',
}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(textConfirm),
        )
      ],
    ),
  );
}

Future<bool> confirm({
  required BuildContext context,
  required String title,
  Widget? content,
  String textConfirm = 'Si',
  String textCancel = 'No',
  void Function()? onConfirm,
  void Function()? onCancel,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
            if (onConfirm != null) onConfirm();
          },
          child: Text(textConfirm),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
            if (onCancel != null) onCancel();
          },
          child: Text(textCancel),
        )
      ],
    ),
  );

  return result ?? false;
}