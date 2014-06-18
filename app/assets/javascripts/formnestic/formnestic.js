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
    var addRowLink = table.find("a.formnestic-add-row-field-link:first");
    var numberOfShowingEntries = Formnestic.getNumberOfShowingEntriesInATable(table) - 1;
    var minNumberOfEntries = parseInt(table.attr("min_entry"), 10);
    var maxNumberOfEntries = parseInt(table.attr("max_entry"), 10);    
    if (minNumberOfEntries !== -1) {
      if (numberOfShowingEntries <= minNumberOfEntries) {
        alert(table.attr("min_entry_alert_message"));
        return;
      }//end if
    }//end if
    
    var _this = this;
    deleteEntryLinkDom.parents("tr:first").find(".formnestic-destroy-input").val("true");
    deleteEntryLinkDom.parents("tr:first").fadeOut(function() {
      var counter = _this.addOddAndEvenClassForTable(table);
      if (maxNumberOfEntries !== -1) {
        if (counter <= maxNumberOfEntries) {
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
      var trDom = $(this);
			if(trDom.css('display') !== 'none' && trDom.hasClass("formnestic-table-no-border") == false) {
				$(this).removeClass("formnestic-odd-row formnestic-even-row").addClass(counter % 2 == 0 ? "formnestic-even-row" : "formnestic-odd-row")
				counter = counter + 1;
      }
		});
    
    return counter;
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
        var counter = _this.addOddAndEvenClassForTable(table);
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