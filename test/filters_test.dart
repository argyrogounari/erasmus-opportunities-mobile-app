// Import the test package and Counter class
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:erasmusopportunitiesapp/helpers/accessibility.dart';
import 'package:erasmusopportunitiesapp/helpers/topics.dart';
import 'package:erasmusopportunitiesapp/models/Filters.dart';
import 'package:erasmusopportunitiesapp/models/opportunity.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {

  final opp1 = Opportunity(
    oid: '1',
    title: 'YAS! -Youth for action and sustainability',
    organisationName: 'Center for Community Mobilisation and Support',
    organisationUID: null,
    venueAddress: null,
    venueCountry: 'Cyprus',
    participatingCountries: ['Greece', 'Albania', 'Finland'],
    type: 'Youth Exchange',
    startDate: DateTime.parse("2020-06-27"),
    endDate: DateTime.parse("2020-07-05"),
    lowAge: 16,
    highAge: 24,
    topics: [topics[0], topics[2]],
    applicationDeadline: DateTime.parse("2020-05-01"),
    participationCost: 50,
    reimbursementLimit: 250,
    applicationLink: null,
    provideForDisabilities: [accessibility[0].value, accessibility[2].value],
    description: null,
    uploadTime: Timestamp.fromDate(DateTime.parse("2020-04-01")),
    coverImage: null,
    postImage: null,
    postVideo: null,
  );

  final opp2 = Opportunity(
    oid: '2',
    title: 'Organic Farm Warriors',
    organisationName: 'Act for change',
    organisationUID: null,
    venueAddress: null,
    venueCountry: 'Netherlands',
    participatingCountries: ['Azerbaijan', 'Romania', 'Turkey'],
    type: 'Trainig Course',
    startDate: DateTime.parse("2020-07-01"),
    endDate: DateTime.parse("2020-09-01"),
    lowAge: 25,
    highAge: 30,
    topics: [topics[3], topics[4], topics[7]],
    applicationDeadline: DateTime.parse("2020-05-27"),
    participationCost: 100,
    reimbursementLimit: 500,
    applicationLink: null,
    provideForDisabilities: [],
    description: null,
    uploadTime: Timestamp.fromDate(DateTime.parse("2020-06-01")),
    coverImage: null,
    postImage: null,
    postVideo: null,
  );

  final opp3 = Opportunity(
    oid: '3',
    title: 'Seeds of Action',
    organisationName: 'Act for change Georgia',
    organisationUID: null,
    venueAddress: null,
    venueCountry: 'Georgia',
    participatingCountries: ['Cyprus', 'Canada', 'Ireland', 'Azerbaijan'],
    type: 'Youth Exchange',
    startDate: DateTime.parse("2020-07-27"),
    endDate: DateTime.parse("2020-08-28"),
    lowAge: 25,
    highAge: 33,
    topics: [topics[2], topics[3], topics[4]],
    applicationDeadline: DateTime.parse("2020-06-01"),
    participationCost: 0,
    reimbursementLimit: 50,
    applicationLink: null,
    provideForDisabilities: [accessibility[2].value, accessibility[3].value],
    description: null,
    uploadTime: Timestamp.fromDate(DateTime.parse("2020-03-01")),
    coverImage: null,
    postImage: null,
    postVideo: null,
  );

  List<Opportunity> oppList = [opp1, opp2, opp3];

  test('setTitle', () {
    final filters = Filters();

    filters.setTitle(oppList, 'organic');

    expect(filters.title, true);
    expect(filters.titleValue, 'organic');
  });


  test('setSortByUrgent', () {
    final filters = Filters();

    filters.setSortByUrgent(oppList);
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list[1], opp2);
    expect(list[2], opp3);
  });

  test('setSortByStartDate', () {
    final filters = Filters();

    filters.setSortByStartDate(oppList);
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list[1], opp2);
    expect(list[2], opp3);
  });

  test('setSortByDateAdded', () {
    final filters = Filters();

    filters.setSortByDateAdded(oppList);
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp3);
    expect(list[1], opp1);
    expect(list[2], opp2);
  });

  test('setFree', () {
    final filters = Filters();

    List<Opportunity> list = filters.setFree(oppList);

    expect(list[0], opp3);
    expect(list.length, 1);
  });

  test('setDateRange', () {
    final filters = Filters();

    List<DateTime> range = [DateTime.parse("2020-06-20"), DateTime.parse("2020-07-20")];
    filters.setDateRange(oppList, range);
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list.length, 1);
  });

  test('setDuration', () {
    final filters = Filters();

    filters.setDuration(oppList, RangeValues(0, 28));
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list.length, 1);
  });

  test('setVenueLocation', () {
    final filters = Filters();

    filters.setVenueLocation(oppList, ['Cyprus', 'Georgia']);
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list[1], opp3);
    expect(list.length, 2);
  });

  test('setParticipatingCountries', () {
    final filters = Filters();

    filters.setParticipatingCountries(oppList, ['Ireland', 'Azerbaijan']);
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp2);
    expect(list[1], opp3);
    expect(list.length, 2);
  });

  test('setReceivingOrganisations', () {
    final filters = Filters();

    filters.setReceivingOrganisations(oppList, ['Act for change', 'Center for Community Mobilisation and Support']);
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list[1], opp2);
    expect(list.length, 2);
  });

  test('setAgesAccepted min-nom', () {
    final filters = Filters();

    filters.setAgesAccepted(oppList, RangeValues(16, 20));
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list.length, 1);
  });

  test('setAgesAccepted minPlus-nom', () {
    final filters = Filters();

    filters.setAgesAccepted(oppList, RangeValues(17, 20));
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list.length, 1);
  });

  test('setAgesAccepted nom-nom', () {
    final filters = Filters();

    filters.setAgesAccepted(oppList, RangeValues(20, 20));
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list.length, 1);
  });

  test('setAgesAccepted nom-maxMinus', () {
    final filters = Filters();

    filters.setAgesAccepted(oppList, RangeValues(20, 23));
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list.length, 1);
  });

  test('setAgesAccepted nom-maxMinus', () {
    final filters = Filters();

    filters.setAgesAccepted(oppList, RangeValues(20, 24));
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list.length, 1);
  });

  test('setTopics', () {
    final filters = Filters();

    filters.setTopics(oppList, [topics[3], topics[4]]);
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp2);
    expect(list[1], opp3);
    expect(list.length, 2);
  });

  test('setNonRefundableFees', () {
    final filters = Filters();

    filters.setNonRefundableFees(oppList, RangeValues(0, 10));
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp3);
    expect(list.length, 1);
  });

  test('setReimbursableExpenses', () {
    final filters = Filters();

    filters.setReimbursableExpenses(oppList, RangeValues(250, 500));
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list[1], opp2);
    expect(list.length, 2);
  });

  test('setAccessibility', () {
    final filters = Filters();

    List<String> acc = [accessibility[0].value];
    filters.setAccessibility(oppList, acc);
    List<Opportunity> list = filters.applyFilters(oppList);

    expect(list[0], opp1);
    expect(list.length, 1);
  });
}