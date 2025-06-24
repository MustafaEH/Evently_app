import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static showLoadingDialog(String? loadingMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Row(
            children: [
              loadingMessage != null ? Text(loadingMessage) : Container(),
              Spacer(),
              CircularProgressIndicator(color: ColorsManager.blue),
            ],
          ),
        );
      },
    );
  }

  static hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showDialogWithMessage(
    BuildContext context, {
    required String message,
    String? title,
    String? positiveActionText,
    String? negActionText,
    VoidCallback? posAction,
    VoidCallback? negAction,
  }) {
    List<Widget> actions = [];
    if (positiveActionText != null) {
      actions.add(
        TextButton(onPressed: posAction, child: Text(positiveActionText)),
      );
    }
    if (negActionText != null) {
      actions.add(
        TextButton(onPressed: negAction, child: Text(negActionText)),
      );
    }

    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          actions: actions,
          content: Text(message),
          title: title != null ? Text(title) : null,
        );
      },
    );
  }
}
