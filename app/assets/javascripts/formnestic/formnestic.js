var Formnestic = {
	getNumberOfShowingEntriesInATable: function(table) {
		var counter = 0;
		table.find('tbody:first').find("tr").each(function() {
      var dom = $(this);
      if(dom.css('display') != 'none' && dom.hasClass("formnestic-table-no-border") == false) {
        counter = counter + 1;
      }//end if
		});		
		return counter;
  },
  
	getNumberOfShowingEntriesInANestedModelContainer: function(listContainer) {
		var counter = 0;
		listContainer.children().each(function() {
      var dom = $(this);
      if(dom.css('display') != 'none') {
        counter = counter + 1;
      }//end if
		});		
		return counter;
  },
    
  removeAListEntry: function(deleteEntryLinkDom) {
    deleteEntryLinkDom = $(deleteEntryLinkDom);
    var listContainer = deleteEntryLinkDom.parents('div.formnestic-nested-model-container:first').find("div.formnestic-list-entries-container");
    var nestedModelContainer = listContainer.parent();
    
    var addRowLinkContainer = nestedModelContainer.find("div.formnestic-list-new-entry-link-container:first");
    var numberOfShowingEntries = Formnestic.getNumberOfShowingEntriesInANestedModelContainer(listContainer);
    var minNumberOfEntries = parseInt(nestedModelContainer.attr("min_entry"), 10);
    var maxNumberOfEntries = parseInt(nestedModelContainer.attr("max_entry"), 10);    
    
    if (minNumberOfEntries !== -1) {
      if (numberOfShowingEntries <= minNumberOfEntries) {
        alert(table.attr("min_entry_alert_message"));
        return;
      }//end if
    }//end if
    
    var _this = this;
    deleteEntryLinkDom.parents("fieldset.inputs:first").find(".formnestic-destroy-input").val("true");
    deleteEntryLinkDom.parents("fieldset.inputs:first").fadeOut(function() {
      var counter = _this.addOddAndEventClassForListContainer(listContainer);
      if (maxNumberOfEntries !== -1) {
        if (counter <= maxNumberOfEntries) {
          return addRowLinkContainer.removeClass("hidden");
        } else {
          return addRowLinkContainer.addClass("hidden");
        }//end else
      } else {
        return addRowLinkContainer.removeClass("hidden");
      }//end else          
    });
  },
  
  removeATableEntry: function(deleteEntryLinkDom) {
    deleteEntryLinkDom = $(deleteEntryLinkDom);
    var table = deleteEntryLinkDom.parents("table:first");
    var addRowLink = table.find("a.formnestic-add-row-field-link:first");
    var numberOfShowingEntries = Formnestic.getNumberOfShowingEntriesInATable(table);
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
  
  addOddAndEventClassForListContainer: function(listContainer) {
		var counter = 0;
		listContainer.children().each(function() {
      var dom = $(this);
			if(dom.css('display') !== 'none') {
				$(this).removeClass("formnestic-odd-row formnestic-even-row").addClass(counter % 2 == 0 ? "formnestic-even-row" : "formnestic-odd-row")
				counter = counter + 1;
      }
		});
		return counter;    
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
  
  addNewListEntry: function(linkDom, associationName, content) {
    var newId = new Date().getTime();
    var regexp = new RegExp("new_" + associationName, "g");
    var linkDomContainer = $(linkDom).parent();
    var _this = this;
    var listContainer = linkDomContainer.parents('div.formnestic-nested-model-container:first').find("div.formnestic-list-entries-container");
    var nestedModelContainer = listContainer.parent();
    var maxNumberOfEntries = parseInt(nestedModelContainer.attr('max_entry'), 10);
    
    $(content.replace(regexp, newId)).appendTo(listContainer).css({display: 'none'}).fadeIn(function() {
      var counter = _this.addOddAndEventClassForListContainer(listContainer);
      if (maxNumberOfEntries !== -1) {
        if (counter >= maxNumberOfEntries) {
          return linkDomContainer.addClass("hidden");
        }//end if
      } else {
        return linkDomContainer.removeClass("hidden");
      }//end else
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