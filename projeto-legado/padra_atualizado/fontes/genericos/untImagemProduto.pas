unit untImagemProduto;

interface
  uses SysUtils, Graphics, Uni, ExtCtrls, untFuncoesSimples, Classes, Data.DB,
  JPEG, System.NetEncoding, Winapi.Windows, untImagemBase64, Dialogs, UniClientDataSet,
  cxImage, frxClass, untTypesSistema;

  Type
    TcdsImagensProduto = class(TUniClientDataSet)
    public
      constructor Create(Owner: TComponent); override;
  end;

  function fRetornaStringProdutoPrincipalBase64(strCodIte : String): String;
  function fRetornaStringProdutoPrincipalImagemUrl(strCodIte : String): String;
  function fRetornaStringImagemBase64(strAutInc : String): String;

  function fCarregaImagemPrincipalProdutoDB(strCodIte : String; var objOutput: TBytesStream): Boolean;
  function fRetornaCaminhoImagemProduto(strCodIte : String) : String;
  function fDeletaImagem(strFormName, strAutInc : String) : Boolean;
  function fDeletaImagemArquivo(strCodIte : String) : Boolean;
  function fRetornaPathImagem : String;
  procedure pImportaImagens(strCodIteFiltro : String = '');
  function fMoveArquivo(strCaminhoOrigem, strCaminhoDestino, strArquivo : String; blnSobrescrever : Boolean) : Boolean;
  function fSalvaImagemProdutoDB(strCodIte, strCaminho : String; blnPrincipal : Boolean; strAutInc : String = '') : boolean;
  function fSelecionaArquivo(strInitialDir, strFilter : String; opoOpenOptions : TOpenOptions ) : String;

  function fRetornaStringReciboBase64(strSeqRom : String): String;
  function fRetornaStringFachadaBase64(strSeqEnt : String): String;
  function fCarregaImagemRecibo(strSeqRom : String; var imgImagem : TImage): TRetornoImagem;
  function fCarregaImagemFachada(strSeqEnt : String; var imgImagem : TImage): TRetornoImagem;

implementation

uses untModulo;

function fRetornaStringProdutoPrincipalBase64(strCodIte : String): String;
var
  qryTabela : TUniQuery;
begin

  Result := '';

  If fEmptyStr(strCodIte) Then
    Exit;

  Try
    qryTabela := fCriaQuery;
    qryTabela.SQL.Add('SELECT ITE_IMGB64 FROM ITEIMG WHERE ITE_CODITE = :CODITE AND ITE_PRINCI = ''S''');
    qryTabela.ParamByName('CODITE').asString := strCodite;
    qryTabela.Open;
    If Not qryTabela.isEmpty Then
      Result := qryTabela.FieldByName('ITE_IMGB64').AsString;
  Finally
    FreeAndNil(qryTabela);
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

function fRetornaStringImagemBase64(strAutInc : String): String;
var
  qryTabela : TUniQuery;
begin

  Result := '';

  If fEmptyStr(strAutInc) Then
    Exit;

  Try
    qryTabela := fCriaQuery;
    qryTabela.SQL.Add('SELECT ITE_IMGB64 FROM ITEIMG WHERE AUTOINCREM = :AUTOINCREM');
    qryTabela.ParamByName('AUTOINCREM').asString := strAutInc;
    qryTabela.Open;
    If Not qryTabela.isEmpty Then
      Result := qryTabela.FieldByName('ITE_IMGB64').Text;
  Finally
    FreeAndNil(qryTabela);
  End;

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
      Add(' REPLACE INTO ITEIMG (AUTOINCREM, ITE_CODITE, ITE_IMGB64) VALUES(:AUTINC, :CODITE, :IMGB64, :PRINCI) ');

      ParamByName('AUTINC').AsString := IIF(strAutInc = '', fRetAutoIncrem('ITEIMG', VS_strCodEmp), strAutInc);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('IMGB64').AsString := fBase64FromJPEG(imgImagem);
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

function fCarregaImagemPrincipalProdutoDB(strCodIte : String; var objOutput: TBytesStream): Boolean;
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
    strCaminhoImagem := fRetornaCaminhoImagemProduto(strCodIte);
    If (FileExists(strCaminhoImagem)) Then
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

