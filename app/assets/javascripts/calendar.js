var num = 0;
var nump = 10000;
var tmp_str = '';
var test = [];


$(document).on('turbolinks:load', function(){

    var path = location.pathname;
    var path_next = path.split('/')[1];
    var path_id = path.split('/')[2];


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

    determine = function(id, access_id, event_id) {
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
          event_id: event_id
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
          if ( confirm('are you sure to delete?') ) {
            $('#calendar').fullCalendar('removeEvents', calEvent.id );
            var del_num = 2*calEvent.id;
            test[del_num]=null;
            test[(del_num+1)]=null;
            console.log(test);
          }
        },
        selectable: true,
        selectHelper: true,


        select: function(start, end) {
            var eventData;
            eventData = {
              start: start,
              end: end,
              id: num
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
          edit_event(start, end, id);
        },
        navLinks: true,
        timeFormat: 'H:mm',
        slotLabelFormat: 'H:mm',
        timezone: 'Asia/Tokyo',
        events: '/events.json'
      });

  //submissionのページで作成者
  }else if (path_next == 's' && gon.selfcreate) {
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

        //ここで削除する
        eventClick: function(calEvent) {
          if ( confirm('are you sure to delete?') ) {
            $('#calendar').fullCalendar('removeEvents', calEvent.id );
            //DBからも消す
            delete_from_submission(calEvent.id, path_id);
          }
        },
        selectable: true,
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
        editable: true,
        //ここで日程を修正するようにする
        eventResize: function(event) {
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
                 color: '#c0c0c0'
            }
       ]
      });

    //submissionページで招待者
    }else if(path_next == 's' && !gon.selfcreate){
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
          if ( confirm('are you sure to pick this?') ) {
            var l = 25;
            var c = "abcdefghijklmnopqrstuv0123456789";
            var cl = c.length;
            var event_id = "";
            for(var i=0; i<l; i++){
            event_id += c[Math.floor(Math.random()*cl)];
            }
            //色を変える処理
            determine(calEvent.id, path_id, event_id);
          }
        },
        selectable: true,
        selectHelper: true,

        //selectを新しい日程の提示に使う
        select: function(start, end) {

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
                 color: '#c0c0c0'
            }
       ]
      });
    }





    //submitに関する
    submit = function(title, arr){
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
          array: arr
        }
      }).done(function(data){
        ;
      }).fail(function(data){
        ;
      });
    };

    $("#submission").on("click", function(){
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
        submit(title, newArray);
      })
    });



});
