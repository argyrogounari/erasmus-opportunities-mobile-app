import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Volunteer {
  final String uid;
  String email;

  Volunteer({
    @required this.uid,
    @required this.email,
  });
}

class VolunteerData {
  final String uid;
  String email;
  List<dynamic> liked;

  VolunteerData({
    @required this.uid,
    @required this.email,
    @required this.liked,
  });

  isOpportunityLiked(String oid) {
    if (liked.contains(oid)) {
      return true;
    }
    return false;
  }
}