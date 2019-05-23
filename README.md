# ogmo-site

## Getting Started

### Building the Tilemap Preview

Building the Tilemap Preview featured in the Hero element requires [Haxe](https://haxe.org/).
Once that is installed, get the following dependencies with `haxelib`:

```
haxelib install heaps
haxelib install ogmo
```

Then simply run this command to build the app:

```
haxe build.hxml
```

### Serving the Website for Development

The Docs portion of the Website needs to be accessed through a webserver. If you dont have a preferred way to serve files, this repo comes with a simple Node server to use. With Node installed, open a terminal in the project and run:

```
npm i
npm start
```

This will serve the site at http://localhost:8000.
