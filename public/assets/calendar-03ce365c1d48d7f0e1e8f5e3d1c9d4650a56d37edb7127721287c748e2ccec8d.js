path = location.pathname
console.log(path)

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
        right: 'month,agendaWeek,agendaDay'
      },

      eventClick: function(calEvent) {
        alert('Event: ' + calEvent.id);
        if ( confirm('are you sure to delete?') ) {
          $('#calendar').fullCalendar('removeEvents', calEvent.id );
          delete_event(calEvent.id);
        }
      },
      selectable: true,
      selectHelper: true,
      select: function(start, end) {
        var title = prompt('イベントを追加');
        var l = 25;
        var c = "abcdefghijklmnopqrstuv0123456789";
        var cl = c.length;
        var id = "";
        for(var i=0; i<l; i++){
        id += c[Math.floor(Math.random()*cl)];
        }
        var eventData;
        if (title) {
          eventData = {
            title: title,
            start: start,
            end: end
          };
          $('#calendar').fullCalendar('renderEvent', eventData, true);
          $('#calendar').fullCalendar('unselect');
          create_event(title, start, end, id);
        }
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

});
