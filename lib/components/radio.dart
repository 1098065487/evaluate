import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class CustomRadio extends StatelessWidget {
  CustomRadio({required this.radioValue, required this.radioName, super.key});

  final String radioValue;
  final String radioName;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return GestureDetector(
        onTap: () => {
          if(radioValue != appState.roleType) {
            appState.updateRoleType(radioValue)
          }
        },
        child: Container(
          width: 145,
          margin: EdgeInsets.symmetric(vertical: 10.0),
          // padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            // borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                  visualDensity: VisualDensity.compact,
                  activeColor: Color(0xFF1890ff),
                  value: radioValue,
                  groupValue: appState.roleType,
                  onChanged: (val) => {
                    if(radioValue != appState.roleType) {
                      appState.updateRoleType(radioValue)
                    }
                  }),
              Text(
                radioName,
                style: TextStyle(
                  fontSize: 12
                ),
              )
            ],
          ),
        ));
  }
}
