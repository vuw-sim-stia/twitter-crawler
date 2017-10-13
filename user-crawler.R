library(twitteR)

consumerKey <- "[your consumer key]"
consumerSecret <- "[your consumer secret]"
accessToken <- "[your access token]"
accessTokenSecret <- "[your token secret]"

setup_twitter_oauth(consumerKey, consumerSecret, accessToken, accessTokenSecret)

users <- c("BarackObama") #put seed list of users
all_tags <- c("#science") #put seed list of tags
all_users <- c() #this will be all users referred to by users from the seed list, we crawl their content as well

tweetIds <- c()

for(user in users){
  tweets <- userTimeline(user, n = 3200)
  
  for(tweet in tweets){
    tags <- unlist(regmatches(tweet$text,gregexpr("#(\\d|\\w)+",tweet$text)))
    usrs <- unlist(regmatches(tweet$text,gregexpr("@(\\d|\\w)+",tweet$text)))
    all_tags <- unique(c(all_tags,tags))
    all_users <- unique(c(all_users,usrs))
    if(length(which(tweetIds==tweet$id)==0)){
      tweetIds <- c(tweetIds,tweet$id)
      write(paste(tweet$id,tweet$screenName,tweet$text,tweet$replyToSID,tweet$replyToSN,tweet$replyToUID,tweet$isRetweet,tweet$retweetCount,tags,usrs,sep=";"), "collected-tweets.csv" ,append=TRUE)
    }
  }
}

for(user in all_users){
  tweets <- userTimeline(user, n = 3200)
  
  for(tweet in tweets){
    tags <- unlist(regmatches(tweet$text,gregexpr("#(\\d|\\w)+",tweet$text)))
    usrs <- unlist(regmatches(tweet$text,gregexpr("@(\\d|\\w)+",tweet$text)))
    all_tags <- unique(c(all_tags,tags))
    all_users <- unique(c(all_users,usrs))
    if(length(which(tweetIds==tweet$id)==0)){
      tweetIds <- c(tweetIds,tweet$id)
      write(paste(tweet$id,tweet$screenName,tweet$text,tweet$replyToSID,tweet$replyToSN,tweet$replyToUID,tweet$isRetweet,tweet$retweetCount,tags,usrs,sep=";"), "collected-tweets.csv" ,append=TRUE)
    }
  }
}

for(tag in all_tags){
  tweets <- searchTwitter(tag, n=3200, resultType = "recent")
  
  for(tweet in tweets){
    tags <- unlist(regmatches(tweet$text,gregexpr("#(\\d|\\w)+",tweet$text)))
    usrs <- unlist(regmatches(tweet$text,gregexpr("@(\\d|\\w)+",tweet$text)))
    all_tags <- unique(c(all_tags,tags))
    all_users <- unique(c(all_users,usrs))
    if(length(which(tweetIds==tweet$id)==0)){
      tweetIds <- c(tweetIds,tweet$id)
      write(paste(tweet$id,tweet$screenName,tweet$text,tweet$replyToSID,tweet$replyToSN,tweet$replyToUID,tweet$isRetweet,tweet$retweetCount,tags,usrs,sep=";"), "collected-tweets.csv" ,append=TRUE)
    }
  }
}