// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

import LocalTime from "local-time"
LocalTime.start()

import L from 'leaflet';

document.addEventListener('turbo:load', () => {
  if (document.getElementById('map')) {
    const map = L.map('map').setView([51.1657, 10.4515], 6);
    
    L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', {
        maxZoom: 19,
        minZoom: 5
    }).addTo(map);
    
    L.marker([52.5200, 13.4050]).addTo(map).bindPopup('Berlin');
    L.marker([48.1351, 11.5820]).addTo(map).bindPopup('Munich');
    L.marker([50.1109, 8.6821]).addTo(map).bindPopup('Frankfurt');
  }
});