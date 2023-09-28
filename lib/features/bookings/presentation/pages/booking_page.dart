import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/features/bookings/presentation/widget/booking_list.dart';
import 'package:caredoot/features/bookings/presentation/widget/divider_widget.dart';
import 'package:caredoot/route/app_pages.dart';

import '../../../../core/helpers/utils.dart';
import '../../../profile/presentation/widgets/isnot_logged_in.dart';
import '../widget/bookings_sizedbox.dart';

class BookingsPageEmpty extends StatefulWidget {
  const BookingsPageEmpty({super.key});

  @override
  State<BookingsPageEmpty> createState() => _BookingsPageEmptyState();
}

class BookingData {
  final bool isAccepted;
  final bool isJobDone;
  final bool isBookingCancelled;

  BookingData({
    required this.isAccepted,
    required this.isJobDone,
    required this.isBookingCancelled,
  });
}

class _BookingsPageEmptyState extends State<BookingsPageEmpty> {
  //Supposse the data comes in a format similar to this from the API
  final List<BookingData> bookingData = [
    BookingData(isAccepted: true, isJobDone: false, isBookingCancelled: false),
    BookingData(isAccepted: false, isJobDone: true, isBookingCancelled: false),
    BookingData(isAccepted: false, isJobDone: false, isBookingCancelled: true),
  ];
  bool isUserLoggedIn = false;
  //TODO: initilize bloc

  @override
  void initState() {
    // TODO _bloc.add();
    Utils.isUserLoggedIn().then((value) {
      isUserLoggedIn = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 80,
        title: Text(
          'My Bookings',
          style: AppTextStyles.textStyleHeebo16w500Secondary
              .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        elevation: .75,
      ),
      body:
          isUserLoggedIn //TODO: Wrap body in bloc provoider inside that listener and builder
              ? ListView.builder(
                  itemCount: bookingData.length,
                  itemBuilder: (context, index) {
                    final statusData = bookingData[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppPages.bookingDetails);
                          },
                          child: BookingListTile(
                            bookingData: statusData,
                          ),
                        ),
                        const BookingsSizedBox(),
                        const MyDivider(),
                      ],
                    );
                  },
                )
              : const UserNotLoggedIn(),
    );
  }
}
