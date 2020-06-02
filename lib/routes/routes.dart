import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mindmapping/pagers/base_pager.dart';
import 'package:mindmapping/routes/configs/default_config.dart';
import 'package:mindmapping/routes/configs/home_config.dart';
import 'package:mindmapping/routes/configs/mind_mapping_config.dart';

abstract class IRoutesConfig {
  static Router router;

  String routesPath();

  BasePager createPager(BuildContext context, Map<String, List<String>> params);

  TransitionType transition() {
    return TransitionType.inFromRight;
  }

  void jumpTo(BuildContext context) {
    router.navigateTo(context, routesPath(), transition: transition());
  }
}

class _RoutesConfigFactory {
  static final routesConfigList = List<IRoutesConfig>();

  static List<IRoutesConfig> getConfigs() {
    routesConfigList.add(HomeRouteConfig());
    routesConfigList.add(DefaultRouteConfig());
    routesConfigList.add(MindMappingConfig());
    return routesConfigList;
  }
}

class Routes {
  static bool _hasInit = false;

  static void init(Router router) {
    assert(_hasInit == false);
    var configs = _RoutesConfigFactory.getConfigs();
    IRoutesConfig.router = router;
    configs.forEach((item) {
      router.define(item.routesPath(), handler: Handler(handlerFunc:
          (BuildContext context, Map<String, List<String>> params) {
        return item.createPager(context, params);
      }));
    });

    _hasInit = true;
  }
}
