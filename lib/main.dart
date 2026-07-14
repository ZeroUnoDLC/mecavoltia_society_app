import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mecavoltia_society_app/core/router/app_router.dart';
import 'package:mecavoltia_society_app/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/config.env');
  runApp(const ProviderScope(child: MecavoltiaApp()));
}

class MecavoltiaApp extends ConsumerWidget {
  const MecavoltiaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Mecavoltia',
      theme: buildAppTheme(),
      routerConfig: ref.watch(appRouterProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
