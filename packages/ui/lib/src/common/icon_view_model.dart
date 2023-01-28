import 'package:flutter/material.dart';

enum IconType {
  calendar,
  schedule,
  archive,
  flag,
  check,
  list;
}

extension IconTypeExt on IconType {
  IconData toMaterialIconData() {
    switch (this) {
      case IconType.calendar:
        return Icons.calendar_today_rounded;
      case IconType.schedule:
        return Icons.calendar_month_rounded;
      case IconType.archive:
        return Icons.archive_rounded;
      case IconType.flag:
        return Icons.flag_rounded;
      case IconType.check:
        return Icons.check_rounded;
      case IconType.list:
        return Icons.list_rounded;
    }
  }
}
