import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:erasmusopportunitiesapp/models/volunteer.dart';
import 'package:erasmusopportunitiesapp/screens/account/wrapper.dart';
import 'package:erasmusopportunitiesapp/screens/home/home.dart';
import 'package:erasmusopportunitiesapp/screens/info/info.dart';
import 'package:erasmusopportunitiesapp/screens/map/map_helper.dart';
import 'package:erasmusopportunitiesapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {

  static const String _title = 'Home';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: _title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 68, 149, 1),
          accentColor: Color(0xFFD8ECF1),
          scaffoldBackgroundColor: Color(0xFFF3F5F7),
        ),
        home: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    MapHelperScreen(),
    InfoScreen(),
    Wrapper(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Volunteer>.value(
      value: AuthService().user,
      child: Scaffold(

        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Theme.of(context).primaryColor,
          items: <Widget>[
            Icon(Icons.home, color: Colors.white, size: 30),
            Icon(Icons.map, color: Colors.white, size: 30),
            Icon(Icons.info, color: Colors.white, size: 30),
            Icon(Icons.account_circle, color: Colors.white, size: 30),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}