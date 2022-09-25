import 'package:erasmusopportunitiesapp/widgets/chewie_list_item.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:erasmusopportunitiesapp/widgets/Circular_clipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:erasmusopportunitiesapp/models/opportunity.dart';
import 'package:video_player/video_player.dart';
import 'package:share/share.dart';

class OpportunityScreen extends StatefulWidget {
  final Opportunity opportunity;

  OpportunityScreen({this.opportunity});

  @override
  _OpportunityScreenState createState() => _OpportunityScreenState();
}

class _OpportunityScreenState extends State<OpportunityScreen> {

  _share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    final text = 'Hey! I found a great opportunity on the urerasmus app.' +
        "You can apply here ---> " + widget.opportunity.applicationLink;

    Share.share(text,
        subject: 'Opportunity "' + widget.opportunity.title + '"',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: new FloatingActionButton(
          elevation: 10.0,
          child: Icon(
            Icons.assignment,
            size: 25.0,
            color: Colors.white,
          ),
          backgroundColor: Color.fromRGBO(0, 68, 149, 1),
          onPressed: () async {
            print('1');
            final url = widget.opportunity.applicationLink;
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              final snackBar = SnackBar(
                content: Text('An error accured! Please try again.'),
                backgroundColor: Colors.red,
              );
              Scaffold.of(context).showSnackBar(snackBar);
            }
          }
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: widget.opportunity.oid,
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(
                        color: Colors.black,
                        blurRadius: 20.0),
                    child:
                    widget.opportunity.coverImage != null ?
                    Image.network(
                      widget.opportunity.coverImage,
                      height: 400.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ) :
                    Image(
                      height: 400.0,
                      width: double.infinity,
                      image: AssetImage(widget.opportunity.getRandomImage()),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Icon(
                    Icons.arrow_back,
                    color: Color.fromRGBO(0, 68, 149, 1),
                    size: 30.0,
                  ),
                  shape: new CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: EdgeInsets.all(5.0),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 20.0,
                child: IconButton(
                  onPressed: () => print('Add to Favorites'),
                  icon: Icon(Icons.favorite_border),
                  iconSize: 35.0,
                  color: Colors.black,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 25.0,
                child: IconButton(
                  onPressed: () => _share(context),
                  icon: Icon(Icons.share),
                  iconSize: 35.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.opportunity.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color.fromRGBO(0, 68, 149, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Fee',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.opportunity.getPreviewParticipationCost(),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Location',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.opportunity.venueCountry,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Duration',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.opportunity.getPreviewDuration(),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Container(
                  height: 140.0,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.opportunity.description,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Start date: ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.opportunity.getStartDate(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Text(
                          'End date: ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.opportunity.getEndDate(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Text(
                          'Deadline: ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.opportunity.getDeadline(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Text(
                          'Ages accepted: ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.opportunity.lowAge.toString() + "-" + widget.opportunity.highAge.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        Text(
                          'Reimbursment limit: ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.opportunity.getReimbursementLimit(),
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    widget.opportunity.postImage != null ?
                    Image.network(
                      widget.opportunity.postImage,
                      fit: BoxFit.cover,
                    ) :
                    Image(
                      width: 110.0,
                      image: AssetImage(widget.opportunity.getRandomImage()),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Organisation: ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Flexible(
                          child: Text(
                            widget.opportunity.organisationName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Topics: ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Flexible(
                          child: Text(
                            widget.opportunity.getTopicsList(),
                            maxLines: 100,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Participating countries: ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Flexible(
                          child: Text(
                            widget.opportunity.getParticipatingCountriesList(),
                            maxLines: 100,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Organisation can provide: ',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Flexible(
                          child: Text(
                            widget.opportunity.getProvideForDisabilitiesList(),
                            maxLines: 100,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    ChewieListItem(
                      videoPlayerController: VideoPlayerController.network(
                        widget.opportunity.postVideo,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
//          ContentScroll(
//            //images: widget.movie.screenshots,
//            title: 'Screenshots',
//            imageHeight: 200.0,
//            imageWidth: 250.0,
//          ),
        ],
      ),
    );
  }
}
