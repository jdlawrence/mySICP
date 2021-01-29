#lang sicp
; The professsor, with the cat, lectures to the student, while the professor in the class. 
(sentence (simple-noun-phrase (article the) (noun professor))
          (verb-phrase
           (verb-phrase
            (verb-phrase (verb lectures)
                         (prep-phrase
                          (prep to)
                          (simple-noun-phrase (article the) (noun student))))
            (prep-phrase (prep in) (simple-noun-phrase (article the) (noun class))))
           (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))
                     
; The professor lectures to a student. The student is in the class, and the class has a cat.
(sentence (simple-noun-phrase (article the) (noun professor))
          (verb-phrase
           (verb-phrase (verb lectures) (prep-phrase (prep to) (simple-noun-phrase (article the) (noun student))))
           (prep-phrase (prep in)
                        (noun-phrase (simple-noun-phrase (article the) (noun class))
                                     (prep-phrase (prep with) (simple-noun-phrase (article the) (noun cat)))))))

; The professor, with a cat, lectures to the student. The student is in the class.
(sentence (simple-noun-phrase (article the) (noun professor))
          (verb-phrase (verb-phrase (verb lectures)
                                    (prep-phrase (prep to)
                                                 (noun-phrase (simple-noun-phrase (article the) (noun student))
                                                              (prep-phrase (prep in)
                                                                           (simple-noun-phrase (article the) (noun class))))))
                       (prep-phrase (prep with)
                                    (simple-noun-phrase (article the) (noun cat)))))

; The professor lectures to the student who is in the class. The professor is with a cat.
(sentence (simple-noun-phrase (article the) (noun professor))
          (verb-phrase (verb lectures)
                       (prep-phrase (prep to)
                                    (noun-phrase
                                     (noun-phrase (simple-noun-phrase (article the) (noun student))
                                                  (prep-phrase (prep in)
                                                               (simple-noun-phrase (article the) (noun class))))
                                     (prep-phrase (prep with)
                                                  (simple-noun-phrase (article the) (noun cat)))))))

; The professor lectures to the student who is in the class. The class is with a cat.
(sentence (simple-noun-phrase (article the) (noun professor))
          (verb-phrase (verb lectures)
                       (prep-phrase (prep to)
                                    (noun-phrase
                                     (simple-noun-phrase (article the) (noun student))
                                     (prep-phrase (prep in)
                                                  (noun-phrase
                                                   (simple-noun-phrase (article the) (noun class))
                                                   (prep-phrase (prep with)
                                                                (simple-noun-phrase (article the) (noun cat)))))))))
