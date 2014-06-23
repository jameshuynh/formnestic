var Formnestic = {
	getNumberOfShowingEntriesInATable: function(table) {
		var counter = 0;
		table.find('tbody:first').find("tr").each(function() {
      var dom = $(this);
      if(!dom.hasClass("formnestic-deleted-row") && !dom.hasClass("formnestic-table-no-border")) {
        counter = counter + 1;
      }//end if
		});		
		return counter;
  },
  
	getNumberOfShowingEntriesInANestedModelContainer: function(listContainer) {
		var counter = 0;
		listContainer.children().each(function() {
      var dom = $(this);
      if(!dom.hasClass("formnestic-deleted-row")) {
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
    
    if (minNumberOfEntries !== -1 && numberOfShowingEntries <= minNumberOfEntries) {
      return alert(nestedModelContainer.attr("min_entry_alert_message"));
    }//end if
    
    var entryContainer = deleteEntryLinkDom.parents("fieldset.inputs:first");
    entryContainer.addClass("formnestic-deleted-row");
    entryContainer.find(".formnestic-destroy-input").val("true");
    
    var counter = this.addOddAndEventClassForListContainer(listContainer);
    if (maxNumberOfEntries !== -1 && counter >= maxNumberOfEntries) {
      addRowLinkContainer.addClass("formnestic-hidden");
    } else {
      addRowLinkContainer.removeClass("formnestic-hidden");
    }//end else
    
    entryContainer.fadeOut(function() {});
  },
  
  removeATableEntry: function(deleteEntryLinkDom) {
    deleteEntryLinkDom = $(deleteEntryLinkDom);
    var table = deleteEntryLinkDom.parents("table:first");
    var addRowLink = table.find("a.formnestic-add-row-field-link:first");
    var numberOfShowingEntries = Formnestic.getNumberOfShowingEntriesInATable(table);
    var minNumberOfEntries = parseInt(table.attr("min_entry"), 10);
    var maxNumberOfEntries = parseInt(table.attr("max_entry"), 10);    
    if (minNumberOfEntries !== -1 && numberOfShowingEntries <= minNumberOfEntries) {
        return alert(table.attr("min_entry_alert_message"));
    }//end if
    
    var trContainer = deleteEntryLinkDom.parents("tr:first");
    trContainer.find(".formnestic-destroy-input").val("true");
    trContainer.addClass("formnestic-deleted-row");
    var counter = this.addOddAndEvenClassForTable(table);
    if (maxNumberOfEntries !== -1 && counter >= maxNumberOfEntries) {
        addRowLink.addClass("formnestic-hidden");
    } else {
      addRowLink.removeClass("formnestic-hidden");
    }//end else
    trContainer.fadeOut(function() {});
  },
  
  addOddAndEventClassForListContainer: function(listContainer) {
		var counter = 0;
		listContainer.children("fieldset").each(function() {
      var dom = $(this);
			if(!dom.hasClass("formnestic-deleted-row")) {
				dom.removeClass("formnestic-odd-row formnestic-even-row").addClass(counter % 2 === 0 ? "formnestic-even-row" : "formnestic-odd-row");
        var counterDom = dom.find("span.formnestic-li-fieldset-for-order:first");
        counter = counter + 1;
        counterDom.html(counter);
      }
		});
		return counter;    
  },
  
  addOddAndEvenClassForTable: function(table) {
    var counter = 0;
		$(table).find("tbody:first").find("tr").each(function() {
      var trDom = $(this);
			if(!trDom.hasClass('formnestic-deleted-row') && !trDom.hasClass("formnestic-table-no-border")) {
				trDom.removeClass("formnestic-odd-row formnestic-even-row").addClass(counter % 2 === 0 ? "formnestic-even-row" : "formnestic-odd-row")
				counter = counter + 1;
      }
		});
    
    return counter;
  },
  
  addNewListEntry: function(linkDom, associationName, content) {
    var newId = new Date().getTime();
    var regexp = new RegExp("new_" + associationName, "g");
    var linkDomContainer = $(linkDom).parent();
    var listContainer = linkDomContainer.parents('div.formnestic-nested-model-container:first').find("div.formnestic-list-entries-container");
    var nestedModelContainer = listContainer.parent();
    var maxNumberOfEntries = parseInt(nestedModelContainer.attr('max_entry'), 10);
    
    var entryContainer = $(content.replace(regexp, newId)).appendTo(listContainer);
    var counter = this.addOddAndEventClassForListContainer(listContainer);
    if (maxNumberOfEntries !== -1 && counter >= maxNumberOfEntries) {
      linkDomContainer.addClass("formnestic-hidden");
    } else {
      linkDomContainer.removeClass("formnestic-hidden");
    }//end else
    
    entryContainer.css({display: 'none'}).fadeIn();
  },
  
  addNewTableEntry: function(linkDom, associationName, content) {
    var newId = new Date().getTime();
    var regexp = new RegExp("new_" + associationName, "g");
    var linkDomjQuery = $(linkDom);
    var table = linkDomjQuery.parents('table:first');
    
    var entryContainer = $(content.replace(regexp, newId)).insertBefore(linkDomjQuery.parents("tr:first"));
      
    var counter = this.addOddAndEvenClassForTable(table);
    var maxNumberOfEntries = parseInt(table.attr('max_entry'), 10);
    if (maxNumberOfEntries !== -1 && counter >= maxNumberOfEntries) {
      linkDomjQuery.addClass("formnestic-hidden");
    } else {
      linkDomjQuery.removeClass("formnestic-hidden");
    }//end else
    
    entryContainer.css({display: 'none'}).fadeIn();
  }
};