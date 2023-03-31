import 'package:flutter/material.dart';

class CowWidget extends StatelessWidget {
  const CowWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://media.rawg.io/media/screenshots/c9f/c9f20e71776b841a8b7cf21917a7a15d.jpg',
        ),
      ],
    );
  }
}
