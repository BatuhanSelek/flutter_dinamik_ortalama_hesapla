import 'package:dinamik_ortalama_hesapla/constants/app_constants.dart';
import 'package:dinamik_ortalama_hesapla/helper/data_helper.dart';
import 'package:dinamik_ortalama_hesapla/model/ders.dart';
import 'package:flutter/material.dart';

class DersListesi extends StatelessWidget {
  final Function onDismissed;
  const DersListesi({super.key, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumEklenenDersler;
    return tumDersler.length > 0
        ? ListView.builder(
            itemCount: tumDersler.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                onDismissed: (a){
                  onDismissed(index);
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Card(
                      child: ListTile(
                    title: Text(tumDersler[index].ad),
                    leading: CircleAvatar(
                      backgroundColor: Sabitler.anaRenk,
                      child: Text(
                        (tumDersler[index].harfDegeri *
                                tumDersler[index].krediDegeri)
                            .toStringAsFixed(0),
                      ),
                    ),
                    subtitle: Text(
                        "${tumDersler[index].krediDegeri} Kredi, Not Değeri : ${tumDersler[index].harfDegeri}"),
                  )),
                ),
              );
            })
        : Container(
            child: Center(child: Text("Lütfen Ders Ekleyiniz",style: Sabitler.baslikStyle,)),
          );
  }
}
