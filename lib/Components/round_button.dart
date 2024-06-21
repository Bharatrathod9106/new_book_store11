import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButtom extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const RoundButtom(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: loading
              ? CupertinoActivityIndicator(color: Colors.white,)
              : Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ),
    );
  }
}
