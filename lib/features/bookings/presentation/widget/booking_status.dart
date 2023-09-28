import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_text_styles.dart';
import 'bookings_sizedbox.dart';

class BookingStatus extends StatefulWidget {
  final bool isAccepted;
  final bool isJobDone;
  final bool isBookingCancelled;

  const BookingStatus({
    super.key,
    required this.isAccepted,
    required this.isJobDone,
    required this.isBookingCancelled,
  });

  @override
  State<BookingStatus> createState() => _BookingStatusState();
}

class _BookingStatusState extends State<BookingStatus> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AC Repair',
            style: AppTextStyles.textStyleHeebo16w500Primary.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffd9d9d9),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Used if statement to determine what the state of the booking is and show the response according to that
                  if (widget.isAccepted)
                    Text(
                      'BOOKING ACCEPTED',
                      style: AppTextStyles.textStyleHeebo22w700Primary.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff35774F),
                      ),
                    ),
                  if (widget.isJobDone)
                    Text(
                      'JOB DONE',
                      style: AppTextStyles.textStyleHeebo22w700Primary.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff35774F),
                      ),
                    ),

                  if (widget.isBookingCancelled)
                    Text(
                      'BOOKING CANCELLED',
                      style: AppTextStyles.textStyleHeebo22w700Primary.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffC50505),
                      ),
                    ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Deep Cleaning of AC and filter change',
                    style: AppTextStyles.textStyleHeebo22w700Secondary.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Fri, May26 at 10:00 AM',
                    style: AppTextStyles.textStyleLato10w400.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  //Again used the if statement to determine what the state of the booking is and show the response according to that
                  //If the booking is accepted then it will show a text and an icon
                  if (widget.isAccepted)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Finding a professional',
                          style: AppTextStyles.textStyleLato10w500Secondary
                              .copyWith(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/search.svg',
                          width: 45,
                          height: 45,
                        ),
                      ],
                    ),

                  //If the booking is done then it will show an icon and the money paid for the service
                  if (widget.isJobDone)
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xff35774F),
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Amount Paid 517',
                                style: AppTextStyles
                                    .textStyleLato10w500Secondary
                                    .copyWith(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 32,
                            width: 125,
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    side: const BorderSide(
                                      color: Colors.grey,
                                      width: 0.2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                shadowColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                              ),
                              child: Text(
                                'Book again',
                                style: AppTextStyles.textStyleHeebo22w700Primary
                                    .copyWith(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const BookingsSizedBox(),
        ],
      ),
    );
  }
}
