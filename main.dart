import 'lib/mainlib.dart';
import 'dart:io';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('No arguments passed. Usage: hpsc <folder>');
  } else {
    String folder = arguments[0];

    stdout.write('What is your project called: ');
    String? projectname = stdin.readLineSync();

    String html = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$projectname</title>
    <link rel="stylesheet" href="assets/styles.css">
    <script src="assets/scripts.js"></script>
</head>
<body>

</body>
</html>""";

    final csstype = consoleChoices("Do you want to use scss?", "css", "scss", "blue", "magenta");

    final jstype = consoleChoices("Do you want to use typescript?", "js", "ts", "yellow", "blue");

    bool indexhtmlexists = checkForFile("$folder/index.html", "file");
    if (!indexhtmlexists) {
      print("Creating index.html");
      createfile("$folder/index.html", html, "Creation of index.html complete!");
    } else {
      print("Index.html already exists");
    }

    await Future.delayed(Duration(milliseconds: 100));

    bool assetsfolderexists = checkForFile("$folder/assets", "folder");
    if (!assetsfolderexists) {
      print("Creating assets folder");
      createfolder("$folder/assets", "Creation of assets folder complete!");
    } else {
      print("Assets folder already exists");
    }

    await Future.delayed(Duration(milliseconds: 100));

    if (csstype == "css") {
      bool stylescssexists = checkForFile("$folder/assets/styles.css", "file");
      if (!stylescssexists) {
        print("Creating styles.css");
        createfile("$folder/assets/styles.css", "", "Creation of styles.css complete!");
      } else {
        print("Styles.css already exists");
      }
    } else {
      bool stylesscssexists = checkForFile("$folder/assets/styles.scss", "file");
      if (!stylesscssexists) {
        print("Creating styles.scss");
        createfile("$folder/assets/styles.scss", "", "Creation of styles.scss complete!");
      } else {
        print("Styles.scss already exists");
      }
    }

    await Future.delayed(Duration(milliseconds: 100));

    if (jstype == "js") {
      bool scriptsjsexists = checkForFile("$folder/assets/scripts.js", "file");
      if (!scriptsjsexists) {
        print("Creating scripts.js");
        createfile("$folder/assets/scripts.js", "", "Creation of scripts.js complete!");
      } else {
        print("Scripts.js already exists");
      }
    } else {
      bool scriptstsexists = checkForFile("$folder/assets/scripts.ts", "file");
      if (!scriptstsexists) {
        print("Creating scripts.ts");
        createfile("$folder/assets/scripts.ts", "", "Creation of scripts.ts complete!");
      } else {
        print("Scripts.ts already exists");
      }
    }

    await Future.delayed(Duration(milliseconds: 100));

    print("");
    print("Your project has been setup!");
    print("Thank you for using hpsc!");
  }
}