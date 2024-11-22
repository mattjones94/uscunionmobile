import 'package:flutter/material.dart';
import 'package:uscunionmobile/custom/app_theme.dart';
import 'package:uscunionmobile/datamodel/todolist_model.dart';
import 'package:uscunionmobile/data/file_handler.dart';

class TodolistPage extends StatefulWidget {
  TodolistPage({Key? key}) : super(key: key);

  final TextEditingController storeFieldController = TextEditingController();
  final List<TodolistItem> todoList = [];
  final FileHandler fileHandler = FileHandler();
  bool _hasLoaded = false;

  @override
  State<TodolistPage> createState() => _TodolistPageState();
}

class _TodolistPageState extends State<TodolistPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      final data = await widget.fileHandler.readTodolistItems();
      setState(() {
        widget.todoList.addAll(data);
        widget._hasLoaded = true;
      });
    } catch (e) {
      setState(() {
        widget._hasLoaded = true;
      });
    }
  }

  void _addItem(String text) {
    setState(() {
      widget.todoList.add(TodolistItem(label: text, checked: false));
      widget.fileHandler.writeTodolistItems(widget.todoList);
    });
  }

  void _deleteItem(int index) {
    setState(() {
      widget.todoList.removeAt(index);
      widget.fileHandler.writeTodolistItems(widget.todoList);
    });
  }

  void _toggleItem(int index, bool isChecked) {
    setState(() {
      widget.todoList[index].checked = isChecked;
      if (isChecked) {
        widget.todoList.add(widget.todoList.removeAt(index));
      } else {
        widget.todoList.insert(0, widget.todoList.removeAt(index));
      }
      widget.fileHandler.writeTodolistItems(widget.todoList);
    });
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("New To-Do Item"),
          content: TextField(
            controller: widget.storeFieldController,
            decoration: InputDecoration(
              hintText: "Enter your task here",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                _addItem(widget.storeFieldController.text.trim());
                widget.storeFieldController.clear();
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget._hasLoaded
        ? Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: Text("To-Do List"),
              backgroundColor: AppTheme.colors.uscuBurgendy,
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _showAddDialog,
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: widget.todoList.length,
              itemBuilder: (context, index) {
                final item = widget.todoList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Checkbox(
                      value: item.checked,
                      onChanged: (isChecked) =>
                          _toggleItem(index, isChecked!),
                    ),
                    title: Text(
                      item.label,
                      style: TextStyle(
                        decoration: item.checked
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteItem(index),
                    ),
                  ),
                );
              },
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}
