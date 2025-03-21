### Summary: Include screen shots or a video of your app highlighting its features

I have included a few screenshots in the GitHub repository. BadImageHandlingScreenshot.png shows a default image I use in case the image downloaded has an error or is invalid. DisplayRecipes.png shows a screenshot of the recipes being displayed at startup. EmptyDataScreenhot.png is a screenshot of how an empty JSON data url is handled. MalformedScreenshot.png is a screenshot of how an empty JSON data url is handled.

I did not include any video files because of size limitations of uploading files on GitHub.

### Focus Areas: What specific areas of the project did you prioritize?
 
I first prioritized defining the model data to properly define the recipe data. I then focused on getting the recipe data, specifically, name, cuisine, and image of each recipe using async/await concurrency using MVVM design as the exercise required. Then I focused on being able to display the recipe data on the recipe view.

Why did you choose to focus on these areas?

I focused on defining the data model so that I could then design the view and view model to download the recipe data. Once I was able to download the recipe data and display it, I broke down the RecipesView(main view) into subviews. I first created a subview called RecipeRowView that represented displaying each recipe data(name, cuisine, image) in a single row. I then created a subview specifically for the display of the image as its own view and called it RecipeImageView to further breakdown the functionality of downloading an image, in case another class in the app needed such a feature.

Finally, I added a Utilities folder specifically to handle the asynchronous downloading of an image and a cache manager to cache a downloaded image.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I am not sure how long it took me but I worked completing each feature one at a time. For example, I first defined the data model, then worked on writing the code to download the JSON recipe data followed by the view to display the data. Once I got that to work I added the functionality to cache images. Lastly, I worked on the refresh of the view. If I had to estimate the time spent to complete this exercise, maybe 7 to 8 days working about 5 to 6 hours per day. Figuring out how to test this app took me a couple of days.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

Yes there was a tradeoff in my solution. I decided to use caching to save the downloaded images. The advantage to this design is that temporary memory is used to cache images downloaded. The app’s memory is used while the app is alive. As the user keeps using the app, the images are retrieved from cache rather than from the network, making it faster and saving bandwidth consumption, but making use of more memory. The developer doesn’t have to keep track of where the images are saved. The disadvantage with this approach is once the app is closed, the images saved to cache are deleted. Once the app runs again after being closed, the images are downloaded once again over the network. Now, if the memory of the app keeps increasing, then there is a risk that the app will crash. A good example of using caching is if you’re viewing someone’s posts on instagram. With each scroll certain information could be cached so as to not make requests on the network.

The alternative approach would have been to use a file manager. Saving the images using a file manager would have saved memory usage. If the app is ever closed, once the user runs the app again, the images are retrieved from the folder created by the file manager. The images are saved directly onto the device. The disadvantage of this approach is having to keep track of where the images are saved. It is best to use the file manager for important data, such as data of a user’s own profile of an app.

### Weakest Part of the Project: What do you think is the weakest part of your project?

My weakest part of the project was figuring out why the refresh wasn’t working. Well at least I thought it was not. Although I used .refreshable{} to refresh the list of recipes and was forcing the logic to download the JSON data once again(bypassing caching), I couldn’t figure out why the refresh wasn’t updating the list even though I created, modified, and used a similar JSON file to the one provided for the exercise. I didn’t realize that the recipes needed to have a different id value associated with each image in order for the View to render again when using the refresh pulldown gesture. To test this feature I needed to create a similar JSON file to the one provided, change the id values of some of the recipes and change the order in which they were listed. I also needed to find a place where my JSON file could be hosted. After some research I figured out how to upload and host my own JSON file on Github. So to test this, when the app uploads, I fetch the original url provided in the exercise. When the user does the refresh, I used my own JSON file instead so that the list can be slightly different in the order it is displayed. This testing did require a slight modification to the submitted code.

Testing this feature is the part that definitely took me the longest.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

The only thing I would like to share or mention is that I am grateful for being given the opportunity to do this exercise. I had never used the cache manager before. In my previous place of employment, all images, colors, etc., were included in the assets folder of the application. I also had never created a test JSON data file to be hosted on a website to be able to do some testing. This exercise was a valuable experience and it has made me a better developer as a result. 
