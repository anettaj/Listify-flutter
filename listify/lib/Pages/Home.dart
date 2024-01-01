import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:listify/Models/Task.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Box? _box;
  String? val;
  TextEditingController? _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
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
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = (await prefs.setBool('isFirstLaunch', false));
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  void dispose() {
    _textEditingController!.dispose();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double H = MediaQuery.of(context).size.height;

    if (_box == null) {
      return Scaffold(
        appBar: _appbar(H),
        body: _loadingIndicator(),
        floatingActionButton: _addTaskButton(),
      );
    }

    return Scaffold(
      appBar: _appbar(H),
      body: _taskList(),
      floatingActionButton: _addTaskButton(),
    );
  }

  PreferredSizeWidget _appbar(double H){
    return AppBar(
      toolbarHeight: H * 0.109,
      title: const Text(
        'Listify',
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontFamily: 'Dela Gothic One',
          letterSpacing: 2,
          shadows: [
            Shadow(
              color: Colors.black,
              blurRadius: 2.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
          fontWeight: FontWeight.bold,
        ),
      ),
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
        return Container(
          padding: EdgeInsets.all(5),
          margin: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 18,
          ),
          decoration: const BoxDecoration(
              color: Color(0xFFFFF5DA),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Text(
              capitalize(task.content),
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'Days one',
                decoration: task.done ? TextDecoration.lineThrough : null,
                color: Colors.black,
              ),
            ),
            trailing: task.done
                ? const Icon(
                    Icons.check_box_outlined,
                    color: Color(0xFFC35959),
                    size: 26,
                  )
                : const Icon(
                    Icons.check_box_outline_blank_outlined,
                    color: Color(0xFFC35959),
                    size: 26,
                  ),
            subtitle: Text(
              '${task.time.toString()}',
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
          ),
        );
      },
    );
  }

  Widget _emptyTaskList() {
    return const Center(
      child: Text('No tasks available.'),
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      backgroundColor: Color(0xFFC35959),
      onPressed: _displayTaskPopup,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void _displayTaskPopup() {
    double H = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          backgroundColor: Color(0xFFC35959),
          title: const Center(
            child: Text(
              'Add Task',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xFFFFF5DA),
                fontFamily: 'Dela Gothic One',
              ),
            ),
          ),
          titlePadding: EdgeInsets.only(top: 40, right: 10),
          content: Container(
            height: H * 0.18,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Enter the task here:',
                      style: TextStyle(
                        fontFamily: 'Days one',
                        color: Color(0xFFFFF5DA),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: Color(0xFFFFF5DA),
                  ),
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _textEditingController!.clear();

                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFF5DA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Color(0xFFC35959),
                          fontFamily: 'Dela Gothic One',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String value = _textEditingController!.text.trim();

                        // Get the current date
                        DateTime currentDate = DateTime.now();

                        // Format the current date as "dd/MM/yyyy"
                        String formattedDate =
                            DateFormat("dd/MM/yyyy").format(currentDate);

                        // Set the current time
                        TimeOfDay currentTime = TimeOfDay.now();

                        // Create a DateTime object with the current date and selected time
                        DateTime selectedDateTime = DateTime(
                          currentDate.year,
                          currentDate.month,
                          currentDate.day,
                          currentTime.hour,
                          currentTime.minute,
                        );

                        // Format the selected date and time
                        String formattedDateTime =
                            DateFormat("dd/MM/yyyy h:mm a")
                                .format(selectedDateTime);

                        if (value.isNotEmpty) {
                          var _task = Task(
                            content: value,
                            done: false,
                            time: formattedDateTime,
                          );
                          _box!.add(_task.toMap());
                          setState(() {
                            _textEditingController!.clear();
                            Navigator.pop(context);
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFFF5DA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Enter",
                        style: TextStyle(
                          color: Color(0xFFC35959),
                          fontFamily: 'Dela Gothic One',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) => {_textEditingController!.clear()});
  }
}
