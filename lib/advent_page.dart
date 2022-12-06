import 'package:advent_of_code/advent_square.dart';
import 'package:advent_of_code/style_sheet.dart';
import 'package:flutter/material.dart';

class AdventPage extends StatefulWidget {
  const AdventPage({super.key, required this.year});
  final String year;

  @override
  State<AdventPage> createState() => _AdventPage();
}

class _AdventPage extends State<AdventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Advent Of Code ${widget.year}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Style.padding0),
        child: Expanded(
          child: GridView.count(
            mainAxisSpacing: Style.padding0,
            crossAxisCount: 5,
            childAspectRatio: 1,
            children: <Widget>[for (var i = 1; i <= 25; i++) AdventSquare(i)],
          ),
        ),
      ),
    );
  }
}
