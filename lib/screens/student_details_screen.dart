import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/admin_edit_widget.dart';
import '../widgets/user_dash_row_widget.dart';

import 'admin_dashboard_screen.dart';

class StudentDetailsScreen extends StatefulWidget {
  const StudentDetailsScreen({Key? key}) : super(key: key);

  @override
  _StudentDetailsScreenState createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: BackButton(
          color: Theme.of(context).colorScheme.secondary,
          onPressed: () => Get.off(AdminDashboardScreen()),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Details',
            style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 70,
                    backgroundImage: const AssetImage('assets/image.png'),
                  ),
                  const SizedBox(height: 15),
                  UserDashRowWidget(
                    label: 'Name:',
                    value: 'Demo name',
                  ),
                  UserDashRowWidget(
                    label: 'Date of Birth:',
                    value: '2020/02/20',
                  ),
                  UserDashRowWidget(
                    label: 'Class:',
                    value: '5',
                  ),
                  UserDashRowWidget(
                    label: 'Contact Number:',
                    value: '9841123456',
                  ),
                  UserDashRowWidget(
                    label: 'Fathers Name:',
                    value: 'demo father',
                  ),
                  UserDashRowWidget(
                    label: 'Mothers Name:',
                    value: 'demo mother',
                  ),
                  UserDashRowWidget(
                    label: 'Address:',
                    value: 'Demo Address',
                  ),
                  UserDashRowWidget(
                    label: 'Total School Days:',
                    value: '100',
                  ),
                  UserDashRowWidget(
                    label: 'Days Present:',
                    value: '90',
                  ),
                  UserDashRowWidget(
                    label: 'Days Absent:',
                    value: '10',
                  ),
                  UserDashRowWidget(
                    label: 'Percentage:',
                    value: '50%',
                  ),
                  UserDashRowWidget(
                    label: 'Due Fees:',
                    value: '4000',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(20),
              ),
              child: AdminEditWidget(),
            ),
          ]),
        ),
      ),
    );
  }
}
