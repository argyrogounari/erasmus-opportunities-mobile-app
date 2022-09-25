class FilterConstants {

  FilterConstants({
    this.sortBy: filtersSortBy,
    this.startDate: filterStartDate,
    this.deadline: filterDeadline,
    this.dateAdded: filterDateAdded,
    this.dateRange: filterDateRange,
    this.duration: filterDuration,
    this.venueLocation: filterVenueLocation,
    this.participatingCountries: filterParticipatingCountries,
    this.organisations: filterOrganisations,
    this.type: filterType,
    this.youthExchange: filterYouthExchange,
    this.trainingCourse: filterTrainingCourse,
    this.bothTypes: filterBothTypes,
    this.agesAccepted: filterAgesAccepted,
    this.topics: filterTopics,
    this.nonRefundableFees: filterNonRefundableFees,
    this.reimbursableExpenses: filterReimbursableExpenses,
    this.accessibility: filterAccessibility,
  });

  static const filtersSortBy = 'sortBy';
  static const filterStartDate = 'startDate';
  static const filterDeadline = 'deadline';
  static const filterDateAdded = 'dateAdded';
  static const filterDateRange = 'dateRange';
  static const filterDuration = 'duration';
  static const filterVenueLocation = 'venueLocation';
  static const filterParticipatingCountries = 'participatingCountries';
  static const filterType = 'organisations';
  static const filterOrganisations = 'type';
  static const filterYouthExchange = 'youthExchange';
  static const filterTrainingCourse = 'trainingCourse';
  static const filterBothTypes = 'both';
  static const filterAgesAccepted = 'agesAccepted';
  static const filterTopics = 'topics';
  static const filterNonRefundableFees = 'nonRefundableFees';
  static const filterReimbursableExpenses = 'reimbursableExpenses';
  static const filterAccessibility = 'accessibility';

  final String sortBy;
  final String startDate;
  final String deadline;
  final String dateAdded;
  final String dateRange;
  final String duration;
  final String venueLocation;
  final String participatingCountries;
  final String organisations;
  final String type;
  final String youthExchange;
  final String trainingCourse;
  final String bothTypes;
  final String agesAccepted;
  final String topics;
  final String nonRefundableFees;
  final String reimbursableExpenses;
  final String accessibility;
}