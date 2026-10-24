unit untGNREModulo;

interface

uses
  System.SysUtils, System.Classes, frxClass, frxDBSet, frxBarcode, Data.DB,
  Vcl.Forms, Vcl.Graphics, Datasnap.DBClient, UniClientDataSet, System.StrUtils, UNI, Printers,
  frxExportPDF, cxStyles, cxGridTableView, cxClasses, untTypesSistema;

type
  TGNREModulo = class(TForm)
    frxReport: TfrxReport;
    cdsDadosGuia: TUniClientDataSet;
    cdsDadosGuiaIdentificador: TStringField;
    cdsDadosGuiaSequencialGuia: TStringField;
    cdsDadosGuiaSituacaoGuia: TStringField;
    cdsDadosGuiaUFfavorecido: TStringField;
    cdsDadosGuiaCodigoReceita: TStringField;
    cdsDadosGuiaTipoDocEmitente: TStringField;
    cdsDadosGuiaDocumentoEmitente: TStringField;
    cdsDadosGuiaRazaoSocialEmitente: TStringField;
    cdsDadosGuiaEnderecoEmitente: TStringField;
    cdsDadosGuiaMinicipioEmitente: TStringField;
    cdsDadosGuiaUFemitente: TStringField;
    cdsDadosGuiaCepEmitente: TStringField;
    cdsDadosGuiaTelefoneEmitente: TStringField;
    cdsDadosGuiaTipoDocDestinatario: TStringField;
    cdsDadosGuiaDocumentoDestinatario: TStringField;
    cdsDadosGuiaMunicipioDestinatario: TStringField;
    cdsDadosGuiaProduto: TStringField;
    cdsDadosGuiaNumeroDocumentoOrigem: TStringField;
    cdsDadosGuiaConvenio: TStringField;
    cdsDadosGuiaInformacoesComplementares: TStringField;
    cdsDadosGuiaDataVencimento: TStringField;
    cdsDadosGuiaDataLimitePagamento: TStringField;
    cdsDadosGuiaPeriodoReferencia: TStringField;
    cdsDadosGuiaMesAnoReferencia: TStringField;
    cdsDadosGuiaParcela: TStringField;
    cdsDadosGuiaValorPrincipal: TCurrencyField;
    cdsDadosGuiaAtualizacaoMonetaria: TCurrencyField;
    cdsDadosGuiaJuros: TCurrencyField;
    cdsDadosGuiaMulta: TCurrencyField;
    cdsDadosGuiaRepresentacaoMonetaria: TStringField;
    cdsDadosGuiaCodigoDeBarras: TStringField;
    cdsDadosGuiaQtdVias: TStringField;
    cdsDadosGuiaNumeroControle: TStringField;
    cdsDadosGuiaIdentificadorGuia: TStringField;
    cdsDadosGuiaGuiaGeradaContingencia: TStringField;
    cdsDadosGuiaReservado: TStringField;
    cdsDadosGuiaValor: TCurrencyField;
    cdsDadosGuiaAmbiente: TStringField;
    cdsDadosGuiaCodigoBarrasBoleto: TStringField;
    cdsDadosGuiaCodigoEmpresa: TStringField;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxDBDatasetGuia: TfrxDBDataset;
    frxPDFExport: TfrxPDFExport;
    cdsDadosGuiaQrCode: TStringField;
    cdsDadosGuiaTitulo: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    function fRetornoMsgAbreviacao(AChaveDeAcesso, ACodCli, AProdutos: String): String;
    function fExibirSelecaoImpressoras(AImpressora: String): Boolean;
    function fRetornaInformacoesComplementares(AQryDados: TUniQuery): String;
    function fRetornaProdutos(ANumDoc, AEspDoc, ACodEmp, ACodCli, AEstado: String; ATipoReceita: TTipoReceitaGnre): String;
    function fRetornaConvenio(LQryDados: TUniQuery; AProdutos: String): String;
    procedure pImpressora(AFormulario, AImpressora: String);
    procedure pEmail;
    procedure pPDF(AAbrir: Boolean = True; AArquivo: String = '');
    function fGetCampoEstadoDaGuia: String;
    { Private declarations }
  public
    procedure pPreparaBoleto(AHomologacao, ABoletoPago: Boolean; ACodigoReceita, AChaveDeAcesso: String; ATipoReceita: TTipoReceitaGnre);
    procedure pPreparaBoletoApuracao(AHomologacao, ABoletoPago: Boolean; ACodigoReceita, AChaveDeApuracao: String; ATipoReceita: TTipoReceitaGnre);
    procedure pGeraExportacaoAutomaticaDeGuiasPDF;
    procedure pImprimir(AFormulario, AImpressora: String);
    { Public declarations }
  end;

var
  GNREModulo: TGNREModulo;

implementation

uses
  untFuncoesGenerica, untFuncoesSimples, untTEnvioEmail;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TGNREModulo.fRetornoMsgAbreviacao(AChaveDeAcesso, ACodCli, AProdutos: String): String;
Var
  LAbrICM: String;
  LQryDados: TUniQuery;
  LSQL: String;
  LSQLNot: String;
