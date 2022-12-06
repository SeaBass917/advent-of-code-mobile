import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:html/parser.dart' show parse;

import 'package:http/http.dart' as http;

const String adventWebsite = "https://adventofcode.com/";
const int adventYear0 = 2015;

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
  http.Client client = http.Client();
  var req = await client.get(Uri.parse(url));
  if (req.statusCode == 200) {
    return String.fromCharCodes(req.bodyBytes);
  } else {
    return "";
  }
}
