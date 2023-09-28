import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/features/home/data/models/categories_response_model.dart';
import 'package:caredoot/features/home/domain/entities/subcategory_entity.dart';
import 'package:caredoot/features/home/presentation/bloc/service/service_bloc.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:caredoot/ui/molecules/custom_drop_down.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

// ignore: unused_import
import '../../../../core/helpers/ui_helpers.dart';
import '../../../../ui/injection_container.dart';
import '../../data/models/subcategory_response_model.dart';
import '../bloc/service/service_event.dart';
import '../bloc/service/service_state.dart';
import '../widgets/services_list.dart';

class ServicesPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  const ServicesPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final List<CategoryModel> _categoryItems = [
    CategoryModel(name: 'All Categories', icon: '', slug: 'all')
  ];
  late CategoryModel _selectedCategoryItem;
  late bool _isSubCategoryLoading;
  late final ServiceBloc _serviceBloc;
  SubCategoryResponseModel? _subCategoryList;

  void refreshServices(String slug) {
    UIHelper.showLoader();

    _serviceBloc = sl<ServiceBloc>()
      ..add(
        GetSubCategoryEvent(
          SubCategoryEntity(slug),
        ),
      );
  }

  // @override
  @override
  void initState() {
    List<CategoryModel> categories = widget.arguments!['categoryList'];
    _selectedCategoryItem = widget.arguments!['isAllServices']
        ? _categoryItems.first
        : widget.arguments!['slug'];
    if (widget.arguments != null &&
        widget.arguments!['categoryList'] != null &&
        widget.arguments!['categoryList'].isNotEmpty) {
      _categoryItems.addAll(widget.arguments!['categoryList']);
    }
    widget.arguments!['isAllServices']
        ? refreshServices('all')
        : refreshServices(widget.arguments!['slug'].slug);
    _isSubCategoryLoading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceBloc>(
      create: (context) => _serviceBloc,
      child: BlocListener<ServiceBloc, ServiceState>(
        listener: (context, state) {
          if (state is SubCategoryLoadingState) {
            _isSubCategoryLoading = true;
          }
          if (state is SubCategorySuccessState) {
            _isSubCategoryLoading = false;
            _subCategoryList = state.subCategoryResponseModel;
          }
          if (state is SubCategoryFailureState) {
            _isSubCategoryLoading = false;
            UIHelper.showToast(msg: state.errorMessage, type: ToastType.Alert);
          }
        },
        child: BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    // Handle back button press
                    CustomNavigator.pop(context);
                  },
                ),
                title: const Text(
                  "Services",
                  style: AppTextStyles.textStyleHeebo24w700Primary,
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomSpacers.height10,
                      _buildCategoryDropdown(),
                      CustomSpacers.height20,
                      Expanded(
                        child: _buildServiceList(),
                      ),
                      // CustomSpacers.height60,
                    ]),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildCategoryDropdown() => CustomDropdown(
      items: _categoryItems.map((e) => e.name).toSet(),
      initialValue: _selectedCategoryItem.name.toLowerCase(),
      hintText: 'Select Service',
      validator: (a) {
        return null;
      },
      onChanged: (selected) {
        try {
          var selectedItem = _categoryItems.firstWhere(
            (element) => element.name.toLowerCase() == selected,
          );
          print(
            'selectedItem $selectedItem',
          );
          selectedItem.name == 'All Categories'
              ? _serviceBloc.add(
                  const GetSubCategoryEvent(
                    SubCategoryEntity('all'),
                  ),
                )
              : _serviceBloc.add(
                  GetSubCategoryEvent(
                    SubCategoryEntity(selectedItem.slug),
                  ),
                );
        } catch (e) {
          print(e);
        }
      });
  //  CustomDropDown(
  //     serviceBloc: _serviceBloc,
  //     subCategoryList: _subCategoryList,
  //     categoryItems: _categoryItems,
  //     selectedCategoryItem: _selectedCategoryItem);

  _buildServiceList() => _isSubCategoryLoading
      ? SizedBox(
          height: MediaQuery.of(context).size.height,
          // width: 382.w,
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: _buildServicePlaceholder(),
          ),
        )
      : _subCategoryList != null
          ? _buildServiceListItems()
          : const Text('No Services Found');

  _buildServiceListItems() => ListView.separated(
      shrinkWrap: false,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: _subCategoryList!.subcategories.length,
      itemBuilder: (context, index) => ServiceListTile(
            subCategoryModel: _subCategoryList!.subcategories[index],
          ));

  Widget _buildServicePlaceholder() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 382.w,
            height: 233.h, // Re
            margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
