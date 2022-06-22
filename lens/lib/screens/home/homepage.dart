import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions:const  [
            Text("Dark Mode"),
            
          ],
          backgroundColor: Colors.transparent,
        ),
        body: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
        
                  ])),
        ));
  }
}
