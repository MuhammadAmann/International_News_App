import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_news_app/View/Models/news_chanel_headlines_model.dart';
import 'package:international_news_app/view_model/News_viewModel.dart';
import 'package:intl/intl.dart';

class News_Homepage extends StatefulWidget {
  const News_Homepage({super.key});

  @override
  State<News_Homepage> createState() => _News_HomepageState();
}

class _News_HomepageState extends State<News_Homepage> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {},
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
          Icon(
            Icons.menu_rounded,
            color: Colors.blue.shade700,
            size: 30,
          ),
          SizedBox(width: width * .02),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: ListView(
          children: [
            SizedBox(height: hieght * .04),
            Text(
              "Breaking News",
              style: GoogleFonts.montserrat(
                  color: Colors.blue.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: hieght * .02),
            Container(
              // color: Colors.black,
              height: hieght * .43,
              width: width,

              child: FutureBuilder<NewsChanelHeadlinesModel>(
                future: newsViewModel.fetchnewschanelheadlinesAPi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      child: Center(child: Spinkit2),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot
                            .data!.articles![index].publishedAt
                            .toString());
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Container(
                            height: hieght * .4,
                            width: width * .8,
                            decoration: BoxDecoration(
                                // boxShadow: [BoxShadow(blurRadius: 2)],
                                border: Border.all(color: Colors.black12),
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
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: hieght * .01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Container(
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
                                        child: Container(
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
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                        // SizedBox(
                        //   child: Stack(
                        //     alignment: Alignment.center,
                        //     children: [
                        //       Container(
                        //         padding: EdgeInsets.symmetric(
                        //             horizontal: width * .02),
                        //         height: hieght * .7,
                        //         width: width * .8,
                        //         child: ClipRRect(
                        //           borderRadius: BorderRadius.circular(15),
                        //           child: CachedNetworkImage(
                        //             imageUrl: snapshot
                        //                 .data!.articles![index].urlToImage
                        //                 .toString(),
                        //             fit: BoxFit.cover,
                        //             placeholder: (context, url) => Container(
                        //               child: Spinkit2,
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //         bottom: 8,
                        //         child: Card(
                        //           elevation: 5,
                        //           color: Colors.white.withOpacity(0.95),
                        //           shape: RoundedRectangleBorder(
                        //               borderRadius: BorderRadius.circular(10)),
                        //           child: Container(
                        //             // padding: EdgeInsets.all(15),
                        //             height: hieght * .18,
                        //             alignment: Alignment.bottomCenter,
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(6),
                        //               child: Column(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.center,
                        //                 children: [
                        //                   Container(
                        //                     alignment: Alignment.bottomCenter,
                        //                     width: width * 0.7,
                        //                     child: Text(
                        //                       snapshot
                        //                           .data!.articles![index].title
                        //                           .toString(),
                        //                       style: GoogleFonts.montserrat(
                        //                           fontSize: 16,
                        //                           fontWeight: FontWeight.w600),
                        //                       maxLines: 3,
                        //                       overflow: TextOverflow.ellipsis,
                        //                     ),
                        //                   ),
                        //                   Spacer(),
                        //                   Container(
                        //                     width: width * 0.7,
                        //                     child: Row(
                        //                       mainAxisAlignment:
                        //                           MainAxisAlignment
                        //                               .spaceBetween,
                        //                       children: [
                        //                         Text(
                        //                           snapshot
                        //                               .data!
                        //                               .articles![index]
                        //                               .source!
                        //                               .name
                        //                               .toString(),
                        //                           style: GoogleFonts.montserrat(
                        //                               fontWeight:
                        //                                   FontWeight.bold),
                        //                         ),
                        //                         Text(
                        //                           format.format(dateTime),
                        //                           style: GoogleFonts.montserrat(
                        //                               fontWeight:
                        //                                   FontWeight.w600,
                        //                               color: Colors.blue),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  final Spinkit2 = SpinKitThreeBounce(
    color: Colors.grey,
    size: 20,
  );
}
