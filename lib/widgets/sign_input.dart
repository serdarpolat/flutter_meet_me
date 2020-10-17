import 'package:flutter/material.dart';

class SignInput extends StatelessWidget {
  final FocusNode focusNode;
  final String hintText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final bool obsecureText;
  final void Function(String) onChanged;
  final void Function(String) onFieldSubmitted;

  const SignInput({
    Key key,
    this.focusNode,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.obsecureText,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
      width: s.width,
      height: 60,
      child: TextFormField(
        focusNode: focusNode,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obsecureText,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.black12,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              color: Color(0xFFE9446A),
            ),
          ),
        ),
      ),
    );
  }
}