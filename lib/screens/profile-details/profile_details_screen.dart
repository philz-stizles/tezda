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
                    : Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            // onSaved: (newValue) => email = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: kEmailNullError);
                              } else if (emailValidatorRegExp.hasMatch(value)) {
                                removeError(error: kInvalidEmailError);
                              }
                              return;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                addError(error: kEmailNullError);
                                return "";
                              } else if (!emailValidatorRegExp
                                  .hasMatch(value)) {
                                addError(error: kInvalidEmailError);
                                return "";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Email",
                              hintText: "Enter your email",
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              // suffixIcon:
                              //     SuffixIcon(svgIcon: "assets/icons/Mail.svg"),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            // onSaved: (newValue) => password = newValue,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                removeError(error: kPassNullError);
                              } else if (value.length >= 8) {
                                removeError(error: kShortPassError);
                              }
                              return;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                addError(error: kPassNullError);
                                return "";
                              } else if (value.length < 8) {
                                addError(error: kShortPassError);
                                return "";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",
                              // If  you are using latest version of flutter then lable text and hint text shown like this
                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              // suffixIcon:
                              //     SuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                            ),
                          ),
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
                      )
              ],
            );
          }),
    );
  }
}
