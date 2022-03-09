import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monets/constants/color_pallete.dart';
import 'package:monets/models/vrijeme_model.dart';

class TimeWidget extends StatefulWidget {
  final VrijemeModel vrijemeModel;
  final int selected;
  final int index;

  const TimeWidget({Key? key, required this.vrijemeModel, required this.selected, required this.index}) : super(key: key);

  @override
  _TimeWidgetState createState() => _TimeWidgetState();
}

class _TimeWidgetState extends State<TimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            width: 70.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: (widget.vrijemeModel.isSlobodno!) ? Colors.white : Colors.grey.shade400,
              border: (widget.selected == widget.index)? Border.all(
                color: ColorPallete.purple, //color of border
                width: 4, //width of border
              ):Border.all(
                color: Colors.black, //color of border
                width: 1, //width of border
              ),
            ),
            child: Text(
              DateFormat('kk:mm').format(widget.vrijemeModel.vrijeme!),
              style: TextStyle(
                fontFamily: 'Avenir-Medium',
                fontSize: 16.0,
                color: ColorPallete.darkGrey
              ),
            ),
          ),
        ),
      ],
    );
  }
}
