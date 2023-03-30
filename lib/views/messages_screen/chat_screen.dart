import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomarce_seller_app/const/const.dart';
import 'package:ecomarce_seller_app/services/store_services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../controllers/chats_controller.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/text_style.dart';
import 'components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: darkGrey,
          ),
        ),
        title: boldText(text: chats, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Obx(
            () => controller.isLoading.value
                ? Center(
                    child: loadingIndecator(),
                  )
                : Expanded(
                    child: StreamBuilder(
                    stream: StoreSrevices.getChatMessages(
                        controller.chatDocId.toString()),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndecator(),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child:
                              "Send a message...".text.color(fontGrey).make(),
                        );
                      } else {
                        return ListView(
                            children: snapshot.data!.docs
                                .mapIndexed((currentValue, index) {
                          var data = snapshot.data!.docs[index];
                          return Align(
                              alignment: data['uid'] == currentUser!.uid
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: chatBubble(data));
                        }).toList());
                      }
                    },
                  )),
          ),
          10.heightBox,
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: controller.msgController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey)),
                    hintText: "Type a message..."),
              )),
              IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: purpleColor,
                  ))
            ],
          )
              .box
              .height(80)
              .padding(const EdgeInsets.all(12))
              .margin(const EdgeInsets.only(bottom: 8))
              .make()
        ]),
      ),
    );
  }
}
