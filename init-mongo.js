// init-mongo.js
db = db.getSiblingDB('mdm'); // Wählt die Datenbank "mdm"

// Fügt ein Beispiel-Dokument hinzu
db.example_collection.insertOne({ name: "Test", value: 123 });
