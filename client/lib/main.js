(function() {
  var Runner, Screen, Timer, Vector, solarSystem,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Timer = require('./timer');

  Screen = require('./screen');

  Vector = require('./vector');

  solarSystem = require('./solar_system');

  module.exports = Runner = (function() {

    function Runner() {
      this.tick = __bind(this.tick, this);
      this.startStop = __bind(this.startStop, this);
      var canvas;
      canvas = document.getElementById('universe');
      this.timer = new Timer(60, canvas);
      this.startStopButton = document.getElementById('start_stop');
      this.planets = solarSystem.activatePlanets(['Sun', 'Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter']);
      this.screen = new Screen(canvas, this.planets, solarSystem.sun, solarSystem.farthestPlanet().distanceToCenter());
      this.dt = 24 * 60 * 60;
    }

    Runner.prototype.startStop = function() {
      if (this.timer.running) {
        return this.timer.stop();
      } else {
        return this.timer.start();
      }
    };

    Runner.prototype.tick = function() {
      var otherPlanet, planet, _i, _j, _k, _len, _len2, _len3, _ref, _ref2, _ref3;
      _ref = this.planets;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        planet = _ref[_i];
        _ref2 = this.planets;
        for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
          otherPlanet = _ref2[_j];
          planet.calculateGravitationalPull(otherPlanet, this.dt);
        }
      }
      _ref3 = this.planets;
      for (_k = 0, _len3 = _ref3.length; _k < _len3; _k++) {
        planet = _ref3[_k];
        planet.move(this.dt);
      }
      return this.screen.draw(this.planets);
    };

    Runner.prototype.render = function() {
      this.screen.draw(this.planets);
      this.timer.registerCallback(this.tick);
      return this.startStopButton.onclick = this.startStop;
    };

    Runner.init = function() {
      var runner;
      runner = new Runner;
      return runner.render();
    };

    return Runner;

  })();

}).call(this);
