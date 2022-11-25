import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loadingStateProvider = ChangeNotifierProvider((ref) => LoadingState());

class LoadingState extends ChangeNotifier {
  bool isLoading = false;
  bool isShowLoadingDialog = false;

  String message = '';

  void toLoading({
    String message = '',
    bool isShowLoadingDialog = true,
  }) {
    if (isLoading) {
      return;
    }
    isLoading = true;
    this.isShowLoadingDialog = isShowLoadingDialog;
    this.message = message;
    notifyListeners();
  }

  void toIdle({
    Function? action,
  }) {
    if (!isLoading) {
      return;
    }
    isLoading = false;
    isShowLoadingDialog = false;
    message = '';
    notifyListeners();
    if (action != null) {
      action.call();
    }
  }
}
