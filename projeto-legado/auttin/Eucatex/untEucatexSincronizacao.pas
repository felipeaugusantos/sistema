unit untEucatexSincronizacao;

interface

uses
  untTintaSincronizacao, Classes, Uni, UniClientDataSet, DB, UniDataSetProvider, SysUtils,
  Variants;

Type
  TEucatexSincronizacao = class(TTintaSincronizacao)
  private
    {*******************************************}
    {* FUNCOES PARA IMPORTAR OS ARQUIVOS TXT   *}
    {****************************************PH*}
    function fProcessaCadBas(): Boolean;
    function fProcessaCadCol(): Boolean;
    function fProcessaCadEuc(): Boolean;

    {*******************************************}
    {* FUNCOES PARA EXPORTACAO DE CADA TABELA  *}
    {****************************************PH*}
    function fExportarCadBas(): Boolean;
    function fExportarCadCol(): Boolean;
    function fExportarCadEuc(): Boolean;
  protected
    {**************************************************}
    {* FUNCOES PARA PROCESSAR OS ARQUIVOS DO DOWNLOAD *}
    {***********************************************PH*}
    function fImportaArquivos(): Boolean; override;
    function fExportaArquivos(): Boolean; override;

  public
    constructor Create(AOWner: TComponent; intOpcao: Integer);
  End;

implementation

uses untFuncoesSimples, untTintadeMaquina;

{ TEucatexSincronizacao }

constructor TEucatexSincronizacao.Create(AOWner: TComponent;
  intOpcao: Integer);
begin
  inherited Create(AOWner, intOpcao);
  strArqTinta := 'EUC_CADEUC';
  strSiglaTinta := 'EUC';

  {*******************************************}
  {* INFORME AS TABELAS DA TINTA AQUI        *}
  {****************************************PH*}
  stlArquivos.Add('EUC_CADBAS');
  stlArquivos.Add('EUC_CADCOL');
  stlArquivos.Add('EUC_CADEUC');
  stlArquivos.Add('EUC_CADNFM');
end;

function TEucatexSincronizacao.fExportaArquivos: Boolean;
begin
  Result := fExportarCadBas;
  Result := Result And fExportarCadCol;
  Result := Result And fExportarCadEuc;
end;

function TEucatexSincronizacao.fExportarCadBas: Boolean;
  Var
    strLinha: String;
    strNomArq: String;

    arquivo: TextFile;
    qryGen: TUniQuery;
begin

  If Not ForceDirectories(strPat) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', Format('Não foi possivel criar a pasta %s', [strPat]), ['OK']);
    Exit;
  End;

  {*******************************************}
  {* CARREGA CADASTRO DE BASES               *}
  {****************************************PH*}
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM EUC_CADBAS';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando EUC_CADBAS...');
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('EUC_CADBAS carregado com sucesso');
  End;

  strNomArq := strPat + '\' + 'EUC_CADBAS.TXT';

  {*******************************************}
  {* TENTA CRIAR AARQUIVO DE EXPORTACAO      *}
  {****************************************PH*}
  Try
    AssignFile(arquivo, strNomArq);
    Rewrite(arquivo);
  Except
    Result := False;
    fMensagem('', Format('Não foi possivel criar o arquivo %s', [strNomArq]), ['OK']);
    Exit;
  End;

  qryGen.First;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Gerando arquivo EUC_CADBAS.TXT...');
  End;


  {*******************************************}
  {* PERCORRE TODO O CADASTRO DE BASES       *}
  {****************************************PH*}
  While Not qryGen.Eof Do
  Begin
    strLinha := fPadR(Trim(qryGen.FieldByName('BAS_DESCRI').AsString), 25) +
                fPadR(Trim(qryGen.FieldByName('BAS_PRODUT').AsString), 30) +
                fPadR(Trim(qryGen.FieldByName('BAS_CODUNI').AsString), 02);

    Writeln(arquivo, strLinha);

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
    End;

    qryGen.Next;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Arquivo EUC_CADBAS.TXT gerado com sucesso!');
  End;


  {*******************************************}
  {* SUCESSO!!                               *}
  {****************************************PH*}
  CloseFile(arquivo);
  qryGen.Close;
  Result := True;
