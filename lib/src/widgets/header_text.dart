
import 'package:anime_twist/src/models/theme.dart';
import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    Key key,
    @required this.theme,
    @required this.fv,
    @required this.text,

  }) : super(key: key);

  final AnimeTwistTheme theme;
  final double fv;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            text,
            style: TextStyle(
                color: theme.accent,
                fontSize: fv,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
