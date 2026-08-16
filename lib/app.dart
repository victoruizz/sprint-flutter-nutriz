import 'package:flutter/material.dart';

import 'core/routes.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'screens/home/home_shell.dart';
import 'screens/landing/landing_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/register/register_screen.dart';
import 'screens/splash/splash_screen.dart';

class NutrizApp extends StatelessWidget {
  const NutrizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutriz',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // O app e desenhado para celular. Em telas largas (navegador, tablet)
      // o conteudo fica centralizado numa coluna de leitura em vez de esticar
      // de borda a borda - no celular a restricao nao tem efeito.
      builder: (context, child) => ColoredBox(
        color: AppColors.canvas,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 460),
            child: Material(color: AppColors.white, child: child),
          ),
        ),
      ),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (_) => const SplashScreen(),
        AppRoutes.landing: (_) => const LandingScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.register: (_) => const RegisterScreen(),
        AppRoutes.home: (_) => const HomeShell(),
      },
    );
  }
}
