draw_chart = function( chart_id, title, formatter, serie_d10, serie_d20, max ) {

    Highcharts.chart( chart_id, {

        title: {
            text: title
        },

        yAxis: {
            title: {
                text: '% succès'
            },
            max: max
        },
        legend: {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'middle'
        },

        tooltip: {
            formatter: function() { return formatter( this ) }
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
            data: serie_d10
        }, {
            name: '2d10',
            data: serie_d20
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

window.onload = function () {

    var data=document.getElementById("json_data").value;
    data = JSON.parse( data );

    console.log( data );

    console.log( data.regular.success.strict_superiority );

    draw_chart( 'chart_regular_success', 'Comparaison des chances de réussites entre un d20 et 2d10',
        function ( chart ) {
        // console.log( chart )
            return 'Pour une difficulté de <b>' + chart.x +
            '</b> les chances de réussite sont de <b>' + chart.y + '%</b>' +
            ' pour ' + chart.series.name
            },
        data.regular.success.strict_superiority.d10, data.regular.success.superior_or_equal.d20, 100
    )

    draw_chart( 'chart_regular_success_equality', 'Comparaison des chances de réussites entre un d20 et 2d10 - equal',
        function ( chart ) {
            // console.log( chart )
            return 'Pour une difficulté de <b>' + chart.x +
                '</b> les chances de réussite sont de <b>' + chart.y + '%</b>' +
                ' pour ' + chart.series.name
        },
        data.regular.success.superior_or_equal.d10, data.regular.success.superior_or_equal.d20, 100
    )

    // Highcharts.chart('chart_critical_success', {
    //
    //     title: {
    //         text: 'Comparaison des chances de réussites critiques entre un d20 et 2d10'
    //     },
    //
    //     yAxis: {
    //         title: {
    //             text: '% succès'
    //         },
    //         max: 10
    //     },
    //     legend: {
    //         layout: 'vertical',
    //         align: 'right',
    //         verticalAlign: 'middle'
    //     },
    //
    //     tooltip: {
    //         formatter: function () {
    //             return 'Pour une difficulté de <b>' + this.x +
    //                 '</b> les chances de réussite critique sont de <b>' + this.y + '%</b>' +
    //                 ' pour ' + this.series.name;
    //         }
    //     },
    //
    //     plotOptions: {
    //         series: {
    //             label: {
    //                 connectorAllowed: false
    //             },
    //             pointStart: 1
    //         }
    //     },
    //
    //     series: [{
    //         name: 'd20',
    //         data: data.regular.critical_success.strict_superiority.d20
    //     }, {
    //         name: '2d10',
    //         data: data.regular.critical_success.strict_superiority.d10
    //     }],
    //
    //     responsive: {
    //         rules: [{
    //             condition: {
    //                 maxWidth: 500
    //             },
    //             chartOptions: {
    //                 legend: {
    //                     layout: 'horizontal',
    //                     align: 'center',
    //                     verticalAlign: 'bottom'
    //                 }
    //             }
    //         }]
    //     }
    //
    // });
}