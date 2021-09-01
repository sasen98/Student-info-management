import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:studentsinfo/auth/authentication_services.dart';
import 'package:studentsinfo/auth/student_data.dart';
import 'package:studentsinfo/screens/login_screen.dart';
import 'package:studentsinfo/widgets/student_list_table_widget.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final List<String> _classList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  String? _classSelected;
  //String? _studentClass;
  void _search() {
    print('works');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthenticationServices>(context, listen: false)
                    .logOut()
                    .then((_) {
                  Get.to(LoginScreen());
                });
              },
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.secondary,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black38,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Class:'),
                  DropdownButton(
                    underline: const SizedBox(),
                    hint: const Text('Select Class'),
                    alignment: Alignment.center,
                    value: _classSelected,
                    onChanged: (newValue) {
                      setState(() {
                        _classSelected = newValue.toString();
                      });
                    },
                    items: _classList.map((classValue) {
                      return DropdownMenuItem(
                        child: Text(
                          classValue,
                        ),
                        value: classValue,
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: _search,
                    child: Text(
                      'Search',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const StudentListTable(),
          ],
        ),
      ),
    );
  }
}
