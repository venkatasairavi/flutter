
import 'dart:async';
import 'dart:convert';
import 'package:moibleapi/app/routes/api.routes.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

void main() {
  stompClient.activate();
}

  void onConnect(StompFrame frame) {
    print(frame.body);

    stompClient.subscribe(
      destination: '/topic/vc/f51633c3-278d-4816-9fa3-81b65fef6b8a/ee12326a-3381-4bd8-ab78-965fb68779af',
      callback: (frame) {
        List<dynamic>? result = json.decode(frame.body!);
        print(result);
      },
    );

    Timer.periodic(Duration(seconds: 10), (_) {
      stompClient.send(
        destination: '/app/heartBeats',
        body: json.encode({
          'userGuid': '6800b44d-b947-4315-9160-e4ad83958305',
          'lastActiveDate': '2022-06-21 06:31:30',
          'timeZone': 'Asia/Kolkata',
        }),
      );

      stompClient.send(
        destination: '/app/heartBeat/request/6800b44d-b947-4315-9160-e4ad83958305',
        body: json.encode({
          'userGuid': '443834dd-138a-4b0f-ae0a-918b6b0374ba',
          'timeZone': 'Asia/Kolkata',
        }),
      );

    });
  }

  StompClient stompClient = StompClient(
    config: StompConfig(
        url: 'wss://$domain/api/ws?token=eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ2ZW5rYXRhc2FpcmF2aUBnbWFpbC5jb20iLCJpYXQiOjE2NTU3NzgwMzQsImV4cCI6MTY1NTgwNjgzNH0.CVMl5ygsM4I_BUllgXd4pQr_WemUNmB5RSeEJCm4H0pSvfe8QOfexRhIJ3omgaAjyNRHbCcRKemUfbUCbs6Pfg',
        onConnect: onConnect,
        beforeConnect: () async {
          print('waiting to connect...');
          await Future.delayed(Duration(milliseconds: 200));
          print('connecting...');
        },
        onWebSocketError: (dynamic error) => print(error.toString()),

       // stompConnectHeaders: {'login': 'guest'},

        // webSocketConnectHeaders: {'passcode': 'guest'},
        onStompError: (d) => print('error stomp'),
        onDisconnect: (f) => print('disconnected')
    ),
  );

