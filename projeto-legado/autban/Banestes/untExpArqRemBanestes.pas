{******************************************************}
{* ATENÇÃO, ESSE BANCO NÃO ESTÁ PREPARADO PARA CARNET *}
{***************************************************AF*}
unit untExpArqRemBanestes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBanestes = class(TfrmPai)
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

    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;
    function fRetEmpresa: String;
    function fRetDupAgrupadas(strNumAgr, strCodCli: String): String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemBanestes: TfrmExpArqRemBanestes;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemBanestes.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yy',VS_Date),2) +
                         '.TXT';
  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemBanestes.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strContCor  : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
    strCodCar   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strInstru2  : String;
    strNossNum  : String;
    strHeader   : String;
    strTransacao: String;
    strMensagem : String;
    strTrailler : String;
    strDupAgr   : String;
    strEnvDpAg  : String;
    strProAce   : String;
    strCodMor   : String;
    strObserv   : String;
    strNovCodEmp: String;
    strRespBol  : String;

    fltValMora  : Double;
    blnRemLoc   : Boolean;
    intCodSeq   : Integer;
    txtTexto    : TextFile;
    qryRemessa  : TUniQuery;

    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;
    strCodRem: String;
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

  strDiaPro  := '00';
  strCodBco  := '021';
  strNomBco  := 'BANESTES';
  strCodAgen := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'CODCART', '');
  strContCor := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'NUMCTAC', '');
  strProAce  := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'PROACEI', '');
  strCodMor  := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'CODMORA', '0');
  strObserv  := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'OBSERV1', '');
  strInstru1 := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'INSTRU2', '');
  strRespBol := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'RESPONS', '');

  strCodRem  := fStrZero(fAtuCodSeq('CONFIG021-' + IntToStr(intCartei), 'PROXNUM'), 7);

  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG021', 'RELOCAL', '') = 'N' );
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  strEnvDpAg := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'ENVDPAG', '');

  If (strInstru1 = 'P6') Then
    strDiaPro := strInstru2;

  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);

  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try
    fStartTransaction;

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

 { Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try}
    strCartei  := 'CONFIG021-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
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
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                                    , 001)      + //001 - 001
                   fPadR   ('1'                                    , 001)      + //002 - 002
                   fPadR   ('REMESSA'                              , 007)      + //003 - 009
                   fPadR   ('01'                                   , 002)      + //010 - 011
                   fPadR   ('COBRANCA'                             , 015, ' ') + //012 - 026
                   fPadR   (strContCor                             , 011, '0') + //027 - 037
                   fPadR   (' '                                    , 009)      + //038 - 046
                   fPadR   (strNomEmp                              , 030, ' ') + //047 - 076
                   fPadR   (strCodBco                              , 003)      + //077 - 079
                   fPadR   (strNomBco                              , 008, ' ') + //080 - 087
                   fPadR   (' '                                    , 007, ' ') + //088 - 094
                   fPadR   (strDtaRem                              , 006)      + //095 - 100
                   fPadR   (' '                                    , 294)      + //101 - 394
                   fPadL   (IntToStr(intCodSeq)                    , 006, '0');  //395 - 400

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG021-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin

          Inc(intCodSeq);
          Application.ProcessMessages;

          {*********************************************************************************************}
          {******************** REGRAS PARA O VALOR DE MORA (posições de 162 a 173) ********************}
          {* 0 - INDICA QUE O CAMPO “VALOR DA MORA” CONTÉM O VALOR DIÁRIO A SER COBRADO POR ATRASO. ****}
          {* 1 - INDICA QUE O CAMPO “VALOR DA MORA” CONTÉM A TAXA MENSAL PARA CÁLCULO DO VALOR DIÁRIO. *}
          {* 9 - INDICA QUE O “VALOR DA MORA” SERÁ COBRADO DE ACORDO COM O PERCENTUAL INFORMADO NO *****}
          {*     CONTRATO DE COBRANÇA DO CLIENTE – PREENCHER O CAMPO COM ZEROS. ************************}
          {**REQ*136326******************************************************************************MO*}
          if strCodMor = '0' then
          begin
            fltValMora := ((FieldByName('CBI_VALDUP').AsFloat) * (FieldByName('CBI_PORCEN').AsFloat / 100));
          end
          else
          if strCodMor = '1' then
          begin
            fltValMora := (FieldByName('CBI_PORCEN').AsFloat * 30);
          end
          else
          begin
            fltValMora := 0;
          end;

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '02'
          Else
            strCpfCgc := '01';

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

          strNossNum := FieldByName('CBI_NOSNUM').AsString;

          strTransacao := fPadR      ('1'                                  , 01)      + //001 - 001
                          fPadR      ('02'                                 , 02)      + //002 - 003
                          fPadL      (strCgcEmp                            , 14, '0') + //004 - 017
                          fPadR      (strContCor                           , 11, '0') + //018 - 028
                          fPadR      (' '                                  , 09)      + //029 - 037
                          fPadR      (strKeyDup                            , 25, ' ') + //038 - 062
                          fPadL      (strNossNum                           , 10, '0') + //063 - 072
                          fPadR      (' '                                  , 10)      + //073 - 082
                          fPadR      (' '                                  , 06)      + //083 - 088
                          fPadR      ('00'                                 , 02)      + //084 - 090
                          fPadR      ('00'                                 , 02)      + //091 - 092
                          fPadL      ('0'                                  , 01, '0') + //093 - 093
                          fPadL      (' '                                  , 14) + //094 - 107
                          fPadR      (strCodCar                            , 01)      + //108 - 108
                          fPadR      ('01'                                 , 02)      + //109 - 110
                          fPadL      (FieldByName('CBI_NUMDUP').AsString +
                                      FieldByName('CBI_PARCEL').AsString   , 10)      + //111 - 120
                          fPadR      (strDtaVen                            , 06)      + //121 - 126
                          fPadR      ('000'                                , 03)      + //127 - 129
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat    , 10)      + //130 - 139
                          fPadR      (strCodBco                            , 03)      ; //140 - 142

                          If strRespBol = 'B' Then
                            strTransacao := strTransacao + fPadL ('0'      , 05, '0') + //143 - 147
                                                           fPadR ('21'     , 02)        //148 - 149
                          Else
                            strTransacao := strTransacao + fPadL ('00501'  , 05, '0') + //143 - 147
                                                           fPadR ('01'     , 02)      ; //148 - 149

                          strTransacao := strTransacao +
                          fPadR      (IIF(strProAce = 'S', 'A', 'N')       , 01)      + //150 - 150
                          fPadR      (strDtaEmi                            , 06)      + //151 - 156
                          fPadL      (strInstru1                           , 02, '0') + //157 - 158
                          fPadL      (strInstru2                           , 02, '0') + //159 - 160
                          fPadR      (strCodMor                            , 01)      + //161 - 161
                          fValNumForm(fltValMora                           , 12)      + //161 - 173
                          fStrZero   ('0'                                  , 06)      + //174 - 179
                          fStrZero   ('0'                                  , 13)      + //180 - 192
                          fStrZero   ('0'                                  , 13)      + //193 - 205
                          fStrZero   ('0'                                  , 13)      + //206 - 218
                          fPadL      (strCpfCgc                            , 02, '0') + //219 - 220
                          fPadL      (strCgcCli                            , 14, '0') + //221 - 234
                          fPadR      (FieldByName('CLI_NOMCLI').AsString   , 40, ' ') + //235 - 274
                          fPadR      (AstrEndereco                         , 40, ' ') + //275 - 314
                          fPadR      (FieldByName('BAIRRO').AsString       , 12, ' ') + //315 - 326
                          fPadL      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 - 334
                          fPadR      (FieldByName('CIDADE').AsString       , 15, ' ') + //335 - 349
                          fPadR      (FieldByName('ESTADO').AsString       , 02, ' ') + //350 - 351
                          fPadR      (strObserv                            , 40, ' ') + //352 - 391
                          fPadL      (strDiaPro                            , 02, '0') + //392 - 393
                          fPadL      ('0'                                  , 01)      + //394 - 394
                          fPadL      (IntToStr(intCodSeq)                  , 06, '0');  //395 - 400

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);

          {******************************}
          {* DADOS DA MENSAGEM VARIÁVEL *}
          {************************PZ,JB*}
          If (strEnvDpAg = 'S') Then
          Begin

            strMensagem := '';
            Inc(intCodSeq);

            {*************************************************}
            {* SE FOR AGRUPAMENTO, INSERE OS NUMEROS DAS DU- *}
            {* PLICATAS AGRUPADAS, SENÃO DEIXA EM BRANCO.    *}
            {**********************************************PZ*}
            If (FieldByName('CBI_ESPDOC').AsString = 'AG') Then
              strDupAgr := fRetDupAgrupadas(FieldByName('CBI_NUMDUP').AsString, FieldByName('CBI_CODCLI').AsString)
            Else
              strDupAgr := '';

            strMensagem  := fPadR      ('1'                                  , 01)      +         //001 - 001
                            fPadR      ('02'                                 , 02)      +         //002 - 003
                            fPadL      (strCgcEmp                            , 14, '0') +         //004 - 017
                            fPadL      (strContCor                           , 11, '0') +         //018 - 028
                            fPadR      (' '                                  , 09)      +         //029 - 037
                            fPadR      (strKeyDup                            , 25)      +         //038 - 062
                            fPadL      (strNossNum                           , 10, '0') +         //063 - 072
                            fPadR      (' '                                  , 10)      +         //073 - 082
                            fPadR      (' '                                  , 06)      +         //083 - 088
                            fPadR      ('00'                                 , 02)      +         //084 - 090
                            fPadR      ('00'                                 , 02)      +         //091 - 092
                            fPadR      (' '                                  , 15)      +         //093 - 107
                            fPadR      (strCodCar                            , 01)      +         //108 - 108
                            fPadR      ('75'                                 , 02)      +         //109 - 110
                            fPadR      (' '                                  ,164)      +         //111 - 274
                            fPadR      (strDupAgr                            , 66)      +         //275 - 340
                            fPadR      (' '                                  , 54)      +         //341 - 394
                            fPadL      (IntToStr(intCodSeq)                  , 06, '0');          //395 - 400

            {**************************************}
            {* ESCREVE A MENSAGEM VARIAVEL NO TXT *}
            {***********************************PZ*}
            Writeln(txtTexto,strMensagem);

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

          Next;
        End;

      End;

      {************}
      {* TRAILLER *}
      {*********AF*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                  + //001 - 001
                     fPadR(' '                , 393)      + //002 - 394
                     fPadL(IntToStr(intCodSeq), 006, '0');  //395 - 400

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
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

procedure TfrmExpArqRemBanestes.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBanestes.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

function TfrmExpArqRemBanestes.fRetEmpresa: String;
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

function TfrmExpArqRemBanestes.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemBanestes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemBanestes.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

function TfrmExpArqRemBanestes.fRetDupAgrupadas(strNumAgr, strCodCli: String): String;
Var
  strSQL   : String;
  strDupAgr: String;
  strInsBar: String;
  intQtdDup: Integer;
  qryAgr   : TUniQuery;
begin

  Try

    Try

      qryAgr := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + 'SELECT   ';
      strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS NUMDUP ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  DUPAGR ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  CTR_NUMAGR = :NUMAGR AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI     ';

      With qryAgr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('NUMAGR').AsString := strNumAgr;
        ParamByName('CODCLI').AsString := strCodCli;

        Open;

        strDupAgr := '';
        intQtdDup := 1;
        strInsBar := 'N';

        While Not Eof Do
        Begin
          {***************************************}
          {* LIMITA A QUANTIDADE DE 7 DUPLICATAS *}
          {* PARA NÃO EXCEDER A QTDE DE CARACTER *}
          {* DISPONÍVEL.(TOTAL = 50)             *}
          {************************************PZ*}
          If (intQtdDup <= 7) Then
          Begin
            If (strInsBar = 'N') Then
            Begin
              strDupAgr := FieldByName('NUMDUP').AsString;
              strInsBar := 'S';
            End
            Else
              strDupAgr := strDupAgr + '/' + FieldByName('NUMDUP').AsString;
          End;

          Inc(intQtdDup);

          Next;
        End;

        Result := strDupAgr;

      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmExpArqRemSantanderBan.fRetDupAgrupadas]');
    End;

  Finally
    FreeAndNil(qryAgr);
  End;

end;

end.
