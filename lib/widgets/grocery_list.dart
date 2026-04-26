import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

import 'package:shopping_list/widgets/new_items.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  void _removeItem(GroceryItem item){
    setState(() {
      _groceryItems.remove(item);
    });
  }

  void _addItemScreen() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewItems()));
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(context) {
    Widget content = Center(child: Text('Oops! Try adding items'));
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (conetxt, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) => _removeItem,
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              height: 25,
              width: 25,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Grocery List'),
        actions: [
          IconButton(
            onPressed: _addItemScreen,
            icon: Icon(Icons.add_circle_outline_sharp),
          ),
        ],
      ),

      body: content,
    );
  }
}
