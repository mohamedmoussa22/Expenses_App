import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _updateTranscation;
  NewTransaction(this._updateTranscation) {
    print('New Transcation constrocutor ');
  }

  @override
  _NewTransactionState createState() {
    print('new transcation Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  @override
  _NewTransactionState() {
    print('New Transcation constrocutor State');
  }
  final _titleControllor = TextEditingController();
  final _amountControllor = TextEditingController();
  DateTime _selectedDate;
  void initState() {
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  void _submitData(BuildContext context) {
    final checkTitle = _titleControllor.text;
    final checkAmount = double.parse(_amountControllor.text);
    if (checkTitle.isEmpty || checkAmount < 0 || _selectedDate == null) {
      return;
    }
    widget._updateTranscation(checkTitle, checkAmount,
        _selectedDate); // widget. give me access to my class proprty
    Navigator.of(context)
        .pop(); // used to close top most screenthat is dispalyed
  }

  void _prestentDatePicker() {
    showDatePicker(
            // da by3ml 7aga zi natega al kda
            context: context,
            initialDate: DateTime.now(), //alyom aly hybda'
            firstDate: DateTime(2019), //de bdayet al natiga bt3tk
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    }); // w de nehaytha (Then) de lma al user ykhtar date hat3ml hya function nta aly btkhtbha
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                //onChanged: (val) => _titleInput = val,
                controller: _titleControllor,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountControllor,
                keyboardType: TextInputType
                    .number, // lazm ykon al input numebr otherwise false
                onSubmitted: (_) =>
                    _submitData(context), // onsubmitted take a string argument
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      // Exoanded make the child take as mush space exist
                      child: Text(_selectedDate == null
                          ? "No Date Choosen!"
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text("Choose Date"),
                      onPressed: _prestentDatePicker,
                    )
                  ],
                ),
              ),
              //onChanged: (val) => _amountInput = val),
              RaisedButton(
                child: Text('Add Transcaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () => _submitData(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
