import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import '../../../common_widgets/base/base_page.dart';
import '../../../common_widgets/control/large_button.dart';
import '../../../common_widgets/input_part/input_text_area.dart';
import '../../../common_widgets/logo_image.dart';
import '../../../common_widgets/space_box.dart';
import '../../../data/model/enum/button_state.dart';
import '../../../data/provider/toast_provider.dart';
import '../../../data/repository/user_repository/user_repository.dart';
import '../../../resource/app_color.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import 'sign_up_state.dart';
import 'sign_up_view_model.dart';

final signUpViewModel = StateNotifierProvider.autoDispose<SignUpViewModel, SignUpState>(
  (ref) => SignUpViewModel(
    userRepository: UserRepository(ref),
    reader: ref,
  ),
);

class SignUpPage extends BasePage {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends BasePageState<SignUpPage> {
  @override
  void onInitState() {
    super.onInitState();
  }

  @override
  bool get tapOutsideHideKeyboard => true;

  @override
  bool get resizeToAvoidBottomInset => true;

  @override
  Color get backgroundColor => const Color(0xffeaeaee);

  @override
  Widget body(BuildContext context) {
    final signUpState = ref.watch(signUpViewModel);
    final formStatus = signUpState.formStatus;

    ref.listen(signUpViewModel, (previous, next) {
      if (next is SignUpState) {
        if (next.formStatus == FormzStatus.submissionSuccess) {
          ref.read(toastProvider).showToast(
                context: context,
                message: AppLocalizations.of(context)!.signUpSuccessMessage,
              );
          Navigator.of(context).pop();
        } else if (next.formStatus == FormzStatus.submissionFailure) {
          ref.read(toastProvider).showToast(
                context: context,
                message: AppLocalizations.of(context)!.signUpErrorMessage,
                color: context.colors.error,
                backgroundColor: context.colors.errorLight,
              );
        }
      }
    });

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const LogoImage(
              size: 40,
            ),
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Colors.pink.shade200,
                  Colors.red.shade300,
                ],
              ).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text(
                AppLocalizations.of(context)!.appName,
                style: AppTextStyles.fontPoppinsBold22,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Text(
                AppLocalizations.of(context)!.createAccount,
                style: AppTextStyles.fontSFProTextBold23.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputTextArea(
                        title: AppLocalizations.of(context)!.termName,
                        maxLength: Constants.maxLengthUsername,
                        onChanged: (value) {
                          ref.read(signUpViewModel.notifier).changeName(
                            value,
                          );
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(Constants.characterAndNumberOnlyRegex),
                          ),
                        ],
                      ),
                      const SpaceBox.height(),
                      InputTextArea(
                        title: AppLocalizations.of(context)!.usernameEmail,
                        maxLength: Constants.maxLengthUsername,
                        onChanged: (value) {
                          ref.read(signUpViewModel.notifier).changeUsername(
                                value,
                              );
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(Constants.characterAndNumberOnlyRegex),
                          ),
                        ],
                      ),
                      const SpaceBox.height(),
                      InputTextArea(
                        title: AppLocalizations.of(context)!.password,
                        maxLength: Constants.maxLengthPassword,
                        obSecureText: true,
                        onChanged: (value) {
                          ref.read(signUpViewModel.notifier).changePassword(
                                value,
                              );
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(Constants.characterAndNumberOnlyRegex),
                          ),
                        ],
                      ),
                      const SpaceBox.height(),
                      InputTextArea(
                        title: AppLocalizations.of(context)!.confirmPassword,
                        maxLength: Constants.maxLengthPassword,
                        obSecureText: true,
                        onChanged: (value) {
                          ref
                              .read(signUpViewModel.notifier)
                              .changeConfirmPassword(
                                value,
                              );
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(Constants.characterAndNumberOnlyRegex),
                          ),
                        ],
                      ),
                      const SpaceBox.height(25),
                      LargeButton(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          ref.read(signUpViewModel.notifier).submitSignUp();
                        },
                        title: AppLocalizations.of(context)!.signUp,
                        buttonState: formStatus.isValidated
                            ? ButtonState.active
                            : ButtonState.inactive,
                      ),
                      const SpaceBox.height(15),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
