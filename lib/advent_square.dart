import 'package:advent_of_code/style_sheet.dart';
import 'package:flutter/material.dart';

class AdventSquare extends StatefulWidget {
  const AdventSquare(this.number, {super.key, this.isEnabled = true});
  final int number;
  final bool isEnabled;

  @override
  State<AdventSquare> createState() => _AdventSquare();
}

class _AdventSquare extends State<AdventSquare> {
  void clickCB(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Style.padding1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 22, 22, 22),
              offset: Offset(2, 0),
              blurRadius: 2,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Color.fromARGB(255, 47, 47, 47),
              offset: Offset(-2, -2),
              blurRadius: 1,
              spreadRadius: .2,
            )
          ],
          color: Style.scaffoldColor.withAlpha(200),
          // backgroundBlendMode: BlendMode.multiply,
        ),
        child: Center(
          child: Text(
            "${widget.number}",
            style: Theme.of(context).textTheme.headline4?.apply(
                color: widget.isEnabled
                    ? Style.linkColor
                    : Style.textDisableColor),
          ),
        ),
      ),
    );
  }
}
