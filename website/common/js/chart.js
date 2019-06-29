window.onload = function () {

    var d20=document.getElementById("d20_data").value;
    d20 = JSON.parse( d20 );
    var d10=document.getElementById("2d10_data").value;
    d10 = JSON.parse( d10 );

    console.log( d20 );

    Highcharts.chart('chart_container', {

        title: {
            text: 'Remplacer un d20 par 2d10'
        },

        yAxis: {
            title: {
                text: '% succès'
            },
            max: 100
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },

        tooltip: {
            formatter: function () {
                return 'Pour une difficulté de <b>' + this.x +
                    '</b> les chances de réussite sont de <b>' + this.y + '%</b>' +
                    ' pour ' + this.series.name;
            }
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
            name: 'un dé 20',
            data: d20
        }, {
            name: 'deux dés 10',
            data: d10
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