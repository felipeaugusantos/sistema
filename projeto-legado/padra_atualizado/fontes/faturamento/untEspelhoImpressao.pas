unit untEspelhoImpressao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiRelatorio, frxClass, Vcl.ExtCtrls,
  frxExportCSVTestabilidade, Vcl.AppEvnts, frxDesgn, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, RLFilters,
  RLDraftFilter, Vcl.Menus, Vcl.StdCtrls, EditFocus, QColorLabel, Vcl.Buttons,
  BitBtnLockedIncrem, untZClient, untLeDocumento, Data.DB, UniClientDataSet, Uni, untFuncFat;

type
  {$SCOPEDENUMS ON}
  TTipoDescricaoItemEspelho = (ReferenciaDescricao = 1, DescricaoReferencia, Descricao);
  {$SCOPEDENUMS OFF}
  TTipoDescricaoItemEspelhoHelper = Record helper for TTipoDescricaoItemEspelho
    procedure SetValueAsString(strValue: String);
  end;

type
  //Para nao ter hint é preciso implementar esse metodo
  TLeDocumentoLocal = Class(TLeDocumento)
  Public
    function fSQLItems: String; override;
  End;

  TfrmEspelhoImpressao = class(TfrmPaiRelatorio)
    frxDBEmpresa: TfrxDBDataset;
    frxDBFornecedor: TfrxDBDataset;
    frxDBEspGer: TfrxDBDataset;
    frxDBEspDet: TfrxDBDataset;
    frxDBTransportadora: TfrxDBDataset;
    frxEspelho: TfrxReport;
    frxDBDuplic: TfrxDBDataset;
    frxDBEndEnt: TfrxDBDataset;

    function frxEspelhoUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure FormCreate(Sender: TObject);
  private
    qryCadEmp : TZClient;
    qryCadFor : TZClient;
    qryCadTra : TZClient;
    qryEspGer : TZClient;
    qryEspDet : TZClient;
    qryDuplic : TZClient;
    qryEndEnt : TZClient;

    strTip_FC : String;
    blnEspDANFE: Boolean;
    blnEspAD : Boolean;
    blnDocFor : Boolean;
    FDiscriminacao : String;
    FTipoDescricaoItem: TTipoDescricaoItemEspelho;

    intDecUni : Integer;
    strPathLayoutEspecifico : String;

    function fGetSQLEmpresa : String;
    function fGetSQLClienteComoEmpresa: String;

    function fGetSQLFornecedor: String;
    function fGetSQLEmpresaComoFornecedor: String;
    function fGetSQLTransportadora(AEspDANFE: Boolean): String;
    function fGetSQLEspGer: String;
    function fGetSQLEspDet: String;
    function fGetSQLCliente: String;
    function fGetSQLDuplic: String;
    function fGetSQLEndEnt: String;

    function fForcaSubTributariaEmDadosPropriosRegraBrinde: Boolean;
    procedure processaDespesasAcessoriasEDadosAdicionais(const strOpcDoc: String; aEspGer: TUniClientDataSet = nil; aEspDet: TUniClientDataSet = nil);
    function fExisteItensDevolvidos(aEspGer, aEspDet: TUniClientDataSet): Boolean;
    procedure pCriarDataSet();
    function fExibeDadosTransportadora(intTipFre: Integer): Boolean;
    procedure pPreencheDadosAdicionais;
    function fRetornaValoresIn(const AstrFieldName: String; AqryDet: TUniClientDataSet): String ;
    procedure pFormataValorUnitario();
  public
    class procedure pImprimeEspelho(const strOpcDoc: String; strCodEmp, strNumEsp: String; strArquivoPdf: String = ''; AfatVenda : TFatVenda = Nil);
    class procedure pImprimeEspelhoDANFE(const strOpcDoc: String; aCodEmp: String; aDocFor: Boolean; aEspGer, aEspDet: TUniClientDataSet; strArquivoPdf: String = ''; aDuplic: TUniClientDataSet = Nil; aEndEnt: TUniClientDataSet = Nil; AEspelhoDevolucaoCliente: Boolean = False);
  end;


implementation

uses
  untFuncoesSimples, untFuncoesGenerica, untFuncoesLibNfe, untGerarEspelhoDevolucaoAD,
  System.StrUtils;

{$R *.dfm}

{ TfrmEspelhoImpressao }

function TfrmEspelhoImpressao.fGetSQLEmpresa: String;
begin
  Result := '';
  Result := Result + ' SELECT EMP_NOMEMP AS NOMEMP, ';
  Result := Result + '        EMP_ENDERE AS ENDERE, ';
  Result := Result + '        EMP_ENDNUM AS ENDNUM, ';
  Result := Result + '        EMP_ENDCMP AS ENDCMP, ';
  Result := Result + '        EMP_BAIRRO AS BAIRRO, ';
  Result := Result + '        EMP_C_E_P_ AS C_E_P_, ';
  Result := Result + '        EMP_C_G_C_ AS C_G_C_, ';
  Result := Result + '        EMP_I_E_S_ AS I_E_S_, ';
  Result := Result + '        CID_NOMCID AS NOMCID, ';
  Result := Result + '        (SELECT EMP_INSSUB FROM EMPISB WHERE EMP_CODEMP = :CODEMP AND EMP_ESTADO = :ESTADO) AS INSSUB ';
  Result := Result + ' FROM CADEMP                  ';
  Result := Result + '   LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
  Result := Result + ' WHERE EMP_CODEMP = :CODEMP   ';
end;

function TfrmEspelhoImpressao.fGetSQLEmpresaComoFornecedor: String;
begin
  Result := '';
  Result := Result + ' SELECT EMP_NOMEMP AS NOMFOR, ';
  Result := Result + '        EMP_ENDERE AS ENDERE, ';
  Result := Result + '        EMP_ENDNUM AS ENDNUM, ';
  Result := Result + '        EMP_BAIRRO AS BAIRRO, ';
  Result := Result + '        EMP_C_E_P_ AS C_E_P_, ';
  Result := Result + '        EMP_C_G_C_ AS C_G_C_, ';
  Result := Result + '        EMP_I_E_S_ AS I_E_S_, ';
  Result := Result + '        CID_NOMCID AS NOMCID, ';
  Result := Result + '        CID_ESTADO AS ESTADO, ';
  Result := Result + '        EMP_FONE01 AS FONE01  ';
  Result := Result + ' FROM CADEMP ';
  Result := Result + '   LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
  Result := Result + ' WHERE EMP_CODEMP = :CODEMP ';
end;

function TfrmEspelhoImpressao.fGetSQLCliente: String;
begin
  Result := '';
  Result := Result + ' SELECT CLI_NOMCLI AS NOMFOR, ';
  Result := Result + '        CLI_ENDERE AS ENDERE, ';
  Result := Result + '        CLI_ENDNUM AS ENDNUM, ';
  Result := Result + '        CLI_BAIRRO AS BAIRRO, ';
  Result := Result + '        CLI_C_E_P_ AS C_E_P_, ';
  Result := Result + '        CLI_C_G_C_ AS C_G_C_, ';
  Result := Result + '        CLI_I_E_S_ AS I_E_S_, ';
  Result := Result + '        CID_NOMCID AS NOMCID, ';
  Result := Result + '        CID_ESTADO AS ESTADO, ';
  Result := Result + '        CLI_FONE01 AS FONE01  ';
  Result := Result + ' FROM CADCLI ';
  Result := Result + '   LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  Result := Result + ' WHERE CLI_CODCLI = :CODCLI ';
