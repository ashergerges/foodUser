import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food_users/assistantMethods/assistant_methods.dart';
import 'package:food_users/authentication/auth_screen.dart';
import 'package:food_users/global/global.dart';
import 'package:food_users/models/sellers.dart';
import 'package:food_users/widgets/sellers_design.dart';
import 'package:food_users/widgets/my_drawer.dart';
import 'package:food_users/widgets/progress_bar.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{
  final items = [
    "assets/slider/0.jpg",
    "assets/slider/1.jpg",
    "assets/slider/2.jpg",
    "assets/slider/3.jpg",
    "assets/slider/4.jpg",
    "assets/slider/5.jpg",
    "assets/slider/6.jpg",
    "assets/slider/7.jpg",
    "assets/slider/8.jpg",
    "assets/slider/9.jpg",
    "assets/slider/10.jpg",
    "assets/slider/11.jpg",
    "assets/slider/12.jpg",
    "assets/slider/13.jpg",
    "assets/slider/14.jpg",
    "assets/slider/15.jpg",
    "assets/slider/16.jpg",
    "assets/slider/17.jpg",
    "assets/slider/18.jpg",
    "assets/slider/19.jpg",
    "assets/slider/20.jpg",
    "assets/slider/21.jpg",
    "assets/slider/22.jpg",
    "assets/slider/23.jpg",
    "assets/slider/24.jpg",
    "assets/slider/25.jpg",
    "assets/slider/26.jpg",
    "assets/slider/27.jpg",
  ];

  @override
  void initState() {
    super.initState();

    clearCartNow(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.cyan,
                  Colors.amber,
                ],
                begin:  FractionalOffset(0.0, 0.0),
                end:  FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )
          ),
        ),
        title: const Text(
          "iFood",
          style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * .3,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    autoPlayAnimationDuration: const Duration(milliseconds: 500),
                    autoPlayCurve: Curves.decelerate,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                  items: items.map((index) {
                    return Builder(builder: (BuildContext context){
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                              index,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    });
                  }).toList(),
                ),
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("sellers")
                .snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                      itemBuilder: (context, index)
                      {
                        Sellers sModel = Sellers.fromJson(
                          snapshot.data!.docs[index].data()! as Map<String, dynamic>
                        );
                        //design for display sellers-cafes-restuarents
                        return SellersDesignWidget(
                          model: sModel,
                          context: context,
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
            },
          ),
        ],
      ),
    );
  }
}
