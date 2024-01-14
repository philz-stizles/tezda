import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/providers/auth_provider.dart';
import 'package:tezda/providers/user_provider.dart';
import 'package:tezda/screens/login/login_screen.dart';
import 'package:tezda/screens/profile/widgets/profile_menu.dart';
import 'package:tezda/screens/profile/widgets/profile_pic.dart';
import 'package:tezda/utils/constants.dart';
import 'package:tezda/widgets/widgets.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  static String routeName = "/profile";

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late Future<void> _userFuture;

  // Form.
  final _profileFormKey = GlobalKey<FormState>();
  final _firstnameCtrl = TextEditingController();
  final _lastnameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _streetCtrl = TextEditingController();

  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _userFuture = ref.read(userProvider.notifier).loadUserProfile();
  }

  @override
  void dispose() {
    _firstnameCtrl.dispose();
    _lastnameCtrl.dispose();
    _phoneCtrl.dispose();
    _cityCtrl.dispose();
    _streetCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final user = ref.read(userProvider.notifier);
    await user.save({
      'firstname': _firstnameCtrl.text,
      'lastname': _lastnameCtrl.text,
      'phone': _phoneCtrl.text,
      'address': {'city': _cityCtrl.text, 'street': _streetCtrl.text}
    });
    setState(() {
      _isEditMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          actions: [
            GestureDetector(
                onTap: () {
                  auth.logout();
                  Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout_outlined,
                        size: 16,
                        color: kPrimaryColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Log Out",
                        style: TextStyle(color: kPrimaryColor),
                      )
                    ],
                  ),
                )),
          ],
        ),
        body: FutureBuilder(
            future: _userFuture,
            builder: (context, snapshot) {
              return Stack(children: [
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          children: [
                            const ProfilePic(),
                            const SizedBox(height: 20),
                            Consumer(builder: (_, ref, ch) {
                              final user = ref.watch(userProvider);
                              _firstnameCtrl.text =
                                  user != null && user.firstname != null
                                      ? user.firstname!
                                      : "";
                              _lastnameCtrl.text =
                                  user != null && user.lastname != null
                                      ? user.lastname!
                                      : "";
                              _phoneCtrl.text =
                                  user != null && user.phone != null
                                      ? user.phone!
                                      : "";
                              _cityCtrl.text = user != null &&
                                      user.address != null &&
                                      user.address?.city != null
                                  ? user.address!.city!
                                  : "";
                              _streetCtrl.text = user != null &&
                                      user.address != null &&
                                      user.address?.street != null
                                  ? user.address!.street!
                                  : "";

                              return Form(
                                  key: _profileFormKey,
                                  child: Column(
                                    children: [
                                      _isEditMode
                                          ? AppTextField(
                                              hintText: 'First name',
                                              icon: Icons.person,
                                              editingCtrl: _firstnameCtrl,
                                            )
                                          : ProfileMenu(
                                              text: user != null &&
                                                      user.firstname != null
                                                  ? user.firstname!
                                                  : "First name",
                                              icon: Icons.person,
                                            ),
                                      _isEditMode
                                          ? AppTextField(
                                              hintText: 'Last name',
                                              icon: Icons.person_2_outlined,
                                              editingCtrl: _lastnameCtrl,
                                            )
                                          : ProfileMenu(
                                              text: user != null &&
                                                      user.lastname != null
                                                  ? user.lastname!
                                                  : "Last name",
                                              icon: Icons.person_2_outlined,
                                            ),
                                      _isEditMode
                                          ? AppTextField(
                                              hintText: 'Phone',
                                              icon: Icons.phone_outlined,
                                              editingCtrl: _phoneCtrl,
                                            )
                                          : ProfileMenu(
                                              text: user != null &&
                                                      user.phone != null
                                                  ? user.phone!
                                                  : "Phone",
                                              icon: Icons.phone_outlined,
                                            ),
                                      _isEditMode
                                          ? AppTextField(
                                              hintText: 'City',
                                              icon:
                                                  Icons.location_city_outlined,
                                              editingCtrl: _cityCtrl,
                                            )
                                          : ProfileMenu(
                                              text: user != null &&
                                                      user.address != null &&
                                                      user.address?.city != null
                                                  ? user.address!.city!
                                                  : "City",
                                              icon:
                                                  Icons.location_city_outlined,
                                            ),
                                      _isEditMode
                                          ? AppTextField(
                                              hintText: 'Street',
                                              icon: Icons.streetview_outlined,
                                              editingCtrl: _streetCtrl,
                                            )
                                          : ProfileMenu(
                                              text: user != null &&
                                                      user.address != null &&
                                                      user.address?.street !=
                                                          null
                                                  ? user.address!.street!
                                                  : "Street",
                                              icon: Icons.streetview_outlined,
                                            ),
                                    ],
                                  ));
                            }),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: _isEditMode
                                  ? Row(
                                      children: [
                                        Expanded(
                                            child: OutlinedButton(
                                          onPressed: () {
                                            setState(() {
                                              _isEditMode = false;
                                            });
                                          },
                                          child: const Text("Cancel"),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (_profileFormKey.currentState!
                                                  .validate()) {
                                                await _save();
                                              }
                                            },
                                            child: const Text("Save"),
                                          ),
                                        )
                                      ],
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _isEditMode = true;
                                        });
                                      },
                                      child: const Text("Edit Profile"),
                                    ),
                            )
                          ],
                        ),
                      )
              ]);
            }));
  }
}
