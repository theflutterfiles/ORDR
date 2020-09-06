import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_app_mindful_lifting/screens/account.dart';
import '../../userCalendar.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_localizations/flutter_localizations.dart';

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// List in reverse Order
List<String> images = [
  "assets/7.png",
  "assets/6.png",
  "assets/5.png",
  "assets/4.png",
  "assets/3.png",
  "assets/2.png",
  "assets/1.png"
];

List<String> title = [
  "Sunday",
  "Saturday",
  "Friday",
  "Thursday",
  "Wednesday",
  "Tuesday",
  "Monday",
];

class _HomePageState extends State<HomePage> {
  var currentPage = images.length - 1.0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    PageController controller =  PageController(initialPage: images.length - 1);
    controller.addListener( () {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25.0, top: 30.0, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //Image(
                    //image: AssetImage("assets/logo.png"),
                    //alignment: Alignment.topLeft,
                  //),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.redAccent[100],
                        fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0.0, top: 20.0, right: 15.0, bottom: 25.0,),
                      child: Text(
                        "Hi Tinika,\nHow are you today?",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Stack(
              children: <Widget>[
                CardScrollWidget(currentPage),
                Positioned.fill(
                    child: PageView.builder(
                        itemCount: images.length,
                        controller: controller,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Container();
                        }
                    )
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Color(0xff19343e),),
              title: Text('')
          ),
          BottomNavigationBarItem(
            icon: IconButton(icon: Icon(Icons.calendar_today), color: Color(0xff19343e),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Calendar()));
              },),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: IconButton(icon: Icon(Icons.person_outline), color: Color(0xff19343e),
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => Account()));
              },),
            title: Text(''),
          ),
        ],
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 25.0;
  var verticalInset = 25.0;

  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for(var i = 0; i< images.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding + max(
              primaryCardLeft - horizontalInset * -delta * (isOnRight ? 15 : 1),
              0.0
          );

          var cardItem= Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0
                    )
                  ]
                  ),
                  child: AspectRatio(
                      aspectRatio: cardAspectRatio,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image(
                            image: AssetImage(images[i]),
                            fit: BoxFit.cover,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                              title[i],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 32.0,
                                                  fontWeight: FontWeight.bold
                                              )
                                          ),
                                        ),
                                        SizedBox(height: 15.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  )
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}