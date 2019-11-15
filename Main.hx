import h2d.Object;
import hxd.Window;
import h2d.Graphics;
import h2d.Tile;
import h2d.TileGroup;
import ogmo.Level;

class Main extends hxd.App {
  var root:Object;

  var levels:Array<Level>;
  var levelIndex:Int = 0;

  var tileWidth:Int = 16;
  var tileHeight:Int = 16;
  var tileImage:Tile;
  var tiles:TileGroup;
  var tileset:Array<Tile>;
  var tileData:Array<TileData>;
  
  var grid:Graphics;
  var gridLineWidth:Int = 1;
  var gridLineColor:Int = 0xffffff;
  var gridLineAlpha:Float = 0.8;

  var transitioning:Bool;
  var transitionTimer:Float;
  var transitionDelay:Float = 0.01;
  var transitionSteps:Int = 1;
  var transitionStepTimer:Float = 0.2;

  override function init() {

    levels = [
      Level.create(hxd.Res.map1.entry.getText()),
      Level.create(hxd.Res.map2.entry.getText()),
      Level.create(hxd.Res.map3.entry.getText())
    ];

    tileImage = hxd.Res.tiles.toTile();
    tileset = [
      for(y in 0 ... Std.int(tileImage.height / tileHeight)) 
      for(x in 0 ... Std.int(tileImage.width / tileWidth)) 
      tileImage.sub(x * tileWidth, y * tileHeight, tileWidth, tileHeight)
    ];
    tileData = [];

    root = new Object(s2d);
    tiles = new TileGroup(tileImage, root);
    grid = new Graphics(root);

    transitioning = false;
    transitionTimer = 0;

    // force a resize for posterity!
    onResize();
  }

  override function onResize() {
    var level = levels[levelIndex];
    var scaleFactorX:Float = engine.width / level.width;
    var scaleFactorY:Float = engine.height / level.height;
    var scaleFactor:Float = Math.max(scaleFactorX, scaleFactorY);
    root.setScale(scaleFactor);
    root.setPosition(engine.width * 0.5 - (level.width * scaleFactor) * 0.5, engine.height * 0.5 - (level.height * scaleFactor) * 0.5);
  }

  override function update(dt:Float) {
    transitionTimer -= dt;

    if (!transitioning && transitionTimer < 0) startTransition();

    if (transitioning) {
      drawTiles(dt);
    }
  }

  function startTransition() {
    transitioning = true;

    levelIndex += 1;
    if (levelIndex >= levels.length) levelIndex = 0;
    var level = levels[levelIndex];

    if (level.layers[0].data2D != null) {
      var data = level.layers[0].data2D;
      for (y in 0...data.length) for (x in 0...data[y].length)
      {
        var i = (y * level.layers[0].gridCellsX)  + x;
        if (tileData[i] != null) {
          tileData[i].lastIndex = tileData[i].index > -1 ? tileData[i].index : null;
          tileData[i].x = x * tileWidth;
          tileData[i].y = y * tileHeight;
          tileData[i].delay = (y + x) * (transitionDelay + Math.random() * 0.01);
          tileData[i].timer = transitionStepTimer;
          tileData[i].step = transitionSteps;
          tileData[i].index = data[y][x];
        }
        else tileData[i] = {
          x: x * tileWidth,
          y: y * tileHeight,
          delay: (y + x) * (transitionDelay + Math.random() * 0.01),
          timer: transitionStepTimer,
          step: transitionSteps,
          index: data[y][x]
        };
      }
      // drawGrid(level);
    }
  }

  function drawTiles(dt:Float) {
    tiles.clear();

    var transitionComplete = true;

    for (tile in tileData) {
      // if delay is greater than 0, display the last tile if there is one
      if (tile.delay > 0) {
        transitionComplete = false;
        tile.delay -= dt;
        if (tile.lastIndex != null) tiles.add(tile.x, tile.y, tileset[tile.lastIndex]);
      }
      // if steps remaining is greater than 0, display a random tile
      else if (tile.step > -1) {
        transitionComplete = false;
        tile.timer -= dt;
        if (tile.timer < 0) {
          tile.step -= 1;
          tile.timer = transitionStepTimer;
          tile.lastIndex = Std.int(Math.random() * tileset.length);
        }
        if (tile.lastIndex != null) tiles.add(tile.x, tile.y, tileset[tile.lastIndex]);
      }
      // otherwise just display the correct tile
      else if (tile.index > -1) tiles.add(tile.x, tile.y, tileset[tile.index]);
    }

    if (transitionComplete) {
      transitionTimer = 5;
      transitioning = false;
    }
  }

  function drawGrid(level:Level) {
    grid.clear();
    grid.lineStyle(gridLineWidth, gridLineColor, gridLineAlpha);

    var layer = level.layers[0];
    for(y in 1...Std.int(level.height / layer.gridCellHeight)) {
      grid.moveTo(0, y * layer.gridCellHeight);
      grid.lineTo(level.width, y * layer.gridCellHeight);
    }
    for(x in 1...Std.int(level.width / layer.gridCellWidth)) {
      grid.moveTo(x * layer.gridCellWidth, 0);
      grid.lineTo(x * layer.gridCellWidth, level.height);
    }
  }

  static function main() {
    #if js
    var canvas : js.html.CanvasElement = cast js.Browser.document.getElementById("webgl");
    new NoInputWindow(canvas, false).setCurrent();
    #end
    
    hxd.Res.initEmbed();
    new Main();
  }
}

typedef TileData = {
  x:Float,
  y:Float,
  delay:Float,
  timer:Float,
  step:Int,
  index:Int,
  ?lastIndex:Int
}

#if js
/**
 * Extending `Window` to remove all input events.
 */
class NoInputWindow extends Window {
  public function new( ?canvas : js.html.CanvasElement, ?globalEvents ) : Void {
    super(canvas, globalEvents);
    element.removeEventListener("mousedown", onMouseDown);
    element.removeEventListener("mouseup", onMouseUp);
    element.removeEventListener("wheel", onMouseWheel);
    element.removeEventListener("touchstart", onTouchStart);
    element.removeEventListener("touchmove", onTouchMove);
    element.removeEventListener("touchend", onTouchEnd);
    element.removeEventListener("keydown", onKeyDown);
    element.removeEventListener("keyup", onKeyUp);
    element.removeEventListener("keypress", onKeyPress);
  }
}
#end
