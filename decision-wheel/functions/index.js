const functions = require('firebase-functions');
const admin = require('firebase-admin');
const app = require('./app');

admin.initializeApp();

// Mount Express app; Hosting sends /api/* so baseUrl is /
exports.api = functions.https.onRequest(app);
