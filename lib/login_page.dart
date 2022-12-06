import 'package:advent_of_code/auth_button.dart';
import 'package:advent_of_code/style_sheet.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage(String title, {super.key});
  final String title = "Login";

  void githubLoginCB() {
    print("github.");
  }

  void googleLoginCB() {
    print("google.");
  }

  void twitterLoginCB() {
    print("twitter.");
  }

  void redditLoginCB() {
    print("reddit.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 32.0, 32.0, 8),
            child: Text(
              "To play, please identify yourself via one of these services:",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthButton(
                "GitHub",
                FontAwesomeIcons.github,
                callback: githubLoginCB,
              ),
              AuthButton(
                "Google",
                FontAwesomeIcons.google,
                callback: googleLoginCB,
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(Style.padding1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthButton(
                "Twitter",
                FontAwesomeIcons.twitter,
                callback: twitterLoginCB,
              ),
              AuthButton(
                "Reddit",
                FontAwesomeIcons.reddit,
                callback: redditLoginCB,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
