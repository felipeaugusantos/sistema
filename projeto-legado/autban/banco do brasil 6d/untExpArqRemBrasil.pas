unit untExpArqRemBrasil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa;

type
  TfrmExpArqRemBrasil = class(TfrmPai)
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
    fraCheckComboBoxEmpresa: TfraCheckComboBoxEmpresa;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;

    function fSetSacadorAvalista(strSacAvalista, strCpfCnpj: String): String;

    function RetornaComando(AOcorrencia:String): String;
    function RetornaInstrucao(AComando, AInstrucao: String): String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemBrasil: TfrmExpArqRemBrasil;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemBrasil.FormShow(Sender: TObject);
  Var
    strCodSeqBoleto : String;
begin
  inherited;
  strCodSeqBoleto :=  IntToStr(StrToInt(fGetBancoProxNum('CONFIG001-' + IntToStr(intCartei))) + 1);
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'PATHREM', ''));
  edtNomArquivo.Text  := 'ARQ'+strCodSeqBoleto+'.TXT';
  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemBrasil.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strNomBenef : String;
    strCpfBenef : String;
    strTipInsc  : String;
    strDtaRem   : String;
    strCodRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strDConCor  : String;
    strContCor  : String;
    strCodAgen  : String;
    strDigAgen  : String;
    strCodConv  : String;
    strCodLider : String;

    strPreFix   : String;
    strCodCar   : String;
    strVarCar   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strObsAgru  : String;
    strMandMsg  : String;
    strCobran   : String;
    strTipCob   : String;

    strCnpjSac	: String;
    strSacAval	: String;
    strMsgSac	  : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    strInstru1  : String;
    strInstru2  : String;
    strCartSeq  : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa  : TUniQuery;

    strNosNum   : String;
    strRespon   : String;

    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;
    blnUsaCnd   : Boolean;
    blnUsaDesPonCli: Boolean;
    blnUsaDesPon   : Boolean;
    dtaDtaDes: TDateTime;
    fltValDes   : Double;
    strDtaDes   : String;

    fltValDup : Double;
    strchkcbEmp : String;
    AstrEndereco: String;

    LComando: String;

    strEnvCaracEsp : String;

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

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco  := '001';
  strNomBco  := 'BANCO DO BRASIL';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);

  strCodAgen := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'DIGAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDConCor := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodConv := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'CODCONV', '');
  strCodLider:= fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'CODLIDE', '');
  strVarCar  := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'VARCART', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'NUMCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'DIAPROT', '');
  strMandMsg := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'MANDMSG', '');
  strInstru1 := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'INSTRU2', '');
  strCobran  := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'TIPCOBR', '');
  strRespon  := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'RESPONS', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG001', 'RELOCAL', '') = 'N' );

  strCnpjSac := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'CNPJSAC', '');
  strSacAval := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'SACAVAL', '');

  StrEnvCaracEsp := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'ENVCESP', '');

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  If (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2')) Then
    blnUsaDesPonCli := True
  else
    blnUsaDesPonCli := False;

  If fCfgSis('DESPON', varBoolean) Then
    blnUsaDesPon := True
  Else
    blnUsaDesPon := False;

  {*********************************************}
  {* NO LUGAR DO NUMERO DO CONVENIO IRA ENVIAR *}
  {* O CODIGO LIDER, SOMENTE SE O MESMO TIVER  *}
  {* VALOR, ASSIM GARANTINDO O FUNCIONAMENTO   *}
  {* EM TODOS OS CLIENTES                      *}
  {****************************************JC*}
  If fEmptyStr(strCodLider) Then
    strCodLider := strCodConv;

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

    strTipInsc  := '02';
    strNomBenef := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'NOMBENE', '');
    strCpfBenef := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'CPFBENE', '');

    If fCfgSis('BENBOL', varBoolean) And (Not fEmptyStr(strCpfBenef)) Then
    Begin
      strNomEmp  := strNomBenef;
      strCgcEmp  := strCpfBenef;
      strTipInsc := '01';
    End;

