import 'dart:math';
import 'package:flutter/material.dart';
import '../Modules/Transactions.dart';
import 'package:intl/intl.dart';

class TranscactionItem extends StatefulWidget {
  final Transcaction _userTranscactions;
  final Function _deleteTransaction;
  const TranscactionItem({
    Key key,
    @required Transcaction userTranscactions,
    @required Function deleteTransaction,
  })  : _userTranscactions = userTranscactions,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  @override
  _TranscactionItemState createState() => _TranscactionItemState();
}

class _TranscactionItemState extends State<TranscactionItem> {
  Color _choosenColor;
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple
    ];
    _choosenColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _choosenColor,
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                  child: Text('\$${widget._userTranscactions.price}')),
            ),
          ), // circle avatar is widget that by defult is taking a shape of Circle

          title: Text(
            widget._userTranscactions.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle:
              Text(DateFormat.yMMMd().format(widget._userTranscactions.date)),
          trailing: MediaQuery.of(context).size.width > 460
              ? FlatButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  textColor: Theme.of(context).errorColor,
                  onPressed: () => widget._deleteTransaction(
                        widget._userTranscactions.id,
                      ))
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () =>
                      widget._deleteTransaction(widget._userTranscactions.id))),
    );
  }
}
