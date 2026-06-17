import 'dart:async';
import 'package:flutter/material.dart';

class TypewriterText extends StatefulWidget {
  const TypewriterText({
    required this.text,
    required this.style,
    required this.color,
    this.typingDelayMs = 40,
    required this.onTypingFinished,
    this.textAlign = TextAlign.start,
    super.key,
  });

  final String text;
  final TextStyle? style;
  final Color color;
  final int typingDelayMs;
  final VoidCallback onTypingFinished;
  final TextAlign textAlign;

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  @override
  void didUpdateWidget(TypewriterText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _timer?.cancel();
      _displayedText = '';
      _startTyping();
    }
  }

  void _startTyping() {
    if (widget.text.isEmpty) {
      widget.onTypingFinished();
      return;
    }

    int index = 0;
    _timer = Timer.periodic(Duration(milliseconds: widget.typingDelayMs), (timer) {
      if (index < widget.text.length) {
        if (mounted) {
          setState(() {
            _displayedText += widget.text[index];
          });
        }
        index++;
      } else {
        _timer?.cancel();
        widget.onTypingFinished();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: widget.style?.copyWith(color: widget.color),
      textAlign: widget.textAlign,
    );
  }
}
