unit untExpArqRemBancoAmazonia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, System.StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBancoAmazonia = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRem: TLabel;
    Label1: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure FormActivate(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private
    { Private declarations }
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    strSeqDia: String;
    dtaDtaSeq: TDateTime;

    procedure pIncrementaSeqDia;
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemBancoAmazonia: TfrmExpArqRemBancoAmazonia;

implementation

uses untFuncoesSimples, untConsultas, untFuncAutBan, untFuncoesConsulta, untFuncoes,
     untTypesSistema, Data.DB, untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemBancoAmazonia.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String; 
    strCodBco  : String;
    strNomBco  : String;
    strNomEmp  : String;
    strCodAge  : String;
    strDigAge  : String;
    strCtaCor  : String;
    strNumCon  : String;
    strConCli  : String;
    strDiasCred: String;
    strProAce  : String;
    strResp    : String;
    strCodPor  : String;
    strCtaBai  : String;
    strInstru1 : String;
    strInstru2 : String;
    strObs001  : String;
    strObs002  : String;
    strObs003  : String;
    strObs004  : String;
    strNosNum  : String;
    strParcel  : String;
    strDtaRem  : String;
    strDtaVen  : String;
    strDtaEmi  : String;
    strCodRem  : String;
    strHeader   : String;
    strTransacao: String;
    strMensagens: String;
    strTrailler : String;
    strCgcEmp   : String;
    strCpfCgc   : String;
    strKeyDup   : String;
    strCgcCli   : String;
    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    qryRemessa  : TUniQuery;
    strCartei   : String;
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

  strCodBco      := '003';
  strNomBco      := 'Banco Amazonia';
  strNomEmp      := fRetNomeEmpresa(VS_strCodEmp);
  strNumCon      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'NUMCONV', '');
  strConCli      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'CONVCLI', '');
  strDiasCred    := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'DIACRED', '');
  strProAce      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'PROACEI', '');
  strCodPor      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'PORBAI_', '');
  strCtaBai      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'CTABAI_', '');
  strInstru1     := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2     := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'DIAPROT', '');
  strDtaRem      := FormatDateTime('dd', VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  strCodRem      := fStrZero(fAtuCodSeq('CONFIG003-' + IntToStr(intCartei), 'PROXNUM'), 7);

  strObs001      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'OBSERV1', '');
  strObs002      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'OBSERV2', '');
  strObs003      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'OBSERV3', '');
  strObs004      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'OBSERV4', '');
  strCtaCor      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'NUMCTAC', '');
  strCodAge      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAge      := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'DIGAGEN', '');

  If fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'RESPONS', '') = 'B' Then
    strResp := '1'
  Else
    strResp := '2';

  strNomEmp := fRetNomeEmpresa(VS_strCodEmp);

  If fEmptyStr(strInstru2) Then
    strInstru2 := '00';

  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try
    strCartei  := 'CONFIG003-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
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
  End;

  Try

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

    IF fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      IF fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
        ParamByName('CARTEI').AsString := StrCartei;

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
      strHeader := fPadR   ('0'                , 001) + //001 - 001  [01]
                   fPadR   ('1'                , 001) + //002 - 002  [02]
                   fPadR   ('REMESSA'          , 007) + //003 - 009  [03]
                   fPadR   ('01'               , 002) + //010 - 011  [04]
                   fPadR   ('COBRANCA'         , 008) + //012 - 019  [05]
                   fPadR   (' '                , 007) + //020 - 026  [06]
                   fStrZero(fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'IDEBANC',''), 020) + //027 - 046  [07]
                   fPadR   (strNomEmp          , 030) + //047 - 076  [08]
                   fPadR   (strCodBco          , 003) + //077 - 079  [09]
                   fPadR   ('BANCO AMAZONIA'   , 015) + //080 - 094  [10]
                   fPadR   (strDtaRem          , 006) + //095 - 100  [11]
                   fPadR   (' '                , 008) + //101 - 108  [12]
                   fPadR   ('MX'               , 002) + //109 - 110  [13]
                   fPadL   (strCodRem     , 007, '0') + //111 - 117  [14]
                   fPadR   (' '                , 277) + //118 - 394  [15]
                   fStrZero(IntToStr(intCodSeq), 006);  //395 - 400  [16]

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************JU*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG003-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

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

          fltValAtr := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CBI_PORCEN').AsFloat / 100 ) );

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

          If SameText(strResp, 'B') Then
            strNosNum := '0'
          Else
            strNosNum := FieldByName('CBI_NOSNUM').AsString;

          strParcel := IntToStr(fGetPosLetraAlfa(FieldByName('CBI_PARCEL').AsString));

          strTransacao := fPadR      ('1'                                  , 01, ' ') + //001 - 001  [01]
                          fPadR      ('0'                                  , 19, '0') + //002 - 020  [02]
                          fPadL      ('0'                                  , 01, ' ') +
                          fPadL      ('009'                                , 03, '0') +
                          fPadL      (strCodAge                            , 05, '0') +
                          fPadL      (strCtaCor                            , 08, '0') + //021 - 037  [03]
                          fPadR      (strKeyDup                            , 25, ' ') + //038 - 062  [04]
                          fPadL      ('0'                                  , 08, '0') + //063 - 070  [05]
                          fPadL      ('0'                                  , 12, '0') + //071 - 082  [06]
                          fPadL      ('0'                                  , 10, '0') + //083 - 092  [07]
                          fPadR      (strResp                              , 01, ' ') + //093 - 093  [08]
                          fPadR      ('N'                                  , 01, ' ') + //094 - 094  [09]
                          fPadR      (' '                                  , 14, ' ') + //095 - 108  [10]
                          fStrZero   ('01'                                      , 02) + //109 - 110  [11]
                          fPadR      (strKeyDup                                 , 10) + //111 - 120  [12]
                          fPadR      (strDtaVen                                 , 06) + //121 - 126  [13]
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat         , 13) + //127 - 139  [14]
                          fPadL      (strCodBco                                 , 03) + //140 - 142  [15]
                          fPadR      ('0'                                  , 05, '0') + //143 - 147  [16]
                          fPadR      ('01'                                      , 02) + //148 - 149  [17]
                          fPadR      ('A'                                       , 01) + //150 - 150  [18]
                          fPadR      (strDtaEmi                                 , 06) + //151 - 156  [19]
                          fPadR      (strInstru1                                , 02) + //157 - 158  [20]
                          fPadR      (strInstru2                                , 02) + //159 - 160  [21]
                          fValNumForm(fStrToFloat(IfThen(strDtaVen < strDtaRem, FloatToStr(fltValAtr),'0')), 13) + //161 - 173  [22]
                          fPadR      ('0'                                  , 06, '0') + //174 - 179  [23]
                          fPadR      ('0'                                  , 13, '0') + //180 - 192  [24]
                          fPadR      ('0'                                  , 13, '0') + //193 - 205  [25]
                          fPadR      ('0'                                  , 13, '0') + //206 - 218  [26]
                          fPadR      (strCpfCgc                                 , 02) + //219 - 220  [27]
                          fStrZero   (strCgcCli                            , 14     ) + //221 - 234  [28]
                          fPadR      (FieldByName('CLI_NOMCLI').AsString   , 40, ' ') + //235 - 274  [29]
                          fPadR      (AstrEndereco                         , 40, ' ') + //275 - 314  [30]
                          fPadR      (FieldByName('BAIRRO').AsString       , 12, ' ') + //315 - 326  [31]
                          fPadR      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 - 334  [32..33]
                          fPadR      (FieldByName('CIDADE').AsString       , 15, ' ') + //335 - 349  [34]
                          fPadR      (FieldByName('ESTADO').AsString       , 02, ' ') + //350 - 351  [35]
                          fPadR      (' '                                  , 43, ' ') + //352 - 394  [36]
                          fStrZero   (IntToStr(intCodSeq)                  , 06     );  //395 - 400  [37]

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************JU*}
          Writeln(txtTexto,strTransacao);

          {***************************}
          {* MENSAGENS / OBSERVAÇÕES *}
          {************************JU*}

          If Not fEmptyStr(strObs001) Then
          Begin
            Inc(intCodSeq);

            strMensagens := '';

            strMensagens := fPadR    ('2',                  1) + //001 - 001 [1]
                            fPadR    (strObs001,           80) + //002 - 081 [2]
                            fPadR    (strObs002,           80) + //082 - 161 [3]
                            fPadR    (strObs003,           80) + //162 - 241 [4]
                            fPadR    (strObs004,           80) + //242 - 321 [5]
                            fPadR    (' ',                 45) + //322 - 366 [6]
                            fPadR    ('009',               03) + //367 - 369 [7]
                            fPadR    (strCodAge,           05) + //370 - 374 [8]
                            fPadR    (strCtaCor,           08) + //375 - 382 [9..10]
                            fPadR    ('0'      ,           12) + //383 - 394 [11..12]
                            fStrZero (IntToStr(intCodSeq), 06);  //395 - 400 [13]

            Writeln(txtTexto, strMensagens);
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
      strTrailler := '9'                        +          //001 - 001  [01]
                     fPadL    (' ', 393, ' ') +            //002 - 394  [02]
                     fStrZero (IntToStr(intCodSeq), 006);  //395 - 400  [03]

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

      IF fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
        strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;

        If (Not fEmptyStr(edtCodPor.Text)) Then
          ParamByName('CODPOR').AsString := edtCodPor.Text;

        IF fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
          ParamByName('CARTEI').AsString := strCartei;

        ExecSQL;
        Close;
      End;

      pIncrementaSeqDia;

    End
    Else
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);

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

