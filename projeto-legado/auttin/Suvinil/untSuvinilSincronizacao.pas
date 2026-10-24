unit untSuvinilSincronizacao;

interface

uses
  untTintaSincronizacao, Classes, Uni, UniClientDataSet, DB, UniDataSetProvider, SysUtils,
  Variants;

Type
  TSuvinilSincronizacao = class(TTintaSincronizacao)
  private
    {*******************************************}
    {* FUNCOES PARA IMPORTAR OS ARQUIVOS TXT   *}
    {****************************************PH*}
    function fProcessaCadBas(): Boolean;
    function fProcessaCadCol(): Boolean;
    function fProcessaCadSuv(): Boolean;

    {*******************************************}
    {* FUNCOES PARA EXPORTACAO DE CADA TABELA  *}
    {****************************************PH*}
    function fExportarCadBas(): Boolean;
    function fExportarCadCol(): Boolean;
    function fExportarCadSuv(): Boolean;
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

{ TSuvinilSincronizacao }

constructor TSuvinilSincronizacao.Create(AOWner: TComponent;
  intOpcao: Integer);
begin
  inherited Create(AOWner, intOpcao);
  strArqTinta := 'SUV_CADSUV';
  strSiglaTinta := 'SUV';

  {*******************************************}
  {* INFORME AS TABELAS DA TINTA AQUI        *}
  {****************************************PH*}
  stlArquivos.Add('SUV_CADBAS');
  stlArquivos.Add('SUV_CADCOL');
  stlArquivos.Add('SUV_CADNFM');
  stlArquivos.Add('SUV_CADSUV');
end;

function TSuvinilSincronizacao.fExportaArquivos: Boolean;
begin
  Result := fExportarCadBas;
  Result := Result And fExportarCadCol;
  Result := Result And fExportarCadSuv;
end;

function TSuvinilSincronizacao.fExportarCadBas: Boolean;
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
  qryGen.SQL.Text := 'SELECT * FROM SUV_CADBAS';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando SUV_CADBAS...');
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('SUV_CADBAS carregado com sucesso');
  End;

  strNomArq := strPat + '\' + 'SUV_CADBAS.TXT';

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
    FRegistraAcao('Gerando arquivo SUV_CADBAS.TXT...');
  End;


  {*******************************************}
  {* PERCORRE TODO O CADASTRO DE BASES       *}
  {****************************************PH*}
  While Not qryGen.Eof Do
  Begin
    strLinha := fPadR(Trim(qryGen.FieldByName('SUV_CODFML').AsString), 04) +  // 001 => 001 A 004 => 004 => SUV_CODFML
                fPadR('', 1)                                                  +  // 002 => 005 A 005 => 001 => ESPACO
                fPadR(Trim(qryGen.FieldByName('SUV_CODBAS').AsString), 01) +  // 003 => 006 A 006 => 001 => SUV_CODBAS
                fPadR('', 1)                                                  +  // 004 => 007 A 007 => 001 => ESPACO
                fPadR(Trim(qryGen.FieldByName('SUV_CODUNI').AsString), 02) +  // 005 => 008 A 009 => 002 => SUV_CODUNI
                fPadR('', 1)                                                  +  // 006 => 010 A 010 => 001 => ESPACO
                fPadR(Trim(qryGen.FieldByName('SUV_DESCRI').AsString), 25);   // 007 => 011 A 035 => 025 => SUV_DESCRI

    Writeln(arquivo, strLinha);

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
    End;

    qryGen.Next;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Arquivo SUV_CADBAS.TXT gerado com sucesso!');
  End;


  {*******************************************}
  {* SUCESSO!!                               *}
  {****************************************PH*}
  CloseFile(arquivo);
  qryGen.Close;
  Result := True;
end;

