(function() {
  var Timer, requestAnimationFrame,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  requestAnimationFrame = window.requestAnimationFrame || window.mozRequestAnimationFrame || window.webkitRequestAnimationFrame || window.msRequestAnimationFrame;

  module.exports = Timer = (function() {

    function Timer(fps, canvas, debug) {
      this.fps = fps;
      this.canvas = canvas;
      this.debug = debug != null ? debug : false;
      this.fpsCounter = __bind(this.fpsCounter, this);
      this.tick = __bind(this.tick, this);
      this.callbacks = [];
      this.msPrFrame = Math.ceil(1000 / this.fps);
      this.ms = 0;
      this.ticksDuringLastSecond = 0;
      if (debug) this.registerCallback(this.fpsCounter);
    }

    Timer.prototype.tick = function(timestamp) {
      var callback, delta, _i, _len, _ref;
      delta = timestamp - this.lastTickTime;
      if (delta > this.msPrFrame) {
        this.lastTickTime = timestamp;
        _ref = this.callbacks;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          callback = _ref[_i];
          callback(delta);
        }
      }
      if (this.running) return requestAnimationFrame(this.tick, this.canvas);
    };

    Timer.prototype.start = function() {
      if (this.running) return;
      this.running = true;
      this.lastTickTime = Date.now();
      return requestAnimationFrame(this.tick, this.canvas);
    };

    Timer.prototype.stop = function() {
      return this.running = false;
    };

    Timer.prototype.registerCallback = function(callback) {
      return this.callbacks.push(callback);
    };

    Timer.prototype.fpsCounter = function(delta) {
      if (this.ms + delta > 1000) {
        console.log("FPS: " + this.ticksDuringLastSecond);
        return this.ms = this.ticksDuringLastSecond = 0;
      } else {
        this.ms += delta;
        return this.ticksDuringLastSecond += 1;
      }
    };

    return Timer;

  })();

}).call(this);
