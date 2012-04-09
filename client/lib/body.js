(function() {
  var Body;

  module.exports = Body = (function() {

    Body.G = 6.6742e-11;

    function Body(name, radius, mass, position, velocity) {
      this.name = name;
      this.radius = radius;
      this.mass = mass;
      this.position = position;
      this.velocity = velocity;
    }

    Body.prototype.exertPullOn = function(otherBody, dt) {
      var radius;
      if (otherBody === this) return;
      radius = otherBody.position.sub(this.position);
      return otherBody.updateVelocity(radius, this.mass, dt);
    };

    Body.prototype.updateVelocity = function(r, mass, dt) {
      var acceleration, hypot, sumOfSquares;
      sumOfSquares = r.sumOfSquares();
      hypot = Math.sqrt(sumOfSquares);
      acceleration = -Body.G * mass / sumOfSquares;
      return this.velocity = this.velocity.add(r.div(hypot).mult(acceleration * dt));
    };

    Body.prototype.calculateGravitationalPull = function(otherBody, dt) {
      var acceleration, hyp, radius, radiusSquared;
      if (otherBody !== this) {
        radius = this.position.sub(otherBody.position);
        radiusSquared = radius.sumOfSquares();
        hyp = Math.sqrt(radiusSquared);
        acceleration = -Body.G * otherBody.mass / radiusSquared;
        return this.velocity = this.velocity.add(radius.div(hyp).mult(acceleration * dt));
      }
    };

    Body.prototype.move = function(dt) {
      this.oldPosition = this.position;
      return this.position = this.position.add(this.velocity.mult(dt));
    };

    Body.prototype.distanceToCenter = function() {
      return Math.sqrt(this.position.sumOfSquares());
    };

    return Body;

  })();

}).call(this);
