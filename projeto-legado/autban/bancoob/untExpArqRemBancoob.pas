unit untExpArqRemBancoob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa;

type
  TfrmExpArqRemBancoob = class(TfrmPai)
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
    fraCheckComboBoxEmpresa: TfraCheckComboBoxEmpresa;
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
  frmExpArqRemBancoob: TfrmExpArqRemBancoob;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemBancoob.FormShow(Sender: TObject);
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yy',VS_Date),2) +
                         '.TXT';
  pSetFocus(edtCodPor);

  fraCheckComboBoxEmpresa.chkcbEmpresaFocusChanged(fraCheckComboBoxEmpresa.chkcbEmpresa);
  fraCheckComboBoxEmpresa.SelecionaEmpresaLogada(fGetBancoConfig(0,'CONFIG756', 'RELOCAL', '') = 'S');
end;

procedure TfrmExpArqRemBancoob.btnGerarClick(Sender: TObject);
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
    strComand  : String;
    strModali  : String;
    strNosNum  : String;
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

    fltValDup : Double;
    strchkcbEmp : String;
    AstrEndereco : String;
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

  strCodBco      := '756';
  strNomBco      := 'Bancoob';
  strNomEmp      := fRetNomeEmpresa(VS_strCodEmp);
  strCodCar      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'CODCART', '');
  strCodCop      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'CODCOPE', '');
  strDigCop      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'DIGCOPE', '');
  strCodCed      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'CODCEDE', '');
  strDigCed      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'DIGCEDE', '');
  strNomCed      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'NOMCEDE', '');
  strNumCon      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'NUMCONV', '');
  strConCli      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'CONVCLI', '');
  strDiasProt    := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'DIAPROT', '');
  strDiasCred    := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'DIACRED', '');
  strProAce      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'PROACEI', '');
  strResp        := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'RESPONS', '');
  strResEnv      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'RESPENV', '');
  strCodPor      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'PORBAI_', '');
  strCtaBai      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'CTABAI_', '');
  strInstru1     := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2     := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'INSTRU2', '');
  blnRemLoc      := Not( fGetBancoConfig(0, 'CONFIG756', 'RELOCAL', '') = 'N' );
  strAgenCob     := IIF(strCodCar = '5', strAgenCob,'00000');
  strDtaRem      := FormatDateTime('dd', VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strObs001      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'OBSERV1', '');
  strComand      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'COMANDO', '');
  strModali      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'MODALID', '');
  strPerMul      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'PERMULT', '');
  strCtaCor      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'CODCCOR', '');
  strDigCor      := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'DIGCCOR', '');

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

