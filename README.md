# CatApp

Cat app is an app that displays cats. Users can view cats by category like friendly or adventurous, view the latest highlighted cats and click to view more information about the cats. Features include being able to filter by category, caching of remote images and being able to login and like cats when logged in.

## Key design decisions:
- Network manager protocol. ```NetworkService``` and ```MockNetworkService``` conform to the protocol for easy swapping (strategy pattern).
- ```NetworkService``` owns an ```EndpointService``` and ```RequestService```. ```EndpointService``` produces the url
- ```RequestService``` creates the URL Request and sets the method, body and headers
- ```KeychainAccess``` is a singleton wrapper class that encapsulates keychain functionality in a simplified manner.
- Created a separate remoteImage UI component to encapsulate the image and loading image state
- ```ProfileService``` that holds login state and handles login functionality. Home VM owns profile service and subscribes to login status. Profile service is passed to the login screen.
- Used ```UserDefaults``` to save user preference for one or two column view. Saved a local copy of preference to avoid frequent access to UserDefaults - app only asks on start, and updates in memory + ```UserDefaults``` on write, only looks at local memory on read.
- Used private computed variables in ```HomeScreenView``` to separate components for readability. Each component that requires a network request to load data has a switch statement on its loading state to show either loading views or data on load.

## Reflections:
- ```EndpointService``` should handle URL, decoding strategy, and headers to fully encapsulate endpoint information instead of separating things.
- Instead of ```KeychainAccess``` singleton, using the strategy pattern with dependency injection will allow us to easily add new methods for saving secure data and inject it without needing to reopen / change all locations where the keychain access is used.  
