import 'package:flutter/material.dart';
import 'package:myspace_core/src/data/app_store.dart';
import 'package:provider/provider.dart';

abstract class Vm extends ChangeNotifier {
  final BuildContext _context;

  Vm({required BuildContext context}) : _context = context;

  CoreAppStore get appStore => _context.read();
}
