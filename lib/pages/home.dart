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
    ConfigType allConfig = appState.config;
    Map <String, dynamic> depart = appState.departSelected;
    Map <String, dynamic> subject = appState.subjectSelected;
    
    var departList = [];
    if(allConfig.padId != 0) {
      List <Departments> departs = allConfig.departments;
      departList = departs.map((e) => (name: e.departmentName, value: e.dpartmentId)).toList();
    }

    var subjectList = [];
    if(depart.isNotEmpty) {
      List <Departments> departs = allConfig.departments;
      List <Departments> selected = departs.where((element) => element.dpartmentId == depart['value']).toList();
      subjectList = selected[0].subject.map((e) => (name: e.subjectName, value: e.subjectId)).toList();
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
        padding: EdgeInsets.symmetric(vertical: 100.0),
        child: Column(
          children: [
            Center(
              child: Text(
                '领导干部测评系统PAD版',
                style: TextStyle(fontSize: 25),
              )
            ),
            SizedBox(height: 40,),
            Container(
              width: MediaQuery.of(context).size.width - 140,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomSelect(selected: depart, selectList: departList, type: 'depart'),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 140,
              margin: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomSelect(selected: subject, selectList: subjectList, type: 'subject'),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 140,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomSelect(selected: depart, selectList: departList, type: 'ticket'),
            ),
          ],
        ),
      )
    );
  }
}
