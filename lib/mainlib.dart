import 'dart:io';
import 'package:dart_console/dart_console.dart';

void createfile(String filename, String content, String successmessage) async {
  final file = File(filename);
  await file.writeAsString(content);
  print(successmessage);
}

void createfolder(String folderName, String successMessage) async {
  final directory = Directory(folderName);
  try {
    await directory.create(recursive: true);
    print(successMessage);
  } catch (e) {
    print('Error creating folder: $e');
  }
}

bool checkForFile(String path, String type) {
  final file = File(path);
  final directory = Directory(path);

  if (type == 'file') {
    return file.existsSync();
  } else if (type == 'folder') {
    return directory.existsSync();
  } else {
    throw ArgumentError('Invalid type specified. Use "file" or "folder".');
  }
}

String consoleChoices(String topText, String choice1, String choice2, String color1, String color2) {
  final console = Console();

  int selectedIndex = 0;
  List<String> choices = [choice1, choice2];
  List<String> colors = [color1, color2];

  void drawChoices() {
    console.clearScreen();
    console.setForegroundColor(ConsoleColor.white);
    console.writeLine(topText);

    for (int i = 0; i < choices.length; i++) {
      if (i == selectedIndex) {
        // Use the color assigned to the selected choice
        console.setForegroundColor(ConsoleColor.values.firstWhere(
          (color) => color.toString().split('.').last.toLowerCase() == colors[i].toLowerCase(),
          orElse: () => ConsoleColor.white,
        ));
        console.writeLine('> ${choices[i]}');
      } else {
        // Use the color assigned to the non-selected choices
        console.setForegroundColor(ConsoleColor.values.firstWhere(
          (color) => color.toString().split('.').last.toLowerCase() == colors[i].toLowerCase(),
          orElse: () => ConsoleColor.white,
        ));
        console.writeLine('  ${choices[i]}');
      }
    }
  }

  drawChoices();

  while (true) {
    final key = console.readKey();

    if (key.isControl) {
      switch (key.controlChar) {
        case ControlCharacter.arrowUp:
          selectedIndex = (selectedIndex - 1 + choices.length) % choices.length; // Ensure index is positive
          break;
        case ControlCharacter.arrowDown:
          selectedIndex = (selectedIndex + 1) % choices.length;
          break;
        case ControlCharacter.enter:
          console.clearScreen();
          String selectedChoice = choices[selectedIndex];
          console.resetColorAttributes();
          return selectedChoice;
        default:
          continue;
      }
      drawChoices();
    }
  }
}