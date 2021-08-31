import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:studentsinfo/widgets/rounded_rect_button_widget.dart';
import '/widgets/user_dash_row_widget.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({Key? key}) : super(key: key);

  @override
  _UserDashboardScreenState createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'User Dashboard',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
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
                    label: 'Percentage:',
                    value: '50%',
                  ),
                  UserDashRowWidget(
                    label: 'Days Present:',
                    value: '80',
                  ),
                  UserDashRowWidget(
                    label: 'Days Absent:',
                    value: '20',
                  ),
                  UserDashRowWidget(
                    label: 'Total School Days:',
                    value: '100',
                  ),
                  UserDashRowWidget(
                    label: 'Due Fees:',
                    value: '100',
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          RoundedRectButtonWidget(
            buttonName: 'Logout',
            buttonFunction: () => Get.offAllNamed('/login'),
          )
        ]),
      ),
    );
  }
}
