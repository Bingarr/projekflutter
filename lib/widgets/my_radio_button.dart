import 'package:flutter/material.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/utils/extensions/tap_extension.dart';
import 'package:trashgrab/utils/space_extension.dart';

class MyRadioButton extends StatelessWidget {
  const MyRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.tap,
    this.valueText,
  }) : super(key: key);

  final String value;
  final String groupValue;
  final String? valueText;
  final void Function() tap;

  @override
  Widget build(BuildContext context) {
    bool selected = value == groupValue;

    return Row(
      children: [
        if (selected) ...[
          Container(
            height: 16,
            width: 16,
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              border: Border.all(
                color: kPrimaryColor.withOpacity(0.6),
              ),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ] else ...[
          Container(
            height: 16,
            width: 16,
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black45,
                width: 1.5,
              ),
              shape: BoxShape.circle,
            ),
          ),
        ],
        5.horizontalSpace,
        Text(
          valueText ?? value,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        10.horizontalSpace,
      ],
    ).extCupertino(onTap: tap);
  }
}
