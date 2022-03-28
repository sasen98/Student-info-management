import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:studentsinfo/auth/authentication_services.dart';
import 'package:studentsinfo/screens/login_screen.dart';
import 'student_details_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final List<String> _classList = [
    'All',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];
  String _classSelected = 'All';
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
                    .logOut(context)
                    .then((_) {
                  Get.to(() => LoginScreen());
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
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: _classSelected == 'All'
                    ? FirebaseFirestore.instance
                        .collection('user')
                        .where('role', isNotEqualTo: 'admin')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('user')
                        .where('studentClass', isEqualTo: _classSelected)
                        .where('role', isNotEqualTo: 'admin')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('No Data Found');
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return InkWell(
                            onTap: () {
                              Get.to(() => StudentDetailsScreen(),
                                  arguments: ds['id']);
                            },
                            child: SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                width: double.infinity,
                                height: 110,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 50,
                                      height: 50,
                                      margin: const EdgeInsets.only(right: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            width: 2,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(ds['image_url']),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            ds['name'],
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.phone,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(ds['contactNumber'],
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      fontSize: 13,
                                                      letterSpacing: .3)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.location_on,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(ds['address'],
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      fontSize: 13,
                                                      letterSpacing: .3)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
