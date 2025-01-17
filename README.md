# The Fisheye Project


Fisheye is the Open Source Climate Change MetaVerse.  Fisheye organizes data related to climate action and makes that data available as 3D, real-time assets.  We believe popular engagement is the key to fighting climate change.  Fisheye brings everyone into the conversation by creating an immersive Digital Twin of Earth's climate.

Fighting climate change requires popular engagement.  To many, the threat is simply too abstract or too complicated to accept.  Climate impact is not "real" and feels foreign.  By making climate change data and assets readily available, we create active engagement, encourage curiousity and ultimately provide a vehicle to action.

***If you can convince people to [shave](https://theoutline.com/post/7118/red-dead-redemption-2-is-a-game-about-a-cowboy-who-does-chores) in the MetaVerse, you can convince them to act on Climate Change.  We're just one good UI away.***

## Work Products
Fisheye has two primary work products.  First, a SQL-enabled database will ingest and normalize environmental data from a variety of sources including NOAA, the EPA and data rich NGOs.  Second, it will provide Virtual Twins for each data source and make the data immediately addressable with virtual environments such as Unity and Unreal.

The core Fisheye platform will be publicly and freely available on networks such as Steam and Unreal Marketplace, with additional content packs for EPA Violations, Coastal Water Quality, Weather Forecasting, etc. “Game jam” style events will encourage independent game designers to use this data to create compelling, educational and influential content.

Users and contributers are encouraged to build the platform locally or host for others to use.  Please consider contributing 

Please read our [CONTRIBUTING](CONTRIBUTING.md) page and use your imagination a bit.

In the spirit of engagement, we encourage community members to find and integrate various data sets.  The [DATA](DATA.md) page has suggestions and notes for ingesting data.


## Inspiration

Microsoft is putting a lot of energy into [IoT and the MetaVerse](https://www.youtube.com/watch?v=GAkB98ewcjI) for industrial optimization purposes.  We can leverage this same concept to fight climate change. But first we need to get the data into a Climate Change MetaVerse.

[Reinforcement Learning](https://en.wikipedia.org/wiki/Reinforcement_learning) is one of the most powerful AI techniques available today.  RL can create amazing and novel solutions to problems given the correct [training environment](https://www.vox.com/future-perfect/2019/9/20/20872672/ai-learn-play-hide-and-seek).  Again, by making climate data accessible to virtual environments we can use these advanced techniques to study climate change.

So let's get on it!!

### Videos and Tutorials

We're building a complicated product and we'll all need to learn.  Here are some videos that have been useful.

* Unreal and ArcGIS [Getting Started Tutorial](https://developers.arcgis.com/unreal-engine/get-started/)
* Quixel MegaScans [Vegetation Tutorial](https://www.youtube.com/watch?v=yaZvyHaYkMU) is really beautiful.

## Structure

Such as it is. For the moment, we are dividing the data into major categories and those are under the corresponding directories.  We expect this to change as we grow.

* [EPA](epa/README.md) Data on EPA violations and infractions, mostly concerning air pollutants and drinking water.
* [National Weather Services](nws/README.md) The U.S. National Weather Service provides several data sources, including RSS feeds for osshore buoys.

## Basic Use Case

The [U.S. Environmental Protection Agency](https://www.epa.gov/) publishes data on facilities that have violated U.S. policy or laws.  Geo-coordinates are typically provided so the violation can be analyzed in its correct geographical context.  Fisheye provides assets and libraries so a Digital Twin can be dragged and dropped into the 3D engine (Unreal, Unity, ect) of their choice where it will automatically place itself in the correct postion and begin emitting data to the other assets. 

## Work Efforts

1.	Extract data from a few sources.  The first is the ECHO EPA data: https://echo.epa.gov/tools/data-downloads#exporter
1.	Setup a cloud Postgres database on Azure
1.	Push the data probably via Azure serverless functions
1.	Start an API for the most common data requests.  My expectations is we’ll do this in Python / Django 
1.	Design, deploy and manage the project website.
1.	Develop multiple 3D assets for importing into Unreal or Unity
1.	Find a CDN for these assets
1.	Develop C++ libraries within Unreal to wrap the data assets
1.	Develop C# libraries within Unity to wrap the data assets
1.	Develop examples Scenes / Levels for game platforms to illustrate use of the assets
1.	Publish some Jupyter notebooks showing the types of analysis that can be done with the data
1.	Promote the project on various social / developer sites.
1.	Manage the project via tickets and roadmaps
1.	Design small games including the gameplay and narratives around available data assets
1.	Devops, devops, devops


## Local Dev
We are using [Python virtual environments](https://docs.python.org/3/library/venv.html). If you are unfamiliar with `venv` please reach out to the other contributors.  Please use the [requirements.txt](requirements.txt) in the current environment.

Make sure you have a file called `.env` that resembles the file [.env.sample](.env.sample).  Cop the sample file and replace with your values.

### Database
For local dev, please install postgres and set up a database called "fisheye-dev".  We'll create a schema called "epa" until we have a full architecture review.  If you are using [Windows Subsystem for Linux (WSL2)](https://docs.microsoft.com/en-us/windows/wsl/install) you can follow [these instructions for Postgresql](https://harshityadav95.medium.com/postgresql-in-windows-subsystem-for-linux-wsl-6dc751ac1ff3).  You will need to install the database locally until we have establihed a public SQL server.

Remember to login to postgres as `postgres` and create a user for the application.  These credentials should be unique and will only apply to your local database.  Here is an example

```
>  sudo -u postgres createuser buddha
> sudo -u postgres createdb fisheye_dev
```
Login to the db
```
> sudo -u postgres psql
> psql (12.11 (Ubuntu 12.11-0ubuntu0.20.04.1))
Type "help" for help.

> alter user buddha with encrypted password 'epa4you';
> grant all privileges on database fisheye_dev to buddha ;
```

At this point, you're still the `postgres` user, so logout and re-enter the db

```
psql buddha -d fisheye_dev
```

There are no tables.  But let's create the epa schema.

```
> create schema epa
```

All right! Now you should have some structure and you can either a) join the ETL team or b) go back to Python.

You may have to run the script several times to load the database.  It runs out of memory, but if you run it again it will just work on the new tables.

# Working with ESRI GIS
Get your API key from the [ArcGIS Dashboard](https://developers.arcgis.com/dashboard/).

For me (Brian) this is where I have the most to learn.  I'm including notes on how the GIS components work.

In the Unity and Unreal Tutorials for ArcGIS there are two distinct steps for map content.  The first is to add the [Base Layer](https://developers.arcgis.com/documentation/mapping-apis-and-services/maps/basemap-layers/) and the second is to start adding Data Layers.  These appear to be proprietary but free to ESRI.  The _Imagery_ type is for a real world visual of the earth and what we want.  They also provide and interesting [library of basemaps](https://livingatlas.arcgis.com/en/browse/#d=2&categories=Basemaps%3A00100) but I'm not yet sure how to use them.  Basemaps are either vector tiles or images.  It appears the vector tiles are like `.svg` files.  The image files are actual photos.

It appears to me the ESRI basemaps will work fine, but we may seek out alternatives at some point.  I got stuck at the [data layer](https://developers.arcgis.com/esri-leaflet/layers/).  The tutorial only shows the [NY Metro](https://tiles.arcgis.com/tiles/nGt4QxSblgDfeJn9/arcgis/rest/services/UrbanObservatory_NYC_TransitFrequency/MapServer) area and I was unable to find alternatives.  Data layers also come as vectors or images. 

## Initial Scene

### Braid Theory / AltaSea
When working the ESRI tutorials for Unity/Unreal you are directed to using NY City maps.  As practice, you can try pointing your scene to [Braid Theory in San Pedro, CA](https://www.google.com/maps/place/AltaSea+at+the+Port+of+Los+Angeles/@33.722451,-118.2788209,16.13z/data=!4m5!3m4!1s0x80dd37b77f64c337:0x2ad7d7fef3923d58!8m2!3d33.7222724!4d-118.2734459)

Lat: 33.722451
Lon: -118.2788209

Set the map center to those values (note the plugin takes Lon first) and put a camera directly south.
* Camera Lon: -118.278
* Camera Lat: 33.69
* Camera Heading: 0
* Camera Pitch: 58
* Camera Roll:


## Contact

[Brian](https://github.com/buddha314) on Discord **buddha_314#1897**
Join the Discord Server: https://discord.gg/6EeWKCmx7s
