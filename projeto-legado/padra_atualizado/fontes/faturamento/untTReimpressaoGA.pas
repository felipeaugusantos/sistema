unit untTReimpressaoGA;

interface

uses
  untReimpressao, DB, Uni, UniClientDataSet;

Type
  {$SCOPEDENUMS ON}
  TReimpressaoDocGarantia = (trRecebimentoCliente, trRetornoFornecedor);
  {$SCOPEDENUMS OFF}


Type
  TReimpressaoGA = class(TReimpressao)
  private
    FDocGarantia: TReimpressaoDocGarantia;
    function fGetSql: String;
    function fSqlDocumentoGA: String;
    function fSqlDocumentoGR: String;
    procedure pCarregarDocumento;

  public
      Constructor Create(strNumDoc: String;
                         dtaDtaIni,
                         dtaDtaFin: TDateTime;
                         strCodCli,
                         strCodEmp: String;
                         pDocGarantia: TReimpressaoDocGarantia);reintroduce;

      procedure pReimprimeDocumento(blnImpNFDireto: Boolean = False;
                                    blnQtdOri: Boolean = False;
                                    blnDocCan: Boolean = False;
                                    blnVerCfg: Boolean = True;
                                    blnImpPed: Boolean = False;
                                    opcEdtFst: TOpcEditorFast = opcPergunta;
                                    blnEditor: Boolean = False;
                                    tipLibPed: TLibPed = libAmbos;
                                    blnF9OrF10: Boolean = False;
                                    blnGerPdf: Boolean = False;
                                    strPasPdf: String = '';
                                    blnVisPdf: Boolean = False;
                                    blnOpcFat: Boolean = False); override;


  end;

implementation

uses
  untTypesSistema, untFuncoesSimples, untFuncoesGenerica, untLiberacao,
  System.SysUtils, System.StrUtils, untConstantes, untMovGer, untFatImpressao;

{ TReimpressaoGA }

constructor TReimpressaoGA.Create(strNumDoc: String; dtaDtaIni,
  dtaDtaFin: TDateTime; strCodCli, strCodEmp: String; pDocGarantia: TReimpressaoDocGarantia);

begin
  FDocGarantia := pDocGarantia;
  FPais := fSetaPais;

  qryCfgRel := fCriaQuery;

  objLiberacao := TLiberacao.Create;

  blnExpedicao := False;
  blnSeparacaoDireto := False;
  blnTelaReimpressao := False;

  FFiltNE := True;
  FNumDoc := strNumDoc;
  FEspDoc := EmptyStr;
  FDtaIni := dtaDtaIni;
  FDtaFin := dtaDtaFin;
  FCodCli := strCodCli;
  FCodEmp := strCodEmp;
  FCodVen := EmptyStr;
  FRecCliGar := False;

  FPergSep := True;
  FFatVenda := False;

  FAux001 := fCriaQuery;
  FAux002 := fCriaQuery;

  blnPreRomaneio := False;
  blnTemLay := False;

  pCarregarDocumento;
end;

procedure TReimpressaoGA.pCarregarDocumento;
  Var
    strSql: String;
begin
  objDocumentos := TDocumentosReimpressao.Create(Nil);

  strSQL := fGetSql;
  objDocumentos.strSqlDocs := strSQL;

  If Not fEmptyStr(FNumDoc) then
    objDocumentos.pAddFiltro('NUMDOC', FNumDoc);

    If Not fEmptyStr(FCodEmp) Then
      objDocumentos.pAddFiltro('CODEMP', FCodEmp);

  If(Not fEmptyStr(FCodCli)) then
    objDocumentos.pAddFiltro('CODCLI', FCodCli);

  objDocumentos.pAddFiltro('DTAINI', FDtaIni);
  objDocumentos.pAddFiltro('DTAFIN', FDtaFin);

  objDocumentos.pCarregarDocumentos;

  objDocumentos.cdsDocumentos.IndexFieldNames := 'DTAENT;NUMDOC;ESPDOC';

  (objDocumentos.cdsDocumentos.FieldByName('VLRCON') As TFloatField).DisplayFormat := '#,##0.00';

  blnReimpressaoDaSeparacaoPedido := True;
end;

