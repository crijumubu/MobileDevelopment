import 'package:flutter/material.dart';
import '../controller/controller.dart';
import '../global.dart';
import '../model/imessage.dart';

class Buzon extends StatelessWidget {
  Buzon({
    super.key,
  });
  final Controller _controller = Controller();

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Buzón", style: appbar,),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _controller.getBuzon(email),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is String) {
              return Center(
                child: Text(snapshot.data),
              );
            }
            List<IMessage> buzon = snapshot.data as List<IMessage>;
            return ListView.separated(
                itemCount: buzon.length,
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.black,
                      height: 5,
                    ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20, top: 15, left: 20),
                    child: Flexible(
                      // height: 120,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(buzon[index].asunto,
                                      style: tituloContacto)),
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              buzon[index].mensaje,
                              style: fieldTexto,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "No tiene mensajes de este usuario.",
                style: infoContacto,
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
