import 'package:international_news_app/View/Models/news_chanel_headlines_model.dart';
import 'package:international_news_app/repository/news_repo.dart';

class NewsViewModel {
  final repo = newsrespository();

  Future<NewsChanelHeadlinesModel> fetchnewschanelheadlinesAPi() async {
    final response = await repo.fetchnewschanelheadlinesAPi();
    return response;
  }
}
