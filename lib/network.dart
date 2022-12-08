import 'dart:convert';
import 'dart:io';
import 'package:advent_of_code/web_view_better.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:html/parser.dart' show parse;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:oauth2/oauth2.dart' as oauth2;
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_cookie_manager/webview_cookie_manager.dart';

const String adventWebsite = "https://adventofcode.com/";
const String endpointGitHubAuth = "${adventWebsite}auth/github";
const String endpointGoogleAuth = "${adventWebsite}auth/google";
const String endpointTwitterAuth = "${adventWebsite}auth/twitter";
const String endpointRedditAuth = "${adventWebsite}auth/reddit";

Future<void> getGitHubSessionToken(context) async {
  http.Client client = http.Client();
  final CookieManager cookieManager = CookieManager.instance();
  Response reqOAuthURL = await client.get(Uri.parse(endpointGitHubAuth));
  if (reqOAuthURL.statusCode == 200) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WebViewBetter(Uri.parse(endpointGitHubAuth), cookieManager),
        ));
  }

  List<Cookie> cookies =
      await cookieManager.getCookies(url: Uri.parse(adventWebsite));
  Cookie sessionCookie =
      cookies.firstWhere((element) => element.name == "session");
  String sessionString = sessionCookie.value;

  // Save a preference
  SharedPreferences.getInstance().then((prefs) {
    prefs.setString("session", sessionString);
  });

  // var req = await client.get(
  //   Uri.parse("${adventWebsite}2022/day/1"),
  //   headers: {
  //     "cookie": "session=$sessionString",
  //   },
  // );
  // if (req.statusCode == 200) {
  //   print(processAdventPage(String.fromCharCodes(req.bodyBytes)));
  // } else {
  //   return "";
  // }
}

String processAdventPage(final String raw) {
  var document = parse(raw);
  var descriptions = document.getElementsByClassName("day-desc");

  String str = "";
  int i = 0;
  for (var description in descriptions) {
    str += "description.outerHtml.$i";
    i++;
  }

  return str;
}

// Get the data for this [year] and [day]
// [day] == 0 => just see if the main page is active for the specified [year].
// Cache using the following design:
//    .data/
//    .data/2015/
//    .data/2015/exists
//    .data/2015/day_1
//    .data/2015/day_2
//    .data/2015/...
//    .data/2015/day_25
//    .data/2016/exists
Future<String> getAdventPage(final int year, {final int day = 0}) async {
  try {
    // Get the to the dir for storing docs
    final String pathDocs = (await getApplicationDocumentsDirectory()).path;

    // Determine the path to get and path to store
    final String downloadURL =
        (0 < day) ? "$adventWebsite$year/day/$day" : "$adventWebsite$year/";
    final String filename = (0 < day) ? "day_$day" : "exists";
    final File filepath = File("$pathDocs/$year/$filename");

    // If the data is present, use that data
    if (await filepath.exists()) {
      return filepath.readAsString();

      // Otherwise download the data
      // parse the data
      // store the data
    } else {
      // Download will return "" on failure.
      String data = await downloadFile(downloadURL);
      if (data.isNotEmpty) {
        // We just need the main problem text,
        // Unless it's [day] == 0, then we just store "exists"
        if (0 < day) {
          data = processAdventPage(data);
        } else {
          data = "exists";
        }

        // Cache for next time
        await Directory("$pathDocs/$year/").create(recursive: true);
        await filepath.writeAsString(data);
      }
      return data;
    }
  } on MissingPlatformDirectoryException {
    return "";
  }
}

// Download from the specified [url].
Future<String> downloadFile(String url) async {
  http.Client client = http.Client();
  var req = await client.get(Uri.parse(url));
  if (req.statusCode == 200) {
    return String.fromCharCodes(req.bodyBytes);
  } else {
    return "";
  }
}
