import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:convert' as convert;
import './test/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Map config = {};
    () async {
      var status = await Permission.storage.status;
      if(status.isGranted) {
        File file = File('/storage/emulated/0/export_test/config');
        if(file.existsSync()) {
          // 存在则可操作
          var jsonStr = await file.readAsString();
          config = convert.jsonDecode(jsonStr);
          print(jsonStr);
        } else {
          // 不存在则提示
        }
      }
    }();
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: FilePickerTest(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {

  var current = 1;

  var favorites = [1];

  void toggleFavorite() {
    if(favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}