begin
  Result := '';

  LAbrICM := fGetTipoAbfCliente(ACodCli);

  If fEmptyStr(LAbrICM) Then
    Exit;

  LQryDados := fCriaQuery(Nil);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT ';
    LSQL := LSQL + ' CONCAT(ABF_MENS01'+LAbrICM+'," ",ABF_MENS02'+LAbrICM+') AS ABREVICAO ';
    LSQL := LSQL + 'FROM MOVDET A1 ';
    LSQL := LSQL + 'INNER JOIN CADCLI A2 ON A2.CLI_CODCLI = A1.DET_CODCLI ';
    LSQL := LSQL + 'LEFT  JOIN CADCID A3 ON A3.CID_CODCID = A2.CLI_CODCID ';
    LSQL := LSQL + 'INNER JOIN CADITE A4 ON A4.ITE_CODITE = A1.DET_CODITE ';
    LSQL := LSQL + 'INNER JOIN ABFICM A5 ON A5.ABF_CODABF = A4.ITE_CODABF AND ';
    LSQL := LSQL + '                        A5.ABF_ESTADO = A3.CID_ESTADO ';
    LSQL := LSQL + 'LEFT  JOIN CADFIS F ON F.FIS_NUMDOC = A1.DET_NUMDOC AND ';
    LSQL := LSQL + '                       F.FIS_ESPDOC = A1.DET_ESPDOC AND ';
    LSQL := LSQL + '                       F.FIS_FORCLI = A1.DET_CODCLI AND ';
    LSQL := LSQL + '                       F.FIS_CODEMP = A1.DET_CODEMP ';
    LSQL := LSQL + 'WHERE DET_TIP_FC = "C" ';
    LSQL := LSQL + '  AND F.FIS_ACESSO = :ACESSO ';

    If Pos(fCfgSis('GNRCOV', varString), 'S_A_') > 0 Then
    Begin
      LSQL := LSQL + '  AND A1.DET_CODITE IN ('+AProdutos+') ';
      LSQL := LSQL + '  AND LENGTH(ABF_MENS01'+LAbrICM+') > 0 ';
    End;

    LSQLNot := AnsiReplaceStr(LSQL,'MOVGER','NOTGER');
    LSQLNot := AnsiReplaceStr(LSQLNot,'MOVDET','NOTDET');
    LSQL := LSQL + ' UNION ALL ' + LSQLNot + 'LIMIT 1 ';

    LQryDados.Close;
    LQryDados.SQL.Clear;
    LQryDados.SQL.Add(LSQL);
    LQryDados.ParamByName('ACESSO').AsString := AChaveDeAcesso;
    LQryDados.Open;

    If not LQryDados.isEmpty Then
    Begin
      Result := LQryDados.FieldByName('ABREVICAO').AsString;
    End;

  Finally
    FreeAndNil(LQryDados);
  End;

end;

procedure TGNREModulo.DataModuleCreate(Sender: TObject);
begin
  cdsDadosGuia.CreateDataSet;
end;

function TGNREModulo.fRetornaInformacoesComplementares(AQryDados: TUniQuery): String;
var
  LIcms: String;
  LFecp: String;
begin
  Result := 'Chave de Acesso: ' + AQryDados.FieldByName('FIS_ACESSO').AsString;

  If AQryDados.FieldByName('GER_ESTADO').AsString = 'RJ' Then
  Begin
    If AQryDados.FieldByName('VAL_ICMS_ST').AsFloat > 0 Then
    Begin
      LIcms := FormatFloat(fMskDigitos(2), AQryDados.FieldByName('VAL_ICMS_ST').AsFloat);
      LFecp := FormatFloat(fMskDigitos(2), AQryDados.FieldByName('VAL_FCP_ST').AsFloat);
    End
    Else
    Begin
      LIcms := FormatFloat(fMskDigitos(2), AQryDados.FieldByName('VAL_DIFAL').AsFloat);
      LFecp := FormatFloat(fMskDigitos(2), AQryDados.FieldByName('VAL_FCP').AsFloat);
    End;

    Result := Result + #13 + 'ICMS: Valor total = R$ ' + LIcms + ' FECP: Valor total = R$ ' + LFecp;
  End;
end;

function TGNREModulo.fRetornaProdutos(ANumDoc, AEspDoc, ACodEmp, ACodCli, AEstado: String; ATipoReceita: TTipoReceitaGnre): String;
Var
  LQryDados: TUniQuery;
  LSQL: String;
  LSQLNot: String;
