import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/cart/presentation/widgets/date_slot_widget.dart';
import 'package:caredoot/features/cart/presentation/widgets/select_time_slot_widget.dart';
import 'package:caredoot/route/app_pages.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:caredoot/ui/molecules/custom_button.dart';
import 'package:intl/intl.dart';

class SelectSlotPage extends StatefulWidget {
  const SelectSlotPage({super.key});

  @override
  State<SelectSlotPage> createState() => _SelectSlotPageState();
}

class _SelectSlotPageState extends State<SelectSlotPage> {
  late DateTime _selectedDate;
  TimeSlot? _selectedTime;
  final String _date = '';
  String? _selectedAddress;
  final _formKey = GlobalKey<FormState>();
  String? cartId;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _selectedDate = availableDates[0];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _selectedAddress = args["selectedAddress"];
    cartId = args['cartId'];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.dismissKeypad(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: Text('Select Preferred Slot',
              style: AppTextStyles.textStyleHeebo14w500Secondary
                  .copyWith(fontSize: 20)),
          centerTitle: false,
          elevation: 0.1,
          shadowColor: Colors.grey,
        ),
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 26),
                  child: Column(
                    children: [
                      _buildHeader(),
                      CustomSpacers.height32,
                      _buildFooter(),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomButton(
                      strButtonText: 'Proceed',
                      disabled: _selectedTime == null,
                      buttonAction: () {
                        if (_selectedTime != null) {
                          String dateTimeString =
                              "${DateFormat("yyyy-MM-dd").format(_selectedDate)} ${_selectedTime!.time}";
                          CustomNavigator.pushTo(context, AppPages.summaryPage,
                              arguments: {
                                'dateTimeString': dateTimeString,
                                'selectedAddress': _selectedAddress,
                                'cartId': cartId
                                // 'day': _date.toString(),
                                // 'time':
                                //     AppData.selectSlot[_selectedTimeSlotIndex.value]
                              });
                        }
                      },
                      dHeight: 75.h,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'When should the professional arrive?',
            style: AppTextStyles.textStyleHeebo14w500Secondary
                .copyWith(fontSize: 18),
          ),
          Text('Your service will take approx 1 hr',
              style: AppTextStyles.textStyleHeebo14w500Secondary
                  .copyWith(fontSize: 16, color: AppColors.grey)),
          CustomSpacers.height24,
          DateSlotWidget(
            onChanged: (date) {
              _selectedDate = date;
            },
          )
        ],
      );
  _buildFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select start time of service',
            style: AppTextStyles.textStyleHeebo14w500Secondary
                .copyWith(fontSize: 20),
          ),
          CustomSpacers.height14,
          selectTimeSlotWidget(
              onTap: (time) {
                print(time);
                _selectedTime = time;
                setState(() {});
              },
              selectedDate: _selectedDate),
        ],
      );
}

class TimeSlot {
  String time;
  bool isAvailable;
  TimeSlot({required this.time, this.isAvailable = true});
}
