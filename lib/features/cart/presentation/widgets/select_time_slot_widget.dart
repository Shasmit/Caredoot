import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/cart/presentation/pages/select_slot_page.dart';
import 'package:caredoot/features/cart/presentation/widgets/date_slot_listtile.dart';
import 'package:intl/intl.dart';

class selectTimeSlotWidget extends StatefulWidget {
  final Function(dynamic) onTap;
  final dynamic selectedDate;
  const selectTimeSlotWidget(
      {super.key, required this.onTap, required this.selectedDate});

  @override
  State<selectTimeSlotWidget> createState() => _selectTimeSlotWidgetState();
}

class _selectTimeSlotWidgetState extends State<selectTimeSlotWidget> {
  TimeSlot? _selectedSlot;
  late List<TimeSlot> _availableTimeSlots;
  @override
  void initState() {
    _availableTimeSlots = Utils.getTimeSlots();
    for (var t in _availableTimeSlots) {
      DateFormat format = DateFormat("HH:mm");
      DateTime resultDateTime = format.parse(t.time);
      if (widget.selectedDate.day == DateTime.now().day) {
        if (resultDateTime.hour <= (DateTime.now().hour + 4)) {
          t.isAvailable = false;
        }
      }
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: 397.w,
            height: MediaQuery.of(context).size.height * 0.7,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _availableTimeSlots.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      if (_availableTimeSlots[index].isAvailable) {
                        setState(() {
                          _selectedSlot = _availableTimeSlots[index];
                        });
                        widget.onTap(_selectedSlot);
                      }
                    },
                    child: InkWell(
                      child: DateSlotListTile(
                        type: DateSlotType.Time,
                        date: _availableTimeSlots[index].time,
                        selectedDate:
                            _selectedSlot != null ? _selectedSlot!.time : null,
                      ),
                    )
                    // Container(
                    //   decoration: BoxDecoration(
                    //     color: _availableTimeSlots[index].isAvailable
                    //         ? Colors.white
                    //         : Colors.grey,
                    //     border: Border.all(
                    //         color:
                    //             _selectedSlot.time == _availableTimeSlots[index]
                    //                 ? Colors.blue
                    //                 : Colors.grey,
                    //         width:
                    //             _selectedSlot.time == _availableTimeSlots[index]
                    //                 ? 2.0
                    //                 : 1),
                    //     borderRadius: BorderRadius.circular(10.0),
                    //   ),
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Center(
                    //     child: Text(_availableTimeSlots[index].time,
                    //         textAlign: TextAlign.center,
                    //         style: AppTextStyles.textStyleHeebo14w500Secondary
                    //             .copyWith(fontSize: 12)),
                    //   ),
                    // ),
                    );
              },
            )),
        CustomSpacers.height160
      ],
    );
  }
}
