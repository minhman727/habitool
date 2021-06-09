import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'view/screen/home_screen.dart';
import 'view/screen/intro/login_screen.dart';
import 'view/screen/new_habit/newhabit_screen.dart'art';
import 'view/screen/user/infomation_screen.dart';

class WidgetTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      return InfomationUserScreen();
    }
    return LogInScreen();
  }
}
