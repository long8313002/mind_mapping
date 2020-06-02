import 'dart:math';

class MindMappingInfo {
  String content;

  double left;

  double top;

  double width;

  double height;

  List<MindMappingInfo> children = List<MindMappingInfo>();

  List<MindMappingLineInfo> lines = List<MindMappingLineInfo>();

  MindMappingInfo(
      {this.content = "",
      this.left = 0,
      this.top = 0,
      this.width = 0,
      this.height = 0,
      this.children,
      this.lines}) {
    if (children == null) {
      children = List<MindMappingInfo>();
    }
    if (lines == null) {
      lines = List<MindMappingLineInfo>();
    }
  }
}

class MindMappingLineInfo {
  Point<double> start;

  Point<double> end;

  MindMappingLineInfo({this.start, this.end});
}
