
import 'package:flutter/material.dart';

import '../pictograms/tacho_chars.dart';

class TachoTextUTC extends StatefulWidget {
  final String text;
  final double rectX;
  final double rectY;
  final Color color;
  final int slots; // visible symbols
  final int leadingEmptySlots;

  const TachoTextUTC({
    super.key,
    required this.text,
    this.rectX = 2,
    this.rectY = 2,
    this.color = Colors.white,
    this.slots = 12,
    this.leadingEmptySlots = 0,
  });

  @override
  State<TachoTextUTC> createState() => _TachoTextUTCState();
}

class _TachoTextUTCState extends State<TachoTextUTC> {
  late List<List<List<int>>> _symbols;

  @override
  void initState() {
    super.initState();
    _symbols = _buildSymbols(widget.text);
  }

  @override
  void didUpdateWidget(covariant TachoTextUTC oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      setState(() {
        _symbols = _buildSymbols(widget.text);
      });
    }
  }

  // Converts the input text string into a list of 7x5 symbol grids.
  List<List<List<int>>> _buildSymbols(String text) {
    final list = List<List<List<int>>>.generate(
      widget.leadingEmptySlots,
      (_) => TachoChars.empty,
      growable: true,
    );
    for (var ch in text.characters) {
      final grid = TachoChars.tachoChars(ch);
      if (grid != null) list.add(grid);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (int i = 0; i < widget.slots; i++) {
      final grid = (i < _symbols.length) ? _symbols[i] : null;

      children.add(
        Container(
          padding: const EdgeInsets.all(2),
          color: Colors.grey[900],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int row = 0; row < 7; row++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int col = 0; col < 5; col++)
                      Container(
                        width: widget.rectX,
                        height: widget.rectY,
                        margin: const EdgeInsets.all(0.5),
                        color: (grid != null && grid[row][col] == 1)
                            ? widget.color
                            : Colors.black,
                      ),
                  ],
                ),
            ],
          ),
        ),
      );

      if (i < widget.slots - 1) {
        children.add(const SizedBox(width: 1));
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

}
