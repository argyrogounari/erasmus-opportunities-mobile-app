import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorMessageScreen extends StatelessWidget {
  final String message;

  const ErrorMessageScreen({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 30.0,),
              Container(
                width: 200.0,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/page_not_found.png'),
                      fit: BoxFit.fill
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
