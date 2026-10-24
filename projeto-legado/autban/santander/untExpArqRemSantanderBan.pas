unit untExpArqRemSantanderBan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa;

type
  TfrmExpArqRemSantanderBan = class(TfrmPai)
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
    function fRetEmpresa: String;
    function fRetDupAgrupadas(strNumAgr, strCodCli, strNaoDup: String): String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemSantanderBan: TfrmExpArqRemSantanderBan;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutban, Data.DB, untTypesSistema,
     untConsultas, untConstantes, untLogCtr, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemSantanderBan.FormShow(Sender: TObject);
begin
  inherited;
  edtNomArquivo.Enabled  := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'NOMREME','N') = 'S';
  fraPathRemessa.edtDirectory.text    := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text     := 'RM' +
                            fStrZero(FormatDateTime('dd',VS_Date),2) +
                            fStrZero(FormatDateTime('mm',VS_Date),2) +
                            fStrZero(FormatDateTime('yy',VS_Date),2) +
                            '.TXT';

  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemSantanderBan.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strContBco  : String;
    strContCor  : String;
    strContGar  : String;
    strUtiConGar: String;
    strContB    : String;
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
    strAgenCob  : String;
    strRespons  : String;
    strNossNum  : String;
    strHeader   : String;
    strTransacao: String;
    stlMensagem : TStringList;
    strTrailler : String;
    strSacAva   : String;
    strDupAgr   : String;
    strTodAgr   : String;
    strEnvDpAg  : String;
    strEnvNos   : String;

    intCodSeq   : Integer;
    intQtdTot   : Integer;
    intCodMsg   : Integer;
    intIndice   : Integer;
    fltValTot   : Double;
    fltValMora  : Double;
    fltValMul   : Double;
    fltValDpo   : Double;
    strDtaDpo   : String;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    blnUsaCnd   : Boolean;
    blnUsaDesPonCli: Boolean;
    blnUsaDesPon   : Boolean;
    dtaDtaDpo   : TDateTime;
    qryRemessa  : TUniQuery;

    strInfMulta : String;
    strCompl    : String;
    strCodRem   : String;
    strObserv1  : String;
    strCartSeq  : String;

    strObservacao,
    strTipoDia   : String;

    strFilePath : String;
    blnObservacao: Boolean;
    strCartei : String;
    strAutoIncremRem: String;
    strCodOco   : String;

    fltValDup : Double;
    strchkcbEmp : String;
    AstrEndereco : String;
    blnParNum : Boolean;

    strUsaSac   : String;
    strBenefi   : String;

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

  If fEmptyStr(fTiraCaracEspeciais(fraPathRemessa.edtDirectory.text)) Then
  Begin
    fMensagem('Path:', 'Diretório p\ exportação deve ser informado!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not TryDirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco  := '033';
  strNomBco  := 'SANTANDER';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strContBco := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'IDENTBC', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'DIAPROT', '');
  strContCor := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'NUMCTAC', '');
  strTipoDia := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'TIPDIA', '');
  blnParNum  := (Trim(fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'PARCNUM', '')) = 'S') And (fCfgSis('PARNUM') = 'S');

  //DEVE SER CONFIGURADO A CONTA DE COBRANCA 8 POSICOES E O COMPLEMENTO 2 POSICOES
  strContB     := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'NUMCTAB', '');

  strUtiConGar := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'UTICGAR', '');

  If (strUtiConGar = 'S') Then
  begin
    strContGar := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'CONGARA', '');
    strCompl   := fStrZero(RightStr(fTiraCaracEspeciais(strContGar, True),2), 02);
    strContGar := LeftStr(strContGar, 8);
  end
  else
  begin
    strCompl   := fStrZero(RightStr(fTiraCaracEspeciais(strContB, True),2), 02);
  end;

  strContB   := LeftStr(strContB, 8);

  strRespons := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'RESPONS', '');
  strEnvNos  := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'ENVNOSN', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'INSTRU2', '');
  strObserv1 := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'OBSERV1', '');
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG033B', 'RELOCAL', '') = 'N' );

  strAgenCob := '00000';
  If strCodCar  = '5' Then
    strAgenCob := fStrZero(strCodAgen, 5);

  strSacAva  := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'MSACAVA', '');
  strEnvDpAg := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'ENVDPAG', '');
  fltValMul  := fStrToFloat(fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'PERMULT', '0'));

  strUsaSac  := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'SACAVAL', '');
  strBenefi  := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'NOMEBEN', '');

  If (strInstru1 <> '06') And (strInstru2 <> '06') Then
    strDiaPro := '0';

  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);

  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  If (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2')) Then
    blnUsaDesPonCli := True
  else
    blnUsaDesPonCli := False;

  If fCfgSis('DESPON', varBoolean) Then
    blnUsaDesPon := True
  Else
    blnUsaDesPon := False;

  blnObservacao := (((strRespons = 'B') And (Not fEmptyStr(strObserv1))) Or
                    ((strRespons = 'E') And (fStrZero(strDiaPro, 2) <> '00')));

  Try
    fStartTransaction;

    stlMensagem    := TStringList.Create;
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
    strCartei := 'CONFIG033B-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, C.CLI_PERDPO, C.CLI_QTDDAV, ';
    strSQL := strSQL + '  SUM(R.CTR_DESCOB) AS CTR_DESCOB, ';
    strSQL := strSQL + '  SUM(R.CTR_JURSUJ) AS CTR_JURSUJ, ';
    strSQL := strSQL + '  SUM(R.CTR_DESSUJ) AS CTR_DESSUJ, ';

    If blnUsaDesPon Then
    Begin
      strSQL := strSQL + '  D.CND_PERDPO, ';
      strSQL := strSQL + '  D.CND_QTDDAV, ';
    End;

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
    strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = B.CBI_CODCLI ';
    strSQL := strSQL + '  JOIN CADREC R ON R.CTR_NUMDUP = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                   R.CTR_PARCEL = B.CBI_PARCEL AND ';
    strSQL := strSQL + '                   R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                   R.CTR_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                   R.CTR_CODCLI = B.CBI_CODCLI     ';

    if (fCfgSis('CONREM', varString) = 'C') THEN
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND (B.CBI_CODOCO = "01" OR B.CBI_CODOCO = "06")) OR';
    strSQL := strSQL + '  (CTR_DTAREC IS NOT NULL AND B.CBI_CODOCO = "02"))';

      If fraCheckComboBoxEmpresa.chkcbEmpresa.Text <> 'Todas'Then
    Begin
      strchkcbEmp := fraCheckComboBoxEmpresa.chkcbEmpresa.Text;
      strSQL := strSQL + ' AND CBI_EMPGER IN (' + fRetStrToSQLIn(strchkcbEmp,';') + ') ';
    End;

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CBI_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    strSQL := strSQL + ' GROUP BY CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI, CTR_SEQCON, CTR_EMPBAI, CTR_DTABAI ' ;

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

      strCartSeq := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG033B-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 6);
      pAtualizaProxNumCartsAutBan('CONFIG033B-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      {***************************************}
      {* VERIFICA SE MOSTRA SACADOR AVALISTA *}
      {************************************PZ*}
      If (strSacAva = 'N') Then
        strNomEmp := '';

      If TriM(fCfgSis('NOMCED', varString)) <> EmptyStr Then
        strNomEmp := fCfgSis('NOMCED', varString);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001)      + //001 - 001
                   fPadR   ('1'                , 001)      + //002 - 002
                   fPadR   ('REMESSA'          , 007)      + //003 - 009
                   fPadR   ('01'               , 002)      + //010 - 011
                   fPadR   ('COBRANCA'         , 015, ' ') + //012 - 026
                   fPadL   (strCodAgen         , 004, '0') + //027 - 030
                   fPadL   (strContCor         , 008, '0') + //031 - 038
                   fPadL   (strContB           , 008, '0') + //039 - 046
                   fPadR   (IIF(strUsaSac <> 'S', strNomEmp, strBenefi) , 030, ' ') + //047 - 076
                   fPadR   (strCodBco          , 003)      + //077 - 079
                   fPadR   (strNomBco          , 015, ' ') + //080 - 094
                   fPadR   (strDtaRem          , 006)      + //095 - 100
                   fStrZero('0'                , 016)      + //101 - 116
                   fPadR   (' '                , 275)      + //117 - 391
                   fStrZero('0'                , 003)      + //392 - 394
                   fPadL   (IntToStr(intCodSeq), 006, '0');  //395 - 400

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
        intQtdTot    := 0;
        fltValTot    := 0;

        While Not Eof Do
        Begin

          Inc(intCodSeq);
          Application.ProcessMessages;

          Inc(intQtdTot);
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

          If blnParNum Then
            strKeyAux := RightStr(FieldByName('CBI_NUMDUP').AsString +
                                  fPadL(fRetNumParcela(FieldByName('CBI_PARCEL').AsString),003,'0'), 10)
          Else
            strKeyAux := RightStr(FieldByName('CBI_NUMDUP').AsString +
                                  FieldByName('CBI_PARCEL').AsString, 10);

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

          If fCfgSis('DESBOL', varBoolean) Then
            fltValDup := fFormataFloat((fltValDup - qryRemessa.FieldByName('CTR_DESSUJ').AsFloat),2);

          If (strRespons = 'E') Or (strEnvNos = 'S') Then
            strNossNum := FieldByName('CBI_NOSNUM').AsString
          Else
            strNossNum := '0';

          strInfMulta := '4';
          If fltValMul <= 0 Then
            strInfMulta := '0';

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
          End
          Else
          Begin
            fltValDpo := 0;
            strDtaDpo := '0';
          End;

          strTransacao := fPadR      ('1'                                           , 01)      + //001 - 001
                          fPadR      ('02'                                          , 02)      + //002 - 003
                          fPadL      (strCgcEmp                                     , 14, '0') + //004 - 017
                          fPadL      (strCodAgen                                    , 04, '0') + //018 - 021
                          fPadL      (strContCor                                    , 08, '0') + //022 - 029
                          fPadL      (IIF(strUtiConGar = 'S', strContGar, strContB) , 08, '0') + //030 - 037
