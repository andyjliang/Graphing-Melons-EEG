<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="dynamoDBAccessor.DynamoDBAccessor"
%>
<jsp:useBean id='data' class = 'dynamoDBAccessor.DynamoDBAccessor' scope = 'session'/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	
	    <title>Melon Design Challenge</title>
	
	    <!-- Bootstrap Core CSS -->
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	
	    <!-- Custom CSS -->
	    <link href="css/main.css" rel="stylesheet">
	
	    <!-- Custom Fonts -->
	    <link href="http://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
	    <link href='http://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
	    <link href='http://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
	    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
		
		<script language="JavaScript" src="js/jquery-2.1.1.min.js"></script>
		<script language="JavaScript" src="js/knockout-3.2.0.js"></script>
		<script language="JavaScript" src="js/main.js"></script>
</head>
<body id="page-top" class="index">
	<script type="text/javascript">
	var focusObj = []; 
<%
	Iterator<String> it = data.getSelectAttr().iterator();
	while(it.hasNext()){
%>
		focusObj.push(<%=it.next()%>)
<%
	}
%>
	var debugging;
	</script>

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <a class="navbar-brand page-scroll" href="#page-top">Melon</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a class="page-scroll" href="#contact">Contact</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Header -->
    <header>
        <div id= "headerContainer" class="container">
            <div class="intro-text">
                <div class="intro-lead-in cover">Think Brightly!</p></div>
                <div class="intro-heading cover">See Focus</p></div>
                <button id="graphButton" data-bind="click: toggleBackground" class="page-scroll btn btn-xl cover">view</button>
            </div>
        </div>
    </header>
    
    <!-- Main -->
    <div class="spacer"> </div>
	  <div id="graph">
		  <div data-bind="foreach: points">
		  	
		  		<!-- Ball Structure -->
		    	<div class="ball" data-bind="style: 
		    		{
		    			left: $parent.leftShiftInc($element),
		    			bottom: $parent.bottomShiftInc($element, y), 
		    			MozAnimationDelay: $index() + 's'
		    		}">
		        	<a href="#"><small data-bind="text: tooltip"></small></a>
		        </div>
		        
		        <!-- Pulse Structure -->
		        <div class="pulse" data-bind="style: 
		        	{ 	
		        		left: $parent.leftShiftInc($element),
		        		bottom: $parent.bottomShiftInc($element, y), 
		        		MozAnimationDelay: $index() + 's'
		        	}"></div>
		    	<div class="line" data-bind="style: 
		    		{
		    			left: $parent.leftShiftInc($element),
		    			bottom: $parent.bottomShiftInc($element, y), 
		    			MozAnimation:'move' + $index() + ' 1s ' + $index() + 's linear forwards',
		    			transform: $parent.angle($index())
		    		}" ></div>
		    	
		  </div>
	  
	  	  <button data-bind="click: myFunc" >Debug</button>
	 	</div>
</body>
</html>