import 'package:flutter/material.dart';

class SizeConfig {
  static double? screenwidth;
  static double? screenheight;
  static double? screendefault;
  static Orientation? orientation;
  void init(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    orientation = MediaQuery.of(context).orientation;

    screendefault = orientation == Orientation.landscape
        ? screenheight! * .024
        : screenwidth! * .024;
    print('this is the default size $screendefault');
  }
}
  



  
 /* ListView.builder(
             itemCount: Matchess.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,indeex){
                return InkWell(
          onTap: (){
          },
          child: Column(
            children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:22.0),
              child: IntrinsicHeight(
                  child: Row(  
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                        Container(
                          margin: EdgeInsets.only(bottom:10,right: 12),
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(image: DecorationImage(image:Matchess[indeex]["imgurll"]==null?
                          AssetImage("images/user.jpg") as ImageProvider:
                        CachedNetworkImageProvider(Matchess[indeex]["imgurll"]),fit: BoxFit.cover),
                        shape: BoxShape.circle,
                        ),),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6),
                          Text(Matchess[indeex]["nom"]),
                          const SizedBox(height: 6),
                          Text("Bonjour....",style: TextStyle(color: Colors.grey),),
                        ],)
                  ],),            
              ),
            ),
            Divider(thickness: 1.0,)
            ],
          ),
                );
        })*/
  
      /*    if ((val.docs[i].data()['interests'].contains(val.docs[index].data()['interests'][j]))&&
          (val.docs[i].data()['Location'].contains(val.docs[index].data()["Location"])))*/