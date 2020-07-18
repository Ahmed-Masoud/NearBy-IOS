# NearBy Application

## Requirements
Ios 11+

## Installation

To try the this app simply clone the repo and install the pods by running the following command in your terminal from the root directory of project

```ruby
pod install
```
## Description
This app is base on Foresquare API to retrieve venues around the user's current location.
The app is implemented using a protocol oriented MVVM.
The app works fine for iphone/ipad.
The app fetches venues with an infinite scroll technique so the user is always data when he needs it
The app has 2 operational modes :
- Single update mode wich loads the venues once the app is launched only
- Real time mode were the user gets an updated venues list as he moves around

## Notes
The app is based on a free tier four square account and it'l likely to have a quotation expiration console log for retrieving images but the app will continue to operate using placeholder images as the error view was disabled for this specific error 

## License
NearBy is available under the MIT license. See the LICENSE file for more info.

