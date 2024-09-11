import 'package:moovup_test_mobile/env/dev_env.dart';
import 'package:moovup_test_mobile/env/prd_env.dart';

import 'app_env_fields.dart';

import 'package:flutter/services.dart';

abstract interface class AppEnv implements AppEnvFields {
  factory AppEnv() => _instance;

  static final AppEnv _instance = appFlavor == 'prd' ? PrdEnv() : DevEnv();
}
