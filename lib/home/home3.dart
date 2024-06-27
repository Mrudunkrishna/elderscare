import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:elderscareapp/home/aboutus.dart';
import 'package:elderscareapp/home/chatuser.dart';
import 'package:elderscareapp/home/contactsupport/contactsupport.dart';
import 'package:elderscareapp/home/gethelp.dart';
import 'package:elderscareapp/home/home4.dart';
import 'package:elderscareapp/home/notification.dart';
import 'package:elderscareapp/home/sharedpreference.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class homee3 extends StatefulWidget {
  @override
  _Homee3State createState() => _Homee3State();
}

class _Homee3State extends State<homee3> {
  DateTime selectedTime = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String reminderMessage = '';

  @override
  void initState() {
    super.initState();


    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        automaticallyImplyLeading: false, // Remove back button
        actions: [
          Row(children: [

            Padding(
              padding: const EdgeInsets.only(left: 20,right: 40),
              child: Text("Set Your Reminder Here",style: TextStyle(fontSize: 20),),
            ),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreenuser(),));
            }, icon: Icon(Icons.chat)),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GetHelpPage(),));
            }, icon: Icon(Icons.help_outline)),
          ],),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu,color: Colors.black,),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),






      drawer: Drawer(
        child: Container(color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(height: 250,
                child: DrawerHeader(
                    decoration: BoxDecoration(
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Image.asset("assets/images/logoofelders.png",width: 170,height: 160,),
                        ),
                      ],
                    )
                ),
              ),
              SizedBox(height: 35,),
              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserNotificationViewPage(),));
                      }, icon: Lottie.asset("assets/images/mani.json")),
                      SizedBox(width: 5), // Add some spacing between the icon and text
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserNotificationViewPage(),));
                      }, child: Text("Notification",style: TextStyle(color: Colors.blue,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.blue[100],
                indent: 20,endIndent: 35,),


              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUploadPage(),));
                      }, icon: Icon(CupertinoIcons.person_alt_circle,color: Colors.blue,size: 18,)),
                      SizedBox(width: 5), // Add some spacing between the icon and text
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ImageUploadPage(),));
                      }, child: Text("My Account",style: TextStyle(color: Colors.blue,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.blue[100],
                indent: 20,endIndent: 35,),




              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSupportPage(),));
                      }, icon: Icon(Icons.phone_forwarded_outlined,color: Colors.blue,size: 18,)),
                      SizedBox(width: 5), // Add some spacing between the icon and text
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ContactSupportPage(),));
                      }, child: Text("Contact Us",style: TextStyle(color: Colors.blue,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.blue[100],
                indent: 20,endIndent: 35,),


              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => aboutus(),));
                      }, icon: Icon(CupertinoIcons.person_2_alt,color: Colors.blue,size: 18,)),
                      SizedBox(width: 5),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => aboutus(),));
                      }, child: Text("About Us",style: TextStyle(color: Colors.blue,fontSize: 18,fontFamily: "Schyler"),))
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.blue[100],
                indent: 20,endIndent: 35,),






              SizedBox(height: 40,
                child: ListTile(
                  onTap: () {
                    // Add functionality for Item 1
                  },
                  title: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.logout,color: Colors.blue,),
                        onPressed: () async {
                          await SharedPrefHelper.setLoginStatus(false);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                      SizedBox(width: 5), // Add some spacing between the icon and text
                      TextButton(
                        onPressed: () async {
                          await SharedPrefHelper.setLoginStatus(false);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.blue, fontSize: 18, fontFamily: "Schyler"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),Divider(thickness: 1,color: Colors.blue[100],
                indent: 20,endIndent: 35,),

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: DateFormat('dd/MM/yyyy').format(selectedDate),
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.date_range),
                    onPressed: () => selectDate(context),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: "${selectedTime.hour}:${selectedTime.minute}",
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => selectTime(context),
                    icon: Icon(Icons.watch_later_outlined),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                maxLines: 5,
                onChanged: (value) {
                  setState(() {
                    reminderMessage = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Reminder Message',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                setReminder();
                triggerNotification();
              },
              child: const Text(
                'SET',
                style: TextStyle(color: Colors.white, fontFamily: 'Schyler', fontSize: 25),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent[100],
                side: BorderSide(color: Colors.green),
              ),
            ),
            SizedBox(height: 15,),
            Text("Reminders already set are Below"),
            SizedBox(height: 25),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('reminders').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No reminders found'));
                }

                final reminders = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = reminders[index];
                    final date = (reminder['date'] as Timestamp).toDate();
                    final time = (reminder['time'] as Timestamp).toDate();
                    final reminderMessage = reminder['reminderMessage'] ?? '';

                    return Card(
                      color: Colors.blue[100],
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Text(
                          DateFormat('dd/MM/yyyy').format(date),
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Text(
                              "${time.hour}:${time.minute}",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            Text(
                              reminderMessage,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _deleteReminder(reminder.id);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime),
    );

    if (picked != null) {
      setState(() {
        selectedTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2031),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        title: 'Reminder Alert',
        body: 'Reminder has been set',
      ),
    );
  }

  Future<void> setReminder() async {
    final Map<String, dynamic> reminderData = {
      'date': Timestamp.fromDate(selectedDate),
      'time': Timestamp.fromDate(selectedTime),
      'reminderMessage': reminderMessage,
    };

    await FirebaseFirestore.instance.collection('reminders').add(reminderData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reminder set successfully')),
    );

    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: reminderData.hashCode,
        channelKey: 'basic_channel',
        title: 'Scheduled Reminder',
        body: reminderMessage.isNotEmpty ? reminderMessage : 'You have a reminder!',
      ),
      schedule: NotificationCalendar.fromDate(date: selectedTime),
    );
  }

  Future<void> _deleteReminder(String id) async {
    await FirebaseFirestore.instance.collection('reminders').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reminder deleted successfully')),
    );
  }
}
