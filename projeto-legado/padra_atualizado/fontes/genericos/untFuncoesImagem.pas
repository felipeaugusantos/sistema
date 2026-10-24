unit untFuncoesImagem;

interface

uses SysUtils, Graphics, Uni, ExtCtrls, Classes, Data.DB,
     JPEG, System.NetEncoding, untImagemBase64, Dialogs,
     UniClientDataSet, untTypesSistema, frxClass, Vcl.Forms, strUtils, PNGImage,
     Winapi.Windows;

Type
  TTipoImagem = (tiJPG, tiPNG, tiUnknow);

  TcdsImagens = class(TUniClientDataSet)
  public
      constructor Create(Owner: TComponent); override;
  end;

  function fRetornaStringProdutoPrincipalBase64(strCodIte : String): String;
  function fRetornaStringImagemBase64(strAutInc : String): String;
  function fRetornaStringClienteBase64(strCodCli : String): String;
  function fRetornaStringProdutoPrincipalImagemUrl(strCodIte : String): String;

  function fCarregaImagemProduto(strCodIte : String; picImagem : TPicture): TRetornoImagem; Overload;
  function fCarregaImagemProduto(strCodIte : String; picImagem : TfrxPictureView; strAutInc : String = ''): TRetornoImagem; Overload;
  function fCarregaImagemProdutoRed(strCodIte : String; picImagem : TfrxPictureView; strAutInc : String = ''): TRetornoImagem; Overload;
  function fCarregaImagemProduto(strCodIte : String; picImagem : TfrxPictureView; fltTamanhoCfg: Double; strCaminhoImagem: String;
   strProPrincipalBase64 : String; blnForcarReleitura: Boolean = False; blnOtimizaImg: Boolean = True; blnCarregarImagemRede: Boolean = True): TRetornoImagem; Overload;

  function fCarregarImagemProduto(strCodIte : String;  picImagemOri: TPicture;
    picImagemDest: TfrxPictureView): TRetornoImagem; overload;
  function fCarregarImagemProduto(const strBase64: String; var picImagem: TPicture): TRetornoImagem; overload;

  function fGerarThumbProduto(strCodIte : String; var picImagem : TPicture; fltTamanhoCfg: Double; strCaminhoImagem: String;
    strProPrincipalBase64 : String; blnForcarReleitura: Boolean = False; blnOtimizaImg: Boolean = True;
    blnCarregarImagemRede: Boolean = True): TRetornoImagem; Overload;

  function fCarregaImagemCliente(strCodCli : String; picImagem : TPicture): TRetornoImagem;
  function fCarregaImagemLinhaGrupo(strCodGru : String; picImagem : TPicture): TRetornoImagem; Overload;
  function fCarregaImagemLinhaGrupo(strCodGru : String; objImagem : TfrxPictureView): TRetornoImagem; Overload;
  function fCarregaImagemGrupoProduto(strCodGru : String; picImagem : TPicture): TRetornoImagem;
  function fCarregaImagemDiverso(strCodDiv : String; picImagem : TPicture): TRetornoImagem;
  function fCarregaImagemPrincipalProdutoDB(strCodIte : String; var objOutput: TBytesStream; blnUsarThread: Boolean = True): Boolean;
  function fRetornaStringReciboBase64(strSeqRom : String): String;
  function fRetornaStringFachadaBase64(strSeqEnt : String): String;
  function fCarregaImagemRecibo(strSeqRom : String; var imgImagem : TImage): TRetornoImagem;
  function fCarregaImagemFachada(strSeqEnt : String; var imgImagem : TImage): TRetornoImagem;
  function fRetornaCaminhoImagemProduto(strCodIte : String; blnUsarThread: Boolean = True) : String;
  function fDeletaImagem(strFormName, strAutInc : String) : Boolean;
  function fDeletaImagemArquivo(strCodIte : String) : Boolean;
  function fRetornaPathImagem(blnUsarThread: Boolean = True): String;
  procedure pVerificaSeOtimizaImagem(strCodIte : String; var strBase64 : String);
  procedure pSalvaImagemOtimizada(strCodIte, strBase64 : String);
  procedure pImportaImagens(strCodIteFiltro : String = '');
  function fMoveArquivo(strCaminhoOrigem, strCaminhoDestino, strArquivo : String; blnSobrescrever : Boolean) : Boolean;
  function fSalvaImagemProdutoDB(strCodIte, strCaminho : String; blnPrincipal : Boolean; strAutInc : String = '') : boolean;
  function fSalvaImagemClienteDB(strCodCli, strCaminho : String; blnPrincipal : Boolean; strAutInc : String = '') : boolean;
  function fSelecionaArquivo(strInitialDir, strFilter : String; opoOpenOptions : TOpenOptions ) : String;
  procedure pMensagemErroImagemProduto(strCodProd: string; strMessagem: String = '');

  function fRetornaStringFotoRomaneioBase64(strAutInc, strTabela: String): String;
  function fRetornaStringURLFotoRomaneio(strAutInc, strTabela: String): String;
  function fCarregaImagemRomaneio(strAutInc, strTabela : String; var objOutput: TBytesStream): Boolean; Overload;
  function fCarregaImagemRomaneio(strAutInc, strTabela : String; picImagem : TPicture): TRetornoImagem; Overload;
  function fCarregaImagemEmpresa(strCodEmp : String; picImagem : TPicture): TRetornoImagem;
  function fRetornaStringEmpresaBase64(strCodEmp : String): String;
  function fCarregaImagemConsertoEquip(strSeqGer: String; picImagem: TPicture): TRetornoImagem;
  function fRetornaStringConsertoEquipBase64(strSeqEqu: String): String;

  procedure ResizeBmp(Dest: Vcl.Graphics.TBitmap; const WMax, HMax: Word);

  procedure LoadImageFromBytesStream(const ABytesStream: TBytesStream; AImage: TPicture);

const
  TOKEN_VALIDADE_MINUTOS = 10;

  function fUtilizaImagemOtimizada: Boolean;
  procedure pOtimizaImagensProduto(strNumdoc, strEspdoc, strCodemp, strCodCli: String); Overload;
  procedure pOtimizaImagensProduto(strCodIte: String); overload;
  procedure pOtimizaImagensProduto(qryItens: TUniQuery; strColuna: String); overload;

Var
  VS_PathImagemExiste: Boolean;

implementation

uses untFuncoesSimples, untModulo, untFuncoesGenerica, untBucketCitel;

function fRetornaStringReciboBase64(strSeqRom : String): String;
Begin
  Try
    Result := fCampoTabela('IMG_IMGB64', 'RECIMG', ['IMG_SEQROM'], [strSeqRom]);
  Except
    Result := '';
  End;
End;

function fRetornaStringFachadaBase64(strSeqEnt : String): String;
begin
  Try
    Result := fCampoTabela('IMG_IMGB64', 'FACIMG', ['IMG_SEQENT'], [strSeqEnt]);
  Except
    Result := '';
  End;
