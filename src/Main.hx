
import luxe.Input;
import haxe.Http;
import snow.api.buffers.Uint8Array;
import luxe.Sprite;
import luxe.Vector;
import snow.system.assets.Asset;

class Main extends luxe.Game {
  override function ready() {
    var request = new Http("http://localhost:40404/assets/logo_box.png");

    request.onData = function(data:String) {
      trace("got image");

      var _image = Uint8Array.fromBytes(haxe.io.Bytes.ofString(data));

      Luxe.snow.assets.image_from_bytes("urlimage", _image)
        .then(function(asset) {
          init(asset);
        })
        .error(function(err) {
          trace(err);
        });
    }

    request.onError = function(msg :String) {
      trace("error loading image:" + msg);
    }

    request.request();
  } //ready

  function init(asset:AssetImage) {
    trace("initing!");
    var tex = new phoenix.Texture({
      id: "urlimage",
      width: asset.image.width_actual,
      height: asset.image.height_actual,
      pixels: asset.image.pixels
    });

    var detail_top = new Sprite({
      texture: tex,
      pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y),
      depth: 1
    });
  }

  override function onkeyup( e:KeyEvent ) {
    if(e.keycode == Key.escape) {
      Luxe.shutdown();
    }
  } //onkeyup

  override function update(dt:Float) {

  } //update
} //Main
