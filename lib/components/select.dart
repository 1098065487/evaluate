import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomSelect extends StatelessWidget {
  CustomSelect({required this.selected, required this.selectList, required this.type, super.key});

  final Map<String, dynamic> selected;
  final List <dynamic> selectList;
  final String type;

  String renderTips(String type) {
    switch(type) {
      case 'depart':
        return '请选择部门';
      case 'subject':
        return '请选择持票层面';
      case 'ticket':
        return '请选择持票种';
      default: 
        return '请选择';
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return GestureDetector(
      onTap: () {
        print(11111);
        if(appState.config.padId == 0) {
          Fluttertoast.showToast(
            msg: "请先导入配置",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
            textColor: Colors.white,
            fontSize: 15.0
          );
        } else {
          if(type == 'subject' && appState.departSelected.isEmpty) {
            Fluttertoast.showToast(
              msg: "请先选择部门",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
              textColor: Colors.white,
              fontSize: 15.0
            );
          } else if(type == 'ticket' && appState.subjectSelected.isEmpty) {
            Fluttertoast.showToast(
              msg: "请先选择持票层面",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              gravity: ToastGravity.CENTER,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
              textColor: Colors.white,
              fontSize: 15.0
            );
          } else {
            Pickers.showSinglePicker(context,
              data: selectList.map((e) => e.name).toList(),
              selectData: selected['name'],
              pickerStyle: PickerStyle(
                textColor: Colors.black,
                textSize: 17,
              ),
              onConfirm: (p, position) {
                Map<String, dynamic> handleSelected = {
                  'name': p,
                  'value': selectList[position].value,
                };
                if(type == 'depart') {
                  appState.updateDepartSelected(handleSelected);
                  appState.updateSubjectSelected({});
                  appState.updateTicketSelected({});
                } else if(type == 'subject') {
                  appState.updateSubjectSelected(handleSelected);
                  appState.updateTicketSelected({});
                } else if(type == 'ticket') {
                  appState.updateTicketSelected(handleSelected);
                }
              }, 
            );
          }
        }
      },
      child: Container(
          width: MediaQuery.of(context).size.width - 110,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(160, 160, 160, 0.15),
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selected.isNotEmpty ? selected['name'] : renderTips(type),
                style: TextStyle(
                  color: selected.isNotEmpty ? Colors.black : Color.fromRGBO(128, 128, 128, 1),
                  fontSize: 15
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: selected.isNotEmpty ? Colors.black : Color.fromRGBO(128, 128, 128, 1),
                size: 15
              ),
            ],
          )
          
        )
    );
  }
}
