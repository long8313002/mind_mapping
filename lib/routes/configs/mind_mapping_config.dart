import 'package:flutter/cupertino.dart';
import 'package:mindmapping/pagers/base_pager.dart';
import 'package:mindmapping/pagers/mind_mapping/index.dart';

import '../routes.dart';

class MindMappingConfig extends IRoutesConfig {

  @override
  BasePager createPager(
      BuildContext context, Map<String, List<String>> params) {
    return MindMappingPager();
  }

  @override
  String routesPath() {
    return "/mind_mapping";
  }

}