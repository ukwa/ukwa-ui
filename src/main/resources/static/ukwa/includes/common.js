//common on load functions
$(document).ready(function(e) {
	
	//bootstrap tooltips
	$('[data-toggle="tooltip"]').tooltip(); 
	$('[data-toggle="tooltip"]').click(function(e) { e.stopPropagation(); });
	
	//radio and check button keyboard
    $(".form-check-cont").each(function(index, element) {
        $(this).on("keypress", function(e) {
			e.stopImmediatePropagation();
			$(this).find("input[type=radio], input[type=checkbox]").trigger("click");
		});
    });
	
	//main menu
	$(".main-menu-button").click(function(e) {
        $(".main-menu").addClass("active");
		$(".main-menu-block").addClass("active");
    });
	
	$(".main-menu-close").click(function(e) {
        $(".main-menu").removeClass("active");
		$(".main-menu-block").removeClass("active");
    });
	
	//sidebar collapse
	$("#toggle-sidebar").click(function(e) {
		if ($(this).hasClass("open")) {
			$(this).addClass("closed");
			$(this).removeClass("open");
			$(".sidebar-collapse").addClass("open");
		} else {
			$(this).addClass("open");
			$(this).removeClass("closed");
			$(".sidebar-collapse").removeClass("open");
		}
	});
	
	//scroll top
	$(".up-button").click(function(e) {
		$("html, body").animate({ scrollTop: 0 }, 600);
	});
	
	//about video
	$("#play-about-video").click(function(e) {
		$("html, body").animate({ scrollTop: "0px" });
        $(".about-full-video-container").fadeIn("slow");
		$("#about-full-video")[0].play();
		$("html").css("overflow","hidden");
    });
	
	$("#close-about-video").click(function(e) {
        $(".about-full-video-container").fadeOut("slow");
		$("#about-full-video")[0].pause();
		$("html").css("overflow","auto");
    });
	
	//replace broken images for collections
	$(".coll-img").each(function(index, element) {
        $(this).on('error', function() {
			var old_img=$(this).attr('src');
			$(this).unbind("error").attr("src", "img/collections/collection_default.png");
			console.log(old_img+' replaced with default image.');
		});
    });
	
	//match height for collection headings and descriptions
	$('.img-square-caption').matchHeight();
	$('.collection-heading').matchHeight();	
	
	//collection description readmore
	$(".collection-readmore-down").each(function(index, element) {
        $(this).click(function(e) {
            e.preventDefault(); //don't activate link to collection

			$(".img-square-caption").addClass("shadow"); //add shadow to all elements in case some is missing
			parentElem=$(this).parent().parent();
			$(".collection-description").height(parentElem.height());
			$(".collection-description > .collection-description-content").text($(this).parent().attr("data-descript"));
			$(".collection-description").css("width", parentElem.width()+40);
			$(".collection-description").css("top", parentElem.offset().top);
			$(".collection-description").css("left", parentElem.offset().left);
			$(".collection-description").css("display", "block");
			parentElem.removeClass("shadow");
			if ($(".collection-description-content").height()>parentElem.height()) {
				$(".collection-description").height($(".collection-description-content").height());
			} else {
				$(".collection-description").height(parentElem.height());
			}
			$(this).blur();
			
        });
    });
	
	$(".collection-readmore-up").each(function(index, element) {
        $(this).click(function(e) {
            e.preventDefault(); //don't activate link to collection
			$(".collection-description").css("display", "none");
			$(".img-square-caption").addClass("shadow");	
			$(this).blur();
        });
    });	
	
	$(window).resize(function(e) {
        $(".collection-description").css("display", "none"); //on resize close collection descript in order for it not to fall apart
		$(".img-square-caption").addClass("shadow");
    });
	
	
	//add default HTML document type filter
	$("#search_form").submit(function(e) {
		$(this).append('<input type="hidden" name="content_type" value="html" />');
    });
	
});