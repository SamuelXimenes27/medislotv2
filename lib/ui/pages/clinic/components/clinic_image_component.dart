import 'package:flutter/material.dart';

class ClinicImageComponent extends StatelessWidget {
  final String? image;
  const ClinicImageComponent({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
