$(function(){
    $("#form").submit(function(){
        postMessage();
        return false;
    });
});

function postMessage () {
    var data = $('#form').serialize();
    $.ajax({
        url: 'api/new.json',
        type: 'POST',
        timeout: 1000,
        data : data,
        beforeSend : function(){ status('sending');},
        error: function(){status('error');},
        success: function(res){
            exchange();
        }
  });
    return false;
}

function exchange() {
    $.ajax({
        url: 'api/get.json',
        type: 'GET',
        timeout: 300000,
        beforeSend : function(){ status('receiving'); },
        error: function(){status('error');},
        success: function(res){
            obj = $.evalJSON(res);
            if (obj.message) {
                status('received');
                log(obj.name + ' says ' + obj.message + ' at ' + obj.created);
            } else {
                exchange();
            }
        }
  });
  return false;
};

function log(text, debug) {
    if(!text) return;
    $('#log').append('<li>'+text+'</li>')
};

function status (text) {
    text = '<small>'+text+'</small>';
    $('#status').html(text);
};
