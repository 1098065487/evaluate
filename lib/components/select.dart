import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:provider/provider.dart';
import '../main.dart';

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
            } else if(type == 'subject') {
              appState.updateSubjectSelected(handleSelected);
            }
          }, 
        );
      },
      child: Container(
          padding: const EdgeInsets.all(10),
          child: Text(
              selected.isNotEmpty ? selected['name'] : renderTips(type),
          ),
        )
    );
  }
}
