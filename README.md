## Yahoo Finance Stock And Market Listing App
Sample iOS application presenting usage of MVVM pattern using Yahoo Finance API.

## Description
Project provides searching stocks and markets and listing them.  These are also can storable on local database.

Project consuming https://apidojo-yahoo-finance-v1.p.rapidapi.com for data source.

## Technical Features
- Using UIKit as interface building using Interface Builder as well as programmatic approach.
- Using RxSwift as reactive programming.
- Project splitted to layers as network, business and UI.
- A Separate framework created for networking called RestClient and it's supported by unit tests.

## Environment
- Xcode 13.0
- Swift 5.0

## Compilation
Project uses [CocoaPods](https://cocoapods.org) for dependencies, so install it first and then run:

    pod install


## Usage
Set your API Key in AppDelegate like in the code below. If you don't have it, you can get it on https://rapidapi.com/apidojo/api/yh-finance/.

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Properties.configure(apiKey: "")
        return true
    }
