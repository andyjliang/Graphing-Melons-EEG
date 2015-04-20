# Graphing-Melons-EEG
Using CSS animation tricks with JavaEE's JSP/Servlets technology to process and dynamically visualize data through DOM style tinkering
<b>Objective:</b> Using CSS3 animation tricks and clear MVVM modeling KnockoutJS structure with JavaEE's JSP/Servlets technology to process and dynamically visualize data through DOM style tinkering

<b>Project Specifics:</b> Adapting from <i>Alessio Atzeni's</i> CSS3 technology of directly mapping html elements through instructions from raw JSON data, I applied the concepts to Melon's EEG server data.

<b>The flow:</b>

1) index.jsp loads main page with dropdown list for selecting Melon user's userID

2) Choosing a userID, and selecting "View", Servlet will send request attribute back to DynamoDBAccessor.java as param to get server datablock with many attributes from DynamoDB with AWS DynamoDBImplInterface.java

3) DynamoDBAccessor iterates through and processes large data block to remap and create ArrayList datablock with only the necessary variables

4) index.jsp passes Java datablock over to JSON focusObj

5) KnockoutJS data-binds focusObj to ko.observableArray() to allow view model access

6) Click event triggers jquery's toggleBackground function (stored within the view model) which replaces viewport with the appropriate graphing objects

7) In "content" class div, knockoutjs iterates through graph element html code elegantly with data-binded styles for positioning, orientation, and coloring, and text for tooltips.

8) Within the view model, the positioning increment values and delay tickers are stored within the data-bind

TODO for UI/backend improvement:

Client-side

Make tooltip of timestamp more presentable – currently shown to make it obviously mapped to timestamp variable Color the points to show quality of data AMD use requireJS for JS files Create Login

Server-side

Create cache for data Create OOP structure for datasource structure, form, graph, dom visual elements Create servlets for selecting all the different attributes to view
