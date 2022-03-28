import 'package:cloud_firestore/cloud_firestore.dart';
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
  User studentDetails = User(
      id: '',
      image: '',
      name: '',
      dob: '',
      gender: '',
      studentClass: '',
      contactNumber: '',
      fathersName: '',
      mothersName: '',
      address: '',
      percentage: '',
      daysPresent: '',
      daysAbsent: '',
      totalDays: '',
      fee: '',
      role: '');

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    String studentId = ModalRoute.of(context)!.settings.arguments.toString();
    Provider.of<StudentData>(context, listen: false)
        .getStudentDetails(studentId)
        .then((value) {
      studentDetails = value;
    });
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
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(studentId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black38),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              radius: 70,
                              backgroundImage:
                                  NetworkImage(snapshot.data!['image_url']),
                            ),
                            const SizedBox(height: 15),
                            UserDashRowWidget(
                              label: 'Name:',
                              value: snapshot.data!['name'],
                            ),
                            UserDashRowWidget(
                              label: 'Date of Birth:',
                              value: snapshot.data!['dob'],
                            ),
                            UserDashRowWidget(
                              label: 'Class:',
                              value: snapshot.data!['studentClass'],
                            ),
                            UserDashRowWidget(
                              label: 'Contact Number:',
                              value: snapshot.data!['contactNumber'],
                            ),
                            UserDashRowWidget(
                              label: 'Fathers Name:',
                              value: snapshot.data!['fathersName'],
                            ),
                            UserDashRowWidget(
                              label: 'Mothers Name:',
                              value: snapshot.data!['mothersName'],
                            ),
                            UserDashRowWidget(
                              label: 'Address:',
                              value: snapshot.data!['address'],
                            ),
                            UserDashRowWidget(
                              label: 'Total School Days:',
                              value: snapshot.data!['totalDays'] == ''
                                  ? 'N/A'
                                  : snapshot.data!['totalDays'],
                            ),
                            UserDashRowWidget(
                              label: 'Days Present:',
                              value: snapshot.data!['daysPresent'] == ''
                                  ? 'N/A'
                                  : snapshot.data!['daysPresent'],
                            ),
                            UserDashRowWidget(
                              label: 'Days Absent:',
                              value: snapshot.data!['daysAbsent'] == ''
                                  ? 'N/A'
                                  : snapshot.data!['daysAbsent'],
                            ),
                            UserDashRowWidget(
                              label: 'Percentage:',
                              value: snapshot.data!['percentage'] == ''
                                  ? 'N/A'
                                  : snapshot.data!['percentage'],
                            ),
                            UserDashRowWidget(
                              label: 'Due Fees:',
                              value: snapshot.data!['fee'] == ''
                                  ? 'N/A'
                                  : snapshot.data!['fee'],
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
                        child: AdminEditWidget(
                          uId: snapshot.data!['id'],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              const Text('No data avaible right now');
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
