import 'package:advent_of_code/login_page.dart';
import 'package:advent_of_code/network.dart';
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
        primarySwatch: Style.terminalHighlightSwatch,
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
  late Widget userField = const Text("unk");

  void loginCB() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage("Login")),
    );
  }

  // Sets up the
  void setLoginText() async {
    // Get the text from the username div
    String username = "";
    String stars = "";
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("session")) {
      String sessionString = prefs.getString("session")!;

      var usernamePair = await getUserName(sessionString);
      username = usernamePair.item1;
      stars = usernamePair.item2;
    }

    /// TODO: Add user profile picture.
    super.setState(() {
      if (usernameDivText.isNotEmpty) {
        userField = TextButton(
            onPressed: null,
            child: Row(
              children: [
                Text(
                  username,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Padding(padding: EdgeInsets.all(Style.padding1)),
                Text(
                  stars,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.apply(color: Style.starColor),
                ),
                // SizedBox(
                //   width: 70,
                //   height: 70,
                //   child: ClipOval(
                //     child: Image.asset(
                //       "assets/images/user-icon.png",
                //       width: 20,
                //       height: 20,
                //     ),
                //   ),
                // ),
              ],
            ));
      } else {
        userField = TextButton(
            onPressed: loginCB,
            child: Text(
              "Log in",
              style: Theme.of(context).textTheme.bodyMedium,
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setLoginText();
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
                return TerminalCard(year: "${DateTime.now().year - index}");
              },
              childCount: DateTime.now().year - yearZero,
            ),
          ),
          const SliverPadding(padding: EdgeInsets.all(Style.padding0))
        ],
      ),
    );
  }
}
