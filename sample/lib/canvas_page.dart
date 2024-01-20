import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sample/span_detail.dart';
import 'package:arrow_path/arrow_path.dart';
import 'generated/merge_log.pbgrpc.dart';
import 'cpid_page.dart';
import 'package:string_to_color/string_to_color.dart';

class CanvasPage extends StatefulWidget {
  CanvasPage({Key? key, required this.cpid}) : super(key: key);
  final String cpid;

  @override
  _CanvasPageState createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  late Future<List<Span>> _relevantSpans;

  @override
  void initState() {
    super.initState();
    debugPrint("widget.cpig: ${widget.cpid}");
    _relevantSpans = getRelevantSpans(widget.cpid);
  }

  double _tapX = 0.0;
  double _tapY = 0.0;
  bool _isTouching = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flame Graph for \n${widget.cpid}'),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: _relevantSpans,
              builder: ((context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Text("none");
                  case ConnectionState.waiting:
                    return const Text("waiting");
                  case ConnectionState.active:
                    return const Text("active");
                  case ConnectionState.done:
                    if (snapshot.data!.isEmpty) {
                      return Expanded(child: SelectableText('No mergelogs.'));
                    } else {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: GestureDetector(
                            // onTapDown: (details) {
                            //   // print('tapped');
                            //   setState(() {
                            //     _tapPosition = details.localPosition;
                            //   });
                            onPanStart: (details) {
                              setState(() {
                                _tapX = details.localPosition.dx;
                                _tapY = details.localPosition.dy;
                                _isTouching = true;
                              });
                            },
                            onPanUpdate: (details) {
                              setState(() {
                                _tapX = details.localPosition.dx;
                                _tapY = details.localPosition.dy;
                              });
                            },
                            onPanEnd: (details) {
                              setState(() {
                                _isTouching = false;
                              });
                            },
                            child: Container(
                              color: Color.fromARGB(255, 240, 240, 240),
                              child: CustomPaint(
                                painter: MyCanvasView(context, snapshot.data!,
                                    _tapX, _tapY, _isTouching),
                                size: Size(width * 1.01, height * 10.0),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                }
              }),
            ),
          ),
          SizedBox(height: 10),
          // Expanded(
          //   child: SpanDetail(),
          // )
        ],
      ),
    );
  }
}

const spanRectHeight = 30.0;
// const spanRectWidth = 100.0;
const heightPadding = 5.0;
const spanAreaStartX = 200.0;
const radiusCircular = Radius.circular(3.0);

class MyCanvasView extends CustomPainter {
  MyCanvasView(
      this.context, this.spans, this._tapX, this._tapY, this._isTouching);
  final List<Span> spans;
  BuildContext context;
  double _tapX, _tapY;
  bool _isTouching;

  @override
  void paint(Canvas canvas, Size size) {
    // if touching, draw a circle
    if (_isTouching) {
      _tapX = _tapX.clamp(spanAreaStartX, size.width);
      _tapY = _tapY.clamp(0.0, size.height);
    } else {
      _tapX = -30.0;
      _tapY = -30.0;
    }
    canvas.drawCircle(
      Offset(_tapX, _tapY),
      10.0,
      Paint()
        ..color = Colors.red
        ..strokeWidth = 2.0
        ..style = PaintingStyle.fill,
    );

    // left box
    canvas.drawRect(
      Rect.fromLTRB(0.0, 0.0, spanAreaStartX - heightPadding, size.height),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 2.0
        ..style = PaintingStyle.fill,
    );

    // time arrow path
    var path = Path();
    path.moveTo(spanAreaStartX + heightPadding, 10.0);
    path.lineTo(size.width, 10.0);
    path = ArrowPath.addTip(path);

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.grey
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke,
    );

    final spanAreaEndX = size.width - 100.0;
    var lastY = 30.0;
    DateTime firstTime = spans[0].startTime.toDateTime();
    DateTime lastTime = spans[0].endTime.toDateTime();
    // find first and last time
    for (var span in spans) {
      if (span.startTime.toDateTime().isBefore(firstTime)) {
        firstTime = span.startTime.toDateTime();
      }
      if (span.endTime.toDateTime().isAfter(lastTime)) {
        lastTime = span.endTime.toDateTime();
      }
    }

