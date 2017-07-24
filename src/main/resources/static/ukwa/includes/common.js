//common on load functions

function checkboxSize() {
	$(".form-check-cont").each(function(index, element) {
		$(this).height($(this).find("label").height()+10);
    });	
}

function rearangeQuestions() {
	
	$(".q-description").each(function(index, element) {
		//if mobile
		if ($(window).width()<768) {
			var elem=$(this).detach();
			elem.insertAfter($(".q-question[data-descriptid='"+$(this).attr("id")+"']"));		
		} else {	
			var id=parseInt($(this).attr("id"));
			var target=Math.ceil(id / 3)*3;
			var elem=$(this).detach();
			elem.insertAfter($(".q-question[data-descriptid='"+target+"']").parent());	
		}
    });
	
}

$(document).ready(function(e) {
	
	//bootstrap tooltips
	$('[data-toggle="tooltip"]').tooltip(); 
	$('[data-toggle="tooltip"]').click(function(e) { e.stopPropagation(); }) //stopps click on the "?" button from expanding/collapsing the filters;
	
	//remove tabindex from radio/check boxes
	$(this).find("input[type=radio], input[type=checkbox]").attr("tabindex", "-1");
		
	//radio and check button keyboard
    $(".form-check-cont").each(function(index, element) {
        $(this).on("keypress", function(e) {
			e.stopImmediatePropagation();
			$(this).find("input[type=radio], input[type=checkbox]").trigger("click");
		});
    });
	
	//main menu
	$(".main-menu-button").click(function(e) {
        $(".main-menu, .main-menu-block").addClass("active");
		$("html").css("overflow", "hidden");
    });
	
	$(".main-menu-close").click(function(e) {
        $(".main-menu, .main-menu-block").removeClass("active");
		$("html").css("overflow", "auto");
    });
	
	//sidebar collapse
	$("#toggle-sidebar").click(function(e) {
		if ($(this).hasClass("open")) {
			$(this).addClass("closed").removeClass("open");
			$(".sidebar-collapse").addClass("open");
		} else {
			$(this).addClass("open").removeClass("closed");
			$(".sidebar-collapse").removeClass("open");
		}
	});
	
	//scroll top
	$(".up-button").on('click keyup', function(e) {
		if(e.which == 13 || e.which == 1) $("html, body").animate({ scrollTop: 0 }, 600);
	});
	
	//replace broken images for collections
	$(".coll-img").each(function(index, element) {
		var elem=$(this);
		$.get(elem.attr('src'))
		.fail(function() { 
			var old_img=elem.attr('src');
			elem.unbind("error").attr("src", "img/collections/collection_default.png");
			console.log(old_img+' replaced with default image.');
		})
    });
	
	
	//add default HTML document type filter
	$("#search_form").submit(function(e) {
		$(this).append('<input type="hidden" name="content_type" value="Web Page" />');
    });
	
	//FAQ 
	$(".q-question").each(function(index, element) {
       	$(this).click(function(e) {
			e.preventDefault();
			$(".q-description").hide();
			$(".q-question").removeClass("active");
			$(this).addClass("active");
			$("#"+$(this).attr("data-descriptid")).show();
			$('html, body').animate({
				scrollTop: $(this).offset().top
			}, 500);
		}); 
    });
	
	//cookies notice
	if (typeof $.cookie('cookies_accepted') === 'undefined' || $.cookie('cookies_accepted')!=="true") {
		$(".cookies-cont").show();
	} 
	
	//close cookie notice
	$("#btn_cookies").click(function(e) {
        $.cookie("cookies_accepted", "true", { expires: 365, path: '/' });
		$(".cookies-cont").hide();
    });
	
	//on load and resize
	$(window).on ("load resize", function(e) {
		checkboxSize(); //expand checkbox size to fit label content
		rearangeQuestions(); //rearange questions for mobile and desktop
    });
	
	//search highlighting
	if ($(".results-container").length!==0) {
	
		//every text section that needs highlighting has this class .results-for-hightlight
		$(".results-for-highlight").each(function(index, element) {
		
			var restext=$(this).html();
			var terms=$(".main-search-field").val().split(" ");
			var operators=["AND", "OR", "NOT", "and", "or", "not", "And", "Or", "Not"];
			var matches=[];
			var uniqueMatches=[];
			
			//match all search terms
			$.each(terms, function(i, term) {
				var rexp = new RegExp(term, 'gi');
				var current_match = restext.match(rexp);
				matches=matches.concat(current_match)
			});
			
			//remove duplicates
			$.each(matches, function(i, el){
				if($.inArray(el, uniqueMatches) === -1) uniqueMatches.push(el);
			});
			
			
			//replace with highlight style
			$.each(uniqueMatches, function(i, el){
				var rexp = new RegExp(el, 'g');
				if($.inArray(el, operators) === -1) restext=restext.replace(rexp, '<span class="results-highlight">'+el+'</span>');
			});
			
			$(this).html(restext);
		
		});
		
	}
	
	//No collection descript
	$(".collection-description").each(function(index, element) {
		if ($(this).text().trim()=="") {
				$(this).html('<span class="gray">'+$("#no-coll-description").val()+'</span>');
		}
	});
	
	//match height for collection headings and descriptions
	$('.collection-heading').matchHeight();	
	$('.img-square-caption').matchHeight();
	
});