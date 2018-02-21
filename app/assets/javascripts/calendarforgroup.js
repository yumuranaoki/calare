$(document).on('turbolinks:load', function(){

  //pathによる場合分けに使う
  var path = location.pathname;
  var path_next = path.split('/')[1];
  var path_id = path.split('/')[2];

  if (path_next == "g") {

    //共通の変数
    var selfcreate = gon.selfcreate
    var finishedFlag = gon.finished_flag;
    var multi = gon.multi;
    var expiredFlag = gon.expired_flag;
    var detail_dates_arr = gon.detail_dates_arr;
    var detail_dates_auto_arr = gon.detail_dates_auto_arr
    var detail_dates_id_arr = gon.detail_dates_id_arr;
    var oneclickBool = false;


    console.log(selfcreate)

    //function
    //作成者・招待者クリックイベント
    determine = function(id, eventId) {
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
        url: "/determine_by_i_from_g",
        data: {
          id: id,
          eventId: eventId,
          accessId: path_id
        }
      }).done(function(data){
        alert("決定しました!");
      }).fail(function(data){
        alert("決定できませんでした。");
      });
    };
    //作成者・招待者クリックイベント

    //招待者の送信するボタンに対するaction
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
          url: "/submitdetaildatesforgroup",
          data: {
            accessId: path_id,
            data: detail_dates_arr
          }
        }).done(function(data){
          ;
        }).fail(function(data){
          ;
        });
      }
    })
    //招待者の送信するボタンに対するaction

    //ワンクリックで選択するボタンに対するaction
    $("#select-by-oneclick").on("click", function(){
      //一旦全部削除してから、追加
      if (!oneclickBool) {
        $('#calendar').fullCalendar( 'removeEventSource', path + '/d.json')
        $('#calendar').fullCalendar( 'addEventSource', path + '/da.json')
        detail_dates_arr = detail_dates_auto_arr
        $("#select-by-oneclick").text("選択したイベントを解除する");
      } else {
        $('#calendar').fullCalendar( 'removeEventSource', path + '/da.json')
        $('#calendar').fullCalendar( 'addEventSource', path + '/d.json')
        detail_dates_arr = gon.detail_dates_arr
        $("#select-by-oneclick").text("ワンクリックで選択する");
      }
      oneclickBool = !oneclickBool
    })
    //ワンクリックで選択するボタンに対するaction

    //締め切るボタンに対するaction
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
          url: "/expiregroup",
          data: {
            aceess_id: path_id
          }
        }).done(function(data){
          ;
        }).fail(function(data){
          ;
        });
      }
    })
    //締め切るボタンに対するaction
    //function



    //作成者
    if (gon.selfcreate) {

      //共通のカレンダー部分
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
        //カレンダーの共通部分


        //ここで選択する
        eventClick: function(calEvent) {
          //複数人ページ && 締め切った後
          if (multi && expiredFlag && !finishedFlag) {
            if ( confirm('are you sure to pick this?') ) {
              var l = 25;
              var c = "abcdefghijklmnopqrstuv0123456789";
              var cl = c.length;
              var eventId = "";
              for(var i=0; i<l; i++){
                eventId += c[Math.floor(Math.random()*cl)];
              }
              finishedFlag = true
              determine(calEvent.id, eventId);
              };
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


    //招待者
    } else {
      console.log(multi)
      console.log(finishedFlag)

      //カレンダーの共通部分
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
        //カレンダーの共通部分


        //ここで選択させる
        eventClick: function(calEvent) {
          //２人ページ
          if (!multi && !finishedFlag) {
            if ( confirm('are you sure to pick this?') ) {
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
                finishedFlag = true
                console.log(finishedFlag)
                determine(calEvent.id, event_id);
            });
            }
          //締め切り前で複数
        } else if (!expiredFlag && multi) {
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

  }

})