end;

function TEucatexSincronizacao.fExportarCadCol: Boolean;
  Var
    strLinha: String;
    strNomArq: String;

    arquivo: TextFile;
    qryGen: TUniQuery;
begin

  If Not ForceDirectories(strPat) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', Format('Não foi possivel criar a pasta %s', [strPat]), ['OK']);
    Exit;
  End;

  {*******************************************}
  {* CARREGA CADASTRO DE COLORANTES          *}
  {****************************************PH*}
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM EUC_CADCOL';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando EUC_CADCOL...');
  End;


  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('EUC_CADCOL carregado com sucesso');
  End;


  strNomArq := strPat + '\' + 'EUC_CADCOL.TXT';

  {*******************************************}
  {* TENTA CRIAR ARQUIVO DE EXPORTACAO       *}
  {****************************************PH*}
  Try
    AssignFile(arquivo, strNomArq);
    Rewrite(arquivo);
  Except
    Result := False;
    fMensagem('', Format('Não foi possivel criar o arquivo %s', [strNomArq]), ['OK']);
    Exit;
  End;

  qryGen.First;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Gerando arquivo EUC_CADCOL.TXT...');
  End;


  {*******************************************}
  {* PERCORRE TODO O CADASTRO DE COLORANTES  *}
  {****************************************PH*}
  While Not qryGen.Eof Do
  Begin
    strLinha := fPadR(Trim(qryGen.FieldByName('COL_CODCOL').AsString), 05); // 001 => 001 A 002 => 002 => COL_CODCOL

    Writeln(arquivo, strLinha);

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
    End;

    qryGen.Next;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Arquivo EUC_CADCOL.TXT gerado com sucesso!');
  End;


  {*******************************************}
  {* SUCESSO!!                               *}
  {****************************************PH*}
  CloseFile(arquivo);
  qryGen.Close;
  Result := True;
end;

function TEucatexSincronizacao.fExportarCadEuc: Boolean;
  Var
    strLinha: String;
    strNomArq: String;
    intCont: Integer;

    arquivo: TextFile;
    qryGen: TUniQuery;
begin

  If Not ForceDirectories(strPat) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', Format('Não foi possivel criar a pasta %s', [strPat]), ['OK']);
    Exit;
  End;

  {*******************************************}
  {* CARREGA CADASTRO DE TINTAS              *}
  {****************************************PH*}
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM EUC_CADEUC';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando EUC_CADEUC...');
  End;


  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('EUC_CADEUC carregado com sucesso');
  End;


  strNomArq := strPat + '\' + 'EUC_CADEUC.TXT';

  {******************************************}
  {* TENTA CRIAR ARQUIVO DE EXPORTACAO      *}
  {***************************************PH*}
  Try
    AssignFile(arquivo, strNomArq);
    Rewrite(arquivo);
  Except
    Result := False;
    fMensagem('', Format('Não foi possivel criar o arquivo %s', [strNomArq]), ['OK']);
    Exit;
  End;

  qryGen.First;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Gerando arquivo EUC_CADEUC.TXT...');
  End;


  {*******************************************}
  {* PERCORRE TODO O CADASTRO DE TINTAS      *}
  {****************************************PH*}
  While Not qryGen.Eof Do
  Begin
    strLinha := fPadR(Trim(qryGen.FieldByName('EUC_CODCOR').AsString), 25)  +               
        fPadR(Trim(qryGen.FieldByName('EUC_DESCOR').AsString), 25)          +
        fPadR(Trim(qryGen.FieldByName('EUC_PRODUT').AsString), 30)          +
        fPadR(Trim(qryGen.FieldByName('EUC_DESBAS').AsString), 10)          +
        fPadR(Trim(qryGen.FieldByName('EUC_UNIDAD').AsString), 02);

    For intCont := 1 To 6 Do
    Begin
      strLinha := strLinha +
        fPadR(Trim(qryGen.FieldByName('EUC_FORM' + fStrZero(intCont, 2)).AsString), 06) +
        fPadL(FloatToStr(qryGen.FieldByName('EUC_QTDB' + fStrZero(intCont, 2)).AsFloat), 14);
    End;

    strLinha := strLinha +
      fPadR(Trim(qryGen.FieldByName('EUC_CODNFM').AsString), 10);

    Writeln(arquivo, strLinha);

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
    End;

    qryGen.Next;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Arquivo EUC_CADEUC.TXT gerado com sucesso!');
  End;


  {*******************************************}
  {* SUCESSO!!                               *}
  {****************************************PH*}
  CloseFile(arquivo);
  qryGen.Close;
  Result := True;