end;

function fCarregaImagemRecibo(strSeqRom : String; var imgImagem : TImage): TRetornoImagem;
  Var
    strImg : String;
    picImagem : TPicture;
Begin
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  strImg := fRetornaStringReciboBase64(strSeqRom);
  If Length(strImg) > 0 Then
  Begin
    Try
      picImagem := TPicture.Create;
      try
        pImagemFromBase64(strImg, picImagem);
        imgImagem.Picture := picImagem;
        Result := riOK;
      finally
        FreeAndNil(picImagem);
      end;
    Except
      imgImagem.Picture := Nil;
      Result := riErro;
    End;
  End
  Else
  Begin
    imgImagem.Picture := Nil;
    Result := riNulo;
  End;
End;

function fCarregaImagemFachada(strSeqEnt : String; var imgImagem : TImage): TRetornoImagem;
  Var
    strImg : String;
    picImagem : TPicture;
Begin
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  strImg := fRetornaStringFachadaBase64(strSeqEnt);
  If Length(strImg) > 0 Then
  Begin
    Try
      picImagem := TPicture.Create;
      try
        pImagemFromBase64(strImg, picImagem);
        imgImagem.Picture := picImagem;
        Result := riOK;
      finally
        FreeAndNil(picImagem);
      end;
    Except
      imgImagem.Picture := Nil;
      Result := riErro;
    End;
  End
  Else
  Begin
    imgImagem.Picture := Nil;
    Result := riNulo;
  End;
End;

function fRetornaStringFotoRomaneioBase64(strAutInc, strTabela: String): String;
var
  strCampo: String;
begin
  Result:= '';
  Try
    strCampo := IIF(strTabela = 'ROMFOT', 'FOT_BASE64', 'ASS_BASE64');
    if not fEmptyStr(strTabela) then
      Result := fCampoTabela(strCampo, strTabela, ['AUTOINCREM'], [strAutInc], False)
  Except
    Result := '';
  End;
end;

function fRetornaStringURLFotoRomaneio(strAutInc, strTabela: String): String;
var
  strCampo: String;
begin
  Result:= '';
  Try
    strCampo := IIF(strTabela = 'ROMFOT', 'FOT_URLFOT', 'ASS_URLFOT');
    if not fEmptyStr(strTabela) then
      Result := fCampoTabela(strCampo, strTabela, ['AUTOINCREM'], [strAutInc], False)
  Except
    Result := '';
  End;
end;

function fRetornaStringProdutoPrincipalBase64(strCodIte : String): String;
Begin
  Try
    Result := fCampoTabela('ITE_IMGB64', 'ITEIMG', ['ITE_CODITE', 'ITE_PRINCI'], [strCodite, 'S'], False)
  Except
    Result := '';
  End;
End;

function fRetornaStringImagemBase64(strAutInc : String): String;
begin

  Try
    Result := fCampoTabela('ITE_IMGB64', 'ITEIMG', ['AUTOINCREM'], [strAutInc], False)
  Except
    Result := '';
  End;

end;

function fRetornaStringClienteBase64(strCodCli : String): String;
begin

  Try
    Result := fCampoTabela('CLI_IMGB64', 'CLIIMG', ['CLI_CODCLI', 'CLI_PRINCI'], [strCodCli, 'S'])
  Except
    Result := '';
  End;

end;

function fRetornaStringEmpresaBase64(strCodEmp : String): String;
begin

  Try
    Result := fCampoTabela('EMP_IMGB64', 'EMPIMG', ['EMP_CODEMP', 'EMP_PRINCI'], [strCodEmp, 'S'])
  Except
    Result := '';
  End;

end;

function fRetornaStringProdutoPrincipalImagemUrl(strCodIte : String): String;
begin
  Try
    Result := fCampoTabela('ITE_IMGURL', 'ITEIMG', ['ITE_CODITE', 'ITE_PRINCI'], [strCodite, 'S'])
  Except
    Result := '';
  End;
end;

function fRetornaStringConsertoEquipBase64(strSeqEqu: String): String;
begin
  try
    Result := fCampoTabela('EQU_IMGB64', 'EQUIMG', ['EQU_SEQEQU', 'EQU_PRINCI'], [strSeqEqu, 'S'])
  except
    Result := '';
  end;
end;

function fSalvaImagemProdutoDB(strCodIte, strCaminho : String; blnPrincipal : Boolean; strAutInc : String = '') : boolean;
var
  imgImagem : TJPEGImage;
  qryTabela : TUniQuery;
begin
  Result := False;

  try
    qryTabela := fCriaQuery;
    imgImagem := TJPEGImage.Create;

    //carrega a imagem
    Try
      imgImagem.LoadFromFile(strCaminho);
    Except
      fMensagem('','Erro ao abrir a imagem, verifique o formato do arquivo!', ['&Ok']);
      Exit;
    End;

    //salva no banco de dados
    With qryTabela, SQL Do
    Begin
      Close;
      Clear;
      Add(' REPLACE INTO ITEIMG (AUTOINCREM, ITE_CODITE, ITE_IMGB64, ITE_THUB64) VALUES(:AUTINC, :CODITE, :IMGB64, :PRINCI, NULL) ');

      ParamByName('AUTINC').AsString := IIF(strAutInc = '', fRetAutoIncrem('ITEIMG', VS_strCodEmp), strAutInc);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('IMGB64').AsString := fBase64FromImg(imgImagem);
      ParamByName('PRINCI').AsString := IIF(blnPrincipal, 'S', 'N');

      Try
        ExecSQL;
        Result := True;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, 'fSalvaImagemBanco');
        End;
      End;
    End;
  Finally
    If Assigned(qryTabela) Then FreeAndNil(qryTabela);
    If Assigned(imgImagem) Then FreeAndNil(imgImagem);
  End;
end;

function fSalvaImagemClienteDB(strCodCli, strCaminho : String; blnPrincipal : Boolean; strAutInc : String = '') : boolean;
var
  imgImagem : TJPEGImage;
  qryTabela : TUniQuery;
begin
  Result := False;

  try
    qryTabela := fCriaQuery;
    imgImagem := TJPEGImage.Create;

    //carrega a imagem
    Try
      imgImagem.LoadFromFile(strCaminho);
    Except
      fMensagem('','Erro ao abrir a imagem, verifique o formato do arquivo!', ['&Ok']);
      Exit;
    End;

    //salva no banco de dados
    With qryTabela, SQL Do
    Begin
      Close;
      Clear;
      Add(' REPLACE INTO CLIIMG (AUTOINCREM, CLI_CODITE, CLI_IMGB64) VALUES(:AUTINC, :CODCLI, :IMGB64) ');

      ParamByName('AUTINC').AsString := IIF(strAutInc = '', fRetAutoIncrem('CLIIMG', VS_strCodEmp), strAutInc);
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('IMGB64').AsString := fBase64FromImg(imgImagem);

      Try
        ExecSQL;
        Result := True;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, 'fSalvaImagemBanco');
        End;
      End;
    End;
  Finally
    If Assigned(qryTabela) Then FreeAndNil(qryTabela);
    If Assigned(imgImagem) Then FreeAndNil(imgImagem);
  End;

