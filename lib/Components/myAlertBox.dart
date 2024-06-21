import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  final String title;
  final String content;
  final String positiveText;
  final String negativeText;
  final double height;
  final Function()? onCancel;
  final Function()? onConfirm;

  const CustomAlert({
    Key? key,
    required this.title,
    required this.content,
    this.onCancel,
    this.onConfirm,
    required this.positiveText,
    required this.negativeText,
    this.height = 5.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.all(15),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24.0,
              ),
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancel ??
                      () {
                        Navigator.pop(context);
                      },
                  child: Text(
                    negativeText.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: onConfirm ?? () {},
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  child: Text(
                    positiveText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