end;

function TfrmEspelhoImpressao.fGetSQLClienteComoEmpresa: String;
begin
  Result := '';
  Result := Result + ' SELECT CLI_NOMCLI AS NOMEMP, ';
  Result := Result + '        CLI_ENDERE AS ENDERE, ';
  Result := Result + '        CLI_ENDNUM AS ENDNUM, ';
  Result := Result + '        CLI_ENDCOM AS ENDCMP, ';
  Result := Result + '        CLI_BAIRRO AS BAIRRO, ';
  Result := Result + '        CLI_C_E_P_ AS C_E_P_, ';
  Result := Result + '        CLI_C_G_C_ AS C_G_C_, ';
  Result := Result + '        CLI_I_E_S_ AS I_E_S_, ';
  Result := Result + '        CID_NOMCID AS NOMCID, ';
  Result := Result + '        " " AS INSSUB         ';
  Result := Result + ' FROM CADCLI                  ';
  Result := Result + '   LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ';
  Result := Result + ' WHERE CLI_CODCLI = :CODCLI   ';
end;

function TfrmEspelhoImpressao.fGetSQLDuplic: String;
begin
  //Select para evitar erro caso o cdsDuplicada não tenha sido passado na função pImprimeEspelhoDANFE
  Result := '';
  Result := Result + ' SELECT CAST(NULL AS CHAR(3)) AS NUMER1,  ';
  Result := Result + '        CAST(NULL AS CHAR(3)) AS NUMER2,  ';
  Result := Result + '        CAST(NULL AS CHAR(3)) AS NUMER3,  ';
  Result := Result + '        CAST(NULL AS CHAR(10)) AS DTVEN1, ';
  Result := Result + '        CAST(NULL AS CHAR(10)) AS DTVEN2, ';
  Result := Result + '        CAST(NULL AS CHAR(10)) AS DTVEN3, ';
  Result := Result + '        CAST(NULL AS CHAR(12)) AS VALOR1, ';
  Result := Result + '        CAST(NULL AS CHAR(12)) AS VALOR2, ';
  Result := Result + '        CAST(NULL AS CHAR(12)) AS VALOR3  ';
end;

function TfrmEspelhoImpressao.fGetSQLEndEnt: String;
begin
  Result := '';
  Result := Result + ' SELECT CAST(NULL AS CHAR(14)) AS CNPJ,    ';
  Result := Result + '        CAST(NULL AS CHAR(60)) AS XLGR,    ';
  Result := Result + '        CAST(NULL AS CHAR(60)) AS NRO,     ';
  Result := Result + '        CAST(NULL AS CHAR(60)) AS XCPL,    ';
  Result := Result + '        CAST(NULL AS CHAR(50)) AS XBAIRRO, ';
  Result := Result + '        CAST(NULL AS CHAR(7))  AS CMUN,    ';
  Result := Result + '        CAST(NULL AS CHAR(50)) AS XMUN,    ';
  Result := Result + '        CAST(NULL AS CHAR(02)) AS UF,      ';
  Result := Result + '        CAST(NULL AS CHAR(09)) AS CEP,     ';
  Result := Result + '        CAST(NULL AS CHAR(20)) AS FONE     ';
end;

function TfrmEspelhoImpressao.fGetSQLEspDet: String;
  var
    strCampoDesIte: String;
    blnFABNFE: Boolean;
    strSubQueryCodFab: String;
begin
  blnFabNFE := fCfgSis('FABNFE', varString) = 'S';
  Result := '';
  Result := Result + ' SELECT ESPDET.*, ';
  Result := result + '        %s as DESITE, ';
  Result := Result + '        ITE_CLAIPI AS CLAIPI, ';
  Result := Result + '        UNI_SIGUNI AS SIGUNI, ';
  Result := Result + '        FIS_ACESSO AS CHVPRO  ';

  Result := Result + ' FROM ESPDET ';
  Result := Result + ' INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';
  Result := Result + ' LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  Result := Result + ' LEFT  JOIN MOVDET ON MOVDET.AUTOINCREM = ESPDET.DET_SEQDET ';
  Result := Result + ' LEFT  JOIN CADFIS ON (MOVDET.DET_CODEMP = CADFIS.FIS_CODEMP) ';
  Result := Result + '                  AND (MOVDET.DET_ESPDOC = CADFIS.FIS_ESPDOC) ';
  Result := Result + '                  AND (MOVDET.DET_TIP_FC = CADFIS.FIS_TIP_FC) ';
  Result := Result + '                  AND (MOVDET.DET_NUMDOC = CADFIS.FIS_NUMDOC) ';
  Result := Result + '                  AND (IFNULL(MOVDET.DET_SERIE_,"") = IFNULL(CADFIS.FIS_SERIE_,"")) ';
  Result := Result + '                  AND (IF(MOVDET.DET_TIP_FC = "C", MOVDET.DET_CODCLI = CADFIS.FIS_FORCLI, MOVDET.DET_CODFOR = CADFIS.FIS_FORCLI)) ';

  if blnEspDANFE then
    Result := Result + ' WHERE FALSE '
  else
    Result := Result + ' WHERE ESPDET.DET_SEQGER = :SEQGER ';

  case FTipoDescricaoItem of
    TTipoDescricaoItemEspelho.ReferenciaDescricao:
        strCampoDesIte := 'CONCAT(IFNULL(ITE_REFERE, ""), " ", IF(ESPDET.DET_DESCRI IS NULL, ITE_DESITE, ESPDET.DET_DESCRI))';

    TTipoDescricaoItemEspelho.DescricaoReferencia:
        strCampoDesIte := 'CONCAT(IF(ESPDET.DET_DESCRI IS NULL, ITE_DESITE, ESPDET.DET_DESCRI) , " ",  IFNULL(ITE_REFERE, ""))';

    TTipoDescricaoItemEspelho.Descricao:
        strCampoDesIte := 'IF(ESPDET.DET_DESCRI IS NULL, ITE_DESITE, ESPDET.DET_DESCRI)';
  end;

  strCampoDesIte := ' CONCAT('+strCampoDesIte+', "  ", IFNULL(ESPDET.DET_DESNES, "")) ';

  if blnFABNFE  then
  begin
    strSubQueryCodFab :=                     ' SELECT CONCAT(IF(IFNULL(GAD_CODFAB,"") = "", "", CONCAT(GAD_CODFAB, " "))) ';
    strSubQueryCodFab := strSubQueryCodFab + ' FROM ESPDEG ED ';
    strSubQueryCodFab := strSubQueryCodFab + ' JOIN MOVGAD D ON D.AUTOINCREM = ED.DEG_SEQGAD ';
    strSubQueryCodFab := strSubQueryCodFab + ' WHERE ED.DEG_SEQGER = D.AUTOINCREM ';
    strSubQueryCodFab := strSubQueryCodFab + ' LIMIT 1 ';


    strCampoDesIte :=
      'CONCAT(COALESCE((' +strSubQueryCodFab+'),""), '+ strCampoDesIte +')';
  end;

  Result := Format(Result,[strCampoDesIte]) ;
