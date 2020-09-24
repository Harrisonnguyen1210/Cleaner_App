class Room {
  final String floorId, roomId, movHeatmap, dirtHeatmap;
  final double dirtIndex;
  final int lastUpdate;
  final int lastCleaned;
  final bool isCleaning;

  Room(
      {this.floorId,
        this.roomId,
        this.movHeatmap,
        this.dirtHeatmap,
        this.dirtIndex,
        this.isCleaning,
        this.lastCleaned,
        this.lastUpdate});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      floorId: json['floor_id'],
      roomId: json['room_id'],
      dirtIndex: json['dirt_index'],
      dirtHeatmap: json['dirt_heatmap'],
      movHeatmap: json['mov_heatmap'],
      lastUpdate: json['last_update'],
      lastCleaned: json['last_cleaned'],
      isCleaning: json['is_cleaning'],
    );
  }
}