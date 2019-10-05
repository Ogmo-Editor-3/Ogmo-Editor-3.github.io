# ogmo-site

## Getting Started

### Building the Tilemap Preview

Building the Tilemap Preview featured in the Hero element requires [Haxe](https://haxe.org/).
Once that is installed, get the following dependencies with `haxelib`:

```
haxelib install heaps
haxelib install ogmo-3
```

Then simply run this command to build the app:

```
haxe build.hxml
```

### Editing the Manual

The Ogmo Editor 3 Manual builds it content through the markdown files (.md) in the `docs` directory.

### Serving the Website for Development

The Manual can only be accessed through a webserver. If you dont have a preferred way to serve files, this repo comes with a simple Node server to use. With [Node](https://nodejs.org/) installed, open a terminal in the project and run:

```
npm i
npm start
```

This will serve the site at http://localhost:8000.
