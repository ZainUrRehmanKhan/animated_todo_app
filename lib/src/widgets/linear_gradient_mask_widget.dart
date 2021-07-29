import 'package:flutter/cupertino.dart';

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({this.child, this.colorList});
  final List<Color> colorList;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: colorList,
        tileMode: TileMode.mirror,
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(bounds),
      child: child,
    );
  }
}