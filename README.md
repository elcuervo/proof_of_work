# Proof Of Work

Pure Ruby implementation of the Hashcash algorithm.

```ruby
hash = ProofOfWork.generate("elcuervo@elcuervo.co")
# => 1:20:140123:elcuervo@elcuervo.co::LENoHOSV:18b952

ProofOfWork.valid?(hash)
# => true
```
