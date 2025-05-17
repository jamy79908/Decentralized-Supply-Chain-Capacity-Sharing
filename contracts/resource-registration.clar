;; Resource Registration Contract
;; Records available logistics assets

(define-map resources
  { owner: principal, resource-id: uint }
  {
    resource-type: (string-utf8 20),
    capacity: uint,
    location: (string-utf8 50),
    available: bool
  })

(define-data-var resource-counter uint u0)

;; Error codes
(define-constant ERR-NOT-FOUND u200)
(define-constant ERR-UNAUTHORIZED u201)

;; Register a new resource
(define-public (register-resource
                (resource-type (string-utf8 20))
                (capacity uint)
                (location (string-utf8 50)))
  (let ((resource-id (+ (var-get resource-counter) u1)))
    (var-set resource-counter resource-id)
    (ok (map-set resources
                { owner: tx-sender, resource-id: resource-id }
                {
                  resource-type: resource-type,
                  capacity: capacity,
                  location: location,
                  available: true
                }))))

;; Update resource availability
(define-public (set-availability (resource-id uint) (available bool))
  (let ((resource-key { owner: tx-sender, resource-id: resource-id }))
    (match (map-get? resources resource-key)
      resource (ok (map-set resources
                           resource-key
                           (merge resource { available: available })))
      (err ERR-NOT-FOUND))))

;; Get resource details
(define-read-only (get-resource (owner principal) (resource-id uint))
  (map-get? resources { owner: owner, resource-id: resource-id }))

;; Check if a resource is available
(define-read-only (is-resource-available (owner principal) (resource-id uint))
  (match (map-get? resources { owner: owner, resource-id: resource-id })
    resource (get available resource)
    false))
