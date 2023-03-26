import 'package:coinrich/Model/CryptoCoinModel.dart';
import 'package:dio/dio.dart';

final dio = Dio();

class ApiServices {
  CryptoCoinModelClass? coinModelClass;
 getCryptoCurrency() async {
    dio.options.headers['X-CMC_PRO_API_KEY'] =
        '27ab17d1-215f-49e5-9ca4-afd48810c149';
    var response = await dio.get(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=BTC,ETH,LTC');
    if (response.statusCode == 200) {
      
     print(response.data['data']);
     coinModelClass=  CryptoCoinModelClass.fromJson(response.data);
       

    return coinModelClass;
    }

  
  }
}
