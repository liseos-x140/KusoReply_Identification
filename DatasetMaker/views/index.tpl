<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <title>クソリプ識別 テスト</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
</head>
<body>
  <header class="bg-info text-light">
    <h1 class="container-fluid pt-3 pb-2">クソリプデータセットメーカー</h1>
  </header>
  <main class="container-fluid">
    <div id="mainView">
    </div>
  </main>

  <!-- Modals -->
  <div class="modal" id="loginModal" tabindex="-1" role="dialog" data-backdrop="static">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">ログイン</h5>
        </div>
        <div class="modal-body">
          <p>ユーザ名を入力してください</p>
          <div class="form-group">
            <label for="inputUserName">ユーザ名</label>
            <input type="text" class="form-control" id="username">
            <!-- Generated markup by the plugin -->
            <div id="loginModalError" class="tooltip bs-tooltip-top" role="tooltip">
              <div class="tooltip-inner">
                再入力してください
              </div>
            </div>
            <p class="text-muted">4文字以上, 半角英数字または記号(-, _, .), ただし，先頭文字と最終文字は半角英数字</p>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-primary">次へ</button>
        </div>
      </div>
    </div>
  </div>

  <!-- Optional JavaScript -->
  <!-- jQuery first, then Popper.js, then Bootstrap JS -->
  <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>

  <!-- script -->
  <script>
  // username
  var username = "";

  $(function(){
    // 読み込みが終わったら実行
    $('#loginModal').modal('show');
  });

  // Modal が表示された時の設定
  $('#loginModal').on('shown.bs.modal', function () {
    $('#username').trigger('focus');
  });

  // loginModal
  $('#loginModal .modal-footer button.btn.btn-primary').on('click',function(){
    var txt = $('#username').val();
    if (txt.match(/^[A-Za-z0-9][A-Za-z0-9\.\-_]{2,}[A-Za-z0-9]$/)) {
      $('#loginModalError').modal('hide');
      $('#loginModal').modal('hide');
      username = txt
      main(-1);
    } else {
      $('#loginModalError').modal('show');
    }
  });

  function postData(url, data) {
    // 既定のオプションには * が付いています
    return fetch(url, {
      body: JSON.stringify(data), // must match 'Content-Type' header
      cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
      headers: {
        'content-type': 'application/json'
      },
      method: 'POST', // *GET, POST, PUT, DELETE, etc.
    })
    .then(response => {
      return response.json()
    }) // parses response to JSON
  }

  function main(value){
    postData('top', {'username': username, 'value': value})
      .then(data => {mainView(data)})
      .catch(error => {console.log(error)})
  }

  function mainView(data){
    $("#mainView").html(
      '<div class="card">'+
        '<div class="card-body">'+
          '<h5 class="card-title">Tweet</h5>'+
          '<p class="card-text">'+data['tweet']+'</p>'+
        '</div>'+
        '<div class="card-body">'+
          '<h5 class="card-title">Reply</h5>'+
          '<p class="card-text">'+data['reply']+'</p>'+
        '</div>'+
        '<div class="card-body">'+
          '<button id="button0" class="btn btn-secondary btn-lg">真っ当なリプ</button> '+
          '<button id="button1" class="btn btn-secondary btn-lg">状況による</button> '+
          '<button id="button2" class="btn btn-secondary btn-lg">紛う事なきクソリプ</button>'+
        '</div>'+
      '</div>'
    );
    $('#button0').on('click',function(){
      main(0);
    });
    $('#button1').on('click',function(){
      main(1);
    });
    $('#button2').on('click',function(){
      main(2);
    });
  }
  </script>
</body>
</html>
