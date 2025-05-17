import 'package:evently/evently.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //
  // );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ConfigProvider(),
      child: const Evently(),
    ),
  );
}
