import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoadingDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(width: 16),
                Text(message),
              ],
            ),
          ),
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showDialogWithMessage(
    BuildContext context, {
    required String message,
    String? positiveActionText,
    String? negativeActionText,
    VoidCallback? posAction,
    VoidCallback? negAction,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: Text(message),
            actions: [
              if (negativeActionText != null)
                TextButton(
                  onPressed: () {
                    hideDialog(context);
                    negAction?.call();
                  },
                  child: Text(negativeActionText),
                ),
              if (positiveActionText != null)
                TextButton(
                  onPressed: () {
                    hideDialog(context);
                    posAction?.call();
                  },
                  child: Text(positiveActionText),
                ),
            ],
          ),
    );
  }

  static void showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? actionText,
    VoidCallback? onAction,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  hideDialog(context);
                  onAction?.call();
                },
                child: Text(actionText ?? 'OK'),
              ),
            ],
          ),
    );
  }

  static void showSuccessDialog(
    BuildContext context, {
    required String message,
    String? actionText,
    VoidCallback? onAction,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            icon: const Icon(Icons.check_circle, color: Colors.green),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  hideDialog(context);
                  onAction?.call();
                },
                child: Text(actionText ?? 'OK'),
              ),
            ],
          ),
    );
  }

  static void showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    required String cancelText,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  hideDialog(context);
                  onCancel?.call();
                },
                child: Text(cancelText),
              ),
              TextButton(
                onPressed: () {
                  hideDialog(context);
                  onConfirm();
                },
                child: Text(confirmText),
              ),
            ],
          ),
    );
  }
}
