import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meet_me/index.dart';

class TopBar extends StatelessWidget {
  final double topBarOffset;
  final GlobalVars gb;
  final String title;
  final List<Widget> actions;

  const TopBar({
    Key key,
    this.topBarOffset,
    this.gb,
    this.title,
    this.actions,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
      width: s.width,
      height: 160 - topBarOffset,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: MediaQuery.of(context).padding.top,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: lerpDouble(40, 24, topBarOffset * 0.016666667),
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            children: actions,
          ),
        ],
      ),
      color: gb.pink,
    );
  }
}
