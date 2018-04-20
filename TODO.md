TODO:
- benchmark the code against vector-algorithms (there's insertion sort, etc.)
- add a flag for that benchmark (see how it's done in lens)
- add a flag for hasktags, too
- benchmark against C?
- try getting rid of the list wrapping and operate on the MutableByteArray
  (suggested by Cale on #haskell)
- benchmark against the standard Haskell sort function (suggested by Cale).
- profile: look at Core, STG, the event log, etc.
