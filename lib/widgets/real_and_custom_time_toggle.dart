import 'package:flutter/material.dart';

// Enum to define the possible states for the time toggle.
enum RealCustomTime { dtReal, dtCustom }

class RealAndCustomTimeToggle extends StatefulWidget {
  // Callback to notify the parent widget when the selection changes.
  final ValueChanged<RealCustomTime> onModeChanged;
  final RealCustomTime initialMode;

  const RealAndCustomTimeToggle({
    super.key,
    required this.onModeChanged,
    this.initialMode = RealCustomTime.dtReal,
  });

  @override
  State<RealAndCustomTimeToggle> createState() =>
      _RealAndCustomTimeToggleState();
}

class _RealAndCustomTimeToggleState extends State<RealAndCustomTimeToggle> {
  late RealCustomTime _selectedMode;

  @override
  void initState() {
    super.initState();
    _selectedMode = widget.initialMode;
  }

  // Toggles the state and calls the parent callback.
  void _handleTap() {
    setState(() {
      _selectedMode = _selectedMode == RealCustomTime.dtReal
          ? RealCustomTime.dtCustom
          : RealCustomTime.dtReal;
      widget.onModeChanged(_selectedMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isRealTime = _selectedMode == RealCustomTime.dtReal;

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 180,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[800], // neutral background
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              // The animated "thumb" that slides back and forth
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment:
                isRealTime ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: 90,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue[800], // selected side
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              // Text + icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildLabel(
                      "LIVE",
                      isRealTime,
                      Icons.access_time,
                    ),
                  ),
                  Expanded(
                    child: _buildLabel(
                      "CUSTOM",
                      !isRealTime,
                      Icons.schedule,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  // A helper to build the text labels with icon.
  Widget _buildLabel(String text, bool isSelected, IconData icon) {
    return Expanded(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
