import 'dart:async';

import 'package:coinrich/Apiservices/ApiServices.dart';
import 'package:coinrich/Model/CryptoCoinModel.dart';
import 'package:flutter/material.dart';

var cryptodatalist = [];

class CryptoProvider extends ChangeNotifier {
  ApiServices apiServices = ApiServices();
  late CryptoCoinModelClass cryptoList;
  // CryptoCoinModelClass? get getCryptolist => _cryptoList;

  bool isloading = false;
 late Timer _timer ;
  Future getAllCrytptoList() async {
 
    cryptoList = await apiServices.getCryptoCurrency();
 
    // isloading = true;
    notifyListeners();
  }
 

}
