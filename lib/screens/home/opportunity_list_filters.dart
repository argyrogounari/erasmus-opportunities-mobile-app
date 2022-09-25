import 'package:erasmusopportunitiesapp/models/Filters.dart';
import 'package:erasmusopportunitiesapp/models/opportunity.dart';
import 'package:erasmusopportunitiesapp/models/volunteer.dart';
import 'package:erasmusopportunitiesapp/screens/home/filters.dart';
import 'package:erasmusopportunitiesapp/widgets/FiltersOutlineButton.dart';
import 'package:erasmusopportunitiesapp/widgets/error_message_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'opportunities_list.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';

class OpportunityListFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var _searchController = TextEditingController();

    final volunteer = Provider.of<VolunteerData>(context);
    final opportunities = Provider.of<List<Opportunity>>(context);
    var filteredOpportunities = opportunities;
    var filters = Filters();
    var _filtersActivated = false;


    return StatefulBuilder(
      builder: (context, StateSetter setState) =>

        FocusWatcher(
          child: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (title) {
                        setState(() {
                          print(title);
                          filteredOpportunities = filters.setTitle(opportunities, title);
                        });
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              filteredOpportunities = filters.setTitle(opportunities, '');
                            });
                          },
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                        hintText: 'Search titles',
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: <Widget>[
                        FiltersOutlineButton(
                          text: 'Filters',
                          color1: _filtersActivated? Theme.of(context).primaryColor : Colors.white,
                          color2: _filtersActivated? Colors.white : Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          onPressed: () async {
                            Filters newFilters = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => FiltersScreen(filters: filters, opportunities: opportunities,)),
                            );

                            setState(() {
                              if (newFilters.filtersActive()) {
                                _filtersActivated = true;
                              } else {
                                _filtersActivated = false;
                              }
                              filters = newFilters;
                              filteredOpportunities = filters.applyFilters(opportunities);
                            });
                          },
                          icon: Icons.filter_list,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  FiltersOutlineButton(
                                    text: 'Urgent',
                                    color1: filters.sortByDeadline ? Theme.of(context).primaryColor : Colors.white,
                                    color2: filters.sortByDeadline? Colors.white : Theme.of(context).primaryColor,
                                    borderColor: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      setState(() {
                                        filteredOpportunities = filters.setSortByUrgent(opportunities);
                                      });
                                    },
                                    icon: Icons.whatshot,
                                  ),
                                  SizedBox(width: 10.0,),
                                  FiltersOutlineButton(
                                    text: 'Free',
                                    color1: filters.free? Theme.of(context).primaryColor : Colors.white,
                                    color2: filters.free? Colors.white : Theme.of(context).primaryColor,
                                    borderColor: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      setState(() {
                                        filteredOpportunities = filters.setFree(opportunities);
                                      });
                                    },
                                    icon: Icons.money_off,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: filteredOpportunities != null && filteredOpportunities.isNotEmpty ? OpportunitiesList(
                      opportunities: filteredOpportunities,
                      volunteer: volunteer,
                    ) :
                    ErrorMessageScreen(
                      message: 'There are no opportunities that match your search filters.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

    );
  }
}

