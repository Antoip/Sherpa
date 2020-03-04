const lineGraphStudent = (values) => {
  let chart = document.getElementById("lineStudentChart")
  if (values) {
    if (chart) {
      let chapters = JSON.parse(document.querySelector(".card-student-list").dataset.label)
      var my_chart = new Chart(chart, {
        type: 'bar',
        data: {
          labels: chapters,
          datasets: [{
              data: Object.values(values),
          label: "Flashcards done",
          borderColor: "purple",
          backgroundColor: "purple",
            },
          ]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          legend: {
            display: false,
          },
          title: {
            display: true,
            text: "Flashcards progression chapter by chapter"
          },
          scales: {
              yAxes: [{
                  ticks: {
                      display: true,
                      beginAtZero: true,
                  },
                  gridLines : {
                    display: false,
                  }
              }]
          },
        }
      });
    }
  }
};

export { lineGraphStudent };
