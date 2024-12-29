import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Color color;
  final Widget widget;
  final double width;
  final double? height;
  final void Function()? onTap;
  const CommonButton(
      {super.key,
      this.onTap,
      this.height,
      required this.color,
      required this.widget,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(child: widget),
      ),
    );
  }
}
