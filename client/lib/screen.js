(function() {
  var Screen, Vector;

  Vector = require('./vector');

  module.exports = Screen = (function() {

    function Screen(canvas, bodies, center, maxDistance) {
      var body, _i, _len;
      this.center = center;
      this.maxDistance = maxDistance;
      this.height = canvas.height = canvas.clientHeight;
      this.width = canvas.width = canvas.clientWidth;
      this.canvasCenter = new Vector(Math.floor(this.width / 2), Math.floor(this.height / 2));
      this.ctx = canvas.getContext('2d');
      this.prerenderedBodies = {};
      for (_i = 0, _len = bodies.length; _i < _len; _i++) {
        body = bodies[_i];
        this.prerenderBody(body);
      }
    }

    Screen.prototype.draw = function(bodies) {
      var body, _i, _len;
      this.ctx.clearRect(0, 0, this.width, this.height);
      this.ctx.save();
      this.ctx.translate(this.canvasCenter.x, this.canvasCenter.y);
      for (_i = 0, _len = bodies.length; _i < _len; _i++) {
        body = bodies[_i];
        this.renderBody(body);
      }
      return this.ctx.restore();
    };

    Screen.prototype.renderBody = function(body) {
      var bodyRadius, translatedPosition;
      bodyRadius = this.radiusInPixels(body.radius);
      translatedPosition = this.positionInPixels(body.position.sub(this.center.position));
      translatedPosition = new Vector(Math.floor(translatedPosition.x), Math.floor(translatedPosition.y));
      return this.ctx.drawImage(this.prerenderedBodies[body.name], Math.floor(translatedPosition.x) - bodyRadius, Math.floor(translatedPosition.y) - bodyRadius);
    };

    Screen.prototype.prerenderBody = function(body) {
      var bodyCanvas, bodyCtx, bodyRadius;
      bodyRadius = this.radiusInPixels(body.radius);
      bodyCanvas = document.createElement('canvas');
      bodyCanvas.width = bodyCanvas.height = bodyRadius * 2;
      bodyCtx = bodyCanvas.getContext('2d');
      bodyCtx.fillStyle = "rgb(255, 255, 255)";
      bodyCtx.beginPath();
      bodyCtx.arc(bodyRadius, bodyRadius, bodyRadius, 0, 2 * Math.PI);
      bodyCtx.fill();
      return this.prerenderedBodies[body.name] = bodyCanvas;
    };

    Screen.prototype.scale = function() {
      return Math.ceil(this.maxDistance / (this.height / 2 - 10));
    };

    Screen.prototype.positionInPixels = function(position) {
      if (position) return position.div(this.scale());
    };

    Screen.prototype.radiusInPixels = function(radius) {
      return Math.ceil(Math.log(radius)) - 13;
    };

    return Screen;

  })();

}).call(this);