//                          fPadL      (strContCob                           , 08, '0') + //022 - 029   *****APENAS PRA HOMOLOGAR*****
//                          fPadL      (strContCor                           , 08, '0') + //030 - 037
                          fPadR      (strKeyDup                                     , 25, ' ') + //038 - 062
                          fPadL      (strNossNum                                    , 08, '0') + //063 - 070
                          fStrZero   ('0'                                           , 06)      + //071 - 076
                          fPadR      (' '                                           , 01)      + //077 - 077
                          fPadR      (strInfMulta                                   , 01)      + //078 - 078
                          fValNumForm(fltValMul                                     , 04)      + //079 - 082
                          fPadR      ('00'                                          , 02)      + //083 - 084
                          fStrZero   ('0'                                           , 13)      + //085 - 097
                          fPadR      (' '                                           , 04)      + //098 - 101
                          fStrZero   ('0'                                           , 06)      + //102 - 107
                          fPadR      (strCodCar                                     , 01)      + //108 - 108
                          fPadR      (strCodOco                                     , 02)      + //109 - 110
//                          fPadR      (strKeyDup                                    , 10)      + //111 - 120
                          fPadR      (strKeyAux                                     , 10)      + //111 - 120    *****APENAS PRA HOMOLOGAR*****
                          fPadR      (strDtaVen                                     , 06)      + //121 - 126
                          fValNumForm(fltValDup                                     , 13)      + //127 - 139
                          fPadR      (strCodBco                                     , 03)      + //140 - 142
                          fPadL      (strAgenCob                                    , 05, '0') + //143 - 147
                          fPadR      ('01'                                          , 02)      + //148 - 149
                          fPadR      ('N'                                           , 01)      + //150 - 150
                          fPadR      (strDtaEmi                                     , 06)      + //151 - 156
                          fPadL      (strInstru1                                    , 02, '0') + //157 - 158
                          fPadL      (strInstru2                                    , 02, '0') + //159 - 160
                          fValNumForm(fltValMora                                    , 13)      + //161 - 173
                          fPadL      (strDtaDpo                                     , 06, '0') + //174 - 179
                          fValNumForm(fltValDpo                                     , 13)      + //180 - 192
                          fStrZero   ('0'                                           , 13)      + //193 - 205
                          fStrZero   ('0'                                           , 13)      + //206 - 218
                          fPadL      (strCpfCgc                                     , 02, '0') + //219 - 220
                          fPadL      (strCgcCli                                     , 14, '0') + //221 - 234
                          fPadR      (FieldByName('CLI_NOMCLI').AsString            , 40, ' ') + //235 - 274
                          fPadR      (AstrEndereco                                  , 40, ' ') + //275 - 314
                          fPadR      (FieldByName('BAIRRO').AsString                , 12, ' ') + //315 - 326
                          fPadL      (FieldByName('C_E_P_').AsString                , 08, '0') + //327 - 334
                          fPadR      (FieldByName('CIDADE').AsString                , 15, ' ') + //335 - 349
                          fPadR      (FieldByName('ESTADO').AsString                , 02, ' ') + //350 - 351
                          fPadR      (IIF(strUsaSac = 'S', strNomEmp, ' ')          , 30, ' ') + //352 - 381
                          fPadR      (' '                                           , 01)      + //382 - 382
                          fPadL      ('I'                                           , 01)      + //383 - 383
                          fStrZero   (strCompl                                      , 02)      + //384 - 385
                          fPadR      (' '                                           , 06)      + //386 - 391
                          fPadL      (strDiaPro                                     , 02, '0') + //392 - 393
                          fPadL      (' '                                           , 01)      + //394 - 394
                          fPadL      (IntToStr(intCodSeq)                           , 06, '0');  //395 - 400

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);


          {*************************************************}
          {* SE FOR AGRUPAMENTO, INSERE OS NUMEROS DAS DU- *}
          {* PLICATAS AGRUPADAS, SENÃO DEIXA EM BRANCO.    *}
          {**********************************************PZ*}
          If (FieldByName('CBI_ESPDOC').AsString = 'AG') Or (blnObservacao)  Then
          Begin
            strDupAgr   := '';
            strTodAgr   := '';
            stlMensagem.Clear;

            {*********************************************}
            {* FEITO FOR PARA GRAVAR TODAS AS DUPLICATAS *}
            {* DOS AGRUAPAMENTOS UTILIZANDO AS 5 LINHAS  *}
            {* DE MENSAGENS                              *}
            {******************************************JU*}
            For intCodMsg := 2 To 7 Do
            Begin

              If intCodMsg <> 3 Then
              Begin
                If ((FieldByName('CBI_ESPDOC').AsString = 'AG') And ((Not blnObservacao) Or (intCodMsg > 2)) And (strEnvDpAg = 'S')) Then
                Begin
                  strDupAgr := fRetDupAgrupadas(FieldByName('CBI_NUMDUP').AsString, FieldByName('CBI_CODCLI').AsString, strTodAgr);
                  strTodAgr := IIF(fEmptyStr(strTodAgr), strDupAgr, strTodAgr + '/' + strDupAgr);
                End;

                If (Not fEmptyStr(strDupAgr)) Or ((blnObservacao) And (intCodMsg = 2)) Then
                Begin
                  strObservacao := strDupAgr;
                  If (blnObservacao) And (intCodMsg = 2) Then
                  Begin
                    strObservacao := strObserv1;

                    If strRespons = 'E' Then
                      strObservacao := 'PROTESTAR NO ' + strDiaPro + ' DIA ' + IIF(strTipoDia = '1', 'UTIL', 'CORRIDO') + ' APOS O VENCIMENTO';
                  End;

                  Inc(intQtdTot);
                  Inc(intCodSeq);
                  stlMensagem.Add(
                      fPadR(IntToStr(intCodMsg), 1) +              // 001 - 001 Código do registro
                      fPadR(' ', 16) +                             // 002 - 017 Reservado (uso Banco)
                      fPadL(strCodAgen, 4, '0') +                  // 018 - 021 Código da Agência do Beneficiário
                      fPadL(strContCor, 8, '0') +                  // 022 - 029 Conta Movimento Beneficiário
                      fPadL(IIF(strUtiConGar = 'S', strContGar, strContB) , 08, '0') + // 030 - 037 Conta Cobrança Beneficiário
                      fPadR(' ', 10) +                             // 038 - 047 Reservado (uso Banco)
                      fPadR('01', 2) +                             // 048 - 049 Sub-sequência do registro 01
                      fPadR(fRetirarCaracteresEspeciais(strObservacao), 50) +  // 050 - 099 Mensagem variável por boleto (primeira parte)
                      fPadR('02', 2) +                             // 100 - 101 Sub-sequência do registro 02
                      fPadR(' ', 50) +                             // 102 - 151 Mensagem variável por boleto (segunda parte)
                      fPadR('02', 2) +                             // 152 - 153 Sub-sequência do registro 02
                      fPadR(' ', 50) +                             // 154 - 203 Mensagem variável por boleto (terceira parte)
                      fPadR(' ', 179) +                            // 204 - 382 Reservado (uso Banco)
                      fPadR('I', 1) +                              // 383 - 383 Identificador do complemento
                      fStrZero(strCompl, 2) +                      // 384 - 385 Complemento
                      fPadR(' ', 9) +                              // 386 - 394 Reservado (uso Banco)
                      fPadL(IntToStr(intCodSeq), 6, '0')           // 395 - 400 Número sequencial do registro no arquivo
                  );
                End;
              End;

            End;

            {**************************************}
            {* ESCREVE A MENSAGEM VARIAVEL NO TXT *}
            {***********************************PZ*}
            For intIndice := 0 To stlMensagem.Count - 1 Do
              Writeln(txtTexto,stlMensagem.Strings[intIndice]);

          End;

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       strNossNum,
                       fltValMul,
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
      {*********AF*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                            + //001 - 001
                     fPadL      (IntToStr(intQtdTot + 2), 006, '0') + //002 - 007
                     fValNumForm(fltValTot              , 013)      + //008 - 020
                     fStrZero   ('0'                    , 374)      + //021 - 394
//                     fPadL      (IntToStr(intQtdTot + 2), 006, '0');  //395 - 400
                     fPadL      (IntToStr(intCodSeq)    , 006, '0');  //395 - 400

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

{      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
 }
      //strCodRem  := fStrZero(fAtuCodSeq('CONFIG033B-' + IntToStr(intCartei), 'PROXNUM'), 6);

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
		FreeAndNil(stlMensagem);

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

procedure TfrmExpArqRemSantanderBan.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemSantanderBan.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

function TfrmExpArqRemSantanderBan.fRetEmpresa: String;
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


  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);


  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;

function TfrmExpArqRemSantanderBan.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemSantanderBan.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemSantanderBan.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

function TfrmExpArqRemSantanderBan.fRetDupAgrupadas(strNumAgr, strCodCli, strNaoDup: String): String;
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

      If Not fEmptyStr(strNaoDup) Then
        strSQL := strSQL + ' AND NOT LOCATE(CTR_NUMDUP, :NUMDUP) > 0 ';

      With qryAgr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('NUMAGR').AsString := strNumAgr;
        ParamByName('CODCLI').AsString := strCodCli;

        If Not fEmptyStr(strNaoDup) Then
          ParamByName('NUMDUP').AsString := strNaoDup;
        
        Open;

        strDupAgr := '';
        intQtdDup := 1;
        strInsBar := 'N';

        While Not Eof Do
        Begin
          {***************************************}
          {* LIMITA A QUANTIDADE DE 6 DUPLICATAS *}
          {* PARA NÃO EXCEDER A QTDE DE CARACTER *}
          {* DISPONÍVEL.(TOTAL = 50)             *}
          {************************************PZ*}
          If (intQtdDup <= 6) Then
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
