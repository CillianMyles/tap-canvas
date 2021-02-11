import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tap_canvas/src/tap_offset_provider.dart';
import 'package:tap_canvas/src/tap_outside_detector_widget.dart';

/// [TapCanvas] represents the area on which taps are tracked, in order to
/// determine taps outside widgets like [TapOutsideDetectorWidget]. In
/// general it makes sense to put this widget as high up the widget tree as
/// possible, but it could be added anywhere above [TapOutsideDetectorWidget],
/// such that it could lower the area of "taps outside" tracking.
class TapCanvas extends StatefulWidget {
  const TapCanvas({
    @required this.child,
    Key key,
  }) : super(key: key);

  final Widget child;

  @override
  _TapCanvasState createState() => _TapCanvasState();
}

class _TapCanvasState extends State<TapCanvas> {
  final StreamController<Offset> _tapOffsetController =
      StreamController<Offset>.broadcast();

  @override
  void dispose() {
    _tapOffsetController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TapOffsetProvider(
        stream: _tapOffsetController.stream,
        child: LayoutBuilder(
          builder: (c, viewportConstraints) => ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: viewportConstraints.maxWidth,
              maxHeight: viewportConstraints.maxHeight,
            ),
            child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerUp: (event) {
                _tapOffsetController.add(event.position);
              },
              child: widget.child,
            ),
          ),
        ),
      );
}
