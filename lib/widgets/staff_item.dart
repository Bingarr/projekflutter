import 'package:flutter/material.dart';
import 'package:trashgrab/utils/extensions/tap_extension.dart';
import 'package:trashgrab/utils/space_extension.dart';

class StaffItem extends StatelessWidget {
  const StaffItem({
    Key? key,
    required this.name,
    required this.platNumber,
    required this.tapEdit,
    required this.tapDelete,
  }) : super(key: key);

  final String name;
  final String platNumber;
  final Function() tapEdit;
  final Function() tapDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(name[0]),
        ),
        title: Text(
          name,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(platNumber),
        trailing: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.edit_square,
              size: 30,
              color: Colors.amber[700],
            ).extCupertino(onTap: tapEdit),
            15.horizontalSpace,
            const Icon(
              Icons.remove_circle_rounded,
              size: 30,
              color: Colors.red,
            ).extCupertino(onTap: tapDelete),
          ],
        ),
      ),
    );
  }
}