end;

function TfrmEspelhoImpressao.fGetSQLEspGer: String;
  Var
    objLeDoc : TLeDocumentoLocal;
begin
  objLeDoc := TLeDocumentoLocal.Create(nil);

  Result := '';
  Result := Result + ' SELECT                                          ';

  If strTip_FC = 'C' Then
    Result := Result + '   CONCAT("Autorização de Devolução", CHAR(13), GER_CODADE, "-AD") AS NUMESP, '
  Else
    Result := Result + '   CONCAT("Documento Para Aprovação da", CHAR(13), '+
      '"Nota Fiscal Eletrônica", CHAR(13), "Espelho: ", GER_NUMESP) AS NUMESP, ';

  Result := Result + '   GER_CLAFIS, ';
  Result := Result + '   GER_TIP_FC AS TIP_FC, ';

  Result := Result + '   (SELECT GROUP_CONCAT(DET_CODFIS) FROM ESPDET ';
  Result := Result + '    WHERE DET_SEQGER = ESPGER.AUTOINCREM) AS CODFIS, ';

  Result := Result + '   (SELECT SUM(IFNULL(DET_BASFCP,0)) FROM ESPDET ';
  Result := Result + '    WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM) AS BASFCP, ';

  Result := Result + '   (SELECT AVG(IFNULL(DET_PERFCP,0)) FROM ESPDET ';
  Result := Result + '    WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM) AS PERFCP, ';

  Result := Result + '   (SELECT SUM(IFNULL(DET_VALFCP,0)) FROM ESPDET ';
  Result := Result + '    WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM) AS VALFCP, ';

  Result := Result + '   (SELECT SUM(IFNULL(DET_BFCPST,0)) FROM ESPDET ';
  Result := Result + '    WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM) AS BFCPST, ';

  Result := Result + '   (SELECT AVG(IFNULL(DET_PFCPST,0)) FROM ESPDET ';
  Result := Result + '    WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM) AS PFCPST, ';

  Result := Result + '   (SELECT SUM(IFNULL(DET_VFCPST,0)) FROM ESPDET ';
  Result := Result + '    WHERE ESPDET.DET_SEQGER = ESPGER.AUTOINCREM) AS VFCPST, ';

  Result := Result + '   ESPGER.*,                                     ';
  Result := Result + '   CAST(NULL AS CHAR(2048)) AS DISCRIMINACAO_DESPESAS_ACESSORIAS,      ';
  Result := Result + '   CAST(NULL AS CHAR(1024)) AS GER_CNFNFE,        ';
  Result := Result + '   CAST(NULL AS CHAR(1024)) AS GER_CNFFIS,        ';
  Result := Result + '   CAST(NULL AS CHAR(1024)) AS GER_OBSERV,        ';
  Result := Result + '   CAST(NULL AS CHAR(1024)) AS GER_OBSFIS,        ';
  Result := Result + '   CFO_DESCR1 AS CLAFIS,                          ';
  Result := Result + objLeDoc.fSQLTipoFrete('GER_TIPFRE')+ ' AS TIPFRE, ';
  Result := Result + '   0.00 AS GER_IPIDEV                             ';

  Result := Result + ' FROM ESPGER                                      ';
  Result := Result + '   LEFT JOIN CADCFO ON CFO_CODCFO = GER_CLAFIS    ';

  if blnEspDANFE then
    Result := Result + ' WHERE FALSE '
  else
  begin
    Result := Result + ' WHERE GER_NUMESP = :NUMESP                      ';
    Result := Result + '   AND GER_CODEMP = :CODEMP                      ';
  end;

  FreeAndNil(objLeDoc);
end;

function TfrmEspelhoImpressao.fGetSQLFornecedor: String;
begin
  Result := '';
  Result := Result + ' SELECT FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '        FOR_ENDERE AS ENDERE, ';
  Result := Result + '        FOR_ENDNUM AS ENDNUM, ';
  Result := Result + '        FOR_BAIRRO AS BAIRRO, ';
  Result := Result + '        FOR_C_E_P_ AS C_E_P_, ';
  Result := Result + '        FOR_C_G_C_ AS C_G_C_, ';
  Result := Result + '        FOR_I_E_S_ AS I_E_S_, ';
  Result := Result + '        CID_NOMCID AS NOMCID, ';
  Result := Result + '        CID_ESTADO AS ESTADO, ';
  Result := Result + '        FOR_FONE01 AS FONE01  ';
  Result := Result + ' FROM CADFOR ';
  Result := Result + '   LEFT JOIN CADCID ON CID_CODCID = FOR_CODCID ';
  Result := Result + ' WHERE FOR_CODFOR = :CODFOR ';
end;

