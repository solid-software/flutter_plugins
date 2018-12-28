import 'package:flutter/material.dart';
import 'package:menu_swipe_helpers/menu_swipe_helpers.dart';

const String _kAsset0 = 'avatars/yann.jpg';
const String _kGalleryAssetsPackage = 'flutter_plugins_assets';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new DrawerProvider(
        drawer: _drawerBuilder,
        child: new FirstPage(
          title: "First Page",
        ),
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  final String title;

  FirstPage({this.title});

  @override
  _FirstPage createState() => new _FirstPage();
}

// ignore: mixin_inherits_from_not_object
class _FirstPage extends State<FirstPage> with DrawerStateMixin {
  List<Widget> buildActions() => [
        new IconButton(
            icon: new Icon(Icons.chevron_right),
            onPressed: () => Navigator.of(context).push(
                new MaterialPageRoute<Null>(builder: (BuildContext context) => new SecondPage()))),
      ];

  @override
  Widget buildBody() {
    var _style = Theme.of(context).textTheme.subhead;
    return new Container(
        decoration: new BoxDecoration(color: Colors.green),
        child: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(32.0),
                child: new Text('''
Very basic page, go to the other pages to see more
              ''', style: _style, softWrap: true),
              ),
            ],
          ),
        ));
  }

  @override
  String get title => widget.title;
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPage createState() => new _SecondPage();
}

// ignore: mixin_inherits_from_not_object
class _SecondPage extends State<SecondPage> with DrawerStateMixin {
  @override
  Widget buildBody() {
    var _style = Theme.of(context).textTheme.subhead;
    return new Container(
        decoration: new BoxDecoration(color: Colors.red),
        child: new Center(
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Text("Demo", style: _style),
              new Padding(
                padding: const EdgeInsets.all(32.0),
                child: new Text('''
Action in app bar
Persistent Footer Button
Floating button
              ''', style: _style, softWrap: true),
              ),
            ],
          ),
        ));
  }

  @override
  List<Widget> buildPersistentFooterButtons() {
    return [
      new ButtonBar(
        alignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new FlatButton(
              onPressed: () => {
                    //TODO not implemented
                  },
              child: new Row(
                children: <Widget>[
                  new Text("BUTTON"),
                ],
              )),
        ],
      )
    ];
  }

  @override
  Widget buildFloatingButton() {
    return new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () => {
              //TODO not implemented
            });
  }

  @override
  String get title => "Second Page";

  @override
  bool get hideDrawer => true;
}

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPage createState() => new _ThirdPage();
}

class _ThirdPage extends State<ThirdPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _first = true;

  void updateDrawer() {
    DrawerProvider.changeDrawer(context, _first ? _drawerBuilder2 : _drawerBuilder);
    _first = !_first;
  }

  @override
  Widget build(BuildContext context) {
    var _style = Theme.of(context).textTheme.subhead;

    return new Scaffold(
      key: _scaffoldKey,
      drawer: DrawerProvider.drawerOf(context),
      body: new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            new InkWell(
              child: new Text(
                '''
Page from scatch 
TAP to open the drawer
              ''',
                style: _style,
                softWrap: true,
              ),
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
            new RaisedButton(
                child: new Row(
                  children: <Widget>[
                    new Text("Change menu swipe"),
                  ],
                ),
                onPressed: () {
                  updateDrawer();
                })
          ],
        ),
      ),
    );
  }
}

Widget _userAccountDrawer(BuildContext context) => new UserAccountsDrawerHeader(
      accountName: new Text("Yann-Cyril Pelud"),
      accountEmail: new Text("yann@fidelisa.com"),
      currentAccountPicture: new CircleAvatar(
        backgroundImage: new AssetImage(
          _kAsset0,
          package: _kGalleryAssetsPackage,
        ),
      ),
      margin: EdgeInsets.zero,
    );

var _firstPage = new DrawerDefinition(
    title: "First page",
    iconData: Icons.home,
    widgetBuilder: (BuildContext context) => new FirstPage(title: "First Page"));

var _secondPage = new DrawerDefinition(
    title: "Second page",
    iconData: Icons.store,
    widgetBuilder: (BuildContext context) => new SecondPage(),
    hideDrawer: true);

var _thirdPage = new DrawerDefinition(
    title: "Third page",
    iconData: Icons.email,
    widgetBuilder: (BuildContext context) => new ThirdPage());

var _fourthPage = new DrawerDefinition(
    title: "Fourth page",
    iconData: Icons.home,
    widgetBuilder: (BuildContext context) => new FirstPage(title: "Fourth Page"));

var _drawerBuilder = new DrawerHelper(
  drawerContents: [_firstPage, _secondPage, _thirdPage],
  userAccountsDrawerHeader: _userAccountDrawer,
);

var _drawerBuilder2 = new DrawerHelper(
    drawerContents: [_firstPage, _secondPage, _thirdPage, _fourthPage],
    userAccountsDrawerHeader: _userAccountDrawer);
