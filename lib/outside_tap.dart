library outside_tap;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (c, viewportConstraints) => ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: viewportConstraints.maxWidth,
            maxHeight: viewportConstraints.maxHeight,
          ),
          child: Listener(
            onPointerUp: (pointerUpEvent) {
              print('*' * 20); // TODO: remove
              print('pointerUpEvent -> $pointerUpEvent'); // TODO: remove
              final renderBox = context.findRenderObject() as RenderBox;
              final boxHitTestResult = BoxHitTestResult();
              renderBox.hitTest(
                boxHitTestResult,
                position: pointerUpEvent.position,
              );

              final ignorableTapped = boxHitTestResult.path.any((entry) {
                print('entry -> $entry'); // TODO: remove
                return entry.target.runtimeType ==
                    TapOutsideDetectorWidgetRenderBox;
              });
              print('ignorableTapped -> $ignorableTapped'); // TODO: remove

              final detectableTapped = boxHitTestResult.path.any((entry) {
                print('entry -> $entry'); // TODO: remove
                return entry.target.runtimeType == TapDetectorWidgetRenderBox;
              });
              print('detectableTapped -> $detectableTapped'); // TODO: remove

              final insideTapped = ignorableTapped;
              final outsideTapped = !ignorableTapped && detectableTapped;
              print('insideTapped -> $insideTapped'); // TODO: remove
              print('outsideTapped -> $outsideTapped'); // TODO: remove

              final currentFocus = FocusScope.of(context);
              print('currentFocus -> $currentFocus'); // TODO: remove

              if (outsideTapped) {
                final widget = TapOutsideDetectorWidget.of(context);
                if (widget != null) {
                  widget.onOutsideTapped();
                } else {
                  print('TapOutsideDetectorWidget == null');
                }
              }
            },
            child: TapDetectorWidget(
              child: widget.child,
            ),
          ),
        ),
      );
}

class TapDetectorWidget extends SingleChildRenderObjectWidget {
  const TapDetectorWidget({
    @required Widget child,
    Key key,
  })  : assert(child != null),
        super(child: child, key: key);

  @override
  TapDetectorWidgetRenderBox createRenderObject(BuildContext context) =>
      TapDetectorWidgetRenderBox();
}

class TapDetectorWidgetRenderBox extends RenderPointerListener {}

class TapOutsideDetectorWidget extends SingleChildRenderObjectWidget {
  const TapOutsideDetectorWidget({
    @required Widget child,
    @required this.onOutsideTapped,
    Key key,
  })  : assert(child != null),
        assert(onOutsideTapped != null),
        super(child: child, key: key);

  static TapOutsideDetectorWidget of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<TapOutsideDetectorWidget>();

  final VoidCallback onOutsideTapped;

  @override
  TapOutsideDetectorWidgetRenderBox createRenderObject(BuildContext context) =>
      TapOutsideDetectorWidgetRenderBox();
}

class TapOutsideDetectorWidgetRenderBox extends RenderPointerListener {}
