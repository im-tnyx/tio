import 'package:flutter/material.dart';
import '../../../../../core/theme/tokens/foundation/dimens.dart';
import '../../../../../core/widgets/typewriter_text.dart';

class NameStepWidget extends StatefulWidget {
  const NameStepWidget({
    required this.name,
    required this.onNameChange,
    required this.onTypingDone,
    super.key,
  });

  final String name;
  final ValueChanged<String> onNameChange;
  final VoidCallback onTypingDone;

  @override
  State<NameStepWidget> createState() => _NameStepWidgetState();
}

class _NameStepWidgetState extends State<NameStepWidget> {
  late final TextEditingController _controller;
  bool _isTitleFinished = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.name);
    if (widget.name.isNotEmpty) {
      _isTitleFinished = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingScreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: Dimens.spaceL),
          if (widget.name.isNotEmpty)
            Text(
              "What's your name?",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            )
          else
            TypewriterText(
              text: "What's your name?",
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              color: theme.colorScheme.onSurface,
              onTypingFinished: () {
                setState(() {
                  _isTitleFinished = true;
                });
                widget.onTypingDone();
              },
            ),
          const SizedBox(height: Dimens.spaceS),
          AnimatedOpacity(
            opacity: _isTitleFinished ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "We use this to personalize your nutrition dashboard.",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: Dimens.spaceM),
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                  onChanged: (val) {
                    if (val.length <= 30) {
                      widget.onNameChange(val);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
