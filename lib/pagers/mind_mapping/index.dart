import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindmapping/pagers/base_pager.dart';

import 'mind_mapping_container.dart';
import 'mind_mapping_info.dart';

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
    infoList.add(MindMappingInfo(content: "思维导图",));
    return infoList;
  }
}
