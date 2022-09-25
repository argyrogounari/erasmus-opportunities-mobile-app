import 'package:erasmusopportunitiesapp/models/opportunity.dart';
import 'package:erasmusopportunitiesapp/models/volunteer.dart';
import 'package:erasmusopportunitiesapp/screens/account/account.dart';
import 'package:erasmusopportunitiesapp/screens/account/onboarding.dart';
import 'package:erasmusopportunitiesapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Volunteer>(context);

    if (user == null) {
      return OnBoarding();
    } else {
      return MultiProvider(
        providers: [
          StreamProvider<VolunteerData>.value(
            value: DatabaseService(uid: user.uid).volunteerData
          ),
          StreamProvider<List<Opportunity>>.value(
            value: DatabaseService().opportunities
          ),
        ],
        child: Account(),
      );
    }
  }
}
