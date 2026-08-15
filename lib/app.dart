import 'package:flutter/material.dart';

import 'core/routes.dart';
import 'core/theme/app_theme.dart';
import 'screens/home/home_shell.dart';
import 'screens/login/login_screen.dart';
import 'screens/register/register_screen.dart';
import 'screens/splash/splash_screen.dart';

/// Raiz do app: define tema, titulo e as rotas nomeadas principais.
class NutrizApp extends StatelessWidget {
  const NutrizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutriz',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.home: (_) => const HomeShell(),
      },
    );
  }
}
