import 'package:flutter/material.dart';

import '../../../controllers/controllers.dart';
import 'widgets/no_connection_body.dart';
import 'widgets/home_custom_appbar.dart';
import 'widgets/hasdata_body.dart';
import 'widgets/loading_body.dart';
import '../../../data/data.dart';
import 'widgets/empty_body.dart';

class HomePage extends StatelessWidget {
  final MainController controller;
  final UserDataController user;
  const HomePage({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    controller.checkConnection(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HomeCustomAppbar(
              controller: controller,
              courses: user.courses!,
            ),
            controller.isConnected
                ? controller.streamError
                    ? Container()
                    : Expanded(
                        child: StreamBuilder(
                          stream: controller.buildStream(
                            userUniv: user.univ,
                            userFac: user.fac,
                            userPromo: user.promo,
                            courses: user.courses,
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return controller.filter != null
                                  ? EmptyBody(
                                      cours: user.courses![controller.filter!],
                                    )
                                  : const EmptyBody();
                            }
                            if (snapshot.hasData) {
                              if (snapshot.data!.docs.isEmpty) {
                                return controller.filter != null
                                    ? EmptyBody(
                                        cours:
                                            user.courses![controller.filter!],
                                      )
                                    : const EmptyBody();
                              } else {
                                final tuyaux = snapshot.data!.docs.map((doc) {
                                  Map<String, dynamic> data = doc.data();
                                  return TuyauxModel(
                                    tuyauID: doc.id,
                                    authorName: data['authorName'],
                                    authorEmail: data['authorEmail'],
                                    imgUrl: data['imgUrl'],
                                    univ: data['univ'],
                                    fac: data['fac'],
                                    promo: data['promo'],
                                    title: data['title'],
                                    academicyear: data['academicyear'],
                                    session: data['session'],
                                    serie: data['serie'],
                                    suite: data['suite'],
                                    size: data['size'],
                                    isPDF: data['isPDF'],
                                  );
                                }).toList();
                                return HasDataBody(
                                  tuyaux: tuyaux,
                                  controller: controller,
                                );
                              }
                            } else if (!snapshot.hasData) {
                              return controller.filter != null
                                  ? EmptyBody(
                                      cours: user.courses![controller.filter!],
                                    )
                                  : const EmptyBody();
                            } else {
                              return const LoadingBody();
                            }
                          },
                        ),
                      )
                : const NoConnectionBody(),
          ],
        ),
      ),
    );
  }

  //Utiliser le setState kwanza

  // return ListView.builder(
  //                 itemCount: snapshot.data!.docs.length + (_isLoading ? 1 : 0),
  //                 itemBuilder: (context, index) {
  //                   if (index < snapshot.data!.docs.length) {
  //                     final document = snapshot.data!.docs[index];
  //                     return ListTile(
  //                       title: Text(document['title']),
  //                       subtitle: Text(document['content']),
  //                     );
  //                   } else {
  //                     return Center(child: CircularProgressIndicator());
  //                   }
  //                 },
  //               );
}