end;

function TEucatexSincronizacao.fImportaArquivos: Boolean;
begin
  Result := fProcessaCadBas;
  Result := Result And fProcessaCadCol;
  Result := Result And fProcessaCadEuc;
end;

function TEucatexSincronizacao.fProcessaCadBas: Boolean;
  Var
    strNomArq: String;

    intLinhas: Integer;
    strLinha: String;
    intCont: Integer;

    indices: TIndexDefs;
    provedor: TUniDataSetProvider;

    arquivo: TextFile;
    qryGen: TUniQuery;
    qryGenMen: TUniClientDataSet;
begin
  strNomArq := strPat + '\' + 'EUC_CADBAS.TXT';

  If Not FileExists(strNomArq) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strNomArq]), ['OK']);
    Exit;
  End;

  intLinhas := fContaLihas(strNomArq);
  intCont := 1;

  AssignFile(arquivo, strNomArq);
  Reset(arquivo);

  {****************************************************}
  {* CARREGA O CADBAS NA MEMORIA, PARA USAR O FINDKEY *}
  {*************************************************PH*}
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('	IFNULL(BAS_DESCRI, "") AS "BAS_DESCRI",');
  qryGen.SQL.Add('   IFNULL(BAS_PRODUT, "") AS "BAS_PRODUT",');
  qryGen.SQL.Add('   IFNULL(BAS_CODUNI, "") AS "BAS_CODUNI"');
  qryGen.SQL.Add('FROM');
  qryGen.SQL.Add('	EUC_CADBAS;');
  qryGen.Open;

  {*******************************************}
  {* CRIA OS INDICES PARA USAR O FINDKEY     *}
  {****************************************PH*}
  indices := TIndexDefs.Create(nil);
  indices.Add('CADBAS', 'BAS_DESCRI;BAS_PRODUT;BAS_CODUNI', []);

  {**************************************************************}
  {* CRIA O CLIENTDATASET, USANDO OS INDICES E LIGANDO NA QUERY *}
  {***********************************************************PH*}
  provedor := TUniDataSetProvider.Create(Self);
  provedor.DataSet := qryGen;
  qryGenMen := TUniClientDataSet.Create(Self);
  qryGenMen.SetProvider(provedor);
  qryGenMen.IndexDefs := indices;
  qryGenMen.IndexName := qryGenMen.IndexDefs[0].Name;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando cadastro de bases...');
  End;

  qryGen.AfterScroll := pOnScrollDatSet;
  qryGenMen.Open;
  qryGen.AfterScroll := nil;

  qryGen.Close;
  qryGen.SQL.Text := 'SELECT * FROM EUC_CADBAS WHERE FALSE';
  qryGen.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('EUC_CADBAS', VS_strCodEmp);

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Cadastro de bases carregado com sucesso!');
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Atualizando cadastro de bases...');
  End;

  While Not Eof(arquivo) Do
  Begin
    Readln(arquivo, strLinha);

    if Not qryGenMen.FindKey([Trim(Copy(strLinha, 001, 025)), Trim(Copy(strLinha, 026, 056)),
          Trim(Copy(strLinha, 057, 002))]) then
    Begin
      qryGen.Insert;
      qryGen.FieldByName('BAS_DESCRI').AsString := Trim(Copy(strLinha, 001, 025));
      qryGen.FieldByName('BAS_PRODUT').AsString := Trim(Copy(strLinha, 026, 056));
      qryGen.FieldByName('BAS_CODUNI').AsString := Trim(Copy(strLinha, 057, 002));
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EUC_CADBAS', VS_strCodEmp);
      qryGen.Post;
    End;

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, intCont, intLinhas);
    End;

    intCont := intCont + 1;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Atualização das bases realizada com sucesso!');
    FRegistraAcao('Bases adicionadas: ' + IntToStr(qryGen.RecordCount));
  End;

  CloseFile(arquivo);
  FreeAndNil(provedor);
  FreeAndNil(indices);

  Result := True;
