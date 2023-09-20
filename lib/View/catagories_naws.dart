import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_news_app/View/Models/catagory_newsmodel.dart';
import 'package:international_news_app/View/News_Homepage.dart';
import 'package:international_news_app/repository/news_repo.dart';
import 'package:international_news_app/view_model/News_viewModel.dart';
import 'package:intl/intl.dart';

class Catagories_News extends StatefulWidget {
  const Catagories_News({super.key});

  @override
  State<Catagories_News> createState() => _Catagories_NewsState();
}

class _Catagories_NewsState extends State<Catagories_News> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMM dd, yyyy');
  String CatagoryName = "General";

  List<String> CatagoriesList = [
    "General",
    "Enterainment",
    "Health",
    "Business",
    "Technology"
  ];

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "News Catagories",
            style: GoogleFonts.montserrat(
                color: Colors.blue.shade700, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.blue.shade700,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: hieght * .01,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: CatagoriesList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        CatagoryName = CatagoriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 07),
                        child: Container(
                          decoration: BoxDecoration(
                              border: CatagoryName == CatagoriesList[index]
                                  ? Border.all(color: Colors.transparent)
                                  : Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(20),
                              color: CatagoryName == CatagoriesList[index]
                                  ? Colors.blue.shade700
                                  : Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                                child: Text(
                              CatagoriesList[index].toString(),
                              style: GoogleFonts.montserrat(
                                  color: CatagoryName == CatagoriesList[index]
                                      ? Colors.white
                                      : Colors.black),
                            )),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: hieght * .02),
              Expanded(
                child: FutureBuilder<CatagoryNewsModel>(
                  future: newsViewModel.fetchCatagoryNewsAPi(CatagoryName),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(child: Center(child: Spinkit2));
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.05)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: hieght * .18,
                                      width: width * .25,
                                      placeholder: (context, url) => Container(
                                        child: Spinkit2,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(6),
                                      height: hieght * .18,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Spacer(),
                                          Row(
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
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final Spinkit2 = SpinKitThreeBounce(
    color: Colors.grey,
    size: 20,
  );
}
