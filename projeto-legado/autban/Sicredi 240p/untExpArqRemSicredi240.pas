unit untExpArqRemSicredi240;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  System.DateUtils, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemSicredi240 = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRem: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    blnRemLoc : Boolean;
    function fRetEmpresa: String;

  public
    { Public declarations }
    intCartei  : Integer;
    strNomForm : String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemSicredi240: TfrmExpArqRemSicredi240;

implementation

uses untFuncoes, untfuncoesSimples, Data.DB, untFuncAutBan, untCfgGenericas_AutBan,
     untConsultas, untTypesSistema, untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemSicredi240.FormShow(Sender: TObject);
  Var
    strCodCed : String;
    strCodMes : String;
    intCodMes : Integer;

begin
  inherited;

  pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
  frmCfgGenericas_AutBan.strNomForm := strNomForm;
  frmCfgGenericas_AutBan.strCodBco  := '748_240p';
  blnRemLoc := (frmCfgGenericas_AutBan.fRetRemessaLocal = 'S');
  FreeAndNil(frmCfgGenericas_AutBan);


  strCodCed := fGetBancoConfig(0,'CONFIG748_240p-' + IntToStr(intCartei), 'IDENTBC', '');
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'PATHREM',''));


  //*************************************************//
  // TABELA DE CODIFICACAO PARA OS MESES             //
  // 1- JANEIRO             7- JULHO                 //
  // 2- FEVEREIRO           8- AGOSTO                //
  // 3- MARÇO               9- SETEMBRO              //
  // 4- ABRIL         LETRA(O)-OUTUBRO               //
  // 5- MAIO                N- NOVEMBRO              //
  // 6- JUNHO               D- DEZEMBRO              //
  //**********************************************ED*//
  strCodMes := FormatDateTime('mm',VS_Date);
  {**********************************}
  {* CORRIJIDO MES DEVE TER APENAS  *}
  {* UMA POSIÇÃO NO NOME DO ARQUIVO *}
  {* HOMOLOGAÇÃO VIASUL 27/09/2013  *}
  {*******************************JU*}
  intCodMes := StrToInt(strCodMes);

  If intCodMes = 10 Then strCodMes := 'O'
  Else If intCodMes = 11 Then strCodMes := 'N'
  Else If intCodMes = 12 Then strCodMes := 'D'
  Else strCodMes := IntToStr(intCodMes);

  //*************************************************//
  // A PEDIDO DO MARIO FOI ALTERADO O NOME DO ARQ.   //
  // NO DIA 05/10/2007.                              //
  //**********************************************ED*//
  edtNomArquivo.Text  := LeftStr(strCodCed, 5) +
                         strCodMes             +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         '.CRM';


  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemSicredi240.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strContBco  : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
    strSeqTit   : String;
    strCodCar   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strInstru2  : String;
    strDigAgen  : String;
    strConCorr  : String;
    strDigCCorr : String;
    strTimeRem  : String;

    strDtaJurosMora: String;
    dtaDtaJurosMora: TDateTime;
    dtaDtaVen   : TDateTime;

    strHeader   : String;
    strHeaderLote: String;
    strTransacao: String;
    strTraillerLote: String;
    strTrailler : String;

    intCodSeq   : Integer;
    txtTexto    : TextFile;

    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strSeqArq   : String;
    strRespon   : String;
    strCobReg   : String;
    strDtaIns   : String;
    qryRemessa  : TUniQuery;
    strProAce   : String;
    fltValAtr   : Double;
    strUsaSac   : String;

    fltPerMul   : Double;
    strPerMul   : String;

    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;

    fltValDpo       : Double;
    strDtaDpo       : String;
    dtaDtaDpo       : TDateTime;
    blnUsaCnd       : Boolean;
    blnUsaDesPonCli : Boolean;
    blnUsaDesPon    : Boolean;
    fltTotalTitulosDetalhe: Double;

    strSacAva : String;
    strSacEnd : String;
    strSacBai : String;
    strSacCEP : String;
    strSacCid : String;
    strSacEst : String;
    strCgcBeneficario: String;
    strBenefi : String;
    strTraillerLot: String;
    intCodSeqQtdLote: Integer;
    intCodSeqQtdTotalLote: Integer;
    intQtdLote: Integer;
    fltValPag2: Double;
    AstrEndereco    : String;
    blnRecDtaVen : Boolean; // Recalcular data de vencimento Req:  178124
    procedure pGravaLogctr;
    begin
      qryRemessa.DisableControls;
      qryRemessa.First;
      While Not qryRemessa.Eof Do
      Begin
        {****************}
        {* GRAVA LOGCTR *}
        {*************JS*}
        untLogCtr.GravaLogCtr(qryRemessa.FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - ' + strCodBco, Self.Name);

        qryRemessa.Next;
      End;
    end;

begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco  := '748';
  strNomBco  := 'SICREDI';
  strContBco := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'IDENTBC', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'DIGAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'DIAPROT', '');
  strUsaSac  := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'SACAVAL', '');
  strBenefi  := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'NOMEBEN', '');
  strCgcBeneficario := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'CNPJBEN', '');

  strConCorr := RightStr(fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'NUMCTAC', ''), 12);
  strDigCCorr := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'DIGCTAC', '');

  If fEmptyStr(strDiaPro) Then
    strDiaPro := '00';

  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strTimeRem := FormatDateTime('hh', fTime()) + FormatDateTime('mm', fTime()) + FormatDateTime('ss', fTime());

  strInstru1 := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'INSTRU2', '');
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG748_240p', 'RELOCAL', '') = 'N');
  strRespon  := fGetBancoConfig(0,'CONFIG748_240p-' + IntToStr(intCartei), 'RESPONS', '');
  strCobReg  := fGetBancoConfig(0,'CONFIG748_240p-' + IntToStr(intCartei), 'COBREGI', '');
  strProAce  := fGetBancoConfig(0,'CONFIG748_240p-' + IntToStr(intCartei), 'PROACEI', 'N');
  fltPerMul  := fStrToFloat(fGetBancoConfig(0,'CONFIG748_240p-' + IntToStr(intCartei), 'PERMULT', ''));
  strPerMul  := FormatFloat('00.00', fltPerMul);
  strPerMul  := fTiraCaracEspeciais(strPerMul);
  blnRecDtaVen :=  (fGetBancoConfig(0,'CONFIG748_240p-' + IntToStr(intCartei), 'RECDTAVEN', 'S') <> 'N');

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  If (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2')) Then
    blnUsaDesPonCli := True
  Else
    blnUsaDesPonCli := False;

  If fCfgSis('DESPON', varBoolean) Then
    blnUsaDesPon := True
  Else
    blnUsaDesPon := False;

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************ED*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);


  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************ED*//
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try

    fStartTransaction;
    strCartei := 'CONFIG748_240p-' + IntToStr(intCartei) + '-' + VS_strCodEmp;

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT E.*,  C.CID_NOMCID, C.CID_ESTADO ';
    strSQL := strSQL + 'FROM CADEMP E ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = E.EMP_CODCID ';
    strSQL := strSQL + 'WHERE EMP_CODEMP = :CODEMP ';

    qryConsultaGen.SQL.Text := strSQL;
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strCgcEmp := qryConsultaGen.FieldByName('EMP_C_G_C_').AsString;

    If strUsaSac = 'S' Then
    Begin
      strSacAva := fPadL(fTiraCaracEspeciaisPonto(strCgcEmp), 015, '0') + '  ' + fPadR(strNomEmp, 043);
      strSacEnd := LeftStr(qryConsultaGen.FieldByName('EMP_ENDERE').AsString + ', ' +
                           qryConsultaGen.FieldByName('EMP_ENDNUM').AsString, 040);
      strSacBai := LeftStr(qryConsultaGen.FieldByName('EMP_BAIRRO').AsString, 015);
      strSacCEP := fPadR(fRetSomenteNumeros(qryConsultaGen.FieldByName('EMP_C_E_P_').AsString), 008, '0');
      strSacCid := fPadR(qryConsultaGen.FieldByName('CID_NOMCID').AsString, 015);
      strSacEst := fPadR(qryConsultaGen.FieldByName('CID_ESTADO').AsString, 002);
    End;

    qryConsultaGen.Close;

    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_CGCCPF, C.CLI_C_G_C_, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, R.CTR_CONREM, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, C.CLI_PERDPO, C.CLI_QTDDAV, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    If blnUsaDesPon Then
    Begin
      strSQL := strSQL + '  ,D.CND_PERDPO ';
      strSQL := strSQL + '  ,D.CND_QTDDAV ';
    End;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B  ';
    strSQL := strSQL + '  JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI     ';
    strSQL := strSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '                   CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '                   CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '                   CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '                   CTR_CODCLI = CBI_CODCLI     ';

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND  ';

    strSQL := strSQL + 'WHERE CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '      CTR_DTAREC IS NULL ';

    if (fCfgSis('CONREM', varString) = 'C') THEN
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CBI_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      if (fCfgSis('CONREM', varString) = 'C') THEN
        ParamByName('CARTEI').AsString := strCartei;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      Open;
    End;

    intCodSeq := 0;

    If Not qryRemessa.IsEmpty Then
    Begin
      strSeqArq  := fStrZero(fAtuCodSeq('CONFIG748_240p-' + IntToStr(intCartei), 'PROXNUM'), 6);
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      inc(intCodSeq);

      //*************************************************//
      // HEADER DO ARQUIVO                               //
      //**********************************************ED*//
      strHeader := '';
      strHeader := fPadR   ('748'                                                                   , 003)      + //001 003 - CÓDIGO DO BANCO
                   fPadR   ('0000'                                                                  , 004)      + //004 007 - LOTE DE SERVIÇO
                   fPadR   ('0'                                                                     , 001)      + //008 008 - TIPO DE REGISTRO 0 = HEADER DE ARQUIVO / 1 = HEADER DE LOTE / 3 = DETALHE / 5 = TRAILER DE LOTE / 9 = TRAILER DE ARQUIVO
                   fPadR   (' '                                                                     , 009)      + //009 017 - USO EXCLUSIVO FEBRABAN
                   fPadR   ('2'                                                                     , 001)      + //018 018 - TIPO DE INSCRIÇÃO DA EMPRESA 1 = CPF / 2 = CNPJ
                   fPadL   (fTiraCaracEspeciais(IIF(strUsaSac <> 'S', strCgcEmp, strCgcBeneficario),
                                                True, True, True, True, True, True)                 , 014, '0') + //019 032 - NÚMERO DE INSCRIÇÃO DA EMPRESA
                   fPadR   (' '                                                                     , 020)      + //033 052 - CÓDIGO DO CONVÊNIO NO BANCO
                   fPadL   (strCodAgen                                                              , 005, '0') + //053 057 - AGÊNCIA MANTENEDORA DA CONTA
                   fPadL   (strDigAgen                                                              , 001)      + //058 058 - DIGITO DA AGÊNCIA
                   fPadL   (strConCorr                                                              , 012, '0') + //059 070 - CONTA CORRENTE DO BENEFICIÁRIO
                   fPadL   (strDigCCorr                                                             , 001, '0') + //071 071 - DIGITO VERIFICADOR DA CONTA CORRENTE
                   fPadR   (' '                                                                     , 001, ' ') + //072 072 - BRANCOS
                   fPadR   (fTiraCaracEspeciais(IIF(strUsaSac <> 'S', strNomEmp, strBenefi),
                                                True, True, True, True, True, True)                 , 030, ' ') + //073 102 - NOME DA EMPRESA
                   fPadR   ('SICREDI'                                                               , 030, ' ') + //103 132 - NOME DO BANCO
                   fPadR   (' '                                                                     , 010, ' ') + //133 142 - BRANCOS
                   fPadL   ('1'                                                                     , 001)      + //143 143 - CÓDIGO REMESSA/RETORNO 1 = REMESSA / 2 = RETORNO
                   fPadR   (strDtaRem                                                               , 008)      + //144 151 - DATA DA GERAÇÃO DO ARQUIVO
                   fPadR   (strTimeRem                                                              , 006)      + //152 157 - HORA DA GERAÇÃO DO ARQUIVO
                   fPadL   (strSeqArq                                                               , 006, '0') + //158 163 - SEQUÊNCIAL DO ARQUIVO
                   fPadR   ('081'                                                                   , 003)      + //164 166 - NÚMERO DA VERSÃO DO ARQUIVO
                   fPadR   ('01600'                                                                 , 005)      + //167 171 - DENSIDADE DE GRAVAÇÃO DO ARQUIVO
                   fPadR   (' '                                                                     , 020, ' ') + //172 191 - RESERVADO BANCO
                   fPadR   (' '                                                                     , 020, ' ') + //192 211 - RESERVADO EMPRESA
                   fPadR   (' '                                                                     , 029, ' ');  //212 240 - EXCLUSIVO FEBRABAN



      //*************************************************//
      // ESCREVE O HEADER NO TXT                         //
      //**********************************************ED*//
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG748_240p-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strSeqArq), strAutoIncremRem);

      //**********************************************//
      // HEADER DO LOTE                               //
      //*******************************************MO*//
      inc(intCodSeq);
      intQtdLote := 1;
      intCodSeqQtdTotalLote := 0;
      strHeaderLote := '';
      strHeaderLote := fPadR   ('748'                                                                   , 003)      + //001 003 - CÓDIGO DO BANCO
                       fPadL   (IntToStr(intQtdLote)                                                    , 004, '0') + //004 007 - LOTE DE SERVIÇO
                       fPadR   ('1'                                                                     , 001)      + //008 008 - TIPO DE REGISTRO 0 = HEADER DE ARQUIVO / 1 = HEADER DE LOTE / 3 = DETALHE / 5 = TRAILER DE LOTE / 9 = TRAILER DE ARQUIVO
                       fPadR   ('R'                                                                     , 001)      + //009 009 - TIPO DE OPERAÇÃO R = REMESSA / T = RETORNO
                       fPadR   ('01'                                                                    , 002)      + //010 011 - TIPO DE SERVIÇO
                       fPadR   (' '                                                                     , 002)      + //012 013 - USO EXCLUSIVO FEBRABAN
                       fPadR   ('040'                                                                   , 003)      + //014 016 - NÚMERO DA VERSÃO DO LAYOUT DO LOTE
                       fPadR   (' '                                                                     , 001)      + //017 017 - USO EXCLUSIVO FEBRABAN
                       fPadR   ('2'                                                                     , 001)      + //018 018 - TIPO DE INSCRIÇÃO DA EMPRESA 1 = CPF / 2 = CNPJ
                       fPadL   (fTiraCaracEspeciais(IIF(strUsaSac <> 'S', strCgcEmp, strCgcBeneficario),
                                                    True, True, True, True, True, True)                 , 015, '0') + //019 033 - NÚMERO DE INSCRIÇÃO DA EMPRESA
                       fPadR   (' '                                                                     , 020)      + //034 053 - CÓDIGO DO CONVÊNIO NO BANCO
                       fPadL   (strCodAgen                                                              , 005, '0') + //054 058 - AGÊNCIA MANTENEDORA DA CONTA
                       fPadL   (strDigAgen                                                              , 001)      + //059 059 - DIGITO DA AGÊNCIA
                       fPadL   (strConCorr                                                              , 012, '0') + //060 071 - CONTA CORRENTE DO BENEFICIÁRIO
                       fPadL   (strDigCCorr                                                             , 001, '0') + //072 072 - DIGITO VERIFICADOR DA CONTA CORRENTE
                       fPadR   (' '                                                                     , 001, ' ') + //073 073 - DIGITO VERIFICADOR DA COOPERATIVA/AGENCIA/CONTA *ATUALMENTE O SICREDI NÃO UTILIZA ESTE CAMPO
                       fPadR   (fTiraCaracEspeciais(IIF(strUsaSac <> 'S', strNomEmp, strBenefi),
                                                    True, True, True, True, True, True)                 , 030, ' ') + //074 103 - NOME DA EMPRESA
                       fPadR   (' '                                                                     , 040, ' ') + //104 143 - BRANCOS
                       fPadR   (' '                                                                     , 040, ' ') + //144 183 - BRANCOS
                       fPadL   (strSeqArq                                                               , 008, '0') + //184 191 - NÚMERO DA REMESSA/RETORNO
                       fPadR   (strDtaRem                                                               , 008)      + //192 199 - DATA DA GERAÇÃO DO ARQUIVO
                       fPadR   ('0'                                                                     , 008, '0') + //200 207 - DATA DO CRÉDITO
                       fPadR   (' '                                                                     , 033, ' ');  //208 240 - EXCLUSIVO FEBRABAN

      //*************************************************//
      // ESCREVE O HEADER DO LOTE NO TXT                 //
      //**********************************************ED*//
      Writeln(txtTexto,strHeaderLote);

      //*************************************************//
      // TRANSAÇÃO DO ARQUIVO                            //
      //**********************************************ED*//
      With qryRemessa Do
      Begin
        strTransacao := '';
        fltTotalTitulosDetalhe := 0;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          If (FieldByName('CBI_DTAVEN').AsDateTime >= (FieldByName('CBI_DTACAD').AsDateTime + 7)) Or Not blnRecDtaVen Then
            strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('yyyy',FieldByName('CBI_DTAVEN').AsDateTime)
          Else
          Begin
            dtaDtaVen := FieldByName('CBI_DTACAD').AsDateTime + 7;

            strDtaVen := FormatDateTime('dd',dtaDtaVen) +
                         FormatDateTime('mm',dtaDtaVen) +
                         FormatDateTime('yyyy',dtaDtaVen) ;
          End;

          dtaDtaJurosMora := IncDay(FieldByName('CBI_DTAVEN').AsDateTime, 1);
          strDtaJurosMora := FormatDateTime('dd', dtaDtaJurosMora) +
                             FormatDateTime('mm', dtaDtaJurosMora) +
                             FormatDateTime('yyyy', dtaDtaJurosMora);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTACAD').AsDateTime) ;

          strDtaIns := FormatDateTime('yyyy',  FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',  FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) ;

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                                      FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          strSeqTit := fStrZero(fAtuCodSeq('CONFIG748_240p', 'PROXNUM'), 7);

          strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                       fPadR(FieldByName('CBI_PARCEL').AsString, 03) +
                       fPadR(FieldByName('CBI_ESPDOC').AsString, 02) +
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03);

          //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
          AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          fltValDpo := 0;
          strDtaDpo := '0';

          If blnUsaDesPonCli And blnUsaDesPon Then
          begin
            fltValDpo := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CLI_PERDPO').AsFloat / 100 ) );

            If fltValDpo > 0 Then
            Begin
              dtaDtaDpo := FieldByName('CBI_DTAVEN').AsDateTime - FieldByName('CLI_QTDDAV').AsInteger;
              strDtaDpo := FormatDateTime('ddmmyy', dtaDtaDpo);
            End
            Else
              strDtaDpo := '0';
          end
          else
          If blnUsaCnd And blnUsaDesPon Then
          Begin
            fltValDpo := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CND_PERDPO').AsFloat / 100 ) );

            If fltValDpo > 0 Then
            Begin
              dtaDtaDpo := FieldByName('CBI_DTAVEN').AsDateTime - FieldByName('CND_QTDDAV').AsInteger;
              strDtaDpo := FormatDateTime('ddmmyy', dtaDtaDpo);
            End
            Else
              strDtaDpo := '0';
          End;
          {************************************}
          {* SEGMENTO P (OBRIGATÓRIO REMESSA) *}
          {*********************************MO*}
          Inc(intCodSeqQtdTotalLote);
          Inc(intCodSeq);
          strTransacao := fPadR      ('748'                                                        , 003)      + //001 003 - CÓDIGO DO BANCO
                          fStrZero   (IntToStr(intQtdLote)                                         , 004)      + //004 007 - SEQUECIAL DE SERVIÇO
                          fPadR      ('3'                                                          , 001)      + //008 008 - TIPO DE REGISTRO 0 = HEADER DE ARQUIVO / 1 = HEADER DE LOTE / 3 = DETALHE / 5 = TRAILER DE LOTE / 9 = TRAILER DE ARQUIVO
                          fStrZero   (IntToStr(intCodSeqQtdTotalLote)                              , 005)      + //009 013 - SEQUECIAL DE REGISTRO
                          fPadR      ('P'                                                          , 001)      + //014 014 - CÓD. SEGMENTO DO REGISTRO DETALHE
                          fPadR      (' '                                                          , 001)      + //015 015 - BRANCOS USO EXCLUSIVO
                          fPadR      ('01'                                                         , 002)      + //016 017 - CÓDIGO DE MOVIMENTO REMESSA
                          fPadL      (strCodAgen                                                   , 005, '0') + //018 022 - AGÊNCIA MANTENEDORA DA CONTA
                          fPadL      (strDigAgen                                                   , 001)      + //023 023 - DIGITO DA AGÊNCIA
                          fPadL      (strConCorr                                                   , 012, '0') + //024 035 - CONTA CORRENTE DO BENEFICIÁRIO
                          fPadL      (strDigCCorr                                                  , 001, '0') + //036 036 - DIGITO VERIFICADOR DA CONTA CORRENTE
                          fPadR      (' '                                                          , 001)      + //037 037 - DIGITO VERIFICADOR DA COOPERATIVA/AGENCIA/CONTA *ATUALMENTE O SICREDI NÃO UTILIZA ESSE CAMPO
                          fPadR      (IIF(strRespon = 'B', ' ', FieldByName('CBI_NOSNUM').AsString), 020)      + //038 057 - IDENTIFICAÇÃO DO TÍTULO NO BANCO
                          fPadR      (strCodCar                                                    , 001)      + //058 058 - CÓDIGO DA CARTEIRA
                          fPadR      (IIF(strCobReg = 'S', '1', '2')                               , 001)      + //059 059 - FORMA DE CADASTRO DO TÍTULO NO BANCO
                          fPadR      ('1'                                                          , 001)      + //060 060 - TIPO DE DOCUMENTO 1 = TRADICIONAL / 2 = ESCRITURAL
                          fPadR      (IIF(strRespon = 'B', '1', '2')                               , 001)      + //061 061 - IDENTIFICAÇÃO EMISSÃO DO BOLETO
                          fPadR      (IIF(strRespon = 'B', '1', '2')                               , 001)      + //062 062 - IDENTIFICAÇÃO DA DISTRIBUIÇÃO
                          fPadR      (FieldByName('CBI_NUMDUP').AsString                           , 015)      + //063 077 - Nº DO DOCUMENTO DE COBRANÇA
                          fPadR      (strDtaVen                                                    , 008)      + //078 085 - DATA DE VENCIMENTO DO TÍTULO
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat                            , 015)      + //086 100 - VALOR NOMINAL DO TÍTULO
                          fStrZero   ('0'                                                          , 005)      + //101 105 - COOPERATIVA/AGENCIA ENCARREGADA DA COBRANÇA *O SICREDI NÃO UTILIZARÁ ESSE CAMPO
                          fPadR      (' '                                                          , 001)      + //106 106 - DÍGITO VERIFICADOR DA COOP./AGENCIA
                          fPadR      ('03'                                                         , 002)      + //107 108 - ESPÉCIE DO TÍTULO
                          fPadR      (IIF(strProAce = 'S', 'A', 'N')                               , 001)      + //109 109 - IDENTIFICAÇÃO DE TÍTULO ACEITO/NÃO ACEITO
                          fPadR      (strDtaEmi                                                    , 008)      + //110 117 - DATA DA EMISSÃO DO TÍTULO
                          fPadR      (IIF(fltValAtr <= 0, '3', '2')                                , 001)      + //118 118 - CÓDIGO DO JUROS DE MORA 1 = VALOR POR DIA / 2 = TAXA MENSAL / 3 = ISENTO
                          fPadR      (strDtaJurosMora                                              , 008)      + //119 126 - DATA DO JUROS DE MORA
                          fValNumForm(fltValAtr                                                    , 015)      + //127 141 - JUROS DE MORA POR DIA/TAXA
                          fPadR      (IIF(fltValDpo <= 0, '0', '1')                                , 001)      + //142 142 - CÓDIGO DO DESCONTO 1 = VALOR FIXO ATÉ A DATA INFORMADA / 2 = PERCENTUAL ATÉ A DATA INFORMADA / 3 = VALOR POR ANTECIPAÇÃO DIA CORRIDO / 7 = CANCELAMENTO DE DESCONTO
                          fPadR      (strDtaDpo                                                    , 008,'0')      + //143 150 - DATA DO DESCONTO
                          fValNumForm(fltValDpo                                                    , 015)      + //151 165 - VALOR / PERCENTUAL A SER CONCEDIDO
                          fStrZero   ('0'                                                          , 015)      + //166 180 - VALOR DO IOF A SER RECOLHIDO *O SICREDI ATUALMENTE NÃO UTILIZA ESSE CAMPO
                          fStrZero   ('0'                                                          , 015)      + //181 195 - VALOR DO ABATIMENTO
                          fPadR      (strKeyDup                                                    , 025)      + //196 220 - IDENTIFICAÇÃO DO TÍTULO NA EMPRESA
                          fPadR      (IIF(strInstru2 = '00', '3', '1')                             , 001)      + //221 221 - CÓDIGO PARA PROTESTO
                          fStrZero   (strDiaPro                                                    , 002)      + //222 223 - NÚMERO DE DIAS PARA PROTESTO
                          fPadR      ('1'                                                          , 001)      + //224 224 - CÓDIGO PARA BAIXA/DEVOLUÇÃO 1 = BAIXAR/DEVOLVER
                          fPadR      ('060'                                                        , 003)      + //225 227 - Nº DE DIAS PARA BAIXA/DEVOLUÇÃO
                          fPadR      ('09'                                                         , 002)      + //228 229 - CÓDIGO DA MOEDA
                          fStrZero   ('0'                                                          , 010)      + //230 239 - Nº DO CONTRATO DA OPERAÇÃO DE CRÉD.
                          fPadR      (' '                                                          , 001);       //240 240 - USO EXCLUSIVO FEBRABAN/CNAB

          //*************************************************//
          // ESCREVE A TRANSACAO NO TXT                      //
          //**********************************************ED*//
          Writeln(txtTexto,strTransacao);

          strTransacao := '';

          {************************************}
          {* SEGMENTO Q (OBRIGATÓRIO REMESSA) *}
          {*********************************MO*}
          Inc(intCodSeqQtdTotalLote);
          Inc(intCodSeq);
          strTransacao := fPadR      ('748'                                                        , 003)      + //001 003 - CÓDIGO DO BANCO
                          fStrZero   (IntToStr(intQtdLote)                                         , 004)      + //004 007 - SEQUECIAL DE SERVIÇO
                          fPadR      ('3'                                                          , 001)      + //008 008 - TIPO DE REGISTRO 0 = HEADER DE ARQUIVO / 1 = HEADER DE LOTE / 3 = DETALHE / 5 = TRAILER DE LOTE / 9 = TRAILER DE ARQUIVO
                          fStrZero   (IntToStr(intCodSeqQtdTotalLote)                              , 005)      + //009 013 - SEQUECIAL DE REGISTRO
                          fPadR      ('Q'                                                          , 001)      + //014 014 - CÓD. SEGMENTO DO REGISTRO DETALHE
                          fPadR      (' '                                                          , 001)      + //015 015 - BRANCOS USO EXCLUSIVO
                          fPadR      ('01'                                                         , 002)      + //016 017 - CÓDIGO DE MOVIMENTO REMESSA
                          fPadR      (strCpfCgc                                                    , 001)      + //018 018 - TIPO DE INSCRIÇÃO
                          fPadR      (FieldByName('CLI_C_G_C_').AsString                           , 015)      + //019 033 - NÚMERO DE INSCRIÇÃO DO PAGADOR
                          fPadR      (fTiraCaracEspeciais(FieldByName('CLI_NOMCLI').AsString)      , 040)      + //034 073 - NOME DO PAGARDP
                          fPadR      (fTiraCaracEspeciais(AstrEndereco)                            , 040)      + //074 113 - ENDEREÇO DO PAGADOR
                          fPadR      (fTiraCaracEspeciais(FieldByName('BAIRRO').AsString)          , 015)      + //114 128 - BAIRRO DO PAGADOR
                          fPadR      (fTiraCaracEspeciais(FieldByName('C_E_P_').AsString,
                                                          True, True, True, True, True, True)      , 008)      + //129 136 - CEP DO PAGADOR
                          fPadR      (fTiraCaracEspeciais(FieldByName('CIDADE').AsString)          , 015)      + //137 151 - CIDADE DO PAGADOR
                          fPadR      (fTiraCaracEspeciais(FieldByName('ESTADO').AsString)          , 002)      + //152 153 - UF DO PAGADOR
                          fPadR      (IIF(strUsaSac = 'S', '2', '0')                               , 001)      + //154 154 - TIPO DE INSCRIÇÃO DO SACADOR/AVALISTA 1 = CPF / 2 = CNPJ
                          fPadL      (IIF(strUsaSac = 'S', strCgcEmp, '0')                         , 015, '0') + //155 169 - NÚMERO DE INSCRIÇÃO SACADOR/AVALISTA
                          fPadR      (IIF(strUsaSac = 'S', fTiraCaracEspeciais(strNomEmp), ' ')    , 040, ' ') + //170 209 - NOME DO SACADOR/AVALISTA
                          fPadR      ('0'                                                          , 003, '0') + //210 212 - CÓDIGO DO BANCO CORRESPONDENTE NA COMPENSAÇÃO
                          fPadR      (IIF(strRespon = 'B', ' ', FieldByName('CBI_NOSNUM').AsString), 020)      + //213 232 - NOSSO NÚMERO NO BANCO CORRESPONDENTE
                          fPadR      (' '                                                          , 008);       //233 240 - USO EXCLUSIVO FEBRABAN/CNAB

          //*************************************************//
          // ESCREVE A TRANSACAO NO TXT                      //
          //**********************************************ED*//
          Writeln(txtTexto,strTransacao);

          {*********************************************}
          {* SEGMENTO Y (OBRIGATÓRIO SACADOR/AVALISTA) *}
          {******************************************AJ*}
          If strUsaSAc.Equals('S') Then
          Begin
            Inc(intCodSeqQtdTotalLote);
            Inc(intCodSeq);
            strTransacao := fPadR      ('748'                                                        , 003)      + //001 003 - CÓDIGO DO BANCO
                            fStrZero   (IntToStr(intQtdLote)                                         , 004)      + //004 007 - SEQUECIAL DE SERVIÇO
                            fPadR      ('3'                                                          , 001)      + //008 008 - TIPO DE REGISTRO 0 = HEADER DE ARQUIVO / 1 = HEADER DE LOTE / 3 = DETALHE / 5 = TRAILER DE LOTE / 9 = TRAILER DE ARQUIVO
                            fStrZero   (IntToStr(intCodSeqQtdTotalLote)                              , 005)      + //009 013 - SEQUECIAL DE REGISTRO
                            fPadR      ('Y'                                                          , 001)      + //014 014 - CÓD. SEGMENTO DO REGISTRO DETALHE
                            fPadR      (' '                                                          , 001)      + //015 015 - BRANCOS USO EXCLUSIVO
                            fPadR      ('01'                                                         , 002)      + //016 017 - CÓDIGO DE MOVIMENTO REMESSA
                            fPadR      ('01'                                                         , 002)      + //018 019 - IDENFIFICAÇÃO DO SACADOR/AVALISTA
                            fPadR      ('2'                                                          , 001)      + //020 020 - TIPO DE INSCRIÇÃO
                            fPadL      (strCgcEmp                                                    , 015)      + //021 035 - NÚMERO DE INSCRIÇÃO DO SACADOR
                            fPadR      (fTiraCaracEspeciais(LeftStr(strNomEmp, 40))                  , 040)      + //036 075 - NOME DO SACADOR
                            fPadR      (fTiraCaracEspeciais(strSacEnd)                               , 040)      + //076 115 - ENDEREÇO DO SACADOR
                            fPadR      (fTiraCaracEspeciais(strSacBai)                               , 015)      + //116 130 - BAIRRO DO SACADOR
                            fPadR      (strSacCEP                                                    , 008)      + //131 138 - CEP DO SACADOR
                            fPadR      (fTiraCaracEspeciais(strSacCid)                               , 015)      + //139 153 - CIDADE DO SACADOR
                            fPadR      (fTiraCaracEspeciais(strSacEst)                               , 002)      + //154 155 - UF DO SACADOR
                            fPadR      (' '                                                          , 085);       //156 240 - USO EXCLUSIVO FEBRABAN/CNAB

            //*************************************************//
            // ESCREVE A TRANSACAO NO TXT                      //
            //**********************************************ED*//
            Writeln(txtTexto,strTransacao);
          End;

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       FieldByName('CBI_NOSNUM').AsString,
                       0,
                       FieldByName('CBI_VALDUP').AsFloat,
                       FieldByName('CTR_DTAREC').AsDateTime,
                       FieldByName('CBI_DTAVEN').AsDateTime,
                       VS_Date,
                       strLoginUsuarioLogado,
                       '');

          fltTotalTitulosDetalhe := fltTotalTitulosDetalhe + FieldByName('CBI_VALDUP').AsFloat;

          Next;
        End;

        {********************}
        {* TRAILLER DO LOTE *}
        {*****************MO*}
        Inc(intCodSeqQtdTotalLote);
        Inc(intCodSeqQtdTotalLote);
        Inc(intCodSeq);
        strTraillerLot := '';
        strTraillerLot := fPadR      ('748'                          , 003)      + //001 003 - CÓDIGO DO BANCO NA COMPENSAÇÃO
                          fPadL      (IntToStr(intQtdLote)           , 004, '0') + //004 007 - LOTE DE SERVIÇO *SEGUNDO O LAYOUT SE REGISTRO FOR HEADER DO ARQUIVO, PREENCHER COM '0000', SE FOR TRAILER DO ARQUIVO, PREENCHER COM '9999'
                          fPadR      ('5'                            , 001)      + //008 008 - TIPO DE REGISTRO 0 = HERADER / 1 = HERADER DE LOTE / 3 = DETALHE / 5 = TRAILER DE LOTE / 9 = TRAILER DE ARQUIVO
                          fPadR      (' '                            , 009)      + //009 017 - USO EXCLUSIVO FEBRABAN/CNAB
                          fPadL      (IntToStr(intCodSeqQtdTotalLote), 006, '0') + //018 023 - QUANTIDADE DE REGISTROS NO LOTE
                          fPadL      (IntToStr(RecordCount)          , 006, '0') + //024 029 - QUANTIDADE DE TÍTULOS EM COBRANÇA
                          fValNumForm(fltTotalTitulosDetalhe         , 017)      + //030 046 - VALOR TOTAL DOS TÍTULOS EM CARTEIRAS
                          fStrZero   ('0'                            , 006)      + //047 052 - QUANTIDADE DE TÍTULOS EM COBRANÇA VINCULADA
                          fStrZero   ('0'                            , 017)      + //053 069 - VALOR TOTAL DOS TÍTULOS EM CARTEIRAS DE COBRANÇA VINCULADA
                          fStrZero   ('0'                            , 006)      + //070 075 - QUANTIDADE DE TÍTULOS EM COBRANÇA CAUCIONADA
                          fStrZero   ('0'                            , 017)      + //076 092 - VALOR TOTAL DOS TÍTULOS EM CARTEIRAS DE COBRANÇA CAUCIONADA
                          fStrZero   ('0'                            , 006)      + //093 098 - QUANTIDADE DE TÍTULOS EM COBRANÇA DESCONTADA
                          fStrZero   ('0'                            , 017)      + //099 115 - VALOR TOTAL DOS TÍTULOS EM CARTEIRAS DE COBRANÇA DESCONTADA
                          fPadR      (' '                            , 008)      + //116 123 - NÚMERO DO AVISO DE LANÇAMENTO *O SICREDI ATUALMENTE NÃO UTILIZA ESTE CAMPO
                          fPadR      (' '                            , 117);       //124 240 - USU EXCLUSIVO FEBRABAN

        {*************************************}
        {* ESCREVE O TRAILLER DO LOTE NO TXT *}
        {**********************************KP*}
        Writeln(txtTexto,strTraillerLot);

      End;

      //*************************************************//
      // TRAILLER                                        //
      //**********************************************ED*//
      strTrailler := '';

      Inc(intCodSeq);
      strTrailler := '748'                                     + //001 003 - CÓDIGO DO BANCO NA COMPENSAÇÃO
                     fPadR   ('9999'                    , 004) + //004 007 - LOTE DE SERVIÇO *SEGUNDO O LAYOUT SE REGISTRO FOR HEADER DO ARQUIVO, PREENCHER COM '0000', SE FOR TRAILER DO ARQUIVO, PREENCHER COM '9999'
                     fPadR   ('9'                       , 001) + //008 008 - TIPO DE REGISTRO 0 = HERADER / 1 = HERADER DE LOTE / 3 = DETALHE / 5 = TRAILER DE LOTE / 9 = TRAILER DE ARQUIVO
                     fPadR   (' '                       , 009) + //009 017 - USO EXCLUSIVO FEBRABAN/CNAB
                     fStrZero(IntToStr(intQtdLote)      , 006) + //018 023 - QUANTIDADE DE LOTES DO ARQUIVO
                     fStrZero(IntToStr(intCodSeq)       , 006) + //024 029 - QUANTIDADE DE REGISTROS DO ARQUIVO
                     fStrZero('0'                       , 006) + //030 035 - QUANTIDADE DE CONTAS PARA CONCIL.(LOTES)
                     fPadR   (' '                       , 205);  //036 240 - USO EXCLUSIVO FEBRABAN/CNAB


      //*************************************************//
      // ESCREVE O TRAILLER NO TXT                       //
      //**********************************************ED*//
      Writeln(txtTexto,strTrailler);
      CloseFile(txtTexto);

      pDeletaCadCbi(strCodBco, strCartei, edtCodPor.Text);

      pBackupCnfBco;

      If fCommit then
      Begin
        {*******************************************}
        {* GRAVA A TABELA LOGCTR FORA DA TRANSAÇÃO *}
        {* POIS ESTAVA CAUSANDO TIMEOUT EM OUTRAS  *}
        {* ROTINAS DO SISTEMA.                     *}
        {*REQ*145737*****************************RP*}
        pGravaLogctr;

		    fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
				          'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
      End;
    End
    Else
    Begin
      fRollBack;
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

		FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);
  Except
		On E: Exception Do
		Begin

		  fRollBack;

      Try
        CloseFile(txtTexto);
      Except
        //Caso o erro acontecer após o arquivo já estiver fechado
      End;

      If FileExists(strFilePath) Then
        DeleteFile(strFilePath);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);

      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;
end;

procedure TfrmExpArqRemSicredi240.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemSicredi240.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     TEditFocus(edtDesPor),
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     '',
                     False,
                     True) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

function TfrmExpArqRemSicredi240.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

Begin

  qryCadEmp := fCriaQuery(Self);
  With qryCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM CADEMP');
    Open;

    SetLength(arrResult, RecordCount);
    intCount := 0;

    While Not Eof Do
    Begin
      arrResult[intCount] := fStrZero(FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + FieldByName('EMP_NOMEMP').AsString;
      Next;
      Inc(intCount);
    End;
  End;


  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);


  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;

function TfrmExpArqRemSicredi240.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If Not CarregaPortador(edtCodPor.Text) Then
           Result := False
        Else
        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('', 'Portador não cadastrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmExpArqRemSicredi240.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemSicredi240.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
