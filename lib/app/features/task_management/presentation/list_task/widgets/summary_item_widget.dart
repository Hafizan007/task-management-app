import 'package:flutter/material.dart';

import '../../../../../config/themes/app_color.dart';
import '../../../../../constants/typograph.dart';

class SummaryItemWidget extends StatelessWidget {
  final String title;
  final String value;

  const SummaryItemWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColor.greyColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Typograph.body14r.copyWith(
                color: AppColor.greyTextColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: Typograph.headline5,
            ),
          ],
        ),
      ),
    );
  }
}
