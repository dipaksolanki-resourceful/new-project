
import 'package:flutter/material.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info,
  loading,
  custom,
}

class AppSnackBar {
  AppSnackBar._();

  static final GlobalKey<ScaffoldMessengerState> messengerKey =
  GlobalKey<ScaffoldMessengerState>();

  static void show({
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
  }) {
    final messenger = messengerKey.currentState;

    if (messenger == null) return;

    final config = _getConfig(type);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              if (type == SnackBarType.loading)
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              else
                Icon(
                  icon ?? config.icon,
                  color: textColor ?? Colors.white,
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor ?? config.color,
          duration: duration,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          action: actionLabel != null
              ? SnackBarAction(
            label: actionLabel,
            textColor: Colors.white,
            onPressed: onAction ?? () {},
          )
              : null,
        ),
      );
  }

  static void success(String message) {
    show(message: message, type: SnackBarType.success);
  }

  static void error(String message) {
    print('called');
    show(message: message, type: SnackBarType.error);
  }

  static void warning(String message) {
    show(message: message, type: SnackBarType.warning);
  }

  static void info(String message) {
    show(message: message, type: SnackBarType.info);
  }

  static void loading(String message) {
    show(
      message: message,
      type: SnackBarType.loading,
      duration: const Duration(days: 1),
    );
  }

  static void custom({
    required String message,
    required Color backgroundColor,
    IconData icon = Icons.notifications,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      message: message,
      type: SnackBarType.custom,
      backgroundColor: backgroundColor,
      icon: icon,
      duration: duration,
    );
  }

  static void hide() {
    messengerKey.currentState?.hideCurrentSnackBar();
  }

  static _SnackBarConfig _getConfig(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return _SnackBarConfig(
          Colors.green.shade700,
          Icons.check_circle,
        );

      case SnackBarType.error:
        return _SnackBarConfig(
          Colors.red.shade700,
          Icons.error,
        );

      case SnackBarType.warning:
        return _SnackBarConfig(
          Colors.orange.shade800,
          Icons.warning_amber_rounded,
        );

      case SnackBarType.info:
        return _SnackBarConfig(
          Colors.blue.shade700,
          Icons.info,
        );

      case SnackBarType.loading:
        return _SnackBarConfig(
          Colors.blueGrey.shade800,
          Icons.hourglass_top,
        );

      case SnackBarType.custom:
        return _SnackBarConfig(
          Colors.black87,
          Icons.notifications,
        );
    }
  }
}

class _SnackBarConfig {
  final Color color;
  final IconData icon;

  _SnackBarConfig(this.color, this.icon);
}
