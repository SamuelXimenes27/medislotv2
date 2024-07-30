import 'package:flutter/material.dart';

class BadgeVideo extends StatelessWidget {
  const BadgeVideo({
    Key? key,
    required this.isVideoAvailable,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  final bool isVideoAvailable;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(2, 2),
            color: Colors.black.withOpacity(0.1),
          ),
          BoxShadow(
            blurRadius: 5,
            offset: const Offset(-2, -2),
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          'lib/ui/assets/imgs/icon_video.png',
          height: 16,
          color: isVideoAvailable ? Colors.yellow : Colors.grey,
        ),
      ),
    );
  }
}
