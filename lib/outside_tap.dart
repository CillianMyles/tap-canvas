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

class _TapCanvasState extends State<TapCanvas>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, viewportConstraints) => ConstrainedBox(
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

              final ignorableClicked = boxHitTestResult.path.any((entry) {
                print('entry -> $entry'); // TODO: remove
                return entry.target.runtimeType == IgnorableWidgetRenderBox;
              });
              print('ignorableClicked -> $ignorableClicked'); // TODO: remove

              final focusableClicked = boxHitTestResult.path.any((entry) {
                print('entry -> $entry'); // TODO: remove
                return entry.target.runtimeType == FocusableWidgetRenderBox;
              });
              print('focusableClicked -> $focusableClicked'); // TODO: remove

              final currentFocus = FocusScope.of(context);
              print('currentFocus -> $currentFocus'); // TODO: remove
            },
            child: FocusableWidget(
              child: widget.child,
            ),
          ),
        ),
      );
}

class FocusableWidget extends SingleChildRenderObjectWidget {
  const FocusableWidget({
    @required Widget child,
    Key key,
  })  : assert(child != null),
        super(child: child, key: key);

  @override
  FocusableWidgetRenderBox createRenderObject(BuildContext context) =>
      FocusableWidgetRenderBox();
}

class FocusableWidgetRenderBox extends RenderPointerListener {}

class IgnorableWidget extends SingleChildRenderObjectWidget {
  const IgnorableWidget({
    @required Widget child,
    Key key,
  })  : assert(child != null),
        super(child: child, key: key);

  @override
  IgnorableWidgetRenderBox createRenderObject(BuildContext context) =>
      IgnorableWidgetRenderBox();
}

class IgnorableWidgetRenderBox extends RenderPointerListener {}
