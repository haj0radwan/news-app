import 'package:flutter/material.dart';
import 'package:news_app/core/network/network_info.dart';

class Getconnst extends StatelessWidget {
  const Getconnst({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: NetworkInfoImpl().isConnected,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return Center(
              child:
                  Text(snapshot.data == true ? "connected " : "not connected "),
            );
          } else {
            return  Text("");
          }
        });
  }
}
