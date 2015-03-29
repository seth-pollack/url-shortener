
[Url-Shortener](http://spollack-url-shortener.herokuapp.com/) by Seth Pollack

###Setup & Installation:

Clone the project with `git clone https://github.com/seth-pollack/url-shortener`

run `bundle install`

run `rake db:setup` to migrate and seed the db.

launch the app  `rails s`

run the tests with `rspec`

###Design Considerations:

####Duplicate Urls:
I chose to keep urls unique. Meaning that if two users enter the same url, they will both get back the same short url. Doing so keeps the urls shorter. However, creating multiple short urls would be a benefit for tracking different campaigns for the same url. 

####Performance Enhancements
1. When creating a new short url I first do a "find or create". I indexed the link column for faster lookups.
2. I also added a counter_cache for visit counts.

#####Improvements
Other performance enhancements that I could have done are:

1. Cache url redirects, redirect right away, and asynchronously add the visit info to the db. 
2. Additionally, I would probably also store the geocoded information instead of just the ip to speed up querying the data later.

####Url Shortening:
My first thought was to encode the url itself. The benefit being that it would be reversible even with the website data being lost. However, that would be too slow and the urls would be really long.

My second option was to just use the primary keys, this would be much faster and have much shorter urls. However, as it grows the urls would quickly become long as well.

The third option that I went with was to encode the primary key itself. This would be the fastest with the shortest possible urls. I chose to build my own encoder using base 62 rather than using the standard base 36 `number.to_s(36)`. The downside (or upside) is that short urls are now case sensitive.

#####Improvements:
Im not sure if url predictability is an issue. But I had two ideas for decreasing the predictability. 

1. One would be to add some additional "url-safe" characters to the mix, which would make the urls less predictable and shorter.
2. The second would be to rearrange the order of the base letters.

####Other Improvements:

I am storing the visit info in a separate table with the thought that each url can have its own stats page showing visitor metrics and top referring sites.