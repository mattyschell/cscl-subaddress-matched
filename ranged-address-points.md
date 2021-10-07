# Ranged Address Points

One of the beautifully confusing aspects of addressing systems in New York City 
is ranged address points.  We see ranged address points primarily in the great 
borough of Queens.

When puzzling over edge cases in data processing it can be helpful to refer to 
some real world examples.

## Queens Type

The address of this building is both 147-45 Barclay Ave and also 147-47 Barclay 
Ave. 

![building png](https://github.com/mattyschell/cscl-subaddress-matched/blob/main/doc/buildingview1.png?raw=true)

The way that this probably works in the physical world is that you walk in this 
door and make a left for 147-45 and a right for 147-47.

![building2 png](https://github.com/mattyschell/cscl-subaddress-matched/blob/main/doc/buildingview2.png?raw=true)

There likely are two separate elevators, and each elevator leads identical 
apartment numbers on each lobe of the building. 


| House Number | Apartment | 
| ---- | ---- |
| 147-45 | Apt 1A |
| 147-47 | Apt 1A | 
| 147-45 | Apt 1B |
| 147-47 | Apt 1B | 

In the New York City GIS systems this data is modeled as a single building
with two address points sitting on the building footprint.  Each address point
will in turn have an associated set of subaddresses.

![gisview1 png](https://github.com/mattyschell/cscl-subaddress-matched/blob/main/doc/gisview1.png?raw=true)


