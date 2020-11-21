import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_mindful_lifting/models/Collaborator.dart';
import 'package:flutter_app_mindful_lifting/styles/text_styles.dart';
import 'package:flutter_app_mindful_lifting/widgets/collaborators/space/empty_widget.dart';

class AlphabeticListView<T extends Collaborator> extends StatefulWidget {

  final int itemCount;
  final List<String> headers;
  final ScrollPhysics physics;
  final List<T> list;
  final String listKey;
  final Widget Function(Map data, int index) item;
  final EdgeInsets padding;
  final bool shrinkWrap;
  final Widget child;

  
  
AlphabeticListView(
      {Key key,
      @required this.headers,
      @required this.itemCount,
      this.physics,
      this.padding,
      this.shrinkWrap,
      @required this.list,
      @required this.listKey,
      this.item,
      this.child})
      : super(key: key);


  @override
  _AlphabeticalListViewState createState() => _AlphabeticalListViewState();
}


class _AlphabeticalListViewState extends State<AlphabeticListView> {
  
  List<String> _headList = [];
  List<Map<String, dynamic>> _mapList = [];
  List<Map<String, dynamic>> _mapListSerach = [];
  int selectedValue = 0;
    

  final int firstIndex = 0;

  final Map<int, String> firstValueMap = {0: "-"};

  @override
  void initState() {
    super.initState();
    headListCreate(widget.headers);
    _mapList = widget.list.map((e) => e.toJson()).toList();
    _mapListSerach = widget.list.map((e) => e.toJson()).toList();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.listKey != widget.listKey) {
      headListCreate(widget.headers);
      setState(() {});
    }
  }

  void headListCreate(List<String> headers) {
    _headList = _headersCharacter(headers);
    _headList.insert(firstValueMap.keys.first, firstValueMap.values.first);
  }

  List<String> _headersCharacter(List<String> headers) {
    final firstCharacterArray =
        headers.map((e) => e.trim()[0]).toSet().toList();
    firstCharacterArray.sort();
    return firstCharacterArray;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [buildExpandedListView(), buildExpandedRightBody()],
    );
  }

  Expanded buildExpandedRightBody() {
    return Expanded(
      child: Column(
        children: <Widget>[Spacer(), buildExpandedRight(), Spacer()],
      ),
    );
  }

  Expanded buildExpandedRight() {
    return Expanded(
      flex: 2,
      child: PageView.builder(
        physics: PageScrollPhysics(),
        onPageChanged: (value) {
          listMapParse(value);
        },
        controller: PageController(viewportFraction: 0.1),
        scrollDirection: Axis.vertical,
        itemCount: _headList.length,
        itemBuilder: (context, index) {
          if (index == firstIndex)
            return buildIconButtonAll(index);
          else
            return Center(child: buildText(index));
        },
      ),
    );
  }

  Expanded buildExpandedListView() {
    return Expanded(flex: 9, child: buildListView());
  }

  ListView buildListView() {
    return ListView(
      shrinkWrap: widget.shrinkWrap ?? false,
      padding: widget.padding ?? EdgeInsets.zero,
      physics: widget.physics ?? NeverScrollableScrollPhysics(),
      children: [
        _customChild,
        ...List.generate(_mapListSerach.length,
            (index) => widget.item(_mapListSerach[index], index))
                    // ..._mapListSerach.map((e) => widget.item(e)).toList()
      ],
    );
  }

  Widget get _customChild =>
      widget.child ??
      EmptyWidget.height(
        value: 0.01,
      );

  IconButton buildIconButtonAll(int index) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;


    return IconButton(
        icon: Icon(
          Icons.search,
          color: selectedValue == index ? Colors.pink : Colors.grey,
          size: selectedValue == index
              ? screenWidth * 0.055
              : screenHeight * 0.015,
        ),
        onPressed: () => listMapParse(index));
  }

  Widget buildText(int index) => Container(
          child: InkWell(
        onTap: () {
          listMapParse(index);
        },
        child: AutoSizeText(
          _headList[index],
          style: selectedValue == index ? boldStyle : normalStyle,
        ),
      ));

  TextStyle get boldStyle => AppThemes.heading
      .copyWith(color: Colors.blue);

  TextStyle get normalStyle => AppThemes.heading;

  void listMapParse(int index) {
    if (index == firstIndex) {
      _mapListSerach = _mapList;
    } else {
      _mapListSerach = _mapList.where((element) {
        if (element is Map) {
          return element.keys.where((subElement) {
            final _valueFirst = element[subElement].toString();
            return subElement == widget.listKey &&
                _valueFirst[firstIndex] == _headList[index];
          }).isNotEmpty;
        }
        return false;
      }).toList();
    }

    setState(() {
      selectedValue = index;
    });
  }
}