    // draw each span
    for (var span in spans) {
      _drawSpan(
        canvas,
        size,
        firstTime,
        lastTime,
        spanAreaStartX,
        spanAreaEndX,
        lastY + heightPadding,
        span,
      );
      lastY += spanRectHeight + heightPadding;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

void _drawSpan(
  Canvas canvas,
  Size size,
  DateTime firstTime,
  DateTime lastTime,
  double canvasStartX,
  double canvasEndX,
  double spanStartY,
  Span span,
) {
  const sidebarRightMostX = spanAreaStartX - heightPadding;
  // draw color bar derived from service name
  final color = ColorUtils.stringToColor(span.service);
  const colorBarWidth = 5.0;
  canvas.drawRect(
    Rect.fromLTRB(
      sidebarRightMostX - colorBarWidth,
      spanStartY,
      sidebarRightMostX,
      spanStartY + spanRectHeight,
    ),
    Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill,
  );
  // draw span name
  var servicePainter = TextPainter(
    textAlign: TextAlign.start,
    textDirection: TextDirection.ltr,
  );
  servicePainter.text = TextSpan(
    text: span.service,
    style: TextStyle(
      color: Colors.black,
      fontSize: 10.0,
    ),
  );
  servicePainter.layout(maxWidth: spanAreaStartX - heightPadding);
  final servicePosition = Offset(
    sidebarRightMostX - colorBarWidth - 10.0 - servicePainter.size.width,
    spanStartY,
  );
  servicePainter.paint(canvas, servicePosition);
  var messagePainter = TextPainter(
    textAlign: TextAlign.start,
    textDirection: TextDirection.ltr,
  );
  // draw message (function name)
  messagePainter.text = TextSpan(
    text: span.message,
    style: TextStyle(
      color: Colors.black,
      fontSize: 12.0,
    ),
  );
  messagePainter.layout(maxWidth: spanAreaStartX - heightPadding);
  final messagePosition = Offset(
    sidebarRightMostX - colorBarWidth - 10.0 - messagePainter.size.width,
    spanStartY + 15.0,
  );
  messagePainter.paint(canvas, messagePosition);

  // draw span
  final spanStartX = _getXPositionFromTime(
    span.startTime.toDateTime(),
    firstTime,
    lastTime,
    canvasStartX,
    canvasEndX,
  );
  final spanEndX = _getXPositionFromTime(
    span.endTime.toDateTime(),
    firstTime,
    lastTime,
    canvasStartX,
    canvasEndX,
  );

  final spanRect = Rect.fromLTRB(
    spanStartX,
    spanStartY,
    spanEndX,
    spanStartY + spanRectHeight,
  );

  var paint = Paint()
    ..color = Colors.blueGrey
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke;
  canvas.drawRRect(
    RRect.fromRectAndRadius(spanRect, radiusCircular),
    paint,
  );

  // draw span id
  var painter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  painter.text = TextSpan(
    text: 'span id: ${span.spanId.toString()}',
    style: TextStyle(
      color: Colors.black,
      fontSize: 13.0,
    ),
  );
  Offset position = Offset(
    spanStartX + (spanEndX - spanStartX) / 2,
    spanStartY,
  );
  painter.layout();
  painter.paint(canvas, position);

  // draw duration
  var durationPainter = TextPainter(
    textAlign: TextAlign.start,
    textDirection: TextDirection.ltr,
  );
  final durationMilliseconds = span.endTime
      .toDateTime()
      .difference(span.startTime.toDateTime())
      .inMilliseconds
      .toString();
  durationPainter.text = TextSpan(
    text: '$durationMilliseconds ms',
    style: TextStyle(
      color: const Color.fromARGB(255, 120, 120, 120),
      fontSize: 10.0,
    ),
  );
  Offset durationPosition = Offset(
    spanEndX + 3.0,
    spanStartY + 15.0,
  );
  durationPainter.layout();
  durationPainter.paint(canvas, durationPosition);
}

double _getXPositionFromTime(DateTime time, DateTime firstTime,
    DateTime lastTime, double canvasStartX, double canvasEndX) {
  assert(
      canvasStartX < canvasEndX, 'canvasStartX must be less than canvasEndX');
  assert(firstTime.isBefore(lastTime), 'firstTime must be before lastTime');
  final areaWidth = canvasEndX - canvasStartX;
  final timeWidth = lastTime.difference(firstTime).inMilliseconds;

  return canvasStartX +
      time.difference(firstTime).inMilliseconds * areaWidth / timeWidth;
}
