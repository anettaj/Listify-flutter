import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/Pages/Home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/Pages/Splash_one.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Hive.initFlutter("hive_boxes");
    await _openBox();
    bool isFirstLaunch = await _initializeData();

    runApp(MyApp(isFirst: isFirstLaunch));
  } catch (e) {
    print('Error initializing app: $e');
  }
}

Future<bool> _initializeData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isFirstLaunch') ?? true;
}

Future<void> _openBox() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('Task');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isFirst}) : super(key: key);

  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 10.0,
          shadowColor: Color(0xFFC35959),
          color: Color(0xFFC35959),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFFC35959),
        ),
        useMaterial3: true,
      ),
      home: isFirst ? const SplashOne() : const Home(),
    );
  }
}