begin
  Result := '';

  LQryDados := fCriaQuery(Nil);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT DET_CODITE ';
    LSQL := LSQL + 'FROM MOVDET ';
    LSQL := LSQL + 'INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    LSQL := LSQL + 'LEFT  JOIN MOVICD ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM ';
    LSQL := LSQL + 'WHERE DET_NUMDOC = :NUMDOC ';
    LSQL := LSQL + '  AND DET_ESPDOC = :ESPDOC ';
    LSQL := LSQL + '  AND DET_CODEMP = :CODEMP ';
    LSQL := LSQL + '  AND DET_CODCLI = :CODCLI ';

    If (AEstado = 'RJ') Then
    Begin
      case ATipoReceita of
           ST: LSQL := LSQL + '  AND ((DET_VALRET > 0) OR (DET_VFCPST > 0)) ';
          FCP: LSQL := LSQL + '  AND ((DET_VFCPST > 0) OR (ICD_VALFCP > 0)) ';
        DIFAL: LSQL := LSQL + '  AND ((ICD_VALDES > 0) OR (ICD_VALFCP > 0)) ';
      end;
    End
    Else
    Begin
      case ATipoReceita of
           ST: LSQL := LSQL + '  AND (DET_VALRET > 0) ';
          FCP: LSQL := LSQL + '  AND ((DET_VFCPST > 0) OR (ICD_VALFCP > 0)) ';
        DIFAL: LSQL := LSQL + '  AND (ICD_VALDES > 0) ';
      end;
    End;

    LSQLNot := AnsiReplaceStr(LSQL,'MOVDET','NOTDET');
    LSQLNot := AnsiReplaceStr(LSQLNot,'MOVTRI','NOTTRI');
    LSQLNot := AnsiReplaceStr(LSQLNot,'MOVICD','NOTICD');

    LSQL := LSQL + ' UNION ALL ' + LSQLNot;

    LSQL := 'SELECT GROUP_CONCAT(DISTINCT DET_CODITE) AS PRODUTOS FROM ( '+ LSQL +' ) TMP WHERE DET_CODITE IS NOT NULL ';

    LQryDados.Close;
    LQryDados.SQL.Clear;
    LQryDados.SQL.Add(LSQL);
    LQryDados.ParamByName('NUMDOC').AsString := ANumDoc;
    LQryDados.ParamByName('ESPDOC').AsString := AEspDoc;
    LQryDados.ParamByName('CODEMP').AsString := ACodEmp;
    LQryDados.ParamByName('CODCLI').AsString := ACodCli;
    LQryDados.Open;

    If not LQryDados.isEmpty Then
    Begin
      Result := LQryDados.FieldByName('PRODUTOS').AsString;
    End;

  Finally
    FreeAndNil(LQryDados);
  End;
end;

function TGNREModulo.fRetornaConvenio(LQryDados: TUniQuery; AProdutos: String): String;
begin
  Result := '';

  If Pos(fCfgSis('GNRCOV', varString), 'S_A_') > 0 Then
  Begin
    If fEmptyStr(AProdutos) Then
      Exit;

    Result := fRetornoMsgAbreviacao(LQryDados.FieldByName('FIS_ACESSO').AsString, LQryDados.FieldByName('DEST_CODCLI').AsString, AProdutos);
    Exit;
  End;

  If not fEmptyStr(LQryDados.FieldByName('CTP_GNRCNV').AsString) Then
  Begin
    Result := LQryDados.FieldByName('CTP_GNRCNV').AsString;
    Exit;
  End;
end;

function TGNREModulo.fGetCampoEstadoDaGuia: String;
begin
  Result := ' Y.CID_ESTADO ';

  If not fCfgSis('GNR_UF', varBoolean) Then
    Exit;

  Result := ' IF(IFNULL(AUX_ABF_UF, "") = "", Y.CID_ESTADO, AUX_ABF_UF) ';
end;

procedure TGNREModulo.pPreparaBoleto(AHomologacao, ABoletoPago: Boolean; ACodigoReceita, AChaveDeAcesso: String; ATipoReceita: TTipoReceitaGnre);
Var
  LQryDados: TUniQuery;
  LSQL: String;
  LSQLNot: String;
  LUsaFazenda: Boolean;
  LCodigoDeBarras: String;

  function fRetornaTitulo: String;
  begin
    Result := 'Guia Nacional de Recolhimento de Tributos Estaduais - GNRE';

    If LQryDados.FieldByName('GER_ESTADO').AsString = 'ES' Then
      Result := 'Documento Único de Arrecadação - DUA-ES';

    If LQryDados.FieldByName('GER_ESTADO').AsString = 'SP' Then
      Result := 'Documento de Arrecadação de Receitas Estaduais - DARE-SP';
  end;

