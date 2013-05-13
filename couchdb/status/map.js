function(doc){
  if(doc["data"]) {
    for (var i = 0; i < doc["data"].length; i++) {
      var evt = doc["data"][i];
      var t = evt["type"];
      var actor = evt["actor"]["login"];
      var score = 0;
      switch(t) {
        case 'CommitCommentEvent':
        score = 2;
        break;
        case 'CreateEvent':
        score = 10;
        break;
        case 'DeleteEvent':
        score = 5;
        break;
        case 'DownloadEvent':
        score = 3;
        break;
        case 'FollowEvent':
        score = 1;
        break;
        case 'ForkEvent':
        score = 3;
        break;
        case 'ForkApplyEvent':
        score = 5;
        break;
        case 'GistEvent':
        score = 5;
        break;
        case 'GollumEvent':
        score = 3;
        break;
        case 'IssueCommentEvent':
        score = 1;
        break;
        case 'IssuesEvent':
        score = 3;
        break;
        case 'MemberEvent':
        score = 10;
        break;
        case 'PublicEvent':
        score = 10;
        break;
        case 'PullRequestEvent':
        score = 5;
        break;
        case 'PullRequestReviewCommentEvent':
        score = 2;
        break;
        case 'PushEvent':
        score = 3 * evt["payload"]["commits"].length;
        break;
        case 'WatchEvent':
        score = 1;
        break;
      }
      emit(actor, score);
    }
  }
}
