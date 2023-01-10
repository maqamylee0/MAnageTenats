import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kitubs/screens/home/tenant_detail.dart';

import '../model/tenant_model.dart';

class BigPost extends StatelessWidget {
  const BigPost({Key? key,  required this.tenant}) : super(key: key);
 final Tenant tenant;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber)
      ),
      child: GestureDetector(
        onTap: (){
          showBottomSheet(context: context, builder: (BuildContext context){
            return TenantDetail(tenant:tenant);
          });
          //Navigate to article deatils page
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context){
          //       return ArticleDetailsPage(article: article,);
          //     })
          // );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CachedNetworkImage(
              //   imageUrl: article.urlToImage,
              //   placeholder: (context, url){
              //     return CircularProgressIndicator();
              //   },
              //   errorWidget: (context, url, error){
              //     return Container(
              //       width: MediaQuery.of(context).size.width,
              //       height: 150,
              //       child: Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           FaIcon(FontAwesomeIcons.chainBroken),
              //           Text("Could not load this image")
              //         ],
              //       ),
              //     );
              //   },
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "${tenant.name?.toUpperCase()}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 10,),
                  // Text('${tenant.amount}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          "Amount Due :  "
                      ),
                      Text(
                          "${tenant.balance}"
                      ),
                    ],
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