function TSuvinilSincronizacao.fExportarCadCol: Boolean;
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
  qryGen.SQL.Text := 'SELECT * FROM SUV_CADCOL';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando SUV_CADCOL...');
  End;


  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('SUV_CADCOL carregado com sucesso');
  End;


  strNomArq := strPat + '\' + 'SUV_CADCOL.TXT';

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
    FRegistraAcao('Gerando arquivo SUV_CADCOL.TXT...');
  End;


  {*******************************************}
  {* PERCORRE TODO O CADASTRO DE COLORANTES  *}
  {****************************************PH*}
  While Not qryGen.Eof Do
  Begin
    strLinha := fPadR(Trim(qryGen.FieldByName('COL_CODCOL').AsString), 02); // 001 => 001 A 002 => 002 => COL_CODCOL

    Writeln(arquivo, strLinha);

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
    End;

    qryGen.Next;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Arquivo SUV_CADCOL.TXT gerado com sucesso!');
  End;


  {*******************************************}
  {* SUCESSO!!                               *}
  {****************************************PH*}
  CloseFile(arquivo);
  qryGen.Close;
  Result := True;
end;


function TSuvinilSincronizacao.fExportarCadSuv: Boolean;
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
  qryGen.SQL.Text := 'SELECT * FROM SUV_CADSUV';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando SUV_CADSUV...');
  End;


  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('SUV_CADSUV carregado com sucesso');
  End;


  strNomArq := strPat + '\' + 'SUV_CADSUV.TXT';

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
    FRegistraAcao('Gerando arquivo SUV_CADSUV.TXT...');
  End;


  {*******************************************}
  {* PERCORRE TODO O CADASTRO DE TINTAS      *}
  {****************************************PH*}
  While Not qryGen.Eof Do
  Begin
    strLinha := fPadR(Trim(qryGen.FieldByName('SUV_DESCRI').AsString), 25)  +               // 001 => 001 A 025 => 025 => SUV_DESCRI
        fPadR(Trim(qryGen.FieldByName('SUV_REFERE').AsString), 35)          +               // 002 => 026 A 057 => 035 => SUV_REFERE
        fPadR(Trim(qryGen.FieldByName('SUV_UNIDAD').AsString), 02);                         // 003 => 058 A 059 => 002 => SUV_UNIDAD

    For intCont := 1 To 15 Do
    Begin
      strLinha := strLinha +
        fPadR(Trim(qryGen.FieldByName('SUV_FORM' + fStrZero(intCont, 2)).AsString), 06) +   // 004 => 060 A 066 => 025 => SUV_FORM
        fPadL(Trim(qryGen.FieldByName('SUV_QTDB' + fStrZero(intCont, 2)).AsString), 14);    // 005 => 067 A 078 => 012 => SUV_QTDB
    End;

    strLinha := strLinha +
      fPadR(Trim(qryGen.FieldByName('SUV_CODFML').AsString), 04) +                          // 035 => 707 A 711 => 004 => SUV_CODFML
      fPadR(Trim(qryGen.FieldByName('SUV_CODBAS').AsString), 01) +                          // 036 => 712 A 712 => 001 => SUV_CODBAS
      fPadR(Trim(qryGen.FieldByName('SUV_CODUNI').AsString), 02);                           // 037 => 713 A 714 => 002 => SUV_CODUNI

    Writeln(arquivo, strLinha);

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
    End;

    qryGen.Next;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Arquivo SUV_CADSUV.TXT gerado com sucesso!');
  End;


  {*******************************************}
  {* SUCESSO!!                               *}
  {****************************************PH*}
  CloseFile(arquivo);
  qryGen.Close;
  Result := True;
end;

function TSuvinilSincronizacao.fImportaArquivos: Boolean;
begin
  Result := fProcessaCadBas;
  Result := Result And fProcessaCadCol;
  Result := Result And fProcessaCadSuv;
end;

