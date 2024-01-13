import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/providers/auth_provider.dart';
import 'package:tezda/screens/login/login_screen.dart';
import 'package:tezda/screens/profile-details/profile_details_screen.dart';
import 'package:tezda/screens/profile/widgets/profile_menu.dart';
import 'package:tezda/screens/profile/widgets/profile_pic.dart';

class ProfileScreen extends ConsumerWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Profile",
              icon: Icons.person_2_outlined,
              press: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfileDetailsScreen())),
            ),
            ProfileMenu(
              text: "Notifications",
              icon: Icons.notifications_outlined,
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: Icons.settings_outlined,
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: Icons.help_center_outlined,
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: Icons.logout_outlined,
              press: () {
                auth.logout();
                Navigator.of(context).pop(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
