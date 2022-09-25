import 'package:flutter/material.dart';

import 'opportunity.dart';

class Filters {
  bool title = false;
  String titleValue = '';

  bool sortByStartDate = true;
  bool sortByDeadline = false;
  bool sortByDateAdded = false;

  bool onlyYouthExchange = false;
  bool onlyTrainingCourse = false;

  bool free = false;

  bool dateRange = false;
  List<DateTime> dateRangeList = [];
  bool duration = false;
  RangeValues durationList = RangeValues(1, 90);
  bool venueLocation = false;
  List<String> venueLocationList = [];
  bool participatingCountries = false;
  List<String> participatingCountriesList = [];
  bool receivingOrganisations = false;
  List<String> receivingOrganisationsList = [];
  bool agesAccepted = false;
  RangeValues agesAcceptedList = RangeValues(12, 120);
  bool topics = false;
  List<String> topicsList = [];
  bool nonRefundableFees = false;
  RangeValues nonRefundableFeesList = RangeValues(0, 500);
  bool reimbursableExpenses = false;
  RangeValues reimbursableExpensesList = RangeValues(0, 500);
  bool accessibility = false;
  List<String> accessibilityList = [];

  List<Opportunity> applyFilters(List<Opportunity> opportunities) {

    if (title) {
      opportunities = opportunities
          .where((opportunity) =>
          opportunity.title.toLowerCase().contains(titleValue.toLowerCase()))
          .toList();
    }

    if (sortByStartDate) {
      opportunities.sort((a, b) => a.startDate.compareTo(b.startDate));
    }

    if (sortByDeadline) {
      opportunities.sort((a, b) => a.applicationDeadline.compareTo(b.applicationDeadline));
    }

    if (sortByDateAdded) {
      opportunities.sort((a, b) => a.uploadTime.compareTo(b.uploadTime));
    }

    if (onlyYouthExchange) {
      opportunities =
          opportunities.where((opportunity) => opportunity.type == 'Youth Exchange').toList();
    }

    if (onlyTrainingCourse) {
      opportunities =
          opportunities.where((opportunity) => opportunity.type == 'Training Course').toList();
    }

    if (free) {
      opportunities = opportunities
          .where((opportunity) => opportunity.participationCost == 0).toList();
    }

    if (dateRange) {
      opportunities = opportunities
          .where((opportunity) =>
          opportunity.startDate.compareTo(dateRangeList[0]) >= 0 && opportunity.endDate.compareTo(dateRangeList[1]) < 0)
          .toList();
    }

    if (duration) {
      opportunities = opportunities
          .where((opportunity) =>  _compareDuration(opportunity)).toList();
    }

    if (venueLocation) {
      opportunities = opportunities
          .where((opportunity) =>  venueLocationList.contains(opportunity.venueCountry)).toList();
    }

    if (participatingCountries) {
      opportunities = opportunities
          .where((opportunity) =>  _compareParticipatingCountries(opportunity)).toList();
    }

    if (receivingOrganisations) {
      opportunities = opportunities
          .where((opportunity) =>  _compareReceivingOrganisations(opportunity)).toList();
    }

    if (agesAccepted) {
      opportunities = opportunities
          .where((opportunity) =>
            opportunity.lowAge <= agesAcceptedList.start &&
            agesAcceptedList.start <= opportunity.highAge &&
            opportunity.lowAge <= agesAcceptedList.end &&
            agesAcceptedList.end <= opportunity.highAge)
          .toList();
    }

    if (topics) {
      opportunities = opportunities
          .where((opportunity) =>  _compareTopics(opportunity)).toList();
    }

    if (nonRefundableFees) {
      opportunities = opportunities
          .where((opportunity) =>
            nonRefundableFeesList.start <= opportunity.participationCost &&
            opportunity.participationCost <= nonRefundableFeesList.end)
          .toList();
    }

    if (reimbursableExpenses) {
      opportunities = opportunities
          .where((opportunity) =>
            reimbursableExpensesList.start <= opportunity.reimbursementLimit &&
            opportunity.reimbursementLimit <= reimbursableExpensesList.end)
          .toList();
    }

    if (accessibility) {
      opportunities = opportunities
          .where((opportunity) =>  _compareAccessibilities(opportunity)).toList();
    }

    return opportunities;
  }

  List<Opportunity> setTitle(List<Opportunity> opportunities, String value) {
    title = true;
    titleValue = value;
    return applyFilters(opportunities);
  }

  List<Opportunity> setSortByUrgent(List<Opportunity> opportunities) {
    sortByDeadline = true;
    sortByStartDate = false;
    sortByDateAdded = false;
    return applyFilters(opportunities);
  }

  setSortByStartDate(List<Opportunity> opportunities) {
    // TODO do we need to take in the oops?
    sortByDeadline = false;
    sortByStartDate = true;
    sortByDateAdded = false;
  }

  setSortByDateAdded(List<Opportunity> opportunities) {
    sortByDeadline = false;
    sortByStartDate = false;
    sortByDateAdded = true;
  }

  List<Opportunity> setFree(List<Opportunity> opportunities) {
    free = !free;
    return applyFilters(opportunities);
  }

  setDateRange(List<Opportunity> opportunities, List dates) {
    if (dates != null && dates.isNotEmpty) {
      dateRange = true;
      dateRangeList = dates;
    } else {
      dateRange = false;
      dateRangeList = [];
    }
  }

  setDuration(List<Opportunity> opportunities, RangeValues durationRange) {
    if (durationRange != null && durationRange != getDefaultDuration()) {
      duration = true;
      durationList = durationRange;
    } else {
      duration = false;
      durationList = getDefaultDuration();
    }
  }

