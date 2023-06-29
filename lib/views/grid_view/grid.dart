import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridViewScreen extends StatefulWidget {
  @override
  _GridViewScreenState createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {

  final List<String> _listItem = [
    'assets/images/two.jpg',
    'assets/images/three.jpg',
    'assets/images/four.jpg',
    'assets/images/five.jpg',
    'assets/images/one.jpg',
    'assets/images/two.jpg',
    'assets/images/three.jpg',
    'assets/images/four.jpg',
    'assets/images/five.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.menu),
        title: Text("Home"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 36,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("0")),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage('assets/images/one.jpg'),
                    fit: BoxFit.cover
                  )
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(.4),
                        Colors.black.withOpacity(.2),
                      ]
                    )
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Lifestyle Sale", style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),),
                      SizedBox(height: 30,),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: Center(child: Text("Shop Now", style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold),)),
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: _listItem.map((item) => Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(item),
                          fit: BoxFit.cover
                        )
                      ),
                      child: Transform.translate(
                        offset: Offset(50, -50),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                          ),
                          child: Icon(Icons.bookmark_border, size: 15,),
                        ),
                      ),
                    ),
                  )).toList(),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_gridview_demo/model/color_model.dart';
// import 'package:flutter_gridview_demo/model/grid_items_model.dart';
// import 'package:flutter_gridview_demo/route_names.dart';
// class GridViewDemo extends StatefulWidget {
//   @override
//   _GridViewDemoState createState() => _GridViewDemoState();
// }

// class _GridViewDemoState extends State<GridViewDemo> {


//   List<GridListItems> items = [
//     GridListItems(color:Colors.green,title: 'Bicycle', icon: Icons.directions_bike),
//     GridListItems(color:Colors.pink[300],title:'Boat', icon: Icons.directions_boat),
//     GridListItems(color:Colors.pink[300],title: 'Bus', icon: Icons.directions_bus),
//     GridListItems(color:Colors.pink[300],title: 'Train', icon: Icons.directions_railway),
//     GridListItems(color:Colors.pink[300],title: 'Walk', icon: Icons.directions_walk),
//     GridListItems(color:Colors.pink[300],title: 'Contact', icon: Icons.contact_mail),
//     GridListItems(color:Colors.green,title: 'Bicycle', icon: Icons.directions_bike),
//     GridListItems(color:Colors.pink[300],title:'Boat', icon: Icons.directions_boat),
//     GridListItems(color:Colors.pink[300],title: 'Bus', icon: Icons.directions_bus),
//     GridListItems(color:Colors.pink[300],title: 'Train', icon: Icons.directions_railway),
//     GridListItems(color:Colors.pink[300],title: 'Walk', icon: Icons.directions_walk),
//     GridListItems(color:Colors.pink[300],title: 'Contact', icon: Icons.contact_mail),
//     GridListItems(color:Colors.green,title: 'Bicycle', icon: Icons.directions_bike),
//     GridListItems(color:Colors.pink[300],title:'Boat', icon: Icons.directions_boat),
//     GridListItems(color:Colors.pink[300],title: 'Bus', icon: Icons.directions_bus),
//     GridListItems(color:Colors.pink[300],title: 'Train', icon: Icons.directions_railway),
//     GridListItems(color:Colors.pink[300],title: 'Walk', icon: Icons.directions_walk),
//     GridListItems(color:Colors.pink[300],title: 'Contact', icon: Icons.contact_mail),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.count(
//         crossAxisCount: 2,
//         childAspectRatio: (2 / 1),
//         crossAxisSpacing: 5,
//         mainAxisSpacing: 5,
//         //physics:BouncingScrollPhysics(),
//         padding: EdgeInsets.all(10.0),
//         children: items.map((data) =>

//             GestureDetector(
//                 onTap: (){
//                   Navigator.of(context).pushNamed(RouteName.GridViewBuilder);
//                   },
//                 child: Container(
//                   padding: const EdgeInsets.all(16),

//                 //  margin:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
//                   //color:data.color,
//                   color: RandomColorModel().getColor(),
//                   child: Column(
//                       children: [
//                         Icon(data.icon,size:25,color:Colors.black,),
//                         Text(data.title,
//                             style: TextStyle(fontSize: 18, color: Colors.black),
//                             textAlign: TextAlign.center)
//                       ],
//                     ),
//                    )),

//         ).toList(),
//       ),
//     );
//   }
// }