import 'lib/mainlib.dart';
import 'dart:io';

void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    print('No arguments passed. Usage: hpsc <folder>');
  } else {
    String folder = arguments[0];

    stdout.write('What is your project called: ');
    String? projectname = stdin.readLineSync();

    // Choice between HTML (orange) or PHP (purple)
    final doctype = consoleChoices("Do you want to use HTML or PHP?", "html", "php", "red", "magenta");

    String htmlContent = """<!DOCTYPE html>
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

    String phpContent = """<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$projectname</title>
    <link rel="stylesheet" href="assets/styles.css">
    <script src="assets/scripts.js"></script>
</head>
<body>
    <?php echo "<h1>Welcome to $projectname</h1>"; ?>
</body>
</html>""";

    // Prompt for CSS or SCSS
    final csstype = consoleChoices("Do you want to use SCSS or CSS?", "css", "scss", "blue", "magenta");

    // Prompt for JS or TS
    final jstype = consoleChoices("Do you want to use TypeScript?", "js", "ts", "yellow", "blue");

    // Create index.html or index.php based on the user's choice
    bool indexExists = checkForFile("$folder/index.${doctype}", "file");
    if (!indexExists) {
      print("Creating index.${doctype}");
      String content = doctype == "html" ? htmlContent : phpContent;
      createfile("$folder/index.${doctype}", content, "Creation of index.${doctype} complete!");
    } else {
      print("Index.${doctype} already exists");
    }

    await Future.delayed(Duration(milliseconds: 100));

    // Create assets folder if it doesn't exist
    bool assetsfolderexists = checkForFile("$folder/assets", "folder");
    if (!assetsfolderexists) {
      print("Creating assets folder");
      createfolder("$folder/assets", "Creation of assets folder complete!");
    } else {
      print("Assets folder already exists");
    }

    await Future.delayed(Duration(milliseconds: 100));

    // Handle CSS or SCSS file creation
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

    // Handle JS or TS file creation
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
    print("Your project has been set up!");
    print("Thank you for using hpsc!");
  }
}