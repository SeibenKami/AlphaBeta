import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          //BAckground
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [
                Colors.green.withOpacity(0),
                Colors.green.withOpacity(0.1),
                Colors.green.withOpacity(0.4),
              ],
            )),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // height: size.height,
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //Browser details
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Colors.blue,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'lens',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'fantasy',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    /////Search textfeild
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: 'Search for web address',
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 5),
                            child: Text(
                              "Search",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    ///
                  ],
                ),
              ),

              /////////Recent Searches
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Searches',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  title: Text(
                                    'title $index',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "www.example.com$index ",
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                        "The mabjn jbadsdhds udbsud shdush dhsidh ijshid sihd ishdih sid ish idhsihdishidhishd dihsihd  dhsih$index ",
                                        maxLines: 3,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                  isThreeLine: true,
                                );
                              }))),
                    ],
                  ))
            ]),
          ),
          ///////ADD Tab and dark mode
          Positioned(
            top: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                  width:30,
                  child: TextButton(
                    onPressed: (){
          
                  }, 
                  
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(side:const BorderSide(color: Colors.blue),borderRadius: BorderRadius.circular(5))
                  ),
                  child:const Icon(Icons.add)),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
