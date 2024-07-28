import 'package:capestone_test/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        strokeCap: StrokeCap.round,
        strokeWidth: 4,
        color: AppPallete.gradient1,
        backgroundColor: AppPallete.gradient2,
      ),
    );
  }
}
