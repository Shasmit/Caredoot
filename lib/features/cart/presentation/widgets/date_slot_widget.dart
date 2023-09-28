import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/features/cart/presentation/widgets/date_slot_listtile.dart';

class DateSlotWidget extends StatefulWidget {
  final Function(DateTime) onChanged;
  const DateSlotWidget({super.key, required this.onChanged});

  @override
  State<DateSlotWidget> createState() => _DateSlotWidgetState();
}

class _DateSlotWidgetState extends State<DateSlotWidget> {
  DateTime _selectedDate = availableDates[0];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(availableDates.length, (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = availableDates[index];
                widget.onChanged(_selectedDate);
              });
            },
            child: DateSlotListTile(
                date: availableDates[index], selectedDate: _selectedDate),
          ),
        );
      }),
    );
  }
}
