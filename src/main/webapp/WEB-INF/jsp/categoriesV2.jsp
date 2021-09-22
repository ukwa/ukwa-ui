<!DOCTYPE html>

<html>
<head>
    <title>
        Categories V2
    </title>
    <%@include file="head2.jsp" %>
</head>

<body data-spy="scroll" data-target="#myScrollspy" data-offset="50">





<div class="container-fluid  text-center categories-cards">
    <h1 class="text-center">Browse Categories</h1>
    <div class="container text-center">
        <div class="row justify-content-start">

            <div class=" col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto" >
                <img src="img/categories/image9.png" alt="" />
                    <div class="ver_mas text-center">
                        <span  class="lnr lnr-eye"></span>
                    </div>
                    <article class="text-left">
                        <h2>Arts and Culture</h2>
                        <h4>Description...</h4>
                    </article>
            </div>

        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto">
            <div class="ver_mas text-center">
                <span  class="lnr lnr-eye"></span>
            </div>
            <article class="text-left">
                <h2>Arts and Culture</h2>
                <h4>Description...</h4>
            </article>
            <img src="img/categories/image9.png" alt="">
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto">
            <div class="ver_mas text-center">
                <span id="click3" class="lnr lnr-eye"></span>
            </div>
            <article class="text-left">
                <h2>HISTORY</h2>
                <h4>Description..</h4>
            </article>
            <img src="img/categories/image55.png" alt="">
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto">
            <div class="ver_mas text-center">
                <span class="lnr lnr-eye"></span>
            </div>
            <article class="text-left">
                <h2>Politics and Government</h2>
                <h4>Description ...</h4>
            </article>
            <img src="img/categories/image4.png" alt="">
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto">
            <div class="ver_mas text-center">
                <span class="lnr lnr-eye"></span>
            </div>
            <article class="text-left">
                <h2>Places</h2>
                <h4>Description ...</h4>
            </article>
            <img src="img/categories/image22.png" alt="">
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto">
            <div class="ver_mas text-center">
                <span class="lnr lnr-eye"></span>
            </div>
            <article class="text-left">
                <h2>Science Technology and Medicine</h2>
                <h4>Description ...</h4>
            </article>
            <img src="img/categories/image7.png" alt="">
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto">
            <div class="ver_mas text-center">
                <span class="lnr lnr-eye"></span>
            </div>
            <article class="text-left">
                <h2>Society and Community</h2>
                <h4>Description ...</h4>
            </article>
            <img src="img/categories/image1.png" alt="">
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto">
            <div class="ver_mas text-center">
                <span class="lnr lnr-eye"></span>
            </div>
            <article class="text-left">
                <h2>Sport and Recreation</h2>
                <h4>Description ...</h4>
            </article>
            <img src="img/categories/image10.png" alt="">
        </div>
        </div>
    </div>
</div>


<div class="container category-items" style="display:none;">
    <div class="row">
        <div class="col-4">
            <div class="list-group" id="list-tab" role="tablist">

                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 container_foto list-group-item list-group-item-action" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile">
                    <div class="ver_mas text-center">
                        <span id="click2" class="lnr lnr-eye"></span>
                    </div>
                    <article class="text-left">
                        <h2>Politics and Government</h2>
                        <h4>Category: Politics and Government</h4>
                    </article>
                    <img src="https://pbs.twimg.com/profile_images/781518570018648065/HcvZhTVn_400x400.jpg" alt="">
                </div>

                <a class="list-group-item list-group-item-action" id="list-messages-list" data-toggle="list" href="#list-messages" role="tab" aria-controls="messages">Politics and Government</a>
                <a class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="list" href="#list-settings" role="tab" aria-controls="settings">Go somewhere</a>
            </div>
        </div>
        <div class="col-8">
            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">
                    <a href="collection/2429" class="collection-link">
                        British Countryside
                    </a>
                    <a href="collection/45" class="collection-link">
                        Collection 2
                    </a>
                </div>
                <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
                    <a href="collection/2429" class="collection-link">
                        British Countryside
                    </a>
                    <a href="collection/45" class="collection-link">
                        Collection 2
                    </a>
                </div>
                <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">BBB Started ApplicationConfiguration in 3.57 seconds (JVM running for 4.38)</div>
                <div class="tab-pane fade" id="list-settings" role="tabpanel" aria-labelledby="list-settings-list">CCC Started ApplicationConfiguration in 3.57 seconds (JVM running for 4.38)</div>
            </div>
        </div>
    </div>

</div>





<button id="btn-hide-categories">Hide</button>



<!-- Option 1: jQuery and Bootstrap Bundle (includes Popper) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>

<script>
    $(document).ready(function(e) {


        $("#btn-hide-categories").click(function() {

            $(".categories-cards").toggle();
            $(".category-items").toggle();
        });

        $(".categories-cards").on('click', function(event){
            $(".categories-cards").fadeToggle();
            $(".category-items").fadeToggle();
        });

        $(".category-items").on('click', function(event){
            $(".categories-cards").fadeToggle();
            $(".category-items").fadeToggle();
        });
    });


</script>

</body>


</html>