procedure TfrmExpArqRemBancoAmazonia.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBancoAmazonia.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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
    if fValidaCampos(edtCodPor) then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmExpArqRemBancoAmazonia.FormActivate(Sender: TObject);
begin
  inherited;

  dtaDtaSeq := VS_Date;

  If ((fEmptyStr(fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'SEQDIA','')))  And
      (fEmptyStr(fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'DTASEQ','')))) Or
     (dtaDtaSeq <> StrToDateTime(fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'DTASEQ',''))) Then
    strSeqDia := '001'
  Else
    strSeqDia := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'SEQDIA','');

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'CODCONV','') +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         '.REM'+
                         strSeqDia;
  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemBancoAmazonia.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
end;

function TfrmExpArqRemBancoAmazonia.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemBancoAmazonia.pIncrementaSeqDia;
  Var
    intSeqDia: Integer;

begin

  fGetBancoConfig(1, 'CONFIG003-' + IntToStr(intCartei), 'DTASEQ', FormatDateTime('dd/mm/yyyy', dtaDtaSeq));
  intSeqDia := StrToInt(strSeqDia);
  Inc(intSeqDia);
  strSeqDia := fStrZero(intSeqDia, 3);
  fGetBancoConfig(1, 'CONFIG003-' + IntToStr(intCartei), 'SEQDIA', strSeqDia);

end;

end.
