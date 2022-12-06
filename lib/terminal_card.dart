import 'package:advent_of_code/advent_page.dart';
import 'package:advent_of_code/network.dart';
import 'package:advent_of_code/style_sheet.dart';
import 'package:flutter/material.dart';

class TerminalCard extends StatefulWidget {
  const TerminalCard({super.key, required this.year, this.offset = 0.0});
  final String year;
  final double offset;

  @override
  State<TerminalCard> createState() => _TerminalCard();
}

class _TerminalCard extends State<TerminalCard> {
  String displayTitle = "unk";

  @override
  void initState() {
    super.initState();
    displayTitle = "Advent of Code \n${widget.year}";
  }

  void clickCB(BuildContext context) {
    // var t = getAdventPage(2022, day: 1);
    // print(t);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdventPage(year: widget.year)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Style.padding0 / 2,
        Style.padding0 * 2,
        Style.padding0 / 2,
        0,
      ),
      child: ElevatedButton(
        onPressed: () {
          clickCB(context);
        },
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
            color: Style.scaffoldColor,
            backgroundBlendMode: BlendMode.multiply,
          ),
          height: 130,
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(Style.padding0),
            child: Text(
              displayTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.apply(color: Style.linkColor),
            ),
          ),
        ),
      ),
    );
  }
}
