import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firestore App',
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Firestore Cloud')),
        ),
        body: Center(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error de conexion');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Cargando");
                  }
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data!.docs.map((userss) {
                    return Center(
                      child: Text(userss["Nombre"]),
                    );
                  }).toList());
                })),
      ),
    );
  }
}
