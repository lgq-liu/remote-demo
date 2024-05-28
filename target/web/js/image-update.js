 //选择图片
function selectImage() {
    document.getElementById("fileInput").click();
}
//显示图片
function showImage() {
    var fileInput = document.getElementById("fileInput");
    if (fileInput.files && fileInput.files[0]) {
        var file = fileInput.files[0];
        // 检查图片类型
        var fileType = file.type;
        if (!(fileType === "image/png" || fileType === "image/gif"||fileType==="image/jpg"||fileType==="image/jpeg")) {
            alert("请选择正确的图片格式：.png, .gif, .jpg(jpeg)");
            return;
        }
        var reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById("image").src = e.target.result;
        };
        reader.readAsDataURL(fileInput.files[0]);
    }
}
