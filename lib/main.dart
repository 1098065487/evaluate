import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './test/file_picker.dart';
import './pages/home.dart';
import './components/config_type.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Evaluate App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: Home(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  ConfigType config = {} as ConfigType;

  void updateConfig(current) {
    config = current;
    notifyListeners();
  }
}