import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SortingOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color1;
  final Color color2;
  final Color borderColor;
  final IconData icon;

  const SortingOutlineButton({Key key, this.text, this.onPressed, this.color1, this.color2, this.borderColor, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: RaisedButton(
        color: color1,
        child: Row(
          children: <Widget>[
            SizedBox(width: 5.0,),
            Text(text, style: TextStyle(color: color2)),
          ],
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: borderColor, width: 1.0)),
      ),
    );
  }
}