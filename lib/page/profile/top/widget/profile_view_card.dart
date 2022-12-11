import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../common_widgets/space_box.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../resource/app_size.dart';
import '../../../../resource/app_text_styles.dart';
import '../../../../resource/constants.dart';

class ProfileOverViewCard extends StatelessWidget {
  const ProfileOverViewCard({
    required this.orderCount,
    required this.cartCount,
    required this.name,
    required this.onTapChangeName,
    Key? key,
  }) : super(key: key);

  /// [name]
  final String name;

  /// [orderCount]
  final int orderCount;

  /// [cartCount]
  final int cartCount;

  /// [onTap]
  final VoidCallback onTapChangeName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapChangeName,
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
                  AppLocalizations.of(context)!.userTerm,
                  style: AppTextStyles.fontPoppinsBold16.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(
                  name,
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
            top: context.sizes.width / 8 + 20,
            right: 20,
            child: GestureDetector(
              onTap: onTapChangeName,
              child: Image.asset(
                Assets.images.icEdit.path,
                width: 18,
                height: 18,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CachedNetworkImage(
              imageUrl: Constants.dummyProfileImage,
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
