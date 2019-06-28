window.onload = function () {
    Highcharts.chart('chart_container', {

        title: {
            text: 'Remplacer un d20 par 2d10'
        },

        yAxis: {
            title: {
                text: 'Occurences'
            }
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },

        plotOptions: {
            series: {
                label: {
                    connectorAllowed: false
                },
                pointStart: 1
            }
        },

        series: [{
            name: 'd20',
            data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
        }, {
            name: '2d10',
            data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434]
        }],

        responsive: {
            rules: [{
                condition: {
                    maxWidth: 500
                },
                chartOptions: {
                    legend: {
                        layout: 'horizontal',
                        align: 'center',
                        verticalAlign: 'bottom'
                    }
                }
            }]
        }

    });
}