import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Download PDF:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              child: DownloadWidget(),
            )
          ],
        ),
      ),
    );
  }
}
class DownloadWidget extends StatefulWidget {
  const DownloadWidget({super.key});

  @override
  _DownloadWidgetState createState() => _DownloadWidgetState();
}
class _DownloadWidgetState extends State<DownloadWidget> {
  double _progress = 0.0;
  bool _isDownloading = false;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          await _handleNotificationClick(response.payload);
        }
      },
    );
  }
  Future<void> _handleNotificationClick(String? payload) async {
    if (payload != null) {
      OpenFile.open(payload);
    }
  }
  Future<void> _showDownloadCompleteNotification(String filePath) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'id',
      'name',
      channelDescription: 'PDF Document',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.show(
      0,
      'Download Complete',
      'Your PDF has been downloaded.',
      platformChannelSpecifics,
      payload: filePath,
    );
  }
  Future<void> _downloadPDF() async {
  // Verificar y solicitar permisos de almacenamiento
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    status = await Permission.storage.request();
    if (!status.isGranted) {
      print("Permiso denegado");
      return;
    }
  }

  // Inicia el proceso de descarga
  setState(() {
    _isDownloading = true;
    _progress = 0.0;
  });

  try {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(Duration(milliseconds: 50));
      setState(() {
        _progress = i / 100;
      });
    }

    // Crear PDF
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello, PDF!'),
          );
        },
      ),
    );

    // Guardar el PDF
    final output = await getExternalStorageDirectory();
    final filePath = '${output!.path}/example.pdf';
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    setState(() {
      _isDownloading = false;
      _progress = 1.0;
    });

    await _showDownloadCompleteNotification(filePath);
  } catch (e) {
    setState(() {
      _isDownloading = false;
    });
    print("Error: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 25.0,
      lineWidth: 5.0,
      percent: _progress,
      center: _isDownloading
          ? Text("${(_progress * 100).toStringAsFixed(0)}%")
          : IconButton(
              icon: Icon(
                Icons.file_download_outlined,
                color: Colors.blue,
              ),
              iconSize: 25.0,
              onPressed: _downloadPDF,
            ),
      progressColor: Colors.blue,
      backgroundColor: Colors.grey[200]!,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
