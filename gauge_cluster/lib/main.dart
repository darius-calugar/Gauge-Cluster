import 'package:flutter/material.dart';
import 'package:gauge_cluster/app.dart';
import 'package:gauge_cluster/utils/assets.dart';

Future<void> main() async {
  await Textures.load();

  runApp(const App());
}
