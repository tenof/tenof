import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

typedef VoidCallback = void Function();

class notification {
  static void Function() open(
      {required Widget title,
      Widget? subTitle,
      VoidCallback? onClose,
      Widget? leading,
      Duration? duration = const Duration(seconds: 2),
      Widget Function(CancelFunc cancelFunc)? trailing}) {
    return BotToast.showNotification(
        leading: leading != null ? (_) => leading : null,
        title: (_) => title,
        subtitle: subTitle != null ? (_) => subTitle : null,
        trailing: trailing ??
            (cancel) => IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: cancel,
                ),
        duration: duration);
  }

  static void Function() success({
    required Widget title,
    Widget? subTitle,
    VoidCallback? onClose,
    Widget? leading,
    Duration? duration = const Duration(seconds: 2),
  }) {
    return open(
        leading: const Icon(Icons.favorite, color: Colors.redAccent),
        title: title,
        subTitle: subTitle,
        duration: duration);
  }

  static void Function() warning({
    required Widget title,
    Widget? subTitle,
    VoidCallback? onClose,
    Widget? leading,
    Duration? duration = const Duration(seconds: 2),
  }) {
    return open(
        leading: const Icon(Icons.sms_failed_outlined, color: Colors.orange),
        title: title,
        subTitle: subTitle,
        duration: duration);
  }
}

class Toast {
  static late Function _cancel;
  static loading() {
    // _cancel 有值的时候，先执行以下。
    hide();

    _cancel = BotToast.showLoading();
    return _cancel;
  }

  static hide() {
    // BotToast.closeAllLoading();
    _cancel();
  }
}
