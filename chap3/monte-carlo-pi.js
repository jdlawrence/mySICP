const randBetween = (low, high) => {
  const diff = high - low;
  return Math.random() * diff - diff / 2;
};

const unitCircleSimulate = () => {
  const x = randBetween(-1, 1);
  const y = randBetween(-1, 1);

  return x * x + y * y <= 1;
};

const MonteCarlo = (test, trials) => {
  let count = 0;
  for (let i = 0; i < trials; i++) {
    if (test()) {
      count++;
    }
  }
  return count / trials;
};

console.log('pi is approximately', MonteCarlo(unitCircleSimulate, 100000000) * 4);
