import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../resource/app_size.dart';
import '../../../resource/constants.dart';

class CardBanner extends StatelessWidget {
  const CardBanner({
    required this.onTap,
    required this.image,
    required this.isLastItem,
    Key? key,
  }) : super(key: key);

  /// [onTap]
  final VoidCallback onTap;

  /// [image]
  final String image;

  /// [isLastItem]
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          right: isLastItem ? Constants.spaceWidth : 8,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: image,
                width: context.sizes.width * 0.8,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => imageLoading(),
                errorWidget: (context, url, error) => imageLoading(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget imageLoading() {
    return AspectRatio(
      aspectRatio: Constants.dimensionImage,
      child: Container(
        color: Colors.black12,
      ),
    );
  }
}
