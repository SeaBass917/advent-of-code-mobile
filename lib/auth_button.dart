import 'package:advent_of_code/style_sheet.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(this.text, this.icon, {super.key, required this.callback});
  final String text;
  final IconData icon;
  final void Function()? callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Style.padding0),
      child: TextButton(
          onHover: (value) {},
          onPressed: callback,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "[",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.apply(color: Style.linkColor),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  icon,
                  color: Style.linkColor,
                  size: 18.0,
                ),
              ),
              Text(
                "$text]",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.apply(color: Style.linkColor),
              ),
            ],
          )),
    );
  }
}