function TfrmEspelhoImpressao.fGetSQLTransportadora(AEspDANFE: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT TRA_NOMTRA AS NOMTRA, ';
  Result := Result + '        TRA_ENDERE AS ENDERE, ';
  Result := Result + '        TRA_BAIRRO AS BAIRRO, ';
  Result := Result + '        TRA_C_E_P_ AS C_E_P_, ';
  Result := Result + '        TRA_C_G_C_ AS C_G_C_, ';
  Result := Result + '        TRA_I_E_S_ AS I_E_S_, ';
  Result := Result + '        CID_ESTADO AS ESTADO, ';
  Result := Result + '        CID_NOMCID AS NOMCID  ';
  Result := Result + ' FROM CADTRA ';
  Result := Result + '   LEFT JOIN CADCID ON CID_CODCID = TRA_CODCID ';
  Result := Result + ' WHERE TRA_CODTRA = :CODTRA';

  If (Not AEspDANFE) And (Not blnEspAD) Then
    If strTip_FC = 'C' Then
      Result := Result + ' AND FALSE ';
end;

function TfrmEspelhoImpressao.fExibeDadosTransportadora(intTipFre: Integer): Boolean;
begin
  Result := True;

  If (intTipFre <> 9) Then
    Exit;

  If (fCfgSis('OUSAFO', varInteger) <> 2) Then
    Exit;

  Result := False;
end;

procedure TfrmEspelhoImpressao.FormCreate(Sender: TObject);
begin
  inherited;
  FTipoDescricaoItem.SetValueAsString(fCfgSis('TDIESP',varString));

  intDecUni := fCfgSis('DECUNI', VarInteger);
end;

function TfrmEspelhoImpressao.fRetornaValoresIn(const AstrFieldName: String;
  AqryDet: TUniClientDataSet): String;
var
  LstrRetorno: String ;
begin
  LstrRetorno := '' ;
  result := fQuotedStr('') ;

  if not Assigned(AqryDet) then
    exit ;

  AqryDet.First ;
  while not AqryDet.Eof do
  begin
    if fEmptyStr(LstrRetorno) then
      LstrRetorno := fQuotedStr(AqryDet.FieldByName(AstrFieldName).AsString)
    else
      LstrRetorno := LstrRetorno + ',' + fQuotedStr(AqryDet.FieldByName(AstrFieldName).AsString) ;
    AqryDet.Next ;
  end ;

  if not fEmptyStr(LstrRetorno) then
    Result := LstrRetorno ;

  AqryDet.First ;
end;

function TfrmEspelhoImpressao.frxEspelhoUserFunction(const MethodName: string;
  var Params: Variant): Variant;
begin
  inherited;
  Result := fImprimeIPIDadosProprios(qryEspGer.FieldByName('GER_CLAFIS').AsString,
                                     VS_strClaVen,
                                     fCfgSis('IVLIPI', varString),
                                     fCfgSis('CONIPI', varBoolean));
end;

function TfrmEspelhoImpressao.fExisteItensDevolvidos(aEspGer, aEspDet: TUniClientDataSet): Boolean;
Var
  qryAux: TUniQuery;
  LstrNumDoc: String ;
  LstrEspDoc: String ;
  LstrCodEmp: String ;
  LstrCodIte: String ;
  LstrCodFor: String ;
  LstrTip_fc: string ;
begin
  Result := False;

  qryAux := fCriaQuery(Nil);
  Try
    if not fEmptyStr(qryEspGer.FieldByName('GER_NUMESP').AsString) then
    begin
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  (SELECT COUNT(DET_NUMDOC) FROM MOVDET ');
      qryAux.SQL.Add('    WHERE MOVDET.DET_NUMDOC = ESPDET.DET_DOCDEV ');
      qryAux.SQL.Add('      AND MOVDET.DET_ESPDOC = ESPDET.DET_ESPDEV ');
      qryAux.SQL.Add('      AND MOVDET.DET_CODEMP = ESPDET.DET_EMPDEV ');
      qryAux.SQL.Add('      AND MOVDET.DET_CODFOR = ESPGER.GER_CODFOR ');
      qryAux.SQL.Add('      AND MOVDET.DET_TIP_FC = ESPGER.GER_TIP_FC ');
      qryAux.SQL.Add('      AND MOVDET.DET_CODITE = ESPDET.DET_CODITE ');
      qryAux.SQL.Add('      AND MOVDET.DET_ORIDOC = "") AS QTDE ');
      qryAux.SQL.Add('FROM ESPGER ');
      qryAux.SQL.Add('INNER JOIN ESPDET ON DET_SEQGER = ESPGER.AUTOINCREM ');
      qryAux.SQL.Add('INNER JOIN CADFOR ON FOR_CODFOR = ESPGER.GER_CODFOR ');
      qryAux.SQL.Add('WHERE GER_NUMESP = :NUMESP ');
      qryAux.SQL.Add('  AND GER_CODEMP = :CODEMP ');
      qryAux.SQL.Add('  AND GER_TIP_FC = "F" ');
      qryAux.SQL.Add('  AND FOR_MATREV = "I" ');

      qryAux.ParamByName('NUMESP').AsString := qryEspGer.FieldByName('GER_NUMESP').AsString;
      qryAux.ParamByName('CODEMP').AsString := qryEspGer.FieldByName('GER_CODEMP').AsString;
    end
    else
    begin
      LstrNumDoc := fRetornaValoresIn('DET_DOCDEV', aEspDet) ;
      LstrEspDoc := fRetornaValoresIn('DET_ESPDEV', aEspDet) ;
      LstrCodEmp := fRetornaValoresIn('DET_EMPDEV', aEspDet) ;
      LstrCodIte := fRetornaValoresIn('DET_CODITE', aEspDet) ;
      LstrCodFor := '' ;
      LstrTip_fc := '' ;
      if Assigned(aEspGer) then
      begin
        LstrCodFor := aEspGer.FieldByName('GER_CODCLI').AsString;
        LstrTip_fc := aEspGer.FieldByName('GER_TIP_FC').AsString;
      end ;
      qryAux.SQL.Add(' SELECT ');
      qryAux.SQL.Add('   COUNT(DET_NUMDOC) AS QTDE ');
      qryAux.SQL.Add(' FROM MOVDET INNER JOIN CADFOR ON FOR_CODFOR = MOVDET.DET_CODFOR ');
      qryAux.SQL.Add('     WHERE MOVDET.DET_NUMDOC IN ( ' + LstrNumDoc + ' ) ');
      qryAux.SQL.Add('       AND MOVDET.DET_ESPDOC IN ( ' + LstrEspDoc  + ' ) ');
      qryAux.SQL.Add('       AND MOVDET.DET_CODEMP IN ( ' + LstrCodEmp  + ' ) ');
      qryAux.SQL.Add('       AND MOVDET.DET_CODFOR = :CODFOR ');
      qryAux.SQL.Add('       AND MOVDET.DET_TIP_FC = :TIP_FC ');
      qryAux.SQL.Add('       AND MOVDET.DET_CODITE IN ( ' + LstrCodIte + ' ) ');
      qryAux.SQL.Add('       AND MOVDET.DET_ORIDOC = "" ');
      qryAux.SQL.Add('       AND FOR_MATREV = "I" ');

      qryAux.ParamByName('CODFOR').AsString := LstrCodFor ;
      qryAux.ParamByName('TIP_FC').AsString := LstrTip_fc ;
    end ;

    qryAux.Open;

    If not qryAux.IsEmpty Then
      Result := (qryAux.FieldByName('QTDE').AsFloat > 0);

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmEspelhoImpressao.fForcaSubTributariaEmDadosPropriosRegraBrinde: Boolean;
begin
  Result := False;

  If not fCfgSis('BRI_ST', varBoolean) Then
    Exit;

  If not (Pos(qryEspGer.FieldByName('GER_CLAFIS').AsString, '5910_6910_') > 0) Then
    Exit;

  If not (qryEspGer.FieldByName('GER_TOTRET').AsFloat > 0) Then
    Exit;

  Result := True;
end;

procedure TfrmEspelhoImpressao.processaDespesasAcessoriasEDadosAdicionais(const strOpcDoc: String; aEspGer: TUniClientDataSet = nil; aEspDet: TUniClientDataSet = nil);
var
  fltTotRet : double;
  fltBasRet : double;
  fltTotFcp : double;
  fltAlqFcp : double;
  fltBasIPI : double;
  fltTotIPI : double;
  fltDesAce : double;
  fltIpiDev : double;
  fltBasFcp: double;
  fltPerFcp: double;
  fltValFcp: double;
  fltBasFcpST: double;
  fltPerFcpST: double;
  fltTotFcpST: double;
  strForcaSubTributariaEmDadosPropriosLocal: String;
begin
  inherited;
  if (not qryEspGer.Active) or (qryEspGer.IsEmpty) then
    exit;

  FDiscriminacao := '';

  qryEspGer.First;
  while not qryEspGer.Eof do
  begin

    FDiscriminacao   := qryEspGer.FieldByName('DISCRIMINACAO_DESPESAS_ACESSORIAS').AsString;
    fltTotRet        := qryEspGer.FieldByName('GER_TOTRET').AsFloat;
    fltBasRet        := qryEspGer.FieldByName('GER_BASRET').AsFloat;
    fltAlqFcp        := qryEspGer.FieldByName('GER_ALQFCP').AsFloat;
    fltTotFcp        := qryEspGer.FieldByName('GER_TOTFCP').AsFloat;
    fltBasIPI        := qryEspGer.FieldByName('GER_BASIPI').AsFloat;
    fltTotIPI        := qryEspGer.FieldByName('GER_TOTIPI').AsFloat;
    fltDesAce        := qryEspGer.FieldByName('GER_DESACE').AsFloat;
    fltBasFcp        := qryEspGer.FieldByName('BASFCP').AsFloat;
    fltPerFcp        := qryEspGer.FieldByName('PERFCP').AsFloat;
    fltValFcp        := qryEspGer.FieldByName('VALFCP').AsFloat;
    fltBasFcpST      := qryEspGer.FieldByName('BFCPST').AsFloat;
    fltPerFcpST      := qryEspGer.FieldByName('PFCPST').AsFloat;
    fltTotFcpST      := qryEspGer.FieldByName('VFCPST').AsFloat;

    If (Not fEmptyStr(qryEspGer.FieldByName('GER_NUMESP').AsString)) Then
      fltIpiDev := fEspelhoValorIpiDevolvido(qryEspGer.FieldByName('GER_NUMESP').AsString,
                                              qryEspGer.FieldByName('GER_CODEMP').AsString)
    Else
      fltIpiDev := qryEspGer.FieldByName('GER_IPIDEV').AsFloat;

    strForcaSubTributariaEmDadosPropriosLocal := IIF(fForcaSubTributariaEmDadosPropriosRegraEspecial('OF',
                                                                                                     qryEspGer.FieldByName('TIP_FC').AsString,
                                                                                                     qryEspGer.FieldByName('CLAFIS').AsString,
                                                                                                     qryEspGer.FieldByName('CODFIS').AsString,
                                                                                                     fCfgSis('SIMPAU', varBoolean),
                                                                                                     qryEspGer.FieldByName('GER_TOTRET').AsFloat,
                                                                                                     qryEspGer.FieldByName('VALFCP').AsFloat,
                                                                                                     qryEspGer.FieldByName('VFCPST').AsFloat), 'S', 'N');
    If not (strForcaSubTributariaEmDadosPropriosLocal = 'S') Then
      strForcaSubTributariaEmDadosPropriosLocal := IIF(fForcaSubTributariaEmDadosPropriosRegraBrinde, 'S', 'N');

    If Not fImprimeSubTributariaDadosProprios(qryEspGer.FieldByName('GER_CLAFIS').AsString,
                                              VS_strClaVen,
                                              fRegimeSubstituicaoTributaria('', strOpcDoc),
                                              fCfgSis('SIMPAU', varBoolean),
                                              strForcaSubTributariaEmDadosPropriosLocal) Then
    Begin



      If (fltTotRet > 0) Then
      Begin
        FDiscriminacao := FDiscriminacao
                          + ' BC.ST: ' + FloatToStrF(fltBasRet, ffNumber, 12, 2)
                          + ' VL.ST: ' + FloatToStrF(fltTotRet, ffNumber, 12, 2);
      End;

      If (fltTotRet > 0) And (fltTotFcpST > 0) Then
      Begin
        If Not fEmptyStr(FDiscriminacao) Then
          FDiscriminacao := FDiscriminacao + ' / ';

        fltDesAce := fltDesAce + fltTotFcpST;
        FDiscriminacao := FDiscriminacao
                            + ' BC.FCP ST: ' + FloatToStrF(fltBasFcpST, ffNumber, 12, 2)
                            + ' AL.FCP ST: ' + FloatToStrF(fltPerFcpST, ffNumber, 12, 2)
                            + ' VL.FCP ST: ' + FloatToStrF(fltTotFcpST, ffNumber, 12, 2);
      End;


      fltDesAce := fltDesAce + fltTotRet;
      fltBasRet := 0;
      fltTotRet := 0;

    End
    Else If (fltTotRet > 0) And (fltTotFcpST > 0) Then
    Begin
      If Not fEmptyStr(FDiscriminacao) Then
        FDiscriminacao := FDiscriminacao + ' / ';

      FDiscriminacao := FDiscriminacao
                          + ' BC.FCP ST: ' + FloatToStrF(fltBasFcpST, ffNumber, 12, 2)
                          + ' AL.FCP ST: ' + FloatToStrF(fltPerFcpST, ffNumber, 12, 2)
                          + ' VL.FCP ST: ' + FloatToStrF(fltTotFcpST, ffNumber, 12, 2);
    End;

    If (fltValFcp > 0) Then
    Begin
      If Not fEmptyStr(FDiscriminacao) Then
        FDiscriminacao := FDiscriminacao + ' / ';

      FDiscriminacao := FDiscriminacao
                          + ' BC.FCP: ' + FloatToStrF(fltBasFcp, ffNumber, 12, 2)
                          + ' AL.FCP: ' + FloatToStrF(fltPerFcp, ffNumber, 12, 2)
                          + ' VL.FCP: ' + FloatToStrF(fltValFcp, ffNumber, 12, 2);
    End;

    if not  fImprimeIPIDadosProprios(qryEspGer.FieldByName('GER_CLAFIS').AsString,
                                 VS_strClaVen,
                                 fCfgSis('IVLIPI', varString),
                                 fCfgSis('CONIPI', varBoolean)) then
    begin

      if (fFormataFloat(fltTotIpi, 2) > 0) And (fFormataFloat(fltIpiDev, 2) = 0) then
      begin
        If Not fEmptyStr(FDiscriminacao) Then
          FDiscriminacao := FDiscriminacao + ' / ';

        FDiscriminacao := FDiscriminacao + 'VL. IPI: ' + FloatToStrF(fltTotIpi, ffNumber, 12, 2);
      end;

      If fltIpiDev > 0 Then
      Begin
        If Not fEmptyStr(FDiscriminacao) Then
          FDiscriminacao := FDiscriminacao + ' / ';

        FDiscriminacao := FDiscriminacao + 'IPI Devolvido: ' + FloatToStrF(fltIpiDev, ffNumber, 12, 2);
      End;

      fltTotIpi := fltTotIpi - fltIpiDev;
      fltDesAce := fltDesAce + fltTotIpi;

      If fExisteItensDevolvidos(aEspGer, aEspDet) Then
        fltDesAce := fltDesAce - fltTotIpi;

      fltTotIpi := 0;
    end
    Else If (fFormataFloat(fltIpiDev, 2) > 0) Then
    Begin
      fltTotIpi := fltTotIpi - fltIpiDev;
      If (fltTotIpi <= 0) Then
      Begin
        fltTotIpi := 0;
        fltBasIPI := 0;
      End;
      qryEspDet.First;
      While Not qryEspDet.Eof Do
      Begin
        If fEmptyStr(qryEspDet.FieldByName('DET_DOCDEV').AsString) Then
        Begin
          qryEspDet.Next;
          Continue;
        End;
        qryEspDet.Edit;
        qryEspDet.FieldByName('DET_ALQIPI').AsFloat := 0;
        qryEspDet.FieldByName('DET_BASIPI').AsFloat := 0;
        qryEspDet.FieldByName('DET_VALIPI').AsFloat := 0;
        qryEspDet.Post;
        qryEspDet.Next;
      End;
    End;

    qryEspGer.Edit;
    qryEspGer.FieldByName('DISCRIMINACAO_DESPESAS_ACESSORIAS').AsString := FDiscriminacao;
    qryEspGer.FieldByName('GER_TOTRET').AsFloat                         := fltTotRet;
    qryEspGer.FieldByName('GER_BASRET').AsFloat                         := fltBasRet;
    qryEspGer.FieldByName('GER_ALQFCP').AsFloat                         := fltAlqFcp;
    qryEspGer.FieldByName('GER_TOTFCP').AsFloat                         := fltTotFcp;
    qryEspGer.FieldByName('GER_BASIPI').AsFloat                         := fltBasIPI;
    qryEspGer.FieldByName('GER_TOTIPI').AsFloat                         := fltTotIPI;
    qryEspGer.FieldByName('GER_DESACE').AsFloat                         := fltDesAce;
    qryEspGer.FieldByName('GER_IPIDEV').AsFloat                         := fltIpiDev;

    qryEspGer.Post;

    qryEspGer.Next;
  end;

end;


procedure TfrmEspelhoImpressao.pCriarDataSet();
begin
  if blnEspDANFE then
    qryCadEmp := TZClient.Create(Self, fGetSQLEmpresa)
  Else If strTip_FC <> 'C' Then
    qryCadEmp := TZClient.Create(Self, fGetSQLEmpresa)
  Else
    qryCadEmp := TZClient.Create(Self, fGetSQLClienteComoEmpresa);

  frxDBEmpresa.DataSet := qryCadEmp;

  if blnEspDANFE and blnDocFor then
    qryCadFor := TZClient.Create(Self, fGetSQLfornecedor)
  else if blnEspDANFE and (not blnDocFor) then
    qryCadFor := TZClient.Create(Self, fGetSQLCliente)
  Else If strTip_FC <> 'C' Then
    qryCadFor := TZClient.Create(Self, fGetSQLfornecedor)
  Else
    qryCadFor := TZClient.Create(Self, fGetSQLEmpresaComoFornecedor);

  frxDBFornecedor.DataSet := qryCadFor;

  qryCadTra := TZClient.Create(Self, fGetSQLTransportadora(blnEspDANFE));
  frxDBTransportadora.DataSet := qryCadTra;

  qryEspGer := TZClient.Create(Self, fGetSQLEspGer);
  frxDBEspGer.DataSet := qryEspGer;

  qryEspDet := TZClient.Create(Self, fGetSQLEspDet);
  frxDBEspDet.DataSet := qryEspDet;

  qryDuplic := TZClient.Create(Self, fGetSQLDuplic);
  frxDBDuplic.DataSet := qryDuplic;

  qryEndEnt := TZClient.Create(Self, fGetSQLEndEnt);
  frxDBEndEnt.DataSet := qryEndEnt;

end;

class procedure TfrmEspelhoImpressao.pImprimeEspelho(const strOpcDoc: String; strCodEmp, strNumEsp: String; strArquivoPdf: String = ''; AfatVenda : TFatVenda = Nil);
  var
    frmEspelhoImpressao: TfrmEspelhoImpressao;
    Log: TLogEspeloAD;
    strSeqGer,
    strCodAde: String;
begin
  pCriarFormularios(TfrmEspelhoImpressao, frmEspelhoImpressao);
  Log := TLogEspeloAD.Create;
  Try
    Try
      With frmEspelhoImpressao Do
      Begin
        strPathLayoutEspecifico := fCfgSis('PATETI') + '\EspelhoDANFE_ESPECIFICO.fr3';
        strPathLayoutEspecifico := IIF(FileExists(strPathLayoutEspecifico),
                                                  strPathLayoutEspecifico, EmptyStr);

        If Not fEmptyStr(strPathLayoutEspecifico) Then
          frxEspelho.LoadFromFile(strPathLayoutEspecifico);

        blnEspDANFE := False;
        strTip_FC := fCampoTabela('GER_TIP_FC', 'ESPGER', ['GER_NUMESP','GER_CODEMP'], [strNumEsp, strCodEmp]);
        blnEspAD  := not fEmptyStr(fCampoTabela('GER_CODADE', 'ESPGER', ['GER_NUMESP','GER_CODEMP'], [strNumEsp, strCodEmp]));

        pCriarDataSet();

        qryEspGer.qryQuery.ParamByName('NUMESP').AsString := strNumEsp;
        qryEspGer.qryQuery.ParamByName('CODEMP').AsString := strCodEmp;
        qryEspGer.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelho');

        if Assigned(AFatVenda) then
        begin
          qryEspGer.Edit ;
          qryEspGer.FieldByName('GER_CNFNFE').AsString  := AFatVenda.fRetDadosCNF_NFE('C');
          qryEspGer.FieldByName('GER_CNFFIS').AsString  := AFatVenda.fRetDadosCNF_NFE('F');
          qryEspGer.FieldByName('GER_OBSERV').AsString  := AFatVenda.fMensagemAdicionalComercial;
          qryEspGer.FieldByName('GER_OBSFIS').AsString  := AFatVenda.fMensagemAdicionalFiscal;
          qryEspGer.Post ;
        end ;

        qryEspDet.qryQuery.ParamByName('SEQGER').AsString := qryEspGer.FieldByName('AUTOINCREM').AsString;
        qryEspDet.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelho');

        processaDespesasAcessoriasEDadosAdicionais(strOpcDoc);

        strSeqGer := qryEspGer.FieldByName('AUTOINCREM').AsString;
        strCodAde := qryEspGer.FieldByName('GER_CODADE').AsString;

        If qryCadFor.qryQuery.FindParam('CODFOR') <> Nil Then
          qryCadFor.qryQuery.ParamByName('CODFOR').AsString := qryEspGer.FieldByName('GER_CODFOR').AsString;

        If qryCadFor.qryQuery.FindParam('CODEMP') <> Nil Then
          qryCadFor.qryQuery.ParamByName('CODEMP').AsString := qryEspGer.FieldByName('GER_CODEMP').AsString;

        qryCadFor.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelho');
        qryCadFor.Edit;
        qryCadFor.FieldByName('C_G_C_').AsString := fFormataCpfCgc(qryCadFor.FieldByName('C_G_C_').AsString, fSetaPais);
        qryCadFor.FieldByName('C_E_P_').AsString := fFormataCEP(qryCadFor.FieldByName('C_E_P_').AsString);
        qryCadFor.Post;

        If qryCadEmp.qryQuery.FindParam('CODEMP') <> Nil Then
          qryCadEmp.qryQuery.ParamByName('CODEMP').AsString := strCodEmp;

        If qryCadEmp.qryQuery.FindParam('CODCLI') <> Nil Then
          qryCadEmp.qryQuery.ParamByName('CODCLI').AsString := qryEspGer.FieldByName('GER_CODCLI').AsString;

        If qryCadEmp.qryQuery.FindParam('ESTADO') <> Nil Then
          qryCadEmp.qryQuery.ParamByName('ESTADO').AsString := qryCadFor.FieldByName('ESTADO').AsString;

        qryCadEmp.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelho');
        qryCadEmp.Edit;
        qryCadEmp.FieldByName('C_G_C_').AsString := fFormataCpfCgc(qryCadEmp.FieldByName('C_G_C_').AsString, fSetaPais);
        qryCadEmp.Post;

        qryCadTra.qryQuery.ParamByName('CODTRA').AsString := qryEspGer.FieldByName('GER_CODTRA').AsString;

        If (Not fExibeDadosTransportadora(qryEspGer.FieldByName('GER_TIPFRE').AsInteger)) Then
          qryCadTra.qryQuery.ParamByName('CODTRA').AsString := '';

        qryCadTra.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelho');
        qryCadTra.Edit;
        qryCadTra.FieldByName('C_G_C_').AsString := fFormataCpfCgc(qryCadTra.FieldByName('C_G_C_').AsString, fSetaPais);
        qryCadTra.FieldByName('C_E_P_').AsString := fFormataCEP(qryCadTra.FieldByName('C_E_P_').AsString);
        qryCadTra.Post;

        pPreencheDadosAdicionais();

        frxEspelho.AddFunction('function fImprimeIPIDadosProprios: Boolean;');

        pFormataValorUnitario();

        If frxEspelho.PrepareReport() Then
        Begin
          If Not fEmptyStr(strArquivoPdf) Then
          Begin
            frxExpPDF.FileName    := ExtractFileName(strArquivoPdf);
            frxExpPDF.DefaultPath := ExtractFilePath(strArquivoPdf);
            frxExpPDF.ShowDialog  := False;
            frxEspelho.Export(frxExpPDF);
          End
          Else
            pPreviewReport('frmEspelhoImpressao', 'Espelho de Nota Fiscal', frxEspelho);

          If FileExists(strArquivoPdf) Then
            Log.pAddLog(tpImpressao, strCodAde, strSeqGer, 'Relatório gerado em: ' + strArquivoPdf)
          Else
            If Not fEmptyStr(frxEspelho.Report.Errors.Text) Then
              Log.pAddLog(tpErroGrav, strCodAde, strSeqGer, 'Problema na gravação do relatório: ' + frxEspelho.Report.Errors.Text);
        End;

      End;
    Except
      On E : Exception Do
      Begin
        pMensagensErro(E.message, '');
        Log.pAddLog(tpErroGrav, strCodAde, strSeqGer, E.message);
      End;
    End;
  Finally
    FreeAndNil(frmEspelhoImpressao);
    FreeAndNil(Log);
  End;
end;

class procedure TfrmEspelhoImpressao.pImprimeEspelhoDANFE(const strOpcDoc: String; aCodEmp: String; aDocFor: Boolean; aEspGer, aEspDet: TUniClientDataSet; strArquivoPdf: String = ''; aDuplic: TUniClientDataSet = Nil; aEndEnt: TUniClientDataSet = Nil; AEspelhoDevolucaoCliente: Boolean = False);
var
  frmEspelhoImpressao: TfrmEspelhoImpressao;
begin
  try
    pCriarFormularios(TfrmEspelhoImpressao, frmEspelhoImpressao);

    frmEspelhoImpressao.blnDocFor := aDocFor;

    If AEspelhoDevolucaoCliente Then
      frmEspelhoImpressao.blnEspDANFE := False
    Else
      frmEspelhoImpressao.blnEspDANFE := True;

    frmEspelhoImpressao.strTip_FC := IIF(aDocFor, 'F', 'C');
    frmEspelhoImpressao.pCriarDataSet();

    frmEspelhoImpressao.qryEndEnt.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelhoDANFE');
    if Assigned(aEndEnt) then
      frmEspelhoImpressao.qryEndEnt.Data := aEndEnt.Data
    else
      frmEspelhoImpressao.qryEndEnt.EmptyDataSet;

    frmEspelhoImpressao.qryEspGer.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelho');
    frmEspelhoImpressao.qryEspGer.Data := aEspGer.Data;

    frmEspelhoImpressao.qryEspDet.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelho');
    frmEspelhoImpressao.qryEspDet.Data := aEspDet.Data;

    frmEspelhoImpressao.processaDespesasAcessoriasEDadosAdicionais(strOpcDoc, aEspGer, aEspDet);

    If frmEspelhoImpressao.qryCadFor.qryQuery.FindParam('CODFOR') <> Nil Then
    Begin
      frmEspelhoImpressao.qryCadFor.qryQuery.ParamByName('CODFOR').AsString := frmEspelhoImpressao.qryEspGer.FieldByName('GER_CODCLI').AsString;
      If fEmptyStr( frmEspelhoImpressao.qryCadFor.qryQuery.ParamByName('CODFOR').AsString ) Then
        frmEspelhoImpressao.qryCadFor.qryQuery.ParamByName('CODFOR').AsString := frmEspelhoImpressao.qryEspGer.FieldByName('GER_CODFOR').AsString;
    End
    else If frmEspelhoImpressao.qryCadFor.qryQuery.FindParam('CODCLI') <> Nil Then
    begin
      frmEspelhoImpressao.qryCadFor.qryQuery.ParamByName('CODCLI').AsString := frmEspelhoImpressao.qryEspGer.FieldByName('GER_CODCLI').AsString;
    end;

    If frmEspelhoImpressao.qryCadFor.qryQuery.FindParam('CODEMP') <> Nil Then
      frmEspelhoImpressao.qryCadFor.qryQuery.ParamByName('CODEMP').AsString := frmEspelhoImpressao.qryEspGer.FieldByName('GER_CODEMP').AsString;

    frmEspelhoImpressao.qryCadFor.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelhoDANFE');

    frmEspelhoImpressao.qryCadFor.Edit;
    frmEspelhoImpressao.qryCadFor.FieldByName('C_G_C_').AsString := fFormataCpfCgc(frmEspelhoImpressao.qryCadFor.FieldByName('C_G_C_').AsString, fSetaPais);
    frmEspelhoImpressao.qryCadFor.FieldByName('C_E_P_').AsString := fFormataCEP(frmEspelhoImpressao.qryCadFor.FieldByName('C_E_P_').AsString);
    frmEspelhoImpressao.qryCadFor.Post;

    If frmEspelhoImpressao.qryCadEmp.qryQuery.FindParam('CODEMP') <> Nil Then
      frmEspelhoImpressao.qryCadEmp.qryQuery.ParamByName('CODEMP').AsString := aCodEmp;

    If frmEspelhoImpressao.qryCadEmp.qryQuery.FindParam('CODCLI') <> Nil Then
      frmEspelhoImpressao.qryCadEmp.qryQuery.ParamByName('CODCLI').AsString := frmEspelhoImpressao.qryEspGer.FieldByName('GER_CODCLI').AsString;

    frmEspelhoImpressao.qryCadEmp.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelhoDANFE');

    frmEspelhoImpressao.qryCadEmp.Edit;
    frmEspelhoImpressao.qryCadEmp.FieldByName('C_G_C_').AsString := fFormataCpfCgc(frmEspelhoImpressao.qryCadEmp.FieldByName('C_G_C_').AsString, fSetaPais);
    frmEspelhoImpressao.qryCadEmp.Post;

    frmEspelhoImpressao.qryCadTra.qryQuery.ParamByName('CODTRA').AsString := frmEspelhoImpressao.qryEspGer.FieldByName('GER_CODTRA').AsString;

    If (Not frmEspelhoImpressao.fExibeDadosTransportadora(frmEspelhoImpressao.qryEspGer.FieldByName('GER_TIPFRE').AsInteger)) Then
      frmEspelhoImpressao.qryCadTra.qryQuery.ParamByName('CODTRA').AsString :='';

    frmEspelhoImpressao.qryCadTra.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelhoDANFE');
    frmEspelhoImpressao.qryCadTra.Edit;
    frmEspelhoImpressao.qryCadTra.FieldByName('C_G_C_').AsString := fFormataCpfCgc(frmEspelhoImpressao.qryCadTra.FieldByName('C_G_C_').AsString, fSetaPais);
    frmEspelhoImpressao.qryCadTra.FieldByName('C_E_P_').AsString := fFormataCEP(frmEspelhoImpressao.qryCadTra.FieldByName('C_E_P_').AsString);
    frmEspelhoImpressao.qryCadTra.Post;


    frmEspelhoImpressao.qryDuplic.fAbreClient(True, 'TfrmEspelhoImpressao.pImprimeEspelhoDANFE');

    if Assigned(aDuplic) then
      frmEspelhoImpressao.qryDuplic.Data := aDuplic.Data
    else
      frmEspelhoImpressao.qryDuplic.EmptyDataSet;

    frmEspelhoImpressao.pPreencheDadosAdicionais();

    try
      frmEspelhoImpressao.frxEspelho.AddFunction('function fImprimeIPIDadosProprios: Boolean;');

      frmEspelhoImpressao.pFormataValorUnitario();

      if frmEspelhoImpressao.frxEspelho.PrepareReport() then
      begin
        if Not fEmptyStr(strArquivoPdf) then
        begin
          frmEspelhoImpressao.frxExpPDF.FileName    := ExtractFileName(strArquivoPdf);
          frmEspelhoImpressao.frxExpPDF.DefaultPath := ExtractFilePath(strArquivoPdf);
          frmEspelhoImpressao.frxExpPDF.ShowDialog  := False;
          frmEspelhoImpressao.frxEspelho.Export(frmEspelhoImpressao.frxExpPDF);
        end
        else
          pPreviewReport('frmEspelhoImpressao', 'Imprimir Espelho DANFE', frmEspelhoImpressao.frxEspelho);
      end;
    except
      On E: Exception do
      begin
        pMensagensErro(E.message, '');
      end;
    end;
  finally
    pFreeAndNil(frmEspelhoImpressao);
  end;
end;

procedure TfrmEspelhoImpressao.pFormataValorUnitario();
var
  objMemo: TfrxMemoView;
  strFormat: String;
begin
  strFormat := '%2.' + IntToStr(intDecUni) + 'n';

  objMemo := TfrxMemoView(frxEspelho.FindObject('memvUnCom'));

  If Assigned(objMemo) Then
    objMemo.DisplayFormat.FormatStr := strFormat;

  objMemo := TfrxMemoView(frxEspelho.FindObject('Memo140'));

  If Assigned(objMemo) Then
    objMemo.DisplayFormat.FormatStr := strFormat;
end;

{ TLeDocumentoLocal }

function TLeDocumentoLocal.fSQLItems: String;
begin
  Result := '';
end;

{ TTipoDescricaoItemEspelhoHelper }

procedure TTipoDescricaoItemEspelhoHelper.SetValueAsString(strValue: String);
begin
  case IndexStr(strValue,['1','2','3']) of
    0: Self := TTipoDescricaoItemEspelho.ReferenciaDescricao;
    1: Self := TTipoDescricaoItemEspelho.DescricaoReferencia;
    2: Self := TTipoDescricaoItemEspelho.Descricao;
    else
      Self := TTipoDescricaoItemEspelho.ReferenciaDescricao;
  end;
end;

procedure TfrmEspelhoImpressao.pPreencheDadosAdicionais;
  Var
    frxMemo: TfrxMemoView;

  function fRetChaveDeProdutos: String;
  begin
    Result := '';
    qryEspDet.First;
    While Not qryEspDet.Eof Do
    Begin

      If fEmptyStr(qryEspDet.FieldByName('CHVPRO').AsString) Then
      Begin
        qryEspDet.Next;
        Continue;
      End;

      If ContainsStr(Result, qryEspDet.FieldByName('CHVPRO').AsString) Then
        Result := Result + qryEspDet.FieldByName('DET_CODITE').AsString + IIF(qryEspDet.RecNo = qryEspDet.RecordCount, '', ', ')
      Else
      Begin
        If Not fEmptyStr(Result) Then
        Begin
          Result := Copy(Result, 1, Length(Result) -2) + sLineBreak;
        End;

        Result := Result + qryEspDet.FieldByName('CHVPRO').AsString + ' - '
                  + qryEspDet.FieldByName('DET_CODITE').AsString + IIF(qryEspDet.RecNo = qryEspDet.RecordCount, '', ', ');
      End;

      qryEspDet.Next;
    End;
  end;

  procedure pIncluirCampo(strCampo: String);
  var
    blnCampoEspGer: Boolean;
  begin
    blnCampoEspGer := (qryEspGer.FindField(strCampo) <> Nil) And (Not fEmptyStr(qryEspGer.FieldByName(strCampo).AsString));

    If blnCampoEspGer Or (qryEspDet.FindField(strCampo) <> Nil) Then
    Begin
      If (strCampo = 'CHVPRO') Then
        frxMemo.Text := frxMemo.Text + fRetChaveDeProdutos
      Else
        frxMemo.Text := frxMemo.Text + qryEspGer.FieldByName(strCampo).AsString;
    End;
  end;

  procedure pIncluirDiscriminacao;
  begin
    If not blnEspDANFE Then
      pIncluirCampo('DISCRIMINACAO_DESPESAS_ACESSORIAS')
    Else
      frxMemo.Text := frxMemo.Text + FDiscriminacao;
  end;

begin
  frxMemo := TfrxMemoView(frxEspelho.FindObject('memOBS'));

  pIncluirCampo('GER_OBSERV');
  pIncluirCampo('GER_CNFNFE');
  pIncluirCampo('GER_MEN001');
  pIncluirCampo('GER_MEN002');
  pIncluirCampo('GER_MEN003');
  pIncluirCampo('GER_MEN004');
  pIncluirCampo('GER_MEN005');
  pIncluirCampo('GER_OBSFIS');
  pIncluirCampo('GER_CNFFIS');
  pIncluirCampo('CHVPRO');
  pIncluirDiscriminacao;
end;

end.

