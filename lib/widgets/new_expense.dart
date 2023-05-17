import 'package:flutter/material.dart';
import 'package:three_expense_tracker_app/models/expense.dart';
class NewExpense extends StatefulWidget {
  const NewExpense(this._onAddExpense,{super.key});

  final void Function(Expense expense) _onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var  _enteredTitle = ' ';           // METHOD 1

  // void _saveTitleInput(String inputValue){
  //   _enteredTitle = inputValue;
  // }

  // METHOD 2
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.Leisure;

  @override
  void dispose(){     // For disposing controller when widget not in use
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  void _presentDatePicker() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year-1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: now
    );
    //this line only be executed when value is available
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseDate(){  
    final _enteredAmount = double.tryParse(_amountController.text);    // tryParse('hello') => null, 
    if(_titleController.text.trim().isEmpty || _enteredAmount == null || _enteredAmount<=0 || _selectedDate == null){
      //show error message
      showDialog(
        context: context, 
        builder: (ctx){
          return AlertDialog(
            title: Text('Invalid input'),
            content: Text('Please enter valid data'),
            actions: [
              TextButton(
                onPressed: (){Navigator.pop(context);},
                child: const Text('Ok')
              )
            ],
          );
        }
      );
      return;
    }

    widget._onAddExpense(Expense(title: _titleController.text, amount: _enteredAmount, date: _selectedDate!, category: _selectedCategory));
    Navigator.pop(context);
  } 

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            // onChanged: _saveTitleInput,  // METHOD 1
            controller: _titleController,    // METHOD 2
            textCapitalization: TextCapitalization.words,
            maxLength: 50,
            // keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              // hintText: 'title',
              label: Text('Title')
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                          // onChanged: _saveTitleInput,  // METHOD 1
                  controller: _amountController,    // METHOD 2
                  maxLength: 50,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                // hintText: 'title',
                    prefixText: 'Rs. ',
                    label: Text('Amount')
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null ? 'No date selected' : formatter.format(_selectedDate!)),
                    IconButton(onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month)),
                  ],
                )
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map((category){
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toString(),),
                  );
                }).toList(), 
                onChanged: (value){
                  if(value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });;
                }
              ),
              const Spacer(),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Cancel')
              ),
              const SizedBox(width: 24,),
              ElevatedButton(
                onPressed: _submitExpenseDate, 
                  child: const Text('Save Expense')
              ),
            ],
          ),
          
          
        ],
      ),
    );
  }
}