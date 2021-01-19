const result = [];

// const aSet = ['a', 'b', 'c', 'd'];
const aSet = ['baker', 'cooper', 'fletcher', 'miller', 'smith'];
// const aSet = ['a', 'b', 'c'];

// for (let i = 0; i < limit; i++) {
//   for (let j = 0; j < limit; j++) {
//     if (j === i) continue;
//     for (let k = 0; k < limit; k++) {
//       if (k === i || k === j) continue;
//       for (let l = 0; l < limit; l++) {
//         if (l === i || l === j || l === k) continue;
//         // console.table([i, j, k, l]);
//         console.log([aSet[i], aSet[j], aSet[j], aSet[l]]);
//       }
//     }
//   }
// }

const removeAtIndex = (input, index) => {
  return input.slice(0, index).concat(input.slice(index + 1));
};

// console.log(removeAtIndex([0, 1, 2, 3, 4, 5], 3));

const permutations = (theSet) => {
  const finalResult = [];

  const iteration = (available, used) => {
    if (available.length) {
      for (let i = 0; i < available.length; i++) {
        const choice = available[i];
        const newAvailable = removeAtIndex(available, i);
        iteration(newAvailable, [...used, choice]);
      }
    } else {
      const bakerIndex = used.indexOf('baker');
      const cooperIndex = used.indexOf('cooper');
      const fletcherIndex = used.indexOf('fletcher');
      const millerIndex = used.indexOf('miller');
      const smithIndex = used.indexOf('smith');
      if (
        bakerIndex !== 4 &&
        cooperIndex !== 0 &&
        fletcherIndex !== 0 &&
        fletcherIndex !== 4 &&
        millerIndex > cooperIndex &&
        Math.abs(smithIndex - fletcherIndex) > 1 &&
        Math.abs(fletcherIndex - cooperIndex) > 1
        ) {
        finalResult.push(used);
      }
    }
  };

  iteration(theSet, []);
  return finalResult;
};

const permutations2 = (theSet) => {
  const finalResult = [];

  const iteration = (available, used) => {
    if (available.length) {
      for (let i = 0; i < available.length; i++) {
        const choice = available[i];
        const newAvailable = removeAtIndex(available, i);
        iteration(newAvailable, [...used, choice]);
      }
    } else {
      finalResult.push(used);
    }
  };
  iteration(theSet, []);
  return finalResult;
};

console.log('ayyyy', permutations2(aSet));
