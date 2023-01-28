import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kitubs/screens/home/tenant_detail.dart';

import '../../../models/TenantModel.dart';
import '../model/tenant_model.dart';

class BigPost extends StatelessWidget {
  const BigPost({Key? key,  required this.tenant}) : super(key: key);
 final TenantModel tenant;

  @override
  Widget build(BuildContext context) {

    final formatCurrency = new NumberFormat.currency(locale: 'en_UG', symbol: "",decimalDigits: 1);
    // final NumberFormat ugCurrency = NumberFormat('#,###', 'en_US');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.amber)
      ),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>TenantDetail(tenant: tenant)));
          // Navigator.push(context: context, builder: (BuildContext context){
          //   return TenantDetail(tenant:tenant);
          //Navigate to article deatils page
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context){
          //       return ArticleDetailsPage(article: article,);
          //     })
          // );
        },
        child: Container(
          padding: EdgeInsets.all(5),
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


                  // Text('${tenant.amount}'),
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${tenant.name?.toUpperCase()}",
                          style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,),
                        ),
                        Text(
                            "${formatCurrency.format(int.parse(tenant.balance!))}",style: TextStyle(fontWeight: FontWeight.w600,color:
                        (int.parse(tenant.balance!) > 0) ?Colors.green : Colors.red)
                        ),
                      ],
                    ),
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
