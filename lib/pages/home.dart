import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:provider/provider.dart';
import '../main.dart';
import '../components/select.dart';
import '../components/config_type.dart';

typedef SelectType = List<dynamic>;

class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {

    var appState = context.watch<MyAppState>();
    ConfigType allConfig = appState.config;

    var depart = '';
    var departId;
    SelectType departList = [];
    if(allConfig.padId != 0) {
      List <Departments> departs = allConfig.departments;
      departList = departs.map((e) => (name: e.departmentName, value: e.dpartmentId)).toList();
    }

    void updateDepart(current) {
      depart = current;
    }

    () async {
      if(allConfig.padId == 0) {
        var status = await Permission.storage.status;
        if(status.isGranted) {
          File file = File('/storage/emulated/0/export_test/config');
          if(file.existsSync()) {
            // 存在则可操作
            var jsonStr = await file.readAsString();
            var config = convert.jsonDecode(jsonStr);
            print(config);
            ConfigType obj = ConfigType.fromJson(convert.jsonDecode(jsonStr));
            appState.updateConfig(obj);
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
            CustomSelect(selected: depart = '', selectList: departList)
          ],
        ),
      )
    );
  }
}
