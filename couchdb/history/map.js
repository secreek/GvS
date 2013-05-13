function(doc){
  if(doc["data"]) {
    for (var i = 0; i < doc["data"].length; i++) {
      var evt = doc["data"][i];
      var type = evt["type"];
      var actor = evt["actor"]["login"];
      var avatar = evt["actor"]["avatar_url"];
      var date = evt["created_at"];
      var result = { "date" : date, "type" : type };
      emit(actor + "/" + avatar, result);
    }
  }
}
