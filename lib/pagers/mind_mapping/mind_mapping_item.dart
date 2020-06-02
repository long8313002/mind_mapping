import 'package:flutter/material.dart';

typedef void IValueChange(String newValue);

typedef void IAddClick();

class MindMappingItem extends StatefulWidget {
  final String info;
  final IValueChange valueChange;
  final int lines ;
  final IAddClick addClick;

  MindMappingItem({this.info, this.valueChange,this.lines =1,this.addClick}) : assert(info != null);

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
    return Stack(
      children: <Widget>[
        TextField(
          maxLines: widget.lines,
          controller: controller,
        ),
        Positioned(
          right: -10,
          top: 0,
          child: IconButton(
            icon: Icon(Icons.thumb_up),
            onPressed: () {
              if(widget.addClick!=null){
                widget.addClick();
              }
            },
          ),
        )
      ],
    );
  }
}
