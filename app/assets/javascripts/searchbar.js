var sendToast = function(title, message) {
    let toastTitle = $(".toast-header")
    toastTitle[0].innerText = title
    let toastBody = $(".toast-body")
    toastBody[0].innerText = message
    $('.toast').toast('show');
}

var updateCartCount = function(decrease){
    let count = $("#cartCount")
    if (decrease){
      count[0].innerText = 0
    }
    else{
      count[0].innerText = parseInt(count[0].innerText) + 1
    }
}

var removeFrmArr = function(arr, value) {
    var index = arr.indexOf(value);
    if (index > -1) {
      arr.splice(index, 1);
    }
    return arr;
}