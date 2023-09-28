import 'package:caredoot/features/bookings/presentation/pages/booking_page.dart';
import 'package:caredoot/features/home/presentation/pages/home_page.dart';
import 'package:caredoot/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_imports.dart';
import '../../../../ui/injection_container.dart';
import '../../../cart/presentation/pages/cart_page.dart';
import '../bloc/dashboard_bloc.dart';
import '../widgets/custom_bottom_nav.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentPageIndex = 0;
  ValueNotifier<bool> isLeadsRefresh = ValueNotifier(false);
  DashboardBloc bloc = sl<DashboardBloc>();
  // ignore: unused_field
  final String _versioningString = "";

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      const HomePage(),
      const BookingsPageEmpty(),
      const ProfilePage(),
      const CartPage(),
    ];
  }

  changeTabIndex(int index) {
    bloc.add(DashboardTabChangeEvent(index: index));
  }

  getNavItemName(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Bookings";
      case 2:
        return "Profile";
      case 3:
        return "Cart";
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentPageIndex != 0) {
          bloc.add(const DashboardTabChangeEvent(index: 0));
          return false;
        } else {
          SystemNavigator.pop();
          return false;
        }
      },
      child: BlocProvider<DashboardBloc>(
        create: (context) => bloc,
        child: BlocListener<DashboardBloc, DashboardState>(
          listener: (context, state) async {
            if (state is DashboardTabChangeState) {
              currentPageIndex = state.index;
            }
          },
          child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              return Scaffold(
                key: _scaffoldKey,
                backgroundColor: AppColors.white,
                drawerEnableOpenDragGesture:
                    currentPageIndex == 0 ? true : false,
                drawerEdgeDragWidth: currentPageIndex == 0 ? null : 0,
                bottomNavigationBar: CustomBottomNav(
                  selectedIndex: currentPageIndex,
                  onChanged: (v) async {
                    bloc.add(DashboardTabChangeEvent(index: v));
                  },
                ),
                body: pages[currentPageIndex],
              );
            },
          ),
        ),
      ),
    );
  }
}
