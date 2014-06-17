var Formnestic = {
	getNumberOfShowingEntriesInATable: function(table) {
		var counter = 0;
		table.find('tbody:first').find("tr").each(function() {
      if($(this).css('display') != 'none') {
        counter = counter + 1;
      }//end if
		});		
		return counter;
  },
  
  removeATableEntry: function(deleteEntryLinkDom) {
    deleteEntryLinkDom = $(deleteEntryLinkDom);
    var table = deleteEntryLinkDom.parents("table:first");
    var addRowLink = table.find("a.formnestic-add-field-link:first");
    var numberOfShowingEntries = Formnestic.getNumberOfShowingEntriesInATable(table) - 1;
    var minNumberOfEntries = parseInt(table.attr("min_entry"), 10);
    if (minNumberOfEntries !== -1) {
      if (number_of_showing_entries <= minNumberOfEntries) {
        alert(addRowLink.attr("data-min-entry-alert"));
        return;
      }//end if
    }//end if
    
    var _this = this;
    deleteEntryLinkDom.parents("tr:first").find(".formnestic-destroy-input").val("true");
    deleteEntryLinkDom.parents("tr:first").fadeOut(function() {
      var counter = 0;
      $(this).parents("tbody:first").find("tr").each(function() {
        if ($(this).css('display') !== 'none') {
          $(this).removeClass("odd").removeClass("even").addClass(counter % 2 === 0 ? "even" : "odd");
          counter = counter + 1;
        }//end if
      });
      
      _this.addOddAndEvenClassForTable(table);
      if (addRowLink.attr("data-max-entry") && parseInt(addRowLink.attr("data-max-entry"), 10) !== -1) {
        if (counter <= parseInt(addRowLink.attr("data-max-entry"), 10)) {
          return addRowLink.removeClass("hidden");
        } else {
          return addRowLink.addClass("hidden");
        }//end else
      } else {
        return addRowLink.removeClass("hidden");
      }//end else          
    });
  },
  
  addOddAndEvenClassForTable: function(table) {
    var counter = 0;
		$(table).find("tbody:first").find("tr").each(function() {
			if($(this).css('display') !== 'none') {
				$(this).removeClass("formnestic-odd-row formnestic-even-row").addClass(counter % 2 == 0 ? "formnestic-even-row" : "formnestic-odd-row")
				counter = counter + 1;
      }
		});
  },
  
  addNewTableEntry: function(linkDom, associationName, content) {
    var newId = new Date().getTime();
    var regexp = new RegExp("new_" + associationName, "g");
    var linkDomjQuery = $(linkDom);
    var _this = this;
    var table = linkDomjQuery.parents('table:first');
    $(content.replace(regexp, newId)).
      insertBefore(linkDomjQuery.parents("tr:first"))
      .css({display: 'none'})
      .fadeIn(function() {
        _this.addOddAndEvenClassForTable(table);
        var maxNumberOfEntries = parseInt(table.attr('max_entry'), 10);
        if (maxNumberOfEntries !== -1) {
          if (counter >= maxNumberOfEntries) {
            return linkDomjQuery.addClass("hidden");
          }//end if
        } else {
          return linkDomjQuery.removeClass("hidden");
        }//end else
        
      });
  }
}