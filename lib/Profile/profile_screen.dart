import 'package:flutter/material.dart';

import 'Account/account_screen.dart';
import 'CommunityGuidelines/community_guidelines_screen.dart';
import 'Notifications/notifications_screen.dart';
import 'OfferHistory//offers_history_screen.dart';
import 'PrivacyPolicy/privacy_policy_screen.dart';
import 'ReportABug/report_a_bug_screen.dart';
import 'RequestHistory/request_history_screen.dart';
import 'Reviews/reviews_screen.dart';
import 'TermsOfService/terms_of_service_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Account',
      'icon': Icons.person_outline_rounded,
      'destination': AccountScreen()
    },
    {
      'title': 'Request History',
      'icon': Icons.assignment_outlined,
      'destination': RequestHistoryScreen()
    },
    {
      'title': 'Offer History',
      'icon': Icons.work_outline_outlined,
      'destination': OfferHistory()
    },
    {
      'title': 'Reviews',
      'icon': Icons.star_border_outlined,
      'destination': ReviewsScreen()
    },
    {
      'title': 'Notifications',
      'icon': Icons.notifications_none_rounded,
      'destination': NotificationsScreen()
    },
    {
      'title': 'Privacy Policy',
      'icon': Icons.privacy_tip_outlined,
      'destination': PrivacyPolicyScreen()
    },
    {
      'title': 'Terms of Service',
      'icon': Icons.description_outlined,
      'destination': TermsOfServiceScreen()
    },
    {
      'title': 'Community Guidelines',
      'icon': Icons.groups_outlined,
      'destination': CommunityGuidelinesScreen()
    },
    {
      'title': 'Report a Bug',
      'icon': Icons.bug_report_outlined,
      'destination': ReportABugScreen()
    }
  ];

  void _navigateToDestination(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => items[index]['destination'],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Stack(children: [
            ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      leading: Icon(items[index]['icon']),
                      title: Text(
                        items[index]['title'],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 15),
                      onTap: () => _navigateToDestination(index),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ]),
        ));
  }
}
