unit untArquivamento;

interface

uses StrUtils, SysUtils, Uni, Db, Classes, Forms, Variants, Controls,
     UniClientDataSet, UniDataSetProvider, untZClient, Windows, cxProgressBar,
     Vcl.FileCtrl;

  type
    TArquivamento = Class(TComponent)
    private
      FcdsArquiv               : TZClient;
      FqryCatArq               : TUniQuery;
      FstrFile                 : String;
      FstrCodCat               : String;
      FstrPath                 : String;
      FstrFileName             : String;
      FstrDirExp               : String;

      function fRetPastaCategoria(strCodCat: String): String;
      function fImportaArquivoProgresso(pgbStatus: TcxProgressBar = nil): Boolean;
      procedure setStrFile(const Value: String);
      function fExportarArquivoProgresso(pgbStatus: TcxProgressBar = Nil): Boolean;
    public
      property cdsArquiv : TZClient  read FcdsArquiv write FcdsArquiv;
      property qryCatArq : TUniQuery read FqryCatArq write FqryCatArq;
      property strPath   : String    read FstrPath   write FstrPath;
      property strCodCat : String    read FstrCodCat write FstrCodCat;
      property strFile : String      read FstrFile write setStrFile;
      procedure pOpenArquiv;
      procedure pOpenCatArq;
      function fImportaArquivo: Boolean;
      function fNovaCategoria : String;
      function fDeletaArquivo: Boolean;
      function fExportarArquivo: boolean;

      Constructor Create(Owner: TComponent); Reintroduce;
    end;

implementation

{ TArquivamento }

uses untFuncoesSimples, untDigCategoriaArquivo, untGravando;

constructor TArquivamento.create;
begin
  Inherited Create(Owner);

  FcdsArquiv := TZClient.Create(Self);
  FqryCatArq := fCriaQuery(Self);

  //sub pasta dentro do autcom para arquivamento
  FstrPath := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName) + 'ARQUIVAMENTO DE DOCUMENTOS');
end;

function TArquivamento.fNovaCategoria : String;
var
  strCategoria : String;
  qryInsert    : TUniQuery;
begin
  Result := '';

  //abre janela para digitar a nova categoria
  strCategoria := TfrmDigCategoriaArquivo.fDigCategoria;
  if not fEmptyStr(strCategoria) then
  begin
    qryInsert := fCriaQuery(nil);
    try
      try

        //insere no banco
        Result := fRetAutoIncrem('CATARQ', VS_strCodemp);
        qryInsert.SQL.Text := 'INSERT INTO CATARQ (AUTOINCREM, CAT_DESCRI) VALUES(:AUTINC, :DESCRI)';
        qryInsert.ParamByName('AUTINC').AsString := Result;
        qryInsert.ParamByName('DESCRI').AsString := strCategoria;

        qryInsert.ExecSQL;

        //se a query de categorias estiver aberta, atualiza e posiciona na nova categoria
        if FqryCatArq.Active then
        begin
          FqryCatArq.Refresh;
          FqryCatArq.Locate('AUTINC', Result, [loCaseInsensitive]);
        end;

      except
        On E: Exception Do
        Begin
          Result := '';
          pMensagensErro(E.Message, 'TArquivamento.fNovaCategoria');
        End;
      end;
    finally
      FreeAndNil(qryInsert);
    end;
  end;
end;


procedure TArquivamento.pOpenArquiv;
begin
  FcdsArquiv.Close;
  FcdsArquiv.qryQuery.SQL.Clear;
  FcdsArquiv.qryQuery.SQL.Add('SELECT ARQUIV.*, CAT_DESCRI FROM ARQUIV             ');
  FcdsArquiv.qryQuery.SQL.Add('INNER JOIN CATARQ ON CATARQ.AUTOINCREM = ARQ_CODCAT ');
  FcdsArquiv.qryQuery.SQL.Add('ORDER BY CAT_DESCRI, ARQ_NOMARQ');

  FcdsArquiv.fAbreClient(True, 'TArquivamento.pOpenArquiv');
end;

procedure TArquivamento.pOpenCatArq;
begin
  FqryCatArq.Close;
  FqryCatArq.SQL.Clear;
  FqryCatArq.SQL.Add('SELECT "0" AS AUTINC, "NOVA CATEGORIA" AS DESCRI    ');
  FqryCatArq.SQL.Add('UNION                                               ');
  FqryCatArq.SQL.Add('SELECT AUTOINCREM, CAT_DESCRI FROM CATARQ           ');
  FqryCatArq.SQL.Add('ORDER BY (AUTINC = "0") DESC, DESCRI ');
  FqryCatArq.Open;
end;

procedure TArquivamento.setStrFile(const Value: String);
begin
  FstrFile := Value;
  FstrFileName := ExtractFileName(FstrFile);
end;

function TArquivamento.fRetPastaCategoria(strCodCat : String) : String;
begin
  Result := IncludeTrailingPathDelimiter(FstrPath);
  Result := Result + fCampoTabela('CAT_DESCRI', 'CATARQ', ['AUTOINCREM'], [strCodCat]);
end;

