import 'package:flutter/material.dart';

import '../constants/constants.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: buttonColor1,
      child: Icon(Icons.cast_rounded),
      onPressed: () => print("Casting Video"),
    );
  }
}
