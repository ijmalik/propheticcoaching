//= require active_admin/base
//= require "documentViewer/libs/yepnope.1.5.3-min.js"
//= require "documentViewer/libs/pdfjs/pdf.js"
//= require "documentViewer/libs/pdfjs/compatibility.js"
//= require "documentViewer/ttw-document-viewer.min.js"
//= require jquery_highlight
//= require fullcalendar.min.js


$(document).ready(function () {
  $("#search_ebook").on("ajax:success",function (e, data, status, xhr) {
    console.log("search ebook success");

    $("#result_table").html(xhr.responseText);
    $("td#tags").highlight($("input#query").val());
    $('#pdfContainer').empty();
    var documentViewer = $('#pdfContainer').documentViewer(
        {
          path: "/assets/documentViewer/",
          debug: true
        }
    );

    $("td #pdf-view").click(function () {
      var document_id = $(this).closest('td').prev('td').prev('td').text(),
          url = "/ebooks/" + document_id + "/pdf.pdf",
          currentPage = parseInt($(this).text());
      console.log(document_id);
      console.log(currentPage);
      documentViewer.load(url, {currentPage: currentPage});
    });

  }).bind("ajax:error", function (e, xhr, status, error) {
        console.log("search ebook error");
        return $("#search_ebook").append("<p>ERROR</p>");
      });

//  $('#calendar').fullCalendar({
//    // put your options and callbacks here
//  })


  $('#new_event').click(function (event) {
    event.preventDefault();
    var url = $(this).attr('href');
    $.ajax({
      url: url,
      beforeSend: function () {
        $('#loading').show();
      },
      complete: function () {
        $('#loading').hide();
      },
      success: function (data) {
        $('#create_event').replaceWith(data['form']);
        $('#create_event_dialog').dialog({
          title: 'New Event',
          modal: true,
          width: 500,
          close: function (event, ui) {
            $('#create_event_dialog').dialog('destroy')
          }
        });
      }
    });
  });

  var event_id = $("#calendar").attr('mentee_id');
  $('#calendar').fullCalendar({
    editable: true,
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    },
    defaultView: 'agendaWeek',
    height: 500,
    slotMinutes: 15,
    loading: function (bool) {
      if (bool)
        $('#loading').show();
      else
        $('#loading').hide();
    },
    events: "/mentees/"+event_id+"/events/get_events",
    timeFormat: 'h:mm t{ - h:mm t} ',
    dragOpacity: "0.5",
    eventDrop: function (event, dayDelta, minuteDelta, allDay, revertFunc) {
      moveEvent(event, dayDelta, minuteDelta, allDay);
    },

    eventResize: function (event, dayDelta, minuteDelta, revertFunc) {
      resizeEvent(event, dayDelta, minuteDelta);
    },

    eventClick: function (event, jsEvent, view) {
      showEventDetails(event);
    }
  });

  function moveEvent(event, dayDelta, minuteDelta, allDay){
    jQuery.ajax({
      data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&all_day=' + allDay + '&authenticity_token=' + authenticity_token,
      dataType: 'script',
      type: 'post',
      url: "/mentees/"+event_id+"/events/move"
    });
  }

  function resizeEvent(event, dayDelta, minuteDelta){
    jQuery.ajax({
      data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&authenticity_token=' + authenticity_token,
      dataType: 'script',
      type: 'post',
      url: "/mentees/"+event_id+"/events/resize"
    });
  }

  function showEventDetails(event){
    $('#event_desc').html(event.description);
    $('#edit_event').html("<a href = 'javascript:void(0);' onclick ='editEvent(" + event.id + ")'>Edit</a>");
    if (event.recurring) {
      title = event.title + "(Recurring)";
      $('#delete_event').html("&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete Only This Occurrence</a>");
      $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + true + ")'>Delete All In Series</a>")
      $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", \"future\")'>Delete All Future Events</a>")
    }
    else {
      title = event.title;
      $('#delete_event').html("<a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete</a>");
    }
    $('#desc_dialog').dialog({
      title: title,
      modal: true,
      width: 500,
      close: function(event, ui){
        $('#desc_dialog').dialog('destroy')
      }

    });

  }


  function editEvent(event_id){
    jQuery.ajax({
      url: "/events/" + event_id + "/edit",
      success: function(data) {
        $('#event_desc').html(data['form']);
      }
    });
  }

  function deleteEvent(event_id, delete_all){
    jQuery.ajax({
      data: 'authenticity_token=' + authenticity_token + '&delete_all=' + delete_all,
      dataType: 'script',
      type: 'delete',
      url: "/events/" + event_id,
      success: refetch_events_and_close_dialog
    });
  }

  function refetch_events_and_close_dialog() {
    $('#calendar').fullCalendar( 'refetchEvents' );
    $('.dialog:visible').dialog('destroy');
  }

  function showPeriodAndFrequency(value){

    switch (value) {
      case 'Daily':
        $('#period').html('day');
        $('#frequency').show();
        break;
      case 'Weekly':
        $('#period').html('week');
        $('#frequency').show();
        break;
      case 'Monthly':
        $('#period').html('month');
        $('#frequency').show();
        break;
      case 'Yearly':
        $('#period').html('year');
        $('#frequency').show();
        break;

      default:
        $('#frequency').hide();
    }




  }
  $(document).ready(function(){
    $('#create_event_dialog, #desc_dialog').on('submit', "#event_form", function(event) {
      var $spinner = $('.spinner');
      event.preventDefault();
      $.ajax({
        type: "POST",
        data: $(this).serialize(),
        url: $(this).attr('action'),
        beforeSend: show_spinner,
        complete: hide_spinner,
        success: refetch_events_and_close_dialog,
        error: handle_error
      });

      function show_spinner() {
        $spinner.show();
      }

      function hide_spinner() {
        $spinner.hide();
      }

      function handle_error(xhr) {
//        alert(xhr.responseText);
      }
    })
  });


});