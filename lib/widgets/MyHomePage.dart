
import 'package:flutter/material.dart';
import 'package:search_database_sheets_api/models/PokemonFields.dart';
import 'package:search_database_sheets_api/models/google_sheets_api.dart';

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}):super(key:key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage>{
 List<Pokemon> allPokemon=[];
  @override
  void initState(){
    super.initState();

    getAllPokemon();
  }
  
  Future getAllPokemon() async{
    final allPokemon = await GoogleSheetsAPI.getAllPokemon();

    setState(() {
      this.allPokemon = allPokemon;
    });
  }


late List<Pokemon> displayed_list=List.from(allPokemon);

 void filterList(String value){
   setState(() {
     displayed_list = allPokemon.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
   });
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
              onChanged: (value) => filterList(value),
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
              displayed_list.length == 0? Center(child: Text("No results found", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),):

              ListView.builder(
                  itemCount: displayed_list.length,
                  itemBuilder: (context,index)=> ListTile(
                    contentPadding: EdgeInsets.all(8),
                    title: Text(displayed_list[index].name, style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Generation: ${displayed_list[index].generation}', style: TextStyle(fontWeight: FontWeight.w300),),
                    trailing: Text("${displayed_list[index].elementType}", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),),
                  )
              ),



              ),
            ],
          ),
        ));
  }
}
