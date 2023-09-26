import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveExample extends StatelessWidget {
   HiveExample({Key? key}) : super(key: key);
  late Box testPutBox;
  late Box testAddBox;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Hive',
        )),
        backgroundColor: Colors.blueAccent,
      ),
      body:  Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async{
              await Hive.openBox<String>('test');
              print(' opened successfully');
              },
              child: const Text(
                'Open Box',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Box box= Hive.box<String>('test');
                print(' accessed successfully');
              },
              child: const Text(
                'Access Box',
              ),
            ),

            ElevatedButton(
              onPressed: () async{
                testPutBox= await Hive.openBox('testPut');
                print(' testPut opened successfully');
              },
              child: const Text(
                'Open test put Box',
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                //TODO:https://www.youtube.com/watch?v=6VWbh8VJDto&list=PL9b6wgodx-C3VRvma06Lz6Y7-fr5fMy6K&index=4

              // testPutBox.put('name', 'marwan'); لو هدخل متغير واحد فقط
              //   testPutBox.putAll( // لو هدخل اكتر من متغير
              //     {
              //       'name':'marwan ali',
              //       'age':20,
              //     }
                    testPutBox.putAt(0, 'x'); // الاضافة بالاندكس
                print(' put data in test put Box successfully');
              },
              child: const Text(
                'put data in test put Box',
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                print('${testPutBox.get('age',)}',);
              //  print('${testPutBox.getAt(0,)}',);// الطباعة بالاندكس
              },
              child: const Text(
                'display data from test put Box',
              ),
            ),

            ElevatedButton(
              onPressed: () async{
                testAddBox=await Hive.openBox('testAddBox');
                print('testAddBox opened successfully');
              },
              child: const Text(
                'Open test add Box',
              ),
            ),
            ElevatedButton(
              onPressed: () async{
               testAddBox.add('ffAdd'); // بتضيف بالفاليو في اقرب اندكس فاضي
             testAddBox.put(100, '100');
             testAddBox.add('value 101');
                print('add data in test add Box successfully');
              },
              child: const Text(
                'add data in test add Box',
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                print('${testAddBox.get(5)}');
                print('${testAddBox.get(100)}');
                print('${testAddBox.get(110)}');
                print('display data from tes add Box successfully');
              },
              child: const Text(
                'display data from test add Box',
              ),
            ),

          ],
        ),
      ),
    );
  }
}
