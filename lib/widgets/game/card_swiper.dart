import 'dart:math';
import 'package:flutter/material.dart';

class CustomCardSwiperController {
  _CustomCardSwiperState? _state;

  void _attach(_CustomCardSwiperState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  void triggerLeft() {
    _state?.swipeLeft();
  }

  void triggerRight() {
    _state?.swipeRight();
  }
}

enum SwipeDirection { left, right }

class CustomCardSwiper extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final Function(SwipeDirection direction, int index)? onSwipe;
  final CustomCardSwiperController? controller;

  const CustomCardSwiper({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.onSwipe,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomCardSwiper> createState() => _CustomCardSwiperState();
}

class _CustomCardSwiperState extends State<CustomCardSwiper>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  Offset _dragOffset = Offset.zero;
  late AnimationController _animController;
  Animation<Offset>? _slideAnimation;
  SwipeDirection? _swipeDirection;

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_swipeDirection != null) {
          final swipedIndex = _currentIndex;
          widget.onSwipe?.call(_swipeDirection!, swipedIndex);
          setState(() {
            _currentIndex++;
            _dragOffset = Offset.zero;
            _swipeDirection = null;
          });
          _animController.reset();
        }
      }
    });
  }

  @override
  void didUpdateWidget(CustomCardSwiper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?._detach();
      widget.controller?._attach(this);
    }
  }

  @override
  void dispose() {
    widget.controller?._detach();
    _animController.dispose();
    super.dispose();
  }

  void swipeLeft() {
    if (_currentIndex >= widget.itemCount || _animController.isAnimating) return;
    _swipeDirection = SwipeDirection.left;
    final screenWidth = MediaQuery.of(context).size.width;
    _slideAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset(-screenWidth * 1.5, _dragOffset.dy),
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward(from: 0);
  }

  void swipeRight() {
    if (_currentIndex >= widget.itemCount || _animController.isAnimating) return;
    _swipeDirection = SwipeDirection.right;
    final screenWidth = MediaQuery.of(context).size.width;
    _slideAnimation = Tween<Offset>(
      begin: _dragOffset,
      end: Offset(screenWidth * 1.5, _dragOffset.dy),
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward(from: 0);
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_currentIndex >= widget.itemCount || _animController.isAnimating) return;
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_currentIndex >= widget.itemCount || _animController.isAnimating) return;
    const threshold = 100.0;

    if (_dragOffset.dx > threshold || details.velocity.pixelsPerSecond.dx > 500) {
      swipeRight();
    } else if (_dragOffset.dx < -threshold || details.velocity.pixelsPerSecond.dx < -500) {
      swipeLeft();
    } else {
      // Snap back to center
      setState(() {
        _dragOffset = Offset.zero;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentIndex >= widget.itemCount) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 440,
      child: AnimatedBuilder(
        animation: _animController,
        builder: (context, child) {
          final currentOffset = _animController.isAnimating
              ? (_slideAnimation?.value ?? _dragOffset)
              : _dragOffset;

          final rotationAngle = (currentOffset.dx / 300.0) * (pi / 12);

          List<Widget> cards = [];

          // Show next card behind top card
          if (_currentIndex + 1 < widget.itemCount) {
            cards.add(
              Positioned.fill(
                child: Transform.scale(
                  scale: 0.95,
                  child: widget.itemBuilder(context, _currentIndex + 1),
                ),
              ),
            );
          }

          // Top card with drag & rotation
          cards.add(
            Positioned.fill(
              child: GestureDetector(
                onPanUpdate: _onPanUpdate,
                onPanEnd: _onPanEnd,
                child: Transform.translate(
                  offset: currentOffset,
                  child: Transform.rotate(
                    angle: rotationAngle,
                    child: widget.itemBuilder(context, _currentIndex),
                  ),
                ),
              ),
            ),
          );

          return Stack(
            children: cards,
          );
        },
      ),
    );
  }
}
