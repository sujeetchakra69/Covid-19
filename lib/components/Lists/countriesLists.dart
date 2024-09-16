import 'package:covid19/components/Lists/Detailed_view.dart';
import 'package:covid19/components/services/statesServices.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Statesservices statesservices = Statesservices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text('Choose a Country'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search countries by name',
                hintStyle: const TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Trigger rebuild when search text changes
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: statesservices.countriesList(), // Call correct method
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var countryData = snapshot.data![index];
                      String countryName = countryData['country'];
                      String flagUrl = countryData['countryInfo']['flag'];
                      String cases = countryData['cases'].toString();

                      if (searchController.text.isEmpty ||
                          countryName
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                        return ListTile(
                          leading: Image.network(
                            flagUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          title: Text(countryName),
                          subtitle: Text('Cases: $cases'),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailedView(
                                        name: countryName,
                                        images: flagUrl,
                                        totalcases: snapshot.data![index]
                                            ['cases'],
                                        totaldeaths: snapshot.data![index]
                                            ['deaths'],
                                        totalpopulation: snapshot.data![index]
                                            ['recovered'],
                                        totalrecovered: snapshot.data![index]
                                            ['population'],
                                      ))),
                        );
                      } else {
                        return Container(); // Return empty container if search doesn't match
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
