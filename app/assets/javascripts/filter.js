window.Filter = {
  scheduleFiltering: function(form, query) {
    return setTimeout(function() {
      form.submit();
    }, 300);
  }
};
