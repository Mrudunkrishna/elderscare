import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class aboutus extends StatefulWidget {
  const aboutus({super.key});

  @override
  State<aboutus> createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue[100],
        title: Text("ABOUT US",style: TextStyle(fontFamily: 'Schyler',fontSize: 30),),
      ),

      body:
          Stack(
            fit: StackFit.expand,
            children: [
            Container(
              color: Colors.blue[100],
                height: 1000,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset("assets/images/background.jpg",))),
            Positioned(child:
            SingleChildScrollView(
              child: Column(children: [

                Image.asset("assets/images/aboutus.webp"),
                SizedBox(height: 15,),

                Container(
                  height: MediaQuery.of(context).size.height * 0.16,
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.center, // Align the child (text) to the center
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey), // Add border for styling
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ), // Add border radius for rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Add padding for text
                    child: Text(
                      "Welcome to Elder Care, a compassionate solution dedicated to enhancing the"
                          " lives of our elderly community members. At Elder Care, we understand the importance"
                          " of providing convenient access to essential services, ensuring the well-being and "
                          "comfort of our seniors.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),




                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(right: 250),
                  child: Text("Our Mission :",style: TextStyle(fontSize: 20,decoration: TextDecoration.underline,color: Colors.black),),
                ),
                SizedBox(height: 15,),


                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.center, // Align the child (text) to the center
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey), // Add border for styling
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ), // Add border radius for rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Add padding for text
                    child: Text(
                      "Elder Care is committed to simplifying the daily lives of seniors by offering a comprehensive platform where "
                          "they can effortlessly purchase medicines, groceries, and even book caretakers as needed. We strive to create a"
                          " supportive environment that fosters independence, "
                          "dignity, and quality care for our elderly population.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),



                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(right: 250),
                  child: Text("What we do :",style: TextStyle(fontSize: 20,decoration: TextDecoration.underline,color: Colors.black),),
                ),
                SizedBox(height: 15,),


                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.center, // Align the child (text) to the center
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey), // Add border for styling
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ), // Add border radius for rounded corners
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0), // Add padding for text
                        child: Text(
                          "Medicines & Groceries: Our user-friendly app allows seniors to browse through a wide selection of"
                              " medicines and groceries from the comfort of their homes. With just a few taps, they can place orders and have them "
                              "delivered directly to their doorstep, eliminating the hassle of visiting multiple stores.",
                          style: TextStyle(fontSize: 16,),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Image.asset("assets/images/grocerydeliv.webp",height: MediaQuery.of(context).size.height*0.20,
                        width: MediaQuery.of(context).size.width*0.9,
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 15,),
                Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.center, // Align the child (text) to the center
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey), // Add border for styling
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ), // Add border radius for rounded corners
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0), // Add padding for text
                        child: Text(
                          "Professional Caretakers: We understand that some seniors may require additional assistance"
                              " with daily tasks or personal care. "
                              "That's why Elder Care provides a platform for booking professional caretakers who are trained to"
                              " offer compassionate support and companionship tailored to individual needs.",
                          style: TextStyle(fontSize: 16,),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Image.asset("assets/images/caretakerdeli.jpeg",height: MediaQuery.of(context).size.height*0.20,
                        width: MediaQuery.of(context).size.width*0.9,
                      ),
                    ],
                  ),
                ),



                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: Text("Our Commitment to Excellence :",style: TextStyle(fontSize: 20,decoration: TextDecoration.underline,color: Colors.black),),
                ),
                SizedBox(height: 15,),


                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.center, // Align the child (text) to the center
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey), // Add border for styling
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ), // Add border radius for rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Add padding for text
                    child: Text(
                      "At Elder Care, we prioritize reliability, security, and exceptional service. Our team is dedicated to ensuring a seamless experience for both "
                          "seniors and their families, with a focus on integrity and respect in every interaction.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),




                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: Text("Join Us in Making a Difference :",style: TextStyle(fontSize: 20,decoration: TextDecoration.underline,color: Colors.black),),
                ),
                SizedBox(height: 15,),


                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.9,
                  alignment: Alignment.center, // Align the child (text) to the center
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    border: Border.all(color: Colors.grey), // Add border for styling
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ), // Add border radius for rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Add padding for text
                    child: Text(
                      "We invite you to join us in our mission to empower and uplift the elderly community. Whether you're a senior seeking support,"
                          " a caregiver looking for opportunities, or a"
                          " concerned family member, Elder Care is here to serve you.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),



                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text("Thank you for choosing Elder Care – where compassion meets convenience for our beloved seniors.",style:
                  TextStyle(fontSize: 25,fontFamily: 'Schyler')
                    ,),
                ),

                SizedBox(height: 15,),
                Center(
                  child: Container(
                      width: 230,
                      height: 80,
                      child: Row(
                        children: [
                          SizedBox(width: 40,),
                          GestureDetector(
                            onTap: () {
                              _launchFacebookLogin();
                            },
                            child: Image.asset(
                              "assets/images/fblogo.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                          SizedBox(width: 40,),
                          GestureDetector(
                            onTap: () {
                              _launchXLogin();
                            },
                            child: Image.asset(
                              "assets/images/x.png",
                              height: 60,
                              width: 60,
                            ),
                          ),
                        ],
                      )
                  ),
                ),

                Divider(color: Colors.grey,),
                Text("Stay Connected With Us..")

              ]),
            ),

            )
          ],
          
          ),


     

    );
  }
}

void _launchFacebookLogin() async {
  const url = 'https://www.facebook.com/login/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchXLogin() async {
  const url = 'https://twitter.com/i/flow/login';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}