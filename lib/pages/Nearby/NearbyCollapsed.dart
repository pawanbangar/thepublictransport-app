import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thepublictransport_app/backend/service/geocode/Geocode.dart';
import 'package:thepublictransport_app/backend/service/nominatim/NominatimRequest.dart';
import 'package:thepublictransport_app/framework/language/GlobalTranslations.dart';
import 'package:thepublictransport_app/framework/theme/ThemeEngine.dart';
import 'package:thepublictransport_app/pages/Flixbus/FlixbusSearch.dart';
import 'package:thepublictransport_app/pages/SavedTrips/SavedTrips.dart';
import 'package:thepublictransport_app/pages/Sparpreis/SparpreisSearch.dart';
import 'package:thepublictransport_app/ui/components/SelectionButtons.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyCollapsed extends StatefulWidget {
  @override
  _NearbyCollapsedState createState() => _NearbyCollapsedState();
}

class _NearbyCollapsedState extends State<NearbyCollapsed> {
  var theme = ThemeEngine.getCurrentTheme();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: 80,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50)
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              allTranslations.text('NEARBY.EXPLORE_WORLD'),
              style: TextStyle(
                fontSize: 20,
                color: theme.textColor
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SelectionButtons(
                  color: Color(0xfff64f59),
                  description: Text(
                    allTranslations.text('NEARBY.SAVED'),
                    style: TextStyle(
                        fontSize: 12,
                        color: theme.textColor
                    ),
                  ),
                  icon: Icon(
                    Icons.save,
                    color: theme.titleColorInverted,
                    size: 30,
                  ),
                  callback: () async {
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SavedTrips()));

                    setState(() {
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                        systemNavigationBarColor: Colors.blueAccent,
                        statusBarColor: Colors.transparent, // status bar color
                        statusBarBrightness: Brightness.light,
                        statusBarIconBrightness: Brightness.light,
                      ));
                    });
                  },
                ),
                SelectionButtons(
                  color: Colors.lightGreen,
                  description: Text(
                    allTranslations.text('NEARBY.FLIXBUS'),
                    style: TextStyle(
                        fontSize: 12,
                        color: theme.textColor
                    ),
                  ),
                  icon: Icon(
                    Icons.directions_bus,
                    color: theme.titleColorInverted,
                    size: 30,
                  ),
                  callback: () async {
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlixbusSearch()));
                    setState(() {
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                        systemNavigationBarColor: Colors.blueAccent,
                        statusBarColor: Colors.transparent, // status bar color
                        statusBarBrightness: Brightness.light,
                        statusBarIconBrightness: Brightness.light,
                      ));
                    });
                  },
                ),
                SelectionButtons(
                  color: Colors.red,
                  description: Text(
                    allTranslations.text('NEARBY.SPARPREIS'),
                    style: TextStyle(
                        fontSize: 12,
                        color: theme.textColor
                    ),
                  ),
                  icon: Icon(
                    Icons.monetization_on,
                    color: theme.titleColorInverted,
                    size: 30,
                  ),
                  callback: () async {
                    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SparpreisSearch()));
                    setState(() {
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                        systemNavigationBarColor: Colors.blueAccent,
                        statusBarColor: Colors.transparent, // status bar color
                        statusBarBrightness: Brightness.light,
                        statusBarIconBrightness: Brightness.light,
                      ));
                    });
                  },
                ),
              ],
            ),
          ]
      ),
    );
  }

  sightseeingGMaps() async {
    var coordinates = await Geocode.location();
    var nominatim = await NominatimRequest.getPlace(coordinates.latitude, coordinates.longitude);

    var url = 'https://www.google.com/maps/search/'+ nominatim.address.city + '+point+of+interest';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
