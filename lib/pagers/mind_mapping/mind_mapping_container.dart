import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mindmapping/pagers/mind_mapping/mind_mapping_info.dart';

import 'mind_mapping_item.dart';
import 'mind_mapping_layout.dart';

class MindMappingContainer extends StatefulWidget {
  final List<MindMappingInfo> infoList;

  MindMappingContainer(this.infoList);

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
    var measureReact = measureWidthHeightLooper(widget.infoList);

    return SingleChildScrollView(
      controller: _hController,
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        controller: _vController,
        child: Container(
            width: measureReact.width + WIDTH_OFFSET,
            height: measureReact.height + HEIGHT_OFFSET,
            padding: EdgeInsets.only(left: WIDTH_OFFSET/2,top: HEIGHT_OFFSET/2),
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
            child: MindMappingItem(
              info: item.content,
              valueChange: (newValue) {
                setState(() {
                  item.content = newValue;
                });
              },
            )),
      ));

      addChildToList(childViews, item.children);
    });
  }
}
