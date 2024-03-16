
import 'package:flutter/material.dart';
import 'package:search_database_sheets_api/models/PokemonFields.dart';
import 'package:search_database_sheets_api/models/google_sheets_api.dart';

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}):super(key:key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage>{
  Pokemon? pokemon;

  @override
  void initState(){
    super.initState();

    getPokemon();
  }
  
  Future getPokemon() async{
    final pokemon = await GoogleSheetsAPI.getById(10);
    print(pokemon!.toJson());

    setState(() {
      this.pokemon = pokemon;
    });
  }


  //filtered results
  void filterList(String value){

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // backgroundColor: Colors.deepPurpleAccent.shade100,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: Text('Search a Pokemon'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(

                style: TextStyle(color: Colors.black, ),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.deepPurple.shade50.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),

                    ),
                    hintText: 'Name of Pokemon',
                    hintStyle: TextStyle(fontStyle: FontStyle.italic, color:Colors.black.withOpacity(0.5)),
                    prefixIcon: Icon(Icons.search)
                ),
              ),
              SizedBox(height: 20,),
              Expanded(child:
              //display message if no results found
              ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context,index)=> ListTile(
                    contentPadding: EdgeInsets.all(8),
                    title: Text('Hello', style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('hello world', style: TextStyle(fontWeight: FontWeight.w300),),
                    trailing: Text("bye", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),),
                  )
              ),



              ),
            ],
          ),
        ));
  }
}
