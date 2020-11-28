import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/notifiers/task_notifier.dart';
import 'package:flutter_app_mindful_lifting/services/task_api.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _selectedDate;
  TaskApi taskApi = new TaskApi();

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
    TaskNotifier taskNotifier =
        Provider.of<TaskNotifier>(context, listen: false);
    taskApi.getDailyTasks(taskNotifier, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width,
      height: 180,
      //color: Colors.white,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)
      ,color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CalendarTimeline(
            initialDate: _selectedDate,
            firstDate: DateTime.now().add(Duration(days: -365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
                TaskApi taskApi = new TaskApi();
                TaskNotifier taskNotifier =
                    Provider.of<TaskNotifier>(context, listen: false);
                taskApi.getDailyTasks(taskNotifier, date);
              });
            },
            leftMargin: 20,
            monthColor: Colors.blueGrey,
            dayColor: AppThemeColours.TextFieldLineColor,
            dayNameColor: Colors.white,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: AppThemeColours.TextFieldLineColor,
            dotsColor: Colors.white,
            selectableDayPredicate: (date) => date.day != 23,
            //locale: 'en_ISO',
          ),
          //SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 18, top: 10),
              child: FlatButton(
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  
                ),
                color: AppThemeColours.LightPurple,
                child:
                    Text('Today', style: TextStyle(color: AppThemeColours.TextFieldLineColor)),
                onPressed: () => setState(() => _resetSelectedDate()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