end;

function fSelecionaArquivo(strInitialDir, strFilter : String; opoOpenOptions : TOpenOptions ) : String;
Var
  objOpenDialog : TOpenDialog;
Begin
  Result := '';
  objOpenDialog := TOpenDialog.Create(nil);
  Try
    if strInitialDir <> '' Then
      objOpenDialog.InitialDir :=  strInitialDir;

    if strFilter <> '' Then
      objOpenDialog.Filter :=  strFilter;

    objOpenDialog.Options := opoOpenOptions;

    If objOpenDialog.Execute Then
      Result := objOpenDialog.FileName;
  Finally
    If Assigned(objOpenDialog) Then FreeAndNil(objOpenDialog);
  End;
End;

procedure pMensagemErroImagemProduto(strCodProd: string; strMessagem: String = '');
var
  strMensagem: string;
begin
  strMensagem := 'Não é possível recuperar a imagem do produto ';
  if (not fEmptyStr(strCodProd)) then
    strMensagem := strMensagem + ': ' +
                   strCodProd + ' - ' +
                   fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodProd]) + #13;

  strMensagem := strMensagem +
                 'Ela pode estar danificada ou não ser compatível com as extensões suportadas.' + #13 +
                 'As extensões suportadas são: *.jpeg, *.jpg, *.png' + #13 +
                 'Verifique se imagem pode ser aberta com duplo clique no Windows Explorer.' + #13 +
                 'Caso o erro persista, procure o departamento de TI.';

  If Not fEmptyStr(strMessagem) Then
    strMensagem := strMensagem + #13 + 'Detalhamento: ' + strMessagem;

  fMensagem('', strMensagem, ['&O k'], 1, False, 1, 0, False, 0, False, False, False, 230, 480);
end;

function fCarregaImagemPrincipalProdutoDB(strCodIte : String; var objOutput: TBytesStream; blnUsarThread: Boolean = True): Boolean;
  Var
    strImg : String;
    strCaminhoImagem : String;
    imgImagem : TJPEGImage;
Begin

  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  strImg := fRetornaStringProdutoPrincipalBase64(strCodite);
  If Length(strImg) > 0 Then
    //carrega a imagem em Stream e retorna o resultado
    Result := fStreamFromBase64(strImg, objOutput)
  Else
  Begin
    //se não existir no banco, verifica se existe o arquivo na pasta
    strCaminhoImagem := fRetornaCaminhoImagemProduto(strCodIte, blnUsarThread);
    If (Not fEmptyStr(strCaminhoImagem)) And (VS_PathImagemExiste) And (FileExists(strCaminhoImagem)) Then
    Begin
      //carrega a imagem do arquivo e depois salva em stream
      imgImagem := TJPEGImage.Create;
      Try
        Try
          imgImagem.LoadFromFile(strCaminhoImagem);
          imgImagem.SaveToStream(objOutput);
          Result := True;
        Except
          Result := False;
        End;
      Finally
        If Assigned(imgImagem) Then FreeAndNil(imgImagem);
      End;
    End
    Else
      Result := False;
  End;

End;

function fCarregaImagemCliente(strCodCli : String; picImagem : TPicture): TRetornoImagem;
  Var
    strImg : String;
    fltTamanho: Double;
Begin
  fltTamanho := fCfgSis('TAMIMG', varDouble) * 1024;
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  strImg := fRetornaStringClienteBase64(strCodCli);
  If Length(strImg) > 0 Then
  Begin
    Try
      If Length(strImg) > fltTamanho Then
        pVerificaSeOtimizaImagem(strCodCli, strImg);

      pImagemFromBase64(strImg, picImagem);
      Result := riOK;
    Except
      Result := riErro;
    End;
  End
  Else
    Result := riNulo;
End;


function fCarregaImagemProduto(strCodIte : String; picImagem : TPicture): TRetornoImagem; Overload;
  Var
    strImg : String;
    strCaminhoImagem : String;
    fltTamanho: Double;
    qryGen: TUniQuery;
    blnEmTrasancao: Boolean;
Begin
  fltTamanho := fCfgSis('TAMIMG', varDouble) * 1024;
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  //strImg := fRetornaStringProdutoPrincipalBase64(strCodite);
  qryGen:= fCriaQuery();
  Try
    blnEmTrasancao := qryGen.Connection.InTransaction;
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT ITE_IMGB64 FROM ITEIMG WHERE ITE_CODITE = "'+strCodite+'" AND ITE_PRINCI = "S"');
    qryGen.Open;
    strImg:= qryGen.FieldByName('ITE_IMGB64').Value;
  Finally
    FreeAndNil(qryGen);
  End;

  If Length(strImg) > 0 Then
  Begin
    Try
      If Length(strImg) > fltTamanho Then
        pVerificaSeOtimizaImagem(strCodIte, strImg);

      pImagemFromBase64(strImg, picImagem);
      Result := riOK;
    Except
      On E: Exception Do
      begin
        Result := riErro;
        If Not blnEmTrasancao Then
          pMensagemErroImagemProduto(strCodIte);
      end;
    End;
  End
  Else
  Begin
    //se não existir no banco, verifica se existe o arquivo na pasta
    strCaminhoImagem := fRetornaCaminhoImagemProduto(strCodIte);
    If (Not fEmptyStr(strCaminhoImagem)) And (VS_PathImagemExiste) And (FileExists(strCaminhoImagem)) Then
    Begin
      Try
        picImagem.LoadFromFile(strCaminhoImagem);
        Result := riOK;
      Except
        On E: Exception Do
        begin
          Result := riErro;
          If Not blnEmTrasancao Then
            pMensagemErroImagemProduto(strCodIte);
        end;
      End;
    End
    Else
    Begin
      Result := riNulo;
    End;
  End;
End;

function fCarregaImagemProduto(strCodIte : String; picImagem : TfrxPictureView; strAutInc : String = ''): TRetornoImagem; Overload;
  Var
    strImg : String;
    strCaminhoImagem : String;
    fltTamanho: Double;
