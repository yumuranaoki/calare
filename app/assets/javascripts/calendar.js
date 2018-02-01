path = location.pathname
console.log(path)
var array = [];
var num = 0;
console.log(num)
console.log(array)

$(document).ready(function() {

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
        alert('Event: ' + calEvent.id);
        if ( confirm('are you sure to delete?') ) {
          $('#calendar').fullCalendar('removeEvents', calEvent.id );
          //delete_event(calEvent.id);
          array[calEvent.id]=null;
          console.log(array);
        }
      },
      selectable: true,
      selectHelper: true,
      select: function(start, end) {
        if(gon.is_first){
          alert("is_first = true");
          //ここでsubmision.is_first=false postして反映される？
          var eventData;
          eventData = {
            start: start,
            end: end,
            id: num
          };
          array.push(eventData);
          var textInput;
          console.log(array[num]['start']['_d']);
          num ++;
          $('#calendar').fullCalendar('renderEvent', eventData, true);
          $('#calendar').fullCalendar('unselect');
        }else{
          alert("is_first = false");
        };
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
      events: path + '/events.json'
    });

    submit = function(arr){
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
          array: arr,
        }
      }).done(function(data){
        alert("登録しました!");
      }).fail(function(data){
        alert("登録できませんでした。");
      });
    };

    $("#submission").on("click", function(){
      var newArray = [];
      for (var i = 0; i < array.length; i++) {
        if(array[i] !== null) newArray.push(array[i]);
      }
      alert(newArray.length);
      submit(newArray);
    });



});
