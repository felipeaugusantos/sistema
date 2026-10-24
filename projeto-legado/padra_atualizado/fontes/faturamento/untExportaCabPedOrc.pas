{******************************************************************************}
{* EXPORTAÇÃO DE CABEÇALHO DO ORÇAMENTO/PEDIDO PARA UM DOCUMENTO DO TIPO WORD *}
{* O NOME DO CAMPO DEFINIDO NO SELECT SERÁ A TAG A SER SUBSTITUIDA NO WORD,   *}
{* PARA CAMPOS COM FORMATAÇÃO UTILIZAR "pSetarTag" APÓS O SELECT              *}
{******************************************************************************}
{* AUTOR: RENAN SERRANO; DATA: 11/09/2014; ORIGINALMENTE FEITO P/: JV VIDROS  *}
{***************************************************************************RN*}
unit untExportaCabPedOrc;

interface

Uses Classes, SysUtils, untWord, Uni, untFuncoesSimples, Db, untFuncoesGenerica,
     Forms, Windows;

Type
  TExpCabPedOrc = Class(TComponent)
  private
    FQryDoc: TUniQuery;
    FWorDoc: TWord;
    FPatMod: String;
    FPatDes: String;
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FCodCli: String;

    const TAG_ESQ = '{{';
    const TAG_DIR = '}}';

    function fCarregaDocumento: Boolean;
    function fValidacoesOK: Boolean;
    procedure pSetarTag(DataSet: TDataSet);
    function fTratarCampo(Field: TField): String;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor CreateInstance(AOwner: TComponent; strPathModelo: String);
    destructor Destroy; override;
    function fExportar(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  End;

implementation

{ TExpCabPedOrc }

constructor TExpCabPedOrc.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);
end;

constructor TExpCabPedOrc.CreateInstance(AOwner: TComponent;
  strPathModelo: String);
begin
  Inherited Create(Owner);
  FQryDoc := fCriaQuery(Self);
  FPatMod := strPathModelo;
end;

destructor TExpCabPedOrc.Destroy;
begin
  FreeAndNil(FQryDoc);

  If Assigned(FWorDoc) Then
    FreeAndNil(FWorDoc);

  Inherited Destroy;
end;

function TExpCabPedOrc.fExportar(strNumDoc, strEspDoc, strCodEmp,
 strCodCli: String): Boolean;
  Var
    intCnt : Integer;
    strDiretorio : String;
    strFieldName : String;
begin
  FNumDoc := strNumDoc;
  FEspDoc := strEspDoc;
  FCodEmp := strCodEmp;
  FCodCli := strCodCli;

  Result := False;

  strDiretorio := ExtractFilePath(Application.ExeName) + 'PedidoOrcamento\';

  If Not DirectoryExists(strDiretorio) Then
    ForceDirectories(strDiretorio);

  FPatDes := strDiretorio + FNumDoc + '_' + FEspDoc + '_' + FCodEmp + '_' +
             FormatDateTime('ddmmyy', Date) + '_' +
             FormatDateTime('hhnn', fNow()) + '.DOC';

  If FileExists(FPatDes) Then
    DeleteFile(PChar(FPatDes));

  CopyFile(PChar(FPatMod), PChar(FPatDes), False);

  FWorDoc := TWord.fCriarWord(Self);

  If (FWorDoc <> Nil) And (fValidacoesOK) Then
  Begin

    With FWorDoc Do
    Begin
      //pGoToPageHeader;
      pGoToMainDocument;

      FQryDoc.First;

      For intCnt := 0 To (FQryDoc.Fields.Count -1) Do
      Begin
        strFieldName := FQryDoc.Fields[intCnt].FieldName;

        pReplace( TAG_ESQ + strFieldName + TAG_DIR,
                  fTratarCampo(FQryDoc.Fields[intCnt]) );

        Application.ProcessMessages;
      End;

      pSalvar;
      pFechar;
      FreeAndNil(FWorDoc);
      Application.ProcessMessages;
    End;

    pExecArquivo(FPatDes, 0);

    FQryDoc.Close;
    Result := True;
  End;
end;

function TExpCabPedOrc.fTratarCampo(Field: TField): String;
begin
  If fEmptyStr(Field.AsString) Then
  Begin
    Result := Field.AsString;
    Exit;
  End;

  If (Field.Tag = 1) Then
    Result := fFormataFone(Field.AsString)
  Else If (Field.Tag = 2) Then
    Result := fFormataCpfCgc(Field.AsString, fSetaPais)
  Else If (Field.Tag = 3) Then
    Result := fFormataCep(Field.AsString)
  Else
    Result := Field.AsString;
end;

function TExpCabPedOrc.fValidacoesOK: Boolean;
begin
  Result := True;

  If (fEmptyStr(FPatMod)) Then
  Begin
    fMensagem('','Arquivo modelo não foi informado!',['&OK']);
    Result := False;
  End

  Else If (Not FileExists(FPatMod)) Then
  Begin
    fMensagem('','Arquivo modelo informado não existe!',['&OK']);
    Result := False;
  End

  Else If (Not FileExists(FPatMod)) Then
  Begin
    fMensagem('','Arquivo destino informado não existe!',['&OK']);
    Result := False;
  End

  Else If (Not FWorDoc.AbrirArquivo(FPatDes)) Then
  Begin
    fMensagem('','Não foi possível abrir o arquivo!',['&OK']);
    Result := False;
  End



  Else If (Not fCarregaDocumento) Then
  Begin
    fMensagem('',Format('Documento informado [%s] não encontrado!', [FNumDoc + '-' + FEspDoc + '-' + FCodEmp]),['&OK']);
    Result := False;
  End;
