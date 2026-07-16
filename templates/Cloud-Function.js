// Template: Firebase Cloud Function v2 callable (or equivalent serverless callable).
// Replace <functionName> with the camelCase function name.

const { onCall, HttpsError } = require('firebase-functions/v2/https');
const { logger } = require('firebase-functions');
const admin = require('firebase-admin');

exports.<functionName> = onCall(
  {
    region: 'us-central1',
    timeoutSeconds: 30,
    memory: '256MiB',
    enforceAppCheck: false, // set true once App Check (or equivalent) is wired
  },
  async (request) => {
    // 1. Auth
    if (!request.auth) {
      throw new HttpsError('unauthenticated', 'Authentication required.');
    }
    const userId = request.auth.uid;

    // 2. Input validation
    const { /* destructure expected fields */ } = request.data ?? {};
    // throw new HttpsError('invalid-argument', '...') if invalid

    // 3. Authorization (path-specific)
    // verify the user can do this action

    // 4. Work
    try {
      const db = admin.firestore();
      // ...
      logger.info('<functionName>: success', { uid: userId });
      return { success: true /* payload */ };
    } catch (err) {
      // sanitize before returning
      logger.error('<functionName>: failed', { uid: userId, err: err.message });
      throw new HttpsError('internal', 'Operation failed.');
    }
  }
);
