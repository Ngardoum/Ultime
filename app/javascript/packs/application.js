// app/javascript/packs/application.js

//= require rails-ujs
// Importation des bibliothèques de Rails et des modules JavaScript essentiels
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

// Importation de Bootstrap et des dépendances JavaScript
import 'bootstrap';
// Import Bootstrap JavaScript files
import './bootstrap.bundle';
import './bootstrap.bundle.min';
import './bootstrap.min';

// Importation de jQuery et des plugins jQuery
import 'jquery';
import 'jquery-migrate-1.1.1';

// Importation des scripts personnalisés
import './script';
import './jquery.horizontalNav';

import '/superfish';
import '/jquery.equalheights';
import '/jquery.mobilemenu';
import '/jquery.easing.1.3';
import '/camera';
import '/jquery.mobile.customized.min';

// Initialisation des modules Rails
Rails.start();
Turbolinks.start();
ActiveStorage.start();


import "controllers"