function TSuvinilSincronizacao.fProcessaCadBas: Boolean;
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
  strNomArq := strPat + '\' + 'SUV_CADBAS.TXT';

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
  qryGen.SQL.Add('	IFNULL(SUV_CODFML, "") AS SUV_CODFML, ');
  qryGen.SQL.Add('	IFNULL(SUV_CODBAS, "") AS SUV_CODBAS, ');
  qryGen.SQL.Add('	IFNULL(SUV_CODUNI, "") AS SUV_CODUNI,	');
  qryGen.SQL.Add('	IFNULL(SUV_DESCRI, "") AS SUV_DESCRI ');
  qryGen.SQL.Add('FROM');
  qryGen.SQL.Add('	SUV_CADBAS');
  qryGen.Open;

  {*******************************************}
  {* CRIA OS INDICES PARA USAR O FINDKEY     *}
  {****************************************PH*}
  indices := TIndexDefs.Create(nil);
  indices.Add('CADBAS', 'SUV_CODFML;SUV_CODBAS;SUV_CODUNI;SUV_DESCRI', []);

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
  qryGen.SQL.Text := 'SELECT * FROM SUV_CADBAS WHERE FALSE';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Cadastro de bases carregado com sucesso!');
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Atualizando cadastro de bases...');
  End;

  TTintadeMaquina.fAjustaInicialAutoIncremento('SUV_CADBAS', VS_strCodEmp);

  While Not Eof(arquivo) Do
  Begin
    Readln(arquivo, strLinha);

    if Not qryGenMen.FindKey([Trim(Copy(strLinha, 001, 004)), Trim(Copy(strLinha, 006, 001)),
          Trim(Copy(strLinha, 008, 002))]) then
    Begin
      qryGen.Insert;
      qryGen.FieldByName('SUV_CODFML').AsString := Trim(Copy(strLinha, 001, 004));
      qryGen.FieldByName('SUV_CODBAS').AsString := Trim(Copy(strLinha, 006, 001));
      qryGen.FieldByName('SUV_CODUNI').AsString := Trim(Copy(strLinha, 008, 002));
      qryGen.FieldByName('SUV_DESCRI').AsString := Trim(Copy(strLinha, 011, 025));
      qryGen.FieldByName('SUV_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SUV_CADBAS', VS_strCodEmp);
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

function TSuvinilSincronizacao.fProcessaCadCol: Boolean;
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
  strNomArq := strPat + '\' + 'SUV_CADCOL.TXT';

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
  qryGen.SQL.Text := 'SELECT IFNULL(COL_CODCOL, "") AS COL_CODCOL FROM SUV_CADCOL';
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
  qryGen.SQL.Text := 'SELECT * FROM SUV_CADCOL WHERE FALSE';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Cadastro de colorantes carregado com sucesso!');
  End;


  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Atualizando cadastro de colorantes...');
  End;

  TTintadeMaquina.fAjustaInicialAutoIncremento('SUV_CADCOL', VS_strCodEmp);

  While Not Eof(arquivo) Do
  Begin
    Readln(arquivo, strLinha);

    if Not qryGenMen.FindKey([Trim(Copy(strLinha, 1, 2))]) then
    Begin
      qryGen.Insert;
      qryGen.FieldByName('COL_CODCOL').AsString := Trim(Copy(strLinha, 1, 2));
      qryGen.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SUV_CADCOL', VS_strCodEmp);
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

