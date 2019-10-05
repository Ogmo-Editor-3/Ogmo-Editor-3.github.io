# Entity Layers

## Tools

### Entity Select Tool - <img src="https://raw.githubusercontent.com/AustinEast/ogmo-site/gh-pages/img/icons/selection.png" class="down-eight" width="32"/>

**Left Mouse Down**

- If cursor is above entity, deselect selected entities, select entity.
  + Shift: Add entity to selected entities.

**Left Mouse Down + Drag** 

- If cursor is not above an entity, create selection rectangle.
  + Left Mouse Up: Select entities in selection rectangle.
  + Shift + Left Mouse Up: Toggle entities' selection status in selection rectangle.

- If cursor is above an entity, move selected entities, snapped to grid.
  + Ctrl: move selected entities, not snapped to grid.

**Right Mouse Down + Drag**

- Create selection rectangle for deletion.
  + Right Mouse Up: Delete entities in selection rectangle.

**Hotkeys**

- Alt: Switch to Entity Resize Tool.

### Entity Create Tool - <img src="https://raw.githubusercontent.com/AustinEast/ogmo-site/gh-pages/img/icons/entity-create.png" class="down-eight" width="32"/>

**Left Mouse Down**

- Create entity from brush template snapped to grid. Automatically selects entity.
  + Ctrl: Create entity not snapped to grid.
  + Shift: Adds entity to existing selection.
  + Drag: Move created entity

**Left Mouse Up**

- If entity is created, tool is automatically set to Entity Select Tool

**Right Mouse Down**

- Delete entity at mouse position
  + Drag: Delete entities

**Drag**

- Preview entity at mouse position

### Entity Resize Tool - <img src="https://raw.githubusercontent.com/AustinEast/ogmo-site/gh-pages/img/icons/entity-scale.png" class="down-eight" width="32"/>

**Left Mouse Down + Drag**

- Resize selected entities (if entities are resizable).

### Entity Rotation Tool - <img src="https://raw.githubusercontent.com/AustinEast/ogmo-site/gh-pages/img/icons/entity-rotate.png" class="down-eight" width="32"/>

**Left Mouse Down + Drag**

- Rotate selected entities (if entities are rotatable).

### Entity Node Tool - <img src="https://raw.githubusercontent.com/AustinEast/ogmo-site/gh-pages/img/icons/entity-nodes.png" class="down-eight" width="32"/>

**Left Mouse Down**

- Create and select a node for each selected entity snapped to grid.
  + Ctrl: Create node(s) not snapped to grid
  + Drag: Move selected node(s)
  - On existing node(s): Select node(s)

**Right Mouse Down**

- Delete node(s) under cursor