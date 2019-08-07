window.onload = function () {

    var data=document.getElementById("json_data").value;
    data = JSON.parse( data );

    console.log( data );

    Highcharts.chart('chart_regular_success', {

        title: {
            text: 'Comparaison des chances de réussites entre un d20 et 2d10'
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
            name: 'd20',
            data: data.regular.strict_superiority.d20
        }, {
            name: '2d10',
            data: data.d10
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

    Highcharts.chart('chart_critical_success', {

        title: {
            text: 'Comparaison des chances de réussites critiques entre un d20 et 2d10'
        },

        yAxis: {
            title: {
                text: '% succès'
            },
            max: 10
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },

        tooltip: {
            formatter: function () {
                return 'Pour une difficulté de <b>' + this.x +
                    '</b> les chances de réussite critique sont de <b>' + this.y + '%</b>' +
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
            name: 'd20',
            data: data.d20_critical
        }, {
            name: '2d10',
            data: data.d10_critical
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