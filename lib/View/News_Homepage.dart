import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_news_app/View/DetailScreen.dart';
import 'package:international_news_app/View/Models/catagory_newsmodel.dart';
import 'package:international_news_app/View/Models/news_chanel_headlines_model.dart';
import 'package:international_news_app/View/nav_bar.dart';
import 'package:international_news_app/View/catagories_naws.dart';
import 'package:international_news_app/view_model/News_viewModel.dart';
import 'package:intl/intl.dart';

class News_Homepage extends StatefulWidget {
  const News_Homepage({super.key});

  @override
  State<News_Homepage> createState() => _News_HomepageState();
}

enum filterlist { bbc_news, Arynews, Cnn, aljazeera, independent }

class _News_HomepageState extends State<News_Homepage> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMM dd, yyyy');
  filterlist? selectedmenu;
  String name = "bbc-news";

  final colorizeColors = [
    Colors.black,
    Colors.white60,
  ];

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Catagories_News(),
                  ));
            },
            icon: Image.asset(
              "images/category_icon.png",
              color: Colors.blue.shade700,
              height: 25,
              width: 25,
            )),
        title: Text(
          "News",
          style: GoogleFonts.montserrat(
              color: Colors.blue.shade700,
              fontSize: 24,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<filterlist>(
            initialValue: selectedmenu,
            icon: Icon(
              Icons.more_vert,
              color: Colors.blue.shade700,
            ),
            onSelected: (filterlist item) {
              if (filterlist.bbc_news.name == item.name) {
                name = 'bbc-news';
              }
              if (filterlist.Arynews.name == item.name) {
                name = 'ary-news';
              }
              if (filterlist.Cnn.name == item.name) {
                name = "cnn";
              }
              if (filterlist.aljazeera.name == item.name) {
                name = "al-jazeera-english";
              }
              if (filterlist.independent.name == item.name) {
                name = "independent";
              }
              setState(() {});
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<filterlist>>[
              const PopupMenuItem<filterlist>(
                  value: filterlist.bbc_news, child: Text("BBC News")),
              const PopupMenuItem<filterlist>(
                  value: filterlist.Arynews, child: Text("ARY News")),
              const PopupMenuItem<filterlist>(
                  value: filterlist.aljazeera, child: Text("AlJazeera News")),
              const PopupMenuItem<filterlist>(
                  value: filterlist.Cnn, child: Text("CNN News")),
              const PopupMenuItem<filterlist>(
                  value: filterlist.independent, child: Text("Independent")),
            ],
          ),
          SizedBox(width: width * .01),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4),
        child: ListView(
          children: [
            SizedBox(height: hieght * .04),
            Text(
              "Worldwide Breaking News",
              style: GoogleFonts.montserrat(
                  color: Colors.blue.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: hieght * .02),
            SizedBox(
              // color: Colors.black,
              height: hieght * .43,
              width: width,

              child: FutureBuilder<NewsChanelHeadlinesModel>(
                future: newsViewModel.fetchnewschanelheadlinesAPi(name),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Spinkit2);
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        DateTime: format.format(dateTime),
                                        image: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        author: snapshot
                                            .data!.articles![index].author
                                            .toString(),
                                        newschanel: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        title: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString())));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              height: hieght * .4,
                              width: width * .8,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.05)),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: Spinkit2,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: hieght * .01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SizedBox(
                                          height: hieght * .1,
                                          width: width * .8,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: hieght * .02,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SizedBox(
                                          height: hieght * .03,
                                          width: width * .8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: GoogleFonts.montserrat(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.blue),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            //General News Horizontal List
            SizedBox(height: hieght * .04),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "General Updates",
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.montserrat(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: hieght * .015),
            SizedBox(
              // color: Colors.black,
              height: hieght * .36,
              width: width,

              child: FutureBuilder<CatagoryNewsModel>(
                future: newsViewModel.fetchCatagoryNewsAPi("General"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Spinkit2);
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        DateTime: format.format(dateTime),
                                        image: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        author: snapshot
                                            .data!.articles![index].author
                                            .toString(),
                                        newschanel: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        title: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString())));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              height: hieght * .3,
                              width: width * .6,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.05)),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      height: hieght * .2,
                                      width: width * .6,
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: Spinkit2,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: hieght * .01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SizedBox(
                                          height: hieght * .1,
                                          width: width * .8,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        height: hieght * .01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          format.format(dateTime),
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(
                                      //       horizontal: 10),
                                      //   child: SizedBox(
                                      //     height: hieght * .03,
                                      //     width: width * .8,
                                      //     child: Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.spaceBetween,
                                      //       children: [
                                      //         // Text(
                                      //         //   snapshot.data!.articles![index]
                                      //         //       .source!.name
                                      //         //       .toString(),
                                      //         //   style: GoogleFonts.montserrat(
                                      //         //       fontWeight: FontWeight.bold),
                                      //         // ),
                                      //         Text(
                                      //           format.format(dateTime),
                                      //           style: GoogleFonts.montserrat(
                                      //               fontWeight: FontWeight.w600,
                                      //               color: Colors.blue),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            //Sports News Horintal List
            SizedBox(height: hieght * .04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "General Updates",
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.montserrat(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),

            SizedBox(height: hieght * .015),
            SizedBox(
              height: hieght * .36,
              width: width,
              child: FutureBuilder<CatagoryNewsModel>(
                future: newsViewModel.fetchCatagoryNewsAPi("Sports"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Spinkit2);
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        DateTime: format.format(dateTime),
                                        image: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        author: snapshot
                                            .data!.articles![index].author
                                            .toString(),
                                        newschanel: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        title: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString())));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              height: hieght * .3,
                              width: width * .6,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.05)),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      height: hieght * .2,
                                      width: width * .6,
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: Spinkit2,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: hieght * .01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SizedBox(
                                          height: hieght * .1,
                                          width: width * .8,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: hieght * .01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          format.format(dateTime),
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            //Business News Horintal List
            SizedBox(height: hieght * .04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "General Updates",
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.montserrat(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),

            SizedBox(height: hieght * .015),
            SizedBox(
              height: hieght * .36,
              width: width,
              child: FutureBuilder<CatagoryNewsModel>(
                future: newsViewModel.fetchCatagoryNewsAPi("Business"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Spinkit2);
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        DateTime: format.format(dateTime),
                                        image: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        author: snapshot
                                            .data!.articles![index].author
                                            .toString(),
                                        newschanel: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        title: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString())));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              height: hieght * .3,
                              width: width * .6,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.05)),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      height: hieght * .2,
                                      width: width * .6,
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: Spinkit2,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: hieght * .01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SizedBox(
                                          height: hieght * .1,
                                          width: width * .8,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: hieght * .01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          format.format(dateTime),
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            //Health News Horintal List
            SizedBox(height: hieght * .04),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "General Updates",
                  style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: GoogleFonts.montserrat(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: hieght * .015),
            SizedBox(
              height: hieght * .36,
              width: width,
              child: FutureBuilder<CatagoryNewsModel>(
                future: newsViewModel.fetchCatagoryNewsAPi("bitcoin"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Spinkit2);
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        DateTime: format.format(dateTime),
                                        image: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        author: snapshot
                                            .data!.articles![index].author
                                            .toString(),
                                        newschanel: snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        title: snapshot
                                            .data!.articles![index].title
                                            .toString(),
                                        description: snapshot
                                            .data!.articles![index].description
                                            .toString())));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Container(
                              height: hieght * .3,
                              width: width * .6,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.05)),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      height: hieght * .2,
                                      width: width * .6,
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => Container(
                                        child: Spinkit2,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: hieght * .01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: SizedBox(
                                          height: hieght * .1,
                                          width: width * .8,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: hieght * .01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          format.format(dateTime),
                                          style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.blue),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),

            SizedBox(height: hieght * .04),
            Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'discover more >',
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Catagories_News(),
                      ));
                },
              ),
            ),
            SizedBox(height: hieght * .04),
          ],
        ),
      ),
    );
  }

  final Spinkit2 = const SpinKitThreeBounce(
    color: Colors.grey,
    size: 20,
  );
}