begin

  LUsaFazenda := fCfgSis('CADFAZ', varBoolean);

  LQryDados := fCriaQuery(Nil);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT ';
    LSQL := LSQL + ' A.GER_NUMDOC, ';
    LSQL := LSQL + ' A.GER_ESPDOC, ';
    LSQL := LSQL + ' A.GER_CODEMP, ';
    LSQL := LSQL + ' A.GER_CODCLI, ';
    LSQL := LSQL + ' H.AUX_ABF_UF, ';
    LSQL := LSQL + fGetCampoEstadoDaGuia + ' AS GER_ESTADO, ';
    LSQL := LSQL + ' CONCAT(MONTH(A.GER_DTAENT),"/", YEAR(A.GER_DTAENT)) AS MESANO, ';
    LSQL := LSQL + ' CLI_C_G_C_ AS DEST_CGC, ';
    LSQL := LSQL + ' CLI_I_E_S_ AS DEST_IE, ';
    LSQL := LSQL + ' CLI_CODCLI AS DEST_CODCLI,';
    LSQL := LSQL + ' CLI_NOMCLI AS DEST_CLIENTE, ';
    LSQL := LSQL + ' CONCAT(C.CID_NOMCID,"-",C.CID_ESTADO) AS DEST_UF, ';
    LSQL := LSQL + ' D.EMP_NOMEMP AS EMI_RAZAO, ';
    LSQL := LSQL + ' D.EMP_ENDERE AS EMI_ENDER, ';
    LSQL := LSQL + ' D.EMP_ENDNUM AS EMI_NUMERO, ';
    LSQL := LSQL + ' D.EMP_BAIRRO AS EMI_BAIRRO, ';
    LSQL := LSQL + ' D.EMP_C_E_P_ AS EMI_CEP, ';
    LSQL := LSQL + ' D.EMP_I_E_S_ AS EMI_IE, ';
    LSQL := LSQL + ' D.EMP_C_G_C_ AS EMI_CGC, ';
    LSQL := LSQL + ' E.CID_NOMCID AS EMI_CIDADE, ';
    LSQL := LSQL + ' E.CID_ESTADO AS EMI_ESTADO, ';
    LSQL := LSQL + ' D.EMP_FONE01 AS EMI_FONE, ';
    LSQL := LSQL + ' F.FIS_ACESSO, ';
    LSQL := LSQL + ' G.CTP_CODREC, ';
    LSQL := LSQL + ' G.CTP_DTAVEN, ';
    LSQL := LSQL + ' G.CTP_DTAPAG, ';
    LSQL := LSQL + ' G.CTP_VALORI, ';
    LSQL := LSQL + ' G.CTP_VALDUP, ';
    LSQL := LSQL + ' G.CTP_VALPAG, ';
    LSQL := LSQL + ' G.CTP_MULSUJ, ';
    LSQL := LSQL + ' G.CTP_JURSUJ, ';
    LSQL := LSQL + ' G.CTP_LINDIG, ';
    LSQL := LSQL + ' G.CTP_CODBAR, ';
    LSQL := LSQL + ' G.CTP_GNRCTR, ';
    LSQL := LSQL + ' G.CTP_GNRDPG, ';
    LSQL := LSQL + ' G.CTP_GNRCNV, ';
    LSQL := LSQL + ' G.CTP_QRCODE, ';
    LSQL := LSQL + ' A.GER_TOTRET AS VAL_ICMS_ST, ';

    LSQL := LSQL + '   IFNULL((SELECT SUM(ICD_VALFCP) FROM MOVICD ';
    LSQL := LSQL + '   INNER JOIN MOVDET ON MOVICD.ICD_SEQGER = MOVDET.AUTOINCREM ';
    LSQL := LSQL + '   WHERE MOVDET.DET_VALRET = 0 ';
    LSQL := LSQL + '     AND MOVDET.DET_PROEMB <> "S" ';
    LSQL := LSQL + '     AND MOVDET.DET_SEQGER = A.AUTOINCREM),0) AS VAL_FCP, ';

    LSQL := LSQL + '   IFNULL((SELECT SUM(DET_VFCPST) FROM MOVTRI ';
    LSQL := LSQL + '   INNER JOIN MOVDET ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    LSQL := LSQL + '   WHERE MOVDET.DET_VALRET > 0 ';
    LSQL := LSQL + '     AND MOVDET.DET_PROEMB <> "S" ';
    LSQL := LSQL + '     AND MOVDET.DET_SEQGER = A.AUTOINCREM),0) AS VAL_FCP_ST, ';

    LSQL := LSQL + '   IFNULL((SELECT SUM(ICD_VALDES) FROM MOVICD ';
    LSQL := LSQL + '   INNER JOIN MOVDET ON ICD_SEQGER = MOVDET.AUTOINCREM ';
    LSQL := LSQL + '   WHERE MOVDET.DET_PROEMB <> "S" ';
    LSQL := LSQL + '     AND MOVDET.DET_SEQGER = A.AUTOINCREM),0) AS VAL_DIFAL ';

    LSQL := LSQL + 'FROM MOVGER A ';
    LSQL := LSQL + 'INNER JOIN CADCLI B ON B.CLI_CODCLI = A.GER_CODCLI ';
    LSQL := LSQL + 'INNER JOIN CADEMP D ON D.EMP_CODEMP = A.GER_CODEMP ';
    LSQL := LSQL + 'LEFT  JOIN CADCID E ON E.CID_CODCID = D.EMP_CODCID ';
    LSQL := LSQL + 'LEFT  JOIN CADFIS F ON F.FIS_NUMDOC = A.GER_NUMDOC AND ';
    LSQL := LSQL + '                       F.FIS_ESPDOC = A.GER_ESPDOC AND ';
    LSQL := LSQL + '                       F.FIS_FORCLI = A.GER_CODCLI AND ';
    LSQL := LSQL + '                       F.FIS_CODEMP = A.GER_CODEMP ';
    LSQL := LSQL + 'INNER JOIN CADPAG G ON G.CTP_GNRACE = FIS_ACESSO ';
    LSQL := LSQL + 'INNER JOIN AUXMOV H ON H.AUX_SEQGER = A.AUTOINCREM ';

    If LUsaFazenda Then
    Begin
      LSQL := LSQL + 'LEFT  JOIN CADFAZ I ON I.FAZ_CODFAZ = H.AUX_CODFAZ ';
      LSQL := LSQL + 'LEFT  JOIN CADCID C ON C.CID_CODCID = IF(I.FAZ_CODCID IS NULL, B.CLI_CODCID, I.FAZ_CODCID) ';
    End
    Else
      LSQL := LSQL + 'LEFT  JOIN CADCID C ON C.CID_CODCID = B.CLI_CODCID ';

    LSQL := LSQL + 'LEFT JOIN ENTCLI X ON X.AUTOINCREM = H.AUX_ENTGER ';
    LSQL := LSQL + '                  AND X.ETC_CODCLI = B.CLI_CODCLI ';
    LSQL := LSQL + 'LEFT JOIN CADCID Y ON Y.CID_CODCID = IF(IFNULL(CLI_REGFIS, "") = "2", ';
    LSQL := LSQL + '                                       IF((IFNULL(H.AUX_VENPRE, "") = "S") AND (IFNULL(H.AUX_ENTGER, "") = ""), ';
    LSQL := LSQL + '                                         IFNULL(GER_CIDCON, CLI_CODCID), IFNULL(ETC_CIDENT, GER_CIDCON)), IFNULL(GER_CIDCON, CLI_CODCID)) ';

    LSQL := LSQL + 'WHERE GER_TIP_FC  = "C" ';
    LSQL := LSQL + '  AND AUX_GNRREJ <> "S" ';
    LSQL := LSQL + '  AND F.FIS_ACESSO = :ACESSO ';
    LSQL := LSQL + '  AND G.CTP_CODREC = :CODREC ';

    If not ABoletoPago Then
      LSQL := LSQL + '  AND G.CTP_DTAPAG IS NULL ';

    LSQLNot := AnsiReplaceStr(LSQL,'MOVGER','NOTGER');
    LSQLNot := AnsiReplaceStr(LSQLNot,'MOVDET','NOTDET');
    LSQLNot := AnsiReplaceStr(LSQLNot,'AUXMOV','AUXNOT');
    LSQLNot := AnsiReplaceStr(LSQLNot,'MOVICD','NOTICD');
    LSQLNot := AnsiReplaceStr(LSQLNot,'MOVTRI','NOTTRI');
    LSQL := LSQL + ' UNION ALL ' + LSQLNot;

    LQryDados.Close;
    LQryDados.SQL.Clear;
    LQryDados.SQL.Add(LSQL);
    LQryDados.ParamByName('ACESSO').AsString := AChaveDeAcesso;
    LQryDados.ParamByName('CODREC').AsString := ACodigoReceita;
    LQryDados.Open;

    If not LQryDados.isEmpty Then
    Begin
      cdsDadosGuia.Insert;

      cdsDadosGuia.FieldByName('Titulo').AsString                    := fRetornaTitulo;
      cdsDadosGuia.FieldByName('Ambiente').AsString                  := IIF(AHomologacao, '2', '1');
      cdsDadosGuia.FieldByName('UFfavorecido').AsString              := LQryDados.FieldByName('GER_ESTADO').AsString;
      cdsDadosGuia.FieldByName('CodigoReceita').AsString             := LQryDados.FieldByName('CTP_CODREC').AsString;
      cdsDadosGuia.FieldByName('DocumentoEmitente').AsString         := fFormataCpfCgc(LQryDados.FieldByName('EMI_CGC').AsString, fSetaPais);
      cdsDadosGuia.FieldByName('RazaoSocialEmitente').AsString       := LQryDados.FieldByName('EMI_RAZAO').AsString;
      cdsDadosGuia.FieldByName('EnderecoEmitente').AsString          := LQryDados.FieldByName('EMI_ENDER').AsString + IIF(fEmptyStr(LQryDados.FieldByName('EMI_NUMERO').AsString), '',','+LQryDados.FieldByName('EMI_NUMERO').AsString);
      cdsDadosGuia.FieldByName('MunicipioEmitente').AsString         := LQryDados.FieldByName('EMI_CIDADE').AsString;
      cdsDadosGuia.FieldByName('UFemitente').AsString                := LQryDados.FieldByName('EMI_ESTADO').AsString;
      cdsDadosGuia.FieldByName('CepEmitente').AsString               := fFormataCEP(LQryDados.FieldByName('EMI_CEP').AsString);
      cdsDadosGuia.FieldByName('TelefoneEmitente').AsString          := LQryDados.FieldByName('EMI_FONE').AsString;
      cdsDadosGuia.FieldByName('DocumentoDestinatario').AsString     := Trim(fFormataCpfCgc(LQryDados.FieldByName('DEST_CGC').AsString, fSetaPais))+'-'+LQryDados.FieldByName('DEST_CLIENTE').AsString;
      cdsDadosGuia.FieldByName('MunicipioDestinatario').AsString     := LQryDados.FieldByName('DEST_UF').AsString;
      cdsDadosGuia.FieldByName('NumeroDocumentoOrigem').AsString     := LQryDados.FieldByName('GER_NUMDOC').AsString;
      cdsDadosGuia.FieldByName('InformacoesComplementares').AsString := fRetornaInformacoesComplementares(LQryDados);
      cdsDadosGuia.FieldByName('DataVencimento').AsString            := LQryDados.FieldByName('CTP_DTAVEN').AsString;
      cdsDadosGuia.FieldByName('DataLimitePagamento').AsString       := LQryDados.FieldByName('CTP_GNRDPG').AsString;
      cdsDadosGuia.FieldByName('PeriodoReferencia').AsString         := LQryDados.FieldByName('MESANO').AsString;
      cdsDadosGuia.FieldByName('MesAnoReferencia').AsString          := FormatDateTime('mm/yyyy', LQryDados.FieldByName('CTP_DTAVEN').AsDateTime);
      cdsDadosGuia.FieldByName('Valor').AsFloat                      := LQryDados.FieldByName('CTP_VALORI').AsFloat;
      cdsDadosGuia.FieldByName('ValorPrincipal').AsFloat             := IIF(fEmptyStr(LQryDados.FieldByName('CTP_DTAPAG').AsString),
                                                                                      LQryDados.FieldByName('CTP_VALDUP').AsFloat +
                                                                                      LQryDados.FieldByName('CTP_MULSUJ').AsFloat +
                                                                                      LQryDados.FieldByName('CTP_JURSUJ').AsFloat,
                                                                                      LQryDados.FieldByName('CTP_VALPAG').AsFloat);
      cdsDadosGuia.FieldByName('Multa').AsFloat                      := LQryDados.FieldByName('CTP_MULSUJ').AsFloat;
      cdsDadosGuia.FieldByName('Juros').AsFloat                      := LQryDados.FieldByName('CTP_JURSUJ').AsFloat;
      cdsDadosGuia.FieldByName('RepresentacaoNumerica').AsString     := LQryDados.FieldByName('CTP_LINDIG').AsString;
      cdsDadosGuia.FieldByName('CodigoDeBarras').AsString            := LQryDados.FieldByName('CTP_CODBAR').AsString;
      cdsDadosGuia.FieldByName('NumeroControle').AsString            := LQryDados.FieldByName('CTP_GNRCTR').AsString;
      cdsDadosGuia.FieldByName('QrCode').AsString                    := LQryDados.FieldByName('CTP_QRCODE').AsString;
      cdsDadosGuia.FieldByName('CodigoEmpresa').AsString             := LQryDados.FieldByName('GER_CODEMP').AsString;
      cdsDadosGuia.FieldByName('Produto').AsString                   := fRetornaProdutos(LQryDados.FieldByName('GER_NUMDOC').AsString,
                                                                                         LQryDados.FieldByName('GER_ESPDOC').AsString,
                                                                                         LQryDados.FieldByName('GER_CODEMP').AsString,
                                                                                         LQryDados.FieldByName('GER_CODCLI').AsString,
                                                                                         LQryDados.FieldByName('GER_ESTADO').AsString,
                                                                                         ATipoReceita);
      cdsDadosGuia.FieldByName('Convenio').AsString                  := fRetornaConvenio(LQryDados, cdsDadosGuia.FieldByName('Produto').AsString);

      If (fCfgSis('GNRCOV', varString) = 'A') Then
      Begin
        cdsDadosGuia.FieldByName('Convenio').AsString                  := '';
        cdsDadosGuia.FieldByName('InformacoesComplementares').AsString := fRetornaConvenio(LQryDados, cdsDadosGuia.FieldByName('Produto').AsString) +#13+
                                                                          fRetornaInformacoesComplementares(LQryDados);
      End;

      LCodigoDeBarras := LQryDados.FieldByName('CTP_CODBAR').AsString;

      If Length(LCodigoDeBarras) = 48 Then
        LCodigoDeBarras := Copy(LCodigoDeBarras, 1,  11) +
                           Copy(LCodigoDeBarras, 13, 11) +
                           Copy(LCodigoDeBarras, 25, 11) +
                           Copy(LCodigoDeBarras, 37, 11) ;

      cdsDadosGuia.FieldByName('CodigoBarrasBoleto').AsString := LCodigoDeBarras;

      If fCfgSis('GNRBAR', varBoolean) Then
        cdsDadosGuia.FieldByName('CodigoBarrasBoleto').AsString := LQryDados.FieldByName('CTP_LINDIG').AsString;

      cdsDadosGuia.Post;
    End;

  Finally
    FreeAndNil(LQryDados);
  End;
