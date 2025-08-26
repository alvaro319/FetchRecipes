### Summary: Fetch Recipes App

On launch, this app downloads recipe data from an API and displays the recipe image, country it is from (cuisine), and the recipe title (name). 

### Focus Areas: What specific areas of the project did you prioritize?

My first task was to define the Recipe data model. I used a website https://app.quicktype.io/ that facilitates defining a Swift structure from JSON data of the API url that I used.

I initially designed a Recipe View along with a Recipe View Model to be able to fetch data from the API to print out to the console. I defined and created the network data service manager with the API Url and injected it into the Recipe View and Recipe View Model that needed a reference to the data service (dependency injection).

In the Recipe View's .task{}, I leveraged the async/await concurrency methodology to make an async call to the viewModel's fetch(). The viewModel's fetch() references the network data service manager object's url to get the data. Once the response was verified to be valid, the JSON data is decoded to the Recipe Model array and displayed in a list. 

The next step was to download the image of each recipe. Once the data was decoded into a RecipeModel, we could then use the data model's photoUrl and the uuid to download and cache the image, respectively. The viewModel for the RecipeImageView creates a singleton reference to the PhotoCacheManager and a reference to the DownloadImageAsyncLoader. The RecipeImage View runs a .task{} that determines whether the user did a refresh or not. If the user did a refresh, a call to DownloadImageAsyncLoader() is made to download the images once again from the url. However, if it is not a refresh, the viewModel then checks if there is an image saved in the cache. If there is an image in the cache, the image is fetched from the cache, othewise the image is fetched from the url. 

Additionally, for the functions that were called within a .task{} using async/await, I used 'await MainActor.run{}' to ensure any properties bound to a view were being updated on the main thread rather than a background thread.

Lastly, I cleaned up the code by creating subviews to make the code more concise and readable. 

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Yes there was a tradeoff in my solution. I decided to use caching to save the downloaded images. The advantage to this design is that temporary memory is used to cache images downloaded. The app’s memory is used while the app is alive. As the user keeps using the app, the images are retrieved from cache rather than from the network, consuming less bandwidth. The advantage to caching is that the developer doesn’t have to keep track of where the images are saved. The disadvantage with this approach is once the app is closed, the images saved to cache are deleted. Once the app runs again after being closed, the images are downloaded once again over the network. A good example of using caching is if you’re viewing someone’s posts on instagram. With each scroll certain information could be cached so as to not make requests on the network.

The alternative approach would have been to use a file manager. If the app is ever closed, once the user runs the app again, the images are retrieved from the folder created by the file manager. The images are saved directly onto the device. The disadvantage of this approach is having to keep track of where the images are saved. It is best to use the file manager for important data, such as data of a user’s own profile of an app.

### How did I test the app?

I tested the app with a Url that had malformed data and an empty data set. I did error handling with alerts to inform the user that something wasn't right. I also created a test JSON data file on github identical to the JSON data file that was valid so that I could test the refresh feature. I would run the app and display the recipes using the url with valid data. I modified the test JSON data file for some of the recipes with new UUID values and placed them in a different order so that when I did a refresh, the recipes would be listed in a different order. This is how I verified the refresh was working. 

### Additional Information

I will be adding more features over time. Some features that may be added are an icon/launch screen along with adding an additional target to this project to include XCTesting. I was also thinking of creating a Details View when the user selects a recipe from a row.
