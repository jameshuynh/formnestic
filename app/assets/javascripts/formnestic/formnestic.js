var Formnestic = {
  addNewTableEntry: function(linkDom, associationName, content) {
    var newId = new Date().getTime();
    var regexp = new RegExp("new_" + associationName, "g");
    var linkDomjQuery = $(linkDom);
    linkDomjQuery.parents("tr:first").before(content.replace(regexp, new_id));
    counter = 0;
    linkDomjQuery.parents("tbody:first").find("tr").each(function() {
      $(this).removeClass("odd even").addClass(counter % 2 === 0 ? "even" : "odd");
      if ($(this).hasClass("tr-fieldset") && $(this).css("display") !== 'none') {
        return counter = counter + 1;
      }
    });
    
    if (linkDomjQuery.attr("data-max-entry") && parseInt($(link).attr("data-max-entry"), 10) !== -1) {
      if (counter >= parseInt(linkDomjQuery.attr("data-max-entry"), 10)) {
        return linkDomjQuery.addClass("hidden");
      }//end if
    } else {
      return linkDomjQuery.removeClass("hidden");
    } 
  }
}