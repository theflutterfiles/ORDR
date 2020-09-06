import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_mindful_lifting/screens/account.dart';
import 'package:flutter_app_mindful_lifting/screens/home/homeScreen.dart';
import 'package:intl/intl.dart' as intl;

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //backgroundColor: Color(0xFF333A47),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Calendar Timeline',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.tealAccent[100],
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
                ),
              ),
              CalendarTimeline(
                initialDate: _selectedDate,
                firstDate: DateTime.now().add(Duration(days: -365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                leftMargin: 20,
                monthColor: Colors.blueGrey,
                dayColor: Colors.teal[200],
                dayNameColor: Colors.white,
                activeDayColor: Colors.white,
                activeBackgroundDayColor: Colors.teal,
                dotsColor: Color(0xFF333A47),
                selectableDayPredicate: (date) => date.day != 23,
                //locale: 'en_ISO',
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: FlatButton(
                  color: Colors.teal[200],
                  child: Text('RESET', style: TextStyle(color: Color(0xFF333A47))),
                  onPressed: () => setState(() => _resetSelectedDate()),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  height: 220.0,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(icon: Icon(Icons.home), color: Color(0xff19343e),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => HomePage()));
                },),
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
