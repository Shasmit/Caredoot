import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/features/bookings/presentation/widget/booking_details_widget.dart';
import 'package:caredoot/route/app_pages.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:caredoot/ui/molecules/buttons.dart';

import '../widget/bookings_sizedbox.dart';
import '../widget/divider_widget.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 80,
        title: Text(
          'AC Repair',
          style: AppTextStyles.textStyleHeebo16w500Secondary
              .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        elevation: .75,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Color(0xff35774F),
                      size: 22,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Booking Accepted',
                      style:
                          AppTextStyles.textStyleHeebo16w500Secondary.copyWith(
                        fontSize: 18,
                        color: const Color(0xff35774F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const MyDivider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Finding a professional',
                            style: AppTextStyles.textStyleLato18w800Secondary
                                .copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const BookingsSizedBox(),
                          Text(
                            'A beautician will be assigned at your place by 6:30 PM',
                            style: AppTextStyles.textStyleHeebo16w500Secondary
                                .copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSpacers.width28,
                    Image.asset(
                      AppImages.findingGif,
                      height: 70,
                      width: 70,
                    )
                  ],
                ),
              ),
              const MyDivider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 20, 15),
                child: Text(
                  'Booking details',
                  style: AppTextStyles.textStyleHeebo16w500Secondary.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const BookingsSizedBox(),
              const BookingDetailsWidget(details: 'Amount Paid: 517'),
              const BookingsSizedBox(),
              const BookingDetailsWidget(
                  details:
                      'Bakers street, Lane 16, near Gurappa Garden,Bengaluru, 560027 '),
              const BookingsSizedBox(),
              const BookingDetailsWidget(details: 'Friday, May 26 at 5:30 PM'),
            ],
          ),
          ButtonsWidget(
            buttonText: 'Done',
            onPressed: () {
              CustomNavigator.popUntilRoute(context, AppPages.dashboardPage);
            },
          ),
        ],
      ),
    );
  }
}
