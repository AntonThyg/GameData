import 'package:flutter/material.dart';

class CowWidget extends StatelessWidget {
  const CowWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'images/cow.jpg',
        ),
      ],
    );
  }
}
