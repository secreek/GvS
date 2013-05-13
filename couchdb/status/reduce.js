function(keys, values, rereduce) {
  if(!rereduce) {
    var result = {};
    for(var i = 0;i < keys.length;i ++) {
      var k = keys[i][0];
      var v = values[i];
      if(!(k in result)) {
        result[k] = v;
      } else {
        result[k] += v;
      }
    }
    return result;
  } else { // rereduce
    var result = values[0];
    for(var i = 0;i < values.length; i++) {
      r = values[i];
      for(var k in r) {
        if(!(k in result)) {
          result[k] = r[k];
        } else {
          result[k] += r[k];
        }
      }
    }
    return result;
  }
}
