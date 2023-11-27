const ctx = document.getElementById("myChart");
const myChart_2 = document.getElementById("myChart_2");

/* input value */
var a = 50;
var b = 50;
var c = 120;

/* doughnut chart */
new Chart(ctx, {
  type: "doughnut",
  data: {
    labels: ["Red", "Blue", "Yellow"],
    datasets: [
      {
        label: "# of Votes",
        data: [a, b, c],
        backgroundColor: [
          "rgba(255, 99, 132, 1",
          "rgba(54, 162, 235, 1",
          "rgba(255, 206, 86, 1",
        ],
      },
    ],
  },
  options: {
    reponsive: true,
  },
});

/* var chart */
new Chart(myChart_2, {
  type: "bar",
  data: {
    labels: ["Red", "Blue", "Yellow"],
    datasets: [
      {
        label: "# of Votes",
        data: [a, b, c],
        backgroundColor: [
          "rgba(255, 99, 132, 1",
          "rgba(54, 162, 235, 1",
          "rgba(255, 206, 86, 1",
        ],
      },
    ],
  },
  options: {
    responsive: true,
  },
});
