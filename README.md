# Apollo iOS Spotify Showcase

## This is currently a WIP and actively under development for an initial version

## Getting Started

### 1. Clone this repository.

### 2. Create an app with the Spotify API

Visit the [Spotify Developer Portal](https://developer.spotify.com/) and log in with your Spotify account. You will need to create an account if you do not already have one.

Once logged in, click the account dropdown in the top-right and go to your '[Dashboard](https://developer.spotify.com/dashboard)' then select '[Create App](https://developer.spotify.com/dashboard/create)'.

Fill out the necessary information and then save your app.  Here are some guidelines:

|Field|Value|
|---|---|
|App name|(anything)|
|App description|(anything)|
|Redirect URIs|`apollo-ios-spotify-showcase://spotify-login-callback`|
|Which API/SDKs are you planning to use?|`Web API` (not iOS!)|

Now select your app from your '[Dashboard](https://developer.spotify.com/dashboard)' and then go to the 'Settings'. Here you will find your 'Client ID' which you will need for the next step.

### 3. Configure the Xcode project with your Client ID

Now to configure the code to use your Client ID, from terminal run the `generate-config-plist.sh` bash script and when prompted enter your Client ID from the previous step.

This will generate a `ClientConfig.plist` file including your Client ID that is already referenced and used by the project.

At this point your are ready to being using the Apollo iOS Spotify app.
