import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:idify/theme/app_theme.dart';
import 'package:idify/utils/globals.dart';

class InputField extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final Widget prefix;
  final Widget suffix;
  final TextEditingController controller;
  final FocusNode focusNode;

  const InputField({
    Key key,
    this.hintText = "",
    this.obscureText = false,
    this.prefix,
    this.suffix,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.system) {
      setState(() => isDark = Globals.systemDarkMode.getValue());
    } else if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
      setState(() => isDark = true);
    } else {
      setState(() => isDark = false);
    }
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        obscureText: widget.obscureText,
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: COLORS.MEDIUM_DARK_GREY,
            ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          border: InputBorder.none,
          fillColor: isDark ? COLORS.DARK_GREY : COLORS.LIGHTER_GREY,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: COLORS.MEDIUM_GREY,
          ),
          prefixIcon: widget.prefix != null
              ? Container(
                  height: 10,
                  width: 10,
                  alignment: Alignment.center,
                  child: widget.prefix,
                )
              : null,
          suffixIcon: widget.suffix != null
              ? Container(
                  height: 10,
                  width: 10,
                  alignment: Alignment.center,
                  child: widget.suffix,
                )
              : null,
        ),
      ),
    );
  }
}
