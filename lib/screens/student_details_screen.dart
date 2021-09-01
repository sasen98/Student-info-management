import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:studentsinfo/auth/student_data.dart';
import 'package:studentsinfo/model/user.dart';
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
    String studentId = ModalRoute.of(context)!.settings.arguments.toString();
    Provider.of<StudentData>(context).getStudentDetails(studentId);
    User studentDetails = Provider.of<StudentData>(context).getStudent();
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
                    backgroundImage: NetworkImage(studentDetails.image),
                  ),
                  const SizedBox(height: 15),
                  UserDashRowWidget(
                    label: 'Name:',
                    value: studentDetails.name,
                  ),
                  UserDashRowWidget(
                    label: 'Date of Birth:',
                    value: studentDetails.dob,
                  ),
                  UserDashRowWidget(
                    label: 'Class:',
                    value: studentDetails.studentClass,
                  ),
                  UserDashRowWidget(
                    label: 'Contact Number:',
                    value: studentDetails.contactNumber,
                  ),
                  UserDashRowWidget(
                    label: 'Fathers Name:',
                    value: studentDetails.fathersName,
                  ),
                  UserDashRowWidget(
                    label: 'Mothers Name:',
                    value: studentDetails.mothersName,
                  ),
                  UserDashRowWidget(
                    label: 'Address:',
                    value: studentDetails.address,
                  ),
                  UserDashRowWidget(
                    label: 'Total School Days:',
                    value: studentDetails.totalDays == ''
                        ? 'N/A'
                        : studentDetails.totalDays,
                  ),
                  UserDashRowWidget(
                    label: 'Days Present:',
                    value: studentDetails.daysPresent == ''
                        ? 'N/A'
                        : studentDetails.daysPresent,
                  ),
                  UserDashRowWidget(
                    label: 'Days Absent:',
                    value: studentDetails.daysAbsent == ''
                        ? 'N/A'
                        : studentDetails.daysAbsent,
                  ),
                  UserDashRowWidget(
                    label: 'Percentage:',
                    value: studentDetails.percentage == ''
                        ? 'N/A'
                        : studentDetails.percentage,
                  ),
                  UserDashRowWidget(
                    label: 'Due Fees:',
                    value:
                        studentDetails.fee == '' ? 'N/A' : studentDetails.fee,
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
