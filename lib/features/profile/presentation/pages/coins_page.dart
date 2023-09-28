import 'package:caredoot/core/app_imports.dart';

class CoinsPage extends StatelessWidget {
  const CoinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Reward Coins'),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  Flexible(
                      child: Container(
                    color: Colors.red,
                    child: Image.asset(
                      AppImages.coinsBg,
                      fit: BoxFit.cover,
                    ),
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('My Balance',
                              style: AppTextStyles.fs18Fw800Lh27
                                  .copyWith(color: Colors.white)),
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFFFFE200), Color(0xFFFF9000)],
                            ).createShader(bounds),
                            child: const Text(
                              '480',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Text(
                              'save ₹48 using 480 coins on your next booking  '),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height * 0.26,
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30),
                      right: Radius.circular(30),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSpacers.height10,
                      const Text("Transaction History",
                          style: AppTextStyles.fs18Fw500Lh20),
                      CustomSpacers.height20,
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 20,
                            separatorBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Divider(),
                              );
                            },
                            itemBuilder: (context, index) {
                              return const CoinTransactionListTile();
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CoinTransactionListTile extends StatelessWidget {
  const CoinTransactionListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Home Painting'), Text('credited on 23 Aug 2023')],
          ),
          const Spacer(),
          Row(
            children: [
              const Text("+30"),
              Image.asset(
                AppIcons.coinIc,
                height: 20,
                width: 20,
              )
            ],
          )
        ],
      ),
    );
  }
}
