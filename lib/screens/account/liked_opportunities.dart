import 'package:erasmusopportunitiesapp/models/Filters.dart';
import 'package:erasmusopportunitiesapp/models/opportunity.dart';
import 'package:erasmusopportunitiesapp/models/volunteer.dart';
import 'package:erasmusopportunitiesapp/screens/home/filters.dart';
import 'package:erasmusopportunitiesapp/screens/home/opportunities_list.dart';
import 'package:erasmusopportunitiesapp/widgets/FiltersOutlineButton.dart';
import 'package:erasmusopportunitiesapp/widgets/error_message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';

class LikedOpportunities extends StatefulWidget {

  final List<Opportunity> opportunities;
  final VolunteerData volunteer;
  LikedOpportunities({this.opportunities, this.volunteer, UniqueKey key});

  @override
  _LikedOpportunitiesState createState() => _LikedOpportunitiesState();
}

class _LikedOpportunitiesState extends State<LikedOpportunities> {

  List<Opportunity> likedOpportunities = [];

  @override
  Widget build(BuildContext context) {

    List<Opportunity> getLikedOpportunities() {
      likedOpportunities = [];
      for( var opp in widget.volunteer.liked) {
        likedOpportunities.add(widget.opportunities.firstWhere((element) => element.oid == opp));
      }
      return likedOpportunities;
    }

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo_white.png', scale: AppBar().preferredSize.height / 8,),
      ),
      body: FocusWatcher(
        child: getLikedOpportunities() != null && getLikedOpportunities().isNotEmpty ?
          OpportunitiesList(
            opportunities: getLikedOpportunities(),
            volunteer: widget.volunteer,
          ) :
          ErrorMessageScreen(
            message: 'There are no liked opportunities.',
          ),
      ),
    );
  }
}
