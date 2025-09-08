import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  final String text;
  final String query;
  final double fontSize;

  const HighlightText({
    super.key,
    required this.text,
    required this.query,
    this.fontSize = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    if (query.isEmpty) {
      return Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: fontSize),
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');
    final startIndex = lowerText.indexOf(lowerQuery);

    if (startIndex == -1) {
      return Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: fontSize),
      );
    }

    final endIndex = startIndex + query.length;

    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: TextStyle(fontSize: fontSize, color: Colors.black),
        children: [
          TextSpan(text: text.substring(0, startIndex)),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
          TextSpan(text: text.substring(endIndex)),
        ],
      ),
    );
  }
}
