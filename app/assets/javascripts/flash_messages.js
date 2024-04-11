document.addEventListener('DOMContentLoaded', function() {
    // Получаем элемент flashContainer
    var flashContainer = document.getElementById('flashContainer');

    // Устанавливаем таймер на удаление элемента через 5 секунд
    setTimeout(function() {
        // Проверяем, существует ли flashContainer
        if (flashContainer) {
            // Удаляем flashContainer
            flashContainer.remove();
        }
    }, 5000); // 5000 миллисекунд = 5 секунд
});