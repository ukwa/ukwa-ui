<!doctype html>
<html lang="en">
<head>
    <%@include file="head4.jsp" %>
    <title>UKWA Categories V4</title>
</head>
<body>
<h1 class="py-4 px-4">UKWA: Categories for Collections - other components available to use</h1>

<div class="row py-4 px-4">
    <div class="col">
        <a href="index" class="btn btn-dark" role="button">Home</a>
        <a href="collection" class="btn btn-dark" role="button">List all topics and themes</a>

    </div>

</div>

<div class="container">


    <div class="row align-items-start">
        <div class="col">
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Categories</li>
                </ol>
            </nav>


        </div>

    </div>
    <!-- Content here -->
    <div class="row align-items-start">
        <div class="col">
            <ul class="list-group">
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    History
                    <span class="badge bg-primary rounded-pill">14</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Arts and Culture
                    <span class="badge bg-primary rounded-pill">2</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-center">
                    Places
                    <span class="badge bg-primary rounded-pill">1</span>
                </li>
            </ul>
        </div>
        <div class="col">
            <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <div class="spinner-grow" style="width: 3rem; height: 3rem;" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <div class="spinner-grow text-success" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <div class="spinner-grow text-danger" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <div class="spinner-grow text-warning" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
            <button class="btn btn-primary" type="button" disabled>
                <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                <span class="visually-hidden">Loading...</span>
            </button>
            <button class="btn btn-dark" type="button" disabled>
                <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                Loading...
            </button>
        </div>
    </div>

    <div class="row align-items-start py-4">
        <div class="col">
            <span class="badge bg-primary">Primary</span>
            <span class="badge bg-secondary">Secondary</span>
            <span class="badge bg-success">Success</span>
            <span class="badge bg-danger">Danger</span>
            <span class="badge bg-warning text-dark">Warning</span>
            <span class="badge bg-info text-dark">Info</span>
            <span class="badge bg-light text-dark">Light</span>
            <span class="badge bg-dark">Dark</span>
        </div>
    </div>

    <div class="row align-items-start py-4">
        <div class="col">
            <button type="button" class="btn btn-primary position-relative">
                Politics and Government
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
    99+
    <span class="visually-hidden">unread messages</span>

  </span>
            </button>
        </div>
        <div class="col">
            <button type="button" class="btn btn-primary position-relative">
                History
                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
    99+
    <span class="visually-hidden">unread messages</span>
  </span>
            </button>
        </div>
    </div>
    <div class="row align-items-start">
        <div class="col">
            <nav id="navbar-example3" class="navbar navbar-light bg-light flex-column align-items-stretch p-3">
                <a class="navbar-brand" href="#">Collections and Sub-Collections</a>
                <nav class="nav nav-pills flex-column">
                    <a class="nav-link" href="#item-1">British Stand-up Comedy Archive</a>
                    <nav class="nav nav-pills flex-column">
                        <a class="nav-link ms-3 my-1" href="#item-1-1">Agents and Production companies</a>
                        <a class="nav-link ms-3 my-1" href="#item-1-2">Comedians</a>
                        <a class="nav-link ms-3 my-1" href="#item-1-3">History of stand-up comedy</a>
                        <a class="nav-link ms-3 my-1" href="#item-1-4">Linda Smith Collection</a>
                        <a class="nav-link ms-3 my-1" href="#item-1-5">Mark Thomas Collection</a>
                        <a class="nav-link ms-3 my-1" href="#item-1-6">Researching stand-up comedy</a>
                        <a class="nav-link ms-3 my-1" href="#item-1-7">Richard Herring</a>
                        <a class="nav-link ms-3 my-1" href="#item-1-8">Stand-up news, listings and reviews</a>
                        <a class="nav-link ms-3 my-1" href="#item-1-9">Venues and Festivals</a>

                    </nav>
                    <a class="nav-link" href="#item-2">Cambridge Science</a>
                    <a class="nav-link" href="#item-3">EU Referendum</a>
                    <nav class="nav nav-pills flex-column">
                        <a class="nav-link ms-3 my-1" href="#item-3-1">Business & Trade Unions</a>
                        <a class="nav-link ms-3 my-1" href="#item-3-2">Opinion Polls</a>
                    </nav>
                </nav>
            </nav>

        </div>
        <div class="col">
        <div data-bs-spy="scroll" data-bs-target="#navbar-example3" data-bs-offset="0" tabindex="0">
                <h4 id="item-1">British Stand-up Comedy Archive</h4>
                <p>This is some placeholder content for the British Stand-up Comedy Archive page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It's repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.</p>
                <h5 id="item-1-1">Agents and Production companies</h5>
                <p>This is some placeholder content for the scrollspy page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It's repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.</p>
                <h5 id="item-1-2">Comedians</h5>
                <p>This is some placeholder content for the Comedians page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It's repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.</p>
                <h4 id="item-2">Cambridge Science</h4>
                <p>This is some placeholder content for the Cambridge Science page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It's repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.</p>
                <h4 id="item-3">EU Referendum</h4>
                <p>This is some placeholder content for the scrollspy page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It's repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.</p>
                <h5 id="item-3-1">Business & Trade Unions</h5>
                <p>This is some placeholder content for the Business & Trade Unions page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It's repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.</p>
                <h5 id="item-3-2">Opinion Polls</h5>
                <p>This is some placeholder content for the Opinion Polls page. Note that as you scroll down the page, the appropriate navigation link is highlighted. It's repeated throughout the component example. We keep adding some more example copy here to emphasize the scrolling and highlighting.</p>
            </div>
        </div>
    </div>



    <div class="row align-items-start">
        <div class="col">
            <span class="badge rounded-pill bg-primary">Primary</span>
            <span class="badge rounded-pill bg-secondary">Secondary</span>
            <span class="badge rounded-pill bg-success">Success</span>
            <span class="badge rounded-pill bg-danger">Danger</span>
            <span class="badge rounded-pill bg-warning text-dark">Warning</span>
            <span class="badge rounded-pill bg-info text-dark">Info</span>
            <span class="badge rounded-pill bg-light text-dark">Light</span>
            <span class="badge rounded-pill bg-dark">Dark</span>
        </div>
    </div>



    <div class="row align-items-start py-4">
        <div class="col-3 ">
            <ol class="list-group list-group-numbered">
                <li class="list-group-item d-flex justify-content-between align-items-start">
                    <div class="ms-2 me-auto">
                        <div class="fw-bold">British Stand-up Comedy Archive</div>
                        Description..
                    </div>
                    <span class="badge bg-primary rounded-pill">9</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-start">
                    <div class="ms-2 me-auto">
                        <div class="fw-bold">Cambridge Science</div>
                        Last updated: 2 days ago
                    </div>
                    <span class="badge bg-primary rounded-pill">14</span>
                </li>
                <li class="list-group-item d-flex justify-content-between align-items-start">
                    <div class="ms-2 me-auto">
                        <div class="fw-bold">EU Referendum</div>
                        Last updated: 29 days ago
                    </div>
                    <span class="badge bg-primary rounded-pill">14</span>
                </li>
            </ol>
        </div>
    </div>



</div>


<!-- Optional JavaScript; choose one of the two! -->

<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

<!-- Option 2: Separate Popper and Bootstrap JS -->
<!--
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
-->
</body>
</html>
