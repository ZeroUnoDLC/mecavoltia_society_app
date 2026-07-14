import 'package:flutter/material.dart';

import 'package:mecavoltia_society_app/core/theme/app_theme.dart';

/// Pantalla de arranque mientras se restaura la sesión persistida.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'MecaVoltIA',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: MvColors.accent,
              ),
            ),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
