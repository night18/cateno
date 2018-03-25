import { Template } from 'meteor/templating';
import { ReactiveVar } from 'meteor/reactive-var';

import './main.html';

Template.login.events({
	'submit #login': function(event){
		event.preventDefault();
		var usrname = event.target.name.value;
		var usrpwd = event.target.pwd.value;
		console.log("usrname:" + usrname + " password:" + usrpwd);

		if(usrname == "company"){
			Router.go('/dashboardc'); 
		}

	}
});


Template.company.events({
	'click #new_request': function () {
		Router.go('/request'); 
	}
});

Template.request.events({
	'click .leave-button': function () {
		Router.go('/dashboardc'); 
	},

	'change #rd_free': function(){
		$('.milestone').addClass("hide");
	},

	'change #rd_apvl': function(){
		$('.milestone').addClass("hide");
	},

	'change #rd_mlst': function(){
		$('.milestone').removeClass("hide");
	},

	'submit form': function(){
		
	}

});