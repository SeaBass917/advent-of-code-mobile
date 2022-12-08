import 'package:advent_of_code/login_page.dart';
import 'package:advent_of_code/style_sheet.dart';
import 'package:advent_of_code/terminal_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advent Of Code',
      theme: ThemeData(
        primarySwatch: Style.actionColor,
        fontFamily: "SourceCodePro",
        scaffoldBackgroundColor: Style.scaffoldColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Style.navColor,
          titleTextStyle: TextStyle(
            color: Style.textBoldColor,
            fontFamily: "SourceCodePro",
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 8.0,
                color: Color.fromARGB(125, 0, 0, 255),
              ),
            ],
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Style.linkColor,
          hoverColor: Style.linkHoverColor,
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Style.textColor,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 8.0,
                color: Color.fromARGB(125, 0, 0, 255),
              ),
            ],
          ),
          headline2: TextStyle(
            color: Style.textColor,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 8.0,
                color: Color.fromARGB(125, 0, 0, 255),
              ),
            ],
          ),
          headline3: TextStyle(
            color: Style.textColor,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 8.0,
                color: Color.fromARGB(125, 0, 0, 255),
              ),
            ],
          ),
          headline4: TextStyle(
            color: Style.textColor,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 8.0,
                color: Color.fromARGB(125, 0, 0, 255),
              ),
            ],
          ),
          headline5: TextStyle(
            color: Style.textColor,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 8.0,
                color: Color.fromARGB(125, 0, 0, 255),
              ),
            ],
          ),
          headline6: TextStyle(
            color: Style.textColor,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(2.0, 2.0),
                blurRadius: 8.0,
                color: Color.fromARGB(125, 0, 0, 255),
              ),
            ],
          ),
          bodyText1: TextStyle(
            color: Style.textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
          bodyText2: TextStyle(
            color: Style.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Widget userField = Text("unk");

  void login_cb() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage("Login")),
    );
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      super.setState(() {
        if (prefs.containsKey("session")) {
          String sessionString = prefs.getString("session")!;

          /// TODO: Get user name
          userField = TextButton(
              onPressed: null,
              child: Text(
                "SeaBass",
                style: Theme.of(context).textTheme.bodyMedium,
              ));
        } else {
          userField = TextButton(
              onPressed: login_cb,
              child: Text(
                "Log in",
                style: Theme.of(context).textTheme.bodyMedium,
              ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Advent Of Code"),
            userField,
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return TerminalCard(year: "${2022 - index}");
              },
              // 40 list items
              childCount: 8,
            ),
          ),
        ],
      ),
    );
  }
}
