import 'package:flutter/material.dart';
import 'package:todo/Pages/Home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  await Hive.initFlutter("hive_boxes");
  await _openBox();
  runApp(MyApp());
}

Future<void> _openBox() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('Task');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 10.0,
          shadowColor: Color.fromARGB(255, 243, 72, 143),
          color: Color.fromARGB(255, 228, 30, 89),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 228, 30, 89),
        ),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}
