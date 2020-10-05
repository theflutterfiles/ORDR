import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/shared/shared_methods.dart';

class CollapsingListTitle extends StatefulWidget {

final String title;
final IconData icon;
final AnimationController animationController;
bool isSelected = false;
final Function onTap;



CollapsingListTitle({@required this.title, @required this.icon, @required this.animationController, this.isSelected, @required this.onTap});

  @override
  _CollapsingListTitleState createState() => _CollapsingListTitleState();
}

class _CollapsingListTitleState extends State<CollapsingListTitle> {

  Animation<double> _widthAnimation;
    

  @override
  void initState() {
    super.initState();
    _widthAnimation = Tween<double>(begin: 250, end: 90).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 18),
            padding: EdgeInsets.only(top: 10, left: 7, bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16),),
            color: (widget.isSelected) ? Colors.transparent.withOpacity(0.3) : Colors.transparent
            ),
            child: Row(
        children: [
            Icon(widget.icon, color: widget.isSelected ? AppThemeColours.NavigationSelectedColor :Color(0xFFC4C4C4) ,size: 35,),
            SizedBox(width: 10,),
            (_widthAnimation.value >= 220 ) 
            ? Text(widget.title, 
            style: TextStyle(
              fontSize: 20,
              color: (widget.isSelected) 
              ? Colors.white 
              : AppThemeColours.NavigationSelectedBackgroundColor),)
              : Container()
        ],
      ),
          ),
    );
  }
}

class AvatarListTitle extends StatefulWidget {

  final String displayName;
  final AnimationController animationController;
  final Function onTap;

  const AvatarListTitle({Key key, @required this.displayName, this.animationController, this.onTap}) : super(key: key);

  @override
  _AvatarListTitleState createState() => _AvatarListTitleState();
}

class _AvatarListTitleState extends State<AvatarListTitle> {

  Animation<double> _widthAnimation;
    
  @override
  void initState() {
    super.initState();
    _widthAnimation = Tween<double>(begin: 250, end: 90).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
              backgroundColor: AppThemeColours.NavigationSelectedColor,
              foregroundColor: Color(0xFF333333),
              child: Text(
                  getInitial(string: widget.displayName, limitTo: 1),
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
            ),
        ),
        SizedBox(width: 10,),
        (_widthAnimation.value >= 220 ) 
        ? Text(widget.displayName, style: AppThemes.avatarListText)
        : Container(),
      ],
    );
  }
}