{  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try}
    strCartei  := 'CONFIG001-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  SUM(R.CTR_DESCOB) AS CTR_DESCOB, ';
    strSQL := strSQL + '  SUM(R.CTR_JURSUJ) AS CTR_JURSUJ, ';
    strSQL := strSQL + '  SUM(R.CTR_DESSUJ) AS CTR_DESSUJ, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, C.CLI_PERDPO, C.CLI_QTDDAV, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                  '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';

    If blnUsaDesPon Then
    Begin
      strSQL := strSQL + '  D.CND_PERDPO, ';
      strSQL := strSQL + '  D.CND_QTDDAV, ';
    End;

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

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = R.CTR_CODCND ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND B.CBI_CODOCO IN ("01", "06", "12")) OR';
    strSQL := strSQL + '  (CTR_DTAREC IS NOT NULL AND B.CBI_CODOCO = "02" AND CTR_BAIMAN="S")) ';

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

    strSQL := strSQL + ' GROUP BY CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI, CTR_SEQCON, CTR_EMPBAI, CTR_DTABAI ' ;

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
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG001-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG001-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001)      + //001
                   fPadR   ('1'                , 001)      + //002
                   fPadR   ('REMESSA'          , 007)      + //003
                   fPadR   ('01'               , 002)      + //010
                   fPadR   ('COBRANCA'         , 008)      + //012
                   fPadR   (' '                , 007)      + //020
                   fPadL   (strCodAgen         , 004, '0') + //027
                   fPadL   (strDigAgen         , 001, '0') + //031
                   fPadL   (strContCor         , 008, '0') + //032
                   fPadL   (strDConCor         , 001, '0') + //040
                   fStrZero(strCodLider        , 006)      + //041
                   fPadR   (strNomEmp          , 030)      + //047
                   fPadR   (strCodBco          , 003)      + //077
                   fPadR   (strNomBco          , 015)      + //080
                   fPadR   (strDtaRem          , 006)      + //095
                   fPadR   (strCodRem          , 007)      + //101
                   fPadR   (' '                , 287)      + //108
                   fStrZero(IntToStr(intCodSeq), 006);       //395

      strHeader := fTiraCaracEspeciais(strHeader, False);

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG001D6-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);


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

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          If (qryRemessa.FieldByName('CBI_ESPDOC').AsString = 'AG') And
              (strMandMsg = 'S') Then
          Begin
            strObsAgru := 'REF:_' + COPY(qryRemessa.FieldByName('CBI_OBSAG1').AsString,11,31);
          End
          Else
          Begin
            strObsAgru := '';
          End;

          strInstru1 := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'INSTRU1', '');
          strInstru2 := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'INSTRU2', '');

          strMsgSac := ' ';
          If ((strCnpjSac <> '') Or (strSacAval <> '')) Then
          begin
          	strMsgSac := 'A'; {SETA OBS PARA CPF/CNPJ DO SACADOR AVALISTA}
            strObsAgru := fSetSacadorAvalista(strSacAval, strCnpjSac);
          end;

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
            fltValDup := fFormataFloat((fltValDup - FieldByName('CTR_DESSUJ').AsFloat),2);

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

          strPreFix := 'AI';

          If (Trim(strCobran) = 'D') Then
          Begin
            strTipCob := '04DSC';
            fltValAtr := 0;
          End
          Else
            strTipCob := '';

          If fStrZero(strCodCar,2) = '12' Then
          Begin
            strPreFix := 'ATU';
          End
          Else If ((fStrZero(strCodCar,2) = '31') Or
                   (fStrZero(strCodCar,2) = '51') Or
                   (fStrZero(strCodCar,2) = '54'))Then
          Begin
            strPreFix := 'SD';
          End;

          strNosNum := strCodConv + RightStr(FieldByName('CBI_NOSNUM').AsString, 06);

          If blnUsaDesPonCli And blnUsaDesPon Then
          begin
            fltValDes := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CLI_PERDPO').AsFloat / 100 ) );
            fltValDes := fFormataFloat(fltValDes, 2);

            If fltValDes > 0 Then
            Begin
              dtaDtaDes := FieldByName('CBI_DTAVEN').AsDateTime - FieldByName('CLI_QTDDAV').AsInteger;
              strDtaDes := FormatDateTime('ddmmyy', dtaDtaDes);
            End
            Else
              strDtaDes := '000000';
          end
          else
          If blnUsaCnd And blnUsaDesPon Then
          Begin
            fltValDes := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CND_PERDPO').AsFloat / 100 ) );
            fltValDes := fFormataFloat(fltValDes, 2);

            If fltValDes > 0 Then
            Begin
              dtaDtaDes := FieldByName('CBI_DTAVEN').AsDateTime - FieldByName('CND_QTDDAV').AsInteger;
              strDtaDes := FormatDateTime('ddmmyy', dtaDtaDes);
            End
            Else
              strDtaDes := '000000';
          End
          Else
          Begin
            fltValDes := 0;
            strDtaDes := '000000';
          End;

          {*************************************************}
          {* CARTEIRAS (11, 31 E 51)                       *}
          {**********************************************AF*}
          If (Pos(strCodCar, '_11_31_51') > 0) Then
          Begin
            strNosNum := '';
          End
          Else
          Begin
            If strRespon = 'B' Then
              strNosNum := '';
          End;

          LComando := RetornaComando(FieldByName('CBI_CODOCO').AsString);
          strPreFix := ''; // 204277
          strTransacao := fPadR      ('1'                                     , 01)      + //001
                          fPadR      (strTipInsc                              , 02)      + //002
                          fPadL      (strCgcEmp                               , 14, '0') + //004
                          fPadL      (strCodAgen                              , 04, '0') + //018
                          fPadL      (strDigAgen                              , 01, '0') + //022
                          fPadL      (strContCor                              , 08, '0') + //023
                          fPadL      (strDConCor                              , 01, '0') + //031
                          fStrZero   (strCodConv                              , 06)      + //032
                          fPadR      (strKeyDup                               , 25)      + //038
                          fPadL      (strNosNum                               , 12, '0') + //063
                          fStrZero   ('0'                                     , 02)      + //075
                          fStrZero   ('0'                                     , 02)      + //077
                          fPadR      (' '                                     , 03)      + //079
                          fPadR      (strMsgSac                               , 01)      + //082
                          fPadR      (strPreFix                               , 03,' ')  + //083
                          fPadR      (strVarCar                               , 03)      + //086
                          fStrZero   ('0'                                     , 01)      + //089
                          fStrZero   ('0'                                     , 05)      + //090
                          fPadR      ('0'                                     , 01)      + //095
                          fStrZero   ('0'                                     , 06)      + //096
                          fPadR      (strTipCob                               , 05)      + //102
                          fStrZero   (strCodCar                               , 02)      + //107
                          fPadR      (LComando                                , 02)      + //109
                          fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                               FieldByName('CBI_PARCEL').AsString , 10), 10) + //111   NUMDUP + PARCEL
                          fPadR      (strDtaVen                               , 06)      + //121
                          fValNumForm(fltValDup                               , 13)      + //127
                          fPadR      (strCodBco                               , 03)      + //140
                          fStrZero   ('0'                                     , 04)      + //143
                          fPadR      (' '                                     , 01)      + //147
                          fPadR      ('01'                                    , 02)      + //148
                          fPadR      ('N'                                     , 01)      + //150
                          fPadR      (strDtaEmi                               , 06)      + //151
                          fPadR      (RetornaInstrucao(LComando, strInstru1)  , 02)      + //157
                          fPadR      (strInstru2                              , 02)      + //159
                          fValNumForm(fltValAtr                               , 13)      + //161
                          fPadR      (strDtaDes                               , 06)      + //174
                          fValNumForm(fltValDes                               , 13)      + //180
                          fStrZero   ('0'                                     , 13)      + //193
                          fStrZero   ('0'                                     , 13)      + //206
                          fStrZero   (strCpfCgc                               , 02)      + //219
                          fPadL      (strCgcCli                               , 14, '0') + //221
                          fPadR      ( IIF(strEnvCaracEsp = 'S', FieldByName('CLI_NOMCLI').AsString,
                                             fTiraCaracEspeciais(FieldByName('CLI_NOMCLI').AsString)), 40)             + //235
                          fPadR      ( IIF(strEnvCaracEsp = 'S', AstrEndereco, fTiraCaracEspeciais(AstrEndereco)), 40) + //275
                          fPadR      ( IIF(strEnvCaracEsp = 'S', FieldByName('BAIRRO').AsString, fTiraCaracEspeciais(FieldByName('BAIRRO').AsString)), 12) + //312
                          fPadR      (FieldByName('C_E_P_').AsString          , 08, '0') + //327
                          fPadR      ( IIF(strEnvCaracEsp = 'S', FieldByName('CIDADE').AsString, fTiraCaracEspeciais(FieldByName('CIDADE').AsString)), 15) + //335
                          fPadR      (FieldByName('ESTADO').AsString          , 02)      + //350
                          fPadR      (strObsAgru                              , 40)      + //352
                          fPadR      (iif((strInstru1 = '06') Or
                                          (strInstru2 = '06'), strDiaPro, '') , 02)      + //392
                          fPadR      (' '                                     , 01)      + //394
                          fStrZero   (IntToStr(intCodSeq)                     , 06);       //395

          If (strEnvCaracEsp <> 'S') Then
              strTransacao := fTiraCaracEspeciais(strTransacao, False);

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       strNosNum,
                       0,
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
      strTrailler := '9'                                + //001
                     fPadR   (' '                , 393) + //002
                     fStrZero(IntToStr(intCodSeq), 006);  //395

      strTrailler := fTiraCaracEspeciais(strTrailler, False);

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
      CloseFile(txtTexto);
      DeleteFile(strFilePath);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);
      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;

