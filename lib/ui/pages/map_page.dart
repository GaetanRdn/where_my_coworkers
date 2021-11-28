import 'package:easymakers_tracker/models/client.dart';
import 'package:easymakers_tracker/stores/client_storage.dart';
import 'package:easymakers_tracker/models/mission.dart';
import 'package:easymakers_tracker/stores/mission_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<MapPage> {
  final MissionStorage _missionStorage = MissionStorage();
  final ClientStorage _clientStorage = ClientStorage();
  List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() async {
    List<Client> clients = await _clientStorage.getAll();
    List<Mission> missions = await _missionStorage.getAll();

    setState(() {
      _markers = clients.map((client) {
        if (missions.any((mission) => mission.clientId == client.id)) {
          return Marker(
            width: 16.0,
            height: 16.0,
            point: LatLng(client.latitude, client.longitude),
            builder: (ctx) => const Icon(Icons.military_tech, color: Colors.blue),
          );
        }
        return Marker(
          width: 16.0,
          height: 16.0,
          point: LatLng(client.latitude, client.longitude),
          builder: (ctx) => const Icon(Icons.business, color: Colors.red),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Flexible(
          child: FlutterMap(
        options: MapOptions(
          center: LatLng(47.218372, -1.553621),
          zoom: 12.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            // For example purposes. It is recommended to use
            // TileProvider with a caching and retry strategy, like
            // NetworkTileProvider or CachedNetworkTileProvider
            tileProvider: const NonCachingNetworkTileProvider(),
          ),
          MarkerLayerOptions(markers: _markers)
        ],
      ))
    ]);
  }
}
