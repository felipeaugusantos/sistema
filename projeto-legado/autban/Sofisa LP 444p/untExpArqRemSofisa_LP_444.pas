unit untExpArqRemSofisa_LP_444;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, DBMemoFocus, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemSofisa_LP_444 = class(TfrmPai)
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

    qryRemessa : TUniQuery;
    strCodBco  : String;
    strCartei  : String;

    strNomEmp    : String;
    fltValMulta  : Double;
    strValMulta  : String;
    strDiaMora   : String;
    strNosNumEmp : String;
    strBcoCamComp : String;

    function fRetEmpresa: String;
    function fRetDupAgrupadas(strNumAgr, strCodCli: String): String;
    procedure pAtualizaHistoricoDuplicata(strNumDup, strParcel, strEspDoc,
      strCodEmp, strCodCli: String);
    function fCriarQueryRemessa: TUniQuery;
    procedure fDeletaArquivoPath(strPath: String);
    function fGetSqlRemessa: String;
    function fRetornaChaveNfe(StrChvNfe: String): String;
    function fRetornaDiaPro(AstrInstru1, AstrInstru2: String): String;
    function fRetornaStrDuplicatasAgrupadas(AstrEspDoc, AstrNumDup,
      AstrCodCli: String): String;
    function fValidacoesParaExportacao: Boolean;
    procedure pGravaLogctr;
    //procedure pValidaEnvioBoletoEmpresaOuBanco(AStrResp, ANosNum: String);
    procedure pVerificaMulta(strPerMul, strTipo: String);
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemSofisa_LP_444: TfrmExpArqRemSofisa_LP_444;

implementation

uses  untFuncoes, untfuncoesSimples, untFuncAutBan, untConstantes, Data.DB, untTypesSistema,
      untConsultas, untLogCtr, untFuncoesGenerica;

{$R *.dfm}

procedure TfrmExpArqRemSofisa_LP_444.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yy',VS_Date),2) +
                         '.TXT';
  pSetFocus(edtCodPor);

end;

function TfrmExpArqRemSofisa_LP_444.fValidacoesParaExportacao: Boolean;
  Var
    blnRemLoc   : Boolean;
    strNovCodEmp: String;
begin
  Result := True;

  If Not fVerificaCampos Then
  Begin
    Result := False;
    Exit;
  End;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
  Begin
    Result := False;
    Exit;
  End;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Result := False;
    Exit;
  End;

  {***************************************************
   * VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  *
   * CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- *
   * TE PARA A EMPRESA ATUAL(LOCAL)                  *
   ***********************************************ED*}
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG637LP444p', 'RELOCAL', '') = 'N' );

  strNovCodEmp := VS_strCodEmp;
  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;  //Abre bloco para escolher a empresa
  strNomEmp := fRetNomeEmpresa(strNovCodEmp);

  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Result := False;
    Exit;
  End;

end;

Procedure TfrmExpArqRemSofisa_LP_444.pVerificaMulta( strPerMul, strTipo : String );
Begin

  If strPerMul <> '' then
     fltValMulta  := StrToFloat(strPerMul)
  Else
     fltValMulta  := 0;

  If strTipo = '0' Then
  Begin
     fltValMulta := 0;
     strDiaMora  := '0';
  End
  Else
  Begin

    If strTipo = '2' Then
    Begin
       fltValMulta := fFormataFloat( fltValMulta, 4);
       strValMulta := Formatfloat('###,###,##0.0000',fltValMulta)
    End
    Else
    Begin
       fltValMulta := fFormataFloat( fltValMulta, 2);
       strValMulta := Formatfloat('###,###,##0.00',fltValMulta)
    End;

  End;

  strValMulta := AnsiReplaceStr(strValMulta, '.', '');
  strValMulta := AnsiReplaceStr(strValMulta, ',', '');

End;

Function TfrmExpArqRemSofisa_LP_444.fRetornaDiaPro(AstrInstru1, AstrInstru2 : String) : String;
Var
    sDiaProt : String;
Begin

  sDiaProt := StrToIntDef(fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'DIAPROT', '0'), 0).ToString;

  If ((AstrInstru1 = '10') or (AstrInstru2 = '10')) Then
       sDiaProt := '0';

  Result := sDiaProt;

End;

