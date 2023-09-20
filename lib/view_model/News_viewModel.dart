import 'package:international_news_app/View/Models/catagory_newsmodel.dart';
import 'package:international_news_app/View/Models/news_chanel_headlines_model.dart';
import 'package:international_news_app/repository/news_repo.dart';

class NewsViewModel {
  final repo = newsrespository();

  Future<NewsChanelHeadlinesModel> fetchnewschanelheadlinesAPi(
      String chanelname) async {
    final response = await repo.fetchnewschanelheadlinesAPi(chanelname);
    return response;
  }

  Future<CatagoryNewsModel> fetchCatagoryNewsAPi(String Catagory) async {
    final response = await repo.fetchCatagoryNewsAPi(Catagory);
    return response;
  }
}
