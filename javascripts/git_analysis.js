    function parseGitAnalysis_count(url, title, id){
      $.ajax({
        type: 'GET',
        url: url,
        dataType: 'json',
        success: function(res){
            var count = res.count
            var num = new Array()
            var domain = new Array()
            Object.keys(count).forEach(function (key) {
                domain.push("%%.%% ("+ count[key] +") - "+ key)
                num.push(count[key])
            });
            pie(num,domain, title, id)
        }
      }); //ajax
    };

    /* @summary create pie chart
     * @param data Array
     * @param label Array
     */
    function pie(data,label, title, div_id){
          var r = Raphael(div_id),
          pie = r.piechart(130, 240, 100, data, 
            { legend: label,
              legendpos: "east"
            }
          );

          r.text(320, 100, title).attr({ font: "20px sans-serif" });
          pie.hover(function () {
            this.sector.stop();
            this.sector.scale(1.1, 1.1, this.cx, this.cy);

            if (this.label) {
              this.label[0].stop();
              this.label[0].attr({ r: 7.5 });
              this.label[1].attr({ "font-weight": 800 });
            }
          }, function () {
            this.sector.animate({ transform: 's1 1 ' + this.cx + ' ' + this.cy }, 500, "bounce");

            if (this.label) {
                this.label[0].animate({ r: 5 }, 500, "bounce");
                this.label[1].attr({ "font-weight": 400 });
            }
          });
    };
