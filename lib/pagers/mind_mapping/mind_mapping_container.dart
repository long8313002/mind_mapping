import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindmapping/pagers/mind_mapping/mind_mapping_info.dart';
import 'package:mindmapping/pagers/mind_mapping/mind_mapping_line.dart';

import 'mind_mapping_item.dart';
import 'mind_mapping_layout.dart';

class MindMappingContainer extends StatefulWidget {
  final List<MindMappingInfo> infoList;

  final ILayout layout = MindMappingLayout(leftOffset: 30, topOffset: 15, width: 100, height: 30);

  MindMappingContainer(this.infoList){
     layout.layout(infoList);
  }

  @override
  State<StatefulWidget> createState() {
    return _MindMappingContainerState();
  }
}

class _MindMappingContainerState extends State<MindMappingContainer> {
  final ScrollController _hController = new ScrollController();
  final ScrollController _vController = new ScrollController();

  static const double WIDTH_OFFSET = 300;
  static const double HEIGHT_OFFSET = 300;

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    var measureReact = measureWidthHeightLooper(widget.infoList);

    return SingleChildScrollView(
      controller: _hController,
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        controller: _vController,
        child: Container(
            width: max(measureReact.width + WIDTH_OFFSET,screenSize.width),
            height: max(measureReact.height + HEIGHT_OFFSET,screenSize.height),
            padding:
                EdgeInsets.only(left: WIDTH_OFFSET / 2, top: HEIGHT_OFFSET / 2),
            child: Stack(
              children: createChildren(),
            )),
      ),
    );
  }

  List<Widget> createChildren() {
    List<MindMappingInfo> infoList = widget.infoList;

    var childViews = List<Widget>();

    addChildToList(childViews, infoList);

    return childViews;
  }

  void addChildToList(List<Widget> childViews, List<MindMappingInfo> infoList) {
    if (infoList == null) {
      return;
    }
    infoList.forEach((item) {
      childViews.add(Positioned(
        left: item.left,
        top: item.top,
        child: Container(
            width: item.width,
            height: item.height,
            color: Colors.transparent,
            child: MindMappingItem(
              info: item.content,
              lines: widget.layout.getLines(item),
              valueChange: (newValue) {
                setState(() {
                  item.content = newValue;
                  widget.layout.layout(widget.infoList);
                });
              },
              addClick: (){
                setState(() {
                  item.children.add(MindMappingInfo(content: "新的"));
                  widget.layout.layout(widget.infoList);
                });
              },
            )),
      ));

      if (item.lines != null && item.lines.isNotEmpty) {
        item.lines.forEach((line) {
          childViews.add(MindMappingLine(line: line,));
        });
      }

      addChildToList(childViews, item.children);
    });
  }
}
