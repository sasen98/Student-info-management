import 'package:flutter/material.dart';

class StudentListTable extends StatefulWidget {
  const StudentListTable({Key? key}) : super(key: key);

  @override
  _StudentListTableState createState() => _StudentListTableState();
}

class _StudentListTableState extends State<StudentListTable> {
  final List<Map> studentList = [
    {
      "name": "Ram Bahadur",
      "address": "Ktm",
      "class": "5",
      "imageurl":
          "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"
    },
    {
      "name": "jon cena",
      "address": "pkr",
      "class": "8",
      "imageurl":
          "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
    },
    {
      "name": "undertaker",
      "address": "Ilam",
      "class": "10",
      "imageurl":
          "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
    },
    {
      "name": "Mark Henery",
      "address": "Jhapa",
      "class": "7",
      "imageurl":
          "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
    },
    {
      "name": "Peter Griffin",
      "address": "Gorkha",
      "class": "6",
      "imageurl":
          "https://cdn.pixabay.com/photo/2017/03/16/21/18/logo-2150297_960_720.png"
    },
    {
      "name": "Dwyane Johnson",
      "address": "Usa",
      "class": "3",
      "imageurl":
          "https://cdn.pixabay.com/photo/2017/01/31/13/14/animal-2023924_960_720.png"
    },
    {
      "name": "Harry Potter",
      "address": "Uk",
      "class": "2",
      "imageurl":
          "https://cdn.pixabay.com/photo/2016/06/09/18/36/logo-1446293_960_720.png"
    },
    {
      "name": "Something Something",
      "address": "SomeWhere",
      "class": "4",
      "imageurl":
          "https://cdn.pixabay.com/photo/2017/01/13/01/22/rocket-1976107_960_720.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: ListView.builder(
          itemCount: studentList.length,
          itemBuilder: (BuildContext context, int index) {
            return buildList(context, index);
          }),
    );
  }

  Widget buildList(BuildContext context, int index) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Theme.of(context).colorScheme.primary,
        ),
        width: double.infinity,
        height: 110,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    width: 2, color: Theme.of(context).colorScheme.secondary),
                image: DecorationImage(
                    image: NetworkImage(studentList[index]['imageurl']),
                    fit: BoxFit.fill),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    studentList[index]['name'],
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
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
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(studentList[index]['class'],
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
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
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(studentList[index]['address'],
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
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
    );
  }
}
