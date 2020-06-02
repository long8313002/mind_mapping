import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindmapping/pagers/base_pager.dart';

import 'mind_mapping_container.dart';
import 'mind_mapping_info.dart';
import 'mind_mapping_layout.dart';

class MindMappingPager extends BasePager {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget createContent(BuildContext context) {
    return Scaffold(
      body: MindMappingContainer(createInfoList()),
    );
  }

  @override
  String title() {
    return "思维导图";
  }


  List<MindMappingInfo> createInfoList() {
    var infoList = <MindMappingInfo>[];
    infoList.add(MindMappingInfo(content: "11111", children: [
      MindMappingInfo(content: "22222", children: [
        MindMappingInfo(content: "1"),
        MindMappingInfo(content: "2"),
        MindMappingInfo(content: "3"),
        MindMappingInfo(content: "4"),
        MindMappingInfo(content: "5"),
        MindMappingInfo(content: "6")
      ]),
      MindMappingInfo(content: "33333", children: [
        MindMappingInfo(content: "7777777"),
        MindMappingInfo(content: "a"),
        MindMappingInfo(content: "s"),
        MindMappingInfo(content: "d"),
        MindMappingInfo(content: "f"),
        MindMappingInfo(content: "g")
      ]),
      MindMappingInfo(content: "44444")
    ]));

    MindMappingLayout(leftOffset: 100, topOffset: 40, width: 80, height: 30)
        .layout(infoList);

    return infoList;
  }

}
