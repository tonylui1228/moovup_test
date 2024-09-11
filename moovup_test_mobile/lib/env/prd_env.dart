import 'package:envied/envied.dart';

import 'app_env.dart';
import 'app_env_fields.dart';

part 'prd_env.g.dart';

@Envied(name: 'Env', path: 'prd.env')
final class PrdEnv implements AppEnv, AppEnvFields {
  @override
  @EnviedField(varName: 'API_KEY')
  final String apiKey = _Env.apiKey;

  @override
  @EnviedField(varName: 'SERVER_URL')
  final String serverUrl = _Env.serverUrl;
}
