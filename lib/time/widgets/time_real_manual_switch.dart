import 'package:flutter/material.dart';

/// 🔹 Defines the possible time/rest types.
enum TimeType { none, timeLive, timeCustom }

class TimeAutoManualButtons extends StatefulWidget {
  final ValueChanged<TimeType> onTimeChanged;

  const TimeAutoManualButtons({
    super.key,
    required this.onTimeChanged,
  });

  @override
  State<TimeAutoManualButtons> createState() => _TimeAutoManualButtonsState();
}

class _TimeAutoManualButtonsState extends State<TimeAutoManualButtons> {
  TimeType _selectedTimeType = TimeType.none;

  void _selectTime(TimeType selection) {
    setState(() {
      // Tap again → deselect
      _selectedTimeType =
      (_selectedTimeType == selection) ? TimeType.none : selection;
    });
    widget.onTimeChanged(_selectedTimeType);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildToggleButton(
            label: 'Live Clock',
            icon: Icons.access_time, // ⏰
            isSelected: _selectedTimeType == TimeType.timeLive,
            onTap: () => _selectTime(TimeType.timeLive),
          ),
          _buildToggleButton(
            label: 'Custom Time',
            icon: Icons.timer, // ✏️
            isSelected: _selectedTimeType == TimeType.timeCustom,
            onTap: () => _selectTime(TimeType.timeCustom),
          ),
        ],
      ),
    );
  }

  /// 🔹 Reusable toggle button builder with icon + text
  Widget _buildToggleButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.blueAccent : Colors.white24,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : Colors.white70,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
