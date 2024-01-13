import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../utils/palette.dart';
import '../utils/enums.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      this.disabled = false,
      this.loading = false,
      this.outlined = false,
      required this.title,
      required this.press,
      this.color,
      this.expanded = true,
      this.size = ButtonSize.large,
      this.icon})
      : super(key: key);

  final Color? color;
  final bool loading;
  final bool disabled;
  final bool outlined;
  final bool expanded;
  final ButtonSize size;
  final String title;
  final IconData? icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? double.infinity : null,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              side: BorderSide(
                  color: outlined ? Palette.secondary : Colors.transparent,
                  width: outlined ? 1 : 0),
              //shadowColor: outlined ? null : Palette.primary,
              elevation: outlined ? 0 : null,
              backgroundColor: outlined ? Palette.white : null,
              padding: EdgeInsets.symmetric(
                  vertical: size == ButtonSize.large ? 18 : 8,
                  horizontal: size == ButtonSize.large ? 15 : 15)),
          onPressed: disabled ? null : press,
          child: loading
              ? Center(
                  child: SpinKitThreeBounce(
                    size: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: outlined ? Palette.secondary : Palette.white,
                      ),
                    ),
                    ...icon == null
                        ? [const SizedBox()]
                        : [
                            const SizedBox(
                              width: 5,
                            ),
                            Icon(
                              icon,
                              size: 20,
                              color:
                                  outlined ? Palette.secondary : Palette.white,
                            )
                          ]
                  ],
                )),
    );
  }
}
