import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

Widget lineWithText({required String text, required BuildContext context}) {
  return Row(children: [
    Expanded(child: lineDivider()),
    Text(
      text,
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    Expanded(child: lineDivider()),
  ]);
}

lineDivider() {
  return Divider(
    thickness: 1,
    color: AppColors.lineColor.withOpacity(0.5),
    indent: 8,
  );
}
