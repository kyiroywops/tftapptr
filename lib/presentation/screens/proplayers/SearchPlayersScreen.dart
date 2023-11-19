import 'package:flutter/material.dart';

class SearchPlayersScreen extends StatefulWidget {
  @override
  _SearchPlayersScreenState createState() => _SearchPlayersScreenState();
}

class _SearchPlayersScreenState extends State<SearchPlayersScreen> {
  final List<String> servers = ['Americas', 'Europa', 'Asia', 'Oceania'];
  String selectedServer = 'Americas'; // Valor predeterminado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          'Search Players',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade900,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                 Container(
                  padding: EdgeInsets.fromLTRB(20, 8, 10, 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: Theme(
                    data: Theme.of(context).copyWith(
                    // Aquí personalizamos el tema del menú desplegable
                    popupMenuTheme: PopupMenuThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Esto dará los bordes redondeados
                      ),
                      // Otras personalizaciones pueden ir aquí
                    ),
                  ),
                                  
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(16), // This line gives the dropdown rounded corners
                        
                        value: selectedServer,
                        icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.white), // Ícono de flecha
                        dropdownColor: Colors.black.withOpacity(0.4), // Color del menú desplegable
                        onChanged: (String? newValue) {
                          setState(() {
                              selectedServer = newValue!;
                          });
                        },
                        items: servers.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        
                          fontFamily: 'ReadexPro',
                          fontWeight: FontWeight.bold,
                        
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Espacio entre el dropdown y el campo de texto
                Expanded(
                  child: TextField(
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 14,
                      fontFamily: 'ReadexPro',
                      fontWeight: FontWeight.bold,
                      // This will make the typed text white
                    ),
                    decoration: InputDecoration(
                      hintText: 'SummonerID',
                      hintStyle: TextStyle(
                        color: Colors.grey[300],
                        fontSize: 14,
                        fontFamily: 'ReadexPro',
                        fontWeight: FontWeight.bold,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 0),
                        child: Icon(Icons.search, color: Colors.grey[300]),
                      ),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
