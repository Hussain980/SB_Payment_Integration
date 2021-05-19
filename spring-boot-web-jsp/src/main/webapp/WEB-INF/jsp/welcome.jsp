<!DOCTYPE html>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">
<head>

<link rel="stylesheet" type="text/css"
	href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />

<!-- 
	<spring:url value="/css/main.css" var="springCss" />
	<link href="${springCss}" rel="stylesheet" />
	 -->
<c:url value="/css/main.css" var="jstlCss" />
<link href="${jstlCss}" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<body>

	<nav class="navbar navbar-inverse">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">Spring Boot</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#about">About</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container">

		<div class="starter-template">
			<h1>Spring Boot Payment Integration Example with RazorPay</h1>
			<h2>Message: ${message}</h2>
			<h2 class="text center">Start Payment</h2>
			<input type="text" id="amount" />
			<button onclick="paymentStart()" class="btn btn success">Pay</button>
			
		</div>

	</div>
	<!-- /.container -->


<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

	<script type="text/javascript"
		src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<script type="text/javascript">
		function paymentStart() {
			var amount = $("#amount").val();
			console.log("amount   " +amount);
			//alert(amount)
	
		$.ajax({

          url : "createPayment",
          data : JSON.stringify({amount:amount}),
          type : "POST",
          dataType : "json",
          contentType : "application/json",
          success : function(response){
               console.log(response);
               if(response.status === "created"){
            	   var options = {
            			    key: "rzp_test_9pVkNjLKK3vvNH", // Enter the Key ID generated from the Dashboard
            			    amount: response.amount, // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
            			    currency: "INR",
            			    name: "Hussain Mansoori",
            			    description: "Test Transaction",
            			 //   image: "https://example.com/your_logo",
            			    order_id: response.id, //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
            			    handler: function (response){
            			        console.log(response.razorpay_payment_id);
            			        console.log(response.razorpay_order_id);
            			        console.log(response.razorpay_signature)
            			        console.log("payment successful")
            			    },
            			    prefill: {
            			        name: "",
            			        email: "",
            			        contact: ""
            			    },
            			    notes: {
            			        address: "Demo Of Payment Integration"
            			    },
            			    theme: {
            			        color: "#3399cc"
            			    }
                   }

            	   var rzp1 = new Razorpay(options);
            	   rzp1.on('payment.failed', function (response){
            	           console.log(response.error.code);
            	           console.log(response.error.description);
            	           console.log(response.error.source);
            	           console.log(response.error.step);
            	           console.log(response.error.reason);
            	           console.log(response.error.metadata.order_id);
            	           console.log(response.error.metadata.payment_id);
            	           alert("oops payment failed!!!!!");
            	   });
            	   rzp1.open();
              }
          }
			});

		};
			
	</script>

</body>

</html>
