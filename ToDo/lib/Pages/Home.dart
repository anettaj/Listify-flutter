import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/Models/Task.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double _deviceHeight;
  String? _newTaskContent;
  Box? _box;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    try {
      _box = await Hive.openBox('Task');
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error opening Hive box: $e');
      // Handle the error as needed
    }
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;

    // Check if _box is still null, and show a loading indicator if it is
    if (_box == null) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: _deviceHeight * 0.12,
          title: const Text(
            'ToDo',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: _loadingIndicator(),
        floatingActionButton: _addTaskButton(),
      );
    }

    // Continue with the rest of the build method
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.12,
        title: const Text(
          'ToDo',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _taskList(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _loadingIndicator() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _taskList() {
    if (_box == null) {
      return _loadingIndicator();
    }

    List tasks = _box!.values.toList();

    if (tasks.isEmpty) {
      return _emptyTaskList();
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext _context, int _index) {
        var task = Task.fromMap(tasks[_index]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
              fontSize: 20,
              decoration: task.done ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          trailing: task.done
              ? Icon(
                  Icons.check_box_outlined,
                  color: Color.fromARGB(255, 228, 30, 89),
                  size: 25,
                )
              : Icon(
                  Icons.check_box_outline_blank_outlined,
                  color: Color.fromARGB(255, 228, 30, 89),
                  size: 25,
                ),
          subtitle: Text(
            task.timestamp.toString(),
            style: TextStyle(fontSize: 15),
          ),
          onTap: () {
            setState(() {
              task.done = !task.done;
              _box!.putAt(_index, task.toMap());
            });
          },
          onLongPress: () {
            setState(() {
              _box!.deleteAt(_index);
            });
          },
        );
      },
    );
  }

  Widget _emptyTaskList() {
    return Center(
      child: Text('No tasks available.'),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 228, 30, 89),
      onPressed: _displayTaskPopup,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text("Add New Task!"),
          content: TextField(
            onSubmitted: (_value) {
              if (_value.isNotEmpty) {
                var _task = Task(
                  content: _value,
                  done: false,
                  timestamp: DateTime.now(),
                );
                _box!.add(_task.toMap());
                setState(() {
                  _newTaskContent = null;
                  Navigator.pop(context);
                });
              }
            },
            onChanged: (_value) {
              setState(() {
                _newTaskContent = _value;
              });
            },
          ),
        );
      },
    );
  }
}
