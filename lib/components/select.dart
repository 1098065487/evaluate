import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';

class CustomSelect extends StatelessWidget {
  CustomSelect({required this.selected, required this.selectList, super.key});

  final String selected;
  final List <dynamic> selectList;
  // void updateSelect;

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('11111');
        Pickers.showSinglePicker(context,
          data: selectList,
          selectData: selected,
          onConfirm: (p, position) {
            print(p);
          }, 
          // onChanged: (p) => print('数据发生改变：$p')
        );
      },
      child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('My Button'),
        )
    );
  }
}
