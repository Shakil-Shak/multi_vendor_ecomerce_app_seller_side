import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/services/store_services.dart';
import 'package:ecomarce_seller_app/views/messages_screen/chat_screen.dart';
import 'package:ecomarce_seller_app/views/widgets/loading_indicator.dart';
import 'package:ecomarce_seller_app/views/widgets/text_style.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
         
          title: boldText(text: messages, size: 16.0, color: fontGrey),
        ),
        body: StreamBuilder(
          stream: StoreSrevices.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndecator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var t = data[index]['created_on'] == null
                          ? DateTime.now()
                          : data[index]['created_on'].toDate();
                      var time = intl.DateFormat("h:mma").format(t);
                      return ListTile(
                        onTap: () {
                          Get.to(() => ChatScreen(), arguments: [
                            data[index]['friend_name'],
                            data[index]['fromId']
                          ]);
                        },
                        leading: const CircleAvatar(
                          backgroundColor: purpleColor,
                          child: Icon(
                            Icons.person_2,
                            color: white,
                          ),
                        ),
                        title: boldText(
                            text: "${data[index]['sender_name']}",
                            color: fontGrey),
                        subtitle: normalText(
                            text: "${data[index]['last_msg']}",
                            color: darkGrey),
                        trailing: normalText(text: time, color: darkGrey),
                      );
                    }),
                  ),
                ),
              );
            }
          },
        ));
  }
}
