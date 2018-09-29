function repositoriesFilters() {
  const submitForm = function() {
    $('#search-form').submit();
  };

  $('#form-filter').on('change', submitForm);
};


document.addEventListener("turbolinks:load", function () {
  repositoriesFilters();
});
