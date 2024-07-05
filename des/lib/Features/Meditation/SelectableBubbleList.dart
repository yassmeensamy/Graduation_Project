import 'package:flutter/material.dart';

class SelectableBubbleList extends StatelessWidget {
  final List<String> options;
  final Function(String) onSelected;

  const SelectableBubbleList({super.key, required this.options, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: options.map((option) {
        return GestureDetector(
          onTap: () => onSelected(option),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              elevation: 2.0,
              color: Colors.grey[200],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                child: Text(
                  option,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
