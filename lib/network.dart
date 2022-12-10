import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:html/parser.dart' show parse;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';
// import 'package:oauth2/oauth2.dart' as oauth2;
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_cookie_manager/webview_cookie_manager.dart';

// Seconds between each access
const int throttleAccessRateSeconds = 5;
DateTime timeLastAccess = DateTime.fromMillisecondsSinceEpoch(0);

// This function is the way out of the application.
// Data access rates will be throttled to avoid angering
// the lovely people who make Advent of Code possible.
Future<Response> getWebPage(final Uri url,
    {final String sessionToken = ""}) async {
  //
  // Determine if we have waited long enough since last query
  // If we have not, then wait
  final timePastSafeTime = DateTime.now().difference(
      timeLastAccess.add(const Duration(seconds: throttleAccessRateSeconds)));
  if (timePastSafeTime.inSeconds < 0) {
    await Future.delayed(Duration(seconds: -1 * timePastSafeTime.inSeconds));
  }

  timeLastAccess = DateTime.now();
  http.Client client = http.Client();
  Map<String, String> headers = (sessionToken.isNotEmpty)
      ? {
          "cookie": "session=$sessionToken",
        }
      : {};
  return client.get(url, headers: headers);
}

const String adventWebsite = "https://adventofcode.com/";
const int yearZero = 2014;

// Auth Endpoints
const String endpointGitHubAuth = "${adventWebsite}auth/github";
const String endpointGoogleAuth = "${adventWebsite}auth/google";
const String endpointTwitterAuth = "${adventWebsite}auth/twitter";
const String endpointRedditAuth = "${adventWebsite}auth/reddit";

Future<void> getSessionToken(context, final String authType) async {
  // Determine which endpoint for the given request
  String endpointAuth = "";
  switch (authType) {
    case "github":
      endpointAuth = endpointGitHubAuth;
      break;
    case "google":
      endpointAuth = endpointGoogleAuth;
      break;
    case "twitter":
      endpointAuth = endpointTwitterAuth;
      break;
    case "reddit":
      endpointAuth = endpointRedditAuth;
      break;
    default:
      return;
  }

  // Let the user login so we can access the session token
  Response reqOAuthURL = await getWebPage(Uri.parse(endpointAuth));
  final CookieManager cookieManager = CookieManager.instance();

  // If that all went well we can grab the token
  if (reqOAuthURL.statusCode == 200) {
    List<Cookie> cookies =
        await cookieManager.getCookies(url: Uri.parse(adventWebsite));
    Cookie sessionCookie =
        cookies.firstWhere((element) => element.name == "session");
    String sessionString = sessionCookie.value;

    // Save the cookie in the prefs
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("session", sessionString);
      // Go back to the main page.
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }
}

// Retrieve the username from the Advent of Code page
// Yes there may be a better way of doing this...
// returns the username, and the number of stars string
Future<Tuple2<String, String>> getUserName(String sessionString) async {
  var req = await getWebPage(
    Uri.parse(adventWebsite),
    sessionToken: sessionString,
  );

  if (req.statusCode != 200) return const Tuple2("", "");

  final document = parse(String.fromCharCodes(req.bodyBytes));
  final usernameDivs = document.getElementsByClassName("user");
  if (usernameDivs.isEmpty) return const Tuple2("", "");

  final usernameDiv = usernameDivs[0];
  final starCounts = usernameDiv.getElementsByClassName("star-count");
  final String stars = (starCounts.isNotEmpty) ? starCounts[0].text : "";

  // Separate the username from the star count if there is a star count
  String username = usernameDiv.text;
  if (stars.isNotEmpty) {
    final tokens = username.split(" ");
    username = tokens.sublist(0, tokens.length - 1).join(" ");
  }

  return Tuple2(username, stars);
}

String processAdventPage(final String raw) {
  var document = parse(raw);
  var descriptions = document.getElementsByClassName("day-desc");

  String str = "";
  for (var description in descriptions) {
    str += description.outerHtml;
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
  var req = await getWebPage(Uri.parse(url));
  if (req.statusCode == 200) {
    return String.fromCharCodes(req.bodyBytes);
  } else {
    return "";
  }
}
