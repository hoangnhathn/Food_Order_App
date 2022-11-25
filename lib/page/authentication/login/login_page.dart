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
import '../../../data/provider/app_navigator_provider.dart';
import '../../../data/repository/authentication_repository/authentication_repository.dart';
import '../../../navigation/app_route.dart';
import '../../../resource/app_text_styles.dart';
import '../../../resource/constants.dart';
import 'login_state.dart';
import 'login_view_model.dart';

final loginViewModel = StateNotifierProvider<LoginViewModel, LoginState>(
  (ref) => LoginViewModel(
    authenticationRepository: AuthenticationRepository(ref),
    ref: ref,
  ),
);

class LoginPage extends BasePage {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BasePageState<LoginPage> {
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
    final loginState = ref.watch(loginViewModel);
    final formStatus = loginState.formStatus;

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
                AppLocalizations.of(context)!.welcomeBack,
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
                        title: AppLocalizations.of(context)!.usernameEmail,
                        maxLength: Constants.maxLengthUsername,
                        onChanged: (value) {
                          ref.read(loginViewModel.notifier).changeUsername(
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
                          ref.read(loginViewModel.notifier).changePassword(
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
                          submitLogin();
                        },
                        title: AppLocalizations.of(context)!.logIn,
                        buttonState: formStatus.isValidated
                            ? ButtonState.active
                            : ButtonState.inactive,
                      ),
                      const SpaceBox.height(15),
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(appNavigatorProvider)
                              .navigateTo(AppRoute.signUpPage);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            AppLocalizations.of(context)!.signUp,
                            style: AppTextStyles.fontPoppinsBold15.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
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

  Future<void> submitLogin() async {
    if (await ref.read(loginViewModel.notifier).submitLogin()) {
      await ref.read(appNavigatorProvider).navigateTo(
            AppRoute.homePage,
          );
    }
  }
}
