# NewsAppDemo
Demo for News App

# The task is to load the articles from the given endpoint in a table view where each cell represents an article.

Screen Info:
Header Title: Todays News
Right navbar button: Title will be ‘French’ if content of the screen is in English, to change in French. And
vice versa.

Each cell should have:
Title: &lt;title&gt;
Author: &lt;author&gt;
Description: &lt;description&gt;
&lt;Image on the left&gt;
**The texts in Green should be Localized on tap of right nav-bar button. For eg. ‘Title’ text, not the value.

# Implementation should have:

1. Article cell should have 120*80 image view, title, author, description
2. Pagination should be implemented(load the articles in chunks of 5)
3. The cells should be of dynamic height according to title and description.
4. Localization to french must be there (Check its translation from google and use it here).
5. Should have followed iOS design patterns (MVC not preferred)
6. Should be written in Swift.
7. Using Codable classes for Models is a plus.

# API details:
GET https://newsapi.org/v2/top-
headlines?country=us&amp;category=technology&amp;apiKey=a8fabd9ff4234c82aad08eaaa4ea17a0&amp;pageSize=5
&amp;page=1
Here you get the paginated content using “pageSize” and “page” parameters

# Documentation:

https://newsapi.org/docs/endpoints/top-headlines
