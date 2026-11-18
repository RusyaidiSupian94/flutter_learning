import 'package:flutter/material.dart';

import 'header_page.dart';
import 'footer_page.dart';

class TestHomePage extends StatelessWidget {
  const TestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderPage(),
          Expanded(child: Center(child: Text('TestHomePage'))),
          const FooterPage(),
        ],
      ),
    );
  }
}
