import 'dart:io';

import 'package:flutter/material.dart';

import 'Widgets/Chart.dart';
import 'Modules/Transactions.dart';
import 'Widgets/transaction_list.dart';
import 'Widgets/new_transactions.dart';
import 'package:flutter/services.dart';

void main() {
  ///next three line i  wrote it solve landscape mode simply when user want to switch to this mode i force the app to be in portariet mode (Lazy solution )
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
          // in Theme you Create your own Style that you will use and you can call it in different places in your code so you don't repeat the same code for many places
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transcaction> _transcaction = [];
  List<Transcaction> get _recentTransactions {
    return _transcaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList(); // where let you run a function on every element in list if true the item kept in new retunred list otherwise it not include in list s
  }

  bool _showChart = false;

  void _addTranscation(String title, double amount, DateTime choosenDate) {
    final transObj = Transcaction(
        title: title,
        price: amount,
        date: choosenDate,
        id: DateTime.now().toString());
    setState(() {
      _transcaction.add(transObj);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            // this calss with this parameters pervent the Sheet to close when  user tap on it
            child: NewTransaction(_addTranscation),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTranscation(String id) {
    setState(() {
      _transcaction.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      // we put app abrd in variable to
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
      title: Text(
        'Mohamed Moussa Flutter App',
      ),
    );
    final txWidget = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7 // perfered.size.height to get the height of appBar,
        ,
        child: TransactionList(_transcaction, _deleteTranscation));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: , da 3shan azabt al X-xais
          //mainAxisAlignment:MainAxisAlignment.spaceAround, // 3shan azabt al Y-axis
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //center widgets at middle of screen
                children: <Widget>[
                  Text("Show Chart"),
                  Switch.adaptive(
                      activeColor: Theme.of(context).accentColor,
                      // make a button that i can use to switch between widgets either one is on or off addaptive is button take a different shape in andriod or I phone
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding
                              .top) * // perfered.size.height to get the height of appBar
                      0.3,
                  child: Chart(_transcaction)),
            if (!isLandscape) txWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding
                                  .top) * // perfered.size.height to get the height of appBar
                          0.7,
                      child: Chart(_transcaction))
                  : txWidget,
          ],
        ),
      ),
      floatingActionButton: Platform
              .isIOS // platform is to check whicj platform my app is run into IOS or andriod or mac or etc
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
