//
// getCurrentLocation(AddFutsal Provider addFutsalProvider, String role) async { LocationPermission permission= await Helper().getPermission();
// if (permission==
// LocationPermission.whileInUse ||
// permission LocationPermission. always) {
// Stream<Coordinate> coordinateStream
// =
// Helper().getCoordinateStream();
// coordinateStream.listen((Coordinate coordinate) async {
// setState(() {
// lat =
// coordinate.latitude;
// long coordinate.longitude; address coordinate.address!;
// });
// ==
// false)
// if (addFutsal Provider.isValueDisplayed addFutsalProvider.setIsValueDisplayed (true);
// if (role
// ==
// userStr) {
// for (int i = 0; i < addFutsalProvider. futsallist.length; i++) { List<Location> startLocations = await locationFromAddress( addFutsalProvider.futsallist[i].address!);
// }
// double haversine = await Helper().calculateDistance(
// lat!, long!,
// startLocations.first.latitude, startLocations.first.longitude);
// addFutsalProvider.futsalDetailsList.add(Futsal DetailsList(
// } else {
// }
// futsalModel: addFutsalProvider.futsallist[i], distance: haversine));
// List<Location> startLocations = await locationFromAddress( addFutsalProvider.futsalModel!.address!);
// double haversine = await Helper().calculateDistance(lat!, long!, startLocations.first.latitude, startLocations.first.longitude);
// addFutsalProvider.futsalDetailsList.add(FutsalDetailsList( futsalModel: addFutsalProvider.futsalModel,
// distance: haversine));
// addFutsalProvider.futsalDetailsList
//     .sort((a, b) => (a.distance ?? 0).compareTo(b. distance ?? 0)); print(addFutsalProvider.futsalDetailsList);
// });