Begin
  fltTamanho := fCfgSis('TAMIMG', varDouble) * 1024;
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  If fEmptyStr(strAutInc) Then
    strImg := fRetornaStringProdutoPrincipalBase64(strCodite)
  Else
    strImg := fRetornaStringImagemBase64(strAutInc);
  If Length(strImg) > 0 Then
  Begin
    Try
      If Length(strImg) > fltTamanho Then
      Begin
        If fEmptyStr(strAutInc) Then
          pVerificaSeOtimizaImagem(strCodIte, strImg)
        Else
          fOtimizaImagem(strImg);
      End;

      pImagemFromBase64(strImg, picImagem);

      Result := riOK;

    Except
      On E: Exception Do
      begin
        Result := riErro;
        pMensagemErroImagemProduto(strCodIte);
      end;
    End;
  End
  Else
  Begin
    //se não existir no banco, verifica se existe o arquivo na pasta
    strCaminhoImagem := fRetornaCaminhoImagemProduto(strCodIte);
    If (Not fEmptyStr(strCaminhoImagem)) And (VS_PathImagemExiste) And (FileExists(strCaminhoImagem)) Then
    Begin
      Try
        picImagem.Picture.LoadFromFile(strCaminhoImagem);
        Result := riOK;
      Except
        On E: Exception Do
        begin
          Result := riErro;
          pMensagemErroImagemProduto(strCodIte);
        end;
      End;
    End
    Else
    Begin
      Result := riNulo;
    End;
  End;
End;

function fCarregaImagemProduto(strCodIte : String; picImagem : TfrxPictureView; fltTamanhoCfg: Double; strCaminhoImagem: String;
   strProPrincipalBase64 : String; blnForcarReleitura: Boolean = False; blnOtimizaImg: Boolean = True; blnCarregarImagemRede: Boolean = True): TRetornoImagem; Overload;
Var
  strImg : String;
  fltTamanho: Double;
Begin
  fltTamanho := fltTamanhoCfg * 1024;
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  strImg := strProPrincipalBase64;
  If Length(strImg) > 0 Then
  Begin
    Try
      If (Length(strImg) > fltTamanho) and blnOtimizaImg Then
        pVerificaSeOtimizaImagem(strCodIte, strImg);

      pImagemProdutoFromBase64(strImg, picImagem, False);

      Result := riOK;

    Except
      On E: Exception Do
      begin
        Result := riErro;
        pMensagemErroImagemProduto(strCodIte, E.Message);
      end;
    End;
  End
  Else If blnCarregarImagemRede Then
  Begin
    //se não existir no banco, verifica se existe o arquivo na pasta
    If (Not fEmptyStr(strCaminhoImagem)) And (VS_PathImagemExiste) And (FileExists(strCaminhoImagem)) Then
    Begin
      Try
        picImagem.Picture.LoadFromFile(strCaminhoImagem);
        Result := riOK;
      Except
        On E: Exception Do
        begin
          Result := riErro;
          pMensagemErroImagemProduto(strCodIte, E.Message);
        end;
      End;
    End
    Else
    Begin
      Result := riNulo;
    End;
  End
  Else
     Result := riNulo;
End;

function fCarregarImagemProduto(strCodIte : String; picImagemOri: TPicture;
  picImagemDest: TfrxPictureView): TRetornoImagem;
Begin
  Result := riNulo;

  If Not Assigned(picImagemOri) Then
  Begin
    Exit;
  End;

  Try
    picImagemDest.Picture.Assign ( picImagemOri );

    If Assigned(picImagemDest.Picture) Then
      Result := riOK;
  Except
    On E: Exception Do
    begin
      Result := riErro;
      pMensagemErroImagemProduto(strCodIte, E.Message);
    end;
  End;
End;

function fCarregarImagemProduto(const strBase64: String;  var picImagem: TPicture): TRetornoImagem;
Var
  strImg : String;
Begin
  Result := riNulo;
  picImagem.CleanupInstance;

  Try
    strImg := strBase64;
    If ((Length(strImg) > 0) And Not fEmptyStr(strBase64)) Then
    Begin
      pImagemFromBase64(strBase64, picImagem);

      If Assigned(picImagem) Then
        Result := riOK;
    End;

  Except
    On E: Exception Do
    begin
      Result := riErro;
      pMensagemErroImagemProduto('', E.Message);
    end;
  End;
End;

function fGerarThumbProduto(strCodIte : String; var picImagem : TPicture; fltTamanhoCfg: Double; strCaminhoImagem: String;
   strProPrincipalBase64 : String; blnForcarReleitura: Boolean = False; blnOtimizaImg: Boolean = True;
   blnCarregarImagemRede: Boolean = True): TRetornoImagem; Overload;
Var
  strImg : String;
  fltTamanho: Double;
Begin
  Result := riNulo;

  If Not Assigned(picImagem) Then
    Exit;

  Try
    fltTamanho := fltTamanhoCfg * 1024;
    picImagem.CleanupInstance;

    strImg := strProPrincipalBase64;

    If ((Length(strImg) > 0) And (Not fEmptyStr(strImg))) Then
    Begin
      If (Length(strImg) > fltTamanho) and blnOtimizaImg Then
        pVerificaSeOtimizaImagem(strCodIte, strImg);

      picImagem.Assign( fRetornaThumbImagemFromBase64(strImg, False) );
      Result := riOK;
    End
    Else If blnCarregarImagemRede Then
    Begin
      If (Not fEmptyStr(strCaminhoImagem)) And (VS_PathImagemExiste) And (FileExists(strCaminhoImagem)) Then
      Begin
        picImagem.LoadFromFile(strCaminhoImagem);
        Result := riOK;
      End;
    End;

  Except
    On E: Exception Do
    begin
      Result := riErro;
      pMensagemErroImagemProduto(strCodIte, E.Message);
    end;
  End;
End;

function fCarregaImagemRomaneio(strAutInc, strTabela : String; var objOutput: TBytesStream): Boolean; Overload;
Var
  strImg, strURL : String;
Begin
  Result := False;

  strURL := fRetornaStringURLFotoRomaneio(strAutInc, strTabela);

  if fURLValida(strURL) then
  begin
    objOutput := TBucketCitel.Instance.fGetFile(strURL);
    Result    := True;
  end
  else
  begin
    strImg    := fRetornaStringFotoRomaneioBase64(strAutInc, strTabela);
    if Length(strImg) > 0 then
      Result  := fStreamFromBase64(strImg, objOutput);
  End;
end;

function fCarregaImagemRomaneio(strAutInc, strTabela : String; picImagem : TPicture): TRetornoImagem; Overload;
  Var
    strImg, strURL : String;
    objImgStream : TBytesStream;
Begin
  Result := riNulo;
  strURL := fRetornaStringURLFotoRomaneio(strAutInc, strTabela);

  if fURLValida(strURL) then
  begin
    Try
      objImgStream := TBucketCitel.Instance.fGetFile(strURL);
      objImgStream.Position := 0;

      LoadImageFromBytesStream(objImgStream, picImagem);

      Result := riOK;
    Except
      Result := riErro;
    End;
  end
  else
  begin
    strImg := fRetornaStringFotoRomaneioBase64(strAutInc, strTabela);
    If Length(strImg) > 0 Then
    Begin
      Try
        pImagemFromBase64(strImg, picImagem);
        Result := riOK;
      Except
        Result := riErro;
      End;
    End;
  End;
