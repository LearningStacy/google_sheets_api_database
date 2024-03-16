import 'package:flutter/material.dart';
import 'package:search_database_sheets_api/models/LetterFields.dart';
import 'package:search_database_sheets_api/models/PokemonFields.dart';
import 'package:search_database_sheets_api/models/google_sheets_api.dart';
import 'package:search_database_sheets_api/models/sheets_api_alphabet.dart';

class MainPage extends StatefulWidget{
  const MainPage({Key? key}):super(key:key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  List<LetterChar> allLetters=[];
  bool isSearching = false;

  final TextEditingController _searchController=  TextEditingController();

  late List<LetterChar> displayedList=List.from(allLetters);


  @override
  void initState(){
    super.initState();

    getAllLetters();
  }

  Future getAllLetters() async{
    allLetters = await AlphabetSheetsAPI.getAllLetters();

    setState(() {
      this.allLetters = allLetters;
    });
  }


  void filterList(String value) async{
    setState(() {
      displayedList =  allLetters.where((element) => element.letterChar.toLowerCase().contains(value.toLowerCase())).toList();
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
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
          title: const Text('Search for a Letter'),
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
                  fillColor: Colors.deepOrangeAccent.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none

                  ),
                  hintText: 'Search by Id',
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
                  Text("Welcome to Search a Letter", style: TextStyle(fontSize: 25),textAlign: TextAlign.center,),
                  SizedBox(height: 12,),
                  Text("Enter a id number to begin", style: TextStyle(fontSize: 18),textAlign: TextAlign.center,)
                ],):
              //display message if no results found
              displayedList.isEmpty && isSearching==true ? const Center(child: Text("No results found", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),):

              ListView.builder(
                  itemCount: displayedList.length,
                  itemBuilder: (context,index)=> ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    title: Text('Letter - ${displayedList[index].letterChar}', style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text('ID: ${displayedList[index].id}', style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 18),),
                  )
              ),

              ),
            ],
          ),
        ));
  }
}
