library outside_tap;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TapWatcher extends StatefulWidget {
  const TapWatcher({
    @required this.child,
    @required this.onOutsideTapped,
    Key key,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onOutsideTapped;

  @override
  _TapWatcherState createState() => _TapWatcherState();
}

class _TapWatcherState extends State<TapWatcher>
    with SingleTickerProviderStateMixin {
  final Offset defaultOffset = const Offset(0, 0);
  double pageY = 0;
  double reverseFrom = 0;
  double textFieldBottom = 0;
  RenderBox lastRenderBox;

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
              final renderBox = context.findRenderObject() as RenderBox;
              final boxHitTestResult = BoxHitTestResult();
              renderBox.hitTest(
                boxHitTestResult,
                position: pointerUpEvent.position,
              );

              // if there any widget in the path that must ignore taps,
              // stop it right here
              if (boxHitTestResult.path.any((entry) =>
                  entry.target.runtimeType == OutsideTapIgnorerRenderBox)) {
                return;
              }

              final isEditable = boxHitTestResult.path.any((entry) =>
                  entry.target.runtimeType == RenderEditable ||
                  entry.target.runtimeType == RenderParagraph ||
                  entry.target.runtimeType == OutsideTapWatcherRenderBox);

              final currentFocus = FocusScope.of(context);
              if (!isEditable) {
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                  lastRenderBox = null;
                }
              } else {
                for (final entry in boxHitTestResult.path) {
                  final isEditable = entry.target.runtimeType ==
                          RenderEditable ||
                      entry.target.runtimeType == RenderParagraph ||
                      entry.target.runtimeType == OutsideTapWatcherRenderBox;

                  if (isEditable) {
                    final renderBox = entry.target as RenderBox;
                    final offset = renderBox.localToGlobal(defaultOffset);
                    textFieldBottom = offset.dy + renderBox.size.height - pageY;
                    if (lastRenderBox != renderBox) {
                      setState(() {});
                      lastRenderBox = renderBox;
                    }
                  }
                }
              }
            },
            child: widget.child,
          ),
        ),
      );
}

class OutsideTapWatcher extends SingleChildRenderObjectWidget {
  const OutsideTapWatcher({
    @required Widget child,
    Key key,
  })  : assert(child != null),
        super(child: child, key: key);

  @override
  OutsideTapWatcherRenderBox createRenderObject(BuildContext context) =>
      OutsideTapWatcherRenderBox();
}

class OutsideTapWatcherRenderBox extends RenderPointerListener {}

class OutsideTapIgnorer extends SingleChildRenderObjectWidget {
  const OutsideTapIgnorer({
    @required Widget child,
    Key key,
  })  : assert(child != null),
        super(child: child, key: key);

  @override
  OutsideTapIgnorerRenderBox createRenderObject(BuildContext context) =>
      OutsideTapIgnorerRenderBox();
}

class OutsideTapIgnorerRenderBox extends RenderPointerListener {}
