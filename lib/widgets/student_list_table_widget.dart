import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentsinfo/model/user.dart';
import 'package:studentsinfo/screens/student_details_screen.dart';

class StudentListTable extends StatefulWidget {
  const StudentListTable({Key? key}) : super(key: key);

  @override
  _StudentListTableState createState() => _StudentListTableState();
}

class _StudentListTableState extends State<StudentListTable> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('No Data Found');
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return InkWell(
                    onTap: () {
                      Get.to(StudentDetailsScreen(), arguments: ds['id']);
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
                                    image: NetworkImage(ds['image_url']),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Icons.school,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(ds['studentClass'],
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
    );
  }
}
