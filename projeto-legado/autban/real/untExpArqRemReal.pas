unit untExpArqRemReal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus,
  Menus, Buttons, ExtCtrls, StrUtils, Uni, AppEvnts, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, frxClass,
  frxExportCSVTestabilidade, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemReal = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    Label1: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  frmExpArqRemReal: TfrmExpArqRemReal;

implementation

uses untFuncoes, untfuncoesSimples,untFuncAutBan, DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemReal.FormShow(Sender: TObject);
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'ARQ01.TXT';
  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemReal.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemReal.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
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
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmExpArqRemReal.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
    strContCor  : String;
    strDigCnt   : String;
    strCodCar   : String;
//    strDigCar   : String;
    strCpfCgc   : String;
    strCodRem   : String;
    strInstru1  : String;
//    strInstru2  : String;
    strMandMsg  : String;
//    strObsAgru  : String;
    strTipoCob  : String;
    strIdentBc  : String;
    strAgenCob  : String;

    strHeader   : String;
    strTransacao: String;
//    strRegMsg   : String;
    strTrailler : String;
    strExpCodC  : String;

    intCodSeq   : Integer;
    fltTotDup   : Double;
    fltMulAtr   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strRespon   : String;
    qryRemessa  : TUniQuery;

    strDiaProt  : String;
    strCartei : String;
    strAutoIncremRem: String;

    AstrEndereco : String;
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

  {***************************************************}
  {* PEGA OS DADOS DAS CONFGIRACOES DO BANCO         *}
  {************************************************LB*}
  strCodBco  := '356';
  strNomBco  := 'BANCO REAL';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodAgen := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'CODAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt  := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'CODCART', '');
  strMandMsg := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'MANDMSG', '');
  strInstru1 := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'INSTRU1', '');
  strTipoCob := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'TIPCOBR', '');
  strIdentBc := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'IDENTBC', '');
  strExpCodC := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'EXPCODC', '');
  strRespon  := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'RESPONS', '');
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG409', 'RELOCAL', '') = 'N' );
  strAgenCob := strCodAgen + fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'DIGAGEN', '');
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG356-' + IntToStr(intCartei), 'PROXNUM'), 7);
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strDiaProt := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'DIAPROT', '00');
  If (StrToIntDef(strDiaProt, 0) < 3) Or (StrToIntDef(strDiaProt, 0) > 55) Then
    strDiaProt := '99';

  If fEmptyStr(fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'MULATR_', '')) Then
    fltMulAtr := 0
  Else
    fltMulAtr := fStrToFloat(fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'MULATR_', ''));

  strDiaProt := fStrZero(strDiaProt, 2);

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************ED*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);

  If Not fEmptyStr(fCfgSis('NOMCED')) Then
    strNomEmp := fCfgSis('NOMCED');

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

  qryConsultaGen := fCriaQuery(qryConsultaGen);

  {***************************************************}
  {* PEGA DADOS DA EMPRESA                           *}
  {************************************************LB*}
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

  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try
    strCartei := 'CONFIG356-' + IntToStr(intCartei) + '-' + VS_strCodEmp;

    qryRemessa := fCriaQuery(Self);

    {***************************************************}
    {* PEGA OS DADOS DOS CLIENTES P/ GERAR ARQUIVO     *}
    {************************************************LB*}
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
    BEGIN
      IF fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
        strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';
    END;

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
      strSQL := strSQL + '  AND LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0 ';

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      if (fCfgSis('CONREM', varString) = 'C') THEN
      BEGIN
        IF fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
          ParamByName('CARTEI').AsString := strCartei;
      END;

      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      Rewrite(txtTexto);
      fltTotDup := 0;    
      {*************************************************}
      {* HEADER DO ARQUIVO COM REGISTRO E SEM REGISTRO *}
      {**********************************************LB*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                 , 001) + //001 a 001
                   fPadR   ('1REMESSA01COBRANCA', 025) + //002 a 026
                   fPadR   ('0'                 , 001) + //027 a 027
                   fPadR   (strCodAgen          , 004) + //028 a 031
                   fPadR   ('0'                 , 001) + //032 a 032
                   fStrZero(strContCor          , 007) + //033 a 039
                   fPadR   (' '                 , 007) + //040 a 046
                   fPadR   (strNomEmp           , 030) + //047 a 076
                   fPadR   (strCodBco           , 003) + //077 a 079
                   fPadR   (strNomBco           , 015) + //080 a 094
                   fPadR   (strDtaRem           , 006) + //095 a 100
                   fPadR   ('01600BPI'          , 008) + //101 a 108
                   fPadR   (' '                 , 286) + //109 a 394
                   fStrZero(IntToStr(intCodSeq) , 006);  //395 a 400

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************LB*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG356-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************LB*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Inc(intCodSeq);
          Application.ProcessMessages;

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


          {******************************************************}
          {* DETALHE DO ARQUIVO REMESSA / COBRANCA COM REGISTRO *}
          {***************************************************LB*}
          If strTipoCob = 'S' Then
          Begin

            strTransacao := fPadR      ('1'                                     , 01)      + //001 a 001
                            fPadR      ('02'                                    , 02)      + //002 a 003
                            fPadL      (strCgcEmp                               , 14,'0')  + //004 a 017 CNPJ / FILIAL / CONTROLE
                            fStrZero   ('0'                                     , 01)      + //018 a 018
                            fStrZero   (strCodAgen                              , 04)      + //019 a 022
                            fStrZero   ('0'                                     , 01)      + //023 a 023
                            fStrZero   (strContCor                              , 07)      + //024 a 030
                            fPadR      (' '                                     , 07)      + //031 a 037
                            fPadR      (strKeyDup                               , 25)      + //038 a 062
                            fStrZero   ('00'                                    , 02)      + //063 a 064
                            fPadR      (IfThen(strRespon = 'B', fStrZero('0', 07),
                            RightStr   (FieldByName('CBI_NOSNUM').AsString, 07)), 07)      + //065 a 071
                            fStrZero   ('0'                                     , 01)      + //072 a 072
                            fStrZero   ('00'                                    , 02)      + //073 a 074
                            fStrZero   ('1'                                     , 01)      + //075 a 075
                            fValNumForm(fltMulAtr                               , 13)      + //076 a 088
                            fPadR      (' '                                     , 07)      + //089 a 095
                            fStrZero   (strIdentBc                              , 09)      + //096 a 104
                            fPadR      (' '                                     , 01)      + //105 a 105
                            fStrZero   (IfThen(strExpCodC='N','00',strCodCar)   , 02)      + //106 a 107
                            fPadR      ('5'                                     , 01)      + //108 a 108
                            fPadR      ('01'                                    , 02)      + //109 a 110
                            fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                                 FieldByName('CBI_PARCEL').AsString, 10), 10) + //111 a 120
                            fPadR      (strDtaVen                               , 06)      + //121 a 126
                            fValNumForm(FieldByName('CBI_VALDUP').AsFloat       , 13)      + //127 a 139
                            fPadR      (strCodBco                               , 03)      + //140 a 142
                            fStrZero   ('0'                                     , 05)      + //143 a 147
                            fStrZero   ('01'                                    , 02)      + //148 a 149
                            fPadR      ('N'                                     , 01)      + //150 a 150
                            fPadR      (strDtaEmi                               , 06)      + //151 a 156
                            fStrZero   (strDiaProt                              , 02)      + //157 a 158
                            fPadR      (' '                                     , 02)      + //159 a 160
                            fStrZero   ('0'                                     , 01)      + //161 a 161
                            fValNumForm(((FieldByName('CBI_PORCEN').AsFloat *
                                         FieldByName('CBI_VALDUP').AsFloat)/100), 12)      + //162 a 173
                            fStrZero   ('0'                                     , 06)      + //174 a 179
                            fStrZero   ('0'                                     , 13)      + //180 a 192
                            fStrZero   ('0'                                     , 13)      + //193 a 205
                            fStrZero   ('0'                                     , 13)      + //206 a 218
                            fStrZero   (strCpfCgc                               , 02);       //219 a 220

                            {***************************************************}
                            {* SE FOR CPF DO CLIENTE                           *}
                            {************************************************LB*}
                            If strCpfCgc = '1' Then
                            Begin
                              strTransacao := strTransacao +
                                              fPadL    (LeftStr(strCgcCli,9)    , 09)      + //221 a 229
                                              fStrZero ('000'                   , 03)      + //230 a 232
                                              fPadL    (RightStr(strCgcCli,2)   , 02);       //233 a 234
                            End
                            Else
                            Begin
                              strTransacao := strTransacao +
                                              fPadL    (strCgcCli               , 14);       //221 a 234
                            End;


                            strTransacao := strTransacao +
                            fPadR      (FieldByName('CLI_NOMCLI').AsString      , 40)      + //235 a 274
                            fPadR      (AstrEndereco                            , 40)      + //275 a 314
                            fPadR      (FieldByName('BAIRRO').AsString          , 12)      + //315 a 326
                            fPadR      (FieldByName('C_E_P_').AsString          , 08)      + //327 a 334 CEP e COMPLEMENTO
                            fPadR      (FieldByName('CIDADE').AsString          , 15)      + //335 a 349
                            fPadR      (FieldByName('ESTADO').AsString          , 02)      + //350 a 351
                            fPadR      (strNomEmp                               , 40)      + //352 a 391
                            fPadR      ('0'                                     , 01)      + //392 a 392
                            fPadR      ('07'                                    , 02)      + //393 a 394
                            fStrZero   (IntToStr(intCodSeq)                     , 06);       //395 a 400

            fltTotDup := fltTotDup + FieldByName('CBI_VALDUP').AsFloat;
            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************LB*}
            Writeln(txtTexto,strTransacao);
          End
          Else
          Begin

            {******************************************************}
            {* DETALHE DO ARQUIVO REMESSA / COBRANCA SEM REGISTRO *}
            {***************************************************LB*}
            strTransacao := fPadR      ('1'                                     , 01)      + //001 a 001
                            fPadR      ('02'                                    , 02)      + //002 a 003
                            fPadL      (strCgcEmp                               , 14,'0')  + //004 a 017 CNPJ / FILIAL / CONTROLE
                            fStrZero   ('0'                                     , 01)      + //018 a 018
                            fStrZero   (strCodAgen                              , 04)      + //019 a 022
                            fStrZero   ('0'                                     , 01)      + //023 a 023
                            fStrZero   (strContCor                              , 07)      + //024 a 030
                            fPadR      (' '                                     , 32)      + //031 a 062
                            fStrZero   ('00'                                    , 02)      + //063 a 064
                            fPadL      (Copy(strKeyDup,1,12)                    , 13,'0')  + //065 a 077
                            fPadR      (' '                                     , 31)      + //078 a 108
                            fStrZero   ('01'                                    , 02)      + //109 a 110
                            fPadR      (' '                                     , 10)      + //111 a 120
                            fPadR      (strDtaVen                               , 06)      + //121 a 126
                            fValNumForm(FieldByName('CBI_VALDUP').AsFloat       , 13)      + //127 a 139
                            fPadR      (strCodBco                               , 03)      + //140 a 142
                            fPadR      (' '                                     , 05)      + //143 a 147
                            fStrZero   ('01'                                    , 02)      + //148 a 149
                            fPadR      (' '                                     , 01)      + //150 a 150
                            fPadR      (strDtaEmi                               , 06)      + //151 a 156
                            fStrZero   ('0'                                     , 04)      + //157 a 160
                            fStrZero   ('0'                                     , 13)      + //161 a 173
                            fStrZero   ('0'                                     , 06)      + //174 a 179
                            fStrZero   ('0'                                     , 13)      + //180 a 192
                            fStrZero   ('0'                                     , 13)      + //193 a 205
                            fStrZero   ('0'                                     , 13)      + //206 a 218
                            fStrZero   (strCpfCgc                               , 02);       //219 a 220

                            {***************************************************}
                            {* SE FOR CPF DO CLIENTE                           *}
                            {************************************************LB*}
                            If strCpfCgc = '1' Then
                            Begin
                              strTransacao := strTransacao +
                                              fPadL    (LeftStr(strCgcCli,9)    , 09)      + //221 a 229
                                              fStrZero ('000'                   , 03)      + //230 a 232
                                              fPadL    (RightStr(strCgcCli,2)   , 02);       //233 a 234
                            End
                            Else
                            Begin
                              strTransacao := strTransacao +
                                              fPadL    (strCgcCli               , 14);       //221 a 234
                            End;

                            strTransacao := strTransacao +
                            fPadR      (FieldByName('CLI_NOMCLI').AsString      , 40)      + //235 a 274
                            fPadR      (AstrEndereco                            , 40)      + //275 a 314
                            fPadR      (FieldByName('BAIRRO').AsString          , 12)      + //315 a 326
                            fPadR      (FieldByName('C_E_P_').AsString          , 08)      + //327 a 334 CEP e COMPLEMENTO
                            fPadR      (FieldByName('CIDADE').AsString          , 15)      + //335 a 349
                            fPadR      (FieldByName('ESTADO').AsString          , 02)      + //350 a 351
                            fPadR      (strNomEmp                               , 40)      + //352 a 391
                            fPadR      (' '                                     , 01)      + //392 a 392
                            fPadR      ('7'                                     , 01)      + //393 a 393
                            fPadR      ('7'                                     , 01)      + //394 a 394
                            fStrZero   (IntToStr(intCodSeq)                     , 06);       //395 a 400

            fltTotDup := fltTotDup + FieldByName('CBI_VALDUP').AsFloat;
            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************LB*}
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

          {****************}
          {* GRAVA LOGCTR *}
          {*************JS*}
          untLogCtr.GravaLogCtr(qryRemessa.FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - ' + strCodBco, Self.Name);

          Next;
        End;
      End;




      //*************************************************//
      // ESSA ROTINA ABAIXO EH USADA, QUANDO NO REGISTRO //
      // ANTERIOR, FOI INFORMADO Q HAVERA CODIGO DE MENS //
      // ENTAO DEVE SE REPETIR O NUMERO DA DUPLICATA E   //
      // A RESPECTIVA MENSAGEM                           //
      //**********************************************ED*//
  (*
      If emitemensagem Then
      Begin

        With frmModulo SPR.qryGen005 Do
        Begin

          First;

          While Not Eof Do
          Begin

            {***************************************************}
            {* REG. MENSAGENS P/ TIPO DE COBRANCA COM REGISTRO *}
            {************************************************LB*}
            Inc(intCodSeq);
            If strTipoCob = 'S' Then
            Begin
              strRegMsg := '';

              strRegMsg :=  fPadR   ('8'                  , 01) + //001 a 001
                            fPadR   ('1'                  , 01) + //002 a 002
                            fStrZero('0'                  , 01) + //003 a 003
                            fPadR   (strCodAgen           , 04) + //004 a 007
                            fStrZero('0'                  , 01) + //008 a 008
                            fStrZero(strContCor           , 07) + //009 a 015
                            fPadR   (strContCor           , 10) + //016 a 025
                            fPadR   (' '                  , 69) + //026 a 094
                            fPadR   (' '                  , 01) + //095 a 095
                            fPadR   (' '                  , 69) + //096 a 164
                            fPadR   (' '                  , 01) + //165 a 165
                            fPadR   (' '                  , 69) + //166 a 234
                            fPadR   (' '                  , 01) + //235 a 235
                            fPadR   (' '                  , 69) + //236 a 304
                            fPadR   (' '                  , 01) + //305 a 305
                            fPadR   (' '                  , 69) + //306 a 374
                            fPadR   (' '                  , 01) + //375 a 375
                            fPadR   (' '                  , 19) + //376 a 394
                            fStrZero(IntToStr(intCodSeq)  , 06);  //395 a 400

            End
            Else
            Begin
              {***************************************************}
              {* REG. MENSAGENS P/ TIPO DE COBRANCA SEM REGISTRO *}
              {************************************************LB*}
              strRegMsg := '';

              strRegMsg :=  fPadR   ('7'                  , 01) + //001 a 001
                            fPadR   ('1'                  , 01) + //002 a 002
                            fPadR   (strCodAgen           , 04) + //003 a 006
                            fStrZero(strContCor           , 07) + //007 a 013
                            fStrZero('00'                 , 02) + //014 a 015
                            fPadR   (' '                  , 13) + //016 a 028
                            fPadR   (' '                  , 69) + //029 a 097
                            fPadR   (' '                  , 01) + //098 a 098
                            fPadR   (' '                  , 69) + //099 a 167
                            fPadR   (' '                  , 01) + //168 a 168
                            fPadR   (' '                  , 69) + //169 a 237
                            fPadR   (' '                  , 01) + //238 a 238
                            fPadR   (' '                  , 69) + //239 a 307
                            fPadR   (' '                  , 01) + //308 a 308
                            fPadR   (' '                  , 69) + //309 a 377
                            fPadR   (' '                  , 01) + //378 a 378
                            fPadR   (' '                  , 16) + //379 a 394
                            fStrZero(IntToStr(intCodSeq)  , 06);  //395 a 400


            End;

            {******************************}
            {* ESCREVE O REG. MSG NO TXT  *}
            {***************************LB*}
            Writeln(txtTexto,strRegMsg );
            Next;

          End;
        End;
      End;
      *)



      {******************************************************}
      {* TRAILLER  / COBRANCA COM REGISTRO E SEM REGISTRO   *}
      {***************************************************LB*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                       + //001 a 001
                     fStrZero   (IntToStr(intCodSeq - 2), 006) + //002 a 007
                     fValNumForm(fltTotDup              , 013) + //008 a 020
                     fPadR      (' '                    , 374) + //021 a 394
                     fStrZero   (IntToStr(intCodSeq)    , 006);  //395 a 400

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************LB*}
      Writeln(txtTexto,strTrailler);
      CloseFile(txtTexto);


      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

      {****************************************************}
      {* DELETA AS DUPL. DO CADCBI REFERENTE AO COD. BANCO*}
      {*************************************************LB*}
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CADCBI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';

      If (Not fEmptyStr(edtCodPor.Text)) Then
        strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

      if (fCfgSis('CONREM', varString) = 'C') THEN
      BEGIN
        IF fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
          strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';
      END;

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;

        If (Not fEmptyStr(edtCodPor.Text)) Then
          ParamByName('CODPOR').AsString := edtCodPor.Text;

        if (fCfgSis('CONREM', varString) = 'C') THEN
        BEGIN
          IF fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
            ParamByName('CARTEI').AsString := strCartei;
        END;

        ExecSQL;
        Close;
      End;

    End
    Else
    Begin
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

    FreeAndNil(qryRemessa);
	Except
		On E: Exception Do
		Begin

		  fRollBack;
      CloseFile(txtTexto);
      DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);
      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;

end;


function TfrmExpArqRemReal.fRetEmpresa: String;
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

function TfrmExpArqRemReal.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemReal.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
