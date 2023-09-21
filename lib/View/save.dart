import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_news_app/View/Models/catagory_newsmodel.dart';
import 'package:international_news_app/view_model/News_viewModel.dart';

class Saved_items extends StatefulWidget {
  const Saved_items({super.key});

  @override
  State<Saved_items> createState() => _Saved_itemsState();
}

class _Saved_itemsState extends State<Saved_items> {
  NewsViewModel newsViewModel = NewsViewModel();
  String CatagoryName = "Sports";

  @override
  Widget build(BuildContext context) {
    final hieght = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Saved News",
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
          actions: [
            Icon(
              Icons.bookmark,
              size: 28,
              color: Colors.blue.shade700,
            ),
            const SizedBox(
              width: 4,
            )
          ],
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: hieght * .01,
              ),
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
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(.05)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
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
                                      padding: const EdgeInsets.all(6),
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
                                          const Spacer(),
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
                                              const Icon(Icons.bookmark)
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

  final Spinkit2 = const SpinKitThreeBounce(
    color: Colors.grey,
    size: 20,
  );
}
