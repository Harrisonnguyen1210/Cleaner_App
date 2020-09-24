class Room {
  final String floorId, roomId, movHeatmap;
  final List<dynamic> dirtHeatmap;
  final double contaminationIndex;
  final int lastUpdate;
  final int lastCleaned;
  final bool isCleaning;

  Room(
      {this.floorId,
        this.roomId,
        this.movHeatmap,
        this.dirtHeatmap,
        this.contaminationIndex,
        this.isCleaning,
        this.lastCleaned,
        this.lastUpdate});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      floorId: json['floor_id'],
      roomId: json['room_id'],
      contaminationIndex: json['contamination_index'],
      dirtHeatmap: json['between_cleaning_plot'],
      lastUpdate: json['last_update'],
      lastCleaned: json['last_cleaned'],
      isCleaning: json['is_cleaning'],
    );
  }
}