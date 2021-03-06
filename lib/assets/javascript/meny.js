/*!
 * meny 1.4
 * http://lab.hakim.se/meny
 * MIT licensed
 *
 * Created by Hakim El Hattab (http://hakim.se, @hakimel)
 */
(function(a, f) {
  "function" === typeof define && define.amd ? define(f) : a.Meny = f()
})(this, function() {
  "function" !== typeof Date.now && (Date.now = function() {
    return (new Date).getTime()
  });
  var a = {
    create: function(f) {
      return function() {
        var e, g, k;

        function p(d) {
          a.extend(c, d);
          O = T = "";
          switch (c.position) {
          case r:
            H = "50% 0%";
            s = "rotateX( 10deg ) translateY( -100% ) translateY( " + c.overlap + "px )";
            t = "50% 0";
            I = "translateY( " + c.height + "px ) rotateX( -10deg )";
            u = {
              top: "-" + (c.height - c.overlap) + "px"
            };
            J = {
              top: "0px"
            };
            v = {
              top: "0px"
            };
            K = {
              top: c.height + "px"
            };
            break;
          case w:
            H = "100% 50%";
            s = "rotateY( 10deg ) translateX( 100% ) translateX( -2px ) scale( 1.01 )";
            t = "100% 50%";
            I = "translateX( -" + c.width + "px ) rotateY( -10deg )";
            u = {
              right: "-" + (c.width - c.overlap) + "px"
            };
            J = {
              right: "0px"
            };
            v = {
              left: "0px"
            };
            K = {
              left: "-" + c.width + "px"
            };
            break;
          case x:
            H = "50% 100%";
            s = "rotateX( -10deg ) translateY( 100% ) translateY( -" + c.overlap + "px )";
            t = "50% 100%";
            I = "translateY( -" + c.height + "px ) rotateX( 10deg )";
            u = {
              bottom: "-" + (c.height - c.overlap) + "px"
            };
            J = {
              bottom: "0px"
            };
            v = {
              top: "0px"
            };
            K = {
              top: "-" + c.height + "px"
            };
            break;
          default:
            H = "100% 50%", s = "translateX( -100% ) translateX( " + c.overlap + "px ) scale( 1.01 ) rotateY( -15deg )", t = "0 50%", I = "translateX( " + c.width + "px ) rotateY( 10deg )", u = {
              left: "-" + (c.width - c.overlap) + "px"
            }, J = {
              left: "0px"
            }, v = {
              left: "0px"
            }, K = {
              left: c.width + "px"
            }
          }
          a.addClass(b.wrapper, "meny-" + c.position);
          e = b.wrapper.style.cssText;
          b.wrapper.style[a.prefix("perspective")] = "900px";
          b.wrapper.style[a.prefix("perspectiveOrigin")] = t;
          b.cover && b.cover.parentNode.removeChild(b.cover);
          b.cover =
          document.createElement("div");
          b.cover.style.position = "absolute";
          b.cover.style.display = "block";
          b.cover.style.width = "100%";
          b.cover.style.height = "100%";
          b.cover.style.left = 0;
          b.cover.style.top = 0;
          b.cover.style.zIndex = 1E3;
          b.cover.style.visibility = "hidden";
          b.cover.style.opacity = 0;
          try {
            b.cover.style.background = "rgba( 0, 0, 0, 0.4 )", b.cover.style.background = "-ms-linear-gradient(" + c.position + ", rgba(0,0,0,0.20) 0%,rgba(0,0,0,0.65) 100%)", b.cover.style.background = "-moz-linear-gradient(" + c.position + ", rgba(0,0,0,0.20) 0%,rgba(0,0,0,0.65) 100%)", b.cover.style.background = "-webkit-linear-gradient(" + c.position + ", rgba(0,0,0,0.20) 0%,rgba(0,0,0,0.65) 100%)"
          } catch (f) {}
          L && (b.cover.style[a.prefix("transition")] = "all " + c.transitionDuration + " " + c.transitionEasing);
          b.contents.appendChild(b.cover);
          d = b.menu.style;
          switch (c.position) {
          case r:
            d.width = "100%";
            d.height = c.height + "px";
            break;
          case w:
            d.right = "0";
            d.width = c.width + "px";
            d.height = "100%";
            break;
          case x:
            d.bottom = "0";
            d.width = "100%";
            d.height = c.height + "px";
            break;
          case y:
            d.width = c.width + "px", d.height = "100%"
          }
          g =
          d.cssText;
          d.position = "fixed";
          d.display = "block";
          d.zIndex = 1;
          L ? (d[a.prefix("transform")] = s, d[a.prefix("transformOrigin")] = H, d[a.prefix("transition")] = "all " + c.transitionDuration + " " + c.transitionEasing) : a.extend(d, u);
          d = b.contents.style;
          k = d.cssText;
          L ? (d[a.prefix("transform")] = O, d[a.prefix("transformOrigin")] = t, d[a.prefix("transition")] = "all " + c.transitionDuration + " " + c.transitionEasing) : (d.position = d.position.match(/relative|absolute|fixed/gi) ? d.position : "relative", a.extend(d, v));
          "ontouchstart" in window && (c.touch ? (a.bindEvent(document, "touchstart", P), a.bindEvent(document, "touchend", q)) : (a.unbindEvent(document, "touchstart", P), a.unbindEvent(document, "touchend", q)));
          c.mouse ? (a.bindEvent(document, "mousedown", l), a.bindEvent(document, "mouseup", z), a.bindEvent(document, "mousemove", M)) : (a.unbindEvent(document, "mousedown", l), a.unbindEvent(document, "mouseup", z), a.unbindEvent(document, "mousemove", M))
        }
        function m() {
          n || (n = !0, a.addClass(b.wrapper, "meny-active"), b.cover.style.height = b.contents.scrollHeight + "px", b.cover.style.visibility = "visible", L ? (a.bindEventOnce(b.wrapper, "transitionend", function() {
            a.dispatchEvent(b.menu, "opened")
          }), b.cover.style.opacity = 1, b.contents.style[a.prefix("transform")] = I, b.menu.style[a.prefix("transform")] = T) : (A && A.stop(), A = a.animate(b.menu, J, 500), B && B.stop(), B = a.animate(b.contents, K, 500), C && C.stop(), C = a.animate(b.cover, {
            opacity: 1
          }, 500)), a.dispatchEvent(b.menu, "open"))
        }
        function h() {
          n && (n = !1, a.removeClass(b.wrapper, "meny-active"), L ? (a.bindEventOnce(b.wrapper, "transitionend", function() {
            a.dispatchEvent(b.menu, "closed")
          }), b.cover.style.visibility = "hidden", b.cover.style.opacity = 0, b.contents.style[a.prefix("transform")] = O, b.menu.style[a.prefix("transform")] = s) : (A && A.stop(), A = a.animate(b.menu, u, 500), B && B.stop(), B = a.animate(b.contents, v, 500), C && C.stop(), C = a.animate(b.cover, {
            opacity: 0
          }, 500, function() {
            b.cover.style.visibility = "hidden";
            a.dispatchEvent(b.menu, "closed")
          })), a.dispatchEvent(b.menu, "close"))
        }
        function l(b) {
          Q = !0
        }
        function M(d) {
          if (!Q) {
            var a = d.clientX - R;
            d = d.clientY - S;
            switch (c.position) {
            case r:
              d > c.height ? h() : d < c.threshold && m();
              break;
            case w:
              d = b.wrapper.offsetWidth;
              a < d - c.width ? h() : a > d - c.threshold && m();
              break;
            case x:
              a = b.wrapper.offsetHeight;
              d < a - c.height ? h() : d > a - c.threshold && m();
              break;
            case y:
              a > c.width ? h() : a < c.threshold && m()
            }
          }
        }
        function z(b) {
          Q = !1
        }
        function P(b) {
          D = b.touches[0].clientX - R;
          E = b.touches[0].clientY - S;
          F = G = null;
          a.bindEvent(document, "touchmove", U)
        }
        function U(b) {
          G = b.touches[0].clientX - R;
          F = b.touches[0].clientY - S;
          var a = null;
          Math.abs(G - D) > Math.abs(F - E) ? G < D - c.threshold ? a = V : G > D + c.threshold && (a = W) : F < E - c.threshold ? a = X : F > E + c.threshold && (a = Y);
          a && a() && b.preventDefault()
        }
        function q(d) {
          a.unbindEvent(document, "touchmove", U);
          null === G && null === F && (c.position === r && E > c.height || c.position === w && D < b.wrapper.offsetWidth - c.width || c.position === x && E < b.wrapper.offsetHeight - c.height || c.position === y && D > c.width) && h()
        }
        function W() {
          if (c.position === w && n) return h(), !0;
          if (c.position === y && !n) return m(), !0
        }
        function V() {
          if (c.position === w && !n) return m(), !0;
          if (c.position === y && n) return h(), !0
        }
        function Y() {
          if (c.position === x && n) return h(), !0;
          if (c.position === r && !n) return m(), !0
        }
        function X() {
          if (c.position === x && !n) return m(), !0;
          if (c.position === r && n) return h(), !0
        }
        if (!f || !f.menuElement || !f.contentsElement) throw "You need to specify which menu and contents elements to use.";
        if (f.menuElement.parentNode !== f.contentsElement.parentNode) throw "The menu and contents elements must have the same parent.";
        var r = "top",
            w = "right",
            x = "bottom",
            y = "left",
            L = "WebkitPerspective" in document.body.style || "MozPerspective" in document.body.style || "msPerspective" in document.body.style || "OPerspective" in document.body.style || "perspective" in document.body.style,
            c = {
            width: 300,
            height: 300,
            position: y,
            threshold: 40,
            overlap: 6,
            transitionDuration: "0.5s",
            transitionEasing: "ease",
            mouse: !0,
            touch: !0
            },
            b = {
            menu: f.menuElement,
            contents: f.contentsElement,
            wrapper: f.menuElement.parentNode,
            cover: null
            },
            R = b.wrapper.offsetLeft,
            S = b.wrapper.offsetTop,
            D = null,
            E = null,
            G = null,
            F = null,
            n = !1,
            Q = !1,
            H, s, T, u, J, t, O, I, v, K;
        k = g = e = void 0;
        var N = [],
            A, B, C;
        p(f);
        return {
          configure: p,
          open: m,
          close: h,
          destroy: function() {
            b.wrapper.style.cssText =
            e;
            b.menu.style.cssText = g;
            b.contents.style.cssText = k;
            b.cover && b.cover.parentNode && b.cover.parentNode.removeChild(b.cover);
            a.unbindEvent(document, "touchstart", P);
            a.unbindEvent(document, "touchend", q);
            a.unbindEvent(document, "mousedown", l);
            a.unbindEvent(document, "mouseup", z);
            a.unbindEvent(document, "mousemove", M);
            for (var c in N) this.removeEventListener(N[c][0], N[c][1]);
            N = []
          },
          isOpen: function() {
            return n
          },
          addEventListener: function(c, f) {
            N.push([c, f]);
            b.menu && a.bindEvent(b.menu, c, f)
          },
          removeEventListener: function(c, f) {
            b.menu && a.unbindEvent(b.menu, c, f)
          }
        }
      }()
    },
    animate: function(a, e, g, k) {
      return function() {
        function p() {
          var e = 1 - Math.pow(1 - (Date.now() - M) / g, 5),
              l;
          for (l in h) {
            var q = h[l];
            a.style[l] = q.start + (q.end - q.start) * e + q.unit
          }
          1 > e ? z = setTimeout(p, 1E3 / 60) : (k && k(), m())
        }
        function m() {
          clearTimeout(z)
        }
        var h = {},
            l;
        for (l in e) h[l] = {
          start: parseFloat(a.style[l]) || 0,
          end: parseFloat(e[l]),
          unit: "string" === typeof e[l] && e[l].match(/px|em|%/gi) ? e[l].match(/px|em|%/gi)[0] : ""
        };
        var M = Date.now(),
            z;
        p();
        return {
          stop: m
        }
      }()
    },
    extend: function(a, e) {
      for (var g in e) a[g] = e[g]
    },
    prefix: function(a, e) {
      for (var g = a.slice(0, 1).toUpperCase() + a.slice(1), k = ["Webkit", "Moz", "O", "ms"], p = 0, m = k.length; p < m; p++) {
        var h = k[p];
        if ("undefined" !== typeof(e || document.body).style[h + g]) return h + g
      }
      return a
    },
    addClass: function(a, e) {
      a.className = a.className.replace(/\s+$/gi, "") + " " + e
    },
    removeClass: function(a, e) {
      a.className = a.className.replace(e, "")
    },
    bindEvent: function(a, e, g) {
      a.addEventListener ? a.addEventListener(e, g, !1) : a.attachEvent("on" + e, g)
    },
    unbindEvent: function(a, e, g) {
      a.removeEventListener ? a.removeEventListener(e, g, !1) : a.detachEvent("on" + e, g)
    },
    bindEventOnce: function(a, e, g) {
      var k = this,
          p = function() {
          k.unbindEvent(a, e, p);
          g.apply(this, arguments)
          };
      this.bindEvent(a, e, p)
    },
    dispatchEvent: function(f, e, g) {
      if (f) {
        var k = document.createEvent("HTMLEvents", 1, 2);
        k.initEvent(e, !0, !0);
        a.extend(k, g);
        f.dispatchEvent(k)
      }
    },
    getQuery: function() {
      var a = {};
      location.search.replace(/[A-Z0-9]+?=([\w|:|\/\.]*)/gi, function(e) {
        a[e.split("=").shift()] = e.split("=").pop()
      });
      return a
    }
  };
  return a
});
