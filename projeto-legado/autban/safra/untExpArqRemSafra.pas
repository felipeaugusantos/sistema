unit untExpArqRemSafra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, System.DateUtils,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, frxClass,
  frxExportCSVTestabilidade, untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa;

type
  TfrmExpArqRemSafra = class(TfrmPai)
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
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemSafra: TfrmExpArqRemSafra;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untPesqAux, untConsultas,
     untTypesSistema, untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemSafra.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yy',VS_Date),2) +
                         '.TXT';
  pSetFocus(edtCodPor);

end;

function TfrmExpArqRemSafra.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemSafra.btnGerarClick(Sender: TObject);
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
    strKeyAux   : String;  //*****APENAS PRA HOMOLOGAR*****
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
    strCodCar   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strInstru2  : String;
    strRespons  : String;
    strNossNum  : String;
    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    strCodRem   : String;
    strDtaDes   : String;
    strNumDoc   : String;
    strPerMul   : String;
    strMailPag  : String;
    strNomBen   : String;
    strCnpjBen  : String;
    strEndBen   : String;
    strBaiBen   : String;
    strCidBen   : String;
    strCEPBen   : String;
    strEstBen   : String;
    strDadosParaMulta: String;
    dtaDataMulta: TDateTime;
    strDataMulta: String;
    blnTemMulta : Boolean;

    fltValDes   : Double;
    intCodSeq   : Integer;
    intQtdTot   : Integer;
    fltValTot   : Double;
    fltValMora  : Double;
    txtTexto    : TextFile;
    qryRemessa  : TUniQuery;
    strCartei : String;
    strAutoIncremRem: String;
    blnParNum : Boolean;

    strchkcbEmp : String;
    AstrEndereco    : String;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  strCodBco  := '422'; 
  strNomBco  := 'SAFRA';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodAgen := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'DIAPROT', '');
  strContCor := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'NUMCTAC', '');
  strRespons := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'RESPONS', '');
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG422-' + IntToStr(intCartei), 'PROXNUM'), 3);
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  blnParNum  := (Trim(fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'PARCNUM', '')) = 'S') And (fCfgSis('PARNUM') = 'S');

  strInstru1 := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'INSTRU2', '');
  strPerMul  := FormatFloat('#,##0.00', fStrToFloat(fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'PERMULT', '')));
  blnTemMulta := False;

  Try
    qryConsultaGen := fCriaQuery;

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
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      strNomBen := fPadR(strNomEmp, 040);
      strCnpjBen:= fPadL(fTiraCaracEspeciaisPonto(strCgcEmp), 014, '0');
      strEndBen := fPadR(FieldByName('EMP_ENDERE').AsString + ', ' +
                          FieldByName('EMP_ENDNUM').AsString, 040);
      strBaiBen := fPadR(FieldByName('EMP_BAIRRO').AsString, 015);
      strCidBen := fPadR(FieldByName('CID_NOMCID').AsString, 020);
      strCEPBen := fPadR(fRetSomenteNumeros(FieldByName('EMP_C_E_P_').AsString), 008, '0');
      strEstBen := fPadR(FieldByName('CID_ESTADO').AsString, 002);
      Close;
    End;

  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try
    strCartei := 'CONFIG422-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  C.CLI_EMCOB1, C.CLI_EMCOB2, C.CLI_EMAIL_, C.CLI_EMAIL2, C.CLI_EMAIL3, ';
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

      if (fCfgSis('CONREM', varString) = 'C') THEN
        ParamByName('CARTEI').AsString := strCartei;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001)      + //001 - 001
                   fPadR   ('1'                , 001)      + //002 - 002
                   fPadR   ('REMESSA'          , 007)      + //003 - 009
                   fPadR   ('01'               , 002)      + //010 - 011
                   fPadR   ('COBRANCA'         , 008)      + //012 - 019
                   fPadR   (' '                , 007)      + //020 - 026
                   fPadL   (strCodAgen         , 005, '0') + //027 - 031
                   fPadL   (strContCor         , 009, '0') + //032 - 040
                   fPadL   (' '                , 006)      + //041 - 046
                   fPadR   (strNomEmp          , 030)      + //047 - 076
                   fPadR   (strCodBco          , 003)      + //077 - 079
                   fPadR   (strNomBco          , 011)      + //080 - 090
                   fPadR   (' '                , 004)      + //091 - 094
                   fPadR   (strDtaRem          , 006)      + //095 - 100
                   fPadR   (' '                , 291)      + //101 - 391
                   fPadR   (strCodRem          , 003)      + //392 - 394
                   fPadL   (IntToStr(intCodSeq), 006, '0');  //395 - 400

      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG422-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      With qryRemessa Do
      Begin
        strTransacao := '';
        intQtdTot    := 0;
        fltValTot    := 0;

        While Not Eof Do
        Begin

          strInstru1 := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'INSTRU1', '');
          strInstru2 := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'INSTRU2', '');


          Inc(intCodSeq);
          Application.ProcessMessages;

          Inc(intQtdTot);
          fltValTot := fltValTot + FieldByName('CBI_VALDUP').AsFloat;

          fltValMora := fFormataFloat(((FieldByName('CBI_VALDUP').AsFloat ) * (FieldByName('CBI_PORCEN').AsFloat / 100)),2);

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '02'
          Else
            strCpfCgc := '01';

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          If (fStrToFloat(strPerMul) > 0) And (trim(strInstru1) = '16') Then
          Begin
            blnTemMulta := True;
            dtaDataMulta := IncDay(FieldByName('CBI_DTAVEN').AsDateTime, 1);
            strDataMulta := FormatDateTime('dd', dtaDataMulta) +
                            FormatDateTime('mm', dtaDataMulta) +
                            FormatDateTime('yy', dtaDataMulta);
            strDadosParaMulta := strDataMulta +  fValNumForm(fStrToFloat(strPerMul), 4) + '000';
          End;

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

          If blnParNum Then
            strKeyAux := RightStr(FieldByName('CBI_NUMDUP').AsString +
                                  fPadL(fRetNumParcela(FieldByName('CBI_PARCEL').AsString),003,'0'), 10)
          Else
            strKeyAux := RightStr(FieldByName('CBI_NUMDUP').AsString +
                                  FieldByName('CBI_PARCEL').AsString, 10);

          strNumDoc := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                       FieldByName('CBI_PARCEL').AsString;
          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          strNossNum := FieldByName('CBI_NOSNUM').AsString;

          strDtaDes := '000000';
          fltValDes := fStrToFloat(fGetBancoConfig(0, 'CONFIG422', 'DESCONT', ''));

          If fltValDes > 0 Then
          Begin
            fltValDes := (FieldByName('CBI_VALDUP').AsFloat * ( fltValDes / 100 ));
            fltValDes := fFormataFloat(fltValDes, 2);
            strDtaDes := strDtaVen;
          End
          Else
            fltValDes := 0;

          If fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'CORBRAD', '') = 'S' Then
            strCodBco := '237';

          If (fltValMora = 0) Then
          Begin
            If strInstru1.Equals('01') Then
              strInstru1 := '00';

            If strInstru2.Equals('01') Then
              strInstru2 := '00';
          End;

          strTransacao := fPadR      ('1'                                     , 01)      + //001 - 001
                          fPadR      ('02'                                    , 02)      + //002 - 003
                          fPadL      (strCgcEmp                               , 14, '0') + //004 - 017
                          fPadL      (strCodAgen                              , 05, '0') + //018 - 022
                          fPadL      (strContCor                              , 09, '0') + //023 - 031
                          fPadL      (' '                                     , 06, ' ') + //032 - 037
                          fPadR      (strKeyDup                               , 25, ' ') + //038 - 062
                          fPadL      (strNossNum                              , 09, '0') + //063 - 071
                          fPadR      (' '                                     , 30)      + //072 - 101
                          fStrZero   ('0'                                     , 01)      + //102 - 102
                          fPadR      ('00'                                    , 02)      + //103 - 104
                          fPadR      (' '                                     , 01)      + //105 - 105
                          fPadR      (IIF(strInstru2 = '10',strDiaPro,'00')   , 02)      + //106 - 107
                          fPadR      (strCodCar                               , 01)      + //108 - 108
                          fPadR      ('01'                                    , 02)      + //109 - 110
                          //fPadL      (strNumDoc                               , 10, ' ') + //111 - 120
                          fPadR      (strKeyAux                               , 10)      + //111 - 120
                          fPadR      (strDtaVen                               , 06)      + //121 - 126
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat       , 13)      + //127 - 139
                          fPadR      (strCodBco                               , 03)      + //140 - 142
                          fPadL      (strCodAgen                              , 05, '0') + //143 - 147
                          fPadR      ('01'                                    , 02)      + //148 - 149
                          fPadR      ('N'                                     , 01)      + //150 - 150
                          fPadR      (strDtaEmi                               , 06)      + //151 - 156
                          fPadL      (strInstru1                              , 02, '0') + //157 - 158
                          fPadL      (strInstru2                              , 02, '0') + //159 - 160
                          fValNumForm(fltValMora                              , 13)      + //161 - 173
                          fPadR      (strDtaDes                               , 06)      + //174 a 179
                          fValNumForm(fltValDes                               , 13)      + //180 a 192
                          fStrZero   ('0'                                     , 13)      + //193 - 205
                          fPadL      (IIF(blnTemMulta, strDadosParaMulta, '0'), 13, '0') + //206 - 218
                          fPadL      (strCpfCgc                               , 02, '0') + //219 - 220
                          fPadL      (strCgcCli                               , 14, '0') + //221 - 234
                          fPadR      (FieldByName('CLI_NOMCLI').AsString      , 40)      + //235 - 274
                          fPadR      (AstrEndereco                            , 40)      + //275 - 314
                          fPadR      (FieldByName('BAIRRO').AsString          , 10)      + //315 - 324
                          fPadR      (' '                                     , 02)      + //325 - 326
                          fPadL      (FieldByName('C_E_P_').AsString          , 08, '0') + //327 - 334
                          fPadR      (FieldByName('CIDADE').AsString          , 15)      + //335 - 349
                          fPadR      (FieldByName('ESTADO').AsString          , 02)      + //350 - 351
                          fPadR      (' '                                     , 30)      + //352 - 381
                          fPadR      (' '                                     , 07)      + //382 - 388
                          fPadR      (strCodBco                               , 03)      + //389 - 391
                          fPadL      (strCodRem                               , 03, '0') + //392 - 394
                          fPadL      (IntToStr(intCodSeq)                     , 06, '0');  //395 - 400

          Writeln(txtTexto,strTransacao);

          strMailPag := fRetornaEmailCliente(qryRemessa);

          If (strRespons='B') And (Not fEmptyStr(strMailPag)) Then
          Begin
            Inc(intCodSeq);
            Application.ProcessMessages;

            strTransacao := fPadR      ('2'                                     , 01)      + //001 - 001
                            fPadR      (strMailPag                              , 50)      + //002 - 051
                            fPadL      (' '                                     ,100, ' ') + //052 - 151
                            fPadR      (strNomBen                               , 40, ' ') + //152 - 191
                            fPadR      ('1'                                     , 01)      + //192 - 192
                            fPadR      (strCnpjBen                              , 14, '0') + //192 - 206
                            fPadR      (strEndBen                               , 40, ' ') + //207 - 246
                            fPadR      (strBaiBen                               , 15, ' ') + //247 - 261
                            fPadR      (strCidBen                               , 20, ' ') + //262 - 281
                            fPadR      (strCEPBen                               , 08, '0') + //282 - 289
                            fPadR      (strEstBen                               , 02)      + //290 - 291
                            fPadR      (' '                                     ,100)      + //292 - 391
                            fPadL      (strCodRem                               , 03, '0') + //392 - 394
                            fPadL      (IntToStr(intCodSeq)                     , 06, '0');  //395 - 400

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

      {************}
      {* TRAILLER *}
      {*********AF*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                            + //001 - 001
                     fPadR      (' '                    , 367)      + //002 - 368
                     fPadL      (IntToStr(intQtdTot)    , 008, '0') + //369 - 376
                     fValNumForm(fltValTot              , 015)      + //377 - 391
                     fPadR      (strCodRem              , 003)      + //392 - 394
                     fPadL      (IntToStr(intCodSeq)    , 006, '0');  //395 - 400

      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      pBackupCnfBco;

      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CADCBI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';

      If (Not fEmptyStr(edtCodPor.Text)) Then
        strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

      if (fCfgSis('CONREM', varString) = 'C') THEN
        strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := '422';

        if (fCfgSis('CONREM', varString) = 'C') THEN
          ParamByName('CARTEI').AsString := strCartei;

        If (Not fEmptyStr(edtCodPor.Text)) Then
          ParamByName('CODPOR').AsString := edtCodPor.Text;

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

      Try
        CloseFile(txtTexto);
      Except
        //Caso o erro acontecer após o arquivo já estiver fechado
      End;

      If FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) Then
        DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);

      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;

end;

procedure TfrmExpArqRemSafra.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemSafra.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrPortador: TConsultasArray;
begin
  inherited;
    If fPesqPortador(conSimples,
                     Self,
                     edtCodPor,
                     TEditFocus(edtDesPor),
                     nil,
                     Key,
                     arrPortador,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     '',
                     False,
                     True) then
    If fValidaCampos(edtCodPor) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmExpArqRemSafra.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemSafra.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
