import 'package:flutter/material.dart';

enum RestType { daily3plus9,daily9, daily11, weekly24, none }
enum MannedType { single, double, none }

class RestAndManedButtons extends StatefulWidget {
  final ValueChanged<RestType> onRestChanged;
  final ValueChanged<MannedType> onMannedChanged;

  const RestAndManedButtons({
    super.key,
    required this.onRestChanged,
    required this.onMannedChanged,
  });

  @override
  State<RestAndManedButtons> createState() => _RestAndManedButtonsState();
}

class _RestAndManedButtonsState extends State<RestAndManedButtons> {
  RestType _selectedRest = RestType.none;
  MannedType _selectedManned = MannedType.none;

  void _selectRest(RestType selection) {
    setState(() {
      _selectedRest = (_selectedRest == selection) ? RestType.none : selection;
    });
    widget.onRestChanged(_selectedRest);
  }

  void _selectManned(MannedType selection) {
    setState(() {
      _selectedManned =
      (_selectedManned == selection) ? MannedType.none : selection;
    });
    widget.onMannedChanged(_selectedManned);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Rest buttons ---
          _buildToggleButton(
            label: '9h',
            isSelected: _selectedRest == RestType.daily9,
            onTap: () => _selectRest(RestType.daily9),
          ),
          _buildToggleButton(
            label: '3+9h',
            isSelected: _selectedRest == RestType.daily3plus9,
            onTap: () => _selectRest(RestType.daily3plus9),
          ),
          _buildToggleButton(
            label: '11h',
            isSelected: _selectedRest == RestType.daily11,
            onTap: () => _selectRest(RestType.daily11),
          ),
          _buildToggleButton(
            label: '24/45h',
            isSelected: _selectedRest == RestType.weekly24,
            onTap: () => _selectRest(RestType.weekly24),
          ),

          // Divider
          Container(
            height: 30,
            width: 1,
            color: Colors.white24,
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),

// --- Manned buttons with icons ---
          _buildToggleButton(
            icon: Icons.person,
            isSelected: _selectedManned == MannedType.single,
            onTap: () => _selectManned(MannedType.single),
          ),
          const SizedBox(width: 8),
          _buildToggleButton(
            icon: Icons.people,
            isSelected: _selectedManned == MannedType.double,
            onTap: () => _selectManned(MannedType.double),
          ),



        ],
      ),
    );
  }

  /// Unified toggle button that supports either `label` or `icon`
  Widget _buildToggleButton({
    String? label,
    IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue[800] : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: label != null
              ? Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight:
              isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          )
              : Icon(
            icon,
            color: isSelected ? Colors.white : Colors.white70,
            size: 24, // ✅ fixed here directly
          ),
        ),
      ),
    );
  }
}