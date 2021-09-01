import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:studentsinfo/auth/authentication_services.dart';
import 'package:studentsinfo/screens/login_screen.dart';

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
    var currentUser =
        Provider.of<AuthenticationServices>(context, listen: false).currentUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    value: currentUser!.name,
                  ),
                  UserDashRowWidget(
                    label: 'Date of Birth:',
                    value: currentUser.dob,
                  ),
                  UserDashRowWidget(
                    label: 'Class:',
                    value: currentUser.studentClass,
                  ),
                  UserDashRowWidget(
                    label: 'Contact Number:',
                    value: currentUser.contactNumber,
                  ),
                  UserDashRowWidget(
                    label: 'Fathers Name:',
                    value: currentUser.fathersName,
                  ),
                  UserDashRowWidget(
                    label: 'Mothers Name:',
                    value: currentUser.mothersName,
                  ),
                  UserDashRowWidget(
                    label: 'Address:',
                    value: currentUser.address,
                  ),
                  UserDashRowWidget(
                    label: 'Percentage:',
                    value: currentUser.percentage == ''
                        ? 'Nil'
                        : currentUser.percentage,
                  ),
                  UserDashRowWidget(
                    label: 'Days Present:',
                    value: currentUser.daysPresent == ''
                        ? 'Nil'
                        : currentUser.daysPresent,
                  ),
                  UserDashRowWidget(
                    label: 'Days Absent:',
                    value: currentUser.daysAbsent == ''
                        ? 'Nil'
                        : currentUser.daysAbsent,
                  ),
                  UserDashRowWidget(
                    label: 'Total School Days:',
                    value: currentUser.totalDays == ''
                        ? 'Nil'
                        : currentUser.totalDays,
                  ),
                  UserDashRowWidget(
                    label: 'Due Fees:',
                    value: currentUser.fee == '' ? 'Nil' : currentUser.fee,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          RoundedRectButtonWidget(
            buttonName: 'Logout',
            buttonFunction: () {
              Provider.of<AuthenticationServices>(context, listen: false)
                  .logOut()
                  .then((_) {
                Get.to(LoginScreen());
              });
            },
          )
        ]),
      ),
    );
  }
}
