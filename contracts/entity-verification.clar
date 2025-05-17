;; Entity Verification Contract
;; Validates supply chain participants

(define-data-var admin principal tx-sender)

;; Entity status: 0 = unverified, 1 = verified, 2 = suspended
(define-map entities principal uint)

;; Error codes
(define-constant ERR-NOT-AUTHORIZED u100)
(define-constant ERR-ALREADY-VERIFIED u101)

;; Check if caller is admin
(define-private (is-admin)
  (is-eq tx-sender (var-get admin)))

;; Register a new entity (only admin can verify entities)
(define-public (verify-entity (entity principal))
  (begin
    (asserts! (is-admin) (err ERR-NOT-AUTHORIZED))
    (asserts! (is-none (map-get? entities entity)) (err ERR-ALREADY-VERIFIED))
    (ok (map-set entities entity u1))))

;; Suspend an entity
(define-public (suspend-entity (entity principal))
  (begin
    (asserts! (is-admin) (err ERR-NOT-AUTHORIZED))
    (ok (map-set entities entity u2))))

;; Check if an entity is verified
(define-read-only (is-verified (entity principal))
  (match (map-get? entities entity)
    status (is-eq status u1)
    false))

;; Transfer admin rights
(define-public (set-admin (new-admin principal))
  (begin
    (asserts! (is-admin) (err ERR-NOT-AUTHORIZED))
    (ok (var-set admin new-admin))))
