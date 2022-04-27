# Image Finder
Application for displaying images by using **unsplash api**. Able to search any images and display in the application

## Search
User able to search any images using search bar. Implemented **search bar**, when user enter search word after pressing search key images will display in the UIcollection view. For displaying the data UICollectionView is used.

## Option
User able to change the displaying column by selecting options like two, three and four. For option added **menu bar item in navigation bar**. It doesn't call api everytime . It changed in UI Level

## paging
For paging, Implemented **infinite scrolling**. Added login when user at the end of scroll it detects and fetch next page images and append to the existing images

## offline
For offline, when the network is not available use able to fetch the previous fetched data. every data is stored in **NSCache** for avoidign rapid api call. for serch history added using **User Defaults**





