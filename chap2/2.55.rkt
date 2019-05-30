#lang racket
#| Given: |#
(car ''abracadabra) ; Outputs "quote"

#| Testing |#
(cdr ''abracadabra) ; Outputs '(abracadabra)
(car (cdr ''abracadabra)) ; Outputs 'abracadabra

#| Answer |#
#| a string is made up of many characters in a row. The first character in this string
(after the initial one to indicate it's a quote) is the quotation symbol
|#