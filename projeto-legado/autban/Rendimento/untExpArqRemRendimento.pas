unit untExpArqRemRendimento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, System.StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemRendimento = class(TfrmPai)
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
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemRendimento: TfrmExpArqRemRendimento;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemRendimento.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yy',VS_Date),2) +
                         '.TXT';
  pSetFocus(edtCodPor);

end;

function TfrmExpArqRemRendimento.fValidaCampos(Sender: TWinControl;
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
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmExpArqRemRendimento.btnGerarClick(Sender: TObject);
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
    strRespons  : String;
    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    strCodRem   : String;
    strDtaDes   : String;
    strIdeCed   : String;

    fltValDes   : Double;
    intCodSeq   : Integer;
    fltValTot   : Double;
    fltValMora  : Double;
    txtTexto    : TextFile;
    qryRemessa  : TUniQuery;
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

  strCodBco  := '633'; 
  strNomBco  := 'RENDIMENTO';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodAgen := fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'DIAPROT', '');
  strContCor := fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'NUMCTAC', '');
  strRespons := fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'RESPONS', '');
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG633-' + IntToStr(intCartei), 'PROXNUM'), 3);
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'INSTRU2', '');

  strIdeCed  := fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'IDENCED', '');

  Try
    qryConsultaGen := fCriaQuery;

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
    strCartei := 'CONFIG633-' + IntToStr(intCartei) + '-' + VS_strCodEmp;

    qryRemessa := fCriaQuery;

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
      IF fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
        strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';
    END;

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      if (fCfgSis('CONREM', varString) = 'C') THEN
      BEGIN
        IF fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
          ParamByName('CARTEI').AsString := strCartei;
      END;

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
      {******************JU*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001)      + //001 - 001
                   fPadR   ('1'                , 001)      + //002 - 002
                   fPadR   ('REMESSA'          , 007)      + //003 - 009
                   fPadR   ('01'               , 002)      + //010 - 011
                   fPadR   ('COBRANCA'         , 015)      + //012 - 026
                   fPadR   (strIdeCed          , 020)      + //027 - 046
                   fPadR   (strNomEmp          , 030)      + //047 - 076
                   fPadR   (strCodBco          , 003)      + //077 - 079
                   fPadR   (strNomBco          , 015)      + //080 - 094
                   fPadR   (strDtaRem          , 006)      + //095 - 100
                   fPadR   (' '                , 294)      + //101 - 394
                   fPadL   (IntToStr(intCodSeq), 006, '0');  //395 - 400

      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG633-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************JU*}
      With qryRemessa Do
      Begin
        strTransacao := '';
        fltValTot    := 0;

        While Not Eof Do
        Begin

          Inc(intCodSeq);
          Application.ProcessMessages;

          fltValTot := fltValTot + FieldByName('CBI_VALDUP').AsFloat;

          fltValMora := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CBI_PORCEN').AsFloat / 100 ) );

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

          strDtaDes := '000000';
          fltValDes := fStrToFloat(fGetBancoConfig(0, 'CONFIG633', 'DESCONT', ''));

          If fltValDes > 0 Then
          Begin
            fltValDes := (FieldByName('CBI_VALDUP').AsFloat * ( fltValDes / 100 ));
            fltValDes := fFormataFloat(fltValDes, 2);
            strDtaDes := strDtaVen;
          End
          Else
            fltValDes := 0;

          strTransacao := fPadR      ('1'                                  , 01)      + //001 - 001
                          fPadR      ('02'                                 , 02)      + //002 - 003
                          fPadL      (strCgcEmp                            , 14, '0') + //004 - 017
                          fPadR      (strIdeCed                            , 20)      + //018 - 037
                          fPadR      (strKeyDup                            , 25)      + //038 - 062
                          fPadL      (IfThen(strCodCar = '6', FieldByName('CBI_NOSNUM').AsString
                                                         , '0')            , 11, '0') + //063 - 073
                          fPadL      (FieldByName('CBI_NN_CRR').AsString   , 13, '0') + //074 - 086
                          fPadR      (' '                                  , 03)      + //087 - 089
                          fPadR      ('0'                                  , 01)      + //090 - 090
                          fPadL      ('0'                                  , 13, '0') + //091 - 103
                          fPadL      ('00'                                 , 02)      + //104 - 105
                          fPadR      (' '                                  , 02)      + //106 - 107
                          fPadR      (strCodCar                            , 01)      + //108 - 108
                          fPadR      ('01'                                 , 02)      + //109 - 110
                          fPadR      (strKeyDup                            , 10)      + //111 - 120
                          fPadR      (strDtaVen                            , 06)      + //121 - 126
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat    , 13)      + //127 - 139
                          fPadR      (strCodBco                            , 03)      + //140 - 142
                          fPadL      ('0'                                  , 05, '0') + //143 - 147
                          fPadR      ('01'                                 , 02)      + //148 - 149
                          fPadR      ('N'                                  , 01)      + //150 - 150
                          fPadR      (strDtaEmi                            , 06)      + //151 - 156
                          fPadL      (strInstru1                           , 02, '0') + //157 - 158
                          fPadL      (strInstru2                           , 02, '0') + //159 - 160
                          fValNumForm(fltValMora                           , 13)      + //161 - 173
                          fPadR      (strDtaDes                            , 06)      + //174 a 179
                          fValNumForm(fltValDes                            , 13)      + //180 a 192
                          fStrZero   ('0'                                  , 13)      + //193 - 205
                          fStrZero   ('0'                                  , 13)      + //206 - 218
                          fPadL      (strCpfCgc                            , 02, '0') + //219 - 220
                          fPadL      (strCgcCli                            , 14, '0') + //221 - 234
                          fPadR      (FieldByName('CLI_NOMCLI').AsString   , 30)      + //235 - 254
                          fPadR      (' '                                  , 10)      + //265 - 274
                          fPadR      (AstrEndereco                         , 40)      + //275 - 314
                          fPadR      (FieldByName('BAIRRO').AsString       , 12)      + //315 - 326
                          fPadL      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 - 334
                          fPadR      (FieldByName('CIDADE').AsString       , 15)      + //335 - 349
                          fPadR      (FieldByName('ESTADO').AsString       , 02)      + //350 - 351
                          fPadR      (strNomEmp                            , 30)      + //352 - 381
                          fPadR      (' '                                  , 10)      + //382 - 391
                          fPadL      (strDiaPro                            , 02, '0') + //392 - 393
                          fPadL      ('0'                                  , 01)      + //394 - 394
                          fPadL      (IntToStr(intCodSeq)                  , 06, '0');  //395 - 400

          Writeln(txtTexto,strTransacao);

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
      {*********JU*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                            + //001 - 001
                     fPadR      (' '                    , 393)      + //002 - 334
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
      BEGIN
        IF fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
          strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';
      END;

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;

        if (fCfgSis('CONREM', varString) = 'C') THEN
        BEGIN
          IF fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
            ParamByName('CARTEI').AsString := strCartei;
        END;

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

procedure TfrmExpArqRemRendimento.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemRendimento.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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
                     ArrSel,
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

procedure TfrmExpArqRemRendimento.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemRendimento.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
