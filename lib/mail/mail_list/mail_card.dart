import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/mail.dart';


class MailCard extends StatelessWidget {
  MailCard(this.mailDoc, {Key? key}) : super(key: key);
  Mail? mailDoc;
  
  
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [
          Divider(indent: 30,color:Colors.grey),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                mailDoc!.read == true ? SizedBox(width: 10,):
                Icon(CupertinoIcons.circle_fill, size: 10, color: Colors.blueAccent,),

                SizedBox(width: 10,),
                Text(mailDoc!.recipient,
                  style: TextStyle(
                  fontSize: 17,
                    fontWeight: FontWeight.w600,
                ),),

                Expanded(child: SizedBox(),),
                Text(mailDoc!.time+". ",style: TextStyle(
                  color: Colors.grey,
                )),
                Icon(CupertinoIcons.chevron_right , size:15,color: Colors.grey,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                SizedBox(width: 20,),
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(
                        text: mailDoc!.title,
                        style: TextStyle(
                          color: Colors.black,
                        )
                    )
                    ,),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              children: [
                SizedBox(width: 20,),
                Flexible(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(
                        text:  MediaQuery.of(context).size.width < mailDoc!.content.length ? mailDoc!.content : mailDoc!.content+"\n",
                          style: TextStyle(
                            color: Colors.grey,
                          )
                      )
                     ,),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

