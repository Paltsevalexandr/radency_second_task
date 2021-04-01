import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
        title: 'Contact list',
        home: Scaffold(
          body: ContactList(),
        )
    ));
}

class ContactList extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<ContactList> {
  List<Map> list = [
    {'name': 'Joshua Alison', 'company': 'Hoolie Inc.', 'isFavourite': true, 'image': 'face1.jpg'},
    {'name': 'John Agnew', 'company': 'Stanford University', 'isFavourite': true, 'image': 'face2.jpg'},
    {'name': 'Sam Barnard', 'company': 'US Berkeley', 'isFavourite': true, 'image': 'face3.jpg'},
    {'name': 'Joel Cahnon', 'company': 'US Berkeley', 'isFavourite': false, 'image': 'face8.jpg'},
    {'name': 'Kyle Dickenson', 'company': 'Pied Piper', 'isFavourite': true, 'image': 'face7.jpg'},
    {'name': 'Lauren Davis', 'company': 'US Berkeley', 'isFavourite': true, 'image': 'face4.jpg'},
    {'name': 'Olga Petrova', 'company': 'Husky Energy', 'isFavourite': false, 'image': 'face5.jpg'},
    {'name': 'Megan Blakely', 'company': 'Husky Energy', 'isFavourite': false, 'image': 'face6.jpg'}
  ];

  Function addToFavourites(String name, String company) {
    return (
      () {
        setState(() {
          list = [
            for(Map item in list) 
              if(item['name'] == name) 
                {...item, 'isFavourite': !item['isFavourite']} 
              else 
                item
          ];
        });
      }
    );
  }
  List sortContacts() {
    List<Map> sortedList = List.from(list);
    sortedList.sort((a, b) => a['name'].split(' ')[1].compareTo(b['name'].split(' ')[1]));
    return sortedList;
  }
  
  List contactsView(List list) {
    List result = [];
    String firstLetter = '';
    for(int i = 0; i < list.length; i++) {

      if(list[i]['name'].split(' ')[1][0] != firstLetter) {
        result.add(list[i]['name'].split(' ')[1][0]);
        result.add(list[i]);
        firstLetter = list[i]['name'].split(' ')[1][0];
      } else {
        result.add(list[i]);
      }
    }
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 30),
          child: ListView(
            children: [
              for(var item in contactsView(sortContacts()))
                if(item is Map)
                  SingleContact(item, addToFavourites(item['name'], item['company']))
                else
                  Container(
                      padding: EdgeInsets.only(left: 5),
                      margin: EdgeInsets.only(bottom: 15),
                      child: Text(
                        item, 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black45)))
            ]
          )
        )
      ],
    );
  }
}

class SingleContact extends StatelessWidget {
  final contact;
  final addToFavourites;

  SingleContact(this.contact, this.addToFavourites);

  Widget build(BuildContext context) {
    var star = 
      Container(
        width: 40, 
        height: 40,
        margin: EdgeInsets.only(right: 20),
        child: GestureDetector(
          child: contact['isFavourite']
          ? Container(
              child: Image.asset('assets/images/star.png'), 
              padding: EdgeInsets.all(12),
              width: 40, height: 40)   
          : null,
          onTap: addToFavourites),
      );
    var avatar = 
      Container(
        width: 40, height: 40,
        margin: EdgeInsets.only(right: 20),
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/${contact['image']}'))
      );
    var nameAndCompany = 
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(contact['name'], 
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black))
              ),
              Text(
                contact['company'], 
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.black38))
            ],
          ),
          margin: EdgeInsets.only(right: 20));

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          star,
          avatar,
          nameAndCompany,
        ],
      ),
    );
  }
}
