import 'package:flutter/material.dart';

class StatusFlag extends StatelessWidget {
  final String status;
  const StatusFlag({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    print('StatusFlag build : $status');
    if (status == 'done') {
      return const Icon(
        Icons.check_circle, //favorite,
        color: Colors.green,
        size: 24.0,
        semanticLabel: 'Text to announce in accessibility modes',
      );
    }
    return const Icon(
      Icons.hourglass_top,
      color: Colors.pink,
      size: 24.0,
      semanticLabel: 'Text to announce in accessibility modes',
    );
  }
}
