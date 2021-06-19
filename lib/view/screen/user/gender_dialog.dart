import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitool/custom_values/custom_colors.dart';
import 'package:habitool/widgets/custom_dialog.dart';
import 'package:radio_grouped_buttons/radio_grouped_buttons.dart';

class GenderDialog extends StatefulWidget {
  String gender;
  Function(String) edited;
  GenderDialog({Key key, this.gender, this.edited}) : super(key: key);

  @override
  _GenderDialogState createState() => _GenderDialogState();
}

class _GenderDialogState extends State<GenderDialog> {
  TextEditingController _genderController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _genderController.text = widget.gender;
  }
  List<String> buttonList = ['Nam', 'Nữ', 'Khác'];

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Giới tính',
      content: CustomRadioButton(       
        buttonLables: buttonList,
        buttonValues: buttonList,
        radioButtonValue: (value, index) {
          print("Button value " + value.toString());
          print("Integer value " + index.toString());
        },
        horizontal: true,
        enableShape: true,
        buttonSpace: 10,
        buttonColor: Colors.white,
        selectedColor: CustomColors.pink,
        elevation: 0,
      ),
    );
  }
}
