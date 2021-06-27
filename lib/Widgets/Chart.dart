import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Modules/Transactions.dart';
import '../Widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transcaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTranscations {
    // List.generate create a list of given length == 7 for every index i do a specific function
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalsum += recentTransactions[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  double get totalamount {
    return groupedTranscations.fold(0.0, (sum, element) {
      return sum + element['amount'];
    }); // 0.0 that is the first value when function runs we sum values of list to this 0.0

    /// fold help us to change the list to anthor type
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        // i added this widget only i can do padding to the Row s
        padding: EdgeInsets.all(10),
        child: Row(
          children: groupedTranscations.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                child: Chartbar(
                    data['day'],
                    data['amount'],
                    totalamount == 0
                        ? 0
                        : (data['amount'] as double) / totalamount));
          }).toList(),
        ),
      ),
    );
  }
}
