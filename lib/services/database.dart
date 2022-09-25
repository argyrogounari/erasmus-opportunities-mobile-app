import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusopportunitiesapp/helpers/opportunity_constants.dart';
import 'package:erasmusopportunitiesapp/models/opportunity.dart';
import 'package:erasmusopportunitiesapp/models/volunteer.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  static final oppConstants = FirebaseOpportunityConstants();
  final CollectionReference opportunitiesCollection = Firestore.instance.collection(oppConstants.collection);

  List<Opportunity> _opportunityListFromSnapshot(QuerySnapshot snapshot) {
    List opportunities =  snapshot.documents.map((doc) {
      return Opportunity(
      oid: doc.documentID,
      title: doc[oppConstants.title],
      organisationName: doc[oppConstants.organisationName],
      organisationUID: doc[oppConstants.organisationUID],
      venueAddress: doc[oppConstants.venueAddress],
      venueCountry: doc[oppConstants.venueCountry],
      participatingCountries: doc[oppConstants.participatingCountries],
      type: doc[oppConstants.type],
      startDate: doc[oppConstants.startDate].toDate(),
      endDate: doc[oppConstants.endDate].toDate(),
      lowAge: doc[oppConstants.lowAge],
      highAge: doc[oppConstants.highAge],
      topics: doc[oppConstants.topics],
      applicationDeadline: doc[oppConstants.applicationDeadline].toDate(),
      participationCost: doc[oppConstants.participationCost].toDouble(),
      reimbursementLimit: doc[oppConstants.reimbursementLimit].toDouble(),
      applicationLink: doc[oppConstants.applicationLink],
      provideForDisabilities: doc[oppConstants.provideForDisabilities],
      description: doc[oppConstants.description],
      uploadTime: doc[oppConstants.uploadTime],
      coverImage: doc[oppConstants.coverImage],
      postImage: doc[oppConstants.postImage],
      postVideo: doc[oppConstants.postVideo],
      );
    }).toList();

    return opportunities;
  }

  Stream<List<Opportunity>> get opportunities {
    return opportunitiesCollection.orderBy(oppConstants.startDate).snapshots()
        .map(_opportunityListFromSnapshot);
  }

  VolunteerData _volunteerDataFromSnapshot(DocumentSnapshot snapshot) {

    return VolunteerData(
      uid: uid,
      email: snapshot.data['email'],
      liked: snapshot.data['liked'],
    );
  }

  Stream<VolunteerData> get volunteerData {
    if (uid != null) {
      return volunteersCollection.document(uid).snapshots()
          .map(_volunteerDataFromSnapshot);
    }
  }

  final CollectionReference volunteersCollection = Firestore.instance.collection('volunteers');
  Future updateUserData(String email) async {
    return await volunteersCollection.document(uid).setData({
      'email' : email,
      'liked' : [],
    });
  }

  Future addLikedOpportunityToUser(String oid) async {

    return await volunteersCollection.document(uid).updateData({
      'liked': FieldValue.arrayUnion([oid]),
    })
    .catchError((error) => print('Function addLikedOpportunityToUser threw: ' + error.toString()));
  }

  Future removeLikedOpportunityFromUser(String oid) async {

    return await volunteersCollection.document(uid).updateData({
      'liked': FieldValue.arrayRemove([oid]),
    });
  }
}