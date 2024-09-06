import 'package:flutter/material.dart';

class Csnakbar extends SnackBar {
  const Csnakbar({super.key, required super.content, required this.f});
  final Function() f;
  @override
  SnackBarAction? get action => SnackBarAction(
      label: "undo",
      backgroundColor: const Color.fromARGB(255, 17, 186, 209),
      onPressed: f);
  @override
  Color? get backgroundColor => Colors.black45;
  @override
  Duration get duration => const Duration(seconds: 1);
}
