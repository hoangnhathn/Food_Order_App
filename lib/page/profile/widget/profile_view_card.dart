import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common_widgets/space_box.dart';
import '../../../resource/app_size.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';

class ProfileOverViewCard extends StatelessWidget {
  const ProfileOverViewCard({
    required this.orderCount,
    required this.cartCount,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  /// orderCount
  final int orderCount;

  /// [cartCount]
  final int cartCount;

  /// [onTap]
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: context.sizes.width / 8,
              right: Constants.spaceWidth,
              left: Constants.spaceWidth,
            ),
            padding: EdgeInsets.only(
              top: context.sizes.width / 8,
              left: Constants.spaceWidth,
              right: Constants.spaceWidth,
            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'User',
                  style: AppTextStyles.fontPoppinsBold16.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  'user@gmail.com',
                  style: AppTextStyles.fontPoppinsRegular14.copyWith(
                    color: Colors.white60,
                  ),
                ),
                const SpaceBox.height(15),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: textLabel(
                            AppLocalizations.of(context)!.termTotal,
                            textAlign: TextAlign.start,
                            color: Colors.lightBlue,
                          ),
                        ),
                        Expanded(
                          child: textLabel(
                            cartCount.toString(),
                            color: Colors.lightBlue,
                            fontSize: 16,
                            isBoldText: true,
                          ),
                        ),
                        Expanded(
                          child: textLabel(
                            orderCount.toString(),
                            color: Colors.lightBlue,
                            fontSize: 16,
                            isBoldText: true,
                          ),
                        )
                      ],
                    ),
                    const SpaceBox.height(),
                    Row(
                      children: [
                        Expanded(
                          child: textLabel(
                            AppLocalizations.of(context)!.termMonth,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    const SpaceBox.height(),
                    Row(
                      children: [
                        Expanded(
                          child: textLabel(
                            AppLocalizations.of(context)!.termYear,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Expanded(
                          child: textLabel(
                            AppLocalizations.of(context)!.cartTerm,
                          ),
                        ),
                        Expanded(
                          child: textLabel(
                            AppLocalizations.of(context)!.orderTerm,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SpaceBox.height(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CachedNetworkImage(
              imageUrl:
                  'https://scontent.fhan2-5.fna.fbcdn.net/v/t39.30808-1/312657397_1757227781317976_4264145091301170904_n.jpg?stp=dst-jpg_p100x100&_nc_cat=106&ccb=1-7&_nc_sid=7206a8&_nc_ohc=pGpUxEVrzG4AX9CJsiK&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.fhan2-5.fna&oh=00_AfCJg_cH8N6MMFU2o92_Lw8BfhvbebGqOpu42wupIguicQ&oe=6397330D',
              imageBuilder: (context, image) {
                return Container(
                  height: context.sizes.width / 4,
                  width: context.sizes.width / 4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: image,
                    ),
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget textLabel(
    String value, {
    Color? color,
    TextAlign? textAlign,
    double? fontSize,
    bool? isBoldText,
  }) {
    return Text(
      value,
      style: AppTextStyles.fontPoppinsRegular14.copyWith(
        color: color ?? Colors.white,
        fontSize: fontSize,
        fontWeight: (isBoldText != null) ? FontWeight.w700 : null,
      ),
      textAlign: textAlign ?? TextAlign.center,
    );
  }
}