function fRetornaCaminhoImagemProduto(strCodIte : String) : String;
Var
  strPath : String;
begin
  Result := '';
  If Not fEmptyStr(strCodIte) Then
  Begin
    strPath := fRetornaPathImagem;
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
    If FileExists(strCaminhoImagem) Then
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

function fRetornaPathImagem : String;
Begin
  Result := fCfgSis('PATIMG', varString);
  If Not fEmptyStr(Result) Then
    //coloca a \ no final, caso precise
    Result := IncludeTrailingPathDelimiter(Result)
  Else
    Result := '';
End;

procedure pImportaImagens(strCodIteFiltro : String = '');
  Var
    srcArquivo: TSearchRec;
    strPath : String;
    strPathImportar : String;
    strCaminhoArquivo : String;
    strCodIte  : String;
    intAchou : Integer;
    qryTabela : TUniQuery;
    imgImagem : TJPEGImage;
    blnPrincipal : boolean;
    strImgB64  : String;

    const
      CHAVE_LOCK = 'untFuncoesImagem.pImportarImagens';

    procedure pRenomeiaImagem(strPrefixo : String);
    Begin
      //só renomeia se for importação geral
      if strCodIteFiltro = '' then
        RenameFile(strCaminhoArquivo , ChangeFileExt(strCaminhoArquivo,'.'+strPrefixo+FormatDateTime('_dd_mm_yy_hh_nn', StrToDateTime(fCurrentDateTime))));
    End;
begin
  If fLock_Unlock(CHAVE_LOCK + strCodIteFiltro, True, False, False, '', False) Then
  begin
    qryTabela := fCriaQuery;
    imgImagem := TJPEGImage.Create;

    Try
      //recupera o caminho da pasta importar que deve estar dentro da pasta de imagens
      strPath := fCfgSis('PATIMG', varString);

      //se o código do item estiver preenchido, irá importar as imagens diretamente da pasta
      if strCodIteFiltro = '' then
        strPathImportar := IncludeTrailingPathDelimiter(strPath) + 'IMPORTAR\'
      else
        strPathImportar := IncludeTrailingPathDelimiter(strPath);

      intAchou := FindFirst(strPathImportar + '*.jpg', faArchive, srcArquivo);

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
          Try
            strCaminhoArquivo := strPathImportar + srcArquivo.Name;

            strCodIte := ChangeFileExt(srcArquivo.Name, '');

            //se houver mais de uma imagem do produto, o nome do arquivo principal
            //será apenas o código e os outros arquivos possuirão um identificador sequencial
            if Length(strCodIte) > fTamCodIte then
            begin
              strCodIte := Copy(ChangeFileExt(srcArquivo.Name, ''), 1, fTamCodIte);
              blnPrincipal := False;
            end
            else
              blnPrincipal := True;

            //só importa se existir um produto com esse código
            strCodIte := fCampoTabela('ITE_CODITE', 'CADITE', ['ITE_CODITE'], [strCodIte]);

            //se for importaçaõ geral, importa qualquer código, senão importa apenas as imagens do código filtrado
            if ((strCodIteFiltro = '') and (strCodIte <> '')) or ((strCodIteFiltro <> '') and (strCodIteFiltro = strCodIte)) then
            Begin
              imgImagem.LoadFromFile(strCaminhoArquivo);
              strImgB64 := fBase64FromJPEG(imgImagem);

              if (strCodIteFiltro <> '') or (fCampoTabela('COUNT(0)', 'ITEIMG', ['ITE_CODITE', 'ITE_IMGB64'], [strCodIte, strImgB64]) = '0') then
              begin
                qryTabela.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEIMG', VS_strCodEmp);
                qryTabela.ParamByName('PRINCI').AsString := IIF(blnPrincipal, 'S', 'N');
                qryTabela.ParamByName('CODITE').AsString := strCodIte;
                qryTabela.ParamByName('IMGB64').AsString := strImgB64;
                qryTabela.ExecSQL;

                //se deu certo joga a imagem na pasta de imagens, caso não consiga mover renomeia a extensão começando com CNF = Conflito
                if strCodIteFiltro = '' then
                begin
                  if Not fMoveArquivo(strPathImportar, strPath, srcArquivo.Name, True) Then
                    pRenomeiaImagem('CNF');
                end;

              end
              else
                pRenomeiaImagem('DUP'); //se já existe no banco renomeia a extensão começando com DUP = Duplicado
            End
            Else
            Begin
              //se não encontrou um produto renomeia a extensão começando com NUL = Nulo
              pRenomeiaImagem('NUL');
            End;
          Except
            //se deu erro renomeia a extensão começando com ERR  = Erro
            pRenomeiaImagem('ERR');
          End;
        Until FindNext(srcArquivo) <> 0;
      End;

    Finally
      SysUtils.FindClose(srcArquivo);
      If Assigned(qryTabela) Then FreeAndNil(qryTabela);
      If Assigned(imgImagem) Then FreeAndNil(imgImagem);

      fLock_Unlock(CHAVE_LOCK + strCodIteFiltro, False);
    End;
  end;
