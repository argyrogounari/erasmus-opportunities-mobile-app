import 'package:erasmusopportunitiesapp/helpers/accessibility.dart';
import 'package:erasmusopportunitiesapp/helpers/countries.dart';
import 'package:erasmusopportunitiesapp/helpers/filter_constants.dart';
import 'package:erasmusopportunitiesapp/helpers/topics.dart';
import 'package:erasmusopportunitiesapp/models/Filters.dart';
import 'package:erasmusopportunitiesapp/models/opportunity.dart';
import 'package:erasmusopportunitiesapp/widgets/multiselect.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:intl/intl.dart';

class FiltersScreen extends StatefulWidget {

  final Filters filters;
  final List opportunities;

  FiltersScreen({Key key, this.filters, this.opportunities}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  static final filterConstants = FilterConstants();

  @override
  Widget build(BuildContext context) {

    FlutterStatusbarcolor.setNavigationBarColor(Colors.black);
    final List<Map<String,String>> organisations = getOrganisations(widget.opportunities);

    var filters = widget.filters;

    // Sort by
    String _getSortByInitialValue() {
      if (filters.sortByStartDate) return filterConstants.startDate;
      if (filters.sortByDeadline) return filterConstants.deadline;
      return filterConstants.dateAdded;
    }
    _setSortBy(value) {
      if (value == filterConstants.startDate) {
        filters.sortByStartDate = true;
        filters.sortByDeadline = false;
        filters.sortByDateAdded = false;
      } else if (value == filterConstants.deadline) {
        filters.sortByStartDate = false;
        filters.sortByDeadline = true;
        filters.sortByDateAdded = false;
      } else {
        filters.sortByStartDate = false;
        filters.sortByDeadline = false;
        filters.sortByDateAdded = true;
      }
    }

    // Type
    String _getInitialType() {
      if (filters.onlyYouthExchange) return filterConstants.youthExchange;
      if (filters.onlyTrainingCourse) return filterConstants.trainingCourse;
      return filterConstants.bothTypes;
    }
    _setType(value) {
      if (value == filterConstants.youthExchange) {
        filters.onlyYouthExchange = true;
        filters.onlyTrainingCourse = false;
      } else if (value == filterConstants.trainingCourse) {
        filters.onlyYouthExchange = false;
        filters.onlyTrainingCourse = true;
      } else {
        filters.onlyYouthExchange = false;
        filters.onlyTrainingCourse = false;
      }
    }

    // Date range
    var dateRangeList = filters.dateRangeList;
    var _dateRangeLabelText = dateRangeList != null && filters.dateRangeList.isNotEmpty? '' : 'Tap to select dates';
    _setDateRange(value) {
      filters.setDateRange(widget.opportunities, value);
    }

    // Duration
    var _durationRange = filters.durationList;
    var _durationStart = _durationRange.start.floor().toString();
    var _durationEnd = _durationRange.end.floor().toString();
    var _durationRangeText = '$_durationStart to $_durationEnd days';
    _setDuration(RangeValues value) {
      setState(() {
        filters.setDuration(widget.opportunities, value);
      });
    }

    // Venue location
    var _venueLocationList = filters.venueLocationList;
    _setVenueLocation(List value) {
      setState(() {
        filters.setVenueLocation(widget.opportunities, value);
      });
    }

    // Participating countries
    var _participatingCountriesList = filters.participatingCountriesList;
    _setParticipatingCountries(List value) {
      setState(() {
        filters.setParticipatingCountries(widget.opportunities, value);
      });
    }

    // Receiving organisations
    var _receivingOrganisationsList = filters.receivingOrganisationsList;
    _setReceivingOrganisations(List value) {
      setState(() {
        filters.setReceivingOrganisations(widget.opportunities, value);
      });
    }

    // Ages accepted
    var _ageRange = filters.agesAcceptedList;
    var _ageStart = _ageRange.start.floor().toString();
    var _ageEnd = _ageRange.end.floor().toString();
    var _ageText = '$_ageStart to $_ageEnd years old';
    _setAge(RangeValues value) {
      setState(() {
        filters.setAgesAccepted(widget.opportunities, value);
      });
    }

    // Topics
    var _topicsList = filters.topicsList;
    _setTopics(List value) {
      setState(() {
        filters.setTopics(widget.opportunities, value);
      });
    }

    // Non refundable fees
    var _feesRange = filters.nonRefundableFeesList;
    var _feesStart = _feesRange.start.floor().toString();
    var _feesEnd = _feesRange.end.floor().toString();
    var _feesText = '£$_feesStart to £$_feesEnd';
    _setFees(RangeValues value) {
      setState(() {
        filters.setNonRefundableFees(widget.opportunities, value);
      });
    }

    // Reimbursable expenses amount
    var _expensesRange = filters.reimbursableExpensesList;
    var _expensesStart = _expensesRange.start.floor().toString();
    var _expensesEnd = _expensesRange.end.floor().toString();
    var _expensesText = '£$_expensesStart to £$_expensesEnd';
    _setExpenses(RangeValues value) {
      setState(() {
        filters.setReimbursableExpenses(widget.opportunities, value);
      });
    }

    // Organisations that provide
    var accessibilityList = filters.accessibilityList;
    _setAccessibility(value) {
      filters.setAccessibility(widget.opportunities, value);
    }

    _onReset() {
      setState(() {
        _fbKey.currentState.reset();
        filters.onReset();
      });
    }



    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 60),
              child: FormBuilder(
                  key: _fbKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      SizedBox(height: 30.0,),

                      Text(
                        "Sort by",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      FormBuilderRadio(
                        attribute: filterConstants.sortBy,
                        initialValue: _getSortByInitialValue(),
                        activeColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          _setSortBy(value);
                        },
                        options: <FormBuilderFieldOption>[
                          FormBuilderFieldOption(
                              child: Text(
                                "Start Date",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              value: filterConstants.startDate,
                          ),
                          FormBuilderFieldOption(
                              child: Text(
                                  "Deadline",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              value: filterConstants.deadline
                          ),
                          FormBuilderFieldOption(
                              child: Text("Date Added",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              value: filterConstants.dateAdded
                          ),
                        ],

                      ),

                      SizedBox(height: 30.0,),

                      Text(
                        "Type",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      FormBuilderRadio(
                        attribute: filterConstants.type,
                        initialValue: _getInitialType(),
                        activeColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          _setType(value);
                        },
                        options: <FormBuilderFieldOption>[
                          FormBuilderFieldOption(
                            child: Text(
                              "Youth Exchange",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            value: filterConstants.youthExchange,
                          ),
                          FormBuilderFieldOption(
                              child: Text(
                                "Training Course",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              value: filterConstants.trainingCourse,
                          ),
                          FormBuilderFieldOption(
                              child: Text("Both",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              value: filterConstants.bothTypes,
                          ),
                        ],

                      ),

                      SizedBox(height: 30.0,),

                      Text(
                        "Date range",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      FormBuilderDateRangePicker(
                        attribute: filterConstants.dateRange,
                        initialValue: dateRangeList,
                        decoration: InputDecoration(
                          labelText:  _dateRangeLabelText,
                          border: InputBorder.none,
                        ),
                        onSaved: (value) {
                          _setDateRange(value);
                        },
                        format: DateFormat("dd/MM/yyyy"),
                        lastDate: DateTime.utc(2023),
                        firstDate: DateTime.now(),
                        onChanged: (dates) {
                          setState(() {
                            if (dates.toString().isEmpty) {
                              filters.dateRangeList = [];
                              _dateRangeLabelText = 'Tap to select dates';
                            } else {
                              filters.dateRangeList = [DateTime.now()];
                              _dateRangeLabelText = '';
                            }
                          });
                        },
                      ),

                      Divider(),
                      SizedBox(height: 30.0,),

                      Text(
                        "Duration",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        _durationRangeText,
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),

                      FormBuilderCustomField(
                        attribute: filterConstants.duration,
                        formField: FormField(
                          enabled: true,
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: field.errorText,
                              ),
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.only(top: 20.0),
                                child: RangeSlider(
                                  min: 1,
                                  max: 90,
                                  activeColor: Theme.of(context).primaryColor,
                                  labels: RangeLabels('$_durationStart days', '$_durationEnd days'),
                                  values: _durationRange,
                                  divisions: 90,
                                  onChanged: (RangeValues value) {
                                    _setDuration(value);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Divider(),
                      SizedBox(height: 30.0,),

                      Text(
                        "Venue location",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      FormBuilderCustomField(
                        attribute: filterConstants.venueLocation,
                        formField: FormField(
                          enabled: true,
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: field.errorText,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 20.0),
                                child: MultiSelect(
                                    autovalidate: false,
                                    dataSource: countries,
                                    textField: 'name',
                                    valueField: 'name',
                                    filterable: true,
                                    initialValue: _venueLocationList,
                                    required: false,
                                    onSaved: (value) {
                                      _setVenueLocation(value);
                                    }
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Divider(),
                      SizedBox(height: 30.0,),

                      Text(
                        "Participating countries",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      FormBuilderCustomField(
                        attribute: filterConstants.participatingCountries,
                        formField: FormField(
                          enabled: true,
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: field.errorText,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 20.0),
                                child: MultiSelect(
                                    autovalidate: false,
                                    dataSource: countries,
                                    textField: 'name',
                                    valueField: 'name',
                                    hintText: 'Tap to select countries',
                                    filterable: true,
                                    required: false,
                                    initialValue: _participatingCountriesList,
                                    onSaved: (value) {
                                      _setParticipatingCountries(value);
                                    }
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Divider(),
                      SizedBox(height: 30.0,),

                      Text(
                        "Receiving organisations",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      FormBuilderCustomField(
                        attribute: filterConstants.organisations,
                        formField: FormField(
                          enabled: true,
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: field.errorText,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 20.0),
                                child: MultiSelect(
                                    autovalidate: false,
                                    dataSource: organisations,
                                    textField: 'organisation',
                                    valueField: 'organisation',
                                    hintText: 'Tap to select organisations',
                                    filterable: true,
                                    required: false,
                                    initialValue: _receivingOrganisationsList,
                                    onSaved: (value) {
                                      _setReceivingOrganisations(value);
                                    }
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Divider(),
                      SizedBox(height: 30.0,),

                      Text(
                        "Ages accepted",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        _ageText,
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),

                      FormBuilderCustomField(
                        attribute: filterConstants.agesAccepted,
                        formField: FormField(
                          enabled: true,
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: field.errorText,
                              ),
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.only(top: 20.0),
                                child: RangeSlider(
                                  min: 12,
                                  max: 120,
                                  activeColor: Theme.of(context).primaryColor,
                                  labels: RangeLabels('$_ageStart', '$_ageEnd'),
                                  values: _ageRange,
                                  divisions: 108,
                                  onChanged: (RangeValues value) {
                                    _setAge(value);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Divider(),
                      SizedBox(height: 30.0,),

                      Text(
                        "Topics",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      FormBuilderCustomField(
                        attribute: filterConstants.topics,
                        formField: FormField(
                          enabled: true,
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: field.errorText,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 20.0),
                                child: MultiSelect(
                                    autovalidate: false,
                                    dataSource: topics,
                                    textField: 'topic',
                                    valueField: 'topic',
                                    hintText: 'Tap to select topics',
                                    filterable: true,
                                    required: false,
                                    initialValue: _topicsList,
                                    onSaved: (value) {
                                      _setTopics(value);
                                    }
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Divider(),
                      SizedBox(height: 30.0,),

                      Text(
                        "Non refundable fees",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        _feesText,
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),

                      FormBuilderCustomField(
                        attribute: filterConstants.nonRefundableFees,
                        formField: FormField(
                          enabled: true,
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: field.errorText,
                              ),
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.only(top: 20.0),
                                child: RangeSlider(
                                  min: 0,
                                  max: 500,
                                  activeColor: Theme.of(context).primaryColor,
                                  labels: RangeLabels('£$_feesStart', '£$_feesEnd'),
                                  values: _feesRange,
                                  divisions: 20,
                                  onChanged: (RangeValues value) {
                                    _setFees(value);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Divider(),
                      SizedBox(height: 30.0,),

                      Text(
                        "Reimbursable expenses amount",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        _expensesText,
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),

                      FormBuilderCustomField(
                        attribute: filterConstants.reimbursableExpenses,
                        formField: FormField(
                          enabled: true,
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: field.errorText,
                              ),
                              child: Container(
                                height: 100,
                                padding: EdgeInsets.only(top: 20.0),
                                child: RangeSlider(
                                  min: 0,
                                  max: 500,
                                  activeColor: Theme.of(context).primaryColor,
                                  labels: RangeLabels('£$_expensesStart', '£$_expensesEnd'),
                                  values: _expensesRange,
                                  divisions: 20,
                                  onChanged: (RangeValues value) {
                                    _setExpenses(value);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      Divider(),
                      SizedBox(height: 30.0,),

                      Text(
                        "Organisations that provide",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),


                      FormBuilderCustomField(
                        attribute: filterConstants.accessibility,
                        formField: FormField(
                          enabled: true,
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: field.errorText,
                              ),
                              child: Container(
                                padding: EdgeInsets.only(top: 20.0),
                                child:
                                FormBuilderCheckboxList(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  activeColor: Theme.of(context).primaryColor,
                                  attribute: filterConstants.accessibility,
                                  options: accessibility,
                                  initialValue: accessibilityList,
                                  onSaved: (value) {
                                    _setAccessibility(value);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 30.0,),

                    ],
                  ),
                ),
            ),
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              height: 57.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      _onReset();
                    },
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {

                      if (_fbKey.currentState.saveAndValidate()) {
                        Navigator.pop(context, filters);
                      }

                    },
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50.0),
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, String>> getOrganisations(List<Opportunity> opps) {

  List<String> organisationsList = [];
  for (var opp in opps) {
    if (!organisationsList.contains(opp.organisationName)) {
      organisationsList.add(opp.organisationName);
    }
  }

  List<Map<String,String>> organisationsMap = [];
  for (var org in organisationsList) {
    organisationsMap.add({'organisation' : org});
  }

  return organisationsMap;
}
