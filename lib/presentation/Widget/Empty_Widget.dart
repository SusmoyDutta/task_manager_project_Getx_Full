import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
   EmptyWidget({
    required this.title,
    super.key,
  });
  String title;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(Icons.face_2_sharp),
        ],
      ),
    );
  }
}