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
    Map<String, dynamic> depart = appState.departSelected;
    Map<String, dynamic> subject = appState.subjectSelected;
    Map<String, dynamic> ticket = appState.ticketSelected;

    print(depart);
    print(subject);
    print(ticket['value']);
    
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

    var ticketList = [];
    if(subject.isNotEmpty) {
      List <Departments> departs = allConfig.departments;
      List <Departments> filterDepart = departs.where((element) => element.dpartmentId == depart['value']).toList();
      List<Subject> selected = filterDepart[0].subject.where((element) => element.subjectId == subject['value']).toList();
      ticketList = selected[0].ticketTypeArr.map((e) => (name: e.ticketType, value: e.pdss)).toList();
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
            ConfigType obj = ConfigType.fromJson(config);
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
              width: MediaQuery.of(context).size.width - 110,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(160, 160, 160, 0.15),
                borderRadius: BorderRadius.circular(32),
              ),
              child: CustomSelect(selected: depart, selectList: departList, type: 'depart'),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 110,
              margin: EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(160, 160, 160, 0.15),
                borderRadius: BorderRadius.circular(32),
              ),
              child: CustomSelect(selected: subject, selectList: subjectList, type: 'subject'),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 110,
              margin: EdgeInsets.symmetric(vertical: 20.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(160, 160, 160, 0.15),
                borderRadius: BorderRadius.circular(32),
              ),
              child: CustomSelect(selected: ticket, selectList: ticketList, type: 'ticket'),
            ),
          ],
        ),
      )
    );
  }
}
