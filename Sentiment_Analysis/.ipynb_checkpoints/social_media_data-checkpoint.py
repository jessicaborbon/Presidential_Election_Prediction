# Dependencies and Credentials
import requests
import tweepy
import pandas as pd
from config import api_key, bearer_key

# Define URL
BEARER_TOKEN = "AAAAAAAAAAAAAAAAAAAAALe%2BvgEAAAAAcLsxdbFdxXNYG7lC9Fs6fPBwvSM%3DLK5VO6DZjTnshVMxsgva9djxz6DOu6C9mi97oGIV1Pl9dY7KGT"

# Authenticate to Twitter
client = tweepy.Client(bearer_token=BEARER_TOKEN)

def fetch_tweets(query, start_time, end_time, max_results=100):
    tweets = []
    for tweet in tweepy.Paginator(client.search_recent_tweets,
                                  query=query,
                                  start_time=start_time,
                                  end_time=end_time,
                                  tweet_fields=['created_at', 'geo', 'place'],
                                  max_results=max_results).flatten(limit=1000):
        # Extract location information
        location = None
        if tweet.geo:
            location = tweet.geo['place_id']  # For geotagged tweets
        elif tweet.place:
            location = tweet.place['full_name']  # For tweets with place information

        # Handle cases where location data might be missing
        location_info = tweet.place['full_name'] if tweet.place else None

        tweets.append([tweet.id, tweet.text, tweet.created_at, location_info])
    return tweets

# Example usage for the year 2016
tweets_2016 = fetch_tweets("US presidential election", "2016-01-01T00:00:00Z", "2016-12-31T23:59:59Z")
df_2016 = pd.DataFrame(tweets_2016, columns=['id', 'text', 'created_at', 'location'])
df_2016.to_csv('tweets_2016_with_location.csv', index=False)