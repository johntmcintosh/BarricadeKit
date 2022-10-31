# Changelog

## Release 3.0.0

* BREAKING - Adjusted `ErrorResponse` protocol so that error is provided through a closure rather than a property. This is to allow for customization of the error's payload, such as including the request's URL in the error's description.
* Added SimulatedSystemError and SimulatedSystemErrorResponse for easy replication of common error types that are returned from NSURLSession
