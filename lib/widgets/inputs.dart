import 'package:flutter/material.dart';
import 'package:tezda/utils/constants.dart';

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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                  prefixIcon: Icon(icon, size: 16),
                  prefixIconColor: kPrimaryColor,
                  border: OutlineInputBorder(
                    gapPadding: 20,
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    gapPadding: 20,
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 20,
                    borderSide: const BorderSide(
                      color: kPrimaryColor,
                      width: 1.5,
                      
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
                  enabled: isEnabled,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: kPrimaryColor)),
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
