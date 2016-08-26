<?php if(Auth::LoggedIn()) {
	header("Location: /index.php/profile");
} else {
	header("Location: /index.php/login");
} ?>