end;

procedure TfrmExpArqRemBrasil.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBrasil.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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


function TfrmExpArqRemBrasil.fRetEmpresa: String;
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



procedure TfrmExpArqRemBrasil.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

function TfrmExpArqRemBrasil.fSetSacadorAvalista(strSacAvalista,
  strCpfCnpj: String): String;
begin
	Result := '';

  if Length(fTiraCaracEspeciaisPonto(strCpfCnpj)) <= 11 then
  Begin
    Result := fPadR(strSacAvalista, 25) + fPadR(' ', 01) +
    fPadr('CPF', 03) +	fPadr(fTiraCaracEspeciaisPonto(strCpfCnpj), 11);
  End
  Else
  Begin
  	Result := fPadR(strSacAvalista, 21) + fPadR(' ', 01) +
    	fPadr('CNPJ', 04) +	fPadr(fTiraCaracEspeciaisPonto(strCpfCnpj), 14);
  End;
end;

function TfrmExpArqRemBrasil.fValidaCampos(Sender: TWinControl;
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

function TfrmExpArqRemBrasil.RetornaComando(AOcorrencia: String): String;
begin
  Result := '01';

  If Not AOcorrencia.IsEmpty Then
    Result := fStrZero(AOcorrencia, 02);
end;

function TfrmExpArqRemBrasil.RetornaInstrucao(AComando, AInstrucao: String): String;
begin
  Result := AInstrucao;

  If AComando = '02' Then
    Result := '44';
end;

end.