end;

function TEucatexSincronizacao.fProcessaCadCol: Boolean;
  Var
    strNomArq: String;

    intLinhas: Integer;
    strLinha: String;
    intCont: Integer;

    indices: TIndexDefs;
    provedor: TUniDataSetProvider;

    arquivo: TextFile;
    qryGen: TUniQuery;
    qryGenMen: TUniClientDataSet;
begin
  strNomArq := strPat + '\' + 'EUC_CADCOL.TXT';

  If Not FileExists(strNomArq) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strNomArq]), ['OK']);
    Exit;
  End;

  intLinhas := fContaLihas(strNomArq);
  intCont := 1;

  AssignFile(arquivo, strNomArq);
  Reset(arquivo);

  {****************************************************}
  {* CARREGA O CADCOL NA MEMORIA, PARA USAR O FINDKEY *}
  {*************************************************PH*}
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT IFNULL(COL_CODCOL, "") AS COL_CODCOL FROM EUC_CADCOL';
  qryGen.Open;

  {*******************************************}
  {* CRIA OS INDICES PARA USAR O FINDKEY     *}
  {****************************************PH*}
  indices := TIndexDefs.Create(nil);
  indices.Add('CADCOL', 'COL_CODCOL', []);

  {**************************************************************}
  {* CRIA O CLIENTDATASET, USANDO OS INDICES E LIGANDO NA QUERY *}
  {***********************************************************PH*}
  provedor := TUniDataSetProvider.Create(Self);
  provedor.DataSet := qryGen;
  qryGenMen := TUniClientDataSet.Create(Self);
  qryGenMen.SetProvider(provedor);
  qryGenMen.IndexDefs := indices;
  qryGenMen.IndexName := qryGenMen.IndexDefs[0].Name;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando cadastro colorantes...');
  End;


  qryGen.AfterScroll := pOnScrollDatSet;
  qryGenMen.Open;
  qryGen.AfterScroll := nil;

  qryGen.Close;
  qryGen.SQL.Text := 'SELECT * FROM EUC_CADCOL WHERE FALSE';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Cadastro de colorantes carregado com sucesso!');
  End;


  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Atualizando cadastro de colorantes...');
  End;


  While Not Eof(arquivo) Do
  Begin
    Readln(arquivo, strLinha);

    if Not qryGenMen.FindKey([Trim(Copy(strLinha, 1, 5))]) then
    Begin
      qryGen.Insert;
      qryGen.FieldByName('COL_CODCOL').AsString := Trim(Copy(strLinha, 1, 5));
      qryGen.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EUC_CADCOL', VS_strCodEmp);
      qryGen.Post;
    End;

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, intCont, intLinhas);
    End;

    intCont := intCont + 1;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Atualização dos colorantes realizado com sucesso!');
    FRegistraAcao('Colorantes adicionadas: ' + IntToStr(qryGen.RecordCount));
  End;

  CloseFile(arquivo);
  FreeAndNil(provedor);
  FreeAndNil(indices);

  Result := True;
end;

function TEucatexSincronizacao.fProcessaCadEuc: Boolean;
  Var
    strNomArq: String;

    intLinhas: Integer;
    strLinha: String;
    intCont: Integer;

    indices: TIndexDefs;
    provedor: TUniDataSetProvider;

    arquivo: TextFile;
    qryGen: TUniQuery;
    qryGenMen: TUniClientDataSet;

    qryAux: TUniQuery;
    intCodSeq: Integer;