end;

procedure TExpCabPedOrc.pSetarTag(DataSet: TDataSet);
begin
  {****************}
  {* 1 - Fone     *}
  {* 2 - CGC      *}
  {* 3 - Cep      *}
  {*************RN*}
  With DataSet Do
  Begin
    FieldByName('FONEMP').Tag := 1;
    FieldByName('FAXEMP').Tag := 1;
    FieldByName('FONE1C').Tag := 1;
    FieldByName('FONE2C').Tag := 1;
    FieldByName('FAXCLI').Tag := 1;
    FieldByName('CELCLI').Tag := 1;
    FieldByName('CGCCLI').Tag := 2;
    FieldByName('CEPEMP').Tag := 3;
    FieldByName('CEPCLI').Tag := 3;
  End;
end;

function TExpCabPedOrc.fCarregaDocumento: Boolean;
begin
  With FQryDoc Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT ');

    {*************************************}
    {* CALCULADOS                        *}
    {**********************************RN*}
    SQL.Add(' IF(FGO_ESPDOC = "PD", "Pedido:", "Orçamento:") TITDOC, ');

    {*************************************}
    {* DADOS DO ORÇAMENTO                *}
    {**********************************RN*}
    SQL.Add('        FGO_NUMDOC NUMORC, ');
    SQL.Add('        FGO_DTAENT DTAORC, ');
    SQL.Add('        OPE_NOMOPE NOMVEN, ');

    {*************************************}
    {* DADOS DA EMPRESA                  *}
    {**********************************RN*}
    SQL.Add('        EMP_ENDERE ENDEMP, ');
    SQL.Add('        EMP_BAIRRO BAIEMP, ');
    SQL.Add('        EMP_ENDNUM NUMEMP, ');
    SQL.Add('        EMP_C_E_P_ CEPEMP, ');
    SQL.Add('        EMP_ENDCMP CMPEMP, ');
    SQL.Add(' CIDEMP.CID_NOMCID CIDEMP, ');
    SQL.Add(' CIDEMP.CID_ESTADO ESTEMP, ');
    SQL.Add('        EMP_HOMEPA SITEMP, ');
    SQL.Add('        EMP_FONE01 FONEMP, ');
    SQL.Add('        EMP_F_A_X_ FAXEMP, ');

    {*************************************}
    {* DADOS DO CLIENTE                  *}
    {**********************************RN*}
    SQL.Add('        CLI_NOMCLI NOMCLI, ');
    SQL.Add('        CLI_ENDERE ENDCLI, ');
    SQL.Add('        CLI_BAIRRO BAICLI, ');
    SQL.Add('        CLI_C_E_P_ CEPCLI, ');
    SQL.Add('        CLI_ENDNUM NUMCLI, ');
    SQL.Add(' CIDCLI.CID_NOMCID CIDCLI, ');
    SQL.Add(' CIDCLI.CID_ESTADO ESTCLI, ');
    SQL.Add('        CLI_ENDCOM CMPCLI, ');
    SQL.Add('        CLI_FONE01 FONE1C, ');
    SQL.Add('        CLI_FONE02 FONE2C, ');
    SQL.Add('        CLI_F_A_X_ FAXCLI, ');
    SQL.Add('        CLI_CELULA CELCLI, ');
    SQL.Add('        CLI_C_G_C_ CGCCLI, ');
    SQL.Add('        CLI_I_E_S_ IESCLI  ');

    SQL.Add('   FROM FATGOR ');
    SQL.Add('  INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ');
    SQL.Add('  INNER JOIN CADEMP ON EMP_CODEMP = FGO_CODEMP ');
    SQL.Add('  INNER JOIN CADCID CIDEMP ON EMP_CODCID = CIDEMP.CID_CODCID ');
    SQL.Add('  INNER JOIN CADCID CIDCLI ON CLI_CODCID = CIDCLI.CID_CODCID ');
    SQL.Add('  INNER JOIN CADOPE ON OPE_CODOPE = FGO_CODVEN ');
    SQL.Add('  WHERE FGO_NUMDOC = :NUMDOC ');
    SQL.Add('    AND FGO_ESPDOC = :ESPDOC ');
    SQL.Add('    AND FGO_CODEMP = :CODEMP ');
    SQL.Add('    AND FGO_CODCLI = :CODCLI ');
    ParamByName('NUMDOC').AsString := FNumDoc;
    ParamByName('ESPDOC').AsString := FEspDoc;
    ParamByName('CODEMP').AsString := FCodEmp;
    ParamByName('CODCLI').AsString := FCodCli;
    Open;

    Result := (Not IsEmpty);

    If (Result) Then
      pSetarTag(FQryDoc);
  End;
end;

end.
