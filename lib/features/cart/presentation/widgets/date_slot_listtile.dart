import 'package:caredoot/core/app_imports.dart';
import 'package:intl/intl.dart';

enum DateSlotType { Date, Time }

class DateSlotListTile extends StatelessWidget {
  final dynamic date;
  final dynamic selectedDate;
  final DateSlotType type;
  const DateSlotListTile(
      {super.key,
      required this.date,
      required this.selectedDate,
      this.type = DateSlotType.Date});

  @override
  Widget build(BuildContext context) {
    if (type == DateSlotType.Time) {
      return Container(
        width: 70.w,
        height: 68.h,
        decoration: BoxDecoration(
            border: Border.all(
                color: selectedDate == date ? Colors.blue : Colors.grey,
                width: selectedDate == date ? 2 : 1),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          date,
          style: AppTextStyles.textStyleHeebo14w500Secondary
              .copyWith(fontSize: 16),
        )),
      );
    }
    return Container(
      width: 70.w,
      height: 68.h,
      decoration: BoxDecoration(
          border: Border.all(
              color: selectedDate == date ? Colors.blue : Colors.grey,
              width: selectedDate == date ? 2 : 1),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat(DateFormat.ABBR_WEEKDAY).format(date),
              style: AppTextStyles.textStyleHeebo14w500Secondary
                  .copyWith(fontSize: 16),
            ),
            Text(
              DateFormat(DateFormat.DAY).format(date),
              style: AppTextStyles.textStyleHeebo14w500Secondary
                  .copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
