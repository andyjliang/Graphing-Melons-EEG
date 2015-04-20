<%@page import="java.util.HashMap"%>
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
		<script language="JavaScript" src="js/dropdown.js"></script>
</head>
<body id="page-top" class="index">

	<!-- Passing Server Data to JSON -->
	
	<script type="text/javascript">
	var focusObj = []; 
<%
	Iterator<HashMap<String, String>> it = data.getSelectAttr().iterator();
	HashMap<String, String> hm; 
	while(it.hasNext()){
		hm = it.next();
%>
		// retrieving & putting into JSON the variables:
		// focus1, dataQuality, maxVoltage1, timestamp
		focusObj.push({'focus1': <%=hm.get("focus1")%>, 
						'dataQuality': <%=hm.get("dataQuality")%>, 
						'maxVoltage1': <%=hm.get("maxVoltage1")%>, 
						'timestamp': '<%=hm.get("timestamp")%>' 
						});
<%
	}
%>
	//debugger;
	</script>

    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <a class="navbar-brand page-scroll" href="http://www.thinkmelon.com/">Melon</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a class="page-scroll" href="http://andyjliang.github.io/Graphing-Melons-EEG/">Andy Liang</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Header -->
    <header>
        <div id= "headerContainer" class="container">
            <div class="intro-text">
                <div class="intro-lead-in">Think Brightly!</p></div>
                <div class="intro-heading">See Focus</p></div>
                <div class="btn-group">
				  <button type="button" class="page-scroll btn btn-default btn-xl dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
				    View <span class="caret"></span>
				  </button>
				  <ul class="dropdown-menu" role="menu">
				    <li id="graphButton" class="dropdown-item" data-bind="click: toggleBackground"><a href="#">Hrt85AC1L7</a></li>
				  </ul>
				</div>
            </div>	
         </div>
    </header>
    
    
    <!-- Main -->
    <div class="content">
	  <div id="graph">
	  
	  	  <!-- Threshold line -->
    	  <div class="threshold"></div>
    	  

            
    	  <!-- Graph line -->
		  <div data-bind="foreach: points">
		  	
		  		<!-- Ball Structure -->
		    	<div class="ball" data-bind="style: 
		    		{
		    			left: $parent.leftShiftInc($element),
		    			bottom: $parent.bottomShiftInc($element, focus1), 
		    			MozAnimationDelay: $index() * .1 + 's'
		    		}">
		        	<a href="#"><small data-bind="text: timestamp + 'quality: ' + dataQuality"></small></a>
		        </div>
		        
		        <!-- Pulse Structure -->
		        <div class="pulse" data-bind="style: 
		        	{ 	
		        		left: $parent.leftShiftInc($element),
		        		bottom: $parent.bottomShiftInc($element, focus1), 
		        		MozAnimationDelay: $index() * .1 + 's'
		        	}"></div>
		    	<div class="line" data-bind="style: 
		    		{
		    			left: $parent.leftShiftInc($element),
		    			bottom: $parent.bottomShiftInc($element, focus1), 
		    			MozAnimation:'move' + $index() + ' .1s ' + $index() * .1 + 's linear forwards',
		    			transform: $parent.angle($index())
		    		}" ></div>
		    	
		  </div>
		  
		      	  <!-- Graph banner -->
    	  <div class="navbar-header page-scroll banner">
                <a class="navbar-brand page-scroll score-report" href="http://www.thinkmelon.com/">
				Great Job Focusing! 
				<br/><br/>
				Your Concentration Score is: 
				<br/><br/>
				<i class="score" data-bind="text:sum.toFixed(2)"></i>
				</a>
           </div>
           
           <!-- Share -->
           <a class="share" href="https://www.facebook.com/sharer/sharer.php?u=https://youtu.be/9NGBG29fse4">
           J'Amazing!
           <br/>
           <i class="share-small">
           &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp Click here
           <br/>
           &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp  &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
           Share Your Results!
           </i>
           </a>
	 	</div>
	 </div>
</body>
</html>