import 'package:flutter/material.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}