end;

procedure TGNREModulo.pPreparaBoletoApuracao(AHomologacao, ABoletoPago: Boolean; ACodigoReceita, AChaveDeApuracao: String; ATipoReceita: TTipoReceitaGnre);
Var
  LQryDados: TUniQuery;
  LSQL: String;
  LCodigoDeBarras: String;
begin

  LQryDados := fCriaQuery(Nil);

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT ';
    LSQL := LSQL + '  EMP_NOMEMP AS EMI_RAZAO, ';
    LSQL := LSQL + '  EMP_ENDERE AS EMI_ENDER, ';
    LSQL := LSQL + '  EMP_ENDNUM AS EMI_NUMERO, ';
    LSQL := LSQL + '  EMP_BAIRRO AS EMI_BAIRRO, ';
    LSQL := LSQL + '  EMP_C_E_P_ AS EMI_CEP, ';
    LSQL := LSQL + '  EMP_I_E_S_ AS EMI_IE, ';
    LSQL := LSQL + '  EMP_C_G_C_ AS EMI_CGC, ';
    LSQL := LSQL + '  CID_NOMCID AS EMI_CIDADE, ';
    LSQL := LSQL + '  CID_ESTADO AS EMI_ESTADO, ';
    LSQL := LSQL + '  EMP_FONE01 AS EMI_FONE, ';

    LSQL := LSQL + '  APU_ESTADO, ';
    LSQL := LSQL + '  APU_MESGNR, ';
    LSQL := LSQL + '  APU_ANOGNR, ';

    LSQL := LSQL + '  CTP_CODREC, ';
    LSQL := LSQL + '  CTP_DTAVEN, ';
    LSQL := LSQL + '  CTP_DTAPAG, ';
    LSQL := LSQL + '  CTP_VALORI, ';
    LSQL := LSQL + '  CTP_VALDUP, ';
    LSQL := LSQL + '  CTP_VALPAG, ';
    LSQL := LSQL + '  CTP_MULSUJ, ';
    LSQL := LSQL + '  CTP_JURSUJ, ';
    LSQL := LSQL + '  CTP_LINDIG, ';
    LSQL := LSQL + '  CTP_CODBAR, ';
    LSQL := LSQL + '  CTP_GNRCTR, ';
    LSQL := LSQL + '  CTP_GNRDPG, ';
    LSQL := LSQL + '  CTP_QRCODE, ';
    LSQL := LSQL + '  CTP_GNRCNV ';
    LSQL := LSQL + 'FROM APUGNR ';
    LSQL := LSQL + 'INNER JOIN CADPAG ON CADPAG.CTP_APUGNR = APUGNR.AUTOINCREM ';
    LSQL := LSQL + 'INNER JOIN CADEMP ON CADEMP.EMP_CODEMP = APUGNR.APU_CODEMP ';
    LSQL := LSQL + 'LEFT  JOIN CADCID ON CADCID.CID_CODCID = CADEMP.EMP_CODCID ';
    LSQL := LSQL + 'WHERE TRUE ';
    LSQL := LSQL + '  AND CTP_APUGNR = :APUGNR ';
    LSQL := LSQL + '  AND CTP_CODREC = :CODREC ';

    LQryDados.Close;
    LQryDados.SQL.Clear;
    LQryDados.SQL.Add(LSQL);
    LQryDados.ParamByName('APUGNR').AsString := AChaveDeApuracao;
    LQryDados.ParamByName('CODREC').AsString := ACodigoReceita;
    LQryDados.Open;

    If not LQryDados.isEmpty Then
    Begin
      cdsDadosGuia.Insert;
      cdsDadosGuia.FieldByName('Titulo').AsString                    := 'Guia Nacional de Recolhimento de Tributos Estaduais - GNRE';
      cdsDadosGuia.FieldByName('Ambiente').AsString                  := IIF(AHomologacao, '2', '1');
      cdsDadosGuia.FieldByName('UFfavorecido').AsString              := LQryDados.FieldByName('APU_ESTADO').AsString;
      cdsDadosGuia.FieldByName('CodigoReceita').AsString             := LQryDados.FieldByName('CTP_CODREC').AsString;
      cdsDadosGuia.FieldByName('DocumentoEmitente').AsString         := fFormataCpfCgc(LQryDados.FieldByName('EMI_CGC').AsString, fSetaPais);
      cdsDadosGuia.FieldByName('RazaoSocialEmitente').AsString       := LQryDados.FieldByName('EMI_RAZAO').AsString;
      cdsDadosGuia.FieldByName('EnderecoEmitente').AsString          := LQryDados.FieldByName('EMI_ENDER').AsString + IIF(fEmptyStr(LQryDados.FieldByName('EMI_NUMERO').AsString), '',','+LQryDados.FieldByName('EMI_NUMERO').AsString);
      cdsDadosGuia.FieldByName('MunicipioEmitente').AsString         := LQryDados.FieldByName('EMI_CIDADE').AsString;
      cdsDadosGuia.FieldByName('UFemitente').AsString                := LQryDados.FieldByName('EMI_ESTADO').AsString;
      cdsDadosGuia.FieldByName('CepEmitente').AsString               := fFormataCEP(LQryDados.FieldByName('EMI_CEP').AsString);
      cdsDadosGuia.FieldByName('TelefoneEmitente').AsString          := LQryDados.FieldByName('EMI_FONE').AsString;
      cdsDadosGuia.FieldByName('DataVencimento').AsString            := LQryDados.FieldByName('CTP_DTAVEN').AsString;
      cdsDadosGuia.FieldByName('DataLimitePagamento').AsString       := LQryDados.FieldByName('CTP_GNRDPG').AsString;
      cdsDadosGuia.FieldByName('PeriodoReferencia').AsString         := Copy(LQryDados.FieldByName('APU_MESGNR').AsString, 1, 3)+'/'+LQryDados.FieldByName('APU_ANOGNR').AsString;
      cdsDadosGuia.FieldByName('MesAnoReferencia').AsString          := FormatDateTime('mm/yyyy', LQryDados.FieldByName('CTP_DTAVEN').AsDateTime);
      cdsDadosGuia.FieldByName('Valor').AsFloat                      := LQryDados.FieldByName('CTP_VALORI').AsFloat;
      cdsDadosGuia.FieldByName('ValorPrincipal').AsFloat             := IIF(fEmptyStr(LQryDados.FieldByName('CTP_DTAPAG').AsString),
                                                                                      LQryDados.FieldByName('CTP_VALDUP').AsFloat +
                                                                                      LQryDados.FieldByName('CTP_MULSUJ').AsFloat +
                                                                                      LQryDados.FieldByName('CTP_JURSUJ').AsFloat,
                                                                                      LQryDados.FieldByName('CTP_VALPAG').AsFloat);
      cdsDadosGuia.FieldByName('Multa').AsFloat                      := LQryDados.FieldByName('CTP_MULSUJ').AsFloat;
      cdsDadosGuia.FieldByName('Juros').AsFloat                      := LQryDados.FieldByName('CTP_JURSUJ').AsFloat;
      cdsDadosGuia.FieldByName('RepresentacaoNumerica').AsString     := LQryDados.FieldByName('CTP_LINDIG').AsString;
      cdsDadosGuia.FieldByName('CodigoDeBarras').AsString            := LQryDados.FieldByName('CTP_CODBAR').AsString;
      cdsDadosGuia.FieldByName('NumeroControle').AsString            := LQryDados.FieldByName('CTP_GNRCTR').AsString;
      cdsDadosGuia.FieldByName('QrCode').AsString                    := LQryDados.FieldByName('CTP_QRCODE').AsString;
      cdsDadosGuia.FieldByName('InformacoesComplementares').AsString := 'Guia Nacional de Recolhimento de Tributos Estaduais por Apuração';

      LCodigoDeBarras := LQryDados.FieldByName('CTP_CODBAR').AsString;

      If Length(LCodigoDeBarras) = 48 Then
        LCodigoDeBarras := Copy(LCodigoDeBarras, 1,  11) +
                           Copy(LCodigoDeBarras, 13, 11) +
                           Copy(LCodigoDeBarras, 25, 11) +
                           Copy(LCodigoDeBarras, 37, 11) ;

      cdsDadosGuia.FieldByName('CodigoBarrasBoleto').AsString := LCodigoDeBarras;

      If fCfgSis('GNRBAR', varBoolean) Then
        cdsDadosGuia.FieldByName('CodigoBarrasBoleto').AsString := LQryDados.FieldByName('CTP_LINDIG').AsString;

      cdsDadosGuia.Post;
    End;

  Finally
    FreeAndNil(LQryDados);
  End;
