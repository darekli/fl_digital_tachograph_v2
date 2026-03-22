import 'package:flutter/material.dart';

class UpDownButtons extends StatefulWidget {
  final void Function(int index) onIndexChanged;
  final VoidCallback onNextTab;
  final VoidCallback onResetTime;
  final int maxIndex; // 🔹 number of labels (e.g. 4)

  const UpDownButtons({
    super.key,
    required this.onIndexChanged,
    required this.onNextTab,
    required this.onResetTime,
    this.maxIndex = 2, // default for backward compatibility
  });

  @override
  State<UpDownButtons> createState() => _UpDownButtonsState();
}

class _UpDownButtonsState extends State<UpDownButtons> {
  int _index = 0;

  void _adjustIndex(int step) {
    setState(() {
      _index = (_index + step) % widget.maxIndex;
      if (_index < 0) _index = widget.maxIndex - 1;
    });
    widget.onIndexChanged(_index);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_circle_up, size: 32),
          onPressed: () => _adjustIndex(-1),
          tooltip: 'Previous label',
          color: Colors.white,
        ),
        const SizedBox(width: 32),
        IconButton(
          icon: const Icon(Icons.arrow_circle_down, size: 32),
          onPressed: () => _adjustIndex(1),
          tooltip: 'Next label',
          color: Colors.white,
        ),
        const SizedBox(width: 32),
        // IconButton(
        //   icon: const Icon(Icons.timer_off_outlined, size: 32),
        //   onPressed: widget.onNextTab,
        //   tooltip: 'Next tab',
        //   color: Colors.white,
        // ),
        // const SizedBox(width: 32),
        // IconButton(
        //   icon: const Icon(Icons.restart_alt, size: 32),
        //   onPressed: widget.onResetTime,
        //   tooltip: 'Reset time',
        //   color: Colors.white,
        // ),
      ],
    );
  }
}