  setVenueLocation(List<Opportunity> opportunities, List venues) {
    if (venues != null && venues.isNotEmpty) {
      venueLocation = true;
      venueLocationList = [];
      for (var location in venues) {
        venueLocationList.add(location.toString());
      }
    } else {
      venueLocation = false;
      venueLocationList = [];
    }
  }

  setParticipatingCountries(List<Opportunity> opportunities, List countries) {
    if (countries != null && countries.isNotEmpty) {
      participatingCountries = true;
      participatingCountriesList = [];
      for (var location in countries) {
        participatingCountriesList.add(location.toString());
      }
    } else {
      participatingCountries = false;
      participatingCountriesList = [];
    }
  }

  setReceivingOrganisations(List<Opportunity> opportunities, List organisations) {
    if (organisations != null && organisations.isNotEmpty) {
      receivingOrganisations = true;
      receivingOrganisationsList = [];
      for (var organisation in organisations) {
        receivingOrganisationsList.add(organisation.toString());
      }
    } else {
      receivingOrganisations = false;
      receivingOrganisationsList = [];
    }
  }

  setAgesAccepted(List<Opportunity> opportunities, RangeValues ages) {
    if (ages != null && ages != getDefaultAgesAccepted()) {
      agesAccepted = true;
      agesAcceptedList = ages;
    } else {
      agesAccepted = false;
      agesAcceptedList = getDefaultAgesAccepted();
    }
  }

  setTopics(List<Opportunity> opportunities, List topicsL) {
    if (topicsL != null && topicsL.isNotEmpty) {
      topics = true;
      topicsList = [];
      for (var topic in topicsL) {
        topicsList.add(topic.toString());
      }
    } else {
      topics = false;
      topicsList = [];
    }
  }

  setNonRefundableFees(List<Opportunity> opportunities, RangeValues fees) {
    if (fees != null && fees != getDefaultNonRefundableFees()) {
      nonRefundableFees = true;
      nonRefundableFeesList = fees;
    } else {
      nonRefundableFees = false;
      nonRefundableFeesList = getDefaultNonRefundableFees();
    }
  }

  setReimbursableExpenses(List<Opportunity> opportunities, RangeValues expenses) {
    if (expenses != null && expenses != getDefaultReimbursableExpenses()) {
      reimbursableExpenses = true;
      reimbursableExpensesList = expenses;
    } else {
      reimbursableExpenses = false;
      reimbursableExpensesList = getDefaultReimbursableExpenses();
    }
  }

  setAccessibility(List<Opportunity> opportunities, List provides) {
    if (provides != null && provides.isNotEmpty) {
      accessibility = true;
      accessibilityList = provides;
    } else {
      accessibility = false;
      accessibilityList = [];
    }
  }

  RangeValues getDefaultDuration() {
    return RangeValues(1, 90);
  }

  RangeValues getDefaultAgesAccepted() {
    return RangeValues(12, 120);
  }

  RangeValues getDefaultNonRefundableFees() {
    return RangeValues(0, 500);
  }

  RangeValues getDefaultReimbursableExpenses() {
    return RangeValues(0, 500);
  }

  onReset() {
    sortByStartDate = true;
    sortByDeadline = false;
    sortByDateAdded = false;

    dateRange = false;
    dateRangeList = [];
    duration = false;
    durationList = RangeValues(1, 90);
    venueLocation = false;
    venueLocationList = [];
    participatingCountries = false;
    participatingCountriesList = [];
    agesAccepted = false;
    agesAcceptedList = RangeValues(12, 120);
    topics = false;
    topicsList = [];
    nonRefundableFees = false;
    nonRefundableFeesList = RangeValues(0, 500);
    reimbursableExpenses = false;
    reimbursableExpensesList = RangeValues(0, 500);
    accessibility = false;
    accessibilityList = [];
  }

  bool _compareDuration(Opportunity opp) {
    int difference = opp.endDate.difference(opp.startDate).inDays;
    if (difference >= durationList.start && difference <= durationList.end) {
      return true;
    }
    return false;
  }

  bool _compareParticipatingCountries(Opportunity opp) {
    if (opp.participatingCountries.isEmpty) return false;

    for (var country in participatingCountriesList) {
      if (opp.participatingCountries.contains(country)) {
        return true;
      }
    }
    return false;
  }

  bool _compareReceivingOrganisations(Opportunity opp) {
    for (var organisationName in receivingOrganisationsList) {
      if (opp.organisationName == organisationName) {
        return true;
      }
    }
    return false;
  }

  bool _compareTopics(Opportunity opp) {
    for (var topic in topicsList) {
      for (var topicFromOpp in opp.topics) {
        if (topicFromOpp.toString() == topic) return true;
      }
    }
    return false;
  }

  bool _compareAccessibilities(Opportunity opp) {
    if (opp.provideForDisabilities.isEmpty) return false;

    int counter = 0;
    for (var disability in accessibilityList) {
      if (opp.provideForDisabilities.contains(disability)) {
        counter++;
      }
    }
    if (counter == accessibilityList.length) return true;
    return false;
  }

  bool filtersActive() {

    if (sortByDateAdded == true ||
        onlyYouthExchange == true ||
        onlyTrainingCourse == true ||
        dateRange == true ||
        duration == true ||
        venueLocation == true ||
        participatingCountries == true ||
        receivingOrganisations == true ||
        agesAccepted == true ||
        topics == true ||
        nonRefundableFees == true ||
        reimbursableExpenses == true ||
        accessibility == true
    )
    {
      return true;
    }

    return false;
  }

}