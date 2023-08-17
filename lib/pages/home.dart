import 'package:evaluate/components/radio.dart';
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
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
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
            CustomSelect(selected: depart, selectList: departList, type: 'depart'),
            CustomSelect(selected: subject, selectList: subjectList, type: 'subject'),
            CustomSelect(selected: ticket, selectList: ticketList, type: 'ticket'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRadio(radioValue: 'last', radioName: '继续上次身份打分'),
                CustomRadio(radioValue: 'new', radioName: '使用新身份打分'),
              ],
            ),
            SizedBox(height: 40,),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(280, 30)),
                foregroundColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
                backgroundColor: MaterialStateProperty.all(Color(0xFF1890ff)),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                textStyle: MaterialStateProperty.all(
                  TextStyle(
                    fontSize: 15,
                  )
                )
              ),
              child: Text('登 录'),
              onPressed: () => {
                print(appState.roleType),
                Navigator.of(context).pushNamed("evaluate")
              },
            ),
            SizedBox(height: 120,),
            TextButton(
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                      return AlertDialog(
                          title: const Text("提示"),
                          content: const Text("确定删除吗？"),
                          actions: [
                              TextButton(
                                  onPressed: () {
                                      Navigator.of(context).pop();
                                  },
                                  child: const Text("取消"),
                              ),
                              TextButton(onPressed: () {}, child: const Text("确定")),
                          ],
                      );
                  },
                )
              }, 
              child: Text('导入配置文件')
            )
          ],
        ),
      )
    );
  }
}
