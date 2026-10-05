<<<<<<< HEAD

import 'package:flutter/material.dart';
=======
import 'package:flutter/material.dart';
import 'package:ota_test/pages/page_two.dart';
>>>>>>> 329f168206da03e33cea10e7613d9360322f5496

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
<<<<<<< HEAD
  void _decrementtCounter() {
    setState(() {
      _counter++;
=======

  void _decrementtCounter() {
    setState(() {
      _counter--;
>>>>>>> 329f168206da03e33cea10e7613d9360322f5496
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar( 
=======
      appBar: AppBar(
>>>>>>> 329f168206da03e33cea10e7613d9360322f5496
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
<<<<<<< HEAD
          
=======
>>>>>>> 329f168206da03e33cea10e7613d9360322f5496
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: _decrementtCounter,
              child: const Text('Decrement'),
            ),

<<<<<<< HEAD
=======
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PageTwo()),
                );
              },
              child: const Text('go to page two'),
            ),

>>>>>>> 329f168206da03e33cea10e7613d9360322f5496
            Text(
              'this is patch 2 updated',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
<<<<<<< HEAD
// shorebird patch android
=======
// shorebird patch android
>>>>>>> 329f168206da03e33cea10e7613d9360322f5496
