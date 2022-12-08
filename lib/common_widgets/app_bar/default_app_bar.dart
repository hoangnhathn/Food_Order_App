import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../gen/assets.gen.dart';
import '../../resource/app_text_styles.dart';
import '../space_box.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    this.title,
    this.onLeftTapped,
    this.onRightTapped,
    this.leftLabel,
    this.rightIcon,
    this.rightLabel,
    Key? key,
  }) : super(key: key);

  /// Title
  final String? title;

  /// on Button Left Tapped
  final VoidCallback? onLeftTapped;

  /// on Button Right Tapped
  final VoidCallback? onRightTapped;

  /// Label of left side AppBar
  final String? leftLabel;

  /// Right Icon Path
  final String? rightIcon;

  /// Label that will show on the right side of the app bar
  final String? rightLabel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: buildLeftContent(context),
      actions: buildActions(context),
      centerTitle: true,
      title: buildTitle(context),
    );
  }

  Widget buildTitle(BuildContext context) {
    return title != null
        ? IntrinsicWidth(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    title!,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.fontPoppinsRegular18.copyWith(
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }

  Widget buildLeftContent(BuildContext context) {
    return onLeftTapped != null
        ? GestureDetector(
            onTap: onLeftTapped,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: kToolbarHeight,
                child: Row(
                  children: [
                    const SpaceBox.width(),
                    Image.asset(
                      Assets.images.icBack.path,
                      height: 18,
                      width: 18,
                    ),
                    if (leftLabel != null)
                      Expanded(
                        child: Text(
                          leftLabel ?? AppLocalizations.of(context)!.back,
                          style: AppTextStyles.fontPoppinsRegular15,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }

  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      if (onRightTapped != null)
        GestureDetector(
          onTap: () {
            if (onRightTapped != null) {
              onRightTapped!();
            }
          },
          child: Row(
            children: [
              if (rightIcon != null)
                Image.asset(
                  rightIcon!,
                  width: 18,
                  height: 18,
                  color: Colors.white,
                ),
              if (rightLabel != null)
                Text(
                  rightLabel!,
                  style: AppTextStyles.fontOverpassRegular15,
                ),
              const SpaceBox.width(),
            ],
          ),
        )
    ];
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