end;


procedure pImportaImagensProduto(strCodIte : String);
  Var
    srcArquivo: TSearchRec;
    strPath : String;
    strCaminhoArquivo : String;
    intAchou : Integer;
    qryTabela : TUniQuery;
    imgImagem : TJPEGImage;
    blnPrincipal : boolean;
    strImgB64  : String;
    strCodIteImg : String;
begin
  //só importa se não houver imagens no banco de dados para o item
  if fCampoTabela('COUNT(0)', 'ITEIMG', ['ITE_CODITE'], [strCodIte]) <> '0' then
   exit;

  qryTabela := fCriaQuery;
  imgImagem := TJPEGImage.Create;

  Try
    //recupera o caminho da pasta importar que deve estar dentro da pasta de imagens
    strPath := fCfgSis('PATIMG', varString);

    intAchou := FindFirst(strPath + '*.jpg', faArchive, srcArquivo);

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
        strCaminhoArquivo := strPath + srcArquivo.Name;

        strCodIteImg := ChangeFileExt(srcArquivo.Name, '');

        //se houver mais de uma imagem do produto, o nome do arquivo principal
        //será apenas o código e os outros arquivos possuirão um identificador sequencial
        if Length(strCodIteImg) > fTamCodIte then
        begin
          strCodIteImg := Copy(ChangeFileExt(srcArquivo.Name, ''), 1, fTamCodIte);
          blnPrincipal := True;
        end
        else
          blnPrincipal := False;

        //só importa se for o produto selecionado
        If strCodIteImg =  strCodIte Then
        Begin
          try
            imgImagem.LoadFromFile(strCaminhoArquivo);
            strImgB64 := fBase64FromJPEG(imgImagem);

            if fCampoTabela('COUNT(0)', 'ITEIMG', ['ITE_CODITE', 'ITE_IMGB64'], [strCodIte, strImgB64]) = '0' then
            begin
              qryTabela.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEIMG', VS_strCodEmp);
              qryTabela.ParamByName('PRINCI').AsString := IIF(blnPrincipal, 'S', 'N');
              qryTabela.ParamByName('CODITE').AsString := strCodIte;
              qryTabela.ParamByName('IMGB64').AsString := strImgB64;
              qryTabela.ExecSQL;
            end;
          Except
            On E: Exception Do
            begin
              pMensagensErro(E.Message,'pImportaImagensProduto');
            end;
          End;
        End;
      Until FindNext(srcArquivo) <> 0;
    End;

  Finally
    SysUtils.FindClose(srcArquivo);
    If Assigned(qryTabela) Then FreeAndNil(qryTabela);
    If Assigned(imgImagem) Then FreeAndNil(imgImagem);
  End;
end;


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
Begin
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  strImg := fRetornaStringReciboBase64(strSeqRom);
  If Length(strImg) > 0 Then
  Begin
    Try
      imgImagem.Picture.Graphic := fJPEGFromBase64(strImg);
      Result := riOK;
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
Begin
  //primeiro verifica se existe a imagem no banco de dados, se existir traz de lá
  strImg := fRetornaStringFachadaBase64(strSeqEnt);
  If Length(strImg) > 0 Then
  Begin
    Try
      imgImagem.Picture.Graphic := fJPEGFromBase64(strImg);
      Result := riOK;
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

{ TcdsImagensProduto }

constructor TcdsImagensProduto.Create(Owner: TComponent);
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
  IndexFieldNames := 'INDICE';
  CreateDataSet;

end;

end.
