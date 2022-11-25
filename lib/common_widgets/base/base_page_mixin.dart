import 'package:flutter/material.dart';

mixin BasePageMixin {
  bool get resizeToAvoidBottomInset => false;

  bool get tapOutsideHideKeyboard => false;

  Color? get backgroundColor => null;

  Future<bool> onWillPop() async => true;

  Widget body(BuildContext context);

  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  Widget? buildBottomNavigationBar(BuildContext context) => null;

  Widget? buildBottomSheet(BuildContext context) => null;

  Widget? buildDrawer(BuildContext context) => null;

  Widget? buildEndDrawer(BuildContext context) => null;

  Widget? buildFloatActionButton(BuildContext context) => null;

  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      appBar: buildAppBar(context),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onWillPop,
          child: GestureDetector(
            onTap: () {
              if (tapOutsideHideKeyboard) {
                hideKeyboard(context);
              }
            },
            child: tapOutsideHideKeyboard
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: body(context),
                  )
                : body(context),
          ),
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
      bottomSheet: buildBottomSheet(context),
      drawer: buildDrawer(context),
      endDrawer: buildEndDrawer(context),
      floatingActionButton: buildFloatActionButton(context),
    );
  }

  void hideKeyboard(BuildContext context) {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    } else {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  Color getBackgroundColor(BuildContext context) {
    return backgroundColor ?? Colors.white;
  }
}