procedure TReimpressaoGA.pReimprimeDocumento(blnImpNFDireto, blnQtdOri,
  blnDocCan, blnVerCfg, blnImpPed: Boolean; opcEdtFst: TOpcEditorFast;
  blnEditor: Boolean; tipLibPed: TLibPed; blnF9OrF10, blnGerPdf: Boolean;
  strPasPdf: String; blnVisPdf: Boolean; blnOpcFat: Boolean);
  Var
    strTabela: String;
    strOpcDoc: String;
    blnImpTck: Boolean;
    blnAjMl: Boolean;
    strNomeArquivo: String;
    intQtdV: Integer;
    blnReimpressaoGR: Boolean;
begin
  blnReimpressaoGR := FDocGarantia =  TReimpressaoDocGarantia.trRetornoFornecedor;

  With objDocumentos.cdsDocumentos Do
  Begin
    blnAjMl := False;

    If Assigned(objDocumentos.cdsDocumentos.FindField('ESAJML')) Then
      If objDocumentos.cdsDocumentos.FieldByName('ESAJML').AsString =  'AJML' Then
        blnAjMl := True;

    If (IsEmpty) Then
      Exit;

    strTabela := fGetNomeTabela;

    untFatImpressao.blnSimples := False;

    If (opcEdtFst = opcPergunta) Then
    Begin
      If (tipLibPed <> libSeparacao) Then
      Begin
        If fMensagem('','Saída',['&Video','&Imprimir']) = 1 Then
          strTipImp := 'V'
        Else
          strTipImp := 'I';
      End;
    End
    Else
    Begin

      Case opcEdtFst Of
        opcVideo: strTipImp := 'V';
        opcEmail: strTipImp := 'P';
      End;

    End;

    {**************************************************************}
    {* ANTERIORMENTE ESTA PASSANDO SOMENTE ATÉ O OITAVO PARAMETRO *}
    {* POREM NA REIMPRESSAO DE IF COM IMPTCK ELE NÃO CORREGAVA    *}
    {* PARA REIMPRESSAO, SOMENTE PARA IMPRESSÃO.ENTAO INCLUI ESSE *}
    {* PARAMETRO PARA REIMPRESSAO TAMBÉM                          *}
    {***********************************************************AC*}
    If fCfgSis('IMPTCK', varBoolean) Then
      blnImpTck := True
    Else
      blnImpTck := False;

    intQtdV := IIf(FieldByName('ESPDOC').AsString = 'PD', fCfgSis('VIA_PD', varInteger), 1);
    If intQtdV < 1 Then
      intQtdV := 1;

    If (tipLibPed <> libSeparacao) Then
      pImprimeFatImpAux(strTabela,
                       IIf(blnAjMl, objDocumentos.cdsDocumentos.FieldByName('NUMDOC').AsString,
                           IIF(SameText(FieldByName('ESPDOC').AsString, 'ML'), Copy(FieldByName('NUMFAT').AsString, 1, fTamDocCadRec()), FieldByName('NUMDOC').AsString)),
                        FieldByName('ESPDOC').AsString,
                        FieldByName('CODEMP').AsString,
                        FieldByName('CODCLI').AsString,
                        FieldByName('TIP_FC').AsString,
                        FieldByName('ORIDOC').AsString,
                        True,
                        strNomeArquivo,
                        False,
                        blnEditor,
                        blnImprimiuEditor,
                        blnImprimiuAmbien,
                        strArqPDF,
                        blnTemLay,
                        strTipImp,
                        intQtdV,
                        impComPrecoGeral,
                        0,
                        False,
                        blnImpTck,
                        True,
                        blnQtdOri,
                        '',
                        '',
                        blnDocCan,
                        blnExpedicao,
                        False,
                        False,
                        False,
                        False,
                        False,
                        opcTodos,
                        False,
                        False,
                        False,
                        False,
                        False,
                        '',
                        '',
                        Nil,
                        False,
                        '',
                        '',
                        '',
                        False,
                        opcNaoAgrupa,
                        False,
                        '',
                        '',
                        blnF9OrF10,
                        False,
                        blnGerPdf,
                        strPasPdf,
                        blnVisPdf,
                        False,
                        False,
                        False,
                        False,
                        False,
                        '',
                        '',
                        '',
                        False,
                        blnAjMl,
                        '',
                        0,
                        0,
                        False,
                        '',
                        False,
                        False,
                        False,
                        '',
                        False,
                        False,
                        False,
                        blnReimpressaoGR);
    strOpcDoc := '';
  End;

  If Self.blnImprimiuAmbien Then
    Self.strArqPDF := strNomeArquivo;