begin
  strNomArq := strPat + '\' + 'EUC_CADEUC.TXT';

  If Not FileExists(strNomArq) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strNomArq]), ['OK']);
    Exit;
  End;

  intLinhas := fContaLihas(strPat + '\' + 'EUC_CADEUC.TXT');
  intCont := 0;

  AssignFile(arquivo, strPat + '\' + 'EUC_CADEUC.TXT');
  Reset(arquivo);

  {****************************************************}
  {* CARREGA O CADCOR NA MEMORIA, PARA USAR O FINDKEY *}
  {*************************************************PH*}
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT	');
  qryGen.SQL.Add('	IFNULL(TRIM(EUC_CODCOR), "") AS "EUC_CODCOR",');
  qryGen.SQL.Add('	IFNULL(TRIM(EUC_DESCOR), "") AS "EUC_DESCOR",');
  qryGen.SQL.Add('	IFNULL(TRIM(EUC_PRODUT), "") AS "EUC_PRODUT",');
  qryGen.SQL.Add('	IFNULL(TRIM(EUC_DESBAS), "") AS "EUC_DESBAS",');
  qryGen.SQL.Add('	IFNULL(TRIM(EUC_UNIDAD), "") AS "EUC_UNIDAD",');
  qryGen.SQL.Add('	EUC_FORM01,');
  qryGen.SQL.Add('	EUC_QTDB01,');
  qryGen.SQL.Add('	EUC_FORM02,');
  qryGen.SQL.Add('	EUC_QTDB02,');
  qryGen.SQL.Add('	EUC_FORM03,');
  qryGen.SQL.Add('	EUC_QTDB03,');
  qryGen.SQL.Add('	EUC_FORM04,');
  qryGen.SQL.Add('	EUC_QTDB04,');
  qryGen.SQL.Add('	EUC_FORM05,');
  qryGen.SQL.Add('	EUC_QTDB05,');
  qryGen.SQL.Add('	EUC_FORM06,');
  qryGen.SQL.Add('	EUC_QTDB06,');
  qryGen.SQL.Add('	IFNULL(TRIM(EUC_CODNFM), "") AS "EUC_CODNFM"');
  qryGen.SQL.Add('FROM');
  qryGen.SQL.Add('	EUC_CADEUC');

  qryGen.Open;

  {*******************************************}
  {* CRIA OS INDICES PARA USAR O FINDKEY     *}
  {****************************************PH*}
  indices := TIndexDefs.Create(nil);
  indices.Add('EUC_CADEUC', 'EUC_CODCOR;EUC_DESCOR;EUC_PRODUT;EUC_DESBAS;EUC_UNIDAD;EUC_CODNFM', []);

  {**************************************************************}
  {* CRIA O CLIENTDATASET, USANDO OS INDICES E LIGANDO NA QUERY *}
  {***********************************************************PH*}
  provedor := TUniDataSetProvider.Create(Self);
  provedor.DataSet := qryGen;
  qryGenMen := TUniClientDataSet.Create(Self);
  qryGenMen.SetProvider(provedor);
  qryGenMen.IndexDefs := indices;
  qryGenMen.IndexName := qryGenMen.IndexDefs[0].Name;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando cadastro de tintas...');
  End;

  qryGen.AfterScroll := pOnScrollDatSet;
  qryGenMen.Open;
  qryGen.AfterScroll := nil;

  qryGen.Close;
  qryGen.SQL.Text := 'SELECT * FROM EUC_CADEUC WHERE FALSE';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Cadastro de tintas carregado com sucesso!');
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Atualizando cadastro de tintas...');
  End;

  qryAux := fCriaQuery(Self);
  qryAux.ParamCheck := False;

  qryAux.SQL.Text := 'SELECT IFNULL(MAX(EUC_CODSEQ), 0) + 1 AS "PROX" FROM EUC_CADEUC;';
  qryAux.Open;

  intCodSeq := qryAux.FieldByName('PROX').AsInteger;

  qryAux.Close;

  TTintadeMaquina.fAjustaInicialAutoIncremento('EUC_CADEUC', VS_strCodEmp);

  While Not Eof(arquivo) Do
  Begin
    Readln(arquivo, strLinha);

    if Not qryGenMen.FindKey([
        Trim(Copy(strLinha, 001, 025)),         //EUC_CODCOR
        Trim(Copy(strLinha, 026, 025)),         //EUC_CODCOR
        Trim(Copy(strLinha, 051, 030)),         //EUC_PRODUT
        Trim(Copy(strLinha, 081, 010)),         //EUC_DESBAS
        Trim(Copy(strLinha, 091, 002)),         //EUC_UNIDAD
        Trim(Copy(strLinha, 213, 010))]) then   //EUC_CODNFM
    Begin
      qryGen.Insert;
      qryGen.FieldByName('EUC_CODCOR').AsString := Trim(Copy(strLinha, 001, 025));
      qryGen.FieldByName('EUC_DESCOR').AsString := Trim(Copy(strLinha, 026, 025));
      qryGen.FieldByName('EUC_PRODUT').AsString := Trim(Copy(strLinha, 051, 030));
      qryGen.FieldByName('EUC_DESBAS').AsString := Trim(Copy(strLinha, 081, 010));
      qryGen.FieldByName('EUC_UNIDAD').AsString := Trim(Copy(strLinha, 091, 002));

      qryGen.FieldByName('EUC_FORM01').AsString := Trim(Copy(strLinha, 093, 006));
      qryGen.FieldByName('EUC_QTDB01').AsFloat := fStrToFloat(Trim(Copy(strLinha, 099, 014)));
      qryGen.FieldByName('EUC_FORM02').AsString := Trim(Copy(strLinha, 113, 006));
      qryGen.FieldByName('EUC_QTDB02').AsFloat := fStrToFloat(Trim(Copy(strLinha, 119, 014)));
      qryGen.FieldByName('EUC_FORM03').AsString := Trim(Copy(strLinha, 133, 006));
      qryGen.FieldByName('EUC_QTDB03').AsFloat := fStrToFloat(Trim(Copy(strLinha, 139, 014)));
      qryGen.FieldByName('EUC_FORM04').AsString := Trim(Copy(strLinha, 153, 006));
      qryGen.FieldByName('EUC_QTDB04').AsFloat := fStrToFloat(Trim(Copy(strLinha, 159, 014)));
      qryGen.FieldByName('EUC_FORM05').AsString := Trim(Copy(strLinha, 173, 006));
      qryGen.FieldByName('EUC_QTDB05').AsFloat := fStrToFloat(Trim(Copy(strLinha, 179, 014)));
      qryGen.FieldByName('EUC_FORM06').AsString := Trim(Copy(strLinha, 193, 006));
      qryGen.FieldByName('EUC_QTDB06').AsFloat := fStrToFloat(Trim(Copy(strLinha, 199, 014)));

      qryGen.FieldByName('EUC_CODNFM').AsString := Trim(Copy(strLinha, 213, 010));
      qryGen.FieldByName('EUC_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EUC_CADEUC', VS_strCodEmp);
      qryGen.FieldByName('EUC_CODSEQ').AsInteger := intCodSeq;

      qryGen.Post;
      intCodSeq := intCodSeq + 1;
    End;

    intCont := intCont + 1;

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, intCont, intLinhas);
    End;

  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Atualização das tintas realizada com sucesso!');
    FRegistraAcao('Tintas adicionadas: ' + IntToStr(qryGen.RecordCount));
  End;

  CloseFile(arquivo);
  FreeAndNil(provedor);
  FreeAndNil(indices);
  FreeAndNil(qryGen);
  FreeAndNil(qryGenMen);
  FreeAndNil(qryAux);

  Result := True;
end;

end.