end;

function fCarregaImagemProdutoRed(strCodIte : String; picImagem : TfrxPictureView; strAutInc : String = ''): TRetornoImagem; Overload;
  Var
    strImg : String;
    strCaminhoImagem : String;
Begin
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  If fEmptyStr(strAutInc) Then
    strImg := fRetornaStringProdutoPrincipalBase64(strCodite)
  Else
    strImg := fRetornaStringImagemBase64(strAutInc);
  If Length(strImg) > 0 Then
  Begin
    Try
      fOtimizaImagem(strImg);
      pImagemFromBase64(strImg, picImagem);

      Result := riOK;

    Except
      On E: Exception Do
      begin
        Result := riErro;
        pMensagemErroImagemProduto(strCodIte);
      end;
    End;
  End
  Else
  Begin
    //se não existir no banco, verifica se existe o arquivo na pasta
    strCaminhoImagem := fRetornaCaminhoImagemProduto(strCodIte);
    If VS_PathImagemExiste And (FileExists(strCaminhoImagem)) Then
    Begin
      Try
        picImagem.Picture.LoadFromFile(strCaminhoImagem);
        Result := riOK;
      Except
        On E: Exception Do
        begin
          Result := riErro;
          pMensagemErroImagemProduto(strCodIte);
        end;
      End;
    End
    Else
    Begin
      Result := riNulo;
    End;
  End;
End;

function fCarregaImagemLinhaGrupo(strCodGru : String; objImagem : TfrxPictureView): TRetornoImagem; Overload;
  Var
    strImg : String;
    picImagem : TPicture;
Begin

  try
    strImg := fCampoTabela('GRU_IMGB64', 'GRUIMG', ['GRU_CODGRU', 'GRU_PRINCI'], [strCodGru, 'S'])
  except
    strImg := '';
  end;

  If Length(strImg) > 0 Then
  Begin
    Try
      picImagem := TPicture.Create;
      try
        pImagemFromBase64(strImg, picImagem);
        objImagem.Picture.Graphic := picImagem.Graphic;
        Result := riOK;
      finally
        FreeAndNil(picImagem);
      end;
    Except
        Result := riErro;
    End;
  End
  Else
    Result := riNulo;

End;

function fCarregaImagemDiverso(strCodDiv : String; picImagem : TPicture): TRetornoImagem; Overload;
  Var
    strImg : String;
Begin

  try
    strImg := fCampoTabela('DIV_IMGB64', 'DIVIMG', ['DIV_CODDIV', 'DIV_PRINCI'], [strCodDiv, 'S'])
  except
    strImg := '';
  end;

  If Length(strImg) > 0 Then
  Begin
    Try
      pImagemFromBase64(strImg, picImagem);
      Result := riOK;
    Except
      Result := riErro;
    End;
  End
  Else
    Result := riNulo;

end;

function fCarregaImagemLinhaGrupo(strCodGru : String; picImagem : TPicture): TRetornoImagem; Overload;
  Var
    strImg : String;
Begin

  try
    strImg := fCampoTabela('GRU_IMGB64', 'GRUIMG', ['GRU_CODGRU', 'GRU_PRINCI'], [strCodGru, 'S'])
  except
    strImg := '';
  end;

  If Length(strImg) > 0 Then
  Begin
    Try
      pImagemFromBase64(strImg, picImagem);
      Result := riOK;
    Except
      Result := riErro;
    End;
  End
  Else
    Result := riNulo;

end;

function fMoveArquivo(strCaminhoOrigem, strCaminhoDestino, strArquivo : String; blnSobrescrever : Boolean) : Boolean;
Var
  strVarCaminhoOrigem : String;
  strVarCaminhoDestino  : String;
begin
  strVarCaminhoOrigem  := IncludeTrailingPathDelimiter(strCaminhoOrigem) + strArquivo;
  strVarCaminhoDestino := IncludeTrailingPathDelimiter(strCaminhoDestino) + strArquivo;

  //se a opção sobrescrever estiver True, verifica se existe o arquivo no novo local, se existir deleta.
  If blnSobrescrever Then
    If FileExists(strVarCaminhoDestino) Then
      DeleteFile(PWideChar(strVarCaminhoDestino));

  Result := MoveFile(PWideChar(strVarCaminhoOrigem),PWideChar(strVarCaminhoDestino));
end;

function fRetornaCaminhoImagemProduto(strCodIte : String; blnUsarThread: Boolean = True) : String;
Var
  strPath : String;
begin
  Result := '';
  If Not fEmptyStr(strCodIte) And VS_PathImagemExiste Then
  Begin
    strPath := fRetornaPathImagem(blnUsarThread);
    If strPath <> '' Then
      Result := strPath + strCodIte + '.jpg';
  End;
end;

function fDeletaImagemArquivo(strCodIte : String) : Boolean;
Var
  strCaminhoImagem : String;
Begin
  Result := False;
  strCaminhoImagem := fRetornaCaminhoImagemProduto(strCodIte);
  If strCaminhoImagem <> '' Then
    If VS_PathImagemExiste And FileExists(strCaminhoImagem) Then
      Result := DeleteFile(PWideChar(strCaminhoImagem))
    Else
      Result := True;
End;

function fDeletaImagem(strFormName, strAutInc : String) : Boolean;
Var
  qryTabela, qryGen : TuniQuery;
  strSQL, strCodIte : String;
  blnTransacaoExterna : Boolean;
Begin
  qryTabela := fCriaQuery;
  qryGen := fCriaQuery;
  strCodIte := '';
  Try
    Try
      blnTransacaoExterna := frmModulo.GetCurrentConnection.InTransaction;

      If Not blnTransacaoExterna Then
        fStartTransaction;

      qryTabela.SQL.Text := 'SELECT * FROM ITEIMG WHERE AUTOINCREM = ' + QuotedStr(strAutInc);
      qryTabela.Open;

      if qryTabela.FieldByName('ITE_PRINCI').AsString = 'S' then
        strCodIte := qryTabela.FieldByName('ITE_CODITE').asString;

      if not qryTabela.IsEmpty then
      begin
        strSQL := fVerificaIntegridade(strFormName, 'ITEIMG', qryTabela, False);

        qryTabela.Delete;

        With qryGen Do
        Begin
          SQL.Add(strSQL);
          ExecSQL;
          Close;
        End;
      end;

      qryTabela.Close;

      //apenas a imagem principal ficará na pasta,
      //então se o item deletado for o principal, deleta a imagem da pasta
      if strCodIte <> '' then
        Result := fDeletaImagemArquivo(strCodIte)
      else
        Result := True;

      If Result Then
        fCommit
      Else
        fRollBack;

    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, 'Excluir registro');
      End;
    End;

  Finally
    If Assigned(qryTabela) Then FreeAndNil(qryTabela);
    If Assigned(qryGen) Then FreeAndNil(qryGen);
  End;
