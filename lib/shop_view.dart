import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';

import 'package:smolstocks/utils/color.dart';
import 'package:smolstocks/utils/fonts.dart';

class ShopView extends StatelessWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const MediumText(data: "Smol Stocks"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(size.width * 0.02),
            child: const HeaderShopScreen(
              header: "General Store 69",
              tagline: "best general store in the are",
              type: "Individual",
            ),
          ),
          const VolatilityShopScreen(),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.02),
            child: const TabBarShopScreen(),
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.02),
            child: const WhyInvestScreen(),
          ),
          Padding(
            padding: EdgeInsets.all(size.width * 0.02),
            child: const PerformanceShopScreen(),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}

class HeaderShopScreen extends StatelessWidget {
  const HeaderShopScreen({
    Key? key,
    required this.header,
    required this.tagline,
    required this.type,
    this.image,
  }) : super(key: key);
  final String header;
  final String tagline;
  final String type;
  final String? image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                BoldText(
                  data: header,
                  size: size.width * 0.055,
                  color: blue,
                  shadow: true,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  child: BodyText(
                    data: type,
                    color: Colors.white,
                    size: size.width * 0.008,
                  ),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: red,
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 5)
                      ]),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            BodyText(
              data: tagline,
              color: lightBlue,
              size: size.width * 0.015,
            ),
          ],
        ),
        SizedBox(
          height: size.width / 5,
          width: size.width / 5,
          child: (image != null) ? Image.network(image!) : const FlutterLogo(),
        ),
      ],
    );
  }
}

class VolatilityShopScreen extends StatelessWidget {
  const VolatilityShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            MediumText(
              data: "13 Months Returns",
              color: Colors.grey[600],
              size: size.width * 0.012,
            ),
            BoldText(
              data: "19%",
              color: green,
              size: size.width * 0.017,
            )
          ],
        ),
        const SizedBox(
          width: 50,
        ),
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [BoxShadow(blurRadius: 2, color: Colors.grey)]),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.dangerous_rounded,
                color: green,
                size: size.width * 0.016,
              ),
              const SizedBox(
                width: 5,
              ),
              BodyText(
                data: "Low Volaity",
                color: green,
                size: size.width * 0.01,
              )
            ],
          ),
        )
      ],
    );
  }
}

class TabBarShopState extends GetxController {
  RxInt key = 0.obs;
}

class TabBarShopScreen extends StatefulWidget {
  const TabBarShopScreen({Key? key}) : super(key: key);

  @override
  State<TabBarShopScreen> createState() => _TabBarShopScreenState();
}

class _TabBarShopScreenState extends State<TabBarShopScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  TabBarShopState obj = Get.put(TabBarShopState());
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  Widget tabText(int index) {
    switch (index) {
      case 0:
        return const BodyText(data: "This is overview of the company");
        break;
      case 1:
        return const BodyText(data: "This is overview of the company");
        break;
      case 2:
        return const BodyText(
            data:
                "This is overview offhkawjfhkajsaksjfbsjafgksajgf the company");
        break;
      default:
        return const BodyText(data: "This is overview of the company");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: size.width * 0.6,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                onTap: (val) {
                  obj.key.value = val;
                },
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[500],
                labelStyle: GoogleFonts.notoSans(
                    fontSize: size.width * 0.012, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    text: "Overview",
                  ),
                  Tab(
                    text: "Target and Goals",
                  ),
                  Tab(
                    text: "News",
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: tabText(obj.key.value),
                  ),
                ),
              )
            ],
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                BodyText(
                  data: "Minimum Investment Amount",
                  color: Colors.grey[600],
                  size: size.width * 0.01,
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.warning_rounded,
                  color: Colors.grey[500],
                )
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            BodyText(
              data: "Rs. 531",
              color: Colors.black,
              size: size.width * 0.02,
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              shape: const StadiumBorder(),
              minWidth: size.width * 0.155,
              height: size.width * 0.037,
              padding: const EdgeInsets.all(15),
              onPressed: () {},
              color: green,
              child: BoldText(
                data: "Invest",
                color: white,
                size: size.width * 0.01,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class WhyInvestScreen extends StatelessWidget {
  const WhyInvestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        BoldText(
          data: "Why invest with us?",
          color: Colors.black,
          size: size.width * 0.017,
        ),
        const SizedBox(
          height: 20,
        ),
        BodyText(
          data:
              "jbfjsajfbaskjfbasjfbasfbakjfbsakjfsabdmsadbamdbambd,amsdbm,adbjadbajdbakdbbaskjfbsakjfbakfbakbfakfbjakfbajkfbajkfbaskfhakjsfhsjfbaskjfbsakjfbakfbafbasmfbafbaksjfbakfbakfalfshfajhfvahfs",
          color: Colors.grey[700],
          size: size.width * 0.011,
        )
      ],
    );
  }
}

class PerformanceShopScreen extends StatelessWidget {
  const PerformanceShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List<LineChartModel> data = [
      LineChartModel(amount: 30, date: DateTime(2022)),
      LineChartModel(amount: 10, date: DateTime(2023)),
      LineChartModel(amount: 80, date: DateTime(2024))
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(
          data: "Past Performance",
          color: Colors.black,
          size: size.width * 0.017,
        ),
        Row(
          children: [
            Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: size.width / 5,
                    width: 2,
                    color: Colors.grey[700],
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: 2,
                    width: size.width / 1.2,
                    color: Colors.grey[700],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: LineChart(
                    width: size.width / 1.2,
                    height: size.width / 5,
                    data: data,
                    linePaint: Paint()
                      ..strokeWidth = 3
                      ..style = PaintingStyle.stroke
                      ..color = lightBlue,
                    circlePaint: Paint()..color = lightBlue,
                    showCircles: true,
                    circleRadiusValue: 6,
                    linePointerDecoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    pointerDecoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    insideCirclePaint: Paint()..color = Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(
                child: Center(
              child: Column(
                children: [
                  Container(
                    width: size.width / 4,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(boxShadow: const [
                      BoxShadow(blurRadius: 2, color: Colors.grey)
                    ], color: lightBlue, borderRadius: BorderRadius.circular(20)),
                    child: BodyText(
                      data: "Amount in 2010\nRs120",
                      color: Colors.white,
                      size: size.width * 0.01,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: size.width / 4,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(boxShadow: const [
                      BoxShadow(blurRadius: 2, color: Colors.grey)
                    ], color: blue, borderRadius: BorderRadius.circular(20)),
                    child: BodyText(
                      data: "Amount now\nRs320",
                      size: size.width * 0.01,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ],
    );
  }
}