end;

function TGNREModulo.fExibirSelecaoImpressoras(AImpressora: String): Boolean;
begin
  Result := True;

  If fEmptyStr(AImpressora) Then
    Exit;

  If VerImpressoraOnline(AImpressora) <> 0 Then
    Exit;

  Result := False;
end;

procedure TGNREModulo.pImpressora(AFormulario, AImpressora: String);
Var
  LQry: TUniQuery;
  LTipImp: String;
begin
  If fEmptyStr(AImpressora) Or (VerImpressoraONLINE(AImpressora) <> 0) Then
  Begin
    LQry := fCriaQuery(nil);
    Try
      pCarregaConfImpr(LQry, AFormulario);
      AImpressora := LQry.FieldByName('REL_NOMFIL').AsString;
      If Not fPreImpressao(LQry, AImpressora, LTipImp, False) Then
        Exit;
    Finally
      FreeAndNil(LQry);
    End;
  End;

  frxReport.PrintOptions.Printer := AImpressora;
  frxReport.SelectPrinter;

  frxReport.PrintOptions.ShowDialog := fExibirSelecaoImpressoras(AImpressora);

  If frxReport.PrepareReport Then
    pPrintReport(AFormulario,'GNRE - Guia Nacional de Recolhimento de Tributos Estaduais',
      AImpressora, frxReport);
