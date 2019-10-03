$('#item_picture').bind('change', function(){
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > 2) {
    alert('最大ファイルサイズは2MBです。小さいファイルを選択してください。')
  }
});