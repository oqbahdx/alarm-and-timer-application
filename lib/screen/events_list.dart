import 'package:alert/config/theme.dart';
import 'package:alert/widget/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);
static String id = "EventsPage";
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuild(title: 'Events List'),
      backgroundColor: blackC,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            const Text('Alarms',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('09:30',style: TextStyle(
                      color: greyC,
                      fontSize: 45,
                      fontWeight: FontWeight.bold
                    ),),
                    Text('Weekends',style: TextStyle(
                        color: greyC,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
                CupertinoSwitch(
                  thumbColor: redC,
                  activeColor: blackC,
                  value: true,onChanged: (bool value){

                },)
              ],
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('06:30',style:  TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold
                    ),),
                    Align(
                      child: Text('Mon-Fri',style: TextStyle(
                          color: greyC,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ],
                ),
                CupertinoSwitch(
                  thumbColor: greenC
                  ,
                  activeColor: blackC,
                  value: false,onChanged: (bool value){

                },)
              ],
            ),
            const SizedBox(height: 25,),
            Card(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35)
              ),
              shadowColor: Colors.white24,
              color: blackC,
              elevation: 20.0,
              child: Container(
                child: Center(child: Text('+  Add Alarm',style: appBarStyle,),),
                height: 80,
                decoration: BoxDecoration(
                  color: blackC,
                  borderRadius: BorderRadius.circular(35),
                ),
              ),

            ),
            const SizedBox(height: 30,),
            const Text('Timer',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            const Text('05:00',style:  TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.bold
            ),),
        Text('Soft Boiled egg',style: TextStyle(
            color: greyC,
            fontSize: 12,
            fontWeight: FontWeight.bold
        )),
            const SizedBox(height: 25,),
            Card(
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35)
              ),
              shadowColor: Colors.white24,
              color: blackC,
              elevation: 20.0,
              child: Container(
                child: Center(child: Text('+  Add Timer',style: appBarStyle,),),
                height: 80,
                decoration: BoxDecoration(
                  color: blackC,
                  borderRadius: BorderRadius.circular(35),
                ),
              ),

            ),
            const SizedBox(height: 10,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.access_time_filled,color: greyC,),
                  Card(
                    shadowColor: Colors.white24,
                    elevation: 50.0,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: Container(
                      child: Center(
                        child: Icon(Icons.add,color: greyC,size: 50,),
                      ),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: blackC,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  Icon(Icons.menu,color: greyC,)
                ],
              ),
            )
          ],
        ),
      ),
    );

  }
}
