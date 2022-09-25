import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusopportunitiesapp/helpers/math.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

List<String> images = [
  'assets/images/happy_people0.jpg',
  'assets/images/happy_people1.jpg',
  'assets/images/happy_people2.jpg',
  'assets/images/happy_people3.jpg',
  'assets/images/happy_people4.jpg',
];

class Opportunity {
  final String oid;
  String title;
  String organisationName;
  final String organisationUID;
  String venueAddress;
  LatLng latLong;
  String venueCountry;
  List<dynamic> participatingCountries;
  String type;
  DateTime startDate;
  DateTime endDate;
  int lowAge;
  int highAge;
  List<dynamic> topics;
  DateTime applicationDeadline;
  double participationCost;
  double reimbursementLimit;
  String applicationLink;
  List<dynamic> provideForDisabilities;
  String description;
  Timestamp uploadTime;
  String coverImage;
  String postImage;
  String postVideo;

  Opportunity({
    @required this.oid,
    @required this.title,
    @required this.organisationName,
    @required this.organisationUID,
    @required this.venueAddress,
    @required this.venueCountry,
    @required this.participatingCountries,
    @required this.type,
    @required this.startDate,
    @required this.endDate,
    @required this.lowAge,
    @required this.highAge,
    @required this.topics,
    @required this.applicationDeadline,
    @required this.participationCost,
    @required this.reimbursementLimit,
    @required this.applicationLink,
    @required this.provideForDisabilities,
    @required this.description,
    @required this.uploadTime,
    @required this.coverImage,
    @required this.postImage,
    @required this.postVideo,
  });

  String getRandomImage() {
    return randomChoice(images);
  }

  String getPreviewType() {
    return (type == 'Youth Exchange') ? 'YE' : 'TC';
  }

  String getPreviewParticipationCost() {
    if (participationCost == 0) {
      return 'free';
    }
    return '€' + removeDecimalZeroFormat(participationCost);
  }

  String getPreviewDuration() {
    Duration difference = endDate.difference(startDate);
    return difference.inDays.toString() + ' days';
  }

  String getStartDate() {
    if (startDate.year == DateTime.now().year) {
      return DateFormat('d/MM').format(startDate);
    }
    return DateFormat('d/MM/yyyy').format(startDate);
  }

  String getEndDate() {
    if (endDate.year == DateTime.now().year) {
      return DateFormat('d/MM').format(endDate);
    }
    return DateFormat('d/MM/yyyy').format(endDate);
  }

  String getDeadline() {
    if (applicationDeadline.year == DateTime.now().year) {
      return DateFormat('d/MM').format(applicationDeadline);
    }
    return DateFormat('d/MM/yyyy').format(applicationDeadline);
  }

  String getReimbursementLimit() {
    if (reimbursementLimit == 0) {
      return 'no reimbursement';
    }
    return '€' + removeDecimalZeroFormat(reimbursementLimit);
  }

  String getTopicsList() {
    String list = '';
    for (var topic in topics) {
      list += '- ' + topic.toString() + '\n';
    }
    return  list;
  }

  String getParticipatingCountriesList() {
    String list = '';
    for (var country in participatingCountries) {
      list += '- ' + country.toString() + '\n';
    }
    return  list;
  }

  String getProvideForDisabilitiesList() {
    String list = '';
    for (var disability in provideForDisabilities) {
      list += '- ' + disability.toString() + '\n';
    }
    if (provideForDisabilities.isEmpty) return 'no assistance';
    return  list;
  }
}