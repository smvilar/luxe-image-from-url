
import luxe.Input;
import haxe.Http;
import snow.api.buffers.Uint8Array;
import luxe.Sprite;
import luxe.Vector;
import snow.system.assets.Asset;

class Main extends luxe.Game {
  override function ready() {
    var request = new js.html.XMLHttpRequest();
    request.open("GET", "http://localhost:40404/assets/logo_box.png", true);
    request.overrideMimeType('text/plain; charset=x-user-defined');
    request.responseType = js.html.XMLHttpRequestResponseType.ARRAYBUFFER;

    request.onload = function(data) {
      trace("got image");

      if (request.status == 200) {
        Luxe.snow.assets.image_from_bytes("urlimage", new Uint8Array(request.response))
          .then(function(asset) {
            init(asset);
          })
          .error(function(err) {
            trace(err);
          });
      } else {
        trace(request.statusText);
      }
    }

    request.send();
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
