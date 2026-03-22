// import 'package:fl_ferry561_2025/tacho_any_text.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_ferry561_2025/digital_clock_saved_tab.dart';
//
// class UnifiedActivityTab extends StatelessWidget {
//   final DateTime? dateTime;
//   final void Function(DateTime) onSet;
//   final String label;
//   final Color color;
//   final List<List<List<int>>> pictogram;
//   final bool boolDailyRestStarted;
//   final bool showSwitch;
//   final void Function(bool)? onSwitchChanged;
//   final bool? isFirstRestOn;
//   final bool? isRestOnFerryOn;
//
//   const UnifiedActivityTab({
//     super.key,
//     required this.dateTime,
//     required this.onSet,
//     required this.label,
//     required this.color,
//     required this.pictogram,
//     required this.boolDailyRestStarted,
//     this.showSwitch = false,
//     this.onSwitchChanged,
//     this.isFirstRestOn,
//     this.isRestOnFerryOn,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Material(
//             color: Colors.transparent,
//             child: InkWell(
//               onTap: () => onSet(dateTime ?? DateTime.now()),
//               borderRadius: BorderRadius.circular(8),
//               child: Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white24, width: 1),
//                   borderRadius: BorderRadius.circular(8),
//                   color: Colors.grey[900]?.withOpacity(0.3),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Clock Display
//                     DigitalClockRealTime(
//                       staticTime: dateTime,
//                       rectX: 3,
//                       rectY: 3,
//                       elements: pictogram,
//                     ),
//                     const SizedBox(height: 1),
//
//                     // Label Display
//                     if (label.isNotEmpty)
//                       TachoAnyText(
//                         text: label,
//                         rectX: 3,
//                         rectY: 3,
//                         color: color,
//                         slots: 25, // Increased for longer labels
//                       ),
//
//                     // Switch Control (if needed)
//                     if (showSwitch && onSwitchChanged != null) ...[
//                       const SizedBox(height: 12),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'Enable: ',
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 14,
//                             ),
//                           ),
//                           Switch(
//                             value: boolDailyRestStarted,
//                             onChanged: onSwitchChanged!,
//                             activeColor: Colors.teal,
//                             inactiveThumbColor: Colors.grey,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 8),
//
//           // Status Text
//           Text(
//             'Data Enabled: $boolDailyRestStarted',
//             style: TextStyle(
//               fontSize: 18,
//               color: boolDailyRestStarted ? Colors.greenAccent : Colors.redAccent,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }