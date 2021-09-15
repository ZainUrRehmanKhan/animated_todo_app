import 'package:flutter/cupertino.dart';
import 'package:todo_app/src/utils/utils.dart';

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: AppUtils.colorList,
        tileMode: TileMode.mirror,
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(bounds),
      child: child,
    );
  }
}