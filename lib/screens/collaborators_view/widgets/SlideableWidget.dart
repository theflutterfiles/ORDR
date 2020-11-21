import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlideableWidget<T> extends StatelessWidget {
  final Widget child;

  const SlideableWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => Slidable(
        actionPane: SlidableDrawerActionPane(),
        child: child,
        actions: [
          IconSlideAction(
            caption: 'Email',
            color: Colors.blue,
            icon: Icons.email,
            onTap: () {},
          ),
          IconSlideAction(
            caption: 'View Instagram',
            color: Colors.orange,
            icon: Icons.alternate_email_rounded,
            onTap: () {},
          ),
        ],
      );
}
