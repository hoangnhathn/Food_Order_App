import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../resource/app_size.dart';
import '../../../../resource/app_text_styles.dart';
import '../../../../resource/constants.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    required this.urlBackground,
    required this.title,
    required this.onLeftTap,
    required this.buildBody,
    Key? key,
  }) : super(key: key);

  /// [title]
  final String title;

  /// [urlBackground]
  final String urlBackground;

  /// [onLeftTap]
  final VoidCallback onLeftTap;

  /// [buildBody] body of sliver appbar
  final Widget buildBody;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(
                title: title,
                urlBackground: urlBackground,
                expandedHeight:
                    context.sizes.width * (1 / Constants.dimensionImage),
                onLeftTap: onLeftTap,
              ),
              pinned: true,
            ),
            buildBody,
          ],
        ),
      );
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  const CustomSliverAppBarDelegate({
    required this.urlBackground,
    required this.title,
    required this.expandedHeight,
    required this.onLeftTap,
  });

  ///
  final String title;

  /// [urlBackground]
  final String urlBackground;

  ///
  final VoidCallback onLeftTap;

  /// [expandedHeight]
  final double expandedHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Stack(
      fit: StackFit.expand,
      children: [
        buildBackground(shrinkOffset),
        buildAppBar(shrinkOffset),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset) => Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: onLeftTap,
            child: Container(
              margin: const EdgeInsets.only(
                left: 10,
              ),
              height: 16,
              padding: const EdgeInsets.all(3),
              child: Image.asset(
                Assets.images.icBackBlack.path,
                height: 10,
                width: 10,
              ),
            ),
          ),
          title: Text(
            title,
            style: AppTextStyles.fontPoppinsRegular15.copyWith(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
      );

  Widget buildBackground(double shrinkOffset) => Opacity(
        opacity: disappear(shrinkOffset),
        child: Image.network(
          urlBackground,
          fit: BoxFit.cover,
        ),
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
