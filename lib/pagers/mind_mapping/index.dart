import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindmapping/pagers/base_pager.dart';

import 'mind_mapping_container.dart';
import 'mind_mapping_info.dart';
import 'mind_mapping_layout.dart';

class MindMappingPager extends BasePager {
  ILayout layout =
      MindMappingLayout(leftOffset: 30, topOffset: 15, width: 100, height: 30);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget createContent(BuildContext context) {
    return Scaffold(
      body: MindMappingContainer(createInfoList(), layout),
    );
  }

  @override
  String title() {
    return "思维导图";
  }

  List<MindMappingInfo> createInfoList() {
    var infoList = <MindMappingInfo>[];
    infoList.add(MindMappingInfo(content: "思维导图",));

    layout.layout(infoList);

    return infoList;
  }
}
