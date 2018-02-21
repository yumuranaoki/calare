/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 369);
/******/ })
/************************************************************************/
/******/ ({

/***/ 369:
/*!******************************************************!*\
  !*** ./app/javascript/packs/action/formforgroup.jsx ***!
  \******************************************************/
/*! exports provided: handlePlus, handleCancel, afterHandleSubmit, handleSubmit, handleSecondCancel, afterHandleSecondSubmit, handleSecondSubmit, handleChange, onToggle */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
Object.defineProperty(__webpack_exports__, "__esModule", { value: true });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "handlePlus", function() { return handlePlus; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "handleCancel", function() { return handleCancel; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "afterHandleSubmit", function() { return afterHandleSubmit; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "handleSubmit", function() { return handleSubmit; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "handleSecondCancel", function() { return handleSecondCancel; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "afterHandleSecondSubmit", function() { return afterHandleSecondSubmit; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "handleSecondSubmit", function() { return handleSecondSubmit; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "handleChange", function() { return handleChange; });
/* harmony export (binding) */ __webpack_require__.d(__webpack_exports__, "onToggle", function() { return onToggle; });
var handlePlus = function handlePlus() {
  return {
    type: 'HANDLE_PLUS'
  };
};

var handleCancel = function handleCancel() {
  return {
    type: "HANDLE_CANCEL"
  };
};

var afterHandleSubmit = function afterHandleSubmit(data) {
  console.log("afterHandleSubmit");
  return {
    type: "AFTER_HANDLE_SUBMIT",
    data: data
  };
};

var handleSubmit = function handleSubmit(data) {
  console.log(data);
  return function (dispatch) {
    var csrfToken = document.getElementsByName('csrf-token').item(0).content;
    fetch('http://localhost:3000/date', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify(data)
    }).then(function () {
      return dispatch(afterHandleSubmit(data));
    });
  };
};

var handleSecondCancel = function handleSecondCancel() {
  return {
    type: "HANDLE_SECOND_CANCEL"
  };
};

var afterHandleSecondSubmit = function afterHandleSecondSubmit(starttime, endtime, timelength) {
  console.log("afterHandleSecondSubmit");
  return {
    type: "AFTER_HANDLE_SECOND_SUBMIT"
  };
};

var handleSecondSubmit = function handleSecondSubmit(starttime, endtime, timelength, accessId) {
  console.log(accessId);
  console.log(starttime);
  return function (dispatch) {
    var csrfToken = document.getElementsByName('csrf-token').item(0).content;
    fetch('http://localhost:3000/time', {
      method: 'POST',
      credentials: 'same-origin',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ starttime: starttime, endtime: endtime, timelength: timelength, accessId: accessId })
    }).then(function () {
      return dispatch(afterHandleSecondSubmit(starttime, endtime, timelength));
    });
  };
};

var handleChange = function handleChange(value, type) {
  return {
    type: "HANDLE_CHANGE",
    value: value,
    formType: type
  };
};

var onToggle = function onToggle() {
  return {
    type: "ON_TOGGLE"
  };
};

/***/ })

/******/ });
//# sourceMappingURL=formforgroup-72cf618ca5cac5e4dbe4.js.map