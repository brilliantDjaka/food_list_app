import 'package:flutter/material.dart';

enum Flavor {
  DEV,
  PRO,
}

class Config {
  static Flavor appFlavor;

  static String get appName {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'FoodLisuto DEV';
        break;
      case Flavor.PRO:
        return 'FoodLisuto';
        break;
      default:
        return 'FoodLisuto';
        break;
    }
  }

  static Icon get appIcon {
    switch (appFlavor) {
      case Flavor.DEV:
        return Icon(Icons.developer_mode);
        break;
      case Flavor.PRO:
        return Icon(Icons.fastfood);
        break;
      default:
        return Icon(Icons.fastfood);
        break;
    }
  }

  static Color get primaryColor {
    switch (appFlavor) {
      case Flavor.DEV:
        return Colors.redAccent;
        break;
      case Flavor.PRO:
        return Colors.blueAccent;
        break;
      default:
        return Colors.blueAccent;
        break;
    }
  }

  static Color get secondaryColor {
    switch (appFlavor) {
      case Flavor.DEV:
        return Colors.red;
        break;
      case Flavor.PRO:
        return Colors.blue;
        break;
      default:
        return Colors.blue;
        break;
    }
  }

  static bool get isDebug {
    switch (appFlavor) {
      case Flavor.DEV:
        return true;
        break;
      case Flavor.PRO:
        return false;
        break;
      default:
        return false;
        break;
    }
  }
}
