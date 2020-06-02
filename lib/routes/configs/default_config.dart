import 'package:flutter/cupertino.dart';
import 'package:mindmapping/pagers/base_pager.dart';
import 'package:mindmapping/pagers/home.dart';

import '../routes.dart';

class DefaultRouteConfig extends IRoutesConfig {

  @override
  BasePager createPager(BuildContext context, Map<String, List<String>> params) {
    return HomePager();
  }

  @override
  String routesPath() {
    return "/";
  }

}