import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:provider/provider.dart';
import '../main.dart';
import '../components/select.dart';
import '../components/config_type.dart';

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {

    var appState = context.watch<MyAppState>();
    Map allConfig = appState.config;

    var depart = '';
    var departId;
    List <dynamic> departList = [];
    if(allConfig.isNotEmpty) {
      List <Departments> departs = allConfig['departments'];
      print(2222);
      print(allConfig);
      print(depart);
    }

    void updateDepart(current) {
      depart = current;
    }

    () async {
      if(allConfig.isEmpty) {
        var status = await Permission.storage.status;
        if(status.isGranted) {
          File file = File('/storage/emulated/0/export_test/config');
          if(file.existsSync()) {
            // 存在则可操作
            var jsonStr = await file.readAsString();
            var config = convert.jsonDecode(jsonStr);
            print(config);
            ConfigType obj = ConfigType.fromJson(config);
            Map<String, dynamic> map = obj.toJson();
            print(11111);
            print(map);
            appState.updateConfig(map);
          } else {
            // 不存在则提示
          }
        }
      }
    }(); 
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 80.0),
        child: Column(
          children: [
            Center(
              child: Text(
                '领导干部测评系统PAD版',
                style: TextStyle(fontSize: 24),
              )
            ),
            // CustomSelect(selected: depart = '', selectList: departList)
          ],
        ),
      )
    );
  }
}
