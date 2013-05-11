GvS
===

Github eVent Synchronize

### Current Status
#### Working version
- [Can be found here.](http://61.167.60.58:5984/secreek-event-dump/_design/secreek-event-dump/_view/status)

### API for user contribution to our organization

#### INPUT
- `secreek` as organization name
- list of member to track

#### OUTPUT
- List of key-value pair in JSON: "username": "score" 
- Filters: since "last 24hrs", "last week", "day one"

#### Github API
http://developer.github.com/v3/activity/events/
http://developer.github.com/v3/activity/events/types/

#### How to calculate the scores

- `+2` per CommitCommentEvent
- `+10` per CreateEvent
- `+5` per DeleteEvent
- `+3` per DownloadEvent
- `+1` per FollowEvent
- `+3` per ForkEvent
- `+5` per ForkApplyEvent
- `+5` per GistEvent
- `+3` per GollumEvent
- `+1` per IssueCommentEvent
- `+3` per IssuesEvent
- `+10` per MemberEvent
- `+10` per PublicEvent
- `+5` per PullRequestEvent
- `+2` per PullRequestReviewCommentEvent
- `+3` per Commit per PushEvent
- `+0` per TeamAddEvent
- `+1` perWatchEvent
