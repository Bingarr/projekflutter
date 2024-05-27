import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trashgrab/constants/color.dart';
import 'package:trashgrab/models/item_model.dart';
import 'package:trashgrab/utils/extensions/string_extensions.dart';
import 'package:trashgrab/utils/space_extension.dart';

class BookmarkItem extends StatelessWidget {
  const BookmarkItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ItemModel data;

  @override
  Widget build(BuildContext context) {
    Widget imageChild;
    if (data.image.isEmpty) {
      imageChild = CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[400],
      );
    } else {
      imageChild = CachedNetworkImage(
        imageUrl: data.image,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            radius: 30,
            backgroundImage: imageProvider,
          );
        },
        progressIndicatorBuilder: (context, url, progress) {
          return CircleAvatar(
            backgroundColor: Colors.grey[400],
            radius: 30,
          );
        },
        errorWidget: (context, url, error) {
          return CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[400],
          );
        },
      );
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black38),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageChild,
          15.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.nama,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  data.harga.formatNumber(),
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
          ),
          15.horizontalSpace,
          Text(
            '${data.totalItem}x',
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
