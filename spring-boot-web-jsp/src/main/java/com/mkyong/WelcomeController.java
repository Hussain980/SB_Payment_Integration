package com.mkyong;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;

@Controller
public class WelcomeController {

	// inject via application.properties
	@Value("${welcome.message:test}")
	private String message = "Hello World";

	@RequestMapping("/")
	public String welcome(Map<String, Object> model) {
		model.put("message", this.message);
		return "welcome";
	}

	@RequestMapping("/createPayment")
	@ResponseBody
	public String createOrder(@RequestBody Map<String, Object> data) throws RazorpayException {
		System.out.println("data >>>>>>> " + data);
		int amount = Integer.parseInt(data.get("amount").toString());
		
		/*
		 * I am using keyId and keySecret from Test Mode if you want to use this in live
		 * mode or production you have to generate key id and key secret for live mode
		 */
		RazorpayClient razorpayClient = new RazorpayClient("rzp_test_9pVkNjLKK3vvNH", "DSQicYWbs5zvfIHZq5JULxYb");

		// create order
		
		JSONObject options = new JSONObject();
		options.put("amount", amount*100);
		options.put("currency", "INR");
		options.put("receipt", "txn_123456");
		Order order = razorpayClient.Orders.create(options);
		System.out.println("order  "+order);
		return order.toString();
	}

}