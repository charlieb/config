(ns particles.core
  (:require [quil.core :as q]
            [quil.middleware :as m]))
(deftype V [^double x ^double y])
(deftype Particle [^double x ^double y ^double vx ^double vy ^double r])

; ------------ V ----------------
(defn dot [^V v1 ^V v2] (+ (* (.x v1) (.x v2)) 
                           (* (.y v1) (.y v2))))
(defn mag [^V v] (Math/sqrt (dot v v)))
(defn scl [^V v ^double s] (V. (* (.x v) s) (* (.y v) s)))
(defn norm [^V v] (scl v (/ 1 (mag v))))


;----------- Particle ----------
(defn dist-sq [^Particle p1 ^Particle p2]
  (let [dx (- (.x p2) (.x p1))
        dy (- (.y p2) (.y p1))]
    (+ (* dx dx) (* dy dy))))

(defn pen-depth [^Particle p1 ^Particle p2]
  (- (+ (.r p1) (.r p2)) (Math/sqrt (dist-sq p1 p2))))

(defn collides? [^Particle p1 ^Particle p2]
  (let [rs (+ (.r p1) (.r p2))]
    (println rs (dist-sq p1 p2))
    (>= (* rs rs) (dist-sq p1 p2))))

(defn collision-normal [^Particle p1 ^Particle p2]
  (norm (V. (- (.x p2) (.x p1))
            (- (.y p2) (.y p1)))))

(defn relative-v [^Particle p1 ^Particle p2 ^V normal] 
  (dot (V. (- (.vx p2) (.vx p1))
           (- (.vy p2) (.vy p1)))
       normal))

(defn impulse [^Particle p1 ^Particle p2]
  (let [e 1. ; Restitution => bounciness
        mass1 1.
        mass2 1.
        n (collision-normal p1 p2)
        v (relative-v p1 p2 n)
        j (/ (* (- (+ e 1)) v) ; Impulse scalar
             (+ (/ 1 mass1) (/ 1 mass2)))]
    (scl n j)))

(defn resolve-collision [^Particle p1 ^Particle p2]
  (if (collides? p1 p2)
    (let [imp (impulse p1 p2)]
      ; [(- (scl imp (/ 1 (.mass p1))))
      ;  (+ (scl imp (/ 1 (.mass p1))))]
      ;[(- imp) imp]
      (println 'coll)
      [(Particle. (.x p1) (.y p1) 
                  (- (.vx p1) (.x imp)) 
                  (- (.vy p1) (.y imp))
                  (.r p1))
       (Particle. (.x p2) (.y p2) 
                  (+ (.vx p2) (.x imp)) 
                  (+ (.vy p2) (.y imp))
                  (.r p2))])
    [p1 p2]))
(defn update-particle [p]
  (Particle. (+ (.x p) (.vx p))
             (+ (.y p) (.vy p))
             (.vx p) (.vy p) (.r p)))
;--------------------------------------------------

(defn setup []
  ; Set frame rate to 30 frames per second.
  (q/frame-rate 30)
  ; Set color mode to HSB (HSV) instead of default RGB.
  (q/color-mode :hsb)
  ; setup function returns initial state. It contains
  ; circle color and position.
  [(Particle. 100 100  0.1 0 10)
   (Particle. 150 100 -0.1 0 10)]
  )

(defn update-state [state]
  (let [s2 (map update-particle state)]
    (resolve-collision (first s2) (second s2))))

(defn draw-state [state]
  ; Clear the sketch by filling it with light-grey color.
  (q/background 240)
  ; Set circle color.
  (q/fill 128 255 255)
  (doseq [p state]
    (q/ellipse (.x p) (.y p) (* 2. (.r p)) (* 2. (.r p)))))

(defn -main [& args]
  (q/defsketch particles
    :title "You spin my circle right round"
    :size [500 500]
    ; setup function called only once, during sketch initialization.
    :setup setup
    ; update-state is called on each iteration before draw-state.
    :update update-state
    :draw draw-state
    :features [:keep-on-top]
    ; This sketch uses functional-mode middleware.
    ; Check quil wiki for more info about middlewares and particularly
    ; fun-mode.
    :middleware [m/fun-mode]))
