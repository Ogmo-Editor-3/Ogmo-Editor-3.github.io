# Project Customization

Every game has different requirements and preferences in data handling. To support these unique use cases, OGMO Editor provides the ability to override behavior using JavaScript hooks. These hooks are an advanced feature, and are not required for normal usage, but they are great for anyone who wants to customize the output of OGMO Editor.

# Configuration

In the `Project Settings` view, set `External Script Location` to the path to a `.js` file, relative to the project location. The script at this location will be executed when a project is loaded, or when the project is saved.

# Script Setup

When the script is executed, the return value of the last statement ran should be an object with a function for each point to override. An example script is provided below that we recommend using as a starting point.

```js
function hook() {
  const fs = require('fs');

  console.log('Project is loaded!');

  return {
    beforeLoadLevel: (project, data) => {
      for (let layer of data.layers) {
        if (!layer.data) continue;
        layer.data = layer.data.map(tile => tile === 0 ? -1 : tile);
      }

      return data;
    },

    beforeSaveLevel: (project, data) => {
      for (let layer of data.layers) {
        if (!layer.data) continue;
        layer.data = layer.data.map(tile => tile === -1 ? 0 : tile);
      }
      return data;
    },

    beforeSaveProject: (project, data) => {
      data.customProjectProperty = Math.random();
      return data;
    }
  }
}

hook();
```

In this example, Node.js `fs` module is loaded, but not used, for demonstration purposes. When a level is saved, the script modifies the tilemaps so that empty tiles are saved with the value `0`, and not `-1` as is the default. On loading the level, this change is reversed so that OGMO Editor still treats these cells as empty. When the project is saved, a random number is assigned to a property on the project file named `customProjectProperty`.

# Available Hooks

  - `BeforeLoadLevel(project, data)` - Modify level object in `data` after the level has been read from the filesystem and parsed. This is the last step before the level is returned to the editor.

  - `BeforeSaveLevel(project, data)` - Modify level object in `data` before the level object is serialized and written to the filesystem.

  - `BeforeSaveProject(project, data)` - Modify project object in `data` to change the project that is saved to the filesystem.

# Technical Details

Scripts are loaded through Node.js' `vm` module, and are ran in the same context as the editor. This means that scripts have access to load Node.js modules through `require` and all other JavaScript built-ins. Because a script can be potentially ran multiple times during the OGMO Editor lifetime, variables that are declared `const` can not be redeclared. By wrapping the entire script in a function, you can ensure that scripts don't unnecessarily pollute the global namespace, and `const` variables will be properly redeclared.

Running in the same context as the OGMO Editor also means that there is unrestricted access to the DOM and OGMO Editor objects. Take care with modifying editor internals, as changes can not be guaranteed to have negative side effects down the line.