function TfrmExpArqRemSofisa_LP_444.fCriarQueryRemessa: TUniQuery;
begin
  Result := Nil;

  Try
    Result:= fCriaQuery(Self);
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Add(fGetSqlRemessa);
    Result.ParamByName('CODBCO').AsString := '637';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      Result.ParamByName('CODPOR').AsString := edtCodPor.Text;

    if (fCfgSis('CONREM', varString) = 'C') THEN
      Result.ParamByName('CARTEI').AsString := strCartei;

    Result.Open;
  Except
  On E: Exception Do
   Begin
     pMensagensErro(E.Message, '[TfrmExpArqRemSofisa_LP_444.fCriarQueryRemessa]');
   End;
  End;

end;

function TfrmExpArqRemSofisa_LP_444.fGetSqlRemessa: String;
  Var
    strSQL : String;
begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
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
    strSQL := strSQL + '                   CTR_CODCLI = CBI_CODCLI AND          ';
    strSQL := strSQL + '                   CTR_SEQBAI = 0 ';
    strSQL := strSQL + '  LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                        L.NFE_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                        L.NFE_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                        L.NFE_CODCLI = B.CBI_CODCLI AND ';
    strSQL := strSQL + '                        L.NFE_TIP_FC = "C"              ';
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

    Result := strSQL;

End;

{
procedure TfrmExpArqRemSofisa_LP_444.pValidaEnvioBoletoEmpresaOuBanco(AStrResp, ANosNum : String);
Begin

   //Validando se a empresa envia o boleto ou o banco;
   If (AStrResp = 'E') Then
   Begin
      strNosNumEmp  := ANosNum; // 13 caracteres
      strBcoCamComp := '033';   // Correspondente Santander;
   End;

End; }

Function TfrmExpArqRemSofisa_LP_444.fRetornaChaveNfe(StrChvNfe : String) : String;
Begin

  Result := '';

  If (Not fEmptyStr(StrChvNfe)) then
     Result := fPadL(StrChvNfe, 044, '0'); //401 - 444 CHAVE DA NF-E

End;

Function TfrmExpArqRemSofisa_LP_444.fRetornaStrDuplicatasAgrupadas(AstrEspDoc, AstrNumDup, AstrCodCli : String) : String;
Begin

   {***********************************************}
   {* SE FOR AGRUPAMENTO, INSERE OS NUMEROS DAS   *}
   {* DUPLICATAS AGRUPADAS, SENÃO DEIXA EM BRANCO *}
   {********************************************RV*}
   If (AstrEspDoc = 'AG') Then
       Result := fRetDupAgrupadas(AstrNumDup, AstrCodCli)
   Else
       Result := '';

End;

procedure TfrmExpArqRemSofisa_LP_444.pGravaLogctr;
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

procedure TfrmExpArqRemSofisa_LP_444.fDeletaArquivoPath(strPath : String);
Begin

   If FileExists(strPath) Then
      DeleteFile(strPath);

End;

procedure TfrmExpArqRemSofisa_LP_444.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strNomBco   : String;
    strContBco  : String;
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
    strAgenCob  : String;
    strDigAgenCob : String;

    strNosNum   : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    strDupAgr   : String;
    strEnvDpAg  : String;
    strMensagem : String;

    intCodSeq   : Integer;
    fltValTot   : Double;
    txtTexto    : TextFile;
    strCodRem   : String;

    strFilePath : String;
    strAutoIncremRem: String;
    AstrEndereco    : String;

    strTpMulta     : String;
    strOcorr       : string;
    strCfgValMulta : String;
    strAceito      : String;

    strUsaSac : String;
    strNomBen : String;
    strEndBen : String;
    strBaiBen : String;
    strCplBen : String;
    strCidBen : String;
    strEstBen : String;
    strCepBen : String;
    strCgcBen : String;

    strTipoInscEmp : String;

    strResp : string;

begin
  inherited;

  If Not fValidacoesParaExportacao Then
     Exit;

  strCodBco  := '637';
  strNomBco  := 'BANCO SOFISA SA';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strContBco := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'IDENTBC', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'CODCART', '');
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG637LP444p-' + IntToStr(intCartei), 'PROXNUM'), 6);
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  strResp    := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'RESPONS', '');

  strInstru1 := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'INSTRU2', '');
  //blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG637LP444p', 'RELOCAL', '') = 'N' );
  strAgenCob := '0000'; //IIF(strCodCar = '4',strCodAgen,'0000');
  strDigAgenCob := '0';

  strEnvDpAg := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'ENVDPAG', '');

  strAceito      := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'PROACEI', 'N');

  strTpMulta     := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'TPMULTA', '0');
  strCfgValMulta := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'PERMULT', '0');
  strDiaMora     := StrToIntDef(fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'DIAMORA', '0'), 0).ToString;
  strOcorr       := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'CODOCOR', '01');

  {*** SACADOR ***}
  strUsaSac  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'SACAVAL', '');
  strNomBen  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'NOMEBEN', '');
  strEndBen  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'ENDEBEN', '');
  strBaiBen  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'BAIRBEN', '');
  strCplBen  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'COMPBEN', '');
  strCidBen  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'CIDABEN', '');
  strEstBen  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'ESTABEN', '');
  strCepBen  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'CEP_BEN', '');
  strCgcBen  := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'CNPJBEN', '');

  pVerificaMulta( strCfgValMulta, strTpMulta );

  strDiaPro := fRetornaDiaPro(strInstru1, strInstru2);

  Try
    fStartTransaction;
    strCartei := 'CONFIG637LP444p-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  *  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    qryConsultaGen.Close;
    qryConsultaGen.SQL.Clear;
    qryConsultaGen.SQL.Add(strSQL);
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strCgcEmp := qryConsultaGen.FieldByName('EMP_C_G_C_').AsString;
    qryConsultaGen.Close;

    qryRemessa := fCriarQueryRemessa;

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
      strHeader := fPadR('0'                , 001)      + //001 - 001
                   fPadR('1'                , 001)      + //002 - 002
                   fPadR('REMESSA'          , 007)      + //003 - 009
                   fPadR('01'               , 002)      + //010 - 011
                   fPadR('COBRANCA'         , 015, ' ') + //012 - 026
                   fPadR(strContBco         , 020, ' ') + //027 - 046 - Identificação do Banco na Empresa
                   fPadR(strNomEmp          , 030, ' ') + //047 - 076
                   fPadR(strCodBco          , 003)      + //077 - 079
                   fPadR(strNomBco          , 015, ' ') + //080 - 094
                   fPadR(strDtaRem          , 006)      + //095 - 100
                   fPadR(' '                , 294)      + //101 - 394
                   fPadL(IntToStr(intCodSeq), 006, '0');  //395 - 400

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strHeader));

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG637LP444p-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      strTransacao := '';

      While Not qryRemessa.Eof Do
      Begin

        Inc(intCodSeq);
        Application.ProcessMessages;

        strCpfCgc := IIF( qryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 1, '2', '1' );

        strDtaVen := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                     FormatDateTime('yy',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);

        strDtaEmi := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('yy',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime);

        if not TEspecieParaArquivoRemessa.New.fValidaEspecie(qryRemessa.FieldByName('CBI_ESPDOC').AsString) then
        begin
          fRollBack;
          CloseFile(txtTexto);
          If FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) Then
            DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
          Exit;
        end;

        strKeyDup := fPadR(qryRemessa.FieldByName('CBI_NUMDUP').AsString, 12) +
                     fPadR(qryRemessa.FieldByName('CBI_PARCEL').AsString, 03) +
                     fPadR(qryRemessa.FieldByName('CBI_ESPDOC').AsString, 02) +
                     fPadR(qryRemessa.FieldByName('CBI_CODEMP').AsString, 03);

        //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
        AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

        strNosNum     := qryRemessa.FieldByName('CBI_NOSNUM').AsString; //11 caracteres
        strNosNumEmp  := '';   //13 caracteres
        strBcoCamComp := strCodBco;

        //pValidaEnvioBoletoEmpresaOuBanco( strResp,
        //                                  qryRemessa.FieldByName('CBI_NOSNUM').AsString );

        strCgcEmp := Trim(strCgcEmp);
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

        strCgcCli := Trim(qryRemessa.FieldByName('CBI_C_G_C_').AsString);
        strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
        strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
        strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

        strTipoInscEmp := IIF( length(strCgcEmp) > 11, '02', '01' );

        {************************************}
        {* VERIFICA SE USA SACADOR AVALISTA *}
        {************************************}
        {If (strUsaSac = 'S') Then
        Begin

           strCgcEmp := Trim(strCgcBen);  // cnpj/cpf do sacador;
           strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
           strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
           strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

           If length(strCgcEmp) > 11 Then // cnpj sacador
              strTipoInscEmp := '04'
           Else
              strTipoInscEmp := '03';     // cpf sacador
        End;}

        {**********************************}
        {* CALCULA O VALOR DA MORA DIARIA *}
        {*******************************JB*}
        fltValTot := qryRemessa.FieldByName('CBI_VALDUP').AsFloat * (qryRemessa.FieldByName('CBI_PORCEN').AsFloat / 100);

        strTransacao := fPadR      ('1'                                  , 01)      + //001 - 001
                        fPadR      (strTipoInscEmp                       , 02)      + //002 - 003
                        fPadL      (strCgcEmp                            , 14, '0') + //004 - 017 - cpf/cnpf da empresa ou sacador;
                        fPadR      (strContBco                           , 20, ' ') + //018 - 037 - Código do Cedente
                        fPadR      (strKeyDup                            , 25, ' ') + //038 - 062
                        fPadR      (strNosNum                            , 11)      + //063 - 073 - Nosso Numero - Identificação do Título no Banco
                        fPadL      (strNosNumEmp                         , 13, ' ') + //074 - 086 - Cobrança Direta Tit Corr.
                        fPadR      (' '                                  , 03)      + //087 - 089 - Nro Cart. no correspondente
                        fPadR      (strTpMulta                           , 01)      + //090 - 090 - Código da Multa
                        //fValNumForm(strValMulta                          , 13)      + //091 - 103 - Valor Ou tx. de Multa
                        fPadR      (fStrZero(strValMulta,13)             , 13, '0') + //091 - 103 - Valor Ou tx. de Multa
                        fPadL      (strDiaMora                           , 02, '0') + //104 - 105 - Número de Dias Após o Vencimento para aplicar a Multa
                        fPadR      (' '                                  , 02)      + //106 - 107 - Identificação da Operação no Banco
                        fPadR      (strCodCar                            , 01)      + //108 - 108 - Código da Carteira
                        fPadR      (strOcorr                             , 02)      + //109 - 110 - Identificação da ocorrência
                        fPadR      (RightStr(qryRemessa.FieldByName('CBI_NUMDUP').AsString +
                                             qryRemessa.FieldByName('CBI_PARCEL').AsString, 10), 10) + //111 - 120 - Numero de Documento de Cobrança
                        fPadR      (strDtaVen                            , 06)      + //121 - 126 - Data de vencimento do titulo
                        fValNumForm(qryRemessa.FieldByName('CBI_VALDUP').AsFloat    , 13)      + //127 - 139 - Valor Nominal do titulo
                        fPadR      (strBcoCamComp                        , 03)      + //140 - 142 - Numero do Banco na Camara de Compensação
                        fPadL      (strAgenCob                           , 04, '0') + //143 - 146 - Agencia Cobradora
                        fPadL      (strDigAgenCob                        , 01, '0') + //147 - 147 - Dig. auto conferencia da agencia cobradora
                        fPadR      ('01'                                 , 02)      + //148 - 149 - Especie do titulo
                        fPadR      (strAceito                            , 01)      + //150 - 150 - Aceito ou não aceito
                        fPadR      (strDtaEmi                            , 06)      + //151 - 156 - Data emissao titulo
                        fPadL      (strInstru1                           , 02, '0') + //157 - 158 - instrucao 01
                        fPadL      (strInstru2                           , 02, '0') + //159 - 160 - instrucao 02
                        fValNumForm(fltValTot                            , 13)      + //161 - 173 - Valor de Mora por dia de atraso;
                        fStrZero   ('0'                                  , 06)      + //174 - 179 - data limite para desconto;
                        fStrZero   ('0'                                  , 13)      + //180 - 192 - Valor do desconto a ser concedido
                        fStrZero   ('0'                                  , 13)      + //193 - 205 - Valor do IOF;
                        fStrZero   ('0'                                  , 13)      + //206 - 218 - Valor do Abatimento;
                        fPadL      (strCpfCgc                            , 02, '0') + //219 - 220 - tipo Identificação do sacado;
                        fPadL      (strCgcCli                            , 14, '0') + //221 - 234 - Numero de inscrição do sacado
                        fPadR      (qryRemessa.FieldByName('CLI_NOMCLI').AsString   , 30, ' ') + //235 - 264 - nome sacado
                        fPadR      (' '                                  , 10)      + //265 - 274 - Complemento do registro;
                        fPadR      (AstrEndereco                         , 40, ' ') + //275 - 314 - logradouro
                        fPadR      (qryRemessa.FieldByName('BAIRRO').AsString       , 12, ' ') + //315 - 326 - Bairro
                        fPadL      (qryRemessa.FieldByName('C_E_P_').AsString       , 08, '0') + //327 - 334 - Cep
                        fPadR      (qryRemessa.FieldByName('CIDADE').AsString       , 15, ' ') + //335 - 349 - Cidade
                        fPadR      (qryRemessa.FieldByName('ESTADO').AsString       , 02, ' ') + //350 - 351 - Estado
                        fPadR      (strNomEmp                            , 30, ' ') + //352 - 381 -
                        fPadR      (' '                                  , 04)      + //382 - 385
                        fPadR      (' '                                  , 06)      + //386 - 391
                        fPadL      (strDiaPro                            , 02, '0') + //392 - 393
                        fPadL      ('0'                                  , 01)      + //394 - 394
                        fPadL      (IntToStr(intCodSeq)                  , 06, '0');  //395 - 400

        strTransacao := strTransacao + fRetornaChaveNfe( qryRemessa.FieldByName('NFE_ACESSO').AsString ); //401 - 444 CHAVE DA NF-E

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,fRetirarCaracteresEspeciais(strTransacao));

          {******************************}
          {* DADOS DO SACADOR AVALISTA  *}
        {******************************}
        {If (strUsaSac = 'S') Then
        Begin

           strCgcBen := Trim(strCgcBen);
           strCgcBen := AnsiReplaceStr(strCgcBen, '.', '');
           strCgcBen := AnsiReplaceStr(strCgcBen, '/', '');
           strCgcBen := AnsiReplaceStr(strCgcBen, '-', '');

           strCepBen := Trim(strCepBen);
           strCepBen := AnsiReplaceStr(strCepBen, '.', '');
           strCepBen := AnsiReplaceStr(strCepBen, '-', '');

           strtipoInscCgcBen := IIF( length(strCgcBen) > 11, '02','01' );

           strRegSacador := '';
           Inc(intCodSeq);

           strRegSacador := fPadR('5'                                  ,  01)     + //001 - 001
                            fPadR(' '                                  , 120)     + //002 - 121
                            fPadR(strtipoInscCgcBen                    , 02)     + //122 - 123
                            fPadL(strCgcBen                            , 14, '0') + //124 - 137
                            fPadR(strEndBen                            , 40)      + //138 - 177
                            fPadR(strBaiBen                            , 12)      + //178 - 189
                            fPadR(strCepBen                            , 08)      + //190 - 197
                            fPadR(strCidBen                            , 15)      + //198 - 212
                            fPadR(strEstBen                            , 02)      + //213 - 214
                            fPadR(' '                                  ,180)      + //215 - 394
                            fPadL(IntToStr(intCodSeq)                  , 06, '0');  //395 - 400

           {****************************************}
           {* ESCREVE O SACADOR NA VARIAVEL NO TXT *}
           {****************************************}
        //   Writeln(txtTexto, strRegSacador);

        //End;

        {******************************}
        {* DADOS DA MENSAGEM VARIÁVEL *}
        {***************************RV*}
        If (strEnvDpAg = 'S') Then
        Begin
          strMensagem := '';
          Inc(intCodSeq);

          {***********************************************}
          {* SE FOR AGRUPAMENTO, INSERE OS NUMEROS DAS   *}
          {* DUPLICATAS AGRUPADAS, SENÃO DEIXA EM BRANCO *}
          {********************************************RV*}

          strDupAgr := fRetornaStrDuplicatasAgrupadas(qryRemessa.FieldByName('CBI_ESPDOC').AsString,
                                                      qryRemessa.FieldByName('CBI_NUMDUP').AsString,
                                                      qryRemessa.FieldByName('CBI_CODCLI').AsString);

          strMensagem := fPadR   ('2'                                  , 01)      + //001 - 001
                         fPadR   ('0'                                  , 01)      + //002 - 002
                         fPadR   (strDupAgr                            , 69)      + //003 - 071
                         fPadR   (' '                                  , 69)      + //072 - 140
                         fPadR   (' '                                  , 69)      + //141 - 209
                         fPadR   (' '                                  , 69)      + //210 - 278
                         fPadR   (' '                                  , 69)      + //279 - 347
                         fPadR   (' '                                  , 47)      + //348 - 394
                         fPadL   (IntToStr(intCodSeq)                  , 06, '0');  //395 - 400

            {**************************************}
            {* ESCREVE A MENSAGEM VARIAVEL NO TXT *}
            {***********************************RV*}
            Writeln(txtTexto, fRetirarCaracteresEspeciais(strMensagem));

          End;

        {*****************************}
        {* GRAVAÇÃO DA TABELA REMDET *}
        {**** DETALHES DA REMESSA ****}
        {**************************MO*}
        pGravaRemDet(strAutoIncremRem,
                     qryRemessa.FieldByName('AUTOINCREM').AsString,
                     qryRemessa.FieldByName('CBI_NOSNUM').AsString,
                     0,
                     qryRemessa.FieldByName('CBI_VALDUP').AsFloat,
                     qryRemessa.FieldByName('CTR_DTAREC').AsDateTime,
                     qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime,
                     VS_Date,
                     strLoginUsuarioLogado,
                     '');

        qryRemessa.Next;
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
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strTrailler));

      CloseFile(txtTexto);

      qryRemessa.First;

      While Not qryRemessa.Eof Do
      Begin
        pAtualizaHistoricoDuplicata(qryRemessa.FieldByName('CBI_NUMDUP').AsString,
                                    qryRemessa.FieldByName('CBI_PARCEL').AsString,
                                    qryRemessa.FieldByName('CBI_ESPDOC').AsString,
                                    qryRemessa.FieldByName('CBI_CODEMP').AsString,
                                    qryRemessa.FieldByName('CBI_CODCLI').AsString);
        qryRemessa.Next;
      End;

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
//      fFecharTabela(frmModuloSPR.qryGen005);
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

      fDeletaArquivoPath(strFilePath);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);

      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;
end;

procedure TfrmExpArqRemSofisa_LP_444.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemSofisa_LP_444.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      if fValidaCampos(edtCodPor) then
        Self.SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

function TfrmExpArqRemSofisa_LP_444.fRetDupAgrupadas(strNumAgr,
  strCodCli: String): String;
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

      qryAgr.Close;
      qryAgr.SQL.Clear;
      qryAgr.SQL.Add(strSQL);

      qryAgr.ParamByName('NUMAGR').AsString := strNumAgr;
      qryAgr.ParamByName('CODCLI').AsString := strCodCli;

      qryAgr.Open;

      strDupAgr := '';
      intQtdDup := 1;
      strInsBar := 'N';

      While Not qryAgr.Eof Do
      Begin
        {***************************************}
        {* LIMITA A QUANTIDADE DE 8 DUPLICATAS *}
        {* PARA NÃO EXCEDER A QTDE DE CARACTER *}
        {* DISPONÍVEL.(TOTAL = 69)             *}
        {************************************IV*}
        If (intQtdDup <= 8) Then
        Begin
          If (strInsBar = 'N') Then
          Begin
            strDupAgr := qryAgr.FieldByName('NUMDUP').AsString;
            strInsBar := 'S';
          End
          Else
          Begin
            strDupAgr := strDupAgr + '/' + qryAgr.FieldByName('NUMDUP').AsString;
          End;
        End;

        Inc(intQtdDup);

        qryAgr.Next;
      End;

      Result := strDupAgr;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmExpArqRemSantander.fRetDupAgrupadas]');
    End;

  Finally
    FreeAndNil(qryAgr);
  End;
end;

function TfrmExpArqRemSofisa_LP_444.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

Begin

  qryCadEmp := fCriaQuery(Self);

  qryCadEmp.Close;
  qryCadEmp.SQL.Clear;
  qryCadEmp.SQL.Add('SELECT * FROM CADEMP');
  qryCadEmp.Open;

  SetLength(arrResult, qryCadEmp.RecordCount);
  intCount := 0;

  While Not qryCadEmp.Eof Do
  Begin
    arrResult[intCount] := fStrZero(qryCadEmp.FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
    qryCadEmp.Next;
    Inc(intCount);
  End;

  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);

  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;

function TfrmExpArqRemSofisa_LP_444.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemSofisa_LP_444.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemSofisa_LP_444.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

procedure TfrmExpArqRemSofisa_LP_444.pAtualizaHistoricoDuplicata(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String);
begin
  fExecutaSQL(' UPDATE CADREC ' +
              ' SET CTR_HIST01 = ' +
              '         CONCAT("REMESSA: ", ' +
              '               ' + QuotedStr(edtNomArquivo.Text) + ', ' +
              '               ' + QuotedStr(STRING_QUEBRA) + ', IFNULL(CTR_HIST01, "")) ' +
              ' WHERE ' +
              '   CTR_NUMDUP = ' + QuotedStr(strNumDup) + ' AND ' +
              '   CTR_PARCEL = ' + QuotedStr(strParcel) + ' AND ' +
              '   CTR_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ' +
              '   CTR_CODEMP = ' + QuotedStr(strCodEmp) + ' AND ' +
              '   CTR_CODCLI = ' + QuotedStr(strCodCli) );
end;

end.