End;

procedure pSalvaImagemOtimizada(strCodIte, strBase64 : String);
var
  qryTabela : TUniQuery;
begin
  try
    qryTabela := fCriaQuery;

    //salva no banco de dados
    With qryTabela, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE ITEIMG SET ITE_IMGB64 = :IMGB64, ');
      Add('                   ITE_THUB64 = NULL     ');
      Add(' WHERE ITE_CODITE = :CODITE AND ITE_PRINCI = "S"');

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('IMGB64').AsString := strBase64;

      Try
        ExecSQL;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, 'fSalvaImagemOtimizada');
        End;
      End;
    End;
  Finally
    If Assigned(qryTabela) Then FreeAndNil(qryTabela);
  End;

end;

function fRetornaPathImagem(blnUsarThread: Boolean = True): String;
Begin
  Result := fCfgSis('PATIMG', varString);

  If Not fEmptyStr(Result) Then
    Result := IncludeTrailingPathDelimiter(Result)
  Else
    Result := '';

  if blnUsarThread then
    VS_PathImagemExiste := TryDirectoryExists(Result)
  else
    VS_PathImagemExiste := DirectoryExists(Result);
End;

procedure pImportaImagens(strCodIteFiltro : String = '');
  Var
    srcArquivo        : TSearchRec;
    strPath           : String;
    strPathImportar   : String;
    strCaminhoArquivo : String;
    strCodIte         : String;
    intAchou          : Integer;
    fltTamanho        : Double;
    qryTabela         : TUniQuery;
    qryAux            : TUniQuery;
    imgGraphic        : TGraphic;
    blnValidaDup      : boolean;
    blnPrincipal      : boolean;
    strImgB64         : String;
    enuTipoImagem     : TTipoImagem;
  const
    CHAVE_LOCK = 'untFuncoesImagem.pImportarImagens';

    procedure pRenomeiaImagem(strPrefixo : String);
    Begin
      //só renomeia se for importação geral
      if strCodIteFiltro = '' then
        RenameFile(strCaminhoArquivo , ChangeFileExt(strCaminhoArquivo,'.'+strPrefixo+FormatDateTime('_dd_mm_yy_hh_nn', fNow)));
    End;
begin
  If fLock_Unlock(CHAVE_LOCK + strCodIteFiltro, True, False, False, '', False) Then
  begin

    qryTabela := fCriaQuery;
    qryAux    := fCriaQuery;

    fltTamanho := fCfgSis('TAMIMG', varDouble) * 1024;

    Try

      //recupera o caminho da pasta importar que deve estar dentro da pasta de imagens
      strPath := fCfgSis('PATIMG', varString);

      //se o código do item estiver preenchido, irá importar as imagens diretamente da pasta
      if strCodIteFiltro = '' then
        strPathImportar := IncludeTrailingPathDelimiter(strPath) + 'IMPORTAR\'
      else
        strPathImportar := IncludeTrailingPathDelimiter(strPath);
     {$WARNINGS OFF}
      intAchou := FindFirst(strPathImportar + '*.*', faArchive, srcArquivo);

     {$WARNINGS ON}
      //se achar arquivos .jpg começa a importação
      If intAchou = 0 then
      Begin
        With qryTabela, SQL Do
        Begin
          Close;
          Clear;
          Add(' INSERT INTO ITEIMG (AUTOINCREM, ITE_CODITE, ITE_IMGB64, ITE_PRINCI) VALUES (:AUTINC, :CODITE, :IMGB64, :PRINCI)');
        End;

        Repeat

          case AnsiIndexStr(UpperCase(ExtractFileExt(srcArquivo.Name)), ['.JPG', '.JPEG', '.PNG']) of
            0,1 : enuTipoImagem := tiJPG;
            2   : enuTipoImagem := tiPNG;
            else enuTipoImagem  := tiUnknow;
          end;

          if not (enuTipoImagem = tiUnknow) then
          begin
            Try
              strCaminhoArquivo := strPathImportar + srcArquivo.Name;

              strCodIte := ChangeFileExt(srcArquivo.Name, '');

              //se houver mais de uma imagem do produto, o nome do arquivo principal
              //será apenas o código e os outros arquivos possuirão um identificador sequencial
              if Length(strCodIte) > fTamCodIte then
              begin
                strCodIte := Copy(ExtractFileName(srcArquivo.Name), 1, fTamCodIte);
                blnPrincipal := False;
              end
              else
                blnPrincipal := True;

              //só importa se existir um produto com esse código
              strCodIte := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [strCodIte]);

              //se for importaçaõ geral, importa qualquer código, senão importa apenas as imagens do código filtrado
              if ((strCodIteFiltro = '') and (strCodIte <> '')) or ((strCodIteFiltro <> '') and (strCodIteFiltro = strCodIte)) then
              Begin
                case enuTipoImagem of
                  tiJPG : imgGraphic := TJPEGImage.Create;
                  tiPNG : imgGraphic := TPngImage.Create;
                end;

                try
                  imgGraphic.LoadFromFile(strCaminhoArquivo);
                  strImgB64 := fBase64FromImg(imgGraphic);
                finally
                  FreeAndNil(imgGraphic);
                end;

                If Length(strImgB64) > fltTamanho Then
                  fOtimizaImagem(strImgB64);

                blnValidaDup := True;
                // só valida se for importação em lote
                if strCodIteFiltro = '' then
                begin
                  //testa a base 64 e quando for principal, se já existe uma principal
                  qryAux.SQL.Clear;
                  qryAux.SQL.Add('SELECT                             ');
                  qryAux.SQL.Add('  COUNT(*) AS QTD                  ');
                  qryAux.SQL.Add('FROM                               ');
                  qryAux.SQL.Add('  ITEIMG                           ');
                  qryAux.SQL.Add('WHERE                              ');
                  qryAux.SQL.Add('      ITE_CODITE = :CODITE         ');
                  qryAux.SQL.Add('  AND (   (ITE_IMGB64 = :IMGB64)   ');

                  IF blnPrincipal then
                    qryAux.SQL.Add('     OR (ITE_PRINCI = "S")       ');

                  qryAux.SQL.Add('      )                            ');

                  qryAux.ParamByName('CODITE').AsString := strCodIte;
                  qryAux.ParamByName('IMGB64').AsString := strImgB64;

                  qryAux.Open;

                  blnValidaDup := qryAux.FieldByName('QTD').AsInteger = 0;

                  qryAux.Close;
                end;

                if blnValidaDup then
                begin
                  qryTabela.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEIMG', VS_strCodEmp);
                  qryTabela.ParamByName('PRINCI').AsString := IIF(blnPrincipal, 'S', 'N');
                  qryTabela.ParamByName('CODITE').AsString := strCodIte;
                  qryTabela.ParamByName('IMGB64').AsString := strImgB64;
                  qryTabela.ExecSQL;

                  //se deu certo joga a imagem na pasta de imagens, caso não consiga mover renomeia a extensão começando com CNF = Conflito
                  if strCodIteFiltro = '' then
                    if Not fMoveArquivo(strPathImportar, strPath, srcArquivo.Name, True) Then
                      pRenomeiaImagem('CNF');

                end
                else
                  pRenomeiaImagem('DUP'); //se já existe no banco renomeia a extensão começando com DUP = Duplicado
              End
              Else
                pRenomeiaImagem('NUL'); //se não encontrou um produto renomeia a extensão começando com NUL = Nulo
            Except
              //se deu erro renomeia a extensão começando com ERR  = Erro
              pRenomeiaImagem('ERR');
            End;

            Application.ProcessMessages;
          end;
        Until FindNext(srcArquivo) <> 0;
      End;

    Finally
      SysUtils.FindClose(srcArquivo);
      If Assigned(qryTabela) Then FreeAndNil(qryTabela);
      If Assigned(qryAux) Then FreeAndNil(qryAux);
      fLock_Unlock(CHAVE_LOCK + strCodIteFiltro, False);
    End;
  end;
