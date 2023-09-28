import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/helpers/scaffold_helpers.dart';
import 'package:caredoot/core/helpers/user_helpers.dart';
import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/bookings/presentation/widget/divider_widget.dart';
import 'package:caredoot/features/profile/presentation/widgets/isnot_logged_in.dart';
import 'package:caredoot/features/profile/presentation/widgets/profile_options_lists.dart';
import 'package:caredoot/route/app_pages.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:caredoot/ui/molecules/buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class ProfileItem {
  final String itemName;
  final String iconName;
  final Function? onTap;

  ProfileItem({
    required this.itemName,
    required this.iconName,
    this.onTap,
  });
}

class SavedAddressDetails {
  final String location;
  final String address;
  final bool isPrimary;

  SavedAddressDetails({
    required this.location,
    required this.address,
    required this.isPrimary,
  });
}

class AddressFieldDetails {
  final String fieldName;
  final TextEditingController? controllers;

  AddressFieldDetails({
    required this.fieldName,
    this.controllers,
  });
}

class EditAddressFieldDetails {
  final String name;
  final String mobileNo;
  final String address;
  final String landmark;
  final String pincode;
  final String city;

  EditAddressFieldDetails({
    required this.name,
    required this.mobileNo,
    required this.address,
    required this.landmark,
    required this.pincode,
    required this.city,
  });
}

class YourClass {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  late List<AddressFieldDetails> addressFieldDetails;

  YourClass() {
    addressFieldDetails = [
      AddressFieldDetails(fieldName: 'Name', controllers: nameController),
      AddressFieldDetails(
          fieldName: 'Mobile Number', controllers: mobileNoController),
      AddressFieldDetails(fieldName: 'Address', controllers: addressController),
      AddressFieldDetails(
          fieldName: 'Landmark', controllers: landmarkController),
      AddressFieldDetails(fieldName: 'City', controllers: pincodeController),
      AddressFieldDetails(fieldName: 'Pincode', controllers: cityController),
    ];
  }
}

class _ProfilePageState extends State<ProfilePage> {
  bool isUserLoggedIn = false;
  bool isdefaultAddress = true;

