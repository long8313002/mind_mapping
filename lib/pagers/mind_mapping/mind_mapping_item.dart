import 'package:flutter/material.dart';

typedef IValueChange(String newValue);

class MindMappingItem extends StatefulWidget {
  final String info;
  final IValueChange valueChange;
  final int lines ;

  MindMappingItem({this.info, this.valueChange,this.lines =1}) : assert(info != null);

  @override
  State<StatefulWidget> createState() {
    return _MindMappingItemState();
  }
}

class _MindMappingItemState extends State<MindMappingItem> {
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController.fromValue(TextEditingValue(
        text: widget.info,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: widget.info.length))));

    controller.addListener(() {
      widget.valueChange(controller.text);
    });
    return TextField(
      maxLines: widget.lines,
      controller: controller,
    );
  }
}
