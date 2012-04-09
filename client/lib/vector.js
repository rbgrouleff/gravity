(function() {
  var Vector;

  module.exports = Vector = (function() {

    function Vector(x, y) {
      this.x = x;
      this.y = y;
    }

    Vector.prototype.mult = function(v) {
      if (this.constructor === v.constructor) {
        return new Vector(this.x * v.x, this.y * v.y);
      } else {
        return new Vector(this.x * v, this.y * v);
      }
    };

    Vector.prototype.div = function(v) {
      if (this.constructor === v.constructor) {
        return new Vector(this.x / v.x, this.y / v.y);
      } else {
        return new Vector(this.x / v, this.y / v);
      }
    };

    Vector.prototype.add = function(v) {
      return new Vector(this.x + v.x, this.y + v.y);
    };

    Vector.prototype.sub = function(v) {
      return new Vector(this.x - v.x, this.y - v.y);
    };

    Vector.prototype.sumOfSquares = function() {
      return this.x * this.x + this.y * this.y;
    };

    Vector.prototype.eq = function(v) {
      if (v) {
        return this.x === v.x && this.y === v.y;
      } else {
        return false;
      }
    };

    Vector.prototype.toString = function() {
      return "(" + this.x + ", " + this.y + ")";
    };

    return Vector;

  })();

}).call(this);
