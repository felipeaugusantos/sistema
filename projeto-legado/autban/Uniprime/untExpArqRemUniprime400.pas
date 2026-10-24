unit untExpArqRemUniprime400;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemUniprime400 = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRemessa: TLabel;
    lblNomArq: TLabel;
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
  private

    qryConsultaGen : TUniQuery;
    qryCadPor   : TUniQuery;

    function fRetEmpresa: String;
    { Private declarations }
  public
    { Public declarations }
    strSimDes: String;
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemUniprime400: TfrmExpArqRemUniprime400;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutban, Data.DB, untConsultas,
     untTypesSistema, untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemUniprime400.FormShow(Sender: TObject);
begin
  inherited;

  strSimDes := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'TIPCOBR','');

  If fEmptyStr(strSimDes) Then
    strSimDes := 'S';

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'PATHREM',''));

  If strSimDes = 'S' Then
  Begin
    edtNomArquivo.Text  := 'CB' +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) + 'A' + IntToStr(intCartei) + '.REM';
  End
  Else
  Begin
    edtNomArquivo.Text  := 'DS' +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) + 'A' + IntToStr(intCartei) + '.REM';
  End;

  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemUniprime400.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strNumDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodRem   : String;
    strCpfCgc   : String;
    strEmpBco   : String;
    strNumAut   : String;
    strCodAge   : String;
    strCntCor   : String;
    strDigCnt   : String;
    strCodCar   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strObserv   : String;
    strEmpAgr   : String;
    strCodCli   : String;

    strHeader   : String;
    strTransacao: String;
    strTrans2   : String;
    strTrailler : String;
    strInformacoesCooperado: String;
    strBairro : String;
    strCidade : String;
    str_UF    : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strRespon   : String;
    strNosNum   : String;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strEnvMsg   : String;
    strObsAgr   : WideString;
    strCartSeq  : String;
    strCartei: String;
    strCcDigito : String;
    strNomeCoop : String;
    strObs1,
    strObs2,
    strObs3,
    strObs4: String;

    fltPerMul   : Double;

    qryRemessa  : TUniQuery;

    strFilePath : String;
    strAutoIncremRem: String;
    AstrEndereco    : String;
    procedure pListaDupAgr(strNumAgr: String);
      Var
        qryDupAgr: TUniQuery;
        strSQL   : String;
    Begin

      qryDupAgr := fCriaQuery(Self);
      strObsAgr := '';

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   CTR_NUMAGR, ';
      strSQL := strSQL + '   CTR_NUMDUP, ';
      strSQL := strSQL + '   CTR_PARCEL, ';
      strSQL := strSQL + '   CTR_ESPDOC, ';
      strSQL := strSQL + '   CTR_CODEMP, ';
      strSQL := strSQL + '   CTR_CODCLI, ';
      strSQL := strSQL + '   CTR_DTACAD, ';
      strSQL := strSQL + '   CTR_VALDUP  ';
      strSQL := strSQL + ' FROM          ';
      strSQL := strSQL + '   DUPAGR      ';
      strSQL := strSQL + ' WHERE         ';
      strSQL := strSQL + '   CTR_NUMAGR = :NUMAGR AND ';
      strSQL := strSQL + '   CTR_EMPAGR = :EMPAGR AND ';
      strSQL := strSQL + '   CTR_CODCLI = :CODCLI ';
      strSQL := strSQL + ' ORDER BY               ';
      strSQL := strSQL + '   CTR_DTACAD, CTR_CODEMP, CTR_ESPDOC, CTR_NUMDUP, CTR_PARCEL ';

      With qryDupAgr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMAGR').AsString := strNumAgr;
        ParamByName('EMPAGR').AsString := strEmpAgr;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;

        First;

        While Not Eof Do
        Begin
          strObsAgr := strObsAgr + FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) +
                                 ' DOC:' + FieldByName('CTR_NUMDUP').AsString +
                                 FieldByName('CTR_PARCEL').AsString +
                                 FieldByName('CTR_ESPDOC').AsString +
                                 '-' + FieldByName('CTR_CODEMP').AsString +
                                 ' V:' + FormatFloat('#,##0.00', FieldByName('CTR_VALDUP').AsFloat) + ' ';

          Next;
        End;

      End;

      FreeAndNil(qryDupAgr);

    End;

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
  strNumDup := '';

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

  intCodSeq  := 1;
  strCodBco  := '099';
  strNomBco  := 'UNIPRIME';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);

  strNumAut  := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'NUMAUTO', '');
  strCodAge  := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'CODAGEN', '');
  strEmpBco  := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'CODEMPR', '');
  strCntCor  := RightStr(fStrZero(fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'NUMCTAC', ''), 7), 7);
  strDigCnt  := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'CODCART', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'INSTRU1', '');
  strObserv  := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'OBSERV1', '');
  blnRemLoc  := Not( fGetBancoConfig(0,'CONFIG099', 'RELOCAL', '') = 'N' );
  strEnvMsg  := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'MANDMSG', '');
  strObs1    := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'OBSERV1', '');
  strObs2    := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'OBSERV2', '');
  strObs3    := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'OBSERV3', '');
  strObs4    := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'OBSERV4', '');
  strNomeCoop := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'NOMECOOP', '');

  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'PERMULT', '') );

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

  strRespon := '1';
  If (fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'RESPONS', '') = 'E') Then
    strRespon := '2';

  If strSimDes = 'S' Then
    strDiaPro := IIF(Pos(strInstru1, '06_05_07_18_') > 0, fStrZero(fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'DIAPROT', ''),2), '00')
  Else
    strDiaPro := '00';

  Try
    fStartTransaction;
    strCartei  := 'CONFIG099-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  E.*,  C.CID_NOMCID, C.CID_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP E ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = E.EMP_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strNovCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      strBairro := FieldByName('EMP_BAIRRO').AsString;
      strCidade := FieldByName('CID_NOMCID').AsString;
      str_UF    := FieldByName('CID_ESTADO').AsString;

      Close;
    End;

    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  C.CLI_C_G_C_, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B, ';
    strSQL := strSQL + '  CADCLI C, ';
    strSQL := strSQL + '  CADREC R ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CLI_CODCLI = CBI_CODCLI AND ';
    strSQL := strSQL + '  CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = CBI_CODCLI AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL ';

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

    If Not qryRemessa.IsEmpty Then
    Begin
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG099-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG099-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      strEmpAgr := qryRemessa.FieldByName('CBI_CODEMP').AsString;
      strCodCli := qryRemessa.FieldByName('CBI_CODCLI').AsString;

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************MO*}
      strHeader := '';

      strHeader := fPadR   ('0'                , 001)      + //001 A 001 - IDENTIFICAÇÃO DO REGISTRO
                   fPadR   ('1'                , 001)      + //002 A 002 - IDENTIFICAÇÃO DO ARQUIVO REMESSA
                   fPadR   ('REMESSA'          , 007)      + //003 A 009 - LITERAL REMESSA
                   fPadR   ('01'               , 002)      + //010 A 011 - CÓDIGO DE SERVIÇO
                   fPadR   ('COBRANCA'         , 015)      + //012 A 026 - LITERAL SERVIÇO
                   fPadL   (strEmpBco          , 020, '0') + //027 A 046 - Código da Empresa
                   fPadR   (strNomeCoop        , 030)      + //047 A 076 - NOME DA EMPRESA
                   fPadR   ('099'              , 003)      + //077 A 079 - NÚMERO DO BANCO NA CÂMARA DE COMPENSAÇÃO
                   fPadR   ('UNIPRIME'         , 015)      + //080 A 094 - NOME DO BANCO POR EXTENSO
                   fPadR   (strDtaRem          , 006)      + //095 A 100 - DATA DA GRAVAÇÃO DO ARQUIVO
                   fPadR   (' '                , 008)      + //101 A 108 - BRANCOS
                   fPadR   ('MX'               , 002)      + //109 A 110 - IDENTIFICAÇÃO DO SISTEMA
                   fPadR   (strCodRem          , 007)      + //111 A 117 - Nº SEQUENCIAL DE REMESSA
                   fPadR   (' '                , 277)      + //118 A 394 - BRANCOS
                   fStrZero('1'                , 006);       //395 A 400 - Nº SEQUENCIAL DO REGISTOR DE UM EM UM

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, StrCartei, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin

          strObserv  := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'OBSERV1', '');

          Inc(intCodSeq);
          Application.ProcessMessages;

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          If FieldByName('CBI_CGCCPF').AsInteger = 0 Then
            strCpfCgc := '99'
          Else If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime);

          if not TEspecieParaArquivoRemessa.New.fValidaEspecie(FieldByName('CBI_ESPDOC').AsString) then
          begin
            fRollBack;
            CloseFile(txtTexto);
            If FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) Then
              DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
            Exit;
          end;

          strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                       fPadR(FieldByName('CBI_PARCEL').AsString, 03) +
                       fPadR(FieldByName('CBI_ESPDOC').AsString, 02) +
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03) ;

          //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
          AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

          strNumDup := (FieldByName('CBI_NUMDUP').AsString) + (FieldByName('CBI_PARCEL').AsString);

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          {*******************************************}
          {* SE BANCO EMITE BOLETO                   *}
          {****************************************MV*}
          strNosNum := FieldByName('CBI_NOSNUM').AsString;
          If (strRespon = '1') Then
            strNosNum := '0';

          If strRespon = '1' then
           strInformacoesCooperado := strBairro + strCidade + str_UF
          Else
           strInformacoesCooperado := strCgcEmp + '  ' + strNomEmp;

          strCcDigito := strCntCor + strDigCnt;
          strTransacao := fPadR      ('1'                                       , 01)      + //001 A 001 - IDENTIFICAÇÃO DO REGISTRO
                          fStrZero   ('0'                                       , 05)      + //002 A 006 - AGÊNCIA DE DÉBITO (OPCIONAL)
                          fStrZero   ('0'                                       , 01)      + //007 A 007 - DÍGITO DA AGÊNCIA DE DÉBITO (OPCIONAL)
                          fStrZero   ('0'                                       , 05)      + //008 A 012 - RAZÃO DA CONTA CORRENTE (OPCIONAL)
                          fStrZero   ('0'                                       , 07)      + //013 A 019 - CONTA CORRENTE (OPCIONAL)
                          fStrZero   ('0'                                       , 01)      + //020 A 020 - DÍGITO DA CONTA CORRENTE (OPCIONAL)
                          fPadR      ('0'                                       , 01)      + //021 A 021 - ZERO FIXO
                          fPadR      (strCodCar                                 , 03)      + //022 A 024 - CÓDIGO DA CARTEIRA
                          fPadR      (strCodAge                                 , 05)      + //025 A 029 - CÓDIGO DA AGÊNCIA
                          fPadR      (strCntCor                                 , 07)      + //030 A 036 - CONTA CORRENTE
                          fPadR      (strDigCnt                                 , 01)      + //037 A 037 - DV CONTA CORRENTE
                          fPadR      (strKeyDup                                 , 25)      + //038 A 062 - CONTROLE DA EMPRESA
                          fPadR      ('000'                                     , 03)      + //063 A 065 - CÓDIGO DO BANCO A SER DEBITADO NA CÂMARA DE COMPENSAÇÃO
                          fPadR      (IIF(fltPerMul > 0, '2', '0')              , 01)      + //066 A 066 - (2) CONSIDERAR O PERCENTUAL DE MULTA (0) NÃO CONSIDERAR
                          fValNumForm(fltPerMul                                 , 04)      + //067 A 070 - PERCENTUAL DE MULTA A SER CONSIDERADO
                          fStrZero   (strNosNum                                 , 12)      + //071 A 082 - NOSSO NÚMERO
                          fStrZero   ('0'                                       , 10)      + //083 A 092 - DESCONTO BONIFICAÇÃO POR DIA
                          fPadR      (strRespon                                 , 01)      + //093 A 093 - RESPONSÁVEL PELA IMPRESSÃO
                          fPadR      (' '                                       , 01)      + //094 A 094 - IDENT. SE EMITE BOLETO PARA DÉBITO AUTOMÁTICO
                          fPadR      (' '                                       , 10)      + //095 A 104 - BRANCOS
                          fPadR      (' '                                       , 01)      + //105 A 105 - INDICADOR DE RATEIO
                          fPadR      ('2'                                       , 01)      + //106 A 106 - ENDEREÇAMENTO PARA AVISO DO DÉBITO AUTOMÁTICO EM CONTA CORRENTE (OPCIONAL)
                          fPadR      (' '                                       , 02)      + //107 A 108 - BRANCOS
                          fPadR      ('01'                                      , 02)      + //109 A 110 - IDENTIFICAÇÃO DA OCORRÊNCIA
                          fPadR      (RightStr(strNumDup, 10)                   , 10)      + //111 A 120 - NÚMERO DO DOCUMENTO
                          fPadR      (strDtaVen                                 , 06)      + //121 A 126 - DATA DE VENCIMENTO
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat         , 13)      + //127 A 139 - VALOR DO TÍTULO
                          fStrZero   ('0'                                       , 03)      + //140 A 142 - BANCO ENCARREDADO DA COBRANÇA
                          fStrZero   ('0'                                       , 05)      + //143 A 147 - AGÊNCIA DEPOSITÁRIA
                          fPadR      ('01'                                      , 02)      + //148 A 149 - ESPÉCIE DO TÍTULO
                          fPadR      ('N'                                       , 01)      + //150 A 150 - ACEITE
                          fPadR      (strDtaEmi                                 , 06)      + //151 A 156 - DATA DE EMISSÃO
                          fPadR      (strInstru1                                , 02)      + //157 A 158 - INSTRUÇÃO 1
                          fPadR      (strDiaPro                                 , 02)      + //159 A 160 - QUANTIDADE DE DIAS PARA PROTESTO
                          fValNumForm(fltValAtr                                 , 13)      + //161 A 173 - MORA DIÁRIA
                          fPadL      (IIF(FieldByName('CBI_DESSUJ').AsFloat > 0, strDtaVen, '0'),06, '0') + //174 A 179 - DATA DE DESCONTO
                          fValNumForm(FieldByName('CBI_DESSUJ').AsFloat         , 13)      + //180 A 192 - VALOR DO DESCONTO
                          fStrZero   ('0'                                       , 13)      + //193 A 205 - VALOR DO IOF
                          fStrZero   ('0'                                       , 13)      + //206 A 218 - VALOR DO ABATIMENTO
                          fStrZero   (strCpfCgc                                 , 02)      + //219 A 220 - TIPO DE INSCRIÇÃO DO PAGADOR
                          fPadL      (strCgcCli                                 , 14, '0') + //221 A 234 - Nº DA INSCRIÇÃO DO PAGADOR
                          fPadR      (FieldByName('CLI_NOMCLI').AsString        , 40)      + //235 A 274 - NOME DO PAGADOR
                          fPadR      (AstrEndereco                              , 40)      + //275 A 314 - ENDEREÇO DO PAGADOR
                          fPadR      (' '                                       , 12)      + //315 A 326 - 1ª MENSAGEM
                          fPadL      (LeftStr(FieldByName('C_E_P_').AsString,5) , 05, '0') + //327 A 331 - CEP DO PAGADOR
                          fPadL      (RightStr(FieldByName('C_E_P_').AsString,3), 03, '0') + //332 A 334 - SUFIXO DO CEP
                          fPadL      (strInformacoesCooperado                   , 60)      + //335 A 394 - DADOS DO COOPERADO
                          fStrZero   (IntToStr(intCodSeq)                       , 06);       //395 A 400 - SEQUENCIAL DO REGISTRO

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);

          Inc(intCodSeq);
          strTrans2 := '';
          strTrans2 := '2'                                        + //001 A 001 - TIPO DE REGISTRO
                       fPadR (strObs1                 , 080, ' ') + //002 A 081 - MENSAGEM 1
                       fPadR (strObs2                 , 080, ' ') + //082 A 161 - MENSAGEM 2
                       fPadR (strObs3                 , 080, ' ') + //162 A 241 - MENSAGEM 3
                       fPadR (strObs4                 , 080, ' ') + //242 A 321 - MENSAGEM 4
                       fPadL ('0'                     , 006, '0') + //322 A 327 - 2ª DATA DE DESCONTO
                       fPadR ('0'                     , 013, '0') + //328 A 340 - 2ª DATA DE DESCONTO
                       fPadL ('0'                     , 006, '0') + //341 A 346 - 3ª DATA DE DESCONTO
                       fPadL ('0'                     , 013, '0') + //347 A 359 - 3ª DATA DE DESCONTO
                       fPadL ('0'                     , 007, '0') + //360 A 366 - RESERVA
                       fPadL (strCodCar               , 003, ' ') + //367 A 369 - CÓDIGO DA CARTEIRA
                       fPadL (strCodAge               , 005, ' ') + //370 A 374 - CÓDIGO DA AGÊNCIA
                       fPadL (strCntCor               , 007, '0') + //375 A 381 - CONTA CORRENTE
                       fPadL (strDigCnt               , 001, '0') + //382 A 382 - DV CONTA CORRENTE
                       fPadL (strNosNum               , 012, '0') + //383 A 394 - NOSSO NÚMERO + DV DO NOSSO NÚMERO
                       fPadL (IntToStr(intCodSeq)     , 006, '0');  //395 A 400 - Nº SEQUENCIAL DE REGISTRO

          Writeln(txtTexto,strTrans2);

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       strNosNum,
                       fltPerMul,
                       FieldByName('CBI_VALDUP').AsFloat,
                       FieldByName('CTR_DTAREC').AsDateTime,
                       FieldByName('CBI_DTAVEN').AsDateTime,
                       VS_Date,
                       strLoginUsuarioLogado,
                       '');

          Next;
        End;

      End;

      {************}
      {* TRAILLER *}
      {*********AF*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                + //001
                     fPadR   (' '                , 393) + //002
                     fStrZero(IntToStr(intCodSeq), 006);  //395

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
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

procedure TfrmExpArqRemUniprime400.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemUniprime400.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var 
    ArrSel: TConsultasArray;
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

function TfrmExpArqRemUniprime400.fRetEmpresa: String;
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
    SQL.Add('SELECT * FROM CADEMP ');
    SQL.Add('ORDER BY EMP_CODEMP ');
    Open;
    First;

    SetLength(arrResult, RecordCount);
    intCount := 0;

    While Not Eof Do
    Begin
      arrResult[intCount] := fStrZero(FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + FieldByName('EMP_NOMEMP').AsString;
      Next;
      Inc(intCount);
    End;
  End;
  {**************}
  {* 14/01/2011 *}
  {***********RV*}
  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);

  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;


function TfrmExpArqRemUniprime400.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemUniprime400.FormCreate(Sender: TObject);
begin
  inherited;
   qryCadPor := fCriaQuery(Self); 
end;

end.
