import 'package:flutter/material.dart';

class FooterPage extends StatelessWidget {
  const FooterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      //decoration: BoxDecoration(
      //  color: Colors.grey.shade200,
      //  border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      //),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Footer
          const Text(
            '© 2026 My Application',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),

          // Right Footer
          const Text(
            'Version 1.0.0',
            style: TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
