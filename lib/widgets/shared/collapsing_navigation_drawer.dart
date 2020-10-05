import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/account.dart';
import 'package:flutter_app_mindful_lifting/models/navigation_model.dart';
import 'package:flutter_app_mindful_lifting/services/auth.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'collapsing_list.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  _CollapsingNavigationDrawerState createState() => _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>  with SingleTickerProviderStateMixin{

final AuthService _auth = new AuthService();
 bool isCollapsed = false;
 AnimationController _animationController;
 Animation<double> widthAnimation;
 int currentSelectedIndex = 1;



Stream<QuerySnapshot> getAboutSnapshot(BuildContext context) async* {
  //* allows data to contsantly be open, always open stream

  final Firestore _firestore = Firestore.instance;
  final currentUserUID = await _auth.getCurrentUserUID();
  yield* _firestore
      .collection('users')
      .document(currentUserUID)
      .collection('about')
      .snapshots();
}

@override
  void initState() {
    
    super.initState();
    _animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 150),);
    widthAnimation = Tween<double>(begin: 250, end: 90).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {


    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
   

    return AnimatedBuilder(animation: _animationController, builder: (context, widget) => getWidget(context, widget) ,);
  }

  Widget getWidget(BuildContext context, Widget widget){
    return Container(
      width: widthAnimation.value,
      decoration: new BoxDecoration(
        color: Color(0xFF333344),
        
        //borderRadius: BorderRadius.circular(10),
              border: new Border(
                  //right: new BorderSide(width: 1.0, color: Colors.white)
                  
                  ),
                  
                  //borderRadius: BorderRadius.circular(35)
                  ),
      
      //color: Color(0xFF333333),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Align(
            alignment: (widthAnimation.value >= 220) ? Alignment.topRight : Alignment.center,
            child: InkWell(
              child: Icon(
                Icons.more_vert, 
                color: Color(0xFFC4C4C4), 
                size: 40,),
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                    isCollapsed ? _animationController.reverse() : _animationController.forward();
                  });
                },
                ),
        ),
          ),
          Container(
            child: StreamBuilder(
                stream: getAboutSnapshot(context),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: SpinKitRing(
                        color: Colors.teal,
                        size: 50.0,
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(left:20.0),
                      child: Container(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  AccountTile(context, snapshot.data.documents[index]))),
                    );          
                  }
                }),
          ),
          Divider(height: 14, color: Color(0xFFEBEBEB),),
          Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: ListView.builder(itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.only(left: 5.0, bottom: 20.0),
                child: CollapsingListTitle(
                  onTap: (){
                    switch (index){
                      case 0 : {Navigator.pop(context);} break;
                      case 1 : 
                    }
                  },
                  isSelected: currentSelectedIndex == index,
                  icon: navigationItems[index].icon,
                  title: navigationItems[index].title,
                  animationController: _animationController, 
                  ),
              );
            },
            itemCount: navigationItems.length,
            ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 108.0, left: 20.0),
            child: CollapsingListTitle(
                  isSelected: false,
                  icon: Icons.settings,
                  title: 'Settings',
                  animationController: _animationController,
                 onTap: () {},
                  ),
          ),
        ],
      ),
    );
  }

Widget AccountTile(BuildContext context, DocumentSnapshot accountDetails){

  final Account userAccount = Account.fromSnapshot(accountDetails);
  return Column(
    children: [
      AvatarListTitle(displayName: accountDetails['displayName'], 
      animationController: _animationController,
        ),
    ],
  );
}

}

