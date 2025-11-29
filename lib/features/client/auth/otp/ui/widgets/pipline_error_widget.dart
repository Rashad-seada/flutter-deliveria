import 'package:flutter/material.dart';

Widget pipelineErrorWidget(String error) {
  return Container(
    margin: const EdgeInsets.only(top: 18, bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.red.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.red.shade300),
    ),
    child: Row(
      children: [
        Icon(Icons.error, color: Colors.red.shade800),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            error,
            style: TextStyle(
              color: Colors.red.shade900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
