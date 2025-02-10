import 'package:flutter/material.dart';

import '../../../config/themes/app_color.dart';
import '../../../constants/typograph.dart';

class BigTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int? maxLength;

  const BigTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLength,
  });

  @override
  State<BigTextfield> createState() => _BigTextfieldState();
}

class _BigTextfieldState extends State<BigTextfield> {
  late int currentLength;

  @override
  void initState() {
    super.initState();
    currentLength = widget.controller.text.length;
    widget.controller.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateCharacterCount);
    super.dispose();
  }

  void _updateCharacterCount() {
    setState(() {
      currentLength = widget.controller.text.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextFormField(
                validator: widget.validator,
                controller: widget.controller,
                obscureText: widget.obscureText,
                keyboardType: widget.keyboardType,
                maxLength: widget.maxLength,
                maxLines: 3,
                minLines: 1,
                style: Typograph.headline5.copyWith(color: AppColor.blackColor),
                buildCounter: (context,
                        {required currentLength,
                        required isFocused,
                        maxLength}) =>
                    null,
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                    hintText: widget.labelText,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: Typograph.headline5.copyWith(
                      color: AppColor.blackColor,
                    )),
              ),
            ),
            if (widget.maxLength != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  children: [
                    Text(
                      '$currentLength',
                      style: Typograph.body12r.copyWith(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '/${widget.maxLength}',
                      style: Typograph.body12r
                          .copyWith(color: AppColor.greyTextColor),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const Divider(
          height: 12,
          thickness: 1,
        )
      ],
    );
  }
}
