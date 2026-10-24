unit untExpArqRemABCBrasil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemABCBrasil = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    Label1: TLabel;
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
  frmExpArqRemABCBrasil: TfrmExpArqRemABCBrasil;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, DB, untTypesSistema, untConsultas,
     untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemABCBrasil.FormShow(Sender: TObject);
begin
  inherited;
  
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := fStrZero(fGetBancoProxNum('CONFIG246-' + IntToStr(intCartei)), 7) +
                         '.TXT';
  pSetFocus(edtCodPor);

end;

function TfrmExpArqRemABCBrasil.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemABCBrasil.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaMor   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodCar   : String;
    strCodCarRem: String;
    strCpfCgc   : String;
    strCodRem   : String;
    strInstru1  : String;
    strInstru2  : String;
    strDiaPro   : String;
    strCep      : String;
    strIdeBco   : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    qryRemessa  : TUniQuery;
    strCartei: String;
    strAutoIncremRem: String;

    AstrEndereco    : String;

    strTpMulta     : String;
    fltValMulta    : Double;
    strValMulta    : String;
    strDiaMora     : String;
    strOcorr       : string;

    strCfgValMulta : String;

    strNota        : string;
    strMensagem    : string;
    strRespEmp     : string;

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

  strCodBco    := '246';
  strNomBco    := 'BCO ABC BRASIL';
  strNomEmp    := fRetNomeEmpresa(VS_strCodEmp);
  strIdeBco    := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'IDENTBC', '');
  strCodCar    := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'CODCART', '');
  strCodCarRem := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'CODCARR', '');
  strInstru1   := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'INSTRU1', '');
  strDiaPro    := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'DIAPROT', '');
  strDtaRem    := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strTpMulta   := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'TPMULTA', '0');
  //fltValMulta  := StrToFloat(fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'VALMULT', '0'));

  strCfgValMulta := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'VALMULT', '0');
  strDiaMora     := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'DIAMORA', '0');
  strRespEmp     := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'RESPONS', 'E');

  if strCfgValMulta <> '' then
     fltValMulta  := StrToFloat(strCfgValMulta)
  Else
     fltValMulta  := 0;

  If strTpMulta = '0' Then
  Begin
     fltValMulta := 0;
     strDiaMora  := '0';
  End;

  If strTpMulta = '2' Then
  Begin
     fltValMulta := fFormataFloat( fltValMulta, 4);
     strValMulta := Formatfloat('###,###,##0.0000',fltValMulta)
  End
  Else
  Begin
     fltValMulta := fFormataFloat( fltValMulta, 2);
     strValMulta := Formatfloat('###,###,##0.00',fltValMulta)
  End;

  strValMulta := AnsiReplaceStr(strValMulta, '.', '');
  strValMulta := AnsiReplaceStr(strValMulta, ',', '');

  strOcorr    := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'CODOCOR', '01');

  strNovCodEmp := VS_strCodEmp;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);

  If Not fEmptyStr(fCfgSis('NOMCED')) Then
    strNomEmp := fCfgSis('NOMCED');

  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************JU*//
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try

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

  Finally
    FreeAndNil(qryConsultaGen);
  ENd;

  Try
    strCartei  := 'CONFIG246-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  G.GER_DTADOC, ';
    strSQL := strSQL + '  G.GER_NUMDOC, ';
    strSQL := strSQL + '  G.GER_SERIE_, ';
    strSQL := strSQL + '  L.NFE_ACESSO, ';
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
    strSQL := strSQL + '  CADCBI B ';
    strSQL := strSQL + '  JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI              ';
    strSQL := strSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND          ';
    strSQL := strSQL + '                   CTR_PARCEL = CBI_PARCEL AND          ';
    strSQL := strSQL + '                   CTR_ESPDOC = CBI_ESPDOC AND          ';
    strSQL := strSQL + '                   CTR_CODEMP = CBI_CODEMP AND          ';
    strSQL := strSQL + '                   CTR_CODCLI = CBI_CODCLI              ';
    strSQL := strSQL + '  LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                        L.NFE_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                        L.NFE_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                        L.NFE_CODCLI = B.CBI_CODCLI AND ';
    strSQL := strSQL + '                        L.NFE_TIP_FC = "C"              ';
    strSQL := strSQL + '  LEFT JOIN CTRCNF F ON F.CTR_DOCCNF = R.CTR_NUMDUP AND ';
    strSQL := strSQL + '                        F.CTR_ESPCNF = R.CTR_ESPDOC AND ';
    strSQL := strSQL + '                        F.CTR_EMPCNF = R.CTR_CODEMP AND ';
    strSQL := strSQL + '                        F.CTR_CODCLI = R.CTR_CODCLI     ';
    strSQL := strSQL + '  LEFT JOIN MOVGER G ON G.GER_NUMDOC = R.CTR_NUMDUP AND ';
    strSQL := strSQL + '                        G.GER_ESPDOC = R.CTR_ESPDOC AND ';
    strSQL := strSQL + '                        G.GER_CODEMP = R.CTR_CODEMP AND ';
    strSQL := strSQL + '                        G.GER_CODCLI = R.CTR_CODCLI     ';
    strSQL := strSQL + '  WHERE                                                 ';
    strSQL := strSQL + '    CBI_CODBCO = :CODBCO AND                            ';
    strSQL := strSQL + '    R.CTR_DTAREC IS NULL                                ';

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

      if (fCfgSis('CONREM', varString) = 'C') then
         ParamByName('CARTEI').AsString := strCartei;

      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      strCodRem    := fStrZero(fAtuCodSeq('CONFIG246-' + IntToStr(intCartei),'PROXNUM'), 7);
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************JU*}
      intCodSeq := 1;
      strHeader := '';

      strHeader := fPadR   ('0'                , 001) + //001
                   fPadR   ('1'                , 001) + //002
                   fPadR   ('REMESSA'          , 007) + //003
                   fPadR   ('01'               , 002) + //010
                   fPadR   ('COBRANCA'         , 015) + //012
                   fPadR   (strIdeBco          , 020) + //027
                   fPadR   (strNomEmp          , 030) + //047
                   fPadR   (strCodBco          , 003) + //077
                   fPadR   (strNomBco          , 015) + //080
                   fPadR   (strDtaRem          , 006) + //095
                   fPadR   (' '                , 294) + //101
                   fStrZero(IntToStr(intCodSeq), 006);  //395

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************JU*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG246-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************JU*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Inc(intCodSeq);
          Application.ProcessMessages;

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          strInstru1 := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'INSTRU1', '');
          strInstru2 := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'INSTRU2', '');

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaMor := FormatDateTime('ddmmyy', FieldByName('CBI_DTAVEN').AsDateTime+1);

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

          strCep := Trim(FieldByName('C_E_P_').AsString);
          strCep := AnsiReplaceStr(strCep, '-', '');

          strTransacao := fPadR      ('1'                                                                    , 01)      + //001
                          fPadR      ('02'                                                                   , 02)      + //002
                          fPadL      (strCgcEmp                                                              , 14, '0') + //004
                          fPadR      (strIdeBco                                                              , 20)      + //018
                          fPadR      (strKeyDup                                                              , 25)      + //038
                          fPadR      (fStrZero(qryRemessa.FieldByName('CBI_NOSNUM').AsString,11)             , 11, '0') + //063
                          fPadR      (' '                                                                    , 13, ' ') + //074
                          fPadR      (' '                                                                    , 03)      + //087
                          fPadR      (strTpMulta                                                             , 01)      + //090
                          fPadR      (fStrZero(strValMulta,13)                                               , 13, '0') +
                          fPadR      (fStrZero(strDiaMora,2)                                                 , 02, '0') + //104
                          fPadR      (' '                                                                    , 02)      + //106
                          fPadR      ( IIF(strCodCarRem <> '', strCodCarRem, strCodCar)                      , 01)      + //108
                          fPadR      (strOcorr                                                               , 02)      + //109
                          fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                               FieldByName('CBI_PARCEL').AsString                            , 10), 10) + //111
                          fPadR      (strDtaVen                                                              , 06)      + //121
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat                                      , 13)      + //127
                          fPadR      (strCodBco                                                              , 03)      + //140
                          fStrZero   ('0'                                                                    , 04)      + //146
                          fPadR      ('0'                                                                    , 01)      + //150
                          fPadR      ('01'                                                                   , 02)      + //151
                          fPadR      ('N'                                                                    , 01)      + //153
                          fPadR      (strDtaEmi                                                              , 06)      + //151
                          fPadR      (strInstru1                                                             , 02)      + //157
                          fPadR      (strInstru2                                                             , 02)      + //159
                          fValNumForm(fltValAtr                                                              , 13)      + //161
                          fStrZero   ('0'                                                                    , 06)      + //174
                          fStrZero   ('0'                                                                    , 13)      + //180
                          fStrZero   ('0'                                                                    , 13)      + //193
                          fStrZero   ('0'                                                                    , 13)      + //206
                          fStrZero   (strCpfCgc                                                              , 02)      + //219
                          fPadL      (strCgcCli                                                              , 14, '0') + //221
                          fPadR      (FieldByName('CLI_NOMCLI').AsString                                     , 30)      + //235
                          fPadR      (' '                                                                    , 10)      + //265
                          fPadR      (AstrEndereco                                                           , 40)      + //275
                          fPadR      (FieldByName('BAIRRO').AsString                                         , 12)      + //315
                          fPadR      (strCep                                                                 , 08, '0') + //327
                          fPadR      (FieldByName('CIDADE').AsString                                         , 15)      + //335
                          fPadR      (FieldByName('ESTADO').AsString                                         , 02)      + //350
                          fPadR      ( IIF(strRespEmp = 'B', strNomEmp, ' ')                                 , 30)      + //352
                          fPadR      (' '                                                                    , 04)      + //382
                          fPadR      (' '                                                                    , 06)      + //386
                          fStrZero   (strDiaPro                                                              , 02)      + //392
                          fPadR      ('0'                                                                    , 01)      + //394
                          fStrZero   (IntToStr(intCodSeq)                                                    , 06);       //395


          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************JU*}
          Writeln(txtTexto,fRetirarCaracteresEspeciais(strTransacao));

          {************************************************}
          {* ESCREVE O REGISTRO DE NOTA FISCAL ELETRONICA *}
          {************************************************}
          If Not fEmptyStr(qryRemessa.FieldByName('NFE_ACESSO').AsString) Then
          Begin
            Inc(intCodSeq);

            strNota   := qryRemessa.FieldByName('GER_NUMDOC').AsString + '-' + qryRemessa.FieldByName('GER_SERIE_').AsString;
            strDtaEmi := FormatDateTime('ddmmyyyy', qryRemessa.FieldByName('GER_DTADOC').AsDateTime);

            strMensagem  := fPadR   ('4'                                                       , 001)      + // 001 - 001
                            fPadR   (strNota                                                   , 015)      + // 002 - 016
                            fValNumForm(qryRemessa. FieldByName('CBI_VALDUP').AsFloat          , 013)      + // 017 - 029
                            fPadR   (strDtaEmi                                                 , 008)      + // 030 - 037
                            fPadR   (qryRemessa.FieldByName('NFE_ACESSO').AsString             , 044)      + // 038 - 081
                            fPadR   (' '                                                       , 015)      + // 002 - 096
                            fPadR   ('0'                                                       , 013,'0')  + // 002 - 096
                            fStrZero(''                                                        , 008)      + // 110 - 117
                            fStrZero(''                                                        , 044)      + // 118 - 161
                            fPadR   (' '                                                       , 015)      + // 162 - 176
                            fPadR   ('0'                                                       , 013,'0')  + // 177 - 189
                            fStrZero(''                                                        , 008)      + // 190 - 197
                            fStrZero(''                                                        , 044)      + // 198 - 241
                            fPadR   (' '                                                       , 153)      + // 242 - 394
                            fPadL   (IntToStr(intCodSeq)                                   , 06, '0');       // 395 - 400

            Writeln(txtTexto,fRetirarCaracteresEspeciais(strMensagem));
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
      {*********JU*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                + //001
                     fPadR   (' '                , 393) + //002
                     fStrZero(IntToStr(intCodSeq), 006);  //395

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************JU*}
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

      If (fCfgSis('CONREM', varString) = 'C') And (Not fEmptyStr(strCartei)) Then
        strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;

        If (Not fEmptyStr(edtCodPor.Text)) Then
          ParamByName('CODPOR').AsString := edtCodPor.Text;

        If (fCfgSis('CONREM', varString) = 'C') And (Not fEmptyStr(strCartei)) Then
          ParamByName('CARTEI').AsString := StrCartei;

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

procedure TfrmExpArqRemABCBrasil.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemABCBrasil.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmExpArqRemABCBrasil.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemABCBrasil.FormCreate(Sender: TObject);
begin
  inherited;
     qryCadPor := fCriaQuery(Self);
end;

end.