function TArquivamento.fImportaArquivoProgresso(pgbStatus: TcxProgressBar = Nil): Boolean;
var
  qryArquiv : TUniquery;
  strPastaCategoriaAntiga : String;

  function fCopiaPasta : boolean;
  var
    strNewFile    : String;
    strPastaCategoria : String;
  begin
    if not DirectoryExists(FstrPath) then
      CreateDir(FstrPath);

    strPastaCategoria  := fRetPastaCategoria(FstrCodCat);
    if not DirectoryExists(strPastaCategoria) then
      CreateDir(strPastaCategoria);

    strNewFile := IncludeTrailingPathDelimiter(strPastaCategoria) + FstrFileName;

    //copia o arquivo e sobrescreve se já existir na pasta
    Result := CopyFile(PWideChar(FstrFile), PWideChar(strNewFile), False);
  end;

begin
  try
    qryArquiv := fCriaQuery(nil);
    try
      strPastaCategoriaAntiga := '';

      qryArquiv.SQL.Clear;
      qryArquiv.SQL.Add('SELECT * FROM ARQUIV ');
      qryArquiv.SQL.Add('WHERE ARQ_NOMARQ = :NOMEARQ ');

      qryArquiv.ParamByName('NOMEARQ').AsString := FstrFileName;
      qryArquiv.Open;

      if qryArquiv.IsEmpty then
      begin
        qryArquiv.Insert;
        qryArquiv.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ARQUIV', VS_strCodEmp);
      end
      else begin
        qryArquiv.Edit;

        //se trocar a categoria, armazena o caminho antigo para deletar no final
        if qryArquiv.FieldByName('ARQ_CODCAT').AsString <> FstrCodCat then
          strPastaCategoriaAntiga := fRetPastaCategoria(qryArquiv.FieldByName('ARQ_CODCAT').AsString);
      end;


      qryArquiv.FieldByName('ARQ_CODCAT').AsString   := FstrCodCat;
      qryArquiv.FieldByName('ARQ_NOMARQ').ASString   := FstrFileName;
      qryArquiv.FieldByName('ARQ_DTAIMP').AsDateTime := VS_Date;
      qryArquiv.FieldByName('ARQ_CODEMP').ASString   := VS_strCodEmp;
      TBlobField(qryArquiv.FieldByName('ARQ_ARQUIV')).LoadFromFile(strFile);

      qryArquiv.Post;

      Result := fCopiaPasta;

      // se o usuário trocou a categoria e deu tudo certo com a gravação,
      // deleta o arquivo da pasta da categoria antiga, para não ficar lixo no disco
      if Result and (strPastaCategoriaAntiga <> '') then
        DeleteFile(PWideChar(IncludeTrailingPathDelimiter(strPastaCategoriaAntiga) + FstrFileName));

    Finally
      qryArquiv.Close;
      FreeAndNil(qryArquiv);
    end;

  except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TArquivamento.fImportaArquivoProgresso');
    End;
  end;
end;

function TArquivamento.fImportaArquivo : Boolean;

begin
  //se um arquivo com o mesmo nome já estiver cadastrado, da a opção de subistituí-lo
  if fCampoTabela('COUNT(0)', 'ARQUIV', ['ARQ_NOMARQ'], [FstrFileName]) <> '0' then
  begin
    if fMensagem('', 'Já existe um arquivo com este nome, deseja substitui-lo?', ['','']) = 2 then
    begin
      Result := False;
      exit;
    end;
  end;

  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.pgbStatus.visible := False;
  frmGravando.lblGravando.Caption := 'Aguarde... Importando Arquivo.';
  frmGravando.fExecutarAcao := fImportaArquivoProgresso;
  frmGravando.ShowModal;
  Result := frmGravando.blnConfirma;
  pFreeAndNil(frmGravando);
end;


function TArquivamento.fDeletaArquivo : Boolean;
var
  strFile : String;
begin
  Try
    Result := True;
    if not FcdsArquiv.IsEmpty Then
    begin
      if fMensagem('', 'Deseja realmente excluir o arquivo selecionado?', ['','']) = 2 then
      begin
        Result := True;
        exit;
      end;

      strFile  := fRetPastaCategoria(FcdsArquiv.FieldByName('ARQ_CODCAT').AsString);
      strFile := IncludeTrailingPathDelimiter(strFile) + FcdsArquiv.FieldByName('ARQ_NOMARQ').AsString;

      FcdsArquiv.Delete;
      Result := FcdsArquiv.ApplyUpdates(0) = 0;
      if Result then
        DeleteFile(PWideChar(strFile));
    end;
  except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TArquivamento.fDeletaArquivo');
    End;
  end;
end;


function TArquivamento.fExportarArquivoProgresso(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  try
    TBlobField(FcdsArquiv.FieldByName('ARQ_ARQUIV')).SaveToFile(IncludeTrailingPathDelimiter(FstrdirExp) + FcdsArquiv.FieldByName('ARQ_NOMARQ').AsString);
    Result := True;
  except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TArquivamento.fDeletaArquivo');
    End;
  end;
end;

function TArquivamento.fExportarArquivo : boolean;
const
  SELDIRHELP = 1000;
begin
  Result := False;

  if not FcdsArquiv.IsEmpty Then
  begin
    If SelectDirectory(FstrDirExp, [sdAllowCreate, sdPerformCreate, sdPrompt],SELDIRHELP) Then
    begin
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.pgbStatus.visible := False;
      frmGravando.lblGravando.Caption := 'Aguarde... Exportando Arquivo.';
      frmGravando.fExecutarAcao := fExportarArquivoProgresso;
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;
      pFreeAndNil(frmGravando);
    end;
  end;

end;


end.
