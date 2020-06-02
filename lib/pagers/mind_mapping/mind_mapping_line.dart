import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'mind_mapping_info.dart';

class MindMappingLine extends StatefulWidget {
  final MindMappingLineInfo line;

  MindMappingLine({this.line});

  @override
  State<StatefulWidget> createState() {
    return _MindMappingLineState();
  }
}

class _MindMappingLineState extends State<MindMappingLine> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(line: widget.line),
    );
  }
}

class MyPainter extends CustomPainter {
  final MindMappingLineInfo line;

  MyPainter({this.line});

  ///[定义画笔]
  Paint _paint = Paint()
    ..color = Colors.black12 //画笔颜色
    ..strokeCap = StrokeCap.round //画笔笔触类型
    ..isAntiAlias = true //是否启动抗锯齿
    ..style = PaintingStyle.fill //绘画风格，默认为填充
    ..strokeWidth = 1.0; //画笔的宽度

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(line.start.x, line.start.y),
        Offset(line.end.x, line.end.y), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }


}
