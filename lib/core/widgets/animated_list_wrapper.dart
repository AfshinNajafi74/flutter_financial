import 'package:flutter/material.dart';

class AnimatedListWrapper extends StatefulWidget {
  const AnimatedListWrapper({super.key,required this.child, required this.index});
  final Widget child;
  final int index;

  @override
  State<AnimatedListWrapper> createState() => _AnimatedListWrapperState();
}

class _AnimatedListWrapperState extends State<AnimatedListWrapper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 300 * (widget.index)),vsync: this,);
    _animation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset(0, 0)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
