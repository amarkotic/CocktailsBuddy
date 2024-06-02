# Cocktails app

For your onboarding task, you will need to implement a simple app. It only has 4 screens and a few simple features. The theme of the app is cocktails! Who doesn’t like cocktails? 

You can check the design of the app in the folder Screens.

To get data we use an open free API, you can check it out on the link below: 
https://www.thecocktaildb.com/api.php 

App has 3 features: Search, Filter, and Cocktail details. And now a bit more about each feature of the app. 

## Search 
This is the first feature and screen in the app. On this screen, the user can search for cocktails by typing his query in the search field. API call used for this screen is www.thecocktaildb.com/api/json/v1/1/search.php?s=query. When the user enters the screen for the first time, the query will be empty and results for the empty query will be shown (the API returns a list of cocktails for an empty query). 

The user has the option to open the filters screen from this screen by pressing the filters button. More about that a bit later. 

When user selects search field to start typing, filter button disappears. This is due to API limits, which doesn’t support filtering and searching. Filter button reappears when user clicks on button to clear input in search field. 

The user can see a list of Cocktails that are the results of his query. Each list item has a cocktail picture, name and ingredients listed under name (they should be truncated if too long). Pressing on one list item opens the details screen of that cocktail. 

And at the bottom of the screen, there is a “feeling lucky” button. Pressing that button opens the details screen of a random cocktail. Random cocktail can be fetched from this endpoint: www.thecocktaildb.com/api/json/v1/1/random.php. 

## Cocktail details 
This is a screen which displays details of the cocktail. Full details of a cocktail can be fetched from this endpoint: www.thecocktaildb.com/api/json/v1/1/lookup.php?i=id. 

On this screen user will first see the picture of the cocktail which should take full width, after that there will be the title of the cocktail. Then, the user can see the category, glass type and alcoholic type for that cocktail followed by a list of ingredients and instructions on how to prepare it. 
At the very end user can also see when was cocktail last modified and it is displayed to him following this logic: 
* If the cocktail was last modified today, the user will see “Today” label 
* If it was in the same week, the user will see “This week” label 
* If it was in the same month, the user will see “This month” label 
* If it was in the same year, the user will see “This year” label 
* For other cases the user will see “X years ago” where X is replaced by the correct number of years passed 

## Filter 
This feature has two screens. On the first screen user can see 3 different types of filters. Types of filters are alcoholic type, category, and glass type. 
All values for those filters can be fetched from these endpoints: 
For alcoholic type - www.thecocktaildb.com/api/json/v1/1/list.php?a=list  
For category - www.thecocktaildb.com/api/json/v1/1/list.php?c=list  
For glass type - www.thecocktaildb.com/api/json/v1/1/list.php?g=list  

User can select only one filter from each filter type, but needs to select at least one for filtering to be possible. That means that button for filtering, on the bottom of the screen, should be enabled only when the user selects at least one filter from any filter type. 
Endpoint used for getting results from filtering is https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=alcoholic_type&c=category&g=glass_type. 
If the user didn’t select some filter type, then the parameter for that filter type shouldn’t be sent at all. 
User can also click on reset button which resets his selection of filters (aka deselects everything). This button should be enabled only if user selected something. 

Pressing the filter button opens the second screen of this feature. This is just a simple screen that shows the results we get from API. It displays number of results we get from API and a list of cocktails, the same as on the search screen, just without the search field, filter and “feeling lucky” button. The list item is also the same – it contains an image, cocktail name and ingredients. Pressing on the list item opens the cocktail details screen. Going back from the details screen returns the user to the filtering results screen, but going back from the filtering results screen returns the user to the search screen. This means that the screen with filter types is skipped when going back from filtering results. 


# Technologies 

Technologies to build this app must be: 

* Swift as the language for developing this app 
* SwiftUI as a toolkit for building UI 
* MVVM as a software design pattern, alongside best practices for clean and maintainable code 

 
# Must: 
* Write unit tests.


# Bonus: 
* Write UI tests.
 
