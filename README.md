# BarricadeKit

BarricadeKit is a Swift rewrite of [MMBarricade](https://github.com/mutualmobile/mmbarricade). The feature set and APIs are similar right now, but future updates will be to BarricadeKit rather than MMBarricade.

## Why Barricade?

BarricadeKit is a framework for setting up a run-time configurable local server in iOS apps. This works by creating a NSURLProtocol "barricade" that blocks outgoing network traffic and redirects it to a custom, local response, without requiring any changes to existing networking code. 

Most other local server implementations only support a single response per request, but Barricade supports multiple responses per request. This allows presentation of an interface at runtime for selecting which response will be returned. Being able to test multiple network paths without requiring a rebuild of the app is a significant time saver.

## Status

The majority of the work to port the existing functionality to Swift 3 has been completed in the master branch, but there's a little more testing that needs to be added before publishing to cocoapods.

## License

MMBarricade is available under the MIT license. See the LICENSE file for more info.
