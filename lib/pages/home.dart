import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:provider/provider.dart';
import '../main.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {

    var appState = context.watch<MyAppState>();
    Map allConfig = appState.config;

    () async {
      if(allConfig.isEmpty) {
        var status = await Permission.storage.status;
        if(status.isGranted) {
          File file = File('/storage/emulated/0/export_test/config');
          if(file.existsSync()) {
            // 存在则可操作
            var jsonStr = await file.readAsString();
            var config = convert.jsonDecode(jsonStr);
            appState.updateConfig(config);
          } else {
            // 不存在则提示
          }
        }
      }
    }(); 
    return Center(
      child: Text('Home'),
    );
  }
}
