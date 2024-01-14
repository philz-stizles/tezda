import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda/providers/user_provider.dart';
import 'package:tezda/utils/constants.dart';

import '../screens.dart';

class ProfileDetailsScreen extends ConsumerStatefulWidget {
  const ProfileDetailsScreen({super.key});
  static const String routeName = '/profile-details--screen';

  @override
  ConsumerState<ProfileDetailsScreen> createState() =>
      _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends ConsumerState<ProfileDetailsScreen> {
  late Future<void> _userFuture;
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  @override
  void initState() {
    super.initState();
    _userFuture = ref.read(userProvider.notifier).loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    Future<void> _submit() async {}

    void addError({String? error}) {
      if (!errors.contains(error)) {
        setState(() {
          errors.add(error);
        });
      }
    }

    void removeError({String? error}) {
      if (errors.contains(error)) {
        setState(() {
          errors.remove(error);
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
      ),
      body: FutureBuilder(
          future: _userFuture,
          builder: (context, snapshot) {
            return Stack(
              children: [
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              // onSaved: (newValue) => email = newValue,
                              onChanged: (value) {},
                              validator: (value) {},
                              decoration: const InputDecoration(
                                labelText: "Name",
                                hintText: "Enter your Name",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              // onSaved: (newValue) => email = newValue,
                              onChanged: (value) {},
                              validator: (value) {},
                              decoration: const InputDecoration(
                                labelText: "Email",
                                hintText: "Enter your email",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              // onSaved: (newValue) => email = newValue,
                              onChanged: (value) {},
                              validator: (value) {},
                              decoration: const InputDecoration(
                                labelText: "Phone",
                                hintText: "Enter your phone",
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _submit();
                                  // KeyboardUtil.hideKeyboard(context);
                                  // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                                }
                              },
                              child: Text(user == null
                                  ? "Create Profile"
                                  : "Update Profile"),
                            ),
                          ],
                        ),
                      )
              ],
            );
          }),
    );
  }
}
