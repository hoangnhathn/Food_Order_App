import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../gen/assets.gen.dart';
import '../../resource/app_text_styles.dart';
import '../../resource/constants.dart';
import '../space_box.dart';

class IconTransitionAppBar extends StatelessWidget {
  const IconTransitionAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: Constants.spaceWidth,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.deliveryTo,
                  style: AppTextStyles.fontOpenSansBold18.copyWith(
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      Assets.images.icLocation.path,
                      height: 14,
                      width: 14,
                    ),
                    const SpaceBox.width(5),
                    Text(
                      'Ha Noi, Viet Nam',
                      style: AppTextStyles.fontPoppinsRegular14.copyWith(
                        color: Colors.black45,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
            child: const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://scontent.fhan14-2.fna.fbcdn.net/v/t1.6435-9/142915405_106600208107240_8287176908190349092_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=aDGoq4IonMwAX9bSeKE&tn=y9erCs1Wd2HJw9GZ&_nc_ht=scontent.fhan14-2.fna&oh=00_AfBGGEUWjM4lDDQUcY64V1EuhGelAQXQzdufNzVvyQT5Wg&oe=63A86D46',
              ),
            ),
          )
        ],
      ),
    );
  }
}