end;

procedure TGNREModulo.pPDF(AAbrir: Boolean = True; AArquivo: String = '');
begin
  frxPDFExport.Author     := 'Citel Software';
  frxPDFExport.Subject    := 'GNRE Exportação PDF';

  frxPDFExport.HideToolbar  := True;
  frxPDFExport.HideMenubar  := True;
  frxPDFExport.HideWindowUI := True;

  frxPDFExport.ShowDialog      := True;
  frxPDFExport.OpenAfterExport := True;

  If not AAbrir Then
  Begin
    frxPDFExport.FileName        := AArquivo;
    frxPDFExport.ShowDialog      := False;
    frxPDFExport.OpenAfterExport := False;
  End;

  If frxReport.PrepareReport Then
    frxReport.Export(frxPDFExport);
end;

procedure TGNREModulo.pEmail;
Var
  LTexto: String;
  LArquivo: String;
  LArrArquivos, LArrDestinatarios : TStringArray;
begin
  Try
    LTexto  := '';

    LArquivo := ExtractFilePath(Application.ExeName) + 'GNRE.pdf';

    DeleteFile(LArquivo);

    pPDF(False, LArquivo);

    pCriarArrayAnexosEDestinatarios(LArquivo, '', LArrDestinatarios, LArrArquivos);

    TEnvioEmail.EnviarEmail(nil,
                            strLoginUsuarioLogado,
                            'GNRE - Relação de Guias',
                            LArrDestinatarios,
                            [],
                            [],
                            TEnvioEmail.ContruirArrayMensagem(LTexto),
                            LArrArquivos,
                            True);
  Finally
    DeleteFile(LArquivo);
  End;