end;

{ TcdsImagens }

constructor TcdsImagens.Create(Owner: TComponent);
begin

  inherited Create(Owner);
  Close;
  FieldDefs.Clear;
  FieldDefs.Add('INDICE', ftAutoInc);
  FieldDefs.Add('AUTINC', ftString, 20);
  FieldDefs.Add('PRINCI', ftString, 1);
  FieldDefs.Add('CAPPRI', ftString, 9);
  FieldDefs.Add('IMAGEM', ftBlob);
  FieldDefs.Add('IMGB64', ftBlob);
  FieldDefs.Add('IMGURL', ftBlob);
  IndexFieldNames := 'INDICE';
  CreateDataSet;

end;

procedure pVerificaSeOtimizaImagem(strCodIte : String; var strBase64 : String);
Begin
  If fOtimizaImagem(strBase64) Then
  Begin
    // Grava strBase64 no banco
    pSalvaImagemOtimizada(strCodIte, strBase64);
  End;
End;

function fCarregaImagemEmpresa(strCodEmp : String; picImagem : TPicture): TRetornoImagem;
  Var
    strImg : String;
    fltTamanho: Double;
Begin
  fltTamanho := fCfgSis('TAMIMG', varDouble) * 1024;
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  strImg := fRetornaStringEmpresaBase64(strCodEmp);
  If Length(strImg) > 0 Then
  Begin
    Try
      If Length(strImg) > fltTamanho Then
        pVerificaSeOtimizaImagem(strCodEmp, strImg);

      pImagemFromBase64(strImg, picImagem);
      Result := riOK;
    Except
      Result := riErro;
    End;
  End
  Else
    Result := riNulo;
End;

function fCarregaImagemConsertoEquip(strSeqGer: String; picImagem: TPicture): TRetornoImagem;
var
  strImg : String;
  fltTamanho: Double;
begin
  fltTamanho := fCfgSis('TAMIMG', varDouble) * 1024;
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  strImg := fRetornaStringConsertoEquipBase64(strSeqGer);

  if Length(strImg) > 0 then
  begin
    try
      if Length(strImg) > fltTamanho then
        pVerificaSeOtimizaImagem(strSeqGer, strImg);

      pImagemFromBase64(strImg, picImagem);
      Result := riOK;
    except
      Result := riErro;
    end;
  end
  else
    Result := riNulo;
end;

procedure ResizeBmp(Dest: Vcl.Graphics.TBitmap; const WMax, HMax: Word);
type
  pRGBArray = ^TRGBArray;
  TRGBArray = array[Word] of TRGBTriple;
var
  TBmp: Vcl.Graphics.TBitmap;
  DstGap: Integer;
  WNew, HNew: Integer;
  X, Y, T3: Integer;
  Z1, Z2, IZ2: Integer;
  W1, W2, W3, W4: Integer;
  XP, XP2, YP, YP2: Integer;
  SrcLine1, SrcLine2, DstLine: pRGBArray;
Begin
  TBmp := Vcl.Graphics.TBitmap.Create;
  try
    try
      WNew := (Dest.Width * HMax) div Dest.Height;
      HNew := (WMax * Dest.Height) div Dest.Width;
      if (WMax < WNew) then
      begin
        TBmp.Width := WMax;
        TBmp.Height := HNew;
      end else
      begin
        TBmp.Width := WNew;
        TBmp.Height := HMax;
      end;
      Dest.PixelFormat := pf24Bit;
      TBmp.PixelFormat := pf24bit;
      DstLine := TBmp.ScanLine[0];
      DstGap  := Integer(TBmp.ScanLine[1]) - Integer(DstLine);
      XP2 := MulDiv(Pred(Dest.Width), $10000, TBmp.Width);
      YP2 := MulDiv(Pred(Dest.Height), $10000, TBmp.Height);
      YP  := 0;
      for Y := 0 to Pred(TBmp.Height) do
      begin
        XP := 0;
        SrcLine1 := Dest.ScanLine[YP shr 16];
        if (YP shr 16 < Pred(Dest.Height))
          then SrcLine2 := Dest.ScanLine[Succ(YP shr 16)]
          else SrcLine2 := Dest.ScanLine[YP shr 16];
        Z2  := Succ(YP and $FFFF);
        IZ2 := Succ((not YP) and $FFFF);
        for X := 0 to Pred(TBmp.Width) do
        begin
          T3 := XP shr 16;
          Z1 := XP and $FFFF;
          W2 := MulDiv(Z1, IZ2, $10000);
          W1 := IZ2 - W2;
          W4 := MulDiv(Z1, Z2, $10000);
          W3 := Z2 - W4;
          DstLine[X].rgbtRed   := (SrcLine1[T3].rgbtRed   * W1 + SrcLine1[T3 + 1].rgbtRed   * W2 + SrcLine2[T3].rgbtRed   * W3 + SrcLine2[T3 + 1].rgbtRed   * W4) shr 16;
          DstLine[X].rgbtGreen := (SrcLine1[T3].rgbtGreen * W1 + SrcLine1[T3 + 1].rgbtGreen * W2 + SrcLine2[T3].rgbtGreen * W3 + SrcLine2[T3 + 1].rgbtGreen * W4) shr 16;
          DstLine[X].rgbtBlue  := (SrcLine1[T3].rgbtBlue  * W1 + SrcLine1[T3 + 1].rgbtBlue  * W2 + SrcLine2[T3].rgbtBlue  * W3 + SrcLine2[T3 + 1].rgbtBlue  * W4) shr 16;
          Inc(XP, XP2);
        end;
        Inc(YP, YP2);
        DstLine := pRGBArray(Integer(DstLine) + DstGap);
      end;
      Dest.Assign(TBmp);
    except
    end;
  finally
    TBmp.Free;
  end;
