## MapGeneration Service


## Generation values

### Map Dimensions Properties
```
MapSize
```
Maps can only be square looking, it Determines the area of the map 



### Map Generation Properties
```
Seed
```
Determines the output of the noise result

```
Amplitude
```
Determines how high (or low) the terrain is, **mathematically speaking it determines the maximum height of the sine wave**. Higher values will output hilly terrain, lower values will yield shallow terrain.

```
Frequency
```
Determines the how frequent terrain features are, **mathematically speaking it determines how frequent waves(?) are**, the higer the value is, bigger less frequent formations will appear, the lower it is more frequent land mass occurrences will be yieled.


```
Octaves
```
Determines how detailed terrain is. **Mathematically speaking, each octave adds a layer of detail to the noise surface**. More octaves will yield more detailed terrain (note: diminishing returns at high costs after 10 octaves), less octaves will yield blob-like, detailess terrain

```
Persistence
```
Determines the "Zoom Level" of the map, or how persistent features are