{  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try}
    strCartei  := 'CONFIG756-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
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

    If fraCheckComboBoxEmpresa.chkcbEmpresa.Text <> 'Todas'Then
    Begin
      strchkcbEmp := fraCheckComboBoxEmpresa.chkcbEmpresa.Text;
      strSQL := strSQL + ' AND CBI_EMPGER IN (' + fRetStrToSQLIn(strchkcbEmp,';') + ') ';
    End;

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

      if (fCfgSis('CONREM', varString) = 'C') THEN
        ParamByName('CARTEI').AsString := strCartei;

      //ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
      AstrEndereco := RetornaEnderecoENumeroCom37Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG756-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG756-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************JB*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001) + //001 - 001  [01]
                   fPadR   ('1'                , 001) + //002 - 002  [02]
                   fPadR   ('REMESSA'          , 007) + //003 - 009  [03]
                   fPadR   ('01'               , 002) + //010 - 011  [04]
                   fPadR   ('COBRANÇA'         , 008) + //012 - 019  [05]
                   fPadR   (' '                , 007) + //020 - 026  [06]
                   fStrZero(strCodCop          , 004) + //027 - 030  [07]
                   fStrZero(strDigCop          , 001) + //031 - 031  [08]
                   fStrZero(strCodCed          , 008) + //032 - 039  [09]
                   fStrZero(strDigCed          , 001) + //040 - 040  [10]
                   fStrZero(strNumCon          , 006) + //041 - 046  [11]
                   fPadR   (strNomEmp          , 030) + //047 - 076  [12]
                   fPadR   ('756BANCOOBCED'    , 018) + //077 - 094  [13]
                   fPadR   (strDtaRem          , 006) + //095 - 100  [14]
                   fStrZero(strCodRem          , 007) + //101 - 107  [15]
                   fPadR   (' '                , 287) + //108 - 394  [16]
                   fStrZero(IntToStr(intCodSeq), 006);  //395 - 400  [17]

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************JB*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG756_400p-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

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
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03);

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

          strTransacao := fPadR      ('1'                                  , 01, ' ') + //001 - 001
                          fPadR      ('02'                                 , 02, '0') + //002 - 003
                          fPadL      (strCgcEmp                            , 14, ' ') + //004 - 017
                          fPadL      (strCodCop                            , 04, ' ') + //018 - 021
                          fPadL      (strDigCop                            , 01, ' ') + //022 - 022
                          fPadL      (strCtaCor                            , 08, ' ') + //023 - 030
                          fPadL      (strDigCor                            , 01, ' ') + //031 - 031
                          fPadR      (strConCli                            , 06, ' ') + //032 - 037
                          fPadR      (strKeyDup                            , 25, ' ') + //038 - 062
                          fStrZero   (strNosNum                            , 12     ) + //063 - 073
                          fStrZero   (strParcel                            , 02     ) + //075 - 076
                          fPadR      ('00'                                 , 02, '0') + //077 - 078
                          fPadR      (' '                                  , 03, ' ') + //079 - 081
                          fPadR      (' '                                  , 01, ' ') + //082 - 082
                          fPadR      (' '                                  , 03, ' ') + //083 - 085
                          fPadR      ('000'                                , 03, '0') + //086 - 088
                          fPadR      ('0'                                  , 01, '0') + //089 - 089
                          fPadR      ('00000'                              , 05, '0') + //090 - 094
                          fPadR      ('0'                                  , 01, ' ') + //095 - 095
                          fPadR      ('0'                                  , 06, '0') + //096 - 101
                          fPadR      (' '                                  , 04, ' ') + //102 - 105
                          fPadR      (IfThen(strResp = 'B', '1', '2')      , 01, ' ') + //106 - 106
                          fPadR      (strModali                            , 02, ' ') + //107 - 108
                          fPadR      (strComand                            , 02, ' ') + //109 - 110
                          fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                               FieldByName('CBI_PARCEL').AsString, 10), 10, ' ') + //111 - 120
                          fPadR      (strDtaVen                            , 06, ' ') + //121 - 126
                          fValNumForm(fltValDup                            , 13     ) + //127 - 139
                          fPadR      ('756'                                , 03, '0') + //140 - 142
                          fPadR      (strCodCop                            , 04, ' ') + //143 - 146
                          fPadR      ('0'                                  , 01, ' ') + //147 - 147
                          fPadR      ('01'                                 , 02, ' ') + //148 - 149
                          fPadR      ('0'                                  , 01, ' ') + //150 - 150
                          fPadR      (strDtaEmi                            , 06, ' ') + //151 - 156
                          fPadR      (strInstru1                           , 02, ' ') + //157 - 158
                          fPadR      (strInstru2                           , 02, ' ') + //159 - 160
                          fValNumForm(fltValAtr                            , 06, 04 ) + //161 - 166
                          fValNumForm(fStrToFloat(strPerMul)               , 06, 04 ) + //167 - 172
                          fPadR      (IfThen(strResEnv = 'B', '1', '2')    , 01, ' ') + //173 - 173
                          fStrZero   ('0'                                  , 06     ) + //174 - 179
                          fStrZero   ('0'                                  , 13     ) + //180 - 192
                          fStrZero   ('9'                                  , 01     ) + //193 - 193
                          fStrZero   ('0'                                  , 12     ) + //194 - 205
                          fStrZero   ('0'                                  , 13     ) + //206 - 218
                          fStrZero   (strCpfCgc                            , 02     ) + //219 - 220
                          fStrZero   (strCgcCli                            , 14     ) + //221 - 234
                          fPadR      (FieldByName('CLI_NOMCLI').AsString   , 40, ' ') + //235 - 271
                          fPadR      (AstrEndereco                         , 37, ' ') + //275 - 311
                          fPadR      (FieldByName('BAIRRO').AsString       , 15, ' ') + //312 - 326
                          fPadR      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 - 334
                          fPadR      (FieldByName('CIDADE').AsString       , 15, ' ') + //335 - 349
                          fPadR      (FieldByName('ESTADO').AsString       , 02, ' ') + //350 - 351
                          fPadR      (strObs001                            , 40, ' ') + //352 - 391
                          fPadR      (strDiasProt                          , 02, ' ') + //392 - 393
                          fPadR      (' '                                  , 01, ' ') + //394 - 395
                          fStrZero   (IntToStr(intCodSeq)                  , 06     );  //395 - 400

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

          If fCfgSis('UTICRM', varBoolean) And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
          Begin
            TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('CBI_NUMDUP').AsString,
                                                     FieldByName('CBI_ESPDOC').AsString,
                                                     FieldByName('CBI_CODEMP').AsString,
                                                     FieldByName('CBI_CODCLI').AsString,
                                                     FieldByName('CBI_PARCEL').AsString,
                                                     strLoginUsuarioLogado,
                                                     fRetCgcCpf(FieldByName('CBI_CODCLI').AsString),
                                                     afcEnviaDuplicataBanco);
          End;

          Next;
        End;
                                                                                                     
      End;

      {************}
      {* TRAILLER *}
      {*********JB*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                        +          //001 - 001  [01]
                     fPadL    (' ', 393, ' ') +            //002 - 394  [02]
                     fStrZero (IntToStr(intCodSeq), 006);  //395 - 400  [03]

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************JB*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

{      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
 }

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
		//FreeAndNil(stlMensagem);


		FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);
		//FreeAndNil(stlMensagem);

  Except
    On E: Exception Do
    Begin

      fRollBack;

      Try
        CloseFile(txtTexto);
      Except
        //Caso o erro acontecer após o arquivo já estiver fechado
      End;

      DeleteFile(strFilePath);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);

      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;
end;

procedure TfrmExpArqRemBancoob.edtCodPorExit(Sender: TObject);
begin
  inherited;

  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBancoob.edtCodPorKeyPress(Sender: TObject;  var Key: Char);
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

function TfrmExpArqRemBancoob.fRetEmpresa: String;
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



function TfrmExpArqRemBancoob.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemBancoob.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemBancoob.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
