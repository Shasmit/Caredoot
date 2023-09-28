// ignore_for_file: unused_import

import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/constants/app_data.dart';
import 'package:caredoot/features/home/data/models/service_response_model.dart';
import 'package:caredoot/features/home/domain/entities/subcategory_entity.dart';

import 'package:caredoot/route/app_pages.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:caredoot/ui/molecules/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helpers/ui_helpers.dart';
import '../../../../ui/injection_container.dart';
import '../../data/models/categories_response_model.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../bloc/service/service_bloc.dart';
import '../bloc/service/service_event.dart';
import '../widgets/service_slider_list_items.dart';
import '../widgets/services_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _homeBloc = sl<HomeBloc>();

  CategoriesResponseModel? _categories;
  ServiceResponseModel? _popularServices;

  late bool _isCategoryLoading;
  late bool _isServiceLoading;

  List<String> categoryitem = [];

  @override
  void initState() {
    _isCategoryLoading = true;
    _isServiceLoading = true;

    initCategoryApi();
    initServiceApi();

    super.initState();
  }

  initCategoryApi() {
    _homeBloc.add(GetAllCategoriesEvent());
  }

  initServiceApi() {
    _homeBloc.add(GetAllServicesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => _homeBloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is CategoryLoadingState) {
            _isCategoryLoading = true;
          }
          if (state is CategoryLoadedSuccessfullState) {
            _isCategoryLoading = false;
            _categories = state.CategoryPosts;
          }
          if (state is CategoryLoadedFailureState) {
            _isCategoryLoading = false;
            UIHelper.showToast(msg: state.message, type: ToastType.Alert);
          }

          if (state is ServiceLoadingState) {
            _isServiceLoading = true;
          }
          if (state is ServiceLoadedSuccessfullState) {
            _isServiceLoading = false;
            _popularServices = state.serviceResponseModel;
          }
          if (state is ServiceLoadedFailureState) {
            _isServiceLoading = false;
            UIHelper.showToast(msg: state.message, type: ToastType.Alert);
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 80.h,
                flexibleSpace: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  // color: Colors.amber,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25.0, right: 21, top: 21),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30.h,
                          width: 97.w,
                          // color: Colors.red,
                          child: Image.asset(
                            AppIcons.appLogo,
                          ),
                        ),
                        SvgPicture.asset(
                          AppIcons.searchIcon,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildServicePortion(),
                    CustomSpacers.height45,
                    _buildPopularServices(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildServicePortion() => SizedBox(
        height: 450.h,
        width: 427.w,
        child: Stack(
          children: [
            _categories != null
                ? _buildServiceBackground(_categories!)
                : Text(''),
            Positioned(
              top: 260.h,
              child: _isCategoryLoading
                  ? SizedBox(
                      height: 164.h,
                      width: 427.w,
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: _buildServiceSliderPlaceholder(),
                      ),
                    )
                  : _categories != null
                      ? _buildServiceSlider()
                      : Text('No Categories Found'),
            )
          ],
        ),
      );

  _buildServiceBackground(CategoriesResponseModel categoryResponse) => SizedBox(
        height: 300.h,
        width: 427.w,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.homeBackgroundThinkBetter),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 73.h,
                  // width: 3.w,
                  child: const Text(
                    "Think Better, Serve Better",
                    style: AppTextStyles.textStyleHeebo24w700Tertiary,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 56.h,
                  width: 348.w,
                  child: const Text(
                    "Provide all kind of services that related you daily usage like repair home appliance.",
                    style: AppTextStyles.textStyleHeebo14w400Tertiary,
                    textAlign: TextAlign.center,
                  ),
                ),
                CustomSpacers.height20,
                _buildViewAllButton(categoryResponse),
              ],
            ),
          ),
        ),
      );

  _buildServiceSlider() => SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200.h,
      child: SeviceSliderListItems(
        categoryPosts: _categories!.categories,
      ));

  _buildPopularServices() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: const TextSpan(children: [
              TextSpan(
                  text: "Our Popular",
                  style: AppTextStyles.textStyleHeebo24w700Secondary),
              TextSpan(
                  text: " Services",
                  style: AppTextStyles.textStyleHeebo24w700Primary)
            ]),
          ),
          CustomSpacers.height12,
          _buildPopularServiceList(),
        ],
      );

  _buildPopularServiceList() => _isServiceLoading
      ? _buildServicePlaceholder()
      : Column(
          children: [
            ..._popularServices!.services
                .map((element) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 39,
                      vertical: 10,
                    ),
                    child: ServiceListTile(
                      serviceModel: element,
                    )))
                .toList()
          ],
        );

  Widget _buildServicePlaceholder() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 39,
        vertical: 10,
      ),
      child: Column(
        children: [
          ...AppData.servicesTitle.map((e) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  width: 382.w,
                  height: 233.h, // Re
                  margin: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  _buildViewAllButton(CategoriesResponseModel categoryResponse) =>
      GestureDetector(
        onTap: () {
          List<CategoryModel> categoryItems = [];

          for (var itemname in categoryResponse.categories) {
            categoryItems.add(itemname);
          }
          print(categoryItems);

          CustomNavigator.pushTo(context, AppPages.servicesPage, arguments: {
            'isAllServices': true,
            'categoryList': categoryItems,
            'slug': '',
          });
        },
        child: Container(
          height: 53.h,
          width: 146.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.visibility,
                color: AppColors.primary,
              ),
              CustomSpacers.width10,
              const Text(
                "VIEW ALL",
                style: AppTextStyles.textStyleHeebo14w500Primary,
              )
            ],
          ),
        ),
      );
}

Widget _buildServiceSliderPlaceholder() {
  return ListView.builder(
    itemCount: 3,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          width: 164.w,
          height: 143.h, // Re
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      );
    },
  );
}