end;

procedure LoadImageFromBytesStream(const ABytesStream: TBytesStream; AImage: TPicture);
var
  ImageFormat: TGraphic;
begin
  if ABytesStream.Size = 0 then
    raise Exception.Create('O stream está vazio.');

  try
    ImageFormat := TJPEGImage.Create;
    try
      ABytesStream.Position := 0;
      ImageFormat.LoadFromStream(ABytesStream);
      AImage.Assign(ImageFormat);
      Exit;
    except
      FreeAndNil(ImageFormat);
    end;

    ImageFormat := TPngImage.Create;
    try
      ABytesStream.Position := 0;
      ImageFormat.LoadFromStream(ABytesStream);
      AImage.Assign(ImageFormat);
      Exit;
    except
      FreeAndNil(ImageFormat);
    end;

  finally
    if Assigned(ImageFormat) then
      ImageFormat.Free;
  end;
end;

function fCarregaImagemGrupoProduto(strCodGru : String; picImagem : TPicture): TRetornoImagem;
  Var
    strImg : String;
Begin

  try
    strImg := fCampoTabela('PRD_IMGB64', 'PRDIMG', ['PRD_CODGRU', 'PRD_PRINCI'], [strCodGru, 'S'])
  except
    strImg := '';
  end;

  If Length(strImg) > 0 Then
  Begin
    Try
      pImagemFromBase64(strImg, picImagem);
      Result := riOK;
    Except
      Result := riErro;
    End;
  End
  Else
    Result := riNulo;

end;

function fUtilizaImagemOtimizada: Boolean;
begin
  Result := (VS_SpoolImpressaoCitel) and (fCfgSis('SPOOTM', VarBoolean));
end;

procedure pOtimizaImagensProduto(strNumdoc, strEspdoc, strCodemp, strCodCli: String); overload;
var
  qryAux: TUniQuery;
  strBase64, strAutInc: String;
begin
  If Not fUtilizaImagemOtimizada Then
    Exit;

  try
    qryAux := fCriaQuery;

    if (Pos(strEspDoc, '_OR_PD_') > 0) Then
    Begin
      qryAux.SQL.Text := '  SELECT ' +
                         '     ITEIMG.* ' +
                         '  FROM FATDOR ' +
                         '  INNER JOIN ITEIMG ON ITEIMG.ITE_CODITE = FATDOR.FDO_CODITE ' +
                         '                   AND ITEIMG.ITE_PRINCI = "S" ' +
                         '  WHERE TRUE ' +
                         '   AND FDO_NUMDOC = :NUMDOC ' +
                         '   AND FDO_ESPDOC = :ESPDOC ' +
                         '   AND FDO_CODEMP = :CODEMP ' +
                         '   AND FDO_CODCLI = :CODCLI ';
    End
    Else if (Pos(strEspDoc, '_NF_FF_IF_') > 0) Then
    Begin
      qryAux.SQL.Text := '  SELECT * FROM ( ' +
                         '  SELECT ' +
                         '     ITEIMG.* ' +
                         '  FROM MOVDET ' +
                         '  INNER JOIN ITEIMG ON ITEIMG.ITE_CODITE = MOVDET.DET_CODITE ' +
                         '                   AND ITEIMG.ITE_PRINCI = "S" ' +
                         '  WHERE TRUE ' +
                         '   AND DET_NUMDOC = :NUMDOC ' +
                         '   AND DET_ESPDOC = :ESPDOC ' +
                         '   AND DET_CODEMP = :CODEMP ' +
                         '   AND DET_CODCLI = :CODCLI ' +
                         ' ' +
                         ' UNION ALL ' +
                         ' ' +
                         '  SELECT ' +
                         '     ITEIMG.* ' +
                         '  FROM NOTDET ' +
                         '  INNER JOIN ITEIMG ON ITEIMG.ITE_CODITE = NOTDET.DET_CODITE ' +
                         '                   AND ITEIMG.ITE_PRINCI = "S" ' +
                         '  WHERE TRUE ' +
                         '   AND DET_NUMDOC = :NUMDOC ' +
                         '   AND DET_ESPDOC = :ESPDOC ' +
                         '   AND DET_CODEMP = :CODEMP ' +
                         '   AND DET_CODCLI = :CODCLI ) AS ITE ';
    End;

    If (qryAux.SQL.Text = '') Then
      Exit;

    qryAux.ParamByName('NUMDOC').AsString := strNumdoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspdoc;
    qryAux.ParamByName('CODEMP').AsString := strCodemp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;

    qryAux.Open;
    while not qryAux.Eof do
    Begin
      strBase64 := qryAux.FieldByName('ITE_IMGB64').AsString;
      fOtimizaImagemTam(strBase64, 150);
      strAutInc := qryAux.FieldByName('AUTOINCREM').AsString;

      pGravarThumbItemSPO(strBase64, strAutInc);
      qryAux.Next;
    end;

  finally
    FreeAndNil(qryAux);
  end;
end;

procedure pOtimizaImagensProduto(strCodIte: String); overload;
var
  qryAux: TUniQuery;
  strBase64, strAutInc: String;
begin
  If Not fUtilizaImagemOtimizada Then
    Exit;
  
  qryAux := fCriaQuery;
  try
    
    qryAux.SQL.Text := '  SELECT ' +
                       '     ITE_IMGB64, AUTOINCREM  ' +
                       '  FROM ITEIMG ' +
                       '  WHERE TRUE ' +
                       '   AND ITEIMG.ITE_CODITE = :CODITE ' +
                       '   AND ITEIMG.ITE_PRINCI = "S" ';
    qryAux.ParamByName('CODITE').AsString := StringReplace(strCodIte , '_', '', [rfReplaceAll]);

    qryAux.Open;
    qryAux.First;
    while not qryAux.Eof do
    Begin
      strBase64 := qryAux.FieldByName('ITE_IMGB64').AsString;
      fOtimizaImagemTam(strBase64, 150);
      strAutInc := qryAux.FieldByName('AUTOINCREM').AsString;

      pGravarThumbItemSPO(strBase64, strAutInc);
      qryAux.Next;
    end;

  finally
    FreeAndNil(qryAux);
  end;
end;

procedure pOtimizaImagensProduto(qryItens: TUniQuery; strColuna: String); overload;
begin
  If Not fUtilizaImagemOtimizada Then
    Exit;

  try
    qryItens.Open;

    if qryItens.FindField(strColuna) = nil then
    begin
      qryItens.Close;
      exit;
    End;

    qryItens.First;

    while not qryItens.Eof do
    Begin
      pOtimizaImagensProduto(qryItens.FieldByName(strColuna).AsString);

      qryItens.Next;
    end;

  finally
    qryItens.Close;
  end;
end;

initialization
  VS_PathImagemExiste := True;

end.