end;

function TReimpressaoGA.fGetSql: String;
begin
  case FDocGarantia of
    TReimpressaoDocGarantia.trRecebimentoCliente: Result := fSqlDocumentoGA;
    TReimpressaoDocGarantia.trRetornoFornecedor: Result := fSqlDocumentoGR;
  end;
end;



function TReimpressaoGA.fSqlDocumentoGA: String;
begin
  {$REGION 'SQL/SELECT'}
  {**************************************}
  {* SELECT NAS TABELAS MOVGAG E MOVGAD *}
  {***********************************RL*}
  Result := ' ';
  Result := Result + 'SELECT SQL_NO_CACHE DISTINCT     ';
  Result := Result + '  " " AS SERIE_, ';
  Result := Result + '  " " AS NUMFAT, ';
  Result := Result + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';
  Result := Result + '  " " AS DOCCAN, ';
  Result := Result + '  " " AS MOTDEL, ';
  Result := Result + '  " " AS DTADEL, ';
  Result := Result + '  " " AS OPEDEL, ';
  Result := Result + '  DET_DTAENT AS DTAENT, ';
  Result := Result + '  GAG_NUMENT AS NUMDOC, ';
  Result := Result + '  "GA" AS ESPDOC, ';
  Result := Result + '  " " AS ESAJML, ';
  Result := Result + '  DET_CODEMP AS CODEMP, ';
  Result := Result + '  CAST(GROUP_CONCAT(DISTINCT DET_CODVEN) AS CHAR(64)) AS CODVEN, ';
  Result := Result + '  DET_CODCLI AS CODCLI, ';
  Result := Result + '  0          AS VPAR01, ';
  Result := Result + '  0          AS VPAR02, ';
  Result := Result + '  0          AS VPAR03, ';
  Result := Result + '  0          AS VPAR04, ';
  Result := Result + '  0          AS VPAR05, ';
  Result := Result + '  0          AS VPAR06, ';
  Result := Result + '  0          AS VPAR07, ';
  Result := Result + '  0          AS VPAR08, ';
  Result := Result + '  0          AS VPAR09, ';
  Result := Result + '  0          AS VPAR10, ';
  Result := Result + '  0          AS VPAR11, ';
  Result := Result + '  0          AS VPAR12, ';
  Result := Result + '  CLI_CODREG AS CODREG, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  CLI_NOMCLI AS CLIORI, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CLI_I_M_P_ AS I_M_P_, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CLI_PRORUR AS PRORUR, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CLI_MICEMP AS MICEMP, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  CLI_ORGPUB AS ORGPUB, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CLI_DESPIS AS DESPIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CLI_ZONFRA AS ZONFRA, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CLI_DESZON AS DESZON, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CLI_PERMUT AS PERMUT, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  CLI_SUFRAM AS CODZFM, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CLI_EXPIND AS EXPIND, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  CLI_CONSUM AS CONSUM, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CLI_TABPRE AS TABPRE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODDIG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODREP, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CONPAG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODCND, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODFPG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CLAFIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTPRO, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTCUS, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS DESESP, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS PORDES, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BASRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ALQRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS RET_SP, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BARTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  0 AS VLRTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  0 AS BASICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ALQICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BASIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ALQIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS CODTRA, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TIPFRE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTFRE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS PESBRU, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS PESLIQ, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS VOLUME, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS NCONHE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BASSIM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MARCA_, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS ESPECI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MEN001, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MEN002, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MEN003, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  " " AS MEN004, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  " " AS MEN005, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  " " AS CLAFI2, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CLAFI3, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS NATOPE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  G.AUTOINCREM AS AUTINC, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CAST(IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_CGCCPF, CLI_CGCCPF) AS UNSIGNED) AS CGCCPF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_NOMCON, CLI_NOMCLI) AS CLINOM, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_ENDCON, CLI_ENDERE) AS ENDERE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDNUM) AS ENDNUM, ';         // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%","", CLI_ENDCOM) AS ENDCOM, ';         // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_BAICON, CLI_BAIRRO) AS BAIRRO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_CEPCON, CLI_C_E_P_) AS C_E_P_, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_CIDCON, CLI_CODCID) AS CODCID, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_TELCON, CLI_FONE01) AS FONE01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_R_GCON, CLI_NUMR_G) AS NUM_RG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_CGCCON, CLI_C_G_C_) AS C_G_C_, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_IESCON, CLI_I_E_S_) AS I_E_S_, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR CLI_NOMCLI LIKE "%BALCAO%" OR CLI_NOMCLI LIKE "%BALCÃO%" OR CLI_NOMCLI LIKE "%SEGURADORA%",GAG_NOMCON, CONCAT(GAG_CODCLI,"-",CLI_NOMCLI)) AS NOMCLI, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CLI_DIFERI AS DIFERI, ';
  Result := Result + '  CLI_DIF_ST AS DIF_ST, ';
  Result := Result + '  CLI_SITP_C AS SITP_C, ';
  Result := Result + '  CLI_MENP_C AS MENP_C, ';
  Result := Result + '  CLI_REDICM AS REDICM, ';
  Result := Result + '  CLI_DESOPE AS DESOPE, ';
  Result := Result + '  CLI_COBISS AS COBISS, ';
  Result := Result + '  CLI_CODOBR AS CODOBR, ';
  Result := Result + '  CLI_CODART AS CODART, ';
  Result := Result + '  CLI_CODCNO AS CODCNO, ';
  Result := Result + '  CLI_INSIMO AS INSIMO, ';
  Result := Result + '  CLI_CODCIB AS CODCIB, ';
  Result := Result + '  CLI_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  CLI_DIF_ST AS DIF_ST, ';
  Result := Result + '  CLI_SITP_C AS SITP_C, ';
  Result := Result + '  CLI_MENP_C AS MENP_C, ';
  Result := Result + '  CLI_REDICM AS REDICM, ';
  Result := Result + '  CLI_DESOPE AS DESOPE, ';
  Result := Result + '  CLI_COBISS AS COBISS, ';
  Result := Result + '  CLI_CODOBR AS CODOBR, ';
  Result := Result + '  CLI_CODART AS CODART, ';
  Result := Result + '  CLI_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA

  Result := Result + '  " " AS CODS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  Result := Result + '  " " AS DESS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  Result := Result + '  0   AS VALS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  Result := Result + '  0   AS PRAENT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS TOTSER, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PERISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CAST(GAG_DTAENT AS TIME) AS HORENT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS DESACE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQPIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALPIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQCOF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALCOF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQCSL, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALCSL, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS RETPCO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS RETIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS RETISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS SEGSOC, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CDESPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS SITIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS ENQIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS MENIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS ORPURD, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CALICM, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " "   AS NOTRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRFRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PISRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COFRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSLRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS SERRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " "   AS NORESE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PIPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PIPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PISERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PISEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VLSGSO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PESGSO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0000000.00 AS DUPREC, '; // USADO PARA REIMPRESSÃO DE NOTA  DE GARANTIA
  Result := Result + '  0 AS BASORG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ICMORG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  "N" AS ENTFAT, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS NOTESP, ';
  Result := Result + '  "MOVGAG     "  AS TABELA, ';
  Result := Result + '  " " AS TIP_FC, ';
  Result := Result + '  " " AS ORIDOC, ';
  Result := Result + '  SUM(DET_VLRCON) AS VLRCON, ';
  Result := Result + '  " " AS DOCORI, ';
  Result := Result + '  "N" AS DOCFOR,  ';
  Result := Result + '  " " AS NROCEI,  ';
  Result := Result + '  "" AS ORDPRO ';
  {$ENDREGION 'SQL/SELECT'}
  Result := Result + 'FROM ';
  Result := Result + ' MOVGAG G ';
  Result := Result + ' JOIN MOVGAD D ON D.GAD_SEQGAG = G.AUTOINCREM ';
  Result := Result + ' JOIN MOVGRC A ON A.GRC_SEQGAD = D.AUTOINCREM AND A.GRC_OPCDOC IN ("GA","NE","OE","DV") ';
  Result := Result + ' JOIN MOVDET M ON M.AUTOINCREM = A.GRC_SEQDET ';
  Result := Result + ' LEFT JOIN MOVTRI T ON T.DET_SEQGAD = D.AUTOINCREM ';

  Result := Result + ' INNER JOIN CADCLI C ON G.GAG_CODCLI = C.CLI_CODCLI  ';

  Result := Result + 'WHERE TRUE ';

  If (Not fEmptyStr(FNumDoc)) Then
    Result := Result + ' AND GAG_NUMENT = :NUMDOC ';

  If Not fEmptyStr(FCodCli) then
    Result := Result + ' AND GAG_CODCLI = :CODCLI ';

  If Not fEmptyStr(FCodEmp) Then
    Result := Result + ' AND GAG_CODEMP IN (:CODEMP) '
  Else
    Result := Result + ' AND ' + fGetSQLInEmpresasAcesso('GAG_CODEMP') + ' ';

  Result := Result + ' AND (CAST(GAG_DTAENT AS DATE) >= :DTAINI AND CAST(GAG_DTAENT AS DATE) <= :DTAFIN) ';

  Result := Result + ' GROUP BY NUMDOC, ESPDOC, CODEMP ';
