import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bands_name/models/banda_model.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    List<BandaModel> bandas = [
      BandaModel(id: "1", name: "Nombre 1", votes: 2),
      BandaModel(id: "2", name: "Banda 2", votes: 3),
      BandaModel(id: "3", name: "Otra banda 3", votes: 5),
      BandaModel(id: "4", name: "Texto 4", votes: 22),
      BandaModel(id: "5", name: "Test 5", votes: 24),
    ]; 

    final txtController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Bandas",
          style: TextStyle(
            color: Colors.black87
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bandas.length,
        itemBuilder: (context, i) => _getTiles(bandas[i]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        child: Icon(Icons.add),
        onPressed: _addNewBand
      ),
   );
  }

  Widget _getTiles(BandaModel banda) {
    return Dismissible(
      key: Key(banda.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Eliminar banda',
            style: TextStyle(
              color: Colors.white
            ),
          )
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            banda.name.substring(0,2)
          ),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(banda.name),
        trailing: Text("${banda.votes}", style: TextStyle(fontSize: 20),),
        onTap: (){
          print(banda.name);
        },
      ),
      onDismissed: (direction){
        //Crear proceso de eliminación
      },
    );
  }

  _addNewBand(){
    if(Platform.isAndroid){
      return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Nueva banda"),
            content: TextField(
              controller: txtController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text("Agregar"),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: ()=>_insertBand(txtController.text),
              )
            ],
          );
        }
      );
    }
    showCupertinoDialog(
      context: context,
     builder: ( _ ){
       return CupertinoAlertDialog(
         title: Text('Nueva banda'),
         content: CupertinoTextField(
           controller: txtController,
         ),
         actions: <Widget>[
           CupertinoDialogAction(
             isDefaultAction: true,
             child: Text('Agregar'),
             onPressed: ()=>_insertBand(txtController.text),
           ),
           CupertinoDialogAction(
             isDestructiveAction: true,
             child: Text('Cancelar'),
             onPressed: ()=>Navigator.pop(context),
           )
         ],
      );
     }
    );
  }

  _insertBand(String nombre){
    print(nombre);
    if(nombre.length > 0){
      //agregamos
      bandas.add(BandaModel(id: DateTime.now().toString(), name: nombre, votes: 0));
      setState(() {
        
      });
    }
    Navigator.pop(context);
  }
}