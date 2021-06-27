// Notes:
/* 1- ListView (children:) || ListView.builder() what is differemce ? 
 Answer : they are doing the same thing there no critcal differnce exepct that ListView.builder() only render
 the visible content when ypu scroll 8in Childern but ListView(children: ) render all content it has in long contents it cause a 
 bad performance 
*/
import 'package:flutter/material.dart';
import '../Modules/Transactions.dart';
import 'transcationitem.dart';

class TransactionList extends StatelessWidget {
  final List<Transcaction> _userTranscactions;
  final Function _deleteTransaction;
  TransactionList(this._userTranscactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return _userTranscactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'No transaction add yet ! ',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 20), // give us a empty space
                Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit
                          .cover, // this tell image to take the size of conatiner that wrap it
                    ))
              ],
            );
          })
        : ListView(
            // by defult feha scroll
            // build in widget that has a good  style and has good layout for list
            children: _userTranscactions
                .map((index) => TranscactionItem(
                    key: ValueKey(index.id),
                    userTranscactions: index,
                    deleteTransaction: _deleteTransaction))
                .toList(),
            /*Card(
                    child: Row(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width:
                                    2)), // context holding a lot of metadata of tree of widgets that is passed as parameter to build method and

                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${_userTranscactions[index].price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                        )),
                    Column(
                      // column always takes all the height it can get
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_userTranscactions[index].title,
                            style: Theme.of(context).textTheme.title),
                        Text(
                          DateFormat.yMMMd()
                              .format(_userTranscactions[index].date),
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    )
                  ],
                ))*/

            // List view has infinite height so if you put it outside an a wrapper it will not appear in the screen so it always need a parent
          );
  }
}
