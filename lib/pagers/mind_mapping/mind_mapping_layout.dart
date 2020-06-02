import 'dart:math';
import 'dart:ui';

import 'mind_mapping_info.dart';

abstract class ILayout {
  void layout(List<MindMappingInfo> infoList);

  int getLines(MindMappingInfo item);
}

Rect measureWidthHeight(List<MindMappingInfo> infoList) {
  double left = 0;
  double top = 0;
  double right = 0;
  double bottom = 0;

  infoList.forEach((item) {
    left = min(item.left, left);
    right = max(item.left + item.width, right);
    top = min(item.top, top);
    bottom = max(item.top + item.height, bottom);
  });

  return Rect.fromLTRB(left, top, right, bottom);
}

Rect measureWidthHeightLooper(List<MindMappingInfo> infoList) {
  double left = 0;
  double top = 0;
  double right = 0;
  double bottom = 0;

  List<MindMappingInfo> tempInfoList = []..addAll(infoList);

  while (tempInfoList != null && tempInfoList.isNotEmpty) {
    List<MindMappingInfo> tempChildInfoList = [];

    tempInfoList.forEach((item) {
      left = min(item.left, left);
      right = max(item.left + item.width, right);
      top = min(item.top, top);
      bottom = max(item.top + item.height, bottom);

      if (item.children != null && item.children.isNotEmpty) {
        tempChildInfoList.addAll(item.children);
      }
    });

    tempInfoList = tempChildInfoList;
  }

  return Rect.fromLTRB(left, top, right, bottom);
}

void _changeWidthHeight(MindMappingInfo item, final double width,
    final double height, final int length) {
  if (item.content.length < length) {
    item.width = width;
  } else {
    item.width = width * 2;
  }

  if (item.content.length > length * 2) {
    item.height = height * 2;
  } else {
    item.height = height;
  }
}

class MindMappingLayout implements ILayout {
  final double leftOffset;

  final double topOffset;

  final double width;

  final double height;

  static const int LINE_EMS = 8;

  MindMappingLayout(
      {this.leftOffset = 0,
      this.topOffset = 0,
      this.width = 30,
      this.height = 10});

  @override
  void layout(List<MindMappingInfo> infoList) {
    assert(infoList != null);

    layoutWithLeft(infoList, 0, 0);

    layoutToCenter(infoList);

    layoutLines(infoList);
  }

  void layoutWithLeft(List<MindMappingInfo> infoList, double left, double top) {
    if (infoList == null || infoList.isEmpty) {
      return;
    }

    double preTop = top;

    infoList.forEach((item) {
      item.left = left;
      item.top = top;

      _changeWidthHeight(item, width, height, LINE_EMS);

      top += item.height+topOffset;

      layoutWithLeft(item.children, left + item.width + leftOffset, preTop);

      if (item.children != null && item.children.length > 0) {
        var childItem = item.children[item.children.length - 1];
        preTop = childItem.top + topOffset+childItem.height;
      }
    });
  }

  void layoutToCenter(List<MindMappingInfo> infoList) {
    var measureRect = measureWidthHeightLooper(infoList);

    var tempInfoList = <MindMappingInfo>[]..addAll(infoList);

    while (tempInfoList != null && tempInfoList.isNotEmpty) {
      var tempChildInfoList = <MindMappingInfo>[];

      double height = measureWidthHeight(tempInfoList).height;

      tempInfoList.forEach((item) {
        item.top += (measureRect.height - height) / 2;

        if (item.children != null && item.children.isNotEmpty) {
          tempChildInfoList.addAll(item.children);
        }
      });

      tempInfoList = tempChildInfoList;
    }
  }

  void layoutLines(List<MindMappingInfo> infoList) {
    List<MindMappingInfo> childrenInfoList = <MindMappingInfo>[];

    infoList.forEach((item) {
      item.lines = List();

      Point<double> startPoint =
          Point(item.left + item.width, item.top + item.height);

      if (item.children == null || item.children.isEmpty) {
        return;
      }

      childrenInfoList.addAll(item.children);

      item.children.forEach((childItem) {
        Point<double> endPoint =
            Point(childItem.left, childItem.top + childItem.height);

        item.lines.add(MindMappingLineInfo(start: startPoint, end: endPoint));
      });
    });

    if (childrenInfoList.isNotEmpty) {
      layoutLines(childrenInfoList);
    }
  }

  @override
  int getLines(MindMappingInfo item) {
    return item.content.length > LINE_EMS * 2 ? 2 : 1;
  }
}
