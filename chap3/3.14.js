
/* Taken from geeksforgeeks.org */
class Node {
  constructor(element)
  {
    this.element = element;
    this.next = null;
  }
}

const reverse = (list, result) => {
  if (list === null) {
    return result;
  } else {
    let temp = list.next;
    list.next = result;
    return reverse(temp, list);
  }
};

// Start with full list and null
// Split list into first item and rest of items
// Attach first item and null
// Call function recursively with rest of items and (first-item + null)


let e = new Node('e');
let f = new Node('f');
let g = new Node('g');
let h = new Node('h');

e.next = f;
f.next = g;
g.next = h;

const result = reverse(e, null);
console.log('result', result);


