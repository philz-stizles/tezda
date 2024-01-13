import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/providers/providers.dart';
import 'package:tezda/screens/login/login_screen.dart';

import 'package:tezda/screens/screens.dart';
import 'package:tezda/services/environment_service.dart';
import 'package:tezda/utils/themes.dart';

Future<void> main() async {
  await EnvironmentService.init();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final authP = ref.watch(authProvider.notifier);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tezda Commerce',
      theme: AppTheme.lightTheme(context),
      home: auth.token != null
          ? const ProductsScreen()
          : FutureBuilder(
              future: authP.tryAutoLogin(),
              builder: (context, snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : const LoginScreen();
              }),
    );
  }
}
