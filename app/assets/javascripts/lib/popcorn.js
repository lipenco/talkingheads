/*
 * popcorn.js version 1.3
 * http://popcornjs.org
 *
 * Copyright 2011, Mozilla Foundation
 * Licensed under the MIT license
 */

(function(r, f) {
  function n(a, g) {
    return function() {
      if (d.plugin.debug) return a.apply(this, arguments);
      try {
        return a.apply(this, arguments)
      } catch (l) {
        d.plugin.errors.push({
          plugin: g,
          thrown: l,
          source: a.toString()
        });
        this.emit("pluginerror", d.plugin.errors)
      }
    }
  }
  if (f.addEventListener) {
    var c = Array.prototype,
        b = Object.prototype,
        e = c.forEach,
        h = c.slice,
        i = b.hasOwnProperty,
        j = b.toString,
        p = r.Popcorn,
        m = [],
        o = false,
        q = {
        events: {
          hash: {},
          apis: {}
        }
        },
        s = function() {
        return r.requestAnimationFrame || r.webkitRequestAnimationFrame || r.mozRequestAnimationFrame || r.oRequestAnimationFrame || r.msRequestAnimationFrame ||
        function(a) {
          r.setTimeout(a, 16)
        }
        }(),
        d = function(a, g) {
        return new d.p.init(a, g || null)
        };
    d.version = "1.3";
    d.isSupported = true;
    d.instances = [];
    d.p = d.prototype = {
      init: function(a, g) {
        var l, k = this;
        if (typeof a === "function") if (f.readyState === "complete") a(f, d);
        else {
          m.push(a);
          if (!o) {
            o = true;
            var t = function() {
              f.removeEventListener("DOMContentLoaded", t, false);
              for (var z = 0, C = m.length; z < C; z++) m[z].call(f, d);
              m = null
            };
            f.addEventListener("DOMContentLoaded", t, false)
          }
        } else {
          if (typeof a === "string") try {
            l = f.querySelector(a)
          } catch (u) {
            throw Error("Popcorn.js Error: Invalid media element selector: " + a);
          }
          this.media = l || a;
          l = this.media.nodeName && this.media.nodeName.toLowerCase() || "video";
          this[l] = this.media;
          this.options = g || {};
          this.id = this.options.id || d.guid(l);
          if (d.byId(this.id)) throw Error("Popcorn.js Error: Cannot use duplicate ID (" + this.id + ")");
          this.isDestroyed = false;
          this.data = {
            running: {
              cue: []
            },
            timeUpdate: d.nop,
            disabled: {},
            events: {},
            hooks: {},
            history: [],
            state: {
              volume: this.media.volume
            },
            trackRefs: {},
            trackEvents: {
              byStart: [{
                start: -1,
                end: -1
              }],
              byEnd: [{
                start: -1,
                end: -1
              }],
              animating: [],
              startIndex: 0,
              endIndex: 0,
              previousUpdateTime: -1
            }
          };
          d.instances.push(this);
          var v = function() {
            if (k.media.currentTime < 0) k.media.currentTime = 0;
            k.media.removeEventListener("loadeddata", v, false);
            var z, C, E, B, w;
            z = k.media.duration;
            z = z != z ? Number.MAX_VALUE : z + 1;
            d.addTrackEvent(k, {
              start: z,
              end: z
            });
            if (k.options.frameAnimation) {
              k.data.timeUpdate = function() {
                d.timeUpdate(k, {});
                d.forEach(d.manifest, function(D, F) {
                  if (C = k.data.running[F]) {
                    B = C.length;
                    for (var I = 0; I < B; I++) {
                      E = C[I];
                      (w = E._natives) && w.frame && w.frame.call(k, {}, E, k.currentTime())
                    }
                  }
                });
                k.emit("timeupdate");
                !k.isDestroyed && s(k.data.timeUpdate)
              };
              !k.isDestroyed && s(k.data.timeUpdate)
            } else {
              k.data.timeUpdate = function(D) {
                d.timeUpdate(k, D)
              };
              k.isDestroyed || k.media.addEventListener("timeupdate", k.data.timeUpdate, false)
            }
          };
          Object.defineProperty(this, "error", {
            get: function() {
              return k.media.error
            }
          });
          k.media.readyState >= 2 ? v() : k.media.addEventListener("loadeddata", v, false);
          return this
        }
      }
    };
    d.p.init.prototype =
    d.p;
    d.byId = function(a) {
      for (var g = d.instances, l = g.length, k = 0; k < l; k++) if (g[k].id === a) return g[k];
      return null
    };
    d.forEach = function(a, g, l) {
      if (!a || !g) return {};
      l = l || this;
      var k, t;
      if (e && a.forEach === e) return a.forEach(g, l);
      if (j.call(a) === "[object NodeList]") {
        k = 0;
        for (t = a.length; k < t; k++) g.call(l, a[k], k, a);
        return a
      }
      for (k in a) i.call(a, k) && g.call(l, a[k], k, a);
      return a
    };
    d.extend = function(a) {
      var g = h.call(arguments, 1);
      d.forEach(g, function(l) {
        for (var k in l) a[k] = l[k]
      });
      return a
    };
    d.extend(d, {
      noConflict: function(a) {
        if (a) r.Popcorn =
        p;
        return d
      },
      error: function(a) {
        throw Error(a);
      },
      guid: function(a) {
        d.guid.counter++;
        return (a ? a : "") + (+new Date + d.guid.counter)
      },
      sizeOf: function(a) {
        var g = 0,
            l;
        for (l in a) g++;
        return g
      },
      isArray: Array.isArray ||
      function(a) {
        return j.call(a) === "[object Array]"
      },
      nop: function() {},
      position: function(a) {
        a = a.getBoundingClientRect();
        var g = {},
            l = f.documentElement,
            k = f.body,
            t, u, v;
        t = l.clientTop || k.clientTop || 0;
        u = l.clientLeft || k.clientLeft || 0;
        v = r.pageYOffset && l.scrollTop || k.scrollTop;
        l = r.pageXOffset && l.scrollLeft || k.scrollLeft;
        t = Math.ceil(a.top + v - t);
        u = Math.ceil(a.left + l - u);
        for (var z in a) g[z] = Math.round(a[z]);
        return d.extend({}, g, {
          top: t,
          left: u
        })
      },
      disable: function(a, g) {
        if (!a.data.disabled[g]) {
          a.data.disabled[g] = true;
          for (var l = a.data.running[g].length - 1, k; l >= 0; l--) {
            k = a.data.running[g][l];
            k._natives.end.call(a, null, k)
          }
        }
        return a
      },
      enable: function(a, g) {
        if (a.data.disabled[g]) {
          a.data.disabled[g] = false;
          for (var l = a.data.running[g].length - 1, k; l >= 0; l--) {
            k = a.data.running[g][l];
            k._natives.start.call(a, null, k)
          }
        }
        return a
      },
      destroy: function(a) {
        var g =
        a.data.events,
            l = a.data.trackEvents,
            k, t, u, v;
        for (t in g) {
          k = g[t];
          for (u in k) delete k[u];
          g[t] = null
        }
        for (v in d.registryByName) d.removePlugin(a, v);
        l.byStart.length = 0;
        l.byEnd.length = 0;
        if (!a.isDestroyed) {
          a.data.timeUpdate && a.media.removeEventListener("timeupdate", a.data.timeUpdate, false);
          a.isDestroyed = true
        }
      }
    });
    d.guid.counter = 1;
    d.extend(d.p, function() {
      var a = {};
      d.forEach("load play pause currentTime playbackRate volume duration preload playbackRate autoplay loop controls muted buffered readyState seeking paused played seekable ended".split(/\s+/g), function(g) {
        a[g] = function(l) {
          var k;
          if (typeof this.media[g] === "function") {
            if (l != null && /play|pause/.test(g)) this.media.currentTime = d.util.toSeconds(l);
            this.media[g]();
            return this
          }
          if (l != null) {
            k = this.media[g];
            this.media[g] = l;
            k !== l && this.emit("attrchange", {
              attribute: g,
              previousValue: k,
              currentValue: l
            });
            return this
          }
          return this.media[g]
        }
      });
      return a
    }());
    d.forEach("enable disable".split(" "), function(a) {
      d.p[a] = function(g) {
        return d[a](this, g)
      }
    });
    d.extend(d.p, {
      roundTime: function() {
        return Math.round(this.media.currentTime)
      },
      exec: function(a, g, l) {
        var k = arguments.length,
            t, u;
        try {
          u = d.util.toSeconds(a)
        } catch (v) {}
        if (typeof u === "number") a = u;
        if (typeof a === "number" && k === 2) {
          l = g;
          g = a;
          a = d.guid("cue")
        } else if (k === 1) g = -1;
        else if (t = this.getTrackEvent(a)) {
          if (typeof a === "string" && k === 2) {
            if (typeof g === "number") l = t._natives.start;
            if (typeof g === "function") {
              l = g;
              g = t.start
            }
          }
        } else if (k >= 2) {
          if (typeof g === "string") {
            try {
              u = d.util.toSeconds(g)
            } catch (z) {}
            g = u
          }
          if (typeof g === "number") l = d.nop();
          if (typeof g === "function") {
            l = g;
            g = -1
          }
        }
        d.addTrackEvent(this, {
          id: a,
          start: g,
          end: g + 1,
          _running: false,
          _natives: {
            start: l || d.nop,
            end: d.nop,
            type: "cue"
          }
        });
        return this
      },
      mute: function(a) {
        a = a == null || a === true ? "muted" : "unmuted";
        if (a === "unmuted") {
          this.media.muted = false;
          this.media.volume = this.data.state.volume
        }
        if (a === "muted") {
          this.data.state.volume = this.media.volume;
          this.media.muted = true
        }
        this.emit(a);
        return this
      },
      unmute: function(a) {
        return this.mute(a == null ? false : !a)
      },
      position: function() {
        return d.position(this.media)
      },
      toggle: function(a) {
        return d[this.data.disabled[a] ? "enable" : "disable"](this, a)
      },
      defaults: function(a, g) {
        if (d.isArray(a)) {
          d.forEach(a, function(l) {
            for (var k in l) this.defaults(k, l[k])
          }, this);
          return this
        }
        if (!this.options.defaults) this.options.defaults = {};
        this.options.defaults[a] || (this.options.defaults[a] = {});
        d.extend(this.options.defaults[a], g);
        return this
      }
    });
    d.Events = {
      UIEvents: "blur focus focusin focusout load resize scroll unload",
      MouseEvents: "mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave click dblclick",
      Events: "loadstart progress suspend emptied stalled play pause error loadedmetadata loadeddata waiting playing canplay canplaythrough seeking seeked timeupdate ended ratechange durationchange volumechange"
    };
    d.Events.Natives = d.Events.UIEvents + " " + d.Events.MouseEvents + " " + d.Events.Events;
    q.events.apiTypes = ["UIEvents", "MouseEvents", "Events"];
    (function(a, g) {
      for (var l = q.events.apiTypes, k = a.Natives.split(/\s+/g), t = 0, u = k.length; t < u; t++) g.hash[k[t]] = true;
      l.forEach(function(v) {
        g.apis[v] = {};
        for (var z = a[v].split(/\s+/g), C = z.length, E = 0; E < C; E++) g.apis[v][z[E]] = true
      })
    })(d.Events, q.events);
    d.events = {
      isNative: function(a) {
        return !!q.events.hash[a]
      },
      getInterface: function(a) {
        if (!d.events.isNative(a)) return false;
        var g =
        q.events,
            l = g.apiTypes;
        g = g.apis;
        for (var k = 0, t = l.length, u, v; k < t; k++) {
          v = l[k];
          if (g[v][a]) {
            u = v;
            break
          }
        }
        return u
      },
      all: d.Events.Natives.split(/\s+/g),
      fn: {
        trigger: function(a, g) {
          var l;
          if (this.data.events[a] && d.sizeOf(this.data.events[a])) {
            if (l = d.events.getInterface(a)) {
              l = f.createEvent(l);
              l.initEvent(a, true, true, r, 1);
              this.media.dispatchEvent(l);
              return this
            }
            d.forEach(this.data.events[a], function(k) {
              k.call(this, g)
            }, this)
          }
          return this
        },
        listen: function(a, g) {
          var l = this,
              k = true,
              t = d.events.hooks[a],
              u;
          if (!this.data.events[a]) {
            this.data.events[a] = {};
            k = false
          }
          if (t) {
            t.add && t.add.call(this, {}, g);
            if (t.bind) a = t.bind;
            if (t.handler) {
              u = g;
              g = function(v) {
                t.handler.call(l, v, u)
              }
            }
            k = true;
            if (!this.data.events[a]) {
              this.data.events[a] = {};
              k = false
            }
          }
          this.data.events[a][g.name || g.toString() + d.guid()] = g;
          !k && d.events.all.indexOf(a) > -1 && this.media.addEventListener(a, function(v) {
            d.forEach(l.data.events[a], function(z) {
              typeof z === "function" && z.call(l, v)
            })
          }, false);
          return this
        },
        unlisten: function(a, g) {
          if (this.data.events[a] && this.data.events[a][g]) {
            delete this.data.events[a][g];
            return this
          }
          this.data.events[a] = null;
          return this
        }
      },
      hooks: {
        canplayall: {
          bind: "canplaythrough",
          add: function(a, g) {
            var l = false;
            if (this.media.readyState) {
              g.call(this, a);
              l = true
            }
            this.data.hooks.canplayall = {
              fired: l
            }
          },
          handler: function(a, g) {
            if (!this.data.hooks.canplayall.fired) {
              g.call(this, a);
              this.data.hooks.canplayall.fired = true
            }
          }
        }
      }
    };
    d.forEach([
      ["trigger", "emit"],
      ["listen", "on"],
      ["unlisten", "off"]
    ], function(a) {
      d.p[a[0]] = d.p[a[1]] = d.events.fn[a[0]]
    });
    d.addTrackEvent = function(a, g) {
      var l, k;
      if (g.id) l = a.getTrackEvent(g.id);
      if (l) {
        k = true;
        g = d.extend({}, l, g);
        a.removeTrackEvent(g.id)
      }
      if (g && g._natives && g._natives.type && a.options.defaults && a.options.defaults[g._natives.type]) g = d.extend({}, a.options.defaults[g._natives.type], g);
      if (g._natives) {
        g._id = g.id || g._id || d.guid(g._natives.type);
        a.data.history.push(g._id)
      }
      g.start = d.util.toSeconds(g.start, a.options.framerate);
      g.end = d.util.toSeconds(g.end, a.options.framerate);
      var t = a.data.trackEvents.byStart,
          u = a.data.trackEvents.byEnd,
          v;
      for (v = t.length - 1; v >= 0; v--) if (g.start >= t[v].start) {
        t.splice(v + 1, 0, g);
        break
      }
      for (t = u.length - 1; t >= 0; t--) if (g.end > u[t].end) {
        u.splice(t + 1, 0, g);
        break
      }
      if (g.end > a.media.currentTime && g.start <= a.media.currentTime) {
        g._running = true;
        a.data.running[g._natives.type].push(g);
        a.data.disabled[g._natives.type] || g._natives.start.call(a, null, g)
      }
      v <= a.data.trackEvents.startIndex && g.start <= a.data.trackEvents.previousUpdateTime && a.data.trackEvents.startIndex++;
      t <= a.data.trackEvents.endIndex && g.end < a.data.trackEvents.previousUpdateTime && a.data.trackEvents.endIndex++;
      this.timeUpdate(a, null, true);
      g._id && d.addTrackEvent.ref(a, g);
      if (k) {
        k = g._natives.type === "cue" ? "cuechange" : "trackchange";
        a.emit(k, {
          id: g.id,
          previousValue: {
            time: l.start,
            fn: l._natives.start
          },
          currentValue: {
            time: g.start,
            fn: g._natives.start
          }
        })
      }
    };
    d.addTrackEvent.ref = function(a, g) {
      a.data.trackRefs[g._id] = g;
      return a
    };
    d.removeTrackEvent = function(a, g) {
      for (var l, k, t = a.data.history.length, u = a.data.trackEvents.byStart.length, v = 0, z = 0, C = [], E = [], B = [], w = []; --u > -1;) {
        l = a.data.trackEvents.byStart[v];
        k = a.data.trackEvents.byEnd[v];
        if (!l._id) {
          C.push(l);
          E.push(k)
        }
        if (l._id) {
          l._id !== g && C.push(l);
          k._id !== g && E.push(k);
          if (l._id === g) {
            z = v;
            l._natives._teardown && l._natives._teardown.call(a, l)
          }
        }
        v++
      }
      u = a.data.trackEvents.animating.length;
      v = 0;
      if (u) for (; --u > -1;) {
        l = a.data.trackEvents.animating[v];
        l._id || B.push(l);
        l._id && l._id !== g && B.push(l);
        v++
      }
      z <= a.data.trackEvents.startIndex && a.data.trackEvents.startIndex--;
      z <= a.data.trackEvents.endIndex && a.data.trackEvents.endIndex--;
      a.data.trackEvents.byStart = C;
      a.data.trackEvents.byEnd = E;
      a.data.trackEvents.animating = B;
      for (u =
      0; u < t; u++) a.data.history[u] !== g && w.push(a.data.history[u]);
      a.data.history = w;
      d.removeTrackEvent.ref(a, g)
    };
    d.removeTrackEvent.ref = function(a, g) {
      delete a.data.trackRefs[g];
      return a
    };
    d.getTrackEvents = function(a) {
      var g = [];
      a = a.data.trackEvents.byStart;
      for (var l = a.length, k = 0, t; k < l; k++) {
        t = a[k];
        t._id && g.push(t)
      }
      return g
    };
    d.getTrackEvents.ref = function(a) {
      return a.data.trackRefs
    };
    d.getTrackEvent = function(a, g) {
      return a.data.trackRefs[g]
    };
    d.getTrackEvent.ref = function(a, g) {
      return a.data.trackRefs[g]
    };
    d.getLastTrackEventId =

    function(a) {
      return a.data.history[a.data.history.length - 1]
    };
    d.timeUpdate = function(a, g) {
      var l = a.media.currentTime,
          k = a.data.trackEvents.previousUpdateTime,
          t = a.data.trackEvents,
          u = t.endIndex,
          v = t.startIndex,
          z = t.byStart.length,
          C = t.byEnd.length,
          E = d.registryByName,
          B, w, D;
      if (k <= l) {
        for (; t.byEnd[u] && t.byEnd[u].end <= l;) {
          B = t.byEnd[u];
          w = (k = B._natives) && k.type;
          if (!k || E[w] || a[w]) {
            if (B._running === true) {
              B._running = false;
              D = a.data.running[w];
              D.splice(D.indexOf(B), 1);
              if (!a.data.disabled[w]) {
                k.end.call(a, g, B);
                a.emit("trackend", d.extend({}, B, {
                  plugin: w,
                  type: "trackend"
                }))
              }
            }
            u++
          } else {
            d.removeTrackEvent(a, B._id);
            return
          }
        }
        for (; t.byStart[v] && t.byStart[v].start <= l;) {
          B = t.byStart[v];
          w = (k = B._natives) && k.type;
          if (!k || E[w] || a[w]) {
            if (B.end > l && B._running === false) {
              B._running = true;
              a.data.running[w].push(B);
              if (!a.data.disabled[w]) {
                k.start.call(a, g, B);
                a.emit("trackstart", d.extend({}, B, {
                  plugin: w,
                  type: "trackstart"
                }))
              }
            }
            v++
          } else {
            d.removeTrackEvent(a, B._id);
            return
          }
        }
      } else if (k > l) {
        for (; t.byStart[v] && t.byStart[v].start > l;) {
          B = t.byStart[v];
          w = (k = B._natives) && k.type;
          if (!k || E[w] || a[w]) {
            if (B._running === true) {
              B._running = false;
              D = a.data.running[w];
              D.splice(D.indexOf(B), 1);
              if (!a.data.disabled[w]) {
                k.end.call(a, g, B);
                a.emit("trackend", d.extend({}, B, {
                  plugin: w,
                  type: "trackend"
                }))
              }
            }
            v--
          } else {
            d.removeTrackEvent(a, B._id);
            return
          }
        }
        for (; t.byEnd[u] && t.byEnd[u].end > l;) {
          B = t.byEnd[u];
          w = (k = B._natives) && k.type;
          if (!k || E[w] || a[w]) {
            if (B.start <= l && B._running === false) {
              B._running = true;
              a.data.running[w].push(B);
              if (!a.data.disabled[w]) {
                k.start.call(a, g, B);
                a.emit("trackstart", d.extend({}, B, {
                  plugin: w,
                  type: "trackstart"
                }))
              }
            }
            u--
          } else {
            d.removeTrackEvent(a, B._id);
            return
          }
        }
      }
      t.endIndex = u;
      t.startIndex = v;
      t.previousUpdateTime = l;
      t.byStart.length < z && t.startIndex--;
      t.byEnd.length < C && t.endIndex--
    };
    d.extend(d.p, {
      getTrackEvents: function() {
        return d.getTrackEvents.call(null, this)
      },
      getTrackEvent: function(a) {
        return d.getTrackEvent.call(null, this, a)
      },
      getLastTrackEventId: function() {
        return d.getLastTrackEventId.call(null, this)
      },
      removeTrackEvent: function(a) {
        d.removeTrackEvent.call(null, this, a);
        return this
      },
      removePlugin: function(a) {
        d.removePlugin.call(null, this, a);
        return this
      },
      timeUpdate: function(a) {
        d.timeUpdate.call(null, this, a);
        return this
      },
      destroy: function() {
        d.destroy.call(null, this);
        return this
      }
    });
    d.manifest = {};
    d.registry = [];
    d.registryByName = {};
    d.plugin = function(a, g, l) {
      if (d.protect.natives.indexOf(a.toLowerCase()) >= 0) d.error("'" + a + "' is a protected function name");
      else {
        var k = ["start", "end"],
            t = {},
            u = typeof g === "function",
            v = ["_setup", "_teardown", "start", "end", "frame"],
            z = function(B, w) {
            B = B || d.nop;
            w = w || d.nop;
            return function() {
              B.apply(this, arguments);
              w.apply(this, arguments)
            }
            };
        d.manifest[a] = l = l || g.manifest || {};
        v.forEach(function(B) {
          g[B] = n(g[B] || d.nop, a)
        });
        var C = function(B, w) {
          if (!w) return this;
          if (w.ranges && d.isArray(w.ranges)) {
            d.forEach(w.ranges, function(G) {
              G = d.extend({}, w, G);
              delete G.ranges;
              this[a](G)
            }, this);
            return this
          }
          var D = w._natives = {},
              F = "",
              I;
          d.extend(D, B);
          w._natives.type = a;
          w._running = false;
          D.start = D.start || D["in"];
          D.end = D.end || D.out;
          if (w.once) D.end = z(D.end, function() {
            this.removeTrackEvent(w._id)
          });
          D._teardown = z(function() {
            var G = h.call(arguments),
                H = this.data.running[D.type];
            G.unshift(null);
            G[1]._running && H.splice(H.indexOf(w), 1) && D.end.apply(this, G)
          }, D._teardown);
          w.compose = w.compose && w.compose.split(" ") || [];
          w.effect = w.effect && w.effect.split(" ") || [];
          w.compose = w.compose.concat(w.effect);
          w.compose.forEach(function(G) {
            F = d.compositions[G] || {};
            v.forEach(function(H) {
              D[H] = z(D[H], F[H])
            })
          });
          w._natives.manifest = l;
          if (!("start" in w)) w.start = w["in"] || 0;
          if (!w.end && w.end !== 0) w.end = w.out || Number.MAX_VALUE;
          if (!i.call(w, "toString")) w.toString = function() {
            var G = ["start: " + w.start, "end: " + w.end, "id: " + (w.id || w._id)];
            w.target != null && G.push("target: " + w.target);
            return a + " ( " + G.join(", ") + " )"
          };
          if (!w.target) {
            I = "options" in l && l.options;
            w.target = I && "target" in I && I.target
          }
          if (w._natives) w._id = d.guid(w._natives.type);
          w._natives._setup && w._natives._setup.call(this, w);
          d.addTrackEvent(this, w);
          d.forEach(B, function(G, H) {
            H !== "type" && k.indexOf(H) === -1 && this.on(H, G)
          }, this);
          return this
        };
        d.p[a] = t[a] = function(B, w) {
          var D;
          if (B && !w) w = B;
          else if (D = this.getTrackEvent(B)) {
            w = d.extend({}, D, w);
            d.addTrackEvent(this, w);
            return this
          } else w.id = B;
          this.data.running[a] = this.data.running[a] || [];
          D = d.extend({}, this.options.defaults && this.options.defaults[a] || {}, w);
          return C.call(this, u ? g.call(this, D) : g, D)
        };
        l && d.extend(g, {
          manifest: l
        });
        var E = {
          fn: t[a],
          definition: g,
          base: g,
          parents: [],
          name: a
        };
        d.registry.push(d.extend(t, E, {
          type: a
        }));
        d.registryByName[a] = E;
        return t
      }
    };
    d.plugin.errors = [];
    d.plugin.debug = d.version === "1.3";
    d.removePlugin = function(a, g) {
      if (!g) {
        g = a;
        a = d.p;
        if (d.protect.natives.indexOf(g.toLowerCase()) >= 0) {
          d.error("'" + g + "' is a protected function name");
          return
        }
        var l = d.registry.length,
            k;
        for (k = 0; k < l; k++) if (d.registry[k].name === g) {
          d.registry.splice(k, 1);
          delete d.registryByName[g];
          delete d.manifest[g];
          delete a[g];
          return
        }
      }
      l = a.data.trackEvents.byStart;
      k = a.data.trackEvents.byEnd;
      var t = a.data.trackEvents.animating,
          u, v;
      u = 0;
      for (v = l.length; u < v; u++) {
        if (l[u] && l[u]._natives && l[u]._natives.type === g) {
          l[u]._natives._teardown && l[u]._natives._teardown.call(a, l[u]);
          l.splice(u, 1);
          u--;
          v--;
          if (a.data.trackEvents.startIndex <= u) {
            a.data.trackEvents.startIndex--;
            a.data.trackEvents.endIndex--
          }
        }
        k[u] && k[u]._natives && k[u]._natives.type === g && k.splice(u, 1)
      }
      u = 0;
      for (v = t.length; u < v; u++) if (t[u] && t[u]._natives && t[u]._natives.type === g) {
        t.splice(u, 1);
        u--;
        v--
      }
    };
    d.compositions = {};
    d.compose = function(a, g, l) {
      d.manifest[a] = l || g.manifest || {};
      d.compositions[a] = g
    };
    d.plugin.effect = d.effect = d.compose;
    var A = /^(?:\.|#|\[)/;
    d.dom = {
      debug: false,
      find: function(a, g) {
        var l = null;
        a = a.trim();
        g =
        g || f;
        if (a) {
          if (!A.test(a)) {
            l = f.getElementById(a);
            if (l !== null) return l
          }
          try {
            l = g.querySelector(a)
          } catch (k) {
            if (d.dom.debug) throw Error(k);
          }
        }
        return l
      }
    };
    var y = /\?/,
        x = {
        url: "",
        data: "",
        dataType: "",
        success: d.nop,
        type: "GET",
        async: true,
        xhr: function() {
          return new r.XMLHttpRequest
        }
        };
    d.xhr = function(a) {
      a.dataType = a.dataType && a.dataType.toLowerCase() || null;
      if (a.dataType && (a.dataType === "jsonp" || a.dataType === "script")) d.xhr.getJSONP(a.url, a.success, a.dataType === "script");
      else {
        a = d.extend({}, x, a);
        a.ajax = a.xhr();
        if (a.ajax) {
          if (a.type === "GET" && a.data) {
            a.url += (y.test(a.url) ? "&" : "?") + a.data;
            a.data = null
          }
          a.ajax.open(a.type, a.url, a.async);
          a.ajax.send(a.data || null);
          return d.xhr.httpData(a)
        }
      }
    };
    d.xhr.httpData = function(a) {
      var g, l = null,
          k, t = null;
      a.ajax.onreadystatechange = function() {
        if (a.ajax.readyState === 4) {
          try {
            l = JSON.parse(a.ajax.responseText)
          } catch (u) {}
          g = {
            xml: a.ajax.responseXML,
            text: a.ajax.responseText,
            json: l
          };
          if (!g.xml || !g.xml.documentElement) {
            g.xml = null;
            try {
              k = new DOMParser;
              t = k.parseFromString(a.ajax.responseText, "text/xml");
              if (!t.getElementsByTagName("parsererror").length) g.xml =
              t
            } catch (v) {}
          }
          if (a.dataType) g = g[a.dataType];
          a.success.call(a.ajax, g)
        }
      };
      return g
    };
    d.xhr.getJSONP = function(a, g, l) {
      var k = f.head || f.getElementsByTagName("head")[0] || f.documentElement,
          t = f.createElement("script"),
          u = false,
          v = [];
      v = /(=)\?(?=&|$)|\?\?/;
      var z, C;
      if (!l) {
        C = a.match(/(callback=[^&]*)/);
        if (C !== null && C.length) {
          v = C[1].split("=")[1];
          if (v === "?") v = "jsonp";
          z = d.guid(v);
          a = a.replace(/(callback=[^&]*)/, "callback=" + z)
        } else {
          z = d.guid("jsonp");
          if (v.test(a)) a = a.replace(v, "$1" + z);
          v = a.split(/\?(.+)?/);
          a = v[0] + "?";
          if (v[1]) a += v[1] + "&";
          a += "callback=" + z
        }
        window[z] = function(E) {
          g && g(E);
          u = true
        }
      }
      t.addEventListener("load", function() {
        l && g && g();
        u && delete window[z];
        k.removeChild(t)
      }, false);
      t.src = a;
      k.insertBefore(t, k.firstChild)
    };
    d.getJSONP = d.xhr.getJSONP;
    d.getScript = d.xhr.getScript = function(a, g) {
      return d.xhr.getJSONP(a, g, true)
    };
    d.util = {
      toSeconds: function(a, g) {
        var l = /^([0-9]+:){0,2}[0-9]+([.;][0-9]+)?$/,
            k, t, u;
        if (typeof a === "number") return a;
        typeof a === "string" && !l.test(a) && d.error("Invalid time format");
        l = a.split(":");
        k = l.length - 1;
        t = l[k];
        if (t.indexOf(";") > -1) {
          t = t.split(";");
          u = 0;
          if (g && typeof g === "number") u = parseFloat(t[1], 10) / g;
          l[k] = parseInt(t[0], 10) + u
        }
        k = l[0];
        return {
          1: parseFloat(k, 10),
          2: parseInt(k, 10) * 60 + parseFloat(l[1], 10),
          3: parseInt(k, 10) * 3600 + parseInt(l[1], 10) * 60 + parseFloat(l[2], 10)
        }[l.length || 1]
      }
    };
    d.p.cue = d.p.exec;
    d.protect = {
      natives: function(a) {
        return Object.keys ? Object.keys(a) : function(g) {
          var l, k = [];
          for (l in g) i.call(g, l) && k.push(l);
          return k
        }(a)
      }(d.p).map(function(a) {
        return a.toLowerCase()
      })
    };
    d.forEach({
      listen: "on",
      unlisten: "off",
      trigger: "emit",
      exec: "cue"
    }, function(a, g) {
      var l = d.p[g];
      d.p[g] = function() {
        if (typeof console !== "undefined" && console.warn) {
          console.warn("Deprecated method '" + g + "', " + (a == null ? "do not use." : "use '" + a + "' instead."));
          d.p[g] = l
        }
        return d.p[a].apply(this, [].slice.call(arguments))
      }
    });
    r.Popcorn = d
  } else {
    r.Popcorn = {
      isSupported: false
    };
    for (c = "byId forEach extend effects error guid sizeOf isArray nop position disable enable destroyaddTrackEvent removeTrackEvent getTrackEvents getTrackEvent getLastTrackEventId timeUpdate plugin removePlugin compose effect xhr getJSONP getScript".split(/\s+/); c.length;) r.Popcorn[c.shift()] =

    function() {}
  }
})(window, window.document);
(function(r, f) {
  var n = r.document,
      c = r.location,
      b = /:\/\//,
      e = c.href.replace(c.href.split("/").slice(-1)[0], ""),
      h = function(j, p, m) {
      j = j || 0;
      p = (p || j || 0) + 1;
      m = m || 1;
      p = Math.ceil((p - j) / m) || 0;
      var o = 0,
          q = [];
      for (q.length = p; o < p;) {
        q[o++] = j;
        j += m
      }
      return q
      };
  f.sequence = function(j, p) {
    return new f.sequence.init(j, p)
  };
  f.sequence.init = function(j, p) {
    this.parent = n.getElementById(j);
    this.seqId = f.guid("__sequenced");
    this.queue = [];
    this.playlist = [];
    this.inOuts = {
      ofVideos: [],
      ofClips: []
    };
    this.dims = {
      width: 0,
      height: 0
    };
    this.active = 0;
    this.playing =
    this.cycling = false;
    this.times = {
      last: 0
    };
    this.events = {};
    var m = this,
        o = 0;
    f.forEach(p, function(q, s) {
      var d = n.createElement("video");
      d.preload = "auto";
      d.controls = true;
      d.style.display = s && "none" || "";
      d.id = m.seqId + "-" + s;
      m.queue.push(d);
      var A = q["in"],
          y = q.out;
      m.inOuts.ofVideos.push({
        "in": A !== undefined && A || 1,
        out: y !== undefined && y || 0
      });
      m.inOuts.ofVideos[s].out = m.inOuts.ofVideos[s].out || m.inOuts.ofVideos[s]["in"] + 2;
      d.src = !b.test(q.src) ? e + q.src : q.src;
      d.setAttribute("data-sequence-owner", j);
      d.setAttribute("data-sequence-guid", m.seqId);
      d.setAttribute("data-sequence-id", s);
      d.setAttribute("data-sequence-clip", [m.inOuts.ofVideos[s]["in"], m.inOuts.ofVideos[s].out].join(":"));
      m.parent.appendChild(d);
      m.playlist.push(f("#" + d.id))
    });
    m.inOuts.ofVideos.forEach(function(q) {
      q = {
        "in": o,
        out: o + (q.out - q["in"])
      };
      m.inOuts.ofClips.push(q);
      o = q.out + 1
    });
    f.forEach(this.queue, function(q, s) {
      function d() {
        if (!s) {
          m.dims.width = q.videoWidth;
          m.dims.height = q.videoHeight
        }
        q.currentTime = m.inOuts.ofVideos[s]["in"] - 0.5;
        q.removeEventListener("canplaythrough", d, false);
        return true
      }
      q.addEventListener("canplaythrough", d, false);
      q.addEventListener("play", function() {
        m.playing = true
      }, false);
      q.addEventListener("pause", function() {
        m.playing = false
      }, false);
      q.addEventListener("timeupdate", function(A) {
        A = A.srcElement || A.target;
        A = +(A.dataset && A.dataset.sequenceId || A.getAttribute("data-sequence-id"));
        var y = Math.floor(q.currentTime);
        if (m.times.last !== y && A === m.active) {
          m.times.last = y;
          y === m.inOuts.ofVideos[A].out && f.sequence.cycle.call(m, A)
        }
      }, false)
    });
    return this
  };
  f.sequence.init.prototype =
  f.sequence.prototype;
  f.sequence.cycle = function(j) {
    this.queue || f.error("Popcorn.sequence.cycle is not a public method");
    var p = this.queue,
        m = this.inOuts.ofVideos,
        o = p[j],
        q = 0,
        s;
    if (p[j + 1]) q = j + 1;
    if (p[j + 1]) {
      p = p[q];
      m = m[q];
      f.extend(p, {
        width: this.dims.width,
        height: this.dims.height
      });
      s = this.playlist[q];
      o.pause();
      this.active = q;
      this.times.last = m["in"] - 1;
      s.currentTime(m["in"]);
      s[q ? "play" : "pause"]();
      this.trigger("cycle", {
        position: {
          previous: j,
          current: q
        }
      });
      if (q) {
        o.style.display = "none";
        p.style.display = ""
      }
      this.cycling =
      false
    } else this.playlist[j].pause();
    return this
  };
  var i = ["timeupdate", "play", "pause"];
  f.extend(f.sequence.prototype, {
    eq: function(j) {
      return this.playlist[j]
    },
    remove: function() {
      this.parent.innerHTML = null
    },
    clip: function(j) {
      return this.inOuts.ofVideos[j]
    },
    duration: function() {
      for (var j = 0, p = this.inOuts.ofClips, m = 0; m < p.length; m++) j += p[m].out - p[m]["in"] + 1;
      return j - 1
    },
    play: function() {
      this.playlist[this.active].play();
      return this
    },
    exec: function(j, p) {
      var m = this.active;
      this.inOuts.ofClips.forEach(function(o, q) {
        if (j >= o["in"] && j <= o.out) m = q
      });
      j += this.inOuts.ofVideos[m]["in"] - this.inOuts.ofClips[m]["in"];
      f.addTrackEvent(this.playlist[m], {
        start: j - 1,
        end: j,
        _running: false,
        _natives: {
          start: p || f.nop,
          end: f.nop,
          type: "exec"
        }
      });
      return this
    },
    listen: function(j, p) {
      var m = this,
          o = this.playlist,
          q = o.length,
          s = 0;
      if (!p) p = f.nop;
      if (f.Events.Natives.indexOf(j) > -1) f.forEach(o, function(d) {
        d.listen(j, function(A) {
          A.active = m;
          if (i.indexOf(j) > -1) p.call(d, A);
          else++s === q && p.call(d, A)
        })
      });
      else {
        this.events[j] || (this.events[j] = {});
        o = p.name || f.guid("__" + j);
        this.events[j][o] = p
      }
      return this
    },
    unlisten: function() {},
    trigger: function(j, p) {
      var m = this;
      if (!(f.Events.Natives.indexOf(j) > -1)) {
        this.events[j] && f.forEach(this.events[j], function(o) {
          o.call(m, {
            type: j
          }, p)
        });
        return this
      }
    }
  });
  f.forEach(f.manifest, function(j, p) {
    f.sequence.prototype[p] = function(m) {
      var o = {},
          q = [],
          s, d, A, y, x;
      for (s = 0; s < this.inOuts.ofClips.length; s++) {
        q = this.inOuts.ofClips[s];
        d = h(q["in"], q.out);
        A = d.indexOf(m.start);
        y = d.indexOf(m.end);
        if (A > -1) o[s] = f.extend({}, q, {
          start: d[A],
          clipIdx: A
        });
        if (y > -1) o[s] =
        f.extend({}, q, {
          end: d[y],
          clipIdx: y
        })
      }
      s = Object.keys(o).map(function(g) {
        return +g
      });
      q = h(s[0], s[1]);
      for (s = 0; s < q.length; s++) {
        A = {};
        y = q[s];
        var a = o[y];
        if (a) {
          x = this.inOuts.ofVideos[y];
          d = a.clipIdx;
          x = h(x["in"], x.out);
          if (a.start) {
            A.start = x[d];
            A.end = x[x.length - 1]
          }
          if (a.end) {
            A.start = x[0];
            A.end = x[d]
          }
        } else {
          A.start = this.inOuts.ofVideos[y]["in"];
          A.end = this.inOuts.ofVideos[y].out
        }
        this.playlist[y][p](f.extend({}, m, A))
      }
      return this
    }
  })
})(this, Popcorn);
(function(r) {
  document.addEventListener("DOMContentLoaded", function() {
    var f = document.querySelectorAll("[data-timeline-sources]");
    r.forEach(f, function(n, c) {
      var b = f[c],
          e, h, i;
      if (!b.id) b.id = r.guid("__popcorn");
      if (b.nodeType && b.nodeType === 1) {
        i = r("#" + b.id);
        e = (b.getAttribute("data-timeline-sources") || "").split(",");
        e[0] && r.forEach(e, function(j) {
          h = j.split("!");
          if (h.length === 1) {
            h = j.match(/(.*)[\/\\]([^\/\\]+\.\w+)$/)[2].split(".");
            h[0] = "parse" + h[1].toUpperCase();
            h[1] = j
          }
          e[0] && i[h[0]] && i[h[0]](h[1])
        });
        i.autoplay() && i.play()
      }
    })
  }, false)
})(Popcorn);
(function(r, f) {
  function n(e) {
    e = typeof e === "string" ? e : [e.language, e.region].join("-");
    var h = e.split("-");
    return {
      iso6391: e,
      language: h[0] || "",
      region: h[1] || ""
    }
  }
  var c = r.navigator,
      b = n(c.userLanguage || c.language);
  f.locale = {
    get: function() {
      return b
    },
    set: function(e) {
      b = n(e);
      f.locale.broadcast();
      return b
    },
    broadcast: function(e) {
      var h = f.instances,
          i = h.length,
          j = 0,
          p;
      for (e = e || "locale:changed"; j < i; j++) {
        p = h[j];
        e in p.data.events && p.trigger(e)
      }
    }
  }
})(this, this.Popcorn);
(function(r) {
  var f = Object.prototype.hasOwnProperty;
  r.parsers = {};
  r.parser = function(n, c, b) {
    if (r.protect.natives.indexOf(n.toLowerCase()) >= 0) r.error("'" + n + "' is a protected function name");
    else {
      if (typeof c === "function" && !b) {
        b = c;
        c = ""
      }
      if (!(typeof b !== "function" || typeof c !== "string")) {
        var e = {};
        e[n] = function(h, i) {
          if (!h) return this;
          var j = this;
          r.xhr({
            url: h,
            dataType: c,
            success: function(p) {
              var m, o, q = 0;
              p = b(p).data || [];
              if (m = p.length) {
                for (; q < m; q++) {
                  o = p[q];
                  for (var s in o) f.call(o, s) && j[s] && j[s](o[s])
                }
                i && i()
              }
            }
          });
          return this
        };
        r.extend(r.p, e);
        return e
      }
    }
  }
})(Popcorn);
(function(r) {
  var f = function(b, e) {
    b = b || r.nop;
    e = e || r.nop;
    return function() {
      b.apply(this, arguments);
      e.apply(this, arguments)
    }
  },
      n = /^.*\.(ogg|oga|aac|mp3|wav)($|\?)/,
      c = /^.*\.(ogg|oga|aac|mp3|wav|ogg|ogv|mp4|webm)($|\?)/;
  r.player = function(b, e) {
    if (!r[b]) {
      e = e || {};
      var h = function(i, j, p) {
        p = p || {};
        var m = new Date / 1E3,
            o = m,
            q = 0,
            s = 0,
            d = 1,
            A = false,
            y = {},
            x = typeof i === "string" ? r.dom.find(i) : i,
            a = {};
        Object.prototype.__defineGetter__ || (a = x || document.createElement("div"));
        for (var g in x) if (!(g in a)) if (typeof x[g] === "object") a[g] =
        x[g];
        else if (typeof x[g] === "function") a[g] = function(k) {
          return "length" in x[k] && !x[k].call ? x[k] : function() {
            return x[k].apply(x, arguments)
          }
        }(g);
        else r.player.defineProperty(a, g, {
          get: function(k) {
            return function() {
              return x[k]
            }
          }(g),
          set: r.nop,
          configurable: true
        });
        var l = function() {
          m = new Date / 1E3;
          if (!a.paused) {
            a.currentTime += m - o;
            a.dispatchEvent("timeupdate");
            setTimeout(l, 10)
          }
          o = m
        };
        a.play = function() {
          this.paused = false;
          if (a.readyState >= 4) {
            o = new Date / 1E3;
            a.dispatchEvent("play");
            l()
          }
        };
        a.pause = function() {
          this.paused =
          true;
          a.dispatchEvent("pause")
        };
        r.player.defineProperty(a, "currentTime", {
          get: function() {
            return q
          },
          set: function(k) {
            q = +k;
            a.dispatchEvent("timeupdate");
            return q
          },
          configurable: true
        });
        r.player.defineProperty(a, "volume", {
          get: function() {
            return d
          },
          set: function(k) {
            d = +k;
            a.dispatchEvent("volumechange");
            return d
          },
          configurable: true
        });
        r.player.defineProperty(a, "muted", {
          get: function() {
            return A
          },
          set: function(k) {
            A = +k;
            a.dispatchEvent("volumechange");
            return A
          },
          configurable: true
        });
        r.player.defineProperty(a, "readyState", {
          get: function() {
            return s
          },
          set: function(k) {
            return s = k
          },
          configurable: true
        });
        a.addEventListener = function(k, t) {
          y[k] || (y[k] = []);
          y[k].push(t);
          return t
        };
        a.removeEventListener = function(k, t) {
          var u, v = y[k];
          if (v) {
            for (u = y[k].length - 1; u >= 0; u--) t === v[u] && v.splice(u, 1);
            return t
          }
        };
        a.dispatchEvent = function(k) {
          var t, u = k.type;
          if (!u) {
            u = k;
            if (k = r.events.getInterface(u)) {
              t = document.createEvent(k);
              t.initEvent(u, true, true, window, 1)
            }
          }
          if (y[u]) for (k = y[u].length - 1; k >= 0; k--) y[u][k].call(this, t, this)
        };
        a.src = j || "";
        a.duration = 0;
        a.paused =
        true;
        a.ended = 0;
        p && p.events && r.forEach(p.events, function(k, t) {
          a.addEventListener(t, k, false)
        });
        if (e._canPlayType(x.nodeName, j) !== false) if (e._setup) e._setup.call(a, p);
        else {
          a.readyState = 4;
          a.dispatchEvent("loadedmetadata");
          a.dispatchEvent("loadeddata");
          a.dispatchEvent("canplaythrough")
        } else setTimeout(function() {
          a.dispatchEvent("error")
        }, 0);
        i = new r.p.init(a, p);
        if (e._teardown) i.destroy = f(i.destroy, function() {
          e._teardown.call(a, p)
        });
        return i
      };
      h.canPlayType = e._canPlayType = e._canPlayType || r.nop;
      r[b] = r.player.registry[b] =
      h
    }
  };
  r.player.registry = {};
  r.player.defineProperty = Object.defineProperty ||
  function(b, e, h) {
    b.__defineGetter__(e, h.get || r.nop);
    b.__defineSetter__(e, h.set || r.nop)
  };
  r.player.playerQueue = function() {
    var b = [],
        e = false;
    return {
      next: function() {
        e = false;
        b.shift();
        b[0] && b[0]()
      },
      add: function(h) {
        b.push(function() {
          e = true;
          h && h()
        });
        !e && b[0]()
      }
    }
  };
  r.smart = function(b, e, h) {
    var i = ["AUDIO", "VIDEO"],
        j, p = r.dom.find(b),
        m;
    j = document.createElement("video");
    var o = {
      ogg: "video/ogg",
      ogv: "video/ogg",
      oga: "audio/ogg",
      webm: "video/webm",
      mp4: "video/mp4",
      mp3: "audio/mp3"
    };
    if (p) {
      if (i.indexOf(p.nodeName) > -1 && !e) {
        if (typeof e === "object") h = e;
        return r(p, h)
      }
      if (typeof e === "string") e = [e];
      b = 0;
      for (srcLength = e.length; b < srcLength; b++) {
        m = c.exec(e[b]);
        m = !m || !m[1] ? false : j.canPlayType(o[m[1]]);
        if (m) {
          e = e[b];
          break
        }
        for (var q in r.player.registry) if (r.player.registry.hasOwnProperty(q)) if (r.player.registry[q].canPlayType(p.nodeName, e[b])) return r[q](p, e[b], h)
      }
      if (i.indexOf(p.nodeName) === -1) {
        j = typeof e === "string" ? e : e.length ? e[0] : e;
        b = document.createElement(n.exec(j) ? i[0] : i[1]);
        b.controls = true;
        p.appendChild(b);
        p = b
      }
      h && h.events && h.events.error && p.addEventListener("error", h.events.error, false);
      p.src = e;
      return r(p, h)
    } else r.error("Specified target " + b + " was not found.")
  }
})(Popcorn);
(function(r) {
  var f = function(n, c) {
    var b = 0,
        e = 0,
        h;
    r.forEach(c.classes, function(i, j) {
      h = [];
      if (i === "parent") h[0] = document.querySelectorAll("#" + c.target)[0].parentNode;
      else h = document.querySelectorAll("#" + c.target + " " + i);
      b = 0;
      for (e = h.length; b < e; b++) h[b].classList.toggle(j)
    })
  };
  r.compose("applyclass", {
    manifest: {
      about: {
        name: "Popcorn applyclass Effect",
        version: "0.1",
        author: "@scottdowne",
        website: "scottdowne.wordpress.com"
      },
      options: {}
    },
    _setup: function(n) {
      n.classes = {};
      n.applyclass = n.applyclass || "";
      for (var c = n.applyclass.replace(/\s/g, "").split(","), b = [], e = 0, h = c.length; e < h; e++) {
        b = c[e].split(":");
        if (b[0]) n.classes[b[0]] = b[1] || ""
      }
    },
    start: f,
    end: f
  })
})(Popcorn);
(function(r) {
  var f = /(?:http:\/\/www\.|http:\/\/|www\.|\.|^)(youtu|vimeo|soundcloud|baseplayer)/,
      n = {},
      c = {
      vimeo: false,
      youtube: false,
      soundcloud: false,
      module: false
      };
  Object.defineProperty(n, void 0, {
    get: function() {
      return c[void 0]
    },
    set: function(b) {
      c[void 0] = b
    }
  });
  r.plugin("mediaspawner", {
    manifest: {
      about: {
        name: "Popcorn Media Spawner Plugin",
        version: "0.1",
        author: "Matthew Schranz, @mjschranz",
        website: "mschranz.wordpress.com"
      },
      options: {
        source: {
          elem: "input",
          type: "text",
          label: "Media Source",
          "default": "http://www.youtube.com/watch?v=CXDstfD9eJ0"
        },
        caption: {
          elem: "input",
          type: "text",
          label: "Media Caption",
          "default": "Popcorn Popping",
          optional: true
        },
        target: "mediaspawner-container",
        start: {
          elem: "input",
          type: "number",
          label: "Start"
        },
        end: {
          elem: "input",
          type: "number",
          label: "End"
        },
        autoplay: {
          elem: "input",
          type: "checkbox",
          label: "Autoplay Video",
          optional: true
        },
        width: {
          elem: "input",
          type: "number",
          label: "Media Width",
          "default": 400,
          units: "px",
          optional: true
        },
        height: {
          elem: "input",
          type: "number",
          label: "Media Height",
          "default": 200,
          units: "px",
          optional: true
        }
      }
    },
    _setup: function(b) {
      function e() {
        function o() {
          if (j !== "HTML5" && !window.Popcorn[j]) setTimeout(function() {
            o()
          }, 300);
          else {
            b.id = b._container.id;
            b._container.style.width = b.width + "px";
            b._container.style.height = b.height + "px";
            b.popcorn = r.smart("#" + b.id, b.source);
            j === "HTML5" && b.popcorn.controls(true);
            b._container.style.width = "0px";
            b._container.style.height = "0px";
            b._container.style.visibility = "hidden";
            b._container.style.overflow = "hidden"
          }
        }
        if (j !== "HTML5" && !window.Popcorn[j] && !n[j]) {
          n[j] = true;
          r.getScript("http://popcornjs.org/code/players/" + j + "/popcorn." + j + ".js", function() {
            o()
          })
        } else o()
      }
      function h() {
        window.Popcorn.player ? e() : setTimeout(function() {
          h()
        }, 300)
      }
      var i = document.getElementById(b.target) || {},
          j, p, m;
      if (p = f.exec(b.source)) {
        j = p[1];
        if (j === "youtu") j = "youtube"
      } else j = "HTML5";
      b._type = j;
      b._container = document.createElement("div");
      p = b._container;
      p.id = "mediaSpawnerdiv-" + r.guid();
      b.width = b.width || 400;
      b.height = b.height || 200;
      if (b.caption) {
        m = document.createElement("div");
        m.innerHTML = b.caption;
        m.style.display = "none";
        b._capCont = m;
        p.appendChild(m)
      }
      i && i.appendChild(p);
      if (!window.Popcorn.player && !n.module) {
        n.module = true;
        r.getScript("http://popcornjs.org/code/modules/player/popcorn.player.js", h)
      } else h()
    },
    start: function(b, e) {
      if (e._capCont) e._capCont.style.display = "";
      e._container.style.width = e.width + "px";
      e._container.style.height = e.height + "px";
      e._container.style.visibility = "visible";
      e._container.style.overflow = "visible";
      e.autoplay && e.popcorn.play()
    },
    end: function(b, e) {
      if (e._capCont) e._capCont.style.display = "none";
      e._container.style.width = "0px";
      e._container.style.height = "0px";
      e._container.style.visibility = "hidden";
      e._container.style.overflow = "hidden";
      e.popcorn.pause()
    },
    _teardown: function(b) {
      b.popcorn && b.popcorn.destory && b.popcorn.destroy();
      document.getElementById(b.target) && document.getElementById(b.target).removeChild(b._container)
    }
  })
})(Popcorn, this);
(function(r) {
  r.plugin("code", function(f) {
    var n = false,
        c = this,
        b = function() {
        var e = function(h) {
          return function(i, j) {
            var p = function() {
              n && i.call(c, j);
              n && h(p)
            };
            p()
          }
        };
        return window.webkitRequestAnimationFrame ? e(window.webkitRequestAnimationFrame) : window.mozRequestAnimationFrame ? e(window.mozRequestAnimationFrame) : e(function(h) {
          window.setTimeout(h, 16)
        })
        }();
    if (!f.onStart || typeof f.onStart !== "function") f.onStart = r.nop;
    if (f.onEnd && typeof f.onEnd !== "function") f.onEnd = undefined;
    if (f.onFrame && typeof f.onFrame !== "function") f.onFrame = undefined;
    return {
      start: function(e, h) {
        h.onStart.call(c, h);
        if (h.onFrame) {
          n = true;
          b(h.onFrame, h)
        }
      },
      end: function(e, h) {
        if (h.onFrame) n = false;
        h.onEnd && h.onEnd.call(c, h)
      }
    }
  }, {
    about: {
      name: "Popcorn Code Plugin",
      version: "0.1",
      author: "David Humphrey (@humphd)",
      website: "http://vocamus.net/dave"
    },
    options: {
      start: {
        elem: "input",
        type: "number",
        label: "Start"
      },
      end: {
        elem: "input",
        type: "number",
        label: "End"
      },
      onStart: {
        elem: "input",
        type: "function",
        label: "onStart"
      },
      onFrame: {
        elem: "input",
        type: "function",
        label: "onFrame",
        optional: true
      },
      onEnd: {
        elem: "input",
        type: "function",
        label: "onEnd"
      }
    }
  })
})(Popcorn);
(function(r) {
  var f = 0;
  r.plugin("flickr", function(n) {
    var c, b = document.getElementById(n.target),
        e, h, i, j, p = n.numberofimages || 4,
        m = n.height || "50px",
        o = n.width || "50px",
        q = n.padding || "5px",
        s = n.border || "0px";
    c = document.createElement("div");
    c.id = "flickr" + f;
    c.style.width = "100%";
    c.style.height = "100%";
    c.style.display = "none";
    f++;
    b && b.appendChild(c);
    var d = function() {
      if (e) setTimeout(function() {
        d()
      }, 5);
      else {
        h = "http://api.flickr.com/services/rest/?method=flickr.people.findByUsername&";
        h += "username=" + n.username + "&api_key=" + n.apikey + "&format=json&jsoncallback=flickr";
        r.getJSONP(h, function(y) {
          e = y.user.nsid;
          A()
        })
      }
    },
        A = function() {
        h = "http://api.flickr.com/services/feeds/photos_public.gne?";
        if (e) h += "id=" + e + "&";
        if (n.tags) h += "tags=" + n.tags + "&";
        h += "lang=en-us&format=json&jsoncallback=flickr";
        r.xhr.getJSONP(h, function(y) {
          var x = document.createElement("div");
          x.innerHTML = "<p style='padding:" + q + ";'>" + y.title + "<p/>";
          r.forEach(y.items, function(a, g) {
            if (g < p) {
              i = document.createElement("a");
              i.setAttribute("href", a.link);
              i.setAttribute("target", "_blank");
              j = document.createElement("img");
              j.setAttribute("src", a.media.m);
              j.setAttribute("height", m);
              j.setAttribute("width", o);
              j.setAttribute("style", "border:" + s + ";padding:" + q);
              i.appendChild(j);
              x.appendChild(i)
            } else
            return false
          });
          c.appendChild(x)
        })
        };
    if (n.username && n.apikey) d();
    else {
      e = n.userid;
      A()
    }
    return {
      start: function() {
        c.style.display = "inline"
      },
      end: function() {
        c.style.display = "none"
      },
      _teardown: function(y) {
        document.getElementById(y.target) && document.getElementById(y.target).removeChild(c)
      }
    }
  }, {
    about: {
      name: "Popcorn Flickr Plugin",
      version: "0.2",
      author: "Scott Downe, Steven Weerdenburg, Annasob",
      website: "http://scottdowne.wordpress.com/"
    },
    options: {
      start: {
        elem: "input",
        type: "number",
        label: "Start"
      },
      end: {
        elem: "input",
        type: "number",
        label: "End"
      },
      userid: {
        elem: "input",
        type: "text",
        label: "User ID",
        optional: true
      },
      tags: {
        elem: "input",
        type: "text",
        label: "Tags"
      },
      username: {
        elem: "input",
        type: "text",
        label: "Username",
        optional: true
      },
      apikey: {
        elem: "input",
        type: "text",
        label: "API Key",
        optional: true
      },
      target: "flickr-container",
      height: {
        elem: "input",
        type: "text",
        label: "Height",
        "default": "50px",
        optional: true
      },
      width: {
        elem: "input",
        type: "text",
        label: "Width",
        "default": "50px",
        optional: true
      },
      padding: {
        elem: "input",
        type: "text",
        label: "Padding",
        optional: true
      },
      border: {
        elem: "input",
        type: "text",
        label: "Border",
        "default": "5px",
        optional: true
      },
      numberofimages: {
        elem: "input",
        type: "number",
        "default": 4,
        label: "Number of Images"
      }
    }
  })
})(Popcorn);
(function(r) {
  r.plugin("footnote", {
    manifest: {
      about: {
        name: "Popcorn Footnote Plugin",
        version: "0.2",
        author: "@annasob, @rwaldron",
        website: "annasob.wordpress.com"
      },
      options: {
        start: {
          elem: "input",
          type: "number",
          label: "Start"
        },
        end: {
          elem: "input",
          type: "number",
          label: "End"
        },
        text: {
          elem: "input",
          type: "text",
          label: "Text"
        },
        target: "footnote-container"
      }
    },
    _setup: function(f) {
      var n = r.dom.find(f.target);
      f._container = document.createElement("div");
      f._container.style.display = "none";
      f._container.innerHTML = f.text;
      n.appendChild(f._container)
    },
    start: function(f, n) {
      n._container.style.display = "inline"
    },
    end: function(f, n) {
      n._container.style.display = "none"
    },
    _teardown: function(f) {
      var n = r.dom.find(f.target);
      n && n.removeChild(f._container)
    }
  })
})(Popcorn);
(function(r) {
  function f(b) {
    return String(b).replace(/&(?!\w+;)|[<>"']/g, function(e) {
      return c[e] || e
    })
  }
  function n(b, e) {
    var h = b.container = document.createElement("div"),
        i = h.style,
        j = b.media,
        p = function() {
        var m = b.position();
        i.fontSize = "18px";
        i.width = j.offsetWidth + "px";
        i.top = m.top + j.offsetHeight - h.offsetHeight - 40 + "px";
        i.left = m.left + "px";
        setTimeout(p, 10)
        };
    h.id = e || "";
    i.position = "absolute";
    i.color = "white";
    i.textShadow = "black 2px 2px 6px";
    i.fontWeight = "bold";
    i.textAlign = "center";
    p();
    b.media.parentNode.appendChild(h);
    return h
  }
  var c = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': "&quot;",
    "'": "&#39;"
  };
  r.plugin("text", {
    manifest: {
      about: {
        name: "Popcorn Text Plugin",
        version: "0.1",
        author: "@humphd"
      },
      options: {
        start: {
          elem: "input",
          type: "number",
          label: "Start"
        },
        end: {
          elem: "input",
          type: "number",
          label: "End"
        },
        text: {
          elem: "input",
          type: "text",
          label: "Text",
          "default": "Popcorn.js"
        },
        escape: {
          elem: "input",
          type: "checkbox",
          label: "Escape"
        },
        multiline: {
          elem: "input",
          type: "checkbox",
          label: "Multiline"
        }
      }
    },
    _setup: function(b) {
      var e, h, i = b._container = document.createElement("div");
      i.style.display = "none";
      if (b.target) if (e = r.dom.find(b.target)) {
        if (["VIDEO", "AUDIO"].indexOf(e.nodeName) > -1) e = n(this, b.target + "-overlay")
      } else e = n(this, b.target);
      else e = this.container ? this.container : n(this);
      b._target = e;
      h = b.escape ? f(b.text) : b.text;
      h = b.multiline ? h.replace(/\r?\n/gm, "<br>") : h;
      i.innerHTML = h || "";
      e.appendChild(i)
    },
    start: function(b, e) {
      e._container.style.display = "inline"
    },
    end: function(b, e) {
      e._container.style.display = "none"
    },
    _teardown: function(b) {
      var e = b._target;
      e && e.removeChild(b._container)
    }
  })
})(Popcorn);
var googleCallback;
(function(r) {
  function f(i, j, p) {
    i = i.type ? i.type.toUpperCase() : "HYBRID";
    var m;
    if (i === "STAMEN-WATERCOLOR" || i === "STAMEN-TERRAIN" || i === "STAMEN-TONER") m = i.replace("STAMEN-", "").toLowerCase();
    p = new google.maps.Map(p, {
      mapTypeId: m ? m : google.maps.MapTypeId[i],
      mapTypeControlOptions: {
        mapTypeIds: []
      }
    });
    m && p.mapTypes.set(m, new google.maps.StamenMapType(m));
    p.getDiv().style.display = "none";
    return p
  }
  var n = 1,
      c = false,
      b = false,
      e, h;
  googleCallback = function(i) {
    if (typeof google !== "undefined" && google.maps && google.maps.Geocoder && google.maps.LatLng) {
      e = new google.maps.Geocoder;
      r.getScript("//maps.stamen.com/js/tile.stamen.js", function() {
        b = true
      })
    } else setTimeout(function() {
      googleCallback(i)
    }, 1)
  };
  h = function() {
    if (document.body) {
      c = true;
      r.getScript("//maps.google.com/maps/api/js?sensor=false&callback=googleCallback")
    } else setTimeout(function() {
      h()
    }, 1)
  };
  r.plugin("googlemap", function(i) {
    var j, p, m, o = document.getElementById(i.target);
    i.type = i.type || "ROADMAP";
    i.zoom = i.zoom || 1;
    i.lat = i.lat || 0;
    i.lng = i.lng || 0;
    c || h();
    j = document.createElement("div");
    j.id = "actualmap" + n;
    j.style.width = i.width || "100%";
    j.style.height = i.height ? i.height : o && o.clientHeight ? o.clientHeight + "px" : "100%";
    n++;
    o && o.appendChild(j);
    var q = function() {
      if (b) {
        if (j) if (i.location) e.geocode({
          address: i.location
        }, function(s, d) {
          if (j && d === google.maps.GeocoderStatus.OK) {
            i.lat = s[0].geometry.location.lat();
            i.lng = s[0].geometry.location.lng();
            m = new google.maps.LatLng(i.lat, i.lng);
            p = f(i, m, j)
          }
        });
        else {
          m = new google.maps.LatLng(i.lat, i.lng);
          p = f(i, m, j)
        }
      } else setTimeout(function() {
        q()
      }, 5)
    };
    q();
    return {
      start: function(s, d) {
        var A = this,
            y, x = function() {
            if (p) {
              d._map = p;
              p.getDiv().style.display = "block";
              google.maps.event.trigger(p, "resize");
              p.setCenter(m);
              if (d.zoom && typeof d.zoom !== "number") d.zoom = +d.zoom;
              p.setZoom(d.zoom);
              if (d.heading && typeof d.heading !== "number") d.heading = +d.heading;
              if (d.pitch && typeof d.pitch !== "number") d.pitch = +d.pitch;
              if (d.type === "STREETVIEW") {
                p.setStreetView(y = new google.maps.StreetViewPanorama(j, {
                  position: m,
                  pov: {
                    heading: d.heading = d.heading || 0,
                    pitch: d.pitch = d.pitch || 0,
                    zoom: d.zoom
                  }
                }));
                var a = function(z, C) {
                  var E = google.maps.geometry.spherical.computeHeading;
                  setTimeout(function() {
                    var B = A.media.currentTime;
                    if (typeof d.tween === "object") {
                      for (var w = 0, D = z.length; w < D; w++) {
                        var F = z[w];
                        if (B >= F.interval * (w + 1) / 1E3 && (B <= F.interval * (w + 2) / 1E3 || B >= F.interval * D / 1E3)) {
                          u.setPosition(new google.maps.LatLng(F.position.lat, F.position.lng));
                          u.setPov({
                            heading: F.pov.heading || E(F, z[w + 1]) || 0,
                            zoom: F.pov.zoom || 0,
                            pitch: F.pov.pitch || 0
                          })
                        }
                      }
                      a(z, z[0].interval)
                    } else {
                      w = 0;
                      for (D = z.length; w < D; w++) {
                        F = d.interval;
                        if (B >= F * (w + 1) / 1E3 && (B <= F * (w + 2) / 1E3 || B >= F * D / 1E3)) {
                          g.setPov({
                            heading: E(z[w], z[w + 1]) || 0,
                            zoom: d.zoom,
                            pitch: d.pitch || 0
                          });
                          g.setPosition(l[w])
                        }
                      }
                      a(l, d.interval)
                    }
                  }, C)
                };
                if (d.location && typeof d.tween === "string") {
                  var g = y,
                      l = [],
                      k = new google.maps.DirectionsService,
                      t = new google.maps.DirectionsRenderer(g);
                  k.route({
                    origin: d.location,
                    destination: d.tween,
                    travelMode: google.maps.TravelMode.DRIVING
                  }, function(z, C) {
                    if (C == google.maps.DirectionsStatus.OK) {
                      t.setDirections(z);
                      for (var E = z.routes[0].overview_path, B = 0, w = E.length; B < w; B++) l.push(new google.maps.LatLng(E[B].lat(), E[B].lng()));
                      d.interval = d.interval || 1E3;
                      a(l, 10)
                    }
                  })
                } else if (typeof d.tween === "object") {
                  var u = y;
                  k = 0;
                  for (var v = d.tween.length; k < v; k++) {
                    d.tween[k].interval = d.tween[k].interval || 1E3;
                    a(d.tween, 10)
                  }
                }
              }
              d.onmaploaded && d.onmaploaded(d, p)
            } else setTimeout(function() {
              x()
            }, 13)
            };
        x()
      },
      end: function() {
        if (p) p.getDiv().style.display = "none"
      },
      _teardown: function(s) {
        var d = document.getElementById(s.target);
        d && d.removeChild(j);
        j = p = m = null;
        s._map = null
      }
    }
  }, {
    about: {
      name: "Popcorn Google Map Plugin",
      version: "0.1",
      author: "@annasob",
      website: "annasob.wordpress.com"
    },
    options: {
      start: {
        elem: "input",
        type: "start",
        label: "Start"
      },
      end: {
        elem: "input",
        type: "start",
        label: "End"
      },
      target: "map-container",
      type: {
        elem: "select",
        options: ["ROADMAP", "SATELLITE", "STREETVIEW", "HYBRID", "TERRAIN", "STAMEN-WATERCOLOR", "STAMEN-TERRAIN", "STAMEN-TONER"],
        label: "Map Type",
        optional: true
      },
      zoom: {
        elem: "input",
        type: "text",
        label: "Zoom",
        "default": 0,
        optional: true
      },
      lat: {
        elem: "input",
        type: "text",
        label: "Lat",
        optional: true
      },
      lng: {
        elem: "input",
        type: "text",
        label: "Lng",
        optional: true
      },
      location: {
        elem: "input",
        type: "text",
        label: "Location",
        "default": "Toronto, Ontario, Canada"
      },
      heading: {
        elem: "input",
        type: "text",
        label: "Heading",
        "default": 0,
        optional: true
      },
      pitch: {
        elem: "input",
        type: "text",
        label: "Pitch",
        "default": 1,
        optional: true
      }
    }
  })
})(Popcorn);
(function(r) {
  function f(b) {
    function e() {
      var p = b.getBoundingClientRect(),
          m = i.getBoundingClientRect();
      if (m.left !== p.left) i.style.left = p.left + "px";
      if (m.top !== p.top) i.style.top = p.top + "px"
    }
    var h = -1,
        i = document.createElement("div"),
        j = getComputedStyle(b).zIndex;
    i.setAttribute("data-popcorn-helper-container", true);
    i.style.position = "absolute";
    i.style.zIndex = isNaN(j) ? n : j + 1;
    document.body.appendChild(i);
    return {
      element: i,
      start: function() {
        h = setInterval(e, c)
      },
      stop: function() {
        clearInterval(h);
        h = -1
      },
      destroy: function() {
        document.body.removeChild(i);
        h !== -1 && clearInterval(h)
      }
    }
  }
  var n = 2E3,
      c = 10;
  r.plugin("image", {
    manifest: {
      about: {
        name: "Popcorn image Plugin",
        version: "0.1",
        author: "Scott Downe",
        website: "http://scottdowne.wordpress.com/"
      },
      options: {
        start: {
          elem: "input",
          type: "number",
          label: "Start"
        },
        end: {
          elem: "input",
          type: "number",
          label: "End"
        },
        src: {
          elem: "input",
          type: "url",
          label: "Image URL",
          "default": "http://mozillapopcorn.org/wp-content/themes/popcorn/images/for_developers.png"
        },
        href: {
          elem: "input",
          type: "url",
          label: "Link",
          "default": "http://mozillapopcorn.org/wp-content/themes/popcorn/images/for_developers.png",
          optional: true
        },
        target: "image-container",
        text: {
          elem: "input",
          type: "text",
          label: "Caption",
          "default": "Popcorn.js",
          optional: true
        }
      }
    },
    _setup: function(b) {
      var e = document.createElement("img"),
          h = document.getElementById(b.target);
      b.anchor = document.createElement("a");
      b.anchor.style.position = "relative";
      b.anchor.style.textDecoration = "none";
      b.anchor.style.display = "none";
      if (h) if (["VIDEO", "AUDIO"].indexOf(h.nodeName) > -1) {
        b.trackedContainer = f(h);
        b.trackedContainer.element.appendChild(b.anchor)
      } else h && h.appendChild(b.anchor);
      e.addEventListener("load", function() {
        e.style.borderStyle = "none";
        b.anchor.href = b.href || b.src || "#";
        b.anchor.target = "_blank";
        var i, j;
        e.style.height = h.style.height;
        e.style.width = h.style.width;
        b.anchor.appendChild(e);
        if (b.text) {
          i = e.height / 12 + "px";
          j = document.createElement("div");
          r.extend(j.style, {
            color: "black",
            fontSize: i,
            fontWeight: "bold",
            position: "relative",
            textAlign: "center",
            width: e.style.width || e.width + "px",
            zIndex: "10"
          });
          j.innerHTML = b.text || "";
          j.style.top = (e.style.height.replace("px", "") || e.height) / 2 - j.offsetHeight / 2 + "px";
          b.anchor.insertBefore(j, e)
        }
      }, false);
      e.src = b.src
    },
    start: function(b, e) {
      e.anchor.style.display = "inline";
      e.trackedContainer && e.trackedContainer.start()
    },
    end: function(b, e) {
      e.anchor.style.display = "none";
      e.trackedContainer && e.trackedContainer.stop()
    },
    _teardown: function(b) {
      if (b.trackedContainer) b.trackedContainer.destroy();
      else b.anchor.parentNode && b.anchor.parentNode.removeChild(b.anchor)
    }
  })
})(Popcorn);
(function(r) {
  var f = 1,
      n = false;
  r.plugin("googlefeed", function(c) {
    var b = function() {
      var j = false,
          p = 0,
          m = document.getElementsByTagName("link"),
          o = m.length,
          q = document.head || document.getElementsByTagName("head")[0],
          s = document.createElement("link");
      if (window.GFdynamicFeedControl) n = true;
      else r.getScript("//www.google.com/uds/solutions/dynamicfeed/gfdynamicfeedcontrol.js", function() {
        n = true
      });
      for (; p < o; p++) if (m[p].href === "//www.google.com/uds/solutions/dynamicfeed/gfdynamicfeedcontrol.css") j = true;
      if (!j) {
        s.type = "text/css";
        s.rel = "stylesheet";
        s.href = "//www.google.com/uds/solutions/dynamicfeed/gfdynamicfeedcontrol.css";
        q.insertBefore(s, q.firstChild)
      }
    };
    window.google ? b() : r.getScript("//www.google.com/jsapi", function() {
      google.load("feeds", "1", {
        callback: function() {
          b()
        }
      })
    });
    var e = document.createElement("div"),
        h = document.getElementById(c.target),
        i = function() {
        if (n) c.feed = new GFdynamicFeedControl(c.url, e, {
          vertical: c.orientation.toLowerCase() === "vertical" ? true : false,
          horizontal: c.orientation.toLowerCase() === "horizontal" ? true : false,
          title: c.title = c.title || "Blog"
        });
        else setTimeout(function() {
          i()
        }, 5)
        };
    if (!c.orientation || c.orientation.toLowerCase() !== "vertical" && c.orientation.toLowerCase() !== "horizontal") c.orientation = "vertical";
    e.style.display = "none";
    e.id = "_feed" + f;
    e.style.width = "100%";
    e.style.height = "100%";
    f++;
    h && h.appendChild(e);
    i();
    return {
      start: function() {
        e.setAttribute("style", "display:inline")
      },
      end: function() {
        e.setAttribute("style", "display:none")
      },
      _teardown: function(j) {
        document.getElementById(j.target) && document.getElementById(j.target).removeChild(e);
        delete j.feed
      }
    }
  }, {
    about: {
      name: "Popcorn Google Feed Plugin",
      version: "0.1",
      author: "David Seifried",
      website: "dseifried.wordpress.com"
    },
    options: {
      start: {
        elem: "input",
        type: "number",
        label: "Start"
      },
      end: {
        elem: "input",
        type: "number",
        label: "End"
      },
      target: "feed-container",
      url: {
        elem: "input",
        type: "url",
        label: "Feed URL",
        "default": "http://planet.mozilla.org/rss20.xml"
      },
      title: {
        elem: "input",
        type: "text",
        label: "Title",
        "default": "Planet Mozilla",
        optional: true
      },
      orientation: {
        elem: "select",
        options: ["Vertical", "Horizontal"],
        label: "Orientation",
        "default": "Vertical",
        optional: true
      }
    }
  })
})(Popcorn);
(function(r) {
  var f = 0,
      n = function(c, b) {
      var e = c.container = document.createElement("div"),
          h = e.style,
          i = c.media,
          j = function() {
          var p = c.position();
          h.fontSize = "18px";
          h.width = i.offsetWidth + "px";
          h.top = p.top + i.offsetHeight - e.offsetHeight - 40 + "px";
          h.left = p.left + "px";
          setTimeout(j, 10)
          };
      e.id = b || r.guid();
      h.position = "absolute";
      h.color = "white";
      h.textShadow = "black 2px 2px 6px";
      h.fontWeight = "bold";
      h.textAlign = "center";
      j();
      c.media.parentNode.appendChild(e);
      return e
      };
  r.plugin("subtitle", {
    manifest: {
      about: {
        name: "Popcorn Subtitle Plugin",
        version: "0.1",
        author: "Scott Downe",
        website: "http://scottdowne.wordpress.com/"
      },
      options: {
        start: {
          elem: "input",
          type: "text",
          label: "Start"
        },
        end: {
          elem: "input",
          type: "text",
          label: "End"
        },
        target: "subtitle-container",
        text: {
          elem: "input",
          type: "text",
          label: "Text"
        }
      }
    },
    _setup: function(c) {
      var b = document.createElement("div");
      b.id = "subtitle-" + f++;
      b.style.display = "none";
      !this.container && (!c.target || c.target === "subtitle-container") && n(this);
      c.container = c.target && c.target !== "subtitle-container" ? document.getElementById(c.target) || n(this, c.target) : this.container;
      document.getElementById(c.container.id) && document.getElementById(c.container.id).appendChild(b);
      c.innerContainer = b;
      c.showSubtitle = function() {
        c.innerContainer.innerHTML = c.text || ""
      }
    },
    start: function(c, b) {
      b.innerContainer.style.display = "inline";
      b.showSubtitle(b, b.text)
    },
    end: function(c, b) {
      b.innerContainer.style.display = "none";
      b.innerContainer.innerHTML = ""
    },
    _teardown: function(c) {
      c.container.removeChild(c.innerContainer)
    }
  })
})(Popcorn);
(function(r) {
  var f = false;
  r.plugin("twitter", {
    manifest: {
      about: {
        name: "Popcorn Twitter Plugin",
        version: "0.1",
        author: "Scott Downe",
        website: "http://scottdowne.wordpress.com/"
      },
      options: {
        start: {
          elem: "input",
          type: "number",
          label: "Start"
        },
        end: {
          elem: "input",
          type: "number",
          label: "End"
        },
        src: {
          elem: "input",
          type: "text",
          label: "Tweet Source (# or @)",
          "default": "@popcornjs"
        },
        target: "twitter-container",
        height: {
          elem: "input",
          type: "number",
          label: "Height",
          "default": "200",
          optional: true
        },
        width: {
          elem: "input",
          type: "number",
          label: "Width",
          "default": "250",
          optional: true
        }
      }
    },
    _setup: function(n) {
      if (!window.TWTR && !f) {
        f = true;
        r.getScript("//widgets.twimg.com/j/2/widget.js")
      }
      var c = document.getElementById(n.target);
      n.container = document.createElement("div");
      n.container.setAttribute("id", r.guid());
      n.container.style.display = "none";
      c && c.appendChild(n.container);
      var b = n.src || "";
      c = n.width || 250;
      var e = n.height || 200,
          h = /^@/.test(b),
          i = {
          version: 2,
          id: n.container.getAttribute("id"),
          rpp: 30,
          width: c,
          height: e,
          interval: 6E3,
          theme: {
            shell: {
              background: "#ffffff",
              color: "#000000"
            },
            tweets: {
              background: "#ffffff",
              color: "#444444",
              links: "#1985b5"
            }
          },
          features: {
            loop: true,
            timestamp: true,
            avatars: true,
            hashtags: true,
            toptweets: true,
            live: true,
            scrollbar: false,
            behavior: "default"
          }
          },
          j = function(p) {
          if (window.TWTR) if (h) {
            i.type = "profile";
            (new TWTR.Widget(i)).render().setUser(b).start()
          } else {
            i.type = "search";
            i.search = b;
            i.subject = b;
            (new TWTR.Widget(i)).render().start()
          } else setTimeout(function() {
            j(p)
          }, 1)
          };
      j(this)
    },
    start: function(n, c) {
      c.container.style.display = "inline"
    },
    end: function(n, c) {
      c.container.style.display = "none"
    },
    _teardown: function(n) {
      document.getElementById(n.target) && document.getElementById(n.target).removeChild(n.container)
    }
  })
})(Popcorn);
(function(r) {
  r.plugin("webpage", {
    manifest: {
      about: {
        name: "Popcorn Webpage Plugin",
        version: "0.1",
        author: "@annasob",
        website: "annasob.wordpress.com"
      },
      options: {
        id: {
          elem: "input",
          type: "text",
          label: "Id",
          optional: true
        },
        start: {
          elem: "input",
          type: "number",
          label: "Start"
        },
        end: {
          elem: "input",
          type: "number",
          label: "End"
        },
        src: {
          elem: "input",
          type: "url",
          label: "Webpage URL",
          "default": "http://mozillapopcorn.org"
        },
        target: "iframe-container"
      }
    },
    _setup: function(f) {
      var n = document.getElementById(f.target);
      f.src = f.src.replace(/^(https?:)?(\/\/)?/, "//");
      f._iframe = document.createElement("iframe");
      f._iframe.setAttribute("width", "100%");
      f._iframe.setAttribute("height", "100%");
      f._iframe.id = f.id;
      f._iframe.src = f.src;
      f._iframe.style.display = "none";
      n && n.appendChild(f._iframe)
    },
    start: function(f, n) {
      n._iframe.src = n.src;
      n._iframe.style.display = "inline"
    },
    end: function(f, n) {
      n._iframe.style.display = "none"
    },
    _teardown: function(f) {
      document.getElementById(f.target) && document.getElementById(f.target).removeChild(f._iframe)
    }
  })
})(Popcorn);
var wikiCallback;
(function(r) {
  r.plugin("wikipedia", {
    manifest: {
      about: {
        name: "Popcorn Wikipedia Plugin",
        version: "0.1",
        author: "@annasob",
        website: "annasob.wordpress.com"
      },
      options: {
        start: {
          elem: "input",
          type: "number",
          label: "Start"
        },
        end: {
          elem: "input",
          type: "number",
          label: "End"
        },
        lang: {
          elem: "input",
          type: "text",
          label: "Language",
          "default": "english",
          optional: true
        },
        src: {
          elem: "input",
          type: "url",
          label: "Wikipedia URL",
          "default": "http://en.wikipedia.org/wiki/Cat"
        },
        title: {
          elem: "input",
          type: "text",
          label: "Title",
          "default": "Cats",
          optional: true
        },
        numberofwords: {
          elem: "input",
          type: "number",
          label: "Number of Words",
          "default": "200",
          optional: true
        },
        target: "wikipedia-container"
      }
    },
    _setup: function(f) {
      var n, c = r.guid();
      if (!f.lang) f.lang = "en";
      f.numberofwords = f.numberofwords || 200;
      window["wikiCallback" + c] = function(b) {
        f._link = document.createElement("a");
        f._link.setAttribute("href", f.src);
        f._link.setAttribute("target", "_blank");
        f._link.innerHTML = f.title || b.parse.displaytitle;
        f._desc = document.createElement("p");
        n = b.parse.text["*"].substr(b.parse.text["*"].indexOf("<p>"));
        n = n.replace(/((<(.|\n)+?>)|(\((.*?)\) )|(\[(.*?)\]))/g, "");
        n = n.split(" ");
        f._desc.innerHTML = n.slice(0, n.length >= f.numberofwords ? f.numberofwords : n.length).join(" ") + " ...";
        f._fired = true
      };
      f.src && r.getScript("//" + f.lang + ".wikipedia.org/w/api.php?action=parse&props=text&redirects&page=" + f.src.slice(f.src.lastIndexOf("/") + 1) + "&format=json&callback=wikiCallback" + c)
    },
    start: function(f, n) {
      var c = function() {
        if (n._fired) {
          if (n._link && n._desc) if (document.getElementById(n.target)) {
            document.getElementById(n.target).appendChild(n._link);
            document.getElementById(n.target).appendChild(n._desc);
            n._added = true
          }
        } else setTimeout(function() {
          c()
        }, 13)
      };
      c()
    },
    end: function(f, n) {
      if (n._added) {
        document.getElementById(n.target).removeChild(n._link);
        document.getElementById(n.target).removeChild(n._desc)
      }
    },
    _teardown: function(f) {
      if (f._added) {
        f._link.parentNode && document.getElementById(f.target).removeChild(f._link);
        f._desc.parentNode && document.getElementById(f.target).removeChild(f._desc);
        delete f.target
      }
    }
  })
})(Popcorn);
(function(r) {
  r.plugin("mustache", function(f) {
    var n, c, b, e;
    r.getScript("http://mustache.github.com/extras/mustache.js");
    var h = !! f.dynamic,
        i = typeof f.template,
        j = typeof f.data,
        p = document.getElementById(f.target);
    f.container = p || document.createElement("div");
    if (i === "function") if (h) b = f.template;
    else e = f.template(f);
    else e = i === "string" ? f.template : "";
    if (j === "function") if (h) n = f.data;
    else c = f.data(f);
    else c = j === "string" ? JSON.parse(f.data) : j === "object" ? f.data : "";
    return {
      start: function(m, o) {
        var q = function() {
          if (window.Mustache) {
            if (n) c =
            n(o);
            if (b) e = b(o);
            var s = Mustache.to_html(e, c).replace(/^\s*/mg, "");
            o.container.innerHTML = s
          } else setTimeout(function() {
            q()
          }, 10)
        };
        q()
      },
      end: function(m, o) {
        o.container.innerHTML = ""
      },
      _teardown: function() {
        n = c = b = e = null
      }
    }
  }, {
    about: {
      name: "Popcorn Mustache Plugin",
      version: "0.1",
      author: "David Humphrey (@humphd)",
      website: "http://vocamus.net/dave"
    },
    options: {
      start: {
        elem: "input",
        type: "number",
        label: "Start"
      },
      end: {
        elem: "input",
        type: "number",
        label: "End"
      },
      target: "mustache-container",
      template: {
        elem: "input",
        type: "text",
        label: "Template"
      },
      data: {
        elem: "input",
        type: "text",
        label: "Data"
      },
      dynamic: {
        elem: "input",
        type: "checkbox",
        label: "Dynamic",
        "default": true
      }
    }
  })
})(Popcorn);
(function(r) {
  function f(c, b) {
    if (c.map) c.map.div.style.display = b;
    else setTimeout(function() {
      f(c, b)
    }, 10)
  }
  var n = 1;
  r.plugin("openmap", function(c) {
    var b, e, h, i, j, p, m, o, q = document.getElementById(c.target);
    b = document.createElement("div");
    b.id = "openmapdiv" + n;
    b.style.width = "100%";
    b.style.height = "100%";
    n++;
    q && q.appendChild(b);
    o = function() {
      if (window.OpenLayers && window.OpenLayers.Layer.Stamen) {
        if (c.location) {
          location = new OpenLayers.LonLat(0, 0);
          r.getJSONP("//tinygeocoder.com/create-api.php?q=" + c.location + "&callback=jsonp", function(d) {
            e = new OpenLayers.LonLat(d[1], d[0])
          })
        } else e = new OpenLayers.LonLat(c.lng, c.lat);
        c.type = c.type || "ROADMAP";
        switch (c.type) {
        case "SATELLITE":
          c.map = new OpenLayers.Map({
            div: b,
            maxResolution: 0.28125,
            tileSize: new OpenLayers.Size(512, 512)
          });
          var s = new OpenLayers.Layer.WorldWind("LANDSAT", "//worldwind25.arc.nasa.gov/tile/tile.aspx", 2.25, 4, {
            T: "105"
          });
          c.map.addLayer(s);
          i = new OpenLayers.Projection("EPSG:4326");
          h = new OpenLayers.Projection("EPSG:4326");
          break;
        case "TERRAIN":
          i = new OpenLayers.Projection("EPSG:4326");
          h = new OpenLayers.Projection("EPSG:4326");
          c.map = new OpenLayers.Map({
            div: b,
            projection: h
          });
          s = new OpenLayers.Layer.WMS("USGS Terraserver", "//terraserver-usa.org/ogcmap.ashx?", {
            layers: "DRG"
          });
          c.map.addLayer(s);
          break;
        case "STAMEN-TONER":
        case "STAMEN-WATERCOLOR":
        case "STAMEN-TERRAIN":
          s = c.type.replace("STAMEN-", "").toLowerCase();
          s = new OpenLayers.Layer.Stamen(s);
          i = new OpenLayers.Projection("EPSG:4326");
          h = new OpenLayers.Projection("EPSG:900913");
          e = e.transform(i, h);
          c.map = new OpenLayers.Map({
            div: b,
            projection: h,
            displayProjection: i,
            controls: [new OpenLayers.Control.Navigation, new OpenLayers.Control.PanPanel, new OpenLayers.Control.ZoomPanel]
          });
          c.map.addLayer(s);
          break;
        default:
          h = new OpenLayers.Projection("EPSG:900913");
          i = new OpenLayers.Projection("EPSG:4326");
          e = e.transform(i, h);
          c.map = new OpenLayers.Map({
            div: b,
            projection: h,
            displayProjection: i
          });
          s = new OpenLayers.Layer.OSM;
          c.map.addLayer(s)
        }
        if (c.map) {
          c.map.setCenter(e, c.zoom || 10);
          c.map.div.style.display = "none"
        }
      } else setTimeout(function() {
        o()
      }, 50)
    };
    o();
    return {
      _setup: function(s) {
        window.OpenLayers || r.getScript("//openlayers.org/api/OpenLayers.js", function() {
          r.getScript("//maps.stamen.com/js/tile.stamen.js")
        });
        var d = function() {
          if (s.map) {
            s.zoom = s.zoom || 2;
            if (s.zoom && typeof s.zoom !== "number") s.zoom = +s.zoom;
            s.map.setCenter(e, s.zoom);
            if (s.markers) {
              var A = OpenLayers.Util.extend({}, OpenLayers.Feature.Vector.style["default"]),
                  y = function(v) {
                  clickedFeature = v.feature;
                  if (clickedFeature.attributes.text) {
                    m = new OpenLayers.Popup.FramedCloud("featurePopup", clickedFeature.geometry.getBounds().getCenterLonLat(), new OpenLayers.Size(120, 250), clickedFeature.attributes.text, null, true, function() {
                      p.unselect(this.feature)
                    });
                    clickedFeature.popup = m;
                    m.feature = clickedFeature;
                    s.map.addPopup(m)
                  }
                  },
                  x = function(v) {
                  feature = v.feature;
                  if (feature.popup) {
                    m.feature = null;
                    s.map.removePopup(feature.popup);
                    feature.popup.destroy();
                    feature.popup = null
                  }
                  },
                  a = function(v) {
                  r.getJSONP("//tinygeocoder.com/create-api.php?q=" + v.location + "&callback=jsonp", function(z) {
                    z = (new OpenLayers.Geometry.Point(z[1], z[0])).transform(i, h);
                    var C = OpenLayers.Util.extend({}, A);
                    if (!v.size || isNaN(v.size)) v.size = 14;
                    C.pointRadius = v.size;
                    C.graphicOpacity = 1;
                    C.externalGraphic = v.icon;
                    z = new OpenLayers.Feature.Vector(z, null, C);
                    if (v.text) z.attributes = {
                      text: v.text
                    };
                    j.addFeatures([z])
                  })
                  };
              j = new OpenLayers.Layer.Vector("Point Layer", {
                style: A
              });
              s.map.addLayer(j);
              for (var g = 0, l = s.markers.length; g < l; g++) {
                var k = s.markers[g];
                if (k.text) if (!p) {
                  p = new OpenLayers.Control.SelectFeature(j);
                  s.map.addControl(p);
                  p.activate();
                  j.events.on({
                    featureselected: y,
                    featureunselected: x
                  })
                }
                if (k.location) a(k);
                else {
                  var t = (new OpenLayers.Geometry.Point(k.lng, k.lat)).transform(i, h),
                      u = OpenLayers.Util.extend({}, A);
                  if (!k.size || isNaN(k.size)) k.size = 14;
                  u.pointRadius = k.size;
                  u.graphicOpacity = 1;
                  u.externalGraphic = k.icon;
                  t = new OpenLayers.Feature.Vector(t, null, u);
                  if (k.text) t.attributes = {
                    text: k.text
                  };
                  j.addFeatures([t])
                }
              }
            }
          } else setTimeout(function() {
            d()
          }, 13)
        };
        d()
      },
      start: function(s, d) {
        f(d, "block")
      },
      end: function(s, d) {
        f(d, "none")
      },
      _teardown: function() {
        q && q.removeChild(b);
        b = map = e = h = i = j = p = m = null
      }
    }
  }, {
    about: {
      name: "Popcorn OpenMap Plugin",
      version: "0.3",
      author: "@mapmeld",
      website: "mapadelsur.blogspot.com"
    },
    options: {
      start: {
        elem: "input",
        type: "number",
        label: "Start"
      },
      end: {
        elem: "input",
        type: "number",
        label: "End"
      },
      target: "map-container",
      type: {
        elem: "select",
        options: ["ROADMAP", "SATELLITE", "TERRAIN"],
        label: "Map Type",
        optional: true
      },
      zoom: {
        elem: "input",
        type: "number",
        label: "Zoom",
        "default": 2
      },
      lat: {
        elem: "input",
        type: "text",
        label: "Lat",
        optional: true
      },
      lng: {
        elem: "input",
        type: "text",
        label: "Lng",
        optional: true
      },
      location: {
        elem: "input",
        type: "text",
        label: "Location",
        "default": "Toronto, Ontario, Canada"
      },
      markers: {
        elem: "input",
        type: "text",
        label: "List Markers",
        optional: true
      }
    }
  })
})(Popcorn);
document.addEventListener("click", function(r) {
  r = r.target;
  if (r.nodeName === "A" || r.parentNode && r.parentNode.nodeName === "A") Popcorn.instances.forEach(function(f) {
    f.options.pauseOnLinkClicked && f.pause()
  })
}, false);
(function(r) {
  var f = {},
      n = 0,
      c = document.createElement("span"),
      b = ["webkit", "Moz", "ms", "O", ""],
      e = ["Transform", "TransitionDuration", "TransitionTimingFunction"],
      h = {},
      i;
  document.getElementsByTagName("head")[0].appendChild(c);
  for (var j = 0, p = e.length; j < p; j++) for (var m = 0, o = b.length; m < o; m++) {
    i = b[m] + e[j];
    if (i in c.style) {
      h[e[j].toLowerCase()] = i;
      break
    }
  }
  document.getElementsByTagName("head")[0].appendChild(c);
  r.plugin("wordriver", {
    manifest: {
      about: {
        name: "Popcorn WordRiver Plugin"
      },
      options: {
        start: {
          elem: "input",
          type: "number",
          label: "Start"
        },
        end: {
          elem: "input",
          type: "number",
          label: "End"
        },
        target: "wordriver-container",
        text: {
          elem: "input",
          type: "text",
          label: "Text",
          "default": "Popcorn.js"
        },
        color: {
          elem: "input",
          type: "text",
          label: "Color",
          "default": "Green",
          optional: true
        }
      }
    },
    _setup: function(q) {
      q._duration = q.end - q.start;
      var s;
      if (!(s = f[q.target])) {
        s = q.target;
        f[s] = document.createElement("div");
        var d = document.getElementById(s);
        d && d.appendChild(f[s]);
        f[s].style.height = "100%";
        f[s].style.position = "relative";
        s = f[s]
      }
      q._container = s;
      q.word = document.createElement("span");
      q.word.style.position = "absolute";
      q.word.style.whiteSpace = "nowrap";
      q.word.style.opacity = 0;
      q.word.style.MozTransitionProperty = "opacity, -moz-transform";
      q.word.style.webkitTransitionProperty = "opacity, -webkit-transform";
      q.word.style.OTransitionProperty = "opacity, -o-transform";
      q.word.style.transitionProperty = "opacity, transform";
      q.word.style[h.transitionduration] = "1s, " + q._duration + "s";
      q.word.style[h.transitiontimingfunction] = "linear";
      q.word.innerHTML = q.text;
      q.word.style.color = q.color || "black"
    },
    start: function(q, s) {
      s._container.appendChild(s.word);
      s.word.style[h.transform] = "";
      s.word.style.fontSize = ~~ (30 + 20 * Math.random()) + "px";
      n %= s._container.offsetWidth - s.word.offsetWidth;
      s.word.style.left = n + "px";
      n += s.word.offsetWidth + 10;
      s.word.style[h.transform] = "translateY(" + (s._container.offsetHeight - s.word.offsetHeight) + "px)";
      s.word.style.opacity = 1;
      setTimeout(function() {
        s.word.style.opacity = 0
      }, (s.end - s.start - 1 || 1) * 1E3)
    },
    end: function(q, s) {
      s.word.style.opacity = 0
    },
    _teardown: function(q) {
      var s = document.getElementById(q.target);
      q.word.parentNode && q._container.removeChild(q.word);
      f[q.target] && !f[q.target].childElementCount && s && s.removeChild(f[q.target]) && delete f[q.target]
    }
  })
})(Popcorn);
(function(r) {
  var f = 1;
  r.plugin("timeline", function(n) {
    var c = document.getElementById(n.target),
        b = document.createElement("div"),
        e, h = true;
    if (c && !c.firstChild) {
      c.appendChild(e = document.createElement("div"));
      e.style.width = "inherit";
      e.style.height = "inherit";
      e.style.overflow = "auto"
    } else e = c.firstChild;
    b.style.display = "none";
    b.id = "timelineDiv" + f;
    n.direction = n.direction || "up";
    if (n.direction.toLowerCase() === "down") h = false;
    if (c && e) h ? e.insertBefore(b, e.firstChild) : e.appendChild(b);
    f++;
    b.innerHTML = "<p><span id='big' style='font-size:24px; line-height: 130%;' >" + n.title + "</span><br /><span id='mid' style='font-size: 16px;'>" + n.text + "</span><br />" + n.innerHTML;
    return {
      start: function(i, j) {
        b.style.display = "block";
        if (j.direction === "down") e.scrollTop = e.scrollHeight
      },
      end: function() {
        b.style.display = "none"
      },
      _teardown: function() {
        e && b && e.removeChild(b) && !e.firstChild && c.removeChild(e)
      }
    }
  }, {
    about: {
      name: "Popcorn Timeline Plugin",
      version: "0.1",
      author: "David Seifried @dcseifried",
      website: "dseifried.wordpress.com"
    },
    options: {
      start: {
        elem: "input",
        type: "number",
        label: "Start"
      },
      end: {
        elem: "input",
        type: "number",
        label: "End"
      },
      target: "feed-container",
      title: {
        elem: "input",
        type: "text",
        label: "Title"
      },
      text: {
        elem: "input",
        type: "text",
        label: "Text"
      },
      innerHTML: {
        elem: "input",
        type: "text",
        label: "HTML Code",
        optional: true
      },
      direction: {
        elem: "select",
        options: ["DOWN", "UP"],
        label: "Direction",
        optional: true
      }
    }
  })
})(Popcorn);
(function(r, f) {
  var n = {};
  r.plugin("documentcloud", {
    manifest: {
      about: {
        name: "Popcorn Document Cloud Plugin",
        version: "0.1",
        author: "@humphd, @ChrisDeCairos",
        website: "http://vocamus.net/dave"
      },
      options: {
        start: {
          elem: "input",
          type: "number",
          label: "Start"
        },
        end: {
          elem: "input",
          type: "number",
          label: "End"
        },
        target: "documentcloud-container",
        width: {
          elem: "input",
          type: "text",
          label: "Width",
          optional: true
        },
        height: {
          elem: "input",
          type: "text",
          label: "Height",
          optional: true
        },
        src: {
          elem: "input",
          type: "url",
          label: "PDF URL",
          "default": "http://www.documentcloud.org/documents/70050-urbina-day-1-in-progress.html"
        },
        preload: {
          elem: "input",
          type: "checkbox",
          label: "Preload",
          "default": true
        },
        page: {
          elem: "input",
          type: "number",
          label: "Page Number",
          optional: true
        },
        aid: {
          elem: "input",
          type: "number",
          label: "Annotation Id",
          optional: true
        }
      }
    },
    _setup: function(c) {
      function b() {
        function m(v) {
          c._key = v.api.getId();
          c._changeView = function(z) {
            c.aid ? z.pageSet.showAnnotation(z.api.getAnnotation(c.aid)) : z.api.setCurrentPage(c.page)
          }
        }
        function o() {
          n[c._key] = {
            num: 1,
            id: c._containerId
          };
          h.loaded = true
        }
        h.loaded = false;
        var q = c.url.replace(/\.html$/, ".js"),
            s = c.target,
            d = f.getElementById(s),
            A = f.createElement("div"),
            y = r.position(d),
            x = c.width || y.width;
        y = c.height || y.height;
        var a = c.sidebar || true,
            g = c.text || true,
            l = c.pdf || true,
            k = c.showAnnotations || true,
            t = c.zoom || 700,
            u = c.search || true;
        if (!
        function(v) {
          var z = false;
          r.forEach(h.viewers, function(C) {
            if (C.api.getSchema().canonicalURL === v) {
              m(C);
              C = n[c._key];
              c._containerId = C.id;
              C.num += 1;
              z = true;
              h.loaded = true
            }
          });
          return z
        }(c.url)) {
          A.id = c._containerId = r.guid(s);
          s = "#" + A.id;
          d.appendChild(A);
          i.trigger("documentready");
          h.load(q, {
            width: x,
            height: y,
            sidebar: a,
            text: g,
            pdf: l,
            showAnnotations: k,
            zoom: t,
            search: u,
            container: s,
            afterLoad: c.page || c.aid ?
            function(v) {
              m(v);
              c._changeView(v);
              A.style.visibility = "hidden";
              v.elements.pages.hide();
              o()
            } : function(v) {
              m(v);
              o();
              A.style.visibility = "hidden";
              v.elements.pages.hide()
            }
          })
        }
      }
      function e() {
        window.DV.loaded ? b() : setTimeout(e, 25)
      }
      var h = window.DV = window.DV || {},
          i = this;
      if (h.loading) e();
      else {
        h.loading = true;
        h.recordHit = "//www.documentcloud.org/pixel.gif";
        var j = f.createElement("link"),
            p = f.getElementsByTagName("head")[0];
        j.rel = "stylesheet";
        j.type = "text/css";
        j.media = "screen";
        j.href = "//s3.documentcloud.org/viewer/viewer-datauri.css";
        p.appendChild(j);
        h.loaded = false;
        r.getScript("http://s3.documentcloud.org/viewer/viewer.js", function() {
          h.loading = false;
          b()
        })
      }
    },
    start: function(c, b) {
      var e = f.getElementById(b._containerId),
          h = DV.viewers[b._key];
      (b.page || b.aid) && h && b._changeView(h);
      if (e && h) {
        e.style.visibility = "visible";
        h.elements.pages.show()
      }
    },
    end: function(c, b) {
      var e = f.getElementById(b._containerId);
      if (e && DV.viewers[b._key]) {
        e.style.visibility = "hidden";
        DV.viewers[b._key].elements.pages.hide()
      }
    },
    _teardown: function(c) {
      var b = f.getElementById(c._containerId);
      if ((c = c._key) && DV.viewers[c] && --n[c].num === 0) {
        for (DV.viewers[c].api.unload(); b.hasChildNodes();) b.removeChild(b.lastChild);
        b.parentNode.removeChild(b)
      }
    }
  })
})(Popcorn, window.document);
(function(r) {
  r.parser("parseJSON", "JSON", function(f) {
    var n = {
      title: "",
      remote: "",
      data: []
    };
    r.forEach(f.data, function(c) {
      n.data.push(c)
    });
    return n
  })
})(Popcorn);
(function(r) {
  r.parser("parseSBV", function(f) {
    var n = {
      title: "",
      remote: "",
      data: []
    },
        c = [],
        b = 0,
        e = 0,
        h = function(q) {
        q = q.split(":");
        var s = q.length - 1,
            d;
        try {
          d = parseInt(q[s - 1], 10) * 60 + parseFloat(q[s], 10);
          if (s === 2) d += parseInt(q[0], 10) * 3600
        } catch (A) {
          throw "Bad cue";
        }
        return d
        },
        i = function(q, s) {
        var d = {};
        d[q] = s;
        return d
        };
    f = f.text.split(/(?:\r\n|\r|\n)/gm);
    for (e = f.length; b < e;) {
      var j = {},
          p = [],
          m = f[b++].split(",");
      try {
        j.start = h(m[0]);
        for (j.end = h(m[1]); b < e && f[b];) p.push(f[b++]);
        j.text = p.join("<br />");
        c.push(i("subtitle", j))
      } catch (o) {
        for (; b < e && f[b];) b++
      }
      for (; b < e && !f[b];) b++
    }
    n.data = c;
    return n
  })
})(Popcorn);
(function(r) {
  function f(c, b) {
    var e = {};
    e[c] = b;
    return e
  }
  function n(c) {
    c = c.split(":");
    try {
      var b = c[2].split(",");
      if (b.length === 1) b = c[2].split(".");
      return parseFloat(c[0], 10) * 3600 + parseFloat(c[1], 10) * 60 + parseFloat(b[0], 10) + parseFloat(b[1], 10) / 1E3
    } catch (e) {
      return 0
    }
  }
  r.parser("parseSRT", function(c) {
    var b = {
      title: "",
      remote: "",
      data: []
    },
        e = [],
        h = 0,
        i = 0,
        j, p, m, o;
    c = c.text.split(/(?:\r\n|\r|\n)/gm);
    for (h = c.length - 1; h >= 0 && !c[h];) h--;
    m = h + 1;
    for (h = 0; h < m; h++) {
      o = {};
      p = [];
      o.id = parseInt(c[h++], 10);
      j = c[h++].split(/[\t ]*--\>[\t ]*/);
      o.start = n(j[0]);
      i = j[1].indexOf(" ");
      if (i !== -1) j[1] = j[1].substr(0, i);
      for (o.end = n(j[1]); h < m && c[h];) p.push(c[h++]);
      o.text = p.join("\\N").replace(/\{(\\[\w]+\(?([\w\d]+,?)+\)?)+\}/gi, "");
      o.text = o.text.replace(/</g, "&lt;").replace(/>/g, "&gt;");
      o.text = o.text.replace(/&lt;(\/?(font|b|u|i|s))((\s+(\w|\w[\w\-]*\w)(\s*=\s*(?:\".*?\"|'.*?'|[^'\">\s]+))?)+\s*|\s*)(\/?)&gt;/gi, "<$1$3$7>");
      o.text = o.text.replace(/\\N/gi, "<br />");
      e.push(f("subtitle", o))
    }
    b.data = e;
    return b
  })
})(Popcorn);
(function(r) {
  function f(b, e) {
    var h = b.substr(10).split(","),
        i;
    i = {
      start: n(h[e.start]),
      end: n(h[e.end])
    };
    if (i.start === -1 || i.end === -1) throw "Invalid time";
    var j = q.call(m, /\{(\\[\w]+\(?([\w\d]+,?)+\)?)+\}/gi, ""),
        p = j.replace,
        m;
    m = h.length;
    q = [];
    for (var o = e.text; o < m; o++) q.push(h[o]);
    m = q.join(",");
    var q = m.replace;
    i.text = p.call(j, /\\N/gi, "<br />");
    return i
  }
  function n(b) {
    var e = b.split(":");
    if (b.length !== 10 || e.length < 3) return -1;
    return parseInt(e[0], 10) * 3600 + parseInt(e[1], 10) * 60 + parseFloat(e[2], 10)
  }
  function c(b, e) {
    var h = {};
    h[b] = e;
    return h
  }
  r.parser("parseSSA", function(b) {
    var e = {
      title: "",
      remote: "",
      data: []
    },
        h = [],
        i = 0,
        j;
    b = b.text.split(/(?:\r\n|\r|\n)/gm);
    for (j = b.length; i < j && b[i] !== "[Events]";) i++;
    var p = b[++i].substr(8).split(", "),
        m = {},
        o, q;
    q = 0;
    for (o = p.length; q < o; q++) if (p[q] === "Start") m.start = q;
    else if (p[q] === "End") m.end = q;
    else if (p[q] === "Text") m.text = q;
    for (; ++i < j && b[i] && b[i][0] !== "[";) try {
      h.push(c("subtitle", f(b[i], m)))
    } catch (s) {}
    e.data = h;
    return e
  })
})(Popcorn);
(function(r) {
  function f(i, j, p) {
    var m = i.firstChild;
    i = n(i, p);
    p = [];
    for (var o; m;) {
      if (m.nodeType === 1) if (m.nodeName === "p") p.push(c(m, j, i));
      else if (m.nodeName === "div") {
        o = b(m.getAttribute("begin"));
        if (o < 0) o = j;
        p.push.apply(p, f(m, o, i))
      }
      m = m.nextSibling
    }
    return p
  }
  function n(i, j) {
    var p = i.getAttribute("region");
    return p !== null ? p : j || ""
  }
  function c(i, j, p) {
    var m = {};
    m.text = (i.textContent || i.text).replace(e, "").replace(h, "<br />");
    m.id = i.getAttribute("xml:id") || i.getAttribute("id");
    m.start = b(i.getAttribute("begin"), j);
    m.end = b(i.getAttribute("end"), j);
    m.target = n(i, p);
    if (m.end < 0) {
      m.end = b(i.getAttribute("duration"), 0);
      if (m.end >= 0) m.end += m.start;
      else m.end = Number.MAX_VALUE
    }
    return {
      subtitle: m
    }
  }
  function b(i, j) {
    var p;
    if (!i) return -1;
    try {
      return r.util.toSeconds(i)
    } catch (m) {
      for (var o = i.length - 1; o >= 0 && i[o] <= "9" && i[o] >= "0";) o--;
      p = o;
      o = parseFloat(i.substring(0, p));
      p = i.substring(p);
      return o * ({
        h: 3600,
        m: 60,
        s: 1,
        ms: 0.0010
      }[p] || -1) + (j || 0)
    }
  }
  var e = /^[\s]+|[\s]+$/gm,
      h = /(?:\r\n|\r|\n)/gm;
  r.parser("parseTTML", function(i) {
    var j = {
      title: "",
      remote: "",
      data: []
    };
    if (!i.xml || !i.xml.documentElement) return j;
    i = i.xml.documentElement.firstChild;
    if (!i) return j;
    for (; i.nodeName !== "body";) i = i.nextSibling;
    if (i) j.data = f(i, 0);
    return j
  })
})(Popcorn);
(function(r) {
  r.parser("parseTTXT", function(f) {
    var n = {
      title: "",
      remote: "",
      data: []
    },
        c = function(j) {
        j = j.split(":");
        var p = 0;
        try {
          return parseFloat(j[0], 10) * 60 * 60 + parseFloat(j[1], 10) * 60 + parseFloat(j[2], 10)
        } catch (m) {
          p = 0
        }
        return p
        },
        b = function(j, p) {
        var m = {};
        m[j] = p;
        return m
        };
    f = f.xml.lastChild.lastChild;
    for (var e = Number.MAX_VALUE, h = []; f;) {
      if (f.nodeType === 1 && f.nodeName === "TextSample") {
        var i = {};
        i.start = c(f.getAttribute("sampleTime"));
        i.text = f.getAttribute("text");
        if (i.text) {
          i.end = e - 0.0010;
          h.push(b("subtitle", i))
        }
        e =
        i.start
      }
      f = f.previousSibling
    }
    n.data = h.reverse();
    return n
  })
})(Popcorn);
(function(r) {
  function f(c) {
    var b = c.split(":");
    c = c.length;
    var e;
    if (c !== 12 && c !== 9) throw "Bad cue";
    c = b.length - 1;
    try {
      e = parseInt(b[c - 1], 10) * 60 + parseFloat(b[c], 10);
      if (c === 2) e += parseInt(b[0], 10) * 3600
    } catch (h) {
      throw "Bad cue";
    }
    return e
  }
  function n(c, b) {
    var e = {};
    e[c] = b;
    return e
  }
  r.parser("parseVTT", function(c) {
    var b = {
      title: "",
      remote: "",
      data: []
    },
        e = [],
        h = 0,
        i = 0,
        j, p;
    c = c.text.split(/(?:\r\n|\r|\n)/gm);
    i = c.length;
    if (i === 0 || c[0] !== "WEBVTT") return b;
    for (h++; h < i;) {
      j = [];
      try {
        for (var m = h; m < i && !c[m];) m++;
        h = m;
        var o = c[h++];
        m =
        void 0;
        var q = {};
        if (!o || o.indexOf("--\>") === -1) throw "Bad cue";
        m = o.replace(/--\>/, " --\> ").split(/[\t ]+/);
        if (m.length < 2) throw "Bad cue";
        q.id = o;
        q.start = f(m[0]);
        q.end = f(m[2]);
        for (p = q; h < i && c[h];) j.push(c[h++]);
        p.text = j.join("<br />");
        e.push(n("subtitle", p))
      } catch (s) {
        for (h = h; h < i && c[h];) h++;
        h = h
      }
    }
    b.data = e;
    return b
  })
})(Popcorn);
(function(r) {
  r.parser("parseXML", "XML", function(f) {
    var n = {
      title: "",
      remote: "",
      data: []
    },
        c = {},
        b = function(m) {
        m = m.split(":");
        if (m.length === 1) return parseFloat(m[0], 10);
        else if (m.length === 2) return parseFloat(m[0], 10) + parseFloat(m[1] / 12, 10);
        else if (m.length === 3) return parseInt(m[0] * 60, 10) + parseFloat(m[1], 10) + parseFloat(m[2] / 12, 10);
        else if (m.length === 4) return parseInt(m[0] * 3600, 10) + parseInt(m[1] * 60, 10) + parseFloat(m[2], 10) + parseFloat(m[3] / 12, 10)
        },
        e = function(m) {
        for (var o = {}, q = 0, s = m.length; q < s; q++) {
          var d = m.item(q).nodeName,
              A = m.item(q).nodeValue,
              y = c[A];
          if (d === "in") o.start = b(A);
          else if (d === "out") o.end = b(A);
          else if (d === "resourceid") for (var x in y) {
            if (y.hasOwnProperty(x)) if (!o[x] && x !== "id") o[x] = y[x]
          } else o[d] = A
        }
        return o
        },
        h = function(m, o) {
        var q = {};
        q[m] = o;
        return q
        },
        i = function(m, o, q) {
        var s = {};
        r.extend(s, o, e(m.attributes), {
          text: m.textContent || m.text
        });
        o = m.childNodes;
        if (o.length < 1 || o.length === 1 && o[0].nodeType === 3) if (q) c[s.id] = s;
        else n.data.push(h(m.nodeName, s));
        else
        for (m = 0; m < o.length; m++) o[m].nodeType === 1 && i(o[m], s, q)
        };
    f = f.documentElement.childNodes;
    for (var j = 0, p = f.length; j < p; j++) if (f[j].nodeType === 1) f[j].nodeName === "manifest" ? i(f[j], {}, true) : i(f[j], {}, false);
    return n
  })
})(Popcorn);
(function() {
  var r = false,
      f = false;
  Popcorn.player("soundcloud", {
    _canPlayType: function(n, c) {
      return /(?:http:\/\/www\.|http:\/\/|www\.|\.|^)(soundcloud)/.test(c) && n.toLowerCase() !== "video"
    },
    _setup: function(n) {
      function c() {
        r = true;
        SC.initialize({
          client_id: "PRaNFlda6Bhf5utPjUsptg"
        });
        SC.get("/resolve", {
          url: e.src
        }, function(A) {
          e.width = e.style.width ? "" + e.offsetWidth : "560";
          e.height = e.style.height ? "" + e.offsetHeight : "315";
          h.scrolling = "no";
          h.frameborder = "no";
          h.id = "soundcloud-" + Popcorn.guid();
          h.src = "http://w.soundcloud.com/player/?url=" + A.uri + "&show_artwork=false&buying=false&liking=false&sharing=false";
          h.width = "100%";
          h.height = "100%";
          n.loadListener = function() {
            n.widget = o = SC.Widget(h.id);
            o.bind(SC.Widget.Events.FINISH, function() {
              e.pause();
              e.dispatchEvent("ended")
            });
            o.bind(SC.Widget.Events.PLAY_PROGRESS, function(y) {
              j = y.currentPosition / 1E3;
              e.dispatchEvent("timeupdate")
            });
            o.bind(SC.Widget.Events.PLAY, function() {
              p = m = false;
              e.dispatchEvent("play");
              e.dispatchEvent("playing");
              e.currentTime = j;
              d.next()
            });
            o.bind(SC.Widget.Events.PAUSE, function() {
              p =
              m = true;
              e.dispatchEvent("pause");
              d.next()
            });
            o.bind(SC.Widget.Events.READY, function() {
              o.getDuration(function(y) {
                q = y / 1E3;
                e.style.visibility = "visible";
                e.dispatchEvent("durationchange");
                e.readyState = 4;
                e.dispatchEvent("readystatechange");
                e.dispatchEvent("loadedmetadata");
                e.dispatchEvent("loadeddata");
                e.dispatchEvent("canplaythrough");
                e.dispatchEvent("load");
                !e.paused && e.play()
              });
              o.getVolume(function(y) {
                i = y / 100
              })
            })
          };
          h.addEventListener("load", n.loadListener, false);
          e.appendChild(h)
        })
      }
      function b() {
        if (f)(function A() {
          setTimeout(function() {
            r ? c() : A()
          }, 100)
        })();
        else {
          f = true;
          Popcorn.getScript("http://w.soundcloud.com/player/api.js", function() {
            Popcorn.getScript("http://connect.soundcloud.com/sdk.js", function() {
              c()
            })
          })
        }
      }
      var e = this,
          h = document.createElement("iframe"),
          i = 1,
          j = 0,
          p = true,
          m = true,
          o, q = 0,
          s = false,
          d = Popcorn.player.playerQueue();
      n._container = h;
      e.style.visibility = "hidden";
      e.play = function() {
        p = false;
        d.add(function() {
          if (m) o && o.play();
          else d.next()
        })
      };
      e.pause = function() {
        p = true;
        d.add(function() {
          if (m) d.next();
          else o && o.pause()
        })
      };
      Object.defineProperties(e, {
        muted: {
          set: function(A) {
            if (A) {
              o && o.getVolume(function(y) {
                i = y / 100
              });
              o && o.setVolume(0);
              s = true
            } else {
              o && o.setVolume(i * 100);
              s = false
            }
            e.dispatchEvent("volumechange")
          },
          get: function() {
            return s
          }
        },
        volume: {
          set: function(A) {
            o && o.setVolume(A * 100);
            i = A;
            e.dispatchEvent("volumechange")
          },
          get: function() {
            return s ? 0 : i
          }
        },
        currentTime: {
          set: function(A) {
            j = A;
            o && o.seekTo(A * 1E3);
            e.dispatchEvent("seeked");
            e.dispatchEvent("timeupdate")
          },
          get: function() {
            return j
          }
        },
        duration: {
          get: function() {
            return q
          }
        },
        paused: {
          get: function() {
            return p
          }
        }
      });
      r ? c() : b()
    },
    _teardown: function(n) {
      var c = n.widget,
          b = SC.Widget.Events,
          e = n._container;
      n.destroyed = true;
      if (c) for (var h in b) c && c.unbind(b[h]);
      else e.removeEventListener("load", n.loadEventListener, false)
    }
  })
})();
(function() {
  function r(n) {
    var c = r.options;
    n = c.parser[c.strictMode ? "strict" : "loose"].exec(n);
    for (var b = {}, e = 14; e--;) b[c.key[e]] = n[e] || "";
    b[c.q.name] = {};
    b[c.key[12]].replace(c.q.parser, function(h, i, j) {
      if (i) b[c.q.name][i] = j
    });
    return b
  }
  function f(n, c) {
    return /player.vimeo.com\/video\/\d+/.test(c) || /vimeo.com\/\d+/.test(c)
  }
  r.options = {
    strictMode: false,
    key: ["source", "protocol", "authority", "userInfo", "user", "password", "host", "port", "relative", "path", "directory", "file", "query", "anchor"],
    q: {
      name: "queryKey",
      parser: /(?:^|&)([^&=]*)=?([^&]*)/g
    },
    parser: {
      strict: /^(?:([^:\/?#]+):)?(?:\/\/((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?))?((((?:[^?#\/]*\/)*)([^?#]*))(?:\?([^#]*))?(?:#(.*))?)/,
      loose: /^(?:(?![^:@]+:[^:@\/]*@)([^:\/?#.]+):)?(?:\/\/)?((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/
    }
  };
  Popcorn.player("vimeo", {
    _canPlayType: f,
    _setup: function(n) {
      function c(l, k) {
        var t = y.src.split("?")[0],
            u = JSON.stringify({
            method: l,
            value: k
          });
        if (t.substr(0, 2) === "//") t = window.location.protocol + t;
        y.contentWindow ? y.contentWindow.postMessage(u, t) : o.unload()
      }
      function b(l) {
        if (l.origin === "http://player.vimeo.com") {
          var k;
          try {
            k = JSON.parse(l.data)
          } catch (t) {
            console.warn(t)
          }
          if (k.player_id == m) {
            k.method && a[k.method] && a[k.method](k);
            k.event && g[k.event] && g[k.event](k)
          }
        }
      }
      function e() {
        d || (d = setInterval(function() {
          o.dispatchEvent("timeupdate")
        }, i));
        s || (s = setInterval(function() {
          c("getCurrentTime")
        }, j))
      }
      function h() {
        if (d) {
          clearInterval(d);
          d = 0
        }
        if (s) {
          clearInterval(s);
          s = 0
        }
      }
      var i = 250,
          j = 16,
          p = {
          MEDIA_ERR_ABORTED: 1,
          MEDIA_ERR_NETWORK: 2,
          MEDIA_ERR_DECODE: 3,
          MEDIA_ERR_SRC_NOT_SUPPORTED: 4
          },
          m, o = this,
          q = {
          q: [],
          queue: function(l) {
            this.q.push(l);
            this.process()
          },
          process: function() {
            if (A) for (; this.q.length;) this.q.shift()()
          }
          },
          s, d, A, y = document.createElement("iframe"),
          x = {
          error: null,
          src: o.src,
          NETWORK_EMPTY: 0,
          NETWORK_IDLE: 1,
          NETWORK_LOADING: 2,
          NETWORK_NO_SOURCE: 3,
          networkState: 0,
          HAVE_NOTHING: 0,
          HAVE_METADATA: 1,
          HAVE_CURRENT_DATA: 2,
          HAVE_FUTURE_DATA: 3,
          HAVE_ENOUGH_DATA: 4,
          readyState: 0,
          seeking: false,
          currentTime: 0,
          duration: NaN,
          paused: true,
          ended: false,
          autoplay: false,
          loop: false,
          volume: 1,
          muted: false,
          width: 0,
          height: 0
          };
      Popcorn.forEach("error networkState readyState seeking duration paused ended".split(" "), function(l) {
        Object.defineProperty(o, l, {
          get: function() {
            return x[l]
          }
        })
      });
      Object.defineProperties(o, {
        src: {
          get: function() {
            return x.src
          },
          set: function(l) {
            x.src = l;
            o.load()
          }
        },
        currentTime: {
          get: function() {
            return x.currentTime
          },
          set: function(l) {
            q.queue(function() {
              c("seekTo", l)
            });
            x.seeking = true;
            o.dispatchEvent("seeking")
          }
        },
        autoplay: {
          get: function() {
            return x.autoplay
          },
          set: function(l) {
            x.autoplay = !! l
          }
        },
        loop: {
          get: function() {
            return x.loop
          },
          set: function(l) {
            x.loop = !! l;
            q.queue(function() {
              c("setLoop", loop)
            })
          }
        },
        volume: {
          get: function() {
            return x.volume
          },
          set: function(l) {
            x.volume = l;
            q.queue(function() {
              c("setVolume", x.muted ? 0 : x.volume)
            });
            o.dispatchEvent("volumechange")
          }
        },
        muted: {
          get: function() {
            return x.muted
          },
          set: function(l) {
            x.muted = !! l;
            q.queue(function() {
              c("setVolume", x.muted ? 0 : x.volume)
            });
            o.dispatchEvent("volumechange")
          }
        },
        width: {
          get: function() {
            return y.width
          },
          set: function(l) {
            y.width = l
          }
        },
        height: {
          get: function() {
            return y.height
          },
          set: function(l) {
            y.height = l
          }
        }
      });
      var a = {
        getCurrentTime: function(l) {
          x.currentTime = parseFloat(l.value)
        },
        getDuration: function(l) {
          x.duration = parseFloat(l.value);
          if (!isNaN(x.duration)) {
            x.readyState = 4;
            o.dispatchEvent("durationchange");
            o.dispatchEvent("loadedmetadata");
            o.dispatchEvent("loadeddata");
            o.dispatchEvent("canplay");
            o.dispatchEvent("canplaythrough")
          }
        },
        getVolume: function(l) {
          x.volume = parseFloat(l.value)
        }
      },
          g = {
          ready: function() {
            c("addEventListener", "loadProgress");
            c("addEventListener", "playProgress");
            c("addEventListener", "play");
            c("addEventListener", "pause");
            c("addEventListener", "finish");
            c("addEventListener", "seek");
            c("getDuration");
            A = true;
            q.process();
            o.dispatchEvent("loadstart")
          },
          loadProgress: function(l) {
            o.dispatchEvent("progress");
            x.duration = parseFloat(l.data.duration)
          },
          playProgress: function(l) {
            x.currentTime = parseFloat(l.data.seconds)
          },
          play: function() {
            if (x.seeking) {
              x.seeking = false;
              o.dispatchEvent("seeked")
            }
            x.paused = false;
            x.ended = false;
            e();
            o.dispatchEvent("play")
          },
          pause: function() {
            x.paused = true;
            h();
            o.dispatchEvent("pause")
          },
          finish: function() {
            x.ended = true;
            h();
            o.dispatchEvent("ended")
          },
          seek: function(l) {
            x.currentTime = parseFloat(l.data.seconds);
            x.seeking = false;
            x.ended = false;
            o.dispatchEvent("timeupdate");
            o.dispatchEvent("seeked")
          }
          };
      o.load = function() {
        A = false;
        m = Popcorn.guid();
        var l = r(x.src),
            k = {},
            t = [],
            u = {
            api: 1,
            player_id: m
            };
        if (f(o.nodeName, l.source)) {
          Popcorn.extend(k, n);
          Popcorn.extend(k, l.queryKey);
          Popcorn.extend(k, u);
          l = "http://player.vimeo.com/video/" + /\d+$/.exec(l.path) + "?";
          for (var v in k) k.hasOwnProperty(v) && t.push(encodeURIComponent(v) + "=" + encodeURIComponent(k[v]));
          l += t.join("&");
          x.loop = !! l.match(/loop=1/);
          x.autoplay = !! l.match(/autoplay=1/);
          y.width = o.style.width ? o.style.width : 500;
          y.height = o.style.height ? o.style.height : 281;
          y.frameBorder = 0;
          y.webkitAllowFullScreen = true;
          y.mozAllowFullScreen = true;
          y.allowFullScreen = true;
          y.src = l;
          o.appendChild(y)
        } else {
          l = x.MEDIA_ERR_SRC_NOT_SUPPORTED;
          x.error = {};
          Popcorn.extend(x.error, p);
          x.error.code = l;
          o.dispatchEvent("error")
        }
      };
      o.unload = function() {
        h();
        window.removeEventListener("message", b, false)
      };
      o.play = function() {
        q.queue(function() {
          c("play")
        })
      };
      o.pause = function() {
        q.queue(function() {
          c("pause")
        })
      };
      setTimeout(function() {
        window.addEventListener("message", b, false);
        o.load()
      }, 0)
    },
    _teardown: function() {
      this.unload && this.unload()
    }
  })
})();
(function(r, f) {
  r.onYouTubePlayerAPIReady = function() {
    onYouTubePlayerAPIReady.ready = true;
    for (var c = 0; c < onYouTubePlayerAPIReady.waiting.length; c++) onYouTubePlayerAPIReady.waiting[c]()
  };
  if (r.YT) {
    r.quarantineYT = r.YT;
    r.YT = null
  }
  onYouTubePlayerAPIReady.waiting = [];
  var n = false;
  f.player("youtube", {
    _canPlayType: function(c, b) {
      return typeof b === "string" && /(?:http:\/\/www\.|http:\/\/|www\.|\.|^)(youtu)/.test(b) && c.toLowerCase() !== "video"
    },
    _setup: function(c) {
      if (!r.YT && !n) {
        n = true;
        f.getScript("//youtube.com/player_api")
      }
      var b =
      this,
          e = false,
          h = document.createElement("div"),
          i = 0,
          j = true,
          p = false,
          m = 0,
          o = false,
          q = 100,
          s = f.player.playerQueue(),
          d = function() {
          f.player.defineProperty(b, "currentTime", {
            set: function(y) {
              if (!c.destroyed) {
                p = true;
                i = Math.round(+y * 100) / 100
              }
            },
            get: function() {
              return i
            }
          });
          f.player.defineProperty(b, "paused", {
            get: function() {
              return j
            }
          });
          f.player.defineProperty(b, "muted", {
            set: function(y) {
              if (c.destroyed) return y;
              if (c.youtubeObject.isMuted() !== y) {
                y ? c.youtubeObject.mute() : c.youtubeObject.unMute();
                o = c.youtubeObject.isMuted();
                b.dispatchEvent("volumechange")
              }
              return c.youtubeObject.isMuted()
            },
            get: function() {
              if (c.destroyed) return 0;
              return c.youtubeObject.isMuted()
            }
          });
          f.player.defineProperty(b, "volume", {
            set: function(y) {
              if (c.destroyed) return y;
              if (c.youtubeObject.getVolume() / 100 !== y) {
                c.youtubeObject.setVolume(y * 100);
                q = c.youtubeObject.getVolume();
                b.dispatchEvent("volumechange")
              }
              return c.youtubeObject.getVolume() / 100
            },
            get: function() {
              if (c.destroyed) return 0;
              return c.youtubeObject.getVolume() / 100
            }
          });
          b.play = function() {
            if (!c.destroyed) {
              j =
              false;
              s.add(function() {
                if (c.youtubeObject.getPlayerState() !== 1) {
                  p = false;
                  c.youtubeObject.playVideo()
                } else s.next()
              })
            }
          };
          b.pause = function() {
            if (!c.destroyed) {
              j = true;
              s.add(function() {
                c.youtubeObject.getPlayerState() !== 2 ? c.youtubeObject.pauseVideo() : s.next()
              })
            }
          }
          };
      h.id = b.id + f.guid();
      c._container = h;
      b.appendChild(h);
      var A = function() {
        var y, x, a, g, l = true,
            k = function() {
            if (!c.destroyed) {
              if (p) if (i === c.youtubeObject.getCurrentTime()) {
                p = false;
                b.dispatchEvent("seeked");
                b.dispatchEvent("timeupdate")
              } else c.youtubeObject.seekTo(i);
              else {
                i = c.youtubeObject.getCurrentTime();
                b.dispatchEvent("timeupdate")
              }
              setTimeout(k, 250)
            }
            },
            t = function(z) {
            var C = c.youtubeObject.getDuration();
            if (isNaN(C) || C === 0) setTimeout(function() {
              t(z * 2)
            }, z * 1E3);
            else {
              b.duration = C;
              b.dispatchEvent("durationchange");
              b.dispatchEvent("loadedmetadata");
              b.dispatchEvent("loadeddata");
              b.readyState = 4;
              k();
              b.dispatchEvent("canplaythrough")
            }
            };
        c.controls = +c.controls === 0 || +c.controls === 1 ? c.controls : 1;
        c.annotations = +c.annotations === 1 || +c.annotations === 3 ? c.annotations : 1;
        y = /^.*(?:\/|v=)(.{11})/.exec(b.src)[1];
        x = (b.src.split("?")[1] || "").replace(/v=.{11}/, "");
        x = x.replace(/&t=(?:(\d+)m)?(?:(\d+)s)?/, function(z, C, E) {
          C |= 0;
          E |= 0;
          m = +E + C * 60;
          return ""
        });
        x = x.replace(/&start=(\d+)?/, function(z, C) {
          C |= 0;
          m = C;
          return ""
        });
        e = /autoplay=1/.test(x);
        x = x.split(/[\&\?]/g);
        a = {
          wmode: "transparent"
        };
        for (var u = 0; u < x.length; u++) {
          g = x[u].split("=");
          a[g[0]] = g[1]
        }
        c.youtubeObject = new YT.Player(h.id, {
          height: "100%",
          width: "100%",
          wmode: "transparent",
          playerVars: a,
          videoId: y,
          events: {
            onReady: function() {
              q = b.volume;
              o = b.muted;
              v();
              j = b.paused;
              d();
              c.youtubeObject.playVideo();
              b.currentTime = m
            },
            onStateChange: function(z) {
              if (!(c.destroyed || z.data === -1)) if (z.data === 2) {
                j = true;
                b.dispatchEvent("pause");
                s.next()
              } else if (z.data === 1 && !l) {
                j = false;
                b.dispatchEvent("play");
                b.dispatchEvent("playing");
                s.next()
              } else if (z.data === 0) b.dispatchEvent("ended");
              else if (z.data === 1 && l) {
                l = false;
                if (e || !b.paused) j = false;
                j && c.youtubeObject.pauseVideo();
                t(0.025)
              }
            },
            onError: function(z) {
              if ([2, 100, 101, 150].indexOf(z.data) !== -1) {
                b.error = {
                  customCode: z.data
                };
                b.dispatchEvent("error")
              }
            }
          }
        });
        var v = function() {
          if (!c.destroyed) {
            if (o !== c.youtubeObject.isMuted()) {
              o = c.youtubeObject.isMuted();
              b.dispatchEvent("volumechange")
            }
            if (q !== c.youtubeObject.getVolume()) {
              q = c.youtubeObject.getVolume();
              b.dispatchEvent("volumechange")
            }
            setTimeout(v, 250)
          }
        }
      };
      onYouTubePlayerAPIReady.ready ? A() : onYouTubePlayerAPIReady.waiting.push(A)
    },
    _teardown: function(c) {
      c.destroyed = true;
      var b = c.youtubeObject;
      if (b) {
        b.stopVideo();
        b.clearVideo && b.clearVideo()
      }
      this.removeChild(document.getElementById(c._container.id))
    }
  })
})(window, Popcorn);
