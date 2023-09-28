import '../helpers/utils.dart';

class AppData {
  static final servicesTitle = Set<String>.unmodifiable({
    'Bathroom & Kitchen Cleaning',
    // 'AC Repair',
    // 'tv',
    // 'computer',
    // 'disinfection'
  });

  static final states = Set<String>.unmodifiable(
    {
      'Andhra Pradesh',
      'Arunachal Pradesh',
      'Assam',
      'Bihar',
      'Chhattisgarh',
      'Goa',
      'Gujarat',
      'Haryana',
      'Himachal Pradesh',
      'Jharkhand',
      'Karnataka',
      'Kerala',
      'Madhya Pradesh',
      'Maharashtra',
      'Manipur',
      'Meghalaya',
      'Mizoram',
      'Nagaland',
      'Odisha',
      'Punjab',
      'Rajasthan',
      'Sikkim',
      'Tamil Nadu',
      'Telangana',
      'Tripura',
      'Uttar Pradesh',
      'Uttarakhand',
      'West Bengal',
      'Andaman and Nicobar Islands',
      'Chandigarh',
      'Dadra and Nagar Haveli and Daman and Diu',
      'Delhi',
      'Lakshadweep',
      'Puducherry',
      'Ladakh',
      'Jammu and Kashmir',
      'None'
    }.toList()
      ..sort(),
  );

  /// Faq data
  static const List<FaqSection> faqs = [
    FaqSection(
      heading: 'Account Related FAQs',
      faqs: [
        Faq(
          title: 'How can I create my account?',
          info: [
            'Login using your mobile number.',
            'Click next to  Profile and make profile.',
            'Fill in the details and press finish once you complete all the details.',
          ],
        ),
        Faq(
          title: 'How can I delete my account?',
          info: [
            'Go to Profile.',
            'Scroll down and you will find an option Delete my account, click on it and your profile will be deleted.',
          ],
        ),
        Faq(
          title: 'How can I change my mail id/ phone number?',
          info: [
            'Go to Profile',
            'Click on Change mobile to change the number, or click on Change email to change the mail id.',
            'Enter the new number, or enter the new mail id',
            'You will then receive an otp on the new number/ new maid id, enter the otp',
            'And click on Update.',
          ],
        ),
      ],
    ),
    FaqSection(
      heading: 'Resume / Profile Related FAQs',
      faqs: [
        Faq(
          title: 'Is my profile visible to all?',
          info: [
            'Once you create a profile, any recruiter registered with Healthires can view it.',
          ],
        ),
        Faq(
          title: 'How will I know who viewed my profile?',
          info: [
            'Go to Detailed profile to then click on section which you want to change',
          ],
        ),
        Faq(
          title: 'Can I customise resume once it is generated from AI?',
          info: [
            'Go to Detailed Profile',
            'Click on sections you want to edit',
            'Click on Edit/ Update Icon',
            'Once the details have been added, click on save.',
          ],
        ),
        Faq(
          title: 'How will automated resumes work?',
          info: [
            'Fill some required details, and select Next',
            'Once your automated generated resume is ready, all the recruiters will be able to view your resume.',
            'You can also Edit/ Update your resume.',
          ],
        ),
      ],
    ),
    FaqSection(
      heading: 'Job Search / Alerts Related FAQs',
      faqs: [
        Faq(
          title: 'How do I apply to a job?',
          info: [
            'Go on the Home page',
            'On the search bar on the top of the page, type the position you are looking for',
            'Select the location.',
            'Click on the job post you find relevant',
            'And below the screen you will find an option Apply here',
            'Click on Apply here to apply for the job',
          ],
        ),
        Faq(
          title: 'How do I report a job?',
          info: [
            'Click on the job post',
            'Scroll down the screen you will find an option Report the job',
            'Click on Report the job to report the job, select the relevant reason for reporting the job.',
            'Select Report.',
          ],
        ),
      ],
    ),
  ];

  static final List<String> referralQuestions = List.unmodifiable(
    [
      'Share the link with your friends',
      'Your friend opens a candidate or employer account through the link',
      'Gets rewarded ${Utils.getDefaultCurrencySymbol()}500 or 50 coins based on employer or candidate login',
    ],
  );

 
  // [
  //   '09:30 AM',
  //   '09:30 AM',
  //   '10:00 AM',
  //   '10:30 AM',
  //   '11:00 AM',
  //   '11:30 AM',
  //   '12:00 PM',
  //   '01:00 PM',
  //   '01:30 PM',
  //   '02:00 PM',
  //   '02:30 PM',
  //   '03:00 PM',
  //   '03:30 PM',
  //   '04:00 PM',
  //   '04:30 PM',
  //   '05:00 PM',
  //   '05:30 PM',
  //   '06:00 PM',
  //   '06:30 PM',
  //   '07:00 PM',
  //   '07:30 PM',
  //   '08:00 PM',
  // ];
}

class FaqSection {
  final String heading;
  final List<Faq> faqs;

  const FaqSection({
    required this.heading,
    required this.faqs,
  });
}

class Faq {
  final String title;
  final List<String> info;

  const Faq({
    required this.title,
    required this.info,
  });
}