end;

procedure TGNREModulo.pGeraExportacaoAutomaticaDeGuiasPDF;
var
  LPathPDF: String;
  LNomePDF: String;
  LArquivo: String;
begin
  Try
    If not fEmptyStr(cdsDadosGuia.FieldByName('NumeroDocumentoOrigem').AsString) Then
    Begin
      LPathPDF := fCfgSis('GNRPAT', varString);
      LNomePDF := cdsDadosGuia.FieldByName('NumeroDocumentoOrigem').AsString + '-' + cdsDadosGuia.FieldByName('CodigoEmpresa').AsString;
      LArquivo := LPathPDF + '\' + LNomePDF + '.pdf';

      DeleteFile(LArquivo);
      pPDF(False, LArquivo);
    End;
  Finally
    cdsDadosGuia.EmptyDataSet;
  End;
end;

procedure TGNREModulo.pImprimir(AFormulario, AImpressora: String);
var
  LOpcoes: Integer;
begin
  If not cdsDadosGuia.IsEmpty Then
  Begin
    LOpcoes := fMensagem('', 'Escolha as opções abaixo:', ['&Impressora', '&PDF', '&E-Mail'], 1, False, 1, 0, False, 0, False, False, True);

    Case LOpcoes Of
      1: pImpressora(AFormulario,AImpressora);
      2: pPDF;
      3: pEmail;
    End;
  End;
end;

end.
