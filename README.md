# Proof Of Work

Pure Ruby implementation of the Hashcash algorithm.

```ruby
hash = ProofOfWork.generate("elcuervo@elcuervo.co")

ProofOfWork.valid?(hash)
# => true
```