function TSuvinilSincronizacao.fProcessaCadSuv: Boolean;
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
  strNomArq := strPat + '\' + 'SUV_CADSUV.TXT';

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

  {*****************************************************************************}
  {* CARREGA O CADSUV NA MEMORIA, PARA USAR O FINDKEY                          *}
  {**************************************************************************PH*}
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('	IFNULL(SUV_DESCRI, "") AS SUV_DESCRI,');
  qryGen.SQL.Add('	IFNULL(SUV_REFERE, "") AS SUV_REFERE,');
  qryGen.SQL.Add('	IFNULL(SUV_UNIDAD, "") AS SUV_UNIDAD,');
  qryGen.SQL.Add('	SUV_FORM01,');
  qryGen.SQL.Add('	SUV_QTDB01,');
  qryGen.SQL.Add('	SUV_FORM02,');
  qryGen.SQL.Add('	SUV_QTDB02,');
  qryGen.SQL.Add('	SUV_FORM03,');
  qryGen.SQL.Add('	SUV_QTDB03,');
  qryGen.SQL.Add('	SUV_FORM04,');
  qryGen.SQL.Add('	SUV_QTDB04,');
  qryGen.SQL.Add('	SUV_FORM05,');
  qryGen.SQL.Add('	SUV_QTDB05,');
  qryGen.SQL.Add('	SUV_COLVEN,');
  qryGen.SQL.Add('	SUV_COLCUS,');
  qryGen.SQL.Add('	SUV_FORM06,');
  qryGen.SQL.Add('	SUV_QTDB06,');
  qryGen.SQL.Add('	SUV_FORM07,');
  qryGen.SQL.Add('	SUV_QTDB07,');
  qryGen.SQL.Add('	SUV_FORM08,');
  qryGen.SQL.Add('	SUV_QTDB08,');
  qryGen.SQL.Add('	SUV_FORM09,');
  qryGen.SQL.Add('	SUV_QTDB09,');
  qryGen.SQL.Add('	SUV_FORM10,');
  qryGen.SQL.Add('	SUV_QTDB10,');
  qryGen.SQL.Add('	SUV_FORM11,');
  qryGen.SQL.Add('	SUV_QTDB11,');
  qryGen.SQL.Add('	SUV_FORM12,');
  qryGen.SQL.Add('	SUV_QTDB12,');
  qryGen.SQL.Add('	SUV_FORM13,');
  qryGen.SQL.Add('	SUV_QTDB13,');
  qryGen.SQL.Add('	SUV_FORM14,');
  qryGen.SQL.Add('	SUV_QTDB14,');
  qryGen.SQL.Add('	SUV_FORM15,');
  qryGen.SQL.Add('	SUV_QTDB15,');
  qryGen.SQL.Add('	IFNULL(SUV_CODFML, "") AS SUV_CODFML,');
  qryGen.SQL.Add('	IFNULL(SUV_CODBAS, "") AS SUV_CODBAS,');
  qryGen.SQL.Add('	IFNULL(SUV_CODUNI, "") AS SUV_CODUNI');
  qryGen.SQL.Add('FROM');
  qryGen.SQL.Add('	SUV_CADSUV');
  qryGen.Open;

  {*******************************************}
  {* CRIA OS INDICES PARA USAR O FINDKEY     *}
  {****************************************PH*}
  indices := TIndexDefs.Create(nil);
  indices.Add('CADSUV', 'SUV_DESCRI;SUV_REFERE;SUV_UNIDAD;SUV_CODFML;SUV_CODBAS;SUV_CODUNI', []);

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
  qryGen.SQL.Text := 'SELECT * FROM SUV_CADSUV WHERE FALSE';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Cadastro de tintas carregado com sucesso!');
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Atualizando cadastro de tintas...');
  End;

  TTintadeMaquina.fAjustaInicialAutoIncremento('SUV_CADSUV', VS_strCodEmp);

  While Not Eof(arquivo) Do
  Begin
    Readln(arquivo, strLinha);

    //SUV_DESCRI;SUV_REFERE;SUV_UNIDAD;SUV_CODFML;SUV_CODBAS;SUV_CODUNI

    if Not qryGenMen.FindKey([Trim(Copy(strLinha, 1, 25)), Trim(Copy(strLinha, 26, 35)), Trim(Copy(strLinha, 61, 2)),
                            Trim(Copy(strLinha, 363, 4)), Trim(Copy(strLinha, 367, 1)), Trim(Copy(strLinha, 368, 2))]) then
    Begin
      qryGen.Insert;
      qryGen.FieldByName('SUV_DESCRI').AsString := Trim(Copy(strLinha, 1, 25));
      qryGen.FieldByName('SUV_REFERE').AsString := Trim(Copy(strLinha, 26, 35));
      qryGen.FieldByName('SUV_UNIDAD').AsString := Trim(Copy(strLinha, 61, 2));

      qryGen.FieldByName('SUV_FORM01').AsString := Trim(Copy(strLinha, 063, 006));
      qryGen.FieldByName('SUV_QTDB01').AsFloat := fStrToFloat(Trim(Copy(strLinha, 069, 014)));
      qryGen.FieldByName('SUV_FORM02').AsString := Trim(Copy(strLinha, 083, 006));
      qryGen.FieldByName('SUV_QTDB02').AsFloat := fStrToFloat(Trim(Copy(strLinha, 089, 014)));
      qryGen.FieldByName('SUV_FORM03').AsString := Trim(Copy(strLinha, 103, 006));
      qryGen.FieldByName('SUV_QTDB03').AsFloat := fStrToFloat(Trim(Copy(strLinha, 109, 014)));
      qryGen.FieldByName('SUV_FORM04').AsString := Trim(Copy(strLinha, 123, 006));
      qryGen.FieldByName('SUV_QTDB04').AsFloat := fStrToFloat(Trim(Copy(strLinha, 129, 014)));
      qryGen.FieldByName('SUV_FORM05').AsString := Trim(Copy(strLinha, 143, 006));
      qryGen.FieldByName('SUV_QTDB05').AsFloat := fStrToFloat(Trim(Copy(strLinha, 149, 014)));
      qryGen.FieldByName('SUV_FORM06').AsString := Trim(Copy(strLinha, 163, 006));
      qryGen.FieldByName('SUV_QTDB06').AsFloat := fStrToFloat(Trim(Copy(strLinha, 169, 014)));
      qryGen.FieldByName('SUV_FORM07').AsString := Trim(Copy(strLinha, 183, 006));
      qryGen.FieldByName('SUV_QTDB07').AsFloat := fStrToFloat(Trim(Copy(strLinha, 189, 014)));
      qryGen.FieldByName('SUV_FORM08').AsString := Trim(Copy(strLinha, 203, 006));
      qryGen.FieldByName('SUV_QTDB08').AsFloat := fStrToFloat(Trim(Copy(strLinha, 209, 014)));
      qryGen.FieldByName('SUV_FORM09').AsString := Trim(Copy(strLinha, 223, 006));
      qryGen.FieldByName('SUV_QTDB09').AsFloat := fStrToFloat(Trim(Copy(strLinha, 229, 014)));
      qryGen.FieldByName('SUV_FORM10').AsString := Trim(Copy(strLinha, 243, 006));
      qryGen.FieldByName('SUV_QTDB10').AsFloat := fStrToFloat(Trim(Copy(strLinha, 249, 014)));
      qryGen.FieldByName('SUV_FORM11').AsString := Trim(Copy(strLinha, 263, 006));
      qryGen.FieldByName('SUV_QTDB11').AsFloat := fStrToFloat(Trim(Copy(strLinha, 269, 014)));
      qryGen.FieldByName('SUV_FORM12').AsString := Trim(Copy(strLinha, 283, 006));
      qryGen.FieldByName('SUV_QTDB12').AsFloat := fStrToFloat(Trim(Copy(strLinha, 289, 014)));
      qryGen.FieldByName('SUV_FORM13').AsString := Trim(Copy(strLinha, 303, 006));
      qryGen.FieldByName('SUV_QTDB13').AsFloat := fStrToFloat(Trim(Copy(strLinha, 309, 014)));
      qryGen.FieldByName('SUV_FORM14').AsString := Trim(Copy(strLinha, 323, 006));
      qryGen.FieldByName('SUV_QTDB14').AsFloat := fStrToFloat(Trim(Copy(strLinha, 329, 014)));
      qryGen.FieldByName('SUV_FORM15').AsString := Trim(Copy(strLinha, 343, 006));
      qryGen.FieldByName('SUV_QTDB15').AsFloat := fStrToFloat(Trim(Copy(strLinha, 349, 014)));

      qryGen.FieldByName('SUV_CODFML').AsString := Trim(Copy(strLinha, 363, 004));
      qryGen.FieldByName('SUV_CODBAS').AsString := Trim(Copy(strLinha, 367, 001));
      qryGen.FieldByName('SUV_CODUNI').AsString := Trim(Copy(strLinha, 368, 002));
      qryGen.FieldByName('SUV_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SUV_CADSUV', VS_strCodEmp);

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
    FRegistraAcao('Atualização das tintas realizada com sucesso!');
    FRegistraAcao('Tintas adicionadas: ' + IntToStr(qryGen.RecordCount));
  End;

  CloseFile(arquivo);
  FreeAndNil(provedor);
  FreeAndNil(indices);

  Result := True;
end;

end.
