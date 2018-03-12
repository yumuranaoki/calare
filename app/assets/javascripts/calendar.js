var num = 0;
var nump = 10000;
var tmp_str = '';
var test = [];

$(document).on('turbolinks:load', function(){

    var path = location.pathname;
    var path_next = path.split('/')[1];
    var path_id = path.split('/')[2];

    App.notification = App.cable.subscriptions.create({
      channel: "NotificationChannel"
    }, {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        //通知のマークを出したい（reactかなー）

      },
      speak: function(name, starttime, endtime) {
        return this.perform('speak', {
          name: name,
          starttime: starttime,
          endtime: endtime
        })
      }
    })


    //function
    delete_event = function (id) {
      $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
        var token;
        if (!options.crossDomain) {
          token = $('meta[name="csrf-token"]').attr('content');
          if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
          }
        }
      });
      $.ajax({
        type: "post",
        url: "/deleteevent",
        data: {
          id: id,
          _method: 'DELETE'
        }
      }).done(function(data){
        alert("削除しました!");
      }).fail(function(data){
        alert("削除できませんでした。");
      });
    };

    create_event = function(title, start, end, id){
      $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
        var token;
        if (!options.crossDomain) {
          token = $('meta[name="csrf-token"]').attr('content');
          if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
          }
        }
      });
      $.ajax({
        type: "post",
        url: "/createevent",
        data: {
          title: title,
          start: start.toISOString(),
          end: end.toISOString(),
          calendar_id: id,
        }
      }).done(function(data){
        alert("登録しました!");
      }).fail(function(data){
        alert("登録できませんでした。");
      });
    };

    edit_event = function (start, end, id) {
      $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
        var token;
        if (!options.crossDomain) {
          token = $('meta[name="csrf-token"]').attr('content');
          if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
          }
        }
      });
      $.ajax({
        type: "post",
        url: "/editevent",
        data: {
          start: start.toISOString(),
          end: end.toISOString(),
          id: id,
          _method: 'PATCH'
        }
      }).done(function(data){
        alert("変更しました!");
      }).fail(function(data){
        alert("変更できませんでした。");
      });
    };

    add_from_submission = function(start, end, id, access_id){
      $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
        var token;
        if (!options.crossDomain) {
          token = $('meta[name="csrf-token"]').attr('content');
          if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
          }
        }
      });
      $.ajax({
        type: "post",
        url: "/addfromsubmission",
        data: {
          start: start.toISOString(),
          end: end.toISOString(),
          id: id,
          access_id: access_id
        }
      }).done(function(data){
        alert("登録しました!");
      }).fail(function(data){
        alert("登録できませんでした。");
      });
    };


    delete_from_submission = function(id, access_id) {
      $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
        var token;
        if (!options.crossDomain) {
          token = $('meta[name="csrf-token"]').attr('content');
          if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
          }
        }
      });
      $.ajax({
        type: "post",
        url: "/deletefromsubmission",
        data: {
          id: id,
          access_id: access_id,
          _method: 'DELETE'
        }
      }).done(function(data){
        alert("削除しました!");
      }).fail(function(data){
        alert("削除できませんでした。");
      });
    }

    determine = function(id, access_id, event_id, memberFlag) {
      $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
        var token;
        if (!options.crossDomain) {
          token = $('meta[name="csrf-token"]').attr('content');
          if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
          }
        }
      });
      $.ajax({
        type: "post",
        url: "/determinedetaildate",
        data: {
          id: id,
          access_id: access_id,
          event_id: event_id,  //google calendarに登録するためのid
          memberFlag: memberFlag
        }
      }).done(function(data){
        alert("送信しました!");
      }).fail(function(data){
        alert("送信できませんでした。");
      });
    }

    edit_submitted_event = function(start, end, id, access_id) {
      $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
        var token;
        if (!options.crossDomain) {
          token = $('meta[name="csrf-token"]').attr('content');
          if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
          }
        }
      });
      $.ajax({
        type: "post",
        url: "/editsubmittedevent",
        data: {
          starttime: start.toISOString(),
          endtime: end.toISOString(),
          id: id,
          access_id: access_id,
          _method: 'PATCH'
        }
      }).done(function(data){
        alert("送信しました!");
      }).fail(function(data){
        alert("送信できませんでした。");
      });
    }


    //function




    //ページによる場合分け
    if (path == '/you' || path == '/participating' || path == '/invited' ){
      $('#calendar').fullCalendar({
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'agendaWeek,month'
        },
        defaultView: 'agendaWeek',
        allDayText: 'all day',
        dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
        views: {
          week: {
            titleFormat: 'YYYY年M月'
          },
          month: {
            titleFormat: 'YYYY年M月'
          },
          day: {
            titleFormat: 'YYYY年M月D日'
          }
        },

        eventClick: function(calEvent) {
          $('#calendar').fullCalendar('removeEvents', calEvent.id );
          var del_num = 2*calEvent.id;
          test[del_num]=null;
          test[(del_num+1)]=null;
          console.log(test);
        },
        selectable: true,
        selectHelper: true,


        select: function(start, end) {
            var eventData;
            eventData = {
              start: start,
              end: end,
              id: num,
              color: "#cecece"
            };
            tmp_start = eventData['start']['_d'] + '';
            tmp_end = eventData['end']['_d'] + '';
            test.push(tmp_start, tmp_end);
            console.log(test);
            num ++;
            $('#calendar').fullCalendar('renderEvent', eventData, true);
            $('#calendar').fullCalendar('unselect');
        },
        editable: true,
        eventResize: function(event) {
          var start = event.start;
          var end = event.end;
          var id = event.id;
          test[2*id] = start['_d'] + '';
          test[2*id+1] = end['_d'] + '';
          console.log(test);
        },
        eventDrop: function(event) {
          var start = event.start;
          var end = event.end;
          var id = event.id;
          test[2*id] = start['_d'] + '';
          test[2*id+1] = end['_d'] + '';
          console.log(test);
        },
        navLinks: true,
        timeFormat: 'H:mm',
        slotLabelFormat: 'H:mm',
        timezone: 'Asia/Tokyo',
        events: '/events.json'
      });

  //submissionのページで作成者
  }else if (path_next == 's' && gon.selfcreate) {
    var memberFlag = gon.more_than_two
    var finishedFlag = gon.finishedFlag
    var expiredFlag = gon.expiredFlag
    var submission_id = gon.submission_id
    var answeredFlag = gon.answered

    $("#expiration").on("click", function(){
      if (confirm("本当に締め切りますか")) {
        expiredFlag = true
        $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
          var token;
          if (!options.crossDomain) {
            token = $('meta[name="csrf-token"]').attr('content');
            if (token) {
              return jqXHR.setRequestHeader('X-CSRF-Token', token);
            }
          }
        });
        $.ajax({
          type: "post",
          url: "/expire",
          data: {
            submission_id: gon.submission_id,
          }
        }).done(function(data){
          ;
        }).fail(function(data){
          ;
        });
      }
    })

      $('#calendar').fullCalendar({
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'agendaWeek,month'
        },
        defaultView: 'agendaWeek',
        allDayText: 'all day',
        dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
        views: {
          week: {
            titleFormat: 'YYYY年M月'
          },
          month: {
            titleFormat: 'YYYY年M月'
          },
          day: {
            titleFormat: 'YYYY年M月D日'
          }
        },

        eventClick: function(calEvent) {
          //締め切っているかどうか
          console.log(expiredFlag)
          console.log(answeredFlag)
          if (!answeredFlag) {
            if (confirm("本当に消しますか？")) {
              delete_from_submission(calEvent.id, path_id)
              $('#calendar').fullCalendar('removeEvents', calEvent.id );
            }
          } else if (anseweredFlag && expiredFlag && memberFlag && !finishedFlag) {
            //締め切っていて複数人向けのグループなら、作成者のクリックで決定
            if (confirm('本当にこの日程でよろしいですか？')) {
              calEvent.color = "rgb(214, 76, 97)"
              $('#calendar').fullCalendar('updateEvent', calEvent);
              var l = 25;
              var c = "abcdefghijklmnopqrstuv0123456789";
              var cl = c.length;
              var event_id = "";
              for(var i=0; i<l; i++){
              event_id += c[Math.floor(Math.random()*cl)];
              }
              App.notification.speak('作成者', calEvent.start, calEvent.end);
              finishedFlag = true
              determine(calEvent.id, path_id, event_id, memberFlag);
            }
          }
        },
        selectable: (!answeredFlag) ? true : false,
        selectHelper: true,

        //selectを新しい日程の提示に使う
        select: function(start, end) {
          var l = 25;
          var c = "abcdefghijklmnopqrstuv0123456789";
          var cl = c.length;
          var id = "";
          for(var i=0; i<l; i++){
          id += c[Math.floor(Math.random()*cl)];
          }
          var eventData;
          eventData = {
            start: start,
            end: end,
            id: id,
            color: '#c0c0c0'
          };
          $('#calendar').fullCalendar('renderEvent', eventData, true);
          $('#calendar').fullCalendar('unselect');
          add_from_submission(start, end, id, path_id);
        },
        editable: (!answeredFlag) ? true : false,
        eventResize: function(event) {
          var start = event.start;
          var end = event.end;
          var id = event.id;
          edit_submitted_event(start, end, id);
        },
        eventDrop: function(event) {
          var start = event.start;
          var end = event.end;
          var id = event.id;
          edit_submitted_event(start, end, id, path_id);
        },
        navLinks: true,
        timeFormat: 'H:mm',
        slotLabelFormat: 'H:mm',
        timezone: 'Asia/Tokyo',
        eventSources: [
            {
                 url: "/events.json",
                 color: '#000080',
            },
            {
                 url: path + '/d.json',
            }
       ]
      });

    //submissionページで招待者
    }else if(path_next == 's' && !gon.selfcreate){
      var memberFlag = gon.more_than_two
      var finishedFlag = gon.finishedFlag
      var expiredFlag = gon.expiredFlag
      var submission_id = gon.submission_id
      var detail_dates_arr = gon.detail_dates_arr
      var detail_dates_id_arr = gon.detail_dates_id_arr
      var detail_date_auto_arr = gon.detail_date_auto_arr
      var oneclickBool = false;
      var anseweredFlag = gon.answered;


      //送信するボタンに対するaction
      $("#submit-detaildates").on("click", function(){
        if (confirm("本当に送信しますか")) {
          $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
            var token;
            if (!options.crossDomain) {
              token = $('meta[name="csrf-token"]').attr('content');
              if (token) {
                return jqXHR.setRequestHeader('X-CSRF-Token', token);
              }
            }
          });
          $.ajax({
            type: "post",
            url: "/submitdetaildates",
            data: {
              submission_id: submission_id,
              data: detail_dates_arr
            }
          }).done(function(data){
            ;
          }).fail(function(data){
            ;
          });
        }
      })

      //ワンクリックで選択するボタンに対するaction
      $("#select-by-oneclick").on("click", function(){
        //一旦全部削除してから、追加
        if (!oneclickBool) {
          $('#calendar').fullCalendar( 'removeEventSource', path + '/d.json')
          $('#calendar').fullCalendar( 'addEventSource', path + '/da.json')
          detail_dates_arr = detail_date_auto_arr
          $("#select-by-oneclick").text("選択したイベントを解除する");
        } else {
          $('#calendar').fullCalendar( 'removeEventSource', path + '/da.json')
          $('#calendar').fullCalendar( 'addEventSource', path + '/d.json')
          detail_dates_arr = gon.detail_dates_arr
          $("#select-by-oneclick").text("ワンクリックで選択する");
        }
        oneclickBool = !oneclickBool

      })

      console.log(detail_dates_arr)

      $('#calendar').fullCalendar({
        header: {
          left: 'prev,next today',
          center: 'title',
          right: 'agendaWeek,month'
        },
        defaultView: 'agendaWeek',
        allDayText: 'all day',
        dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
        views: {
          week: {
            titleFormat: 'YYYY年M月'
          },
          month: {
            titleFormat: 'YYYY年M月'
          },
          day: {
            titleFormat: 'YYYY年M月D日'
          }
        },

        //ここで選択させる

        eventClick: function(calEvent) {
          //２人ページ
          if (!memberFlag) {
            if ( confirm('本当にこの日程でよろしいですか？') ) {
              $("#input-modal").modal("show");
              $("#title-button").on("click", function(){
                var name = $("#title-input").val();
                $("#input-modal").modal("hide");
                var l = 25;
                var c = "abcdefghijklmnopqrstuv0123456789";
                var cl = c.length;
                var event_id = "";
                for(var i=0; i<l; i++){
                event_id += c[Math.floor(Math.random()*cl)];
                }
                App.notification.speak(name, calEvent.start, calEvent.end);
                finishedFlag = true
                console.log(finishedFlag)
                determine(calEvent.id, path_id, event_id, memberFlag);
            });
            }
          //締め切り前で複数
          } else if (!expiredFlag && memberFlag) {
            //clickでhashの配列を操作、毎回カレンダーのviewを変える
            if (detail_dates_id_arr.includes(calEvent.id)) {
              var selected_color;
              for (var i in detail_dates_arr) {
                if (detail_dates_arr[i]['id'] == calEvent.id) {
                  detail_dates_arr[i]['selected'] = !detail_dates_arr[i]['selected']
                  selected_bool = detail_dates_arr[i]['selected'];
                }
              }

              calEvent.title = (selected_bool) ? calEvent.title + 1 : calEvent.title - 1,
              calEvent.color = (selected_bool) ? "rgb(26, 211, 236)" : "#cecece"
              $('#calendar').fullCalendar('updateEvent', calEvent);
            }
          }

        },
        selectable: false,
        selectHelper: false,
        //selectを新しい日程の提示に使う。（当面は一方向）
        select: function(start, end) {
        },
        navLinks: true,
        timeFormat: 'H:mm',
        slotLabelFormat: 'H:mm',
        timezone: 'Asia/Tokyo',
        eventSources: [
            {
                 url: "/events.json",
                 color: '#000080'
            },
            {
                 url: path + '/d.json'
            }
       ]
      });
    }

    //submitに関する
    submit = function(title, arr, radioVal){
      $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
        var token;
        if (!options.crossDomain) {
          token = $('meta[name="csrf-token"]').attr('content');
          if (token) {
            return jqXHR.setRequestHeader('X-CSRF-Token', token);
          }
        }
      });
      $.ajax({
        type: "post",
        url: "/submit",
        data: {
          title: title,
          array: arr,
          radio_val: radioVal
        }
      }).done(function(data){
        ;
      }).fail(function(data){
        ;
      });
    };

    $("#submission").on("click", function(){
      var radioVal = $("input[name=member]:checked").val();
      console.log(radioVal);
      $("#input-modal").modal("show");
      $("#title-button").on("click", function(){

        var title = $("#title-input").val();
        $("#input-modal").modal("hide");
        var newArray = [];
        for (var i = 0; i < test.length; i++) {
          var tmp = test[i];
          if(tmp !== null) newArray.push(tmp);
        }
        console.log(newArray)
        submit(title, newArray, radioVal);
      })
    });

    //resetに関する
    $("#reset").on("click", function(){
      $('#calendar').fullCalendar('removeEvents');
      $('#calendar').fullCalendar('addEventSource', "/events.json");
      test = [];


    })

});
