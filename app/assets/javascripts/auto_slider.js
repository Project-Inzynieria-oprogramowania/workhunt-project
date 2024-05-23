document.addEventListener('DOMContentLoaded', function() {
    let counter = 1;
    document.getElementById('sr' + counter).checked = true;
    counter++;
    setInterval(function(){
        document.getElementById('sr' + counter).checked = true;
        counter++;
        if(counter > 4){
            counter = 1;
        } 
    }, 5000);
});