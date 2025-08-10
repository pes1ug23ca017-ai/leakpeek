/**
 * Minimal Firebase Cloud Function stub for breach checking.
 * Replace the mock with your crawler integration and security.
 */
const functions = require("firebase-functions");

exports.checkBreach = functions.https.onCall(async (data, context) => {
  if (!context.auth) {
    throw new functions.https.HttpsError("unauthenticated", "Sign in required");
  }
  const query = (data && data.query) || "";
  // Return mock data for now
  if (!query) return [];
  return [
    { source: "MockSite", date: new Date().toISOString(), type: "emails", breached: true },
    { source: "AnotherSource", date: new Date().toISOString(), type: "none", breached: false },
  ];
});


