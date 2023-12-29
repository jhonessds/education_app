enum StatusCode {
  unknown('UNKNOWN', 0),
  connectionError('CONNECTION_ERROR', 10),
  notAuthenticated('NOT_AUTHENTICATED', 20),

  //1xx Informativo
  continues('CONTINUE', 100),
  switchingProtocol('SWITCHING_PROTOCOL', 101),
  processing('PROCESSING', 102),

  //2xx Sucesso
  ok('OK', 200),
  created('CREATED', 201),
  accepted('ACCEPTED', 202),
  nonAuthoritativeInformation('NON_AUTHORITATIVE_INFORMATION', 203),
  noContent('NO_CONTENT', 204),
  resetContent('RESET_CONTENT', 205),
  partialContent('PARTIAL_CONTENt', 206),
  multiStatus('MULTI_STATUS', 207),
  alreadyReported('ALREADY_REPORTED', 208),
  imUsed('IM_USED', 226),

  //3xx Redirecionamento
  multipleChoices('MULTIPLE_CHOICES', 300),
  movedPermanently('MOVED_PERMANENTLY', 301),
  found('FOUND', 302),
  seeOther('SEE_OTHER', 303),
  notModified('NOT_MODIFIED', 304),
  useProxy('USE_PROXY', 305),
  temporaryRedirect('TEMPORARY_REDIRECT', 307),
  permanentRedirect('PERMANENT_REDIRECT', 308),

  //4xx Erro no Cliente
  badRequest('BAD_REQUEST', 400),
  unauthorized('UNAUTHORIZED', 401),
  paymentRequired('PAYMENT REQUIRED', 402),
  forbidden('FORBIDDEN', 403),
  notFound('NOT_FOUND', 404),
  methodNotAllowed('METHOD_NOT_ALLOWED', 405),
  notAcceptable('NOT_ACCEPTABLE', 406),
  proxyAuthenticationRequired('PROXY_AUTHENTICATION_REQUIRED', 407),
  requestTimeout('REQUEST_TIMEOUT', 408),
  conflict('CONFLICT', 409),
  gone('GONE', 410),
  lengthRequired('LENGTH_REQUIRED', 411),
  preconditionFailed('PRECONDITION_FAILED', 412),
  payloadTooLarge('PAYLOAD_TOO_LARGE', 413),
  requestURITooLong('REQUEST_URI_TOO_LONG', 414),
  unsupportedMediaType('UNSUPPORTED_MEDIA_TYPE', 415),
  requestedRangeNotSatisfiable('REQUESTED_RANGE_NOT_SATISFIABLE', 416),
  expectationFailed('EXPECTATION FAILED', 417),
  iamATeapot('I_AM_A_TEAPOT', 418),
  misdirectedRequest('MISDIRECTED_REQUEST', 421),
  unprocessableEntity('UNPROCESSABLE_ENTITY', 422),
  locked('LOCKED', 423),
  failedDependency('FAILED_DEPENDENCY', 424),
  upgradeRequired('UPGRADE_REQUIRED', 426),
  preconditionRequired('PRECONDITION_REQUIRED', 428),
  tooManyRequests('TOO_MANY_REQUESTS', 429),
  requestHeaderFieldsTooLarge('REQUEST_HEADER_FIELDS_TOO_LARGE', 431),
  connectionClosedWithoutResponse('CONNECTION_CLOSED_WITHOUT_RESPONSE', 444),
  unavailableForLegalReasons('UNAVAILABLE_FOR_LEGAL_REASONS', 451),
  clientClosedRequest('CLIENT_CLOSED_REQUEST', 499),

  //5xx Erro no Servidor
  internalServerError('INTERNAL_SERVER_ERROR', 500),
  notImplemented('NOT_IMPLEMENTED', 501),
  badGateway('BAD_GATEWAY', 502),
  serviceUnavailable('SERVICE_UNAVAILABLE', 503),
  gatewayTimeout('GATEWAY_TIMEOUT', 504),
  httpVersionNotSupported('HTTP_VERSION_NOT_SUPPORTED', 505),
  variantAlsoNegociates('VARIANT_ALSO_NEGOCIATES', 506),
  insufficientStorage('INSUFFICIENT_STORAGE', 507),
  loopDetected('LOOP_DETECTED', 508),
  notExtended('NOT_EXTENDED', 510),
  networkAuthenticationRequired('NETWORK_AUTHENTICATION_REQUIRED', 511),
  networkConnectionTimeoutError('NETWORK_CONNECTION_TIMEOUT_ERROR', 599),
  firebase('FIREBASE', 600),
  cache('CACHE', 700),
  ;

  const StatusCode(this.name, this.value);

  final String name;
  final int value;

  @override
  String toString() => name;

  factory StatusCode.fromFirebase(String code) {
    switch (code) {
      case 'invalid-email':
      case 'missing-android-pkg-name':
      case 'missing-continue-uri':
      case 'missing-ios-bundle-id':
      case 'invalid-continue-uri':
      case 'unauthorized-continue-uri':
      case 'user-not-found':
      case 'user-disabled':
      case 'wrong-password':
      case 'email-already-in-use':
      case 'operation-not-allowed':
      case 'weak-password':
      case 'requires-recent-login':
      case 'user-mismatch':
      case 'invalid-credential':
      case 'invalid-verification-code':
      case 'invalid-verification-id':
        return StatusCode.firebase;
      default:
        return StatusCode.firebase;
    }
  }
  factory StatusCode.fromInt(int code) {
    switch (code) {
      case 10:
        return StatusCode.connectionError;
      case 20:
        return StatusCode.notAuthenticated;
      case 100:
        return StatusCode.continues;
      case 101:
        return StatusCode.switchingProtocol;
      case 102:
        return StatusCode.processing;
      case 200:
        return StatusCode.ok;
      case 201:
        return StatusCode.created;
      case 202:
        return StatusCode.accepted;
      case 203:
        return StatusCode.nonAuthoritativeInformation;
      case 204:
        return StatusCode.noContent;
      case 205:
        return StatusCode.resetContent;
      case 206:
        return StatusCode.partialContent;
      case 207:
        return StatusCode.multiStatus;
      case 208:
        return StatusCode.alreadyReported;
      case 226:
        return StatusCode.imUsed;
      case 300:
        return StatusCode.multipleChoices;
      case 301:
        return StatusCode.movedPermanently;
      case 302:
        return StatusCode.found;
      case 303:
        return StatusCode.seeOther;
      case 304:
        return StatusCode.notModified;
      case 305:
        return StatusCode.useProxy;
      case 307:
        return StatusCode.temporaryRedirect;
      case 308:
        return StatusCode.permanentRedirect;
      case 400:
        return StatusCode.badRequest;
      case 401:
        return StatusCode.unauthorized;
      case 402:
        return StatusCode.paymentRequired;
      case 403:
        return StatusCode.forbidden;
      case 404:
        return StatusCode.notFound;
      case 405:
        return StatusCode.methodNotAllowed;
      case 406:
        return StatusCode.notAcceptable;
      case 407:
        return StatusCode.proxyAuthenticationRequired;
      case 408:
        return StatusCode.requestTimeout;
      case 409:
        return StatusCode.conflict;
      case 410:
        return StatusCode.gone;
      case 411:
        return StatusCode.lengthRequired;
      case 412:
        return StatusCode.preconditionFailed;
      case 413:
        return StatusCode.payloadTooLarge;
      case 414:
        return StatusCode.requestURITooLong;
      case 415:
        return StatusCode.unsupportedMediaType;
      case 416:
        return StatusCode.requestedRangeNotSatisfiable;
      case 417:
        return StatusCode.expectationFailed;
      case 418:
        return StatusCode.iamATeapot;
      case 421:
        return StatusCode.misdirectedRequest;
      case 422:
        return StatusCode.unprocessableEntity;
      case 423:
        return StatusCode.locked;
      case 424:
        return StatusCode.failedDependency;
      case 426:
        return StatusCode.upgradeRequired;
      case 428:
        return StatusCode.preconditionRequired;
      case 429:
        return StatusCode.tooManyRequests;
      case 431:
        return StatusCode.requestHeaderFieldsTooLarge;
      case 444:
        return StatusCode.connectionClosedWithoutResponse;
      case 451:
        return StatusCode.unavailableForLegalReasons;
      case 499:
        return StatusCode.clientClosedRequest;
      case 500:
        return StatusCode.internalServerError;
      case 501:
        return StatusCode.notImplemented;
      case 502:
        return StatusCode.badGateway;
      case 503:
        return StatusCode.serviceUnavailable;
      case 504:
        return StatusCode.gatewayTimeout;
      case 505:
        return StatusCode.httpVersionNotSupported;
      case 506:
        return StatusCode.variantAlsoNegociates;
      case 507:
        return StatusCode.insufficientStorage;
      case 508:
        return StatusCode.loopDetected;
      case 510:
        return StatusCode.notExtended;
      case 511:
        return StatusCode.networkAuthenticationRequired;
      case 599:
        return StatusCode.networkConnectionTimeoutError;
      case 600:
        return StatusCode.firebase;
      case 700:
        return StatusCode.cache;
      default:
        return StatusCode.unknown;
    }
  }
}
