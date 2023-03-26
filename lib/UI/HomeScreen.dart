import 'dart:async';

import 'package:coinrich/Apiservices/ApiServices.dart';
import 'package:coinrich/Model/CryptoCoinModel.dart';
import 'package:coinrich/Provider/CyrptoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  CryptoCoinModelClass? cryptoCoinModelClas;
  late final CryptoProvider cryptoProvider;
  bool loading = true;
  late Timer _timer;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      cryptoProvider = Provider.of<CryptoProvider>(context, listen: false);

      await cryptoProvider.getAllCrytptoList();
      await initTimer();

      loading = false;
      setState(() {});
    });

    super.initState();
  }

  Future<void> initTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await cryptoProvider.getAllCrytptoList();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    // TODO: implement dispose
  }

  @override
  Widget build(BuildContext context) {
    //cryptodatalist[index].name
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 60, 60, 60),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "CoinRich",
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.pie_chart,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Show Chart",
                            style: TextStyle(color: Colors.amber),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Count : ${cryptoProvider.cryptoList.data.length}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                      // shrinkWrap: true,
                      itemCount: cryptoProvider.cryptoList.data.length,
                      itemBuilder: (context, index) {
                        cryptoProvider.cryptoList.data.forEach(
                          (key, value) {
                            cryptodatalist.add(value);
                          },
                        );

                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cryptodatalist[index].name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "price",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                cryptodatalist[index]
                                                    .quote
                                                    .usd
                                                    .price
                                                    .toStringAsFixed(2),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            cryptodatalist[index]
                                                    .quote
                                                    .usd
                                                    .percentChange24H
                                                    .toString()
                                                    .startsWith('-')
                                                ? Icon(Icons.arrow_downward,
                                                    color: Colors.red)
                                                : Icon(Icons.arrow_upward,
                                                    color: Colors.green),
                                            Text("",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          children: [
                                            Text("Rank",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                cryptodatalist[index]
                                                    .cmcRank
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.white))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        DecoratedBox(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 2),
                                            child: Text(
                                                cryptodatalist[index].symbol),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 14,
                                        ),
                                        const CircleAvatar(
                                          backgroundColor: Colors.amber,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
