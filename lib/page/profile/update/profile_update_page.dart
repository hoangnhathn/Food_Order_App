import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common_widgets/base/base_page.dart';
import '../../../common_widgets/control/large_button.dart';
import '../../../common_widgets/input_part/input_text_area.dart';
import '../../../common_widgets/space_box.dart';
import '../../../resource/app_color.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import 'model/profile_update_arguments.dart';

class ProfileUpdatePage extends BasePage {
  const ProfileUpdatePage({
    required this.arguments,
    required this.onChanged,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final ProfileUpdateArguments arguments;

  /// onTap
  final VoidCallback onTap;

  /// Text has been changed
  final ValueChanged<String> onChanged;

  @override
  ProfileUpdatePageState createState() => ProfileUpdatePageState();
}

class ProfileUpdatePageState extends BasePageState<ProfileUpdatePage> {
  @override
  bool get tapOutsideHideKeyboard => true;

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Color get backgroundColor => context.colors.baseBackgroundColor;

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.updateProfile,
            style: AppTextStyles.fontPoppinsRegular15,
          ),
          const SpaceBox.height(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.spaceWidth,
            ),
            child: InputTextArea(
              initialText: widget.arguments.name,
              title: AppLocalizations.of(context)!.termName,
              onChanged: (value) => widget.onChanged(value),
            ),
          ),
          const SpaceBox.height(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.spaceWidth,
            ),
            child: LargeButton(
              title: AppLocalizations.of(context)!.termUpdate,
              onTap: () {
                widget.onTap();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
