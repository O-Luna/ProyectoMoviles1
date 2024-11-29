import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/providers/providers.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class Bluetooth extends StatefulWidget {
  final Map<String, dynamic> mascota;

  const Bluetooth({
    Key? key,
    required this.mascota,
  }) : super(key: key);

  @override
  State<Bluetooth> createState() => _BluetoothState();  
}

class _BluetoothState extends State<Bluetooth> {
  final _bluetooth = FlutterBluetoothSerial.instance;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  //BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  //BluetoothDevice? _deviceConnected;
  int times = 0;
  String latitud= "0.0";
  String longitud= "0.0";
  bool state =false;

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
  }

  void _receiveData() {
    var provider = Provider.of<Providers>(context);
    //_connection?.input?.listen((event) {
    provider.connection?.input?.listen((event) {

      if(!state){
        setState(() => latitud = String.fromCharCodes(event));
      } else{
        setState(() => longitud = String.fromCharCodes(event));
      }

      state= !state;      
    });
  }

  void _sendData(String data) {
    var provider = Provider.of<Providers>(context);
    
    // if (_connection?.isConnected ?? false) {
    //   _connection?.output.add(ascii.encode(data));
    // }
      if (provider.connection?.isConnected ?? false) {
      provider.connection?.output.add(ascii.encode(data));
      }
  }

  void _requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  @override
  void initState() {
    super.initState();

    _requestPermission();

    _bluetooth.state.then((state) {
      setState(() => _bluetoothState = state.isEnabled);
    });

    _bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => _bluetoothState = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => _bluetoothState = true);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Configurar bluetooth'),
          ),
          body: Column(
            children: [
              _controlBT(),
              _infoDevice(),
              Expanded(child: _listDevices()),
              _inputSerial(),
            ],
          ),
        );
      }
    );
  }

  Widget _controlBT() {
    return SwitchListTile(
      value: _bluetoothState,
      onChanged: (bool value) async {
        if (value) {
          await _bluetooth.requestEnable();
        } else {
          await _bluetooth.requestDisable();
        }
      },
      tileColor: Colors.black26,
      title: Text(
        _bluetoothState ? "Bluetooth encendido" : "Bluetooth apagado",
      ),
    );
  }

  Widget _infoDevice() {
  var provider = Provider.of<Providers>(context);

    return ListTile(
      tileColor: Colors.black12,
      //title: Text("Conectado a: ${_deviceConnected?.name ?? "ninguno"}"),
      title: Text("Conectado a: ${provider.deviceConnected?.name ?? "ninguno"}"),
      //trailing: _connection?.isConnected ?? false
      trailing: provider.connection?.isConnected ?? false
          ? TextButton( 
              onPressed: () async {
                //await _connection?.finish();
                await provider.connection?.finish();
                //setState(() => _deviceConnected = null);
                setState(() => provider.deviceConnected = null);
              },
              child: const Text("Desconectar"),
            )
          : TextButton(
              onPressed: _getDevices,
              child: const Text("Ver dispositivos"),
            ),
    );
  }

  Widget _listDevices() {
  var provider = Provider.of<Providers>(context);

    return _isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade100,
              child: Column(
                children: [
                  ...[
                    for (final device in _devices)
                      ListTile(
                        title: Text(device.name ?? device.address),
                        trailing: TextButton(
                          child: const Text('conectar'),
                          onPressed: () async {
                            setState(() => _isConnecting = true);

                            //_connection = await BluetoothConnection.toAddress(device.address);
                            provider.connection = await BluetoothConnection.toAddress(device.address);
                            //_deviceConnected = device;
                            provider.deviceConnected = device;
                            _devices = [];
                            _isConnecting = false;
                            
                            _receiveData();                            

                            setState(() {});
                          },
                        ),
                      )
                  ]
                ],
              ),
            ),
          );
  }

  Widget _inputSerial() {
    var provider = Provider.of<Providers>(context);
    return ListTile(
      // trailing: TextButton(
      //   child: const Text('reiniciar'),
      //   onPressed: () => setState(() => times = 0),
      // ),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(              
                  //"Lat: ($latitud)",
                  "Lat: (${provider.lat.toString()})",
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(              
                  //"Long: ($longitud)",
                  "Long: (${provider.lon.toString()})",
                  style: const TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text(              
            //       widget.mascota['latitud'].toString(),
            //       style: const TextStyle(fontSize: 18.0),
            //     ),
            //     Text(              
            //       widget.mascota['longitud'].toString(),
            //       style: const TextStyle(fontSize: 18.0),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}