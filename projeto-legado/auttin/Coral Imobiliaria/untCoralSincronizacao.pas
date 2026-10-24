unit untCoralSincronizacao;

interface

uses
  untTintaSincronizacao, Classes, Uni, UniClientDataSet, DB, UniDataSetProvider, SysUtils,
  Variants;

Type
  TCoralSincronizacao = class(TTintaSincronizacao)
  private
    {*******************************************}
    {* FUNCOES PARA IMPORTAR OS ARQUIVOS TXT   *}
    {****************************************PH*}
    function fProcessaCadBas(): Boolean;
    function fProcessaCadCol(): Boolean;
    function fProcessaCadCor(): Boolean;

    {*******************************************}
    {* FUNCOES PARA EXPORTACAO DE CADA TABELA  *}
    {****************************************PH*}
    function fExportarCadBas(): Boolean;
    function fExportarCadCol(): Boolean;
    function fExportarCadCor(): Boolean;

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

{ TCoralSincronizacao }

constructor TCoralSincronizacao.Create(AOWner: TComponent; intOpcao: Integer);
begin
  inherited Create(AOWner, intOpcao);
  strArqTinta := 'CORIMO_CADCOR';
  strSiglaTinta := 'CORIMO';

  {*******************************************}
  {* INFORME AS TABELAS DA TINTA AQUI        *}
  {****************************************PH*}
  stlArquivos.Add('CORIMO_CADBAS');
  stlArquivos.Add('CORIMO_CADCOL');
  stlArquivos.Add('CORIMO_CADCOR');
  stlArquivos.Add('CORIMO_CADEMB');
  stlArquivos.Add('CORIMO_CADNFM');

end;

function TCoralSincronizacao.fExportaArquivos: Boolean;
begin
  Result := fExportarCadBas;
  Result := Result And fExportarCadCol;
  Result := Result And fExportarCadCor;
end;

function TCoralSincronizacao.fExportarCadBas: Boolean;
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
  qryGen.SQL.Text := 'SELECT * FROM CORIMO_CADBAS';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando CORIMO_CADBAS...');
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('CORIMO_CADBAS carregado com sucesso');
  End;

  strNomArq := strPat + '\' + 'CORIMO_CADBAS.TXT';

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
    FRegistraAcao('Gerando arquivo CORIMO_CADBAS.TXT...');
  End;

  {*******************************************}
  {* PERCORRE TODO O CADASTRO DE BASES       *}
  {****************************************PH*}
  While Not qryGen.Eof Do
  Begin
    strLinha := fPadR(Trim(qryGen.FieldByName('BAS_BASE__').AsString), 10) +  // 001 => 001 A 010 => 010 => BAS_BASE__
                fPadR('', 1)                                                  +  // 002 => 011 A 011 => 001 => ESPACO
                fPadR(Trim(qryGen.FieldByName('BAS_DESCRI').AsString), 40) +  // 003 => 012 A 051 => 040 => BAS_DESCRI
                fPadR('', 1)                                                  +  // 004 => 052 A 052 => 001 => ESPACO
                fPadR(Trim(qryGen.FieldByName('BAS_UNIDAD').AsString), 02);   // 005 => 053 A 054 => 002 => BAS_UNIDAD

    Writeln(arquivo, strLinha);

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
    End;

    qryGen.Next;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Arquivo CORIMO_CADBAS.TXT gerado com sucesso!');
  End;

  {*******************************************}
  {* SUCESSO!!                               *}
  {****************************************PH*}
  CloseFile(arquivo);
  qryGen.Close;
  FreeAndNil(qryGen);
  Result := True;
end;

function TCoralSincronizacao.fExportarCadCol: Boolean;
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
  qryGen.SQL.Text := 'SELECT * FROM CORIMO_CADCOL';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando CORIMO_CADCOL...');
  End;


  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('CORIMO_CADCOL carregado com sucesso');
  End;


  strNomArq := strPat + '\' + 'CORIMO_CADCOL.TXT';

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
    FRegistraAcao('Gerando arquivo CORIMO_CADCOL.TXT...');
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
    FRegistraAcao('Arquivo CORIMO_CADCOL.TXT gerado com sucesso!');
  End;

  {*******************************************}
  {* SUCESSO!!                               *}
  {****************************************PH*}
  CloseFile(arquivo);
  qryGen.Close;
  FreeAndNil(qryGen);
  Result := True;
end;

function TCoralSincronizacao.fExportarCadCor: Boolean;
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

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Carregando CORIMO_CADCOR...');
  End;

  {*******************************************}
  {* CARREGA CADASTRO DE TINTAS              *}
  {****************************************PH*}
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT * FROM CORIMO_CADCOR';
  qryGen.Open;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('CORIMO_CADCOR carregado com sucesso');
  End;


  strNomArq := strPat + '\' + 'CORIMO_CADCOR.TXT';

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
    FRegistraAcao('Gerando arquivo CORIMO_CADCOR.TXT...');
  End;

  {*******************************************}
  {* PERCORRE TODO O CADASTRO DE TINTAS      *}
  {****************************************PH*}
  While Not qryGen.Eof Do
  Begin
    strLinha := fPadR(Trim(qryGen.FieldByName('COR_DESCRI').AsString), 50)  +
        fPadR(Trim(qryGen.FieldByName('COR_CODIGO').AsString), 25)          +
        fPadR(Trim(qryGen.FieldByName('COR_UNIDAD').AsString), 02)          +
        fPadR(Trim(qryGen.FieldByName('COR_COLID1').AsString), 30)          +
        fPadR(Trim(qryGen.FieldByName('COR_COLID2').AsString), 50)          +
        fPadR(Trim(qryGen.FieldByName('COR_DESPRO').AsString), 40)          +
        fPadR(Trim(qryGen.FieldByName('COR_CODBAS').AsString), 10);

    For intCont := 1 To 10 Do
    Begin
      strLinha := strLinha +
        fPadR(Trim(qryGen.FieldByName('COR_FORM' + fStrZero(intCont, 2)).AsString), 06);   // 010 => 242 A 247 => 006
    End;

    For intCont := 1 To 10 Do
    Begin
      strLinha := strLinha +
        fPadL(Trim(qryGen.FieldByName('COR_QTDC' + fStrZero(intCont, 2)).AsString), 12);   // 020 => 302 A 311 => 010
    End;

    strLinha := strLinha +
      fPadR(Trim(qryGen.FieldByName('COR_CODEMB').AsString), 05) +                         // 030 => 402 A 406 => 005
      fPadR(Trim(qryGen.FieldByName('COR_CODUNI').AsString), 02) +                         // 031 => 407 A 408 => 002
      fPadR(Trim(qryGen.FieldByName('COR_UNIVER').AsString), 50);                          // 032 => 409 A 458 => 050

    Writeln(arquivo, strLinha);

    If Assigned(FRegistraProgresso) Then
    Begin
      FRegistraProgresso(1, qryGen.RecNo, qryGen.RecordCount);
    End;

    qryGen.Next;
  End;

  If Assigned(FRegistraAcao) Then
  Begin
    FRegistraAcao('Arquivo CORIMO_CADCOR.TXT gerado com sucesso!');
  End;

  {**********************}
  {* SUCESSO!!          *}
  {*******************PH*}
  CloseFile(arquivo);
  qryGen.Close;
  FreeAndNil(qryGen);
  Result := True;
end;

function TCoralSincronizacao.fImportaArquivos: Boolean;
begin
  Result := fProcessaCadBas;
  Result := Result And fProcessaCadCol;
  Result := Result And fProcessaCadCor;
end;

function TCoralSincronizacao.fProcessaCadBas(): Boolean;
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
  strNomArq := strPat + '\' + 'CORIMO_CADBAS.TXT';

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

  {*******************************************************}
  {* CARREGA O CADBAS NA MEMORIA, PARA USAR O FINDKEY    *}
  {****************************************************PH*}
  qryGen := fCriaQuery();
  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('	IFNULL(BAS_BASE__, "") AS BAS_BASE__,');
  qryGen.SQL.Add('	IFNULL(BAS_DESCRI, "") AS BAS_DESCRI,');
  qryGen.SQL.Add('	IFNULL(BAS_UNIDAD, "") AS BAS_UNIDAD');
  qryGen.SQL.Add('FROM');
  qryGen.SQL.Add('	CORIMO_CADBAS');
  qryGen.Open;

  {*******************************************}
  {* CRIA OS INDICES PARA USAR O FINDKEY     *}
  {****************************************PH*}
  indices := TIndexDefs.Create(nil);
  indices.Add('CADBAS', 'BAS_BASE__;BAS_DESCRI;BAS_UNIDAD', []);

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
  qryGen.SQL.Text := 'SELECT * FROM CORIMO_CADBAS WHERE FALSE';
  qryGen.Open;

  TTintadeMaquina.fAjustaInicialAutoIncremento('CORIMO_CADBAS', VS_strCodEmp);

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
    // BAS_BASE__;BAS_DESCRI;BAS_UNIDAD
    if Not qryGenMen.FindKey([
        Trim(Copy(strLinha, 01, 11)),             // BAS_BASE__
        Trim(Copy(strLinha, 12, 41)),             // BAS_DESCRI
        Trim(Copy(strLinha, 53, 02))]) then       // BAS_UNIDAD
    Begin
      qryGen.Insert;
      qryGen.FieldByName('BAS_BASE__').AsString := Trim(Copy(strLinha, 01, 11));
      qryGen.FieldByName('BAS_DESCRI').AsString := Trim(Copy(strLinha, 12, 41));
      qryGen.FieldByName('BAS_UNIDAD').AsString := Trim(Copy(strLinha, 53, 02));
      qryGen.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CORIMO_CADBAS', VS_strCodEmp);
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
  FreeAndNil(qryGen);
  FreeAndNil(qryGenMen);

  Result := True;
end;

function TCoralSincronizacao.fProcessaCadCol(): Boolean;
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
  strNomArq := strPat + '\' + 'CORIMO_CADCOL.TXT';

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
  qryGen.SQL.Text := 'SELECT IFNULL(COL_CODCOL, "") AS COL_CODCOL FROM CORIMO_CADCOL';
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
  qryGen.SQL.Text := 'SELECT * FROM CORIMO_CADCOL WHERE FALSE';
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

    if Not qryGenMen.FindKey([Trim(Copy(strLinha, 1, 2))]) then
    Begin
      qryGen.Insert;
      qryGen.FieldByName('COL_CODCOL').AsString := Trim(Copy(strLinha, 1, 2));
      qryGen.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CORIMO_CADCOR', VS_strCodEmp);  
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
    FRegistraAcao('Atualização dos colorantes realizada com sucesso!');
    FRegistraAcao('Colorantes adicionados: ' + IntToStr(qryGen.RecordCount));
  End;

  CloseFile(arquivo);
  FreeAndNil(provedor);
  FreeAndNil(indices);
  FreeAndNil(qryGen);
  FreeAndNil(qryGenMen);
  Result := True;
end;

function TCoralSincronizacao.fProcessaCadCor(): Boolean;
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
  strNomArq := strPat + '\' + 'CORIMO_CADCOR.TXT';

  If Not FileExists(strNomArq) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO', Format('O arquivo %s não existe', [strNomArq]), ['OK']);
    Exit;
  End;

  intLinhas := fContaLihas(strPat + '\' + 'CORIMO_CADCOR.TXT');
  intCont := 0;

  AssignFile(arquivo, strPat + '\' + 'CORIMO_CADCOR.TXT');
  Reset(arquivo);

  {****************************************************}
  {* CARREGA O CADCOR NA MEMORIA, PARA USAR O FINDKEY *}
  {*************************************************PH*}
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Clear;
  qryGen.SQL.Add('SELECT');
  qryGen.SQL.Add('	IFNULL(COR_DESCRI, "") AS COR_DESCRI,');
  qryGen.SQL.Add('	IFNULL(COR_CODIGO, "") AS COR_CODIGO,');
  qryGen.SQL.Add('	IFNULL(COR_UNIDAD, "") AS COR_UNIDAD,');
  qryGen.SQL.Add('	IFNULL(COR_COLID1, "") AS COR_COLID1,');
  qryGen.SQL.Add('	IFNULL(COR_COLID2, "") AS COR_COLID2,');
  qryGen.SQL.Add('	IFNULL(COR_DESPRO, "") AS COR_DESPRO,');
  qryGen.SQL.Add('	IFNULL(COR_CODBAS, "") AS COR_CODBAS,');
  qryGen.SQL.Add('	IFNULL(COR_COLVEN, "") AS COR_COLVEN,');
  qryGen.SQL.Add('	IFNULL(COR_COLCUS, "") AS COR_COLCUS,');
  qryGen.SQL.Add('	COR_FORM01,');
  qryGen.SQL.Add('	COR_FORM02,');
  qryGen.SQL.Add('	COR_FORM03,');
  qryGen.SQL.Add('	COR_FORM04,');
  qryGen.SQL.Add('	COR_FORM05,');
  qryGen.SQL.Add('	COR_FORM06,');
  qryGen.SQL.Add('	COR_FORM07,');
  qryGen.SQL.Add('	COR_FORM08,');
  qryGen.SQL.Add('	COR_FORM09,');
  qryGen.SQL.Add('	COR_FORM10,');
  qryGen.SQL.Add('	COR_QTDC01,');
  qryGen.SQL.Add('	COR_QTDC02,');
  qryGen.SQL.Add('	COR_QTDC03,');
  qryGen.SQL.Add('	COR_QTDC04,');
  qryGen.SQL.Add('	COR_QTDC05,');
  qryGen.SQL.Add('	COR_QTDC06,');
  qryGen.SQL.Add('	COR_QTDC07,');
  qryGen.SQL.Add('	COR_QTDC08,');
  qryGen.SQL.Add('	COR_QTDC09,');
  qryGen.SQL.Add('	COR_QTDC10,');
  qryGen.SQL.Add('	IFNULL(COR_CODEMB, "") AS COR_CODEMB,');
  qryGen.SQL.Add('	IFNULL(COR_CODUNI, "") AS COR_CODUNI,');
  qryGen.SQL.Add('	IFNULL(COR_UNIVER, "") AS COR_UNIVER');
  qryGen.SQL.Add('FROM');
  qryGen.SQL.Add('	CORIMO_CADCOR');

  qryGen.Open;

  {*******************************************}
  {* CRIA OS INDICES PARA USAR O FINDKEY     *}
  {****************************************PH*}
  indices := TIndexDefs.Create(nil);
  indices.Add('CORIMO_CADCOR', 'COR_DESCRI;COR_CODIGO;COR_UNIDAD;COR_COLID1;COR_COLID2;COR_DESPRO;COR_CODBAS;COR_CODEMB;COR_CODUNI;COR_UNIVER', []);

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
  qryGen.SQL.Text := 'SELECT * FROM CORIMO_CADCOR WHERE FALSE';
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

  qryAux.SQL.Text := 'SET @CONT = 0;';
  qryAux.ExecSQL;

  qryAux.SQL.Text := 'UPDATE CORIMO_CADCOR SET COR_CODSEQ = RIGHT(CONCAT("000000", @CONT := @CONT + 1), 6) ORDER BY COR_CODSEQ;';
  qryAux.ExecSQL;

  qryAux.SQL.Text := 'SELECT IFNULL(MAX(COR_CODSEQ), 0) + 1 AS "PROX" FROM CORIMO_CADCOR';
  qryAux.Open;

  intCodSeq := qryAux.FieldByName('PROX').AsInteger;
  TTintadeMaquina.fAjustaInicialAutoIncremento('CORIMO_CADCOR', VS_strCodEmp);

  qryAux.Close;


  While Not Eof(arquivo) Do
  Begin
    Readln(arquivo, strLinha);

//COR_DESCRI;COR_CODIGO;COR_UNIDAD;COR_COLID1;COR_COLID2;COR_DESPRO;COR_CODBAS;COR_CODEMB;COR_CODUNI;COR_UNIVER

    if Not qryGenMen.FindKey([
        Trim(Copy(strLinha, 001, 050)),         //COR_DESCRI
        Trim(Copy(strLinha, 051, 025)),         //COR_CODIGO
        Trim(Copy(strLinha, 076, 002)),         //COR_UNIDAD
        Trim(Copy(strLinha, 078, 030)),         //COR_COLID1
        Trim(Copy(strLinha, 108, 050)),         //COR_COLID2
        Trim(Copy(strLinha, 158, 040)),         //COR_DESPRO
        Trim(Copy(strLinha, 198, 010)),         //COR_CODBAS
        Trim(Copy(strLinha, 388, 005)),         //COR_CODEMB
        Trim(Copy(strLinha, 393, 002)),         //COR_CODUNI
        Trim(Copy(strLinha, 395, 050))]) then   //COR_UNIVER
    Begin
      qryGen.Insert;
      qryGen.FieldByName('COR_DESCRI').AsString := Trim(Copy(strLinha, 001, 050));
      qryGen.FieldByName('COR_CODIGO').AsString := Trim(Copy(strLinha, 051, 025));
      qryGen.FieldByName('COR_UNIDAD').AsString := Trim(Copy(strLinha, 076, 002));
      qryGen.FieldByName('COR_COLID1').AsString := Trim(Copy(strLinha, 078, 030));
      qryGen.FieldByName('COR_COLID2').AsString := Trim(Copy(strLinha, 108, 050));
      qryGen.FieldByName('COR_DESPRO').AsString := Trim(Copy(strLinha, 158, 040));
      qryGen.FieldByName('COR_CODBAS').AsString := Trim(Copy(strLinha, 198, 010));

      qryGen.FieldByName('COR_FORM01').AsString := Trim(Copy(strLinha, 208, 006)); //a
      qryGen.FieldByName('COR_FORM02').AsString := Trim(Copy(strLinha, 214, 006)); //b
      qryGen.FieldByName('COR_FORM03').AsString := Trim(Copy(strLinha, 220, 006)); //c
      qryGen.FieldByName('COR_FORM04').AsString := Trim(Copy(strLinha, 226, 006)); //d
      qryGen.FieldByName('COR_FORM05').AsString := Trim(Copy(strLinha, 232, 006)); //e
      qryGen.FieldByName('COR_FORM06').AsString := Trim(Copy(strLinha, 238, 006)); //f
      qryGen.FieldByName('COR_FORM07').AsString := Trim(Copy(strLinha, 244, 006)); //g
      qryGen.FieldByName('COR_FORM08').AsString := Trim(Copy(strLinha, 250, 006)); //h
      qryGen.FieldByName('COR_FORM09').AsString := Trim(Copy(strLinha, 256, 006)); //i
      qryGen.FieldByName('COR_FORM10').AsString := Trim(Copy(strLinha, 262, 006)); //j

      qryGen.FieldByName('COR_QTDC01').AsFloat := fStrToFloat(Trim(Copy(strLinha, 268, 012)));
      qryGen.FieldByName('COR_QTDC02').AsFloat := fStrToFloat(Trim(Copy(strLinha, 280, 012)));
      qryGen.FieldByName('COR_QTDC03').AsFloat := fStrToFloat(Trim(Copy(strLinha, 292, 012)));
      qryGen.FieldByName('COR_QTDC04').AsFloat := fStrToFloat(Trim(Copy(strLinha, 304, 012)));
      qryGen.FieldByName('COR_QTDC05').AsFloat := fStrToFloat(Trim(Copy(strLinha, 316, 012)));
      qryGen.FieldByName('COR_QTDC06').AsFloat := fStrToFloat(Trim(Copy(strLinha, 328, 012)));
      qryGen.FieldByName('COR_QTDC07').AsFloat := fStrToFloat(Trim(Copy(strLinha, 340, 012)));
      qryGen.FieldByName('COR_QTDC08').AsFloat := fStrToFloat(Trim(Copy(strLinha, 352, 012)));
      qryGen.FieldByName('COR_QTDC09').AsFloat := fStrToFloat(Trim(Copy(strLinha, 364, 012)));
      qryGen.FieldByName('COR_QTDC10').AsFloat := fStrToFloat(Trim(Copy(strLinha, 376, 012)));

      qryGen.FieldByName('COR_CODEMB').AsString := Trim(Copy(strLinha, 388, 05));
      qryGen.FieldByName('COR_CODUNI').AsString := Trim(Copy(strLinha, 393, 02));
      qryGen.FieldByName('COR_UNIVER').AsString := Trim(Copy(strLinha, 395, 50));
      qryGen.FieldByName('COR_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CORIMO_CADCO', VS_strCodEmp);
      qryGen.FieldByName('COR_CODSEQ').AsInteger := intCodSeq;

      qryGen.Post;
      intCodSeq := intCodSeq + 1;
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
  FreeAndNil(qryGen);
  FreeAndNil(qryGenMen);
  FreeAndNil(qryAux);

  Result := True;
end;



end.
