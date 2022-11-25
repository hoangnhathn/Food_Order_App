import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(
            color: Colors.deepOrangeAccent,
          ),
        ),
      ),
    );
  }
}
