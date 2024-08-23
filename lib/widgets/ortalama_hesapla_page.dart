import 'package:dinamik_ortalama_hesapla/constants/app_constants.dart';
import 'package:dinamik_ortalama_hesapla/helper/data_helper.dart';
import 'package:dinamik_ortalama_hesapla/model/ders.dart';
import 'package:dinamik_ortalama_hesapla/widgets/ders_listesi.dart';
import 'package:dinamik_ortalama_hesapla/widgets/ortalama_goster.dart';
import 'package:flutter/material.dart';

class OrtalamaHesaplaPage extends StatefulWidget {
  const OrtalamaHesaplaPage({super.key});

  @override
  State<OrtalamaHesaplaPage> createState() => _OrtalamaHesaplaPageState();
}

class _OrtalamaHesaplaPageState extends State<OrtalamaHesaplaPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double secilenHarfDegeri = 4;
  double secilenKrediDegeri = 1;
  String girilenDersAdi = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              Sabitler.baslikText,
              style: Sabitler.baslikStyle,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Form
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildForm(),
                ),
                Expanded(
                  flex: 1,
                  child: OrtalamaGoster(
                      ortalama: DataHelper.ortalamaHesapla(),
                      dersSayisi: DataHelper.tumEklenenDersler.length),
                )
              ],
            ),
            Expanded(child: DersListesi(
              onDismissed: (index) {
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {});
              },
            ))
            //Liste
          ],
        ));
  }

  Widget _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatayPadding8,
            child: _buildTextFormField(),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: _buildHarfler(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Sabitler.yatayPadding8,
                  child: _buildKrediler(),
                ),
              ),
              IconButton(
                onPressed:() {_dersEkleveOrtalamaHesapla();},
                icon: Icon(Icons.arrow_forward_ios_sharp),
                color: Sabitler.anaRenk,
                iconSize: 30,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  _buildTextFormField() {
    return TextFormField(
      onSaved: (deger) {
        setState(() {
          girilenDersAdi = deger!;
        });
      },
      validator: (s) {
        if (s!.length <= 0) {
          return "Lütfen Ders Adını Giriniz";
        } else
          return null;
      },
      decoration: InputDecoration(
          hintText: "Ders ADI",
          border: OutlineInputBorder(
              borderRadius: Sabitler.borderRadius, borderSide: BorderSide.none),
          filled: true,
          fillColor: Sabitler.anaRenk.shade100.withOpacity(0.3)),
    );
  }

  _buildHarfler() {
    return Container(
        alignment: Alignment.center,
        padding: Sabitler.dropDownPadding,
        decoration: BoxDecoration(
            color: Sabitler.anaRenk.shade100.withOpacity(0.3),
            borderRadius: Sabitler.borderRadius),
        child: DropdownButton<double>(
          value: secilenHarfDegeri,
          elevation: 16,
          iconEnabledColor: Sabitler.anaRenk.shade200,
          onChanged: (deger) {
            setState(() {
              secilenHarfDegeri = deger!;
            });
          },
          items: DataHelper.tumDerslerinHarfleri(),
          underline: Container(),
        ));
  }

  _buildKrediler() {
    return Container(
        alignment: Alignment.center,
        padding: Sabitler.dropDownPadding,
        decoration: BoxDecoration(
            color: Sabitler.anaRenk.shade100.withOpacity(0.3),
            borderRadius: Sabitler.borderRadius),
        child: DropdownButton<double>(
          value: secilenKrediDegeri,
          elevation: 16,
          iconEnabledColor: Sabitler.anaRenk.shade200,
          onChanged: (deger) {
            setState(() {
              secilenKrediDegeri = deger!;
            });
          },
          items: DataHelper.tumDerslerinKredileri(),
          underline: Container(),
        ));
  }

  _dersEkleveOrtalamaHesapla() {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      formKey.currentState?.save();
      var eklenecekDers = Ders(
          ad: girilenDersAdi,
          harfDegeri: secilenHarfDegeri,
          krediDegeri: secilenKrediDegeri);
      DataHelper.dersEkle(eklenecekDers);
      setState(() {});
    }
  }
}
