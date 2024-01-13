import 'package:flutter/material.dart';

import 'package:tezda/utils/palette.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.validationText,
    this.formKey,
    this.maxLength,
    this.icon,
    this.maxLines = 1,
    this.isObscured = false,
    this.fontWeight = FontWeight.w700,
    this.isEnabled = true,
    this.type = TextInputType.text,
    this.editingCtrl,
    this.validator,
    this.iconTap,
    this.descriptionText,
    this.initialValue,
    this.formFieldKey,
  });
  final GlobalKey<FormState>? formKey;
  final String? hintText;
  final String? labelText;
  final String? validationText;
  final String? initialValue;
  final String? descriptionText;
  final bool isObscured;
  final bool isEnabled;
  final IconData? icon;
  final FontWeight fontWeight;
  final VoidCallback? iconTap;
  final int? maxLength;
  final TextInputType type;
  final TextEditingController? editingCtrl;
  final GlobalKey<FormFieldState>? formFieldKey;
  final FormFieldValidator<String>? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText == null
                ? const SizedBox()
                : Text(
                    labelText!,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: fontWeight,
                        color: Palette.secondary),
                  ),
            SizedBox(
              height: labelText == null ? 0 : 10,
            ),
            descriptionText == null
                ? const SizedBox()
                : Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      descriptionText!,
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC8CBD5)),
                    ),
                  ),
            TextFormField(
              key: formFieldKey,
              maxLines: maxLines,
              initialValue: initialValue,
              controller: editingCtrl,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: const TextStyle(fontSize: 14),
              keyboardType: type,
              maxLength: maxLength,
              obscureText: isObscured,
              decoration: InputDecoration(
                enabled: isEnabled,
                hintText: hintText,
                suffixIcon: icon == null
                    ? null
                    : GestureDetector(onTap: iconTap, child: Icon(icon)),
              ),
              validator: validator ??
                  (val) {
                    if (val == null || val.isEmpty) {
                      return validationText ?? "Please provide a valid value";
                    } else {
                      return null;
                    }
                  },
            ),
          ],
        ));
  }
}
