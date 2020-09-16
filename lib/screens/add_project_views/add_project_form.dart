import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Project.dart';
import 'package:flutter_app_mindful_lifting/screens/add_project_views/add_project_form.dart';

class AddProjectForm extends StatefulWidget {

  Project project;
  //AddProjectForm({Key key, @required this.project}) : super(key: key);

  @override
  _AddProjectFormState createState() => _AddProjectFormState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController _projectTitleController = new TextEditingController();

class _AddProjectFormState extends State<AddProjectForm> {

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildProjectNameTextField(),
        ],
      ),
    );
  }

  Widget _buildProjectNameTextField() {

    Project project = new Project(null, null, null, null, null, null, null, null, null, null, null, null, null);
    _projectTitleController.text = project.projectName;
    project.projectName = "Name";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 70.0,
          child: TextFormField(
            controller: _projectTitleController,
            //autofocus: true,
            validator: (val) => val.isEmpty ? "Enter project name" : null,
            //return null or helper text
            onChanged: (val) {
              //val is whatever value is in the field, on changed is activated whenever user does absolutely anything in that field
              setState(() => project.projectName = val);
            },
            onFieldSubmitted: (val) {
              _formKey.currentState.validate();
            },
            //keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Color(0xFF333333),
            ),
            decoration: InputDecoration(
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.folder_special,
                  color: Color(0xFF333333),
                ),
                hintText: 'Project Name',
                hintStyle: TextStyle(
                  color: Color(0xFF333333),
                  fontFamily: 'OpenSans',
                )),
          ),
        ),
      ],
    );
  }

}

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
