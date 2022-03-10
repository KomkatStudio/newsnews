import 'package:flutter/material.dart';

class AnimatedEffectSize extends StatelessWidget {
  final Widget? child;

  final bool isExpand;

  final Duration sizeDuration;

  final Duration switchDuration;

  final Curve sizeCurve;

  final Curve switchInCurve;

  final Curve switchOutCurve;

  /// Using like AnimatedSwicher but has AnimatedSize
  ///
  /// Example: ```AnimatedEffectSize(child: toggle ? widget1 : widget2)```
  const AnimatedEffectSize({
    Key? key,
    this.isExpand = true,
    this.child,
    this.sizeDuration = const Duration(milliseconds: 500),
    this.switchDuration = const Duration(milliseconds: 500),
    this.sizeCurve = Curves.easeInOut,
    this.switchInCurve = Curves.easeInOut,
    this.switchOutCurve = Curves.easeInOut,
  }) : super(key: key);

  // ignore: use_key_in_widget_constructors
  const AnimatedEffectSize.hide({
    Key? key,
    required this.isExpand,
    this.child,
    this.sizeDuration = const Duration(milliseconds: 500),
    this.switchDuration = const Duration(milliseconds: 500),
    this.sizeCurve = Curves.easeInOut,
    this.switchInCurve = Curves.easeInOut,
    this.switchOutCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    var animatedSize = AnimatedSize(
      duration: sizeDuration,
      curve: Curves.easeInOut,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: isExpand
            ? child
            : SizedBox(
                key: UniqueKey(),
                width: double.infinity,
                height: 0,
              ),
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        layoutBuilder: (currentChild, previousChildren) {
          List<Widget> children = previousChildren;
          if (currentChild != null) {
            if (previousChildren.isEmpty) {
              children = [currentChild];
            } else {
              children = [
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  child: Container(child: previousChildren[0]),
                ),
                Container(child: currentChild),
              ];
            }
          }
          return Stack(
            clipBehavior: Clip.none,
            children: children,
            // alignment: Alignment.center,
          );
        },
      ),
    );
    return ClipRect(
      child: animatedSize,
    );
  }
}
