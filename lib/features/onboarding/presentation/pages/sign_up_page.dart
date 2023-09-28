// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/app_imports.dart';
// import '../../domain/entities/sign_up_entity.dart';
// import '../../../../route/app_pages.dart';
// import '../../../../ui/molecules/custom_back_button.dart';
// import '../../../../ui/molecules/custom_button.dart';
// import '../../../../ui/molecules/custom_text_field.dart';

// import '../../../../route/custom_navigator.dart';
// import '../bloc/onboarding_bloc.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({Key? key}) : super(key: key);

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _bloc = sl<OnboardingBloc>();
//   bool _isLoading = false;
//   late TextEditingController _emailController, _referralController;

//   @override
//   void initState() {
//     _initControllers();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _referralController.dispose();
//     super.dispose();
//   }

//   _initControllers() {
//     _emailController = TextEditingController();
//     _referralController = TextEditingController();
//   }

//   Widget buildHeading() {
//     return const Text.rich(
//       TextSpan(
//         style: TextStyle(
//           fontFamily: 'Lato',
//           fontSize: 32,
//           fontWeight: FontWeight.w800,
//         ),
//         children: [
//           TextSpan(
//             text: 'Hello! ',
//             style: TextStyle(color: AppColors.primary),
//           ),
//           TextSpan(
//             text: 'Register to get started',
//             style: TextStyle(
//               color: AppColors.secondaryText,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildEmailTextField() {
//     return CustomTextField(
//       controller: _emailController,
//       isRequired: true,
//       hint: 'Email',
//       keyboardType: TextInputType.emailAddress,
//     );
//   }

//   Widget buildReferCodeTextField() {
//     return CustomTextField(
//       controller: _referralController,
//       hint: 'Referral code (optional)',
//       keyboardType: TextInputType.text,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocProvider(
//         create: (context) => _bloc,
//         child: BlocListener<OnboardingBloc, OnboardingState>(
//           listener: (context, state) {
//             if (state is SignUpLoadingState) {
//               _isLoading = true;
//             }
//             if (state is SignUpCompleteState) {
//               _isLoading = false;
//               CustomNavigator.pushTo(context, AppPages.candidateRegistration);
//             }
//             if (state is SignUpErrorState) {
//               _isLoading = false;
//             }
//           },
//           child: BlocBuilder<OnboardingBloc, OnboardingState>(
//             builder: (context, state) {
//               return SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.all(VALUE_STANDARD_SCREEN_PADDING),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustombackButton(
//                         onTap: () {},
//                       ),
//                       CustomSpacers.height34,
//                       buildHeading(),
//                       CustomSpacers.height52,
//                       buildEmailTextField(),
//                       CustomSpacers.height14,
//                       buildReferCodeTextField(),
//                       const Spacer(),
//                       CustomButton(
//                         strButtonText: 'Next',
//                         isLoading: _isLoading,
//                         buttonAction: () {
//                           _bloc.add(SignUpEvent(SignUpEntity(
//                               email: _emailController.text,
//                               referralCode: _referralController.text)));
//                           // CustomNavigator.pushTo(
//                           //     context, AppPages.candidateRegistration);
//                           //  CustomNavigator.pushTo(context, AppPages.resume);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