  @override
  void initState() {
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
          'My Profile',
          style: AppTextStyles.textStyleHeebo16w500Secondary
              .copyWith(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        elevation: .75,
      ),
      body: isUserLoggedIn ? _buildProfileDetails() : const UserNotLoggedIn(),
    );
  }

  List<SavedAddressDetails> savedAddresses = [
    SavedAddressDetails(
      location: 'Home',
      address:
          '103, Bankers street, 5Th Block, 6th Cross, Bengaluru, Karnataka, 560027, India',
      isPrimary: true,
    ),
    SavedAddressDetails(
      location: 'Work',
      address:
          '103, Bankers street, 5Th Block, 6th Cross, Bengaluru, Karnataka, 560027, India',
      isPrimary: false,
    ),
  ];

  List<EditAddressFieldDetails> editAddressDetails = [
    EditAddressFieldDetails(
      name: 'Rahul',
      mobileNo: '9090909090',
      address:
          '103, Bankers street, 5Th Block, 6th Cross, Bengaluru, Karnataka, 560027, India',
      landmark: 'Near Bankers Street',
      pincode: '560027',
      city: 'Bengaluru',
    ),
  ];

  Widget _buildProfileOptions() {
    List<ProfileItem> items = [
      ProfileItem(
        itemName: 'My Bookings',
        iconName: AppIcons.bookingsList,
        onTap: () {
          Navigator.pushNamed(context, AppPages.bookingPage);
        },
      ),
      ProfileItem(
        itemName: 'My Address',
        iconName: AppIcons.location,
        onTap: () {
          _buildAddressDetialsBottomSheet();
        },
      ),
      ProfileItem(
        itemName: 'Coin Balance',
        iconName: AppIcons.coinBalance,
        onTap: () {
          CustomNavigator.pushTo(context, AppPages.coinsPage);
        },
      ),
      ProfileItem(
        itemName: 'Help / Support',
        iconName: AppIcons.help,
        onTap: () {},
      ),
      ProfileItem(
          itemName: 'Logout',
          iconName: AppIcons.logout,
          onTap: () {
            setState(() {
              UserHelpers.clearUser();
              Navigator.popAndPushNamed(context, AppPages.dashboardPage);
            });
          }),
    ];
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ProfileOptionListTile(
          profileItem: items[index],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: 0.35,
          color: AppColors.black,
        );
      },
    );
  }

  _buildAddressDetialsBottomSheet() {
    return ScaffoldHelpers.showBottomSheet(
      context: context,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 10, 10),
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {
                    setState(() {
                      // Navigator.pop(context);

                      _buildAddAnotherAddressBottomSheet();
                    });
                  },
                  child: Text(
                    '+   Add another address',
                    style: AppTextStyles.textStyleHeebo14w500Primary.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppIcons.cancel,
                    height: 12,
                    width: 12,
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 0.35,
              color: AppColors.black,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(38, 15, 10, 0),
              child: Text(
                'Saved addresses',
                style: AppTextStyles.textStyleHeebo14w500Secondary.copyWith(
                  fontSize: 20,
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: savedAddresses.length,
              itemBuilder: (context, index) {
                return _buildSavedAddressListWidget(savedAddresses[index]);
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 0.35,
                  color: AppColors.black,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _buildEditAddressBottomSheet() {
    return ScaffoldHelpers.showBottomSheet(
      context: context,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 10, 10),
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Edit address',
                    style: AppTextStyles.textStyleHeebo14w500Primary.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppIcons.cancel,
                    height: 12,
                    width: 12,
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 0.35,
              color: AppColors.black,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildEditAddressDetailsFormField(
                  YourClass().addressFieldDetails[index],
                  editAddressDetails[0],
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child:
                  ButtonsWidget(buttonText: 'Save Address', onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditAddressDetailsFormField(
      AddressFieldDetails fieldtext, EditAddressFieldDetails editAddress) {
    TextEditingController controllers = TextEditingController();

    if (fieldtext.fieldName == 'Name') {
      controllers = TextEditingController(text: editAddress.name);
    } else if (fieldtext.fieldName == 'Mobile Number') {
      controllers = TextEditingController(text: editAddress.mobileNo);
    } else if (fieldtext.fieldName == 'Address') {
      controllers = TextEditingController(text: editAddress.address);
    } else if (fieldtext.fieldName == 'Pincode') {
      controllers = TextEditingController(text: editAddress.pincode);
    } else if (fieldtext.fieldName == 'City') {
      controllers = TextEditingController(text: editAddress.city);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: TextFormField(
        controller: controllers,
        enabled: fieldtext.fieldName == 'Landmark' ? false : true,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffF7F8F9),
          labelText: fieldtext.fieldName,
          labelStyle: AppTextStyles.textStyleHeebo14w500Tertiary.copyWith(
            fontSize: 16,
            color: const Color(0xff8D8D8D),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.42),
            borderSide: const BorderSide(
              color: Color(0xffC3D1FF),
              width: 1.05,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.42),
            borderSide: const BorderSide(
              color: Color(0xff0048C4),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  _buildAddAnotherAddressBottomSheet() {
    return ScaffoldHelpers.showBottomSheet(
      context: context,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 10, 10),
              child: ListTile(
                leading: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Add address',
                    style: AppTextStyles.textStyleHeebo14w500Primary.copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    AppIcons.cancel,
                    height: 12,
                    width: 12,
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 0.35,
              color: AppColors.black,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildAddressDetailsFormField(
                    YourClass().addressFieldDetails[index]);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ButtonsWidget(buttonText: 'Add Address', onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressDetailsFormField(AddressFieldDetails fieldtext) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
      child: TextFormField(
        controller: fieldtext.controllers,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffF7F8F9),
          labelText: fieldtext.fieldName,
          labelStyle: AppTextStyles.textStyleHeebo14w500Tertiary.copyWith(
            fontSize: 16,
            color: const Color(0xff8D8D8D),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.42),
            borderSide: const BorderSide(
              color: Color(0xffC3D1FF),
              width: 1.05,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.42),
            borderSide: const BorderSide(
              color: Color(0xff0048C4),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSavedAddressListWidget(SavedAddressDetails savedAddress) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 10, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppIcons.homeAddress,
                  height: 20,
                  width: 20,
                ),
                CustomSpacers.width10,
                Text(
                  savedAddress.location,
                  style: AppTextStyles.textStyleHeebo14w500Secondary.copyWith(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                CustomSpacers.width10,
                savedAddress.isPrimary
                    ? Container(
                        width: 60,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xffe8effb),
                          border: Border.all(
                            color: const Color(0xffa2bde8),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          'Primary',
                          style: AppTextStyles.textStyleHeebo14w500Primary
                              .copyWith(
                            fontSize: 12,
                            color: const Color(0xff699efc),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Container(),
              ],
            ),
            trailing: GestureDetector(
              onTapDown: (details) {
                showMenu(
                  color: Colors.white,
                  context: context,
                  position: RelativeRect.fromLTRB(
                    details.globalPosition.dx,
                    details.globalPosition.dy,
                    details.globalPosition.dx + 20,
                    0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'edit',
                      height: BorderSide.strokeAlignCenter,
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem<String>(
                        value: 'divider',
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                        height: BorderSide.strokeAlignCenter,
                        child: Divider(
                          thickness: 0.35,
                          color: AppColors.black,
                        )),
                    const PopupMenuItem<String>(
                      value: 'delete',
                      height: BorderSide.strokeAlignCenter,
                      child: Text('Delete'),
                    ),
                  ],
                ).then((value) {
                  if (value == 'edit') {
                    _buildEditAddressBottomSheet();
                  } else if (value == 'delete') {}
                });
              },
              child: const Icon(
                Icons.more_vert_rounded,
                size: 24,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              savedAddress.address,
              style: AppTextStyles.textStyleHeebo14w400Tertiary.copyWith(
                fontSize: 16,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return ListView(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0048C4), // Start color
                Color(0xFF0048C4),
              ],
              stops: [0.1, 0.82],
            ),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.fromLTRB(20, 20, 15, 20),
            leading: SvgPicture.asset('assets/icons/user_profile.svg'),
            horizontalTitleGap: 25,
            title: Text(
              "${UserHelpers.userDetails!.name}",
              style: AppTextStyles.textStyle12w400Secondary.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                '+91 9090909090',
                style: AppTextStyles.textStyleHeebo16w400Secondary.copyWith(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            trailing: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.transparent,
                  border: Border.all(
                    color: const Color(0xffa2bde8),
                    width: 1,
                  )),
              child: const Icon(
                Icons.edit_rounded,
                color: Color(0xffa2bde8),
                size: 16,
              ),
            ),
          ),
        ),
        const MyDivider(), // Assuming MyDivider is correctly implemented
        _buildProfileOptions(),
        const Divider(
          thickness: 0.35,
          color: AppColors.black,
        ),
      ],
    );
  }
}
