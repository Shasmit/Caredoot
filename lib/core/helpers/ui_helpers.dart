import 'package:shimmer/shimmer.dart';

import '../loaded_widget.dart';
// import 'package:shimmer/shimmer.dart';

import '../app_imports.dart';

class UIHelper {
  static showToast(
      {required String msg,
      required ToastType type,
      ToastDuration duration = ToastDuration.medium}) {
    OverlayManager.showToast(type: type, msg: msg, duration: duration);
  }

  static showLoader() {
    OverlayManager.showLoader(opacity: 0.1, color: Colors.red);
  }

  static hideLoader() {
    OverlayManager.hideOverlay();
  }

  static Widget getProgressGhost({height = 0.0, width = 0.0}) {
    return Center(
        child: Shimmer.fromColors(
            baseColor: AppColors.lightBackground,
            highlightColor: AppColors.white,
            period: const Duration(seconds: 2),
            child: Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
            )));
  }

  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
