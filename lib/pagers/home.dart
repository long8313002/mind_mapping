import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindmapping/pagers/base_pager.dart';
import 'package:mindmapping/routes/configs/mind_mapping_config.dart';

class HomePager extends BasePager {

  String titles = "ZZZZZ";

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 3000),(){

      setState((){
        titles = "AAAAAAAA";
      });

    });
  }

  @override
  Widget createContent(BuildContext context) {
    return Center(
        child: FloatingActionButton(
      child: Text(titles),
      onPressed: () {
        MindMappingConfig().jumpTo(context);
      },
    ));
  }

  @override
  String title() {
    return "Home";
  }
}
