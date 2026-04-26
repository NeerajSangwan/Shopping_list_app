import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class NewItems extends StatefulWidget {
  const NewItems({super.key});

  @override
  State<NewItems> createState() {
    return _NewItemsState();
  }
}

class _NewItemsState extends State<NewItems> {
  final _formkey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredquantity = 1;
  var _enteredCategory = categories[Categories.vegetables]!;

  void _saveItem() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      Navigator.of(context).pop(
        GroceryItem(
          id: DateTime.now().toString(),
          category: _enteredCategory,
          name: _enteredName,
          quantity: _enteredquantity,
        ),
      );
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add new item')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text('Name')),
                maxLength: 50,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.length <= 1 ||
                      value.length > 50) {
                    return 'Please enter valid name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! < 1) {
                          return 'Please enter valid quantity';
                        }
                        return null;
                      },
                      initialValue: _enteredquantity.toString(),
                      decoration: InputDecoration(label: Text('Quantity')),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _enteredquantity = int.parse(value);
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField(
                      initialValue: _enteredCategory,
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  height: 15,
                                  width: 15,
                                  color: category.value.color,
                                ),
                                SizedBox(width: 8),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _enteredCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formkey.currentState!.reset();
                    },
                    child: Text('Reset'),
                  ),
                  SizedBox(width: 6),
                  ElevatedButton(onPressed: _saveItem, child: Text('Save')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
