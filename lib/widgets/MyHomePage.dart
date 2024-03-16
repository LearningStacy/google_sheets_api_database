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
 bool isSearching = false;

 final TextEditingController _searchController=  TextEditingController();

 late List<Pokemon> displayedList=List.from(allPokemon);


 @override
  void initState(){
    super.initState();

    getAllPokemon();
  }
  
  Future getAllPokemon() async{
    allPokemon = await GoogleSheetsAPI.getAllPokemon();

    setState(() {
      this.allPokemon = allPokemon;
    });
  }


 void filterList(String value) async{
   setState(() {
    displayedList =  allPokemon.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
   });
 }

 @override
 void dispose(){
   super.dispose();
   _searchController.dispose();
 }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // backgroundColor: Colors.deepPurpleAccent.shade100,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text('Search a Pokemon'),
          titleTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
          centerTitle: true,
        ),
        body:
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                controller: _searchController,

                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.deepPurple.shade50.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),

                    ),
                    hintText: 'Name of Pokemon',
                    hintStyle: TextStyle(fontStyle: FontStyle.italic, color:Colors.black.withOpacity(0.5)),
                    prefixIcon: const Icon(Icons.search),

                ),
                onChanged: (value) => {isSearching=true,filterList(value)},

              ),
              const SizedBox(height: 20,),
              Expanded(child:
              displayedList.isEmpty && isSearching == false ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Welcome to Search a Pokemon", style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
                  SizedBox(height: 12,),
                  Text("Enter a letter to begin", style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)
                ],):
              //display message if no results found
              displayedList.isEmpty && isSearching==true ? const Center(child: Text("No results found", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),):

              ListView.builder(
                  itemCount: displayedList.length,
                  itemBuilder: (context,index)=> ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    title: Text(displayedList[index].name, style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Generation: ${displayedList[index].generation}', style: const TextStyle(fontWeight: FontWeight.w300),),
                    trailing: Text(displayedList[index].elementType, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),),
                  )
              ),

              ),
            ],
          ),
        ));
  }
}
