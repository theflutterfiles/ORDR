import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Collaborator.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CollaboratorsListView extends StatefulWidget {
  @override
  _CollaboratorsListViewState createState() => _CollaboratorsListViewState();
}

class _CollaboratorsListViewState extends State<CollaboratorsListView> {
  
  List<Collaborator> collabsList = [];

  List<String> strList = [];

  List<Widget> favouriteList = [];

  List<Widget> normalList = [];

  TextEditingController searchController = TextEditingController();

  filterList() {
    List<Collaborator> collabs =
        Provider.of<ProjectNotifier>(context, listen: false).collabsList;
    
    favouriteList = [];
    normalList = [];
    strList = [];
    if (searchController.text.isNotEmpty) {
      collabs.retainWhere((collab) => collab.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase()));
    }
    collabs.forEach((collab) {
      normalList.add(
        Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
            IconSlideAction(
              iconWidget: Icon(Icons.star),
              onTap: () {},
            ),
            IconSlideAction(
              iconWidget: Icon(Icons.more_horiz),
              onTap: () {},
            ),
          ],
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage("http://placeimg.com/200/200/people"),
            ),
            title: Text(collab.name),
            subtitle: Text(collab.email),
          ),
        ),
      );
      strList.add(collab.name);
    });

    setState(() {
      strList;
      favouriteList;
      normalList;
      strList;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var currentStr = "";
    return AlphabetListScrollView(
      strList: strList,
      highlightTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      showPreview: true,
      itemBuilder: (context, index) {
        return normalList[index];
      },
      indexedHeight: (i) {
        return 80;
      },
      keyboardUsage: true,
      headerWidgetList: <AlphabetScrollListHeader>[
        AlphabetScrollListHeader(widgetList: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffix: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                labelText: "Search",
              ),
            ),
          )
        ], icon: Icon(Icons.search), indexedHeaderHeight: (index) => 80),
        AlphabetScrollListHeader(
            widgetList: favouriteList,
            icon: Icon(Icons.star),
            indexedHeaderHeight: (index) {
              return 80;
            }),
      ],
    );
  }
}
