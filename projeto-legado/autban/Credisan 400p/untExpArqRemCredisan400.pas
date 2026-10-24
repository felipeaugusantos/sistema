unit untExpArqRemCredisan400;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemCredisan400 = class(TfrmPai)
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
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;  

    function fRetEmpresa: String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemCredisan400: TfrmExpArqRemCredisan400;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemCredisan400.FormShow(Sender: TObject);
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := fStrZero(fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'CODCCOR','') +
                                  fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'DIGCCOR',''), 10) +
                         FormatDateTime('dd',   VS_Date) +
                         FormatDateTime('MM',   VS_Date) +
                         FormatDateTime('yyyy', VS_Date) +
                         '.REM';
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemCredisan400.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;

    strCodBco  : String;
    strNomBco  : String;
    strNomEmp  : String;
    strCodCar  : String;
    strCodCop  : String;
    strDigCop  : String;
    strCtaCor  : String;
    strDigCor  : String;
    strCodCed  : String;
    strDigCed  : String;
    strNomCed  : String;
    strNumCon  : String;
    strConCli  : String;
    strDiasProt: String;
    strDiasCred: String;
    strProAce  : String;
    strResp    : String;
    strResEnv  : String;
    strCodPor  : String;
    strCtaBai  : String;
    strInstru1 : String;
    strInstru2 : String;
    strObs001  : String;
    strModali  : String;
    strNosNum  : String;
    strSeuNum  : String;
    strParcel  : String;

    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;

    strAgenCob : String;
    strCodRem  : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;

    strCgcEmp   : String;
    strCpfCgc   : String;

    strKeyDup   : String;
    strCgcCli   : String;
    strCartSeq  : String;

    intCodSeq   : Integer;

    fltValAtr   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa  : TUniQuery;
    strPerMul   : String;

    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;
    strCodOco   : String;

    fltValDup : Double;
    AstrEndereco    : String;
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

  strCodBco      := '089';
  strNomBco      := 'Credisan';
  strNomEmp      := fRetNomeEmpresa(VS_strCodEmp);
  strCodCar      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'CODCART', '');
  strCodCop      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'CODCOPE', '');
  strDigCop      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'DIGCOPE', '');
  strCodCed      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'CODCEDE', '');
  strDigCed      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'DIGCEDE', '');
  strNomCed      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'NOMCEDE', '');
  strNumCon      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'NUMCONV', '');
  strConCli      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'CONVCLI', '');
  strDiasProt    := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'DIAPROT', '');
  strDiasCred    := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'DIACRED', '');
  strProAce      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'PROACEI', '');
  strResp        := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'RESPONS', '');
  strResEnv      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'RESPENV', '');
  strCodPor      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'PORBAI_', '');
  strCtaBai      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'CTABAI_', '');
  strInstru1     := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2     := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'INSTRU2', '');
  blnRemLoc      := Not( fGetBancoConfig(0, 'CONFIG089', 'RELOCAL', '') = 'N' );
  strAgenCob     := IIF(strCodCar = '5', strAgenCob,'00000');
  strDtaRem      := FormatDateTime('dd', VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strObs001      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'OBSERV1', '');
  strModali      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'MODALID', '');
  strPerMul      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'PERMULT', '');
  strCtaCor      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'CODCCOR', '');
  strDigCor      := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'DIGCCOR', '');

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
    fStartTransAction;

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  *  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      Close;
    End;

    strCartei  := 'CONFIG089-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
    strSQL := strSQL + '  R.CTR_JURSUJ AS CTR_JURSUJ, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM CADCBI B ';
    strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = B.CBI_CODCLI ';
    strSQL := strSQL + '  JOIN CADREC R ON R.CTR_NUMDUP = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                   R.CTR_PARCEL = B.CBI_PARCEL AND ';
    strSQL := strSQL + '                   R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                   R.CTR_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                   R.CTR_CODCLI = B.CBI_CODCLI     ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND (B.CBI_CODOCO = "01" OR B.CBI_CODOCO = "06")) OR';
    strSQL := strSQL + '  (CTR_DTAREC IS NOT NULL AND B.CBI_CODOCO = "02"))';

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

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      If (fCfgSis('CONREM', varString) = 'C') THEN
        ParamByName('CARTEI').AsString := strCartei;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG089-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG089-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
      AstrEndereco := RetornaEnderecoENumeroCom37Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************JB*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                 , 001) + //001 - 001 - IDENTIFICAÇÃO DO REGISTRO
                   fPadR   ('1'                 , 001) + //002 - 002 - TIPO DE ARQUIVO REMESSA
                   fPadR   ('REMESSA'           , 007) + //003 - 009 - NOME DO ARQUIVO
                   fPadR   ('01'                , 002) + //010 - 011 - TIPO DE SERVIÇO
                   fPadR   ('COBRANÇA'          , 008) + //012 - 019 - NOME DO SERVIÇO
                   fPadR   (' '                 , 007) + //020 - 026 - BRANCOS
                   fStrZero(strCodCop           , 004) + //027 - 030 - PREFIXO DA COOPERATIVA
                   fStrZero(strDigCop           , 001) + //031 - 031 - DIGITO VERIFICADOR
                   fStrZero(strCodCed           , 008) + //032 - 039 - CÓDIGO DO CEDENTE
                   fStrZero(strDigCed           , 001) + //040 - 040 - DIGITO VERIFICADOR
                   fStrZero(strNumCon           , 006) + //041 - 046 - NÚMERO CONVENENTE - LIDER
                   fPadR   (strNomEmp           , 030) + //047 - 076 - NOME DO CEDENTE
                   fPadR   ('089CREDISANCED'    , 018) + //077 - 094 - IDENTIFICAÇÃO DO BANCO
                   fPadR   (strDtaRem           , 006) + //095 - 100 - DATA DA GRAVAÇÃO
                   fStrZero(strCodRem           , 007) + //101 - 107 - SEQUÊNCIAL DA REMESSA
                   fPadR   (' '                 , 287) + //108 - 394 - FILLER
                   fStrZero(IntToStr(intCodSeq) , 006);  //395 - 400 - NÚMERO SEQUÊNCIAL DO REGISTRO

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************JB*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG089-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************JB*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Inc(intCodSeq);
          Application.ProcessMessages;

          {************}
          {* % AO MES *}
          {*********AF*}
          fltValAtr := fFormataFloat(FieldByName('CBI_PORCEN').AsFloat * 30, 2);

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
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

          strSeuNum := FieldByName('CBI_NUMDUP').AsString +
                       FieldByName('CBI_PARCEL').AsString +
                       FieldByName('CBI_ESPDOC').AsString;

          strCodOco := FieldByName('CBI_CODOCO').AsString;
          if fEmptyStr(strCodOco) Then
             strCodOco := '01';

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          fltValDup := FieldByName('CBI_VALDUP').AsFloat;

          If fCfgSis('VALIMP', varBoolean) then
          begin
            fltValDup := fltValDup + FieldByName('CTR_JURSUJ').AsFloat +
                                     FieldByName('CTR_DESCOB').AsFloat;
          end;

          If SameText(strResp, 'B') Then
            strNosNum := '0'
          Else
            strNosNum := FieldByName('CBI_NOSNUM').AsString;

          strParcel := IntToStr(fGetPosLetraAlfa(FieldByName('CBI_PARCEL').AsString));

          strTransacao := fPadR      ('1'                                  , 01, ' ') + //001 - 001 - IDENTIFICAÇÃO DP REGISTRO
                          fPadR      ('02'                                 , 02, '0') + //002 - 003 - TIPO DE INSCRIÇÃO DO CLIENTE
                          fPadL      (strCgcEmp                            , 14, ' ') + //004 - 017 - CFP/CGC DO CLIENTE
                          fStrZero   (strCodCop                            , 04)      + //018 - 021 - COOPERATIVA CLIENTE
                          fStrZero   (strDigCop                            , 01)      + //022 - 022 - DV COOPERATIVA DO CLIENTE
                          fStrZero   (strCtaCor                            , 08)      + //023 - 030 - CONTA CORRENTE DO CLIENTE
                          fStrZero   (strDigCor                            , 01)      + //031 - 031 - DV CONTA CLIENTE
                          fStrZero   (strConCli                            , 06)      + //032 - 037 - NÚMERO DO CONVÊNIO
                          fPadR      (strKeyDup                            , 25, ' ') + //038 - 062 - NÚMERO CONTROLE DO CLIENTE
                          fStrZero   (strNosNum                            , 12     ) + //063 - 073 - NOSSO NÚMERO/DV DO NOSSO NÚMERO
                          fPadR      ('00'                                 , 02     ) + //075 - 076 - NÚMERO DA PARCELA
                          fPadR      ('00'                                 , 02, '0') + //077 - 078 - INDICATIVO DE VALOR DE GRUPO
                          fPadR      (' '                                  , 03, ' ') + //079 - 081 - FILLER
                          fPadR      (' '                                  , 01, ' ') + //082 - 082 - INDICADOR DE SACADOR
                          fPadR      (IIF(strResp = 'E', '109', '112')     , 03)      + //083 - 085 - PREFIXO DO TÍTULO
                          fPadR      ('000'                                , 03, '0') + //086 - 088 - VARIAÇÃO
                          fPadR      ('0'                                  , 01, '0') + //089 - 089 - CONTA CAUÇÃO
                          fPadR      ('00000'                              , 05, '0') + //090 - 094 - CÓDIGO DE RESPONSABILIDADE
                          fPadR      ('0'                                  , 01, ' ') + //095 - 095 - DV
                          fPadR      ('0'                                  , 06, '0') + //096 - 101 - NÚMERO DO BORDERÔ
                          fPadR      (' '                                  , 05, ' ') + //102 - 106 - FILLER
                          fStrZero   (strCodCar                            , 02     ) + //107 - 108 - CARTEIRA/MODALIDADE
                          fPadR      (strCodOco                            , 02     ) + //109 - 110 - COMANDO/MOVIMENTO
                          fPadR      (strSeuNum                            , 10, ' ') + //111 - 120 -  SEU NÚMERO
                          fPadR      (strDtaVen                            , 06, ' ') + //121 - 126 - DATA VENCIMENTO TÍTULO
                          fValNumForm(fltValDup                            , 13     ) + //127 - 139 - VALOR TÍTULO
                          fPadR      ('089'                                , 03, '0') + //140 - 142 - NÚMERO DO BANCO
                          fPadR      (strCodCop                            , 04, ' ') + //143 - 146 - NÚMERO DA AGÊNCIA COBRADORA
                          fPadR      ('0'                                  , 01, ' ') + //147 - 147 - DV DA AGÊNCIA COBRADORA
                          fPadR      ('01'                                 , 02, ' ') + //148 - 149 - ESPÉCIE DO TÍTULO
                          fPadR      ('0'                                  , 01, ' ') + //150 - 150 - ACEITE DO TÍTULO
                          fPadR      (strDtaEmi                            , 06, ' ') + //151 - 156 - DATA DA EMISSÃO DO TÍTULO
                          fPadR      (strInstru1                           , 02, ' ') + //157 - 158 - PRIMEIRA INSTRUÇÃO CODIFICADA
                          fPadR      (strInstru2                           , 02, ' ') + //159 - 160 - SEGUNDA INSTRUÇÃO
                          fValNumForm(fltValAtr                            , 06, 02 ) + //161 - 166 - TAXA DE MORA MÊS
                          fValNumForm(fStrToFloat(strPerMul)               , 06, 02 ) + //167 - 172 - TAXA DE MULTA
                          fPadR      (' '                                  , 01, ' ') + //173 - 173 - FILLER
                          fStrZero   ('0'                                  , 06     ) + //174 - 179 - DATA PRIMEIRO DESCONTO *
                          fStrZero   ('0'                                  , 13     ) + //180 - 192 - VALOR DO PRIMEIRO DESCONTO
                          fStrZero   ('0'                                  , 13     ) + //193 - 205 - VALOR IOF/QUANTIDADE MONETÁRIA
                          fStrZero   ('0'                                  , 13     ) + //206 - 218 - VALOR ABATIMENTO
                          fStrZero   (strCpfCgc                            , 02     ) + //219 - 220 - TIPO DE INSCRIÇÃO
                          fStrZero   (strCgcCli                            , 14     ) + //219 - 220 - NÚMERO DE INSCRIÇÃO
                          fPadR      (FieldByName('CLI_NOMCLI').AsString   , 40, ' ') + //235 - 274 - NOME DO SACADO
                          fPadR      (AstrEndereco                         , 37, ' ') + //275 - 311 - ENDEREÇO DO SACADO
                          fPadR      (FieldByName('BAIRRO').AsString       , 15, ' ') + //312 - 326 - BAIRRO DO SACADO
                          fPadR      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 - 334 - CEP DO SACADO
                          fPadR      (FieldByName('CIDADE').AsString       , 15, ' ') + //335 - 349 - CIDADE DO SACADO
                          fPadR      (FieldByName('ESTADO').AsString       , 02, ' ') + //350 - 351 - UF DO SACADO
                          fPadR      (strObs001                            , 40, ' ') + //352 - 391 - OBSERVAÇÕES
                          fPadR      (strDiasProt                          , 02, ' ') + //392 - 393 - PROTESTO
                          fPadR      (' '                                  , 01, ' ') + //394 - 395 - FILLER
                          fStrZero   (IntToStr(intCodSeq)                  , 06     );  //395 - 400 - NÚMERO SEQUENCIAL DO REGISTRO

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************JB*}
          Writeln(txtTexto,strTransacao);

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       strNosNum,
                       fStrToFloat(strPerMul),
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
      {*********JB*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                       + //001 - 001 - IDENTIFICAÇÃO DE REGISTRO
                     fPadL    (' '                 , 193, ' ') + //002 - 194 - BRANCOS
                     fPadL    (' '                 , 040)      + //195 - 234 - MENSAGEM DE RESPONSABILIDADE DO CEDENTE
                     fPadL    (' '                 , 040)      + //235 - 274 - MENSAGEM DE RESPONSABILIDADE DO CEDENTE
                     fPadL    (' '                 , 040)      + //275 - 314 - MENSAGEM DE RESPONSABILIDADE DO CEDENTE
                     fPadL    (' '                 , 040)      + //315 - 354 - MENSAGEM DE RESPONSABILIDADE DO CEDENTE
                     fPadL    (' '                 , 040)      + //355 - 394 - MENSAGEM DE RESPONSABILIDADE DO CEDENTE
                     fStrZero (IntToStr(intCodSeq) , 006);       //395 - 400 - NÚMERO SEQUENCIAL DO REGISTRO

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************JB*}
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

procedure TfrmExpArqRemCredisan400.edtCodPorExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemCredisan400.edtCodPorKeyPress(Sender: TObject;  var Key: Char);
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

function TfrmExpArqRemCredisan400.fRetEmpresa: String;
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

function TfrmExpArqRemCredisan400.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemCredisan400.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemCredisan400.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
