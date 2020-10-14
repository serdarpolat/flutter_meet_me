import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final Widget title;
  final Color color;
  final Function onPressed;
  const SignButton({Key key, this.title, this.color, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
      width: s.width,
      height: 60,
      child: RaisedButton(
        onPressed: onPressed,
        elevation: 10,
        child: title,
        color: color,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
