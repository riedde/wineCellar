# wineCellar
Simple App to manage your stock

## requirements
For this app you need [eXist-db](http://exist-db.org/exist/apps/homepage/index.html).

## before build (pictures)
* I you like to have some pictures or icons as thumbnails, you should create a folder (**wineCellar/resources/pics**) and put them there
* Pictures with the following names will be used by default (if exists)
  * cool.png (freezer-icon)
  * empty.jpg (empty bottle)
  * red.jpg (red wine)
  * rose.jpg (white wine)
  * sparkling.jpg (sparkling wine)
  * white.jpg (white bottle)

## build
* You have to check the serverpaths in the source code and change them to your specifications.
* After that go to the directory of this app ant build the .xar file by tipping **ant** to your terminal shell.
* Now you can upload your new build package to the database by using for example the Package-Manager on eXist-db dashboard.

## content

* create a folder **contents** in **/db/**
* create a folder **wineCellar** in **/db/contents/**
* put there your xml-data by using the following template (one document for each sort of wine)

## content template

```
<bottle stock="4" volume="0.75" id="bottle0001">
    <color>white</color>
    <grapeVariety>Riesling</grapeVariety>
    <sweet>dry</sweet>
    <vintage>2019</vintage>
    <vineyard>Name of wineyard</vineyard>
    <cooler>true</cooler>
</bottle>
```