end;

function TReimpressaoGA.fSqlDocumentoGR: String;
begin
  {$REGION 'SQL/SELECT'}
  {**************************************}
  {* SELECT NAS TABELAS MOVGAG E MOVGAD *}
  {***********************************RL*}
  Result := ' ';
  Result := Result + 'SELECT SQL_NO_CACHE DISTINCT     ';
  Result := Result + '  " " AS SERIE_, ';
  Result := Result + '  " " AS NUMFAT, ';
  Result := Result + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';
  Result := Result + '  " " AS DOCCAN, ';
  Result := Result + '  " " AS MOTDEL, ';
  Result := Result + '  " " AS DTADEL, ';
  Result := Result + '  " " AS OPEDEL, ';
  Result := Result + '  DET_DTAENT AS DTAENT, ';
  Result := Result + '  DET_NUMDOC AS NUMDOC, ';
  Result := Result + '  DET_ESPDOC AS ESPDOC, ';
  Result := Result + '  " " AS ESAJML, ';
  Result := Result + '  DET_CODEMP AS CODEMP, ';
  Result := Result + '  CAST(GROUP_CONCAT(DISTINCT DET_CODVEN) AS CHAR(64)) AS CODVEN, ';
  Result := Result + '  DET_CODFOR AS CODCLI, ';
  Result := Result + '  0          AS VPAR01, ';
  Result := Result + '  0          AS VPAR02, ';
  Result := Result + '  0          AS VPAR03, ';
  Result := Result + '  0          AS VPAR04, ';
  Result := Result + '  0          AS VPAR05, ';
  Result := Result + '  0          AS VPAR06, ';
  Result := Result + '  0          AS VPAR07, ';
  Result := Result + '  0          AS VPAR08, ';
  Result := Result + '  0          AS VPAR09, ';
  Result := Result + '  0          AS VPAR10, ';
  Result := Result + '  0          AS VPAR11, ';
  Result := Result + '  0          AS VPAR12, ';

  Result := Result + '  " "        AS CODREG, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_NOMFOR AS CLIORI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  " " AS I_M_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "" AS PRORUR, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "" AS MICEMP, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS ORGPUB, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS DESPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS ZONFRA, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS DESZON, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS PERMUT, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  " " AS CODZFM, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  CAST(" " AS CHAR(1)) AS EXPIND, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "S" AS CONSUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "1" AS TABPRE, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  " " AS CODDIG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODREP, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CONPAG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODCND, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODFPG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CLAFIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTPRO, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTCUS, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS DESESP, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS PORDES, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BASRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ALQRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS RET_SP, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BARTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  0 AS VLRTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  0 AS BASICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ALQICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BASIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ALQIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS CODTRA, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TIPFRE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTFRE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS PESBRU, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS PESLIQ, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS VOLUME, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS NCONHE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BASSIM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MARCA_, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS ESPECI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MEN001, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MEN002, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MEN003, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  " " AS MEN004, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  " " AS MEN005, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  " " AS CLAFI2, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CLAFI3, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS NATOPE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA

  Result := Result + '  FOR_NOMFOR AS CLINOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_ENDERE AS ENDERE, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_ENDNUM AS ENDNUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_ENDCOM AS ENDCOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_BAIRRO AS BAIRRO, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_C_E_P_ AS C_E_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_CODCID AS CODCID, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_FONE01 AS FONE01, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  " " AS NUM_RG, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_C_G_C_ AS C_G_C_, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_I_E_S_ AS I_E_S_, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  CONCAT(FOR_CODFOR,"-",FOR_NOMFOR) AS NOMCLI, ';
  Result := Result + '  "N"        AS DIFERI, ';
  Result := Result + '  "N"        AS DIF_ST, ';
  Result := Result + '  "T"        AS SITP_C, ';
  Result := Result + '  ""         AS MENP_C, ';
  Result := Result + '  0.00       AS REDICM, ';
  Result := Result + '  0.00       AS DESOPE, ';
  Result := Result + '  ""         AS COBISS, ';
  Result := Result + '  ""         AS CODOBR, ';
  Result := Result + '  ""         AS CODART, ';
  Result := Result + '  ""         AS CODCNO, ';
  Result := Result + '  FOR_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA

  Result := Result + '  G.AUTOINCREM AS AUTINC, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA


  Result := Result + '  " " AS CODS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  Result := Result + '  " " AS DESS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  Result := Result + '  0   AS VALS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  Result := Result + '  0   AS PRAENT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS TOTSER, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PERISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CAST(GAG_DTAENT AS TIME) AS HORENT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS DESACE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQPIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALPIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQCOF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALCOF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQCSL, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALCSL, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS RETPCO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS RETIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS RETISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS SEGSOC, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CDESPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS SITIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS ENQIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS MENIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS ORPURD, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CALICM, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " "   AS NOTRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRFRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PISRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COFRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSLRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS SERRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " "   AS NORESE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PIPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PIPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PISERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PISEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VLSGSO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PESGSO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0000000.00 AS DUPREC, '; // USADO PARA REIMPRESSÃO DE NOTA  DE GARANTIA
  Result := Result + '  0 AS BASORG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ICMORG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  "N" AS ENTFAT, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS NOTESP, ';
  Result := Result + '  "MOVGAG     "  AS TABELA, ';
  Result := Result + '  " " AS TIP_FC, ';
  Result := Result + '  " " AS ORIDOC, ';
  Result := Result + '  SUM(DET_VLRCON) AS VLRCON, ';
  Result := Result + '  " " AS DOCORI, ';
  Result := Result + '  "N" AS DOCFOR,  ';
  Result := Result + '  " " AS NROCEI,  ';
  Result := Result + '  "" AS ORDPRO ';
  {$ENDREGION 'SQL/SELECT'}
  Result := Result + 'FROM ';
  Result := Result + ' MOVGAG G ';
  Result := Result + ' JOIN MOVGAD D ON D.GAD_SEQGAG = G.AUTOINCREM ';
  Result := Result + ' JOIN MOVGAU U ON U.GAU_SEQGAD = D.AUTOINCREM ';
  Result := Result + ' JOIN MOVDET M ON M.AUTOINCREM = U.GAU_SEQDET ';

  Result := Result + ' LEFT JOIN MOVTRI T ON T.DET_SEQGER = M.AUTOINCREM ';

  Result := Result + ' INNER JOIN CADFOR F ON F.FOR_CODFOR = M.DET_CODFOR ';

  Result := Result + 'WHERE TRUE ';

  If (Not fEmptyStr(FNumDoc)) Then
    Result := Result + ' AND GAG_NUMENT = :NUMDOC ';

  If Not fEmptyStr(FCodCli) then
    Result := Result + ' AND GAG_CODCLI = :CODCLI ';

  If Not fEmptyStr(FCodEmp) Then
    Result := Result + ' AND GAG_CODEMP IN (:CODEMP) '
  Else
    Result := Result + ' AND ' + fGetSQLInEmpresasAcesso('GAG_CODEMP') + ' ';

  Result := Result + ' AND (CAST(GAG_DTAENT AS DATE) >= :DTAINI AND CAST(GAG_DTAENT AS DATE) <= :DTAFIN) ';

  Result := Result + ' GROUP BY NUMDOC, ESPDOC, CODEMP ';

  Result := Result + ' UNION ';

  Result := Result + 'SELECT SQL_NO_CACHE DISTINCT     ';
  Result := Result + '  " " AS SERIE_, ';
  Result := Result + '  " " AS NUMFAT, ';
  Result := Result + '  CAST(" "  AS CHAR(100)) AS SITUACAO, ';
  Result := Result + '  " " AS DOCCAN, ';
  Result := Result + '  " " AS MOTDEL, ';
  Result := Result + '  " " AS DTADEL, ';
  Result := Result + '  " " AS OPEDEL, ';
  Result := Result + '  RFG_DTAENT AS DTAENT, ';
  Result := Result + '  RFG_NUMDOC AS NUMDOC, ';
  Result := Result + '  RFG_ESPDOC AS ESPDOC, ';
  Result := Result + '  " " AS ESAJML, ';
  Result := Result + '  RFG_CODEMP AS CODEMP, ';
  Result := Result + '  "" AS CODVEN, ';
  Result := Result + '  RFG_CODFOR AS CODCLI, ';
  Result := Result + '  0          AS VPAR01, ';
  Result := Result + '  0          AS VPAR02, ';
  Result := Result + '  0          AS VPAR03, ';
  Result := Result + '  0          AS VPAR04, ';
  Result := Result + '  0          AS VPAR05, ';
  Result := Result + '  0          AS VPAR06, ';
  Result := Result + '  0          AS VPAR07, ';
  Result := Result + '  0          AS VPAR08, ';
  Result := Result + '  0          AS VPAR09, ';
  Result := Result + '  0          AS VPAR10, ';
  Result := Result + '  0          AS VPAR11, ';
  Result := Result + '  0          AS VPAR12, ';

  Result := Result + '  " "        AS CODREG, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_NOMFOR AS CLIORI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  " " AS I_M_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "" AS PRORUR, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "" AS MICEMP, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS ORGPUB, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS DESPIS, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS ZONFRA, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS DESZON, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS PERMUT, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  " " AS CODZFM, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  CAST(" " AS CHAR(1)) AS EXPIND, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "S" AS CONSUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "1" AS TABPRE, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  " " AS CODDIG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODREP, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CONPAG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODCND, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODFPG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CLAFIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTPRO, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTCUS, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS DESESP, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS PORDES, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BASRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ALQRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTRET, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS RET_SP, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BARTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  0 AS VLRTSP, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  0 AS BASICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ALQICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTICM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BASIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ALQIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTIPI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS CODTRA, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TIPFRE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS TOTFRE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS PESBRU, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS PESLIQ, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS VOLUME, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS NCONHE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  0 AS BASSIM, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MARCA_, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS ESPECI, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MEN001, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MEN002, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS MEN003, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  " " AS MEN004, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  " " AS MEN005, '; // USADO PARA REIMPRESSAO DE NOTA
  Result := Result + '  " " AS CLAFI2, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CLAFI3, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA
  Result := Result + '  " " AS NATOPE, '; // USADO PARA REIMPRESSAO DE NOTA DE GARANTIA

  Result := Result + '  FOR_NOMFOR AS CLINOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_ENDERE AS ENDERE, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_ENDNUM AS ENDNUM, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_ENDCOM AS ENDCOM, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_BAIRRO AS BAIRRO, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_C_E_P_ AS C_E_P_, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_CODCID AS CODCID, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_FONE01 AS FONE01, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  " " AS NUM_RG, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_C_G_C_ AS C_G_C_, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  FOR_I_E_S_ AS I_E_S_, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  CONCAT(FOR_CODFOR,"-",FOR_NOMFOR) AS NOMCLI, ';
  Result := Result + '  "N"        AS DIFERI, ';
  Result := Result + '  "N"        AS DIF_ST, ';
  Result := Result + '  "T"        AS SITP_C, ';
  Result := Result + '  ""         AS MENP_C, ';
  Result := Result + '  0.00       AS REDICM, ';
  Result := Result + '  0.00       AS DESOPE, ';
  Result := Result + '  ""         AS COBISS, ';
  Result := Result + '  ""         AS CODOBR, ';
  Result := Result + '  ""         AS CODART, ';
  Result := Result + '  ""         AS CODCNO, ';
  Result := Result + '  FOR_CODATI AS CODATI, '; // USADO PARA REIMPRESSÃO DE NOTA

  Result := Result + '  G.AUTOINCREM AS AUTINC, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA


  Result := Result + '  " " AS CODS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS CODS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  Result := Result + '  " " AS DESS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " " AS DESS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  Result := Result + '  0   AS VALS01, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS02, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS03, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS04, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS05, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS06, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS07, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS08, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS09, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS10, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS11, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS12, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS13, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS14, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS15, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS16, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS17, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS18, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS19, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS20, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS21, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS22, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS23, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS24, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS25, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS26, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS27, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS28, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS29, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALS30, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA

  Result := Result + '  0   AS PRAENT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS TOTSER, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PERISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  CAST(GAG_DTAENT AS TIME) AS HORENT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS DESACE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQPIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALPIS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQCOF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALCOF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS ALQCSL, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VALCSL, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS RETPCO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS RETIRF, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS RETISS, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS SEGSOC, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CDESPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS SITIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS ENQIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS MENIPI, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  0   AS ORPURD, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CALICM, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " "   AS NOTRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRFRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PISRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COFRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSLRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS SERRET, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  " "   AS NORESE, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS IRSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PIPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PIPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PISERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PISEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS COSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSPRRT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSPRDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSSERT, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS CSSEDV, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS VLSGSO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0   AS PESGSO, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0000000.00 AS DUPREC, '; // USADO PARA REIMPRESSÃO DE NOTA  DE GARANTIA
  Result := Result + '  0 AS BASORG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  0 AS ICMORG, '; // USADO PARA REIMPRESSÃO DE NOTA DE GARANTIA
  Result := Result + '  "N" AS ENTFAT, '; // USADO PARA REIMPRESSÃO DE NOTA
  Result := Result + '  "N" AS NOTESP, ';
  Result := Result + '  "MOVGAG     "  AS TABELA, ';
  Result := Result + '  " " AS TIP_FC, ';
  Result := Result + '  " " AS ORIDOC, ';
  Result := Result + '  M2.VLRCON AS VLRCON, ';
  Result := Result + '  " " AS DOCORI, ';
  Result := Result + '  "N" AS DOCFOR,  ';
  Result := Result + '  " " AS NROCEI,  ';
  Result := Result + '  "" AS ORDPRO ';
  {$ENDREGION 'SQL/SELECT'}
  Result := Result + 'FROM ';
  Result := Result + ' MOVGAG G ';
  Result := Result + ' JOIN MOVGAD D ON D.GAD_SEQGAG = G.AUTOINCREM ';
  Result := Result + ' JOIN MOVGAU U ON U.GAU_SEQGAD = D.AUTOINCREM ';

  Result := Result + ' JOIN GAGRFD M ON M.RFD_SEQGAU = U.AUTOINCREM ';

  Result := Result + ' JOIN (SELECT A.AUTOINCREM, A. RFG_CODFOR, A.RFG_DTAENT, A.RFG_NUMDOC, A.RFG_ESPDOC, A.RFG_CODEMP, ';
  Result := Result + '              T.QTDITE, T.VLRCON, T.TOTPRO ';
  Result := Result + '       FROM GAGRFG A ';
  Result := Result + '       JOIN (SELECT  AUTOINCREM, ';
  Result := Result + '                     SUM(@QTDITE := IFNULL(RFD_QTDRET,0)+ IFNULL(RFD_QTDREF,0)+ IFNULL(RFD_QTDBAI,0)) AS QTDITE, ';
  Result := Result + '                     SUM(@QTDITE * RFD_UNICON) AS VLRCON, ';
  Result := Result + '                     SUM(@QTDITE * RFD_VALITE) AS TOTPRO ';
  Result := Result + '             FROM GAGRFD ';
  Result := Result + '             GROUP BY AUTOINCREM) T ON T.AUTOINCREM = A.AUTOINCREM) M2 ON M2.AUTOINCREM = M.AUTOINCREM ';

  Result := Result + ' INNER JOIN CADFOR F ON F.FOR_CODFOR = M2.RFG_CODFOR ';
  Result := Result + ' LEFT JOIN MOVDET M3 ON M3.AUTOINCREM = U.GAU_SEQDET ';

  Result := Result + 'WHERE TRUE ';

  If (Not fEmptyStr(FNumDoc)) Then
    Result := Result + ' AND GAG_NUMENT = :NUMDOC ';

  If Not fEmptyStr(FCodCli) then
    Result := Result + ' AND GAG_CODCLI = :CODCLI ';

  If Not fEmptyStr(FCodEmp) Then
    Result := Result + ' AND GAG_CODEMP IN (:CODEMP) '
  Else
    Result := Result + ' AND ' + fGetSQLInEmpresasAcesso('GAG_CODEMP') + ' ';

  Result := Result + ' AND (CAST(GAG_DTAENT AS DATE) >= :DTAINI AND CAST(GAG_DTAENT AS DATE) <= :DTAFIN) ';
  Result := Result + ' AND M3.AUTOINCREM IS NULL ';

  Result := Result + ' GROUP BY NUMDOC, ESPDOC, CODEMP ';

end;

end.
