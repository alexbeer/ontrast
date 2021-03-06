// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require moment
//= require bootstrap-datetimepicker
//= require fancybox
//= require jquery-ui
//= require load-image.all.min
//= require canvas-to-blob.min
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require jquery.fileupload-process
//= require jquery.fileupload-image
//= require ZeroClipboard
//= require upload
//= require moment
//= require_tree .

if(window.s3PresignedPosts === undefined)
  window.s3PresignedPosts = [{ url: '' }];

$(document).on('ready page:load', function() {
  $('input.date').parents('.input-group').addClass('date');
  $('input.date').parents('.input-group').datetimepicker({
    format: 'MM/DD/YYYY'
  });

  $('a.submission').fancybox();

  $('.copy-url-button').click(function(e) { e.preventDefault(); })
  clip = new ZeroClipboard($('.copy-url-button'));

  $('.contest-countdown').each(function(i, el) {
    var t = moment.duration(parseInt($(el).attr('data-milliseconds-left')));
    setInterval(function() {
      t.subtract(1, 's');
      $(el).text('Ends ' + t.humanize(true));
    }, 1000);
  });
});
