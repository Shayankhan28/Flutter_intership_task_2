import 'package:apitask/ApiFetching/Fetch_api.dart';
import 'package:apitask/Routings/routename.dart';
import 'package:apitask/models/model.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get API"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 244, 187, 123),
      ),
      body: Center(
        child: FutureBuilder<Model>(
          future: getapidata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Color.fromARGB(255, 244, 187, 123),
              );
            } else if (!snapshot.hasData || snapshot.hasError) {
              return const Text("Data Not Found!");
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: InkWell(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                            snapshot.data!.data![index].avatar ?? "",
                          ),
                        ),
                        title: Text(
                          snapshot.data!.data![index].firstName ?? "",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routename.profilescreen,
                          arguments: {
                            "image": snapshot.data!.data![index].avatar ?? "",
                            "firstname":
                                snapshot.data!.data![index].firstName ?? "",
                            "lastname":
                                snapshot.data!.data![index].lastName ?? "",
                            "email": snapshot.data!.data![index].email ?? "",
                          },
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
