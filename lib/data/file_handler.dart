import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:uscunionmobile/datamodel/todolist_model.dart';

const String filePath = '/todolist.txt';

class FileHandler {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path$filePath');
  }

  Future<File> writeTodolistItems(List<TodolistItem> todolist) async {
    print("The todolist has been written to");

    List<Map<String, dynamic>> json = [];

    for (int index = 0; index < todolist.length; index++) {
      json.add(todolist[index].TodolistToMap(todolist[index]));
    }

    final String jsonEncoded = jsonEncode(json);

    print(jsonEncoded);

    final file = await _localFile;

    return file.writeAsString(jsonEncoded);
  }

  Future<List<TodolistItem>> readTodolistItems() async {
    try {
      final file = await _localFile;

      if (file.existsSync()) {
        // print("The file exists!");

        // read the file
        final contents = await file.readAsString();

        // print(contents);

        // literally to fix I only had to remove the cast to List<Map<String, dynamic>> here
        final List<dynamic> jsonMap = jsonDecode(contents);

        // print("cast to map worked $jsonMap");

        List<TodolistItem> todolist = [];

        for (int index = 0; index < jsonMap.length; index++) {
          todolist.add(TodolistItem.fromJSON(jsonMap[index]));
        }

        return todolist;
      } else {
        // print("the file does not exist");
        return [
          TodolistItem(
            label: "Example Item",
            
            checked: false,
          ),
        ];
      }
    } catch (e) {
      throw Exception("cannot load todolist");
    }
  }

  Future<void> clearItems() async {
    try {
      final localFile = await _localFile;

      if (await localFile.exists()) {
        await localFile.delete();
      }
    } catch (e) {
      throw Exception("Error in deleting items.");
    }
  }
}
