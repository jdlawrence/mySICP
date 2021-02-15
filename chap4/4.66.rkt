#lang sicp
#| Answer:
Ben has realized that one query can give multiple right answers, and that this would mess up his accumulation function.
For  example, a query on wheels along with their salary would produce 4 times the correct salary for (Warbucks Oliver)
since he appears four times in the (wheel ?who) query. For this to function correctly, Ben would need some sort of
"unique-by" field, ie (accumulation-function ⟨variable⟩ <unique-by> ⟨query pattern⟩)

|#