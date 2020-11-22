import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Collaborator.dart';
import 'package:flutter_app_mindful_lifting/notifiers/auth_notifier.dart';
import 'package:flutter_app_mindful_lifting/notifiers/project_notifier.dart';
import 'package:flutter_app_mindful_lifting/services/project_api.dart';
import 'package:flutter_app_mindful_lifting/styles/colour_styles.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:slide_popup_dialog/slide_popup_dialog.dart' as slideDialog;

class SlideableWidget<T> extends StatefulWidget {
  final Widget child;
  final String instagram;
  final String email;
  final ProjectNotifier projectNotifier;
  final Collaborator collaborator;

  const SlideableWidget(
      {Key key,
      @required this.child,
      @required this.email,
      @required this.projectNotifier,
      @required this.instagram,
      @required this.collaborator})
      : super(key: key);

  @override
  _SlideableWidgetState<T> createState() => _SlideableWidgetState<T>();
}

class _SlideableWidgetState<T> extends State<SlideableWidget<T>> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController instagramController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: widget.child,
      actions: [
        widget.email != null
            ? IconSlideAction(
                caption: 'Email',
                color: Colors.blue,
                icon: Icons.email,
                onTap: () {
                  _launchEmail(widget.email, widget.projectNotifier);
                },
              )
            : null,
        widget.instagram != null
            ? IconSlideAction(
                caption: 'View Insta',
                color: Colors.orange,
                icon: Icons.alternate_email_rounded,
                onTap: () {
                  _launchInstagram(widget.instagram);
                },
              )
            : null,
      ],
      secondaryActions: [
        IconSlideAction(
            caption: 'Edit',
            color: Colors.amber,
            icon: Icons.edit,
            onTap: () {
              slideDialog.showSlideDialog(
                context: context,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    children: [
                      Text("Edit Collaborator", style: AppThemes.display1),
                      TextFormField(
                        initialValue: widget.collaborator.name,
                        //controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.person_rounded,
                            color: AppThemeColours.TextFieldLineColor,
                          ),
                          
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 26,
                            color: AppThemeColours.TextFieldLineColor),
                        cursorColor: Colors.white,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.collaborator.email,
                        //controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: AppThemeColours.TextFieldLineColor,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 26,
                            color: AppThemeColours.TextFieldLineColor),
                        cursorColor: Colors.white,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.collaborator.number,
                        //controller: numberController,
                        decoration: InputDecoration(
                          labelText: "Number",
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.phone_rounded,
                            color: AppThemeColours.TextFieldLineColor,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 26,
                            color: AppThemeColours.TextFieldLineColor),
                        cursorColor: Colors.white,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: widget.collaborator.instagram,
                        //controller: instagramController,
                        decoration: InputDecoration(
                          labelText: "Instagram handle",
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.alternate_email_rounded,
                            color: AppThemeColours.TextFieldLineColor,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontSize: 26,
                            color: AppThemeColours.TextFieldLineColor),
                        cursorColor: Colors.white,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Enter instagram handle';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: RaisedButton(
                          onPressed: () async {
                            Collaborator collab = new Collaborator();
                            collab.name = nameController.text;
                            collab.email = emailController.text;
                            collab.number = numberController.text;
                            collab.instagram = instagramController.text;

                            String currentUserUID = Provider.of<AuthNotifier>(
                                    context,
                                    listen: false)
                                .user
                                .uid;
                            ProjectNotifier projectNotifier =
                                Provider.of<ProjectNotifier>(context,
                                    listen: false);

                            ProjectApi projectApi = new ProjectApi();

                            projectApi.addCollaborator(
                                currentUserUID,
                                projectNotifier.currentProject.id,
                                collab,
                                projectNotifier);

                            Navigator.of(context).pop();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 1.0,
                          color: AppThemeColours.LightPurple,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: AppThemeColours.BlueGreenGradientBox,
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontFamily: 'OpenSans', fontSize: 20),
                            ),
                          ),
                          textColor: Color(0xFF333333),
                        ),
                      ),
                    ],
                  ),
                ),
                barrierColor: Colors.white.withOpacity(0.7),
                pillColor: Colors.grey,
                backgroundColor: Colors.white,
              );
            }),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        )
      ],
    );
  }

  void _launchInstagram(String handle) async {
    var url = "https://instagram.com/$handle";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchEmail(String email, ProjectNotifier projectNotifier) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      //query: 'subject=$projectNotifier.currentProject.porojectName', //add subject and body here
    );

    var url = params.toString();

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
