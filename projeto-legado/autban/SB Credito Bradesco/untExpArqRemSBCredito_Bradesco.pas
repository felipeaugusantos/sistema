unit untExpArqRemSBCredito_Bradesco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, frxClass,  Data.DB,
  untTypesSistema, untConsultas, frxExportCSVTestabilidade, untFuncAutban,
  untLogCtr, untConstantes,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemSBCredito_Bradesco = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRemessa: TLabel;
    lblNomArq: TLabel;
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
  private

    qryConsultaGen : TUniQuery;
    qryCadPor   : TUniQuery;

    strNomEmp   : String;

    function fRetEmpresa: String;
    function fRetornaChaveNfe(StrChvNfe: String): String;
    function fRetornaCpfCgc(IntTipo: Integer): String;
    function fRetornaExportarNaRemessa: String;
    function fRetornaFoneCliente(strFoneCli01, strFoneCli02: String): String;
    function fRetornaInstrucao02(strInstrucao01: String): String;
    function fRetornaObservacao(StrEspDoc: String): String;
    function fRetornaResponsavelEmissao: String;
    function fRetornaSqlRemessa: String;
    function fValidaRemessa: Boolean;
    procedure pDeleteCadCbi(sCodBco, AstrCartei: String);
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;       
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemSBCredito_Bradesco: TfrmExpArqRemSBCredito_Bradesco;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmExpArqRemSBCredito_Bradesco.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'PATHREM',''));

  edtNomArquivo.Text  := 'CB' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         'A.REM';

  pSetFocus(edtCodPor);
end;

Function TfrmExpArqRemSBCredito_Bradesco.fRetornaSqlRemessa() : String;
 Var
     strSQL : string;
Begin
    Result := '';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_EMCOB1, ';
    strSQL := strSQL + '  C.CLI_EMCOB2, ';
    strSQL := strSQL + '  C.CLI_EMAIL_, ';
    strSQL := strSQL + '  C.CLI_EMAIL2, ';
    strSQL := strSQL + '  C.CLI_EMAIL3, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  C.CLI_FONE01, ';
    strSQL := strSQL + '  C.CLI_FONE02, ';
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
                                                  '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO,  ';
    strSQL := strSQL + '  L.NFE_ACESSO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B  ';
    strSQL := strSQL + '  JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI     ';
    strSQL := strSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '                   CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '                   CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '                   CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '                   CTR_CODCLI = CBI_CODCLI     ';

    strSQL := strSQL + '  LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                        L.NFE_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                        L.NFE_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                        L.NFE_CODCLI = B.CBI_CODCLI AND ';
    strSQL := strSQL + '                        L.NFE_TIP_FC = "C" ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CLI_CODCLI = CBI_CODCLI AND ';
    strSQL := strSQL + '  CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = CBI_CODCLI AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL ';


    IF fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CBI_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    result := strSQL;

End;

Function TfrmExpArqRemSBCredito_Bradesco.fRetornaFoneCliente(strFoneCli01, strFoneCli02 : String) : String;
Begin
  Result := '';
  If Not FEmptyStr(strFoneCli01) Then
     Result := fRetSomenteNumeros(strFoneCli01)
  Else
     Result := fRetSomenteNumeros(strFoneCli02);
End;

Function TfrmExpArqRemSBCredito_Bradesco.fRetornaObservacao(StrEspDoc : String) : String;
Begin
  Result := '';
  If StrEspDoc = 'AG' Then
     Result := Trim(Copy(StrEspDoc, 11, 60))
  Else
     Result := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'OBSERV1', '');
End;

Function TfrmExpArqRemSBCredito_Bradesco.fValidaRemessa : Boolean;
 Var
     strNovCodEmp : String;
     blnRemLoc    : Boolean;
Begin
  Result := True;

  If Not fVerificaCampos Then
  Begin
     Exit;
     Result := False;
  End;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
  Begin
     Result := false;
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

  //*****************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERACAO DE //
  // REMESSA PARA TODAS AS EMPRESAS OU SOMENTE PARA A    //
  // EMPRESA ATUAL(LOCAL)                                //
  //*****************************************************//
  blnRemLoc  := Not( fGetBancoConfig(0,'CONFIG987', 'RELOCAL', '') = 'N' );

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
    Result := False;
    Exit;
  End;

End;

Function TfrmExpArqRemSBCredito_Bradesco.fRetornaInstrucao02(strInstrucao01 : String) : String;
Begin

  If MatchStr(strInstrucao01, ['06','05','18']) Then
     Result := fStrZero(fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'DIAPROT', ''),2)
  Else
     Result := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'INSTRU2', '');

End;

Function TfrmExpArqRemSBCredito_Bradesco.fRetornaResponsavelEmissao() : String;
Begin

  Result := '1';
  If (fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'RESPONS', '') = 'E') Then
    Result := '2';

End;

Function TfrmExpArqRemSBCredito_Bradesco.fRetornaExportarNaRemessa() : String;
 Var
     sExpRem : String;
Begin

  sExpRem := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'EXPOREM', '');
  If fEmptyStr( sExpRem ) Then
     sExpRem := '1';

  Result := sExpRem;

End;

Function TfrmExpArqRemSBCredito_Bradesco.fRetornaCpfCgc(IntTipo : Integer) : String;
Begin

  Result := '1';

  If IntTipo = 0 Then
     Result := '99'
  Else If IntTipo = 1 Then
     Result := '2'
  Else
     Result := '1';

End;

Function TfrmExpArqRemSBCredito_Bradesco.fRetornaChaveNfe(StrChvNfe : String) : String;
Begin

  Result := '';

  If (Not fEmptyStr(StrChvNfe)) then
     Result := fPadL(StrChvNfe, 044, '0'); //401 - 444 CHAVE DA NF-E

End;

Procedure TfrmExpArqRemSBCredito_Bradesco.pDeleteCadCbi(sCodBco, AstrCartei: String);
Var
   sSql : String;
   qryDelCadCbi  : TUniQuery;
Begin

  Try

    Try
      qryDelCadCbi := fCriaQuery(Self);

      sSql := '';
      sSql := sSql + 'DELETE FROM ';
      sSql := sSql + '  CADCBI ';
      sSql := sSql + 'WHERE ';
      sSql := sSql + 'CBI_CODBCO = :CODBCO ';

      If (Not fEmptyStr(edtCodPor.Text)) Then
         sSql := sSql + '  AND CBI_CODPOR = :CODPOR ';

      IF fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
         sSql := sSql + '  AND CBI_CARTEI = :CARTEI ';

      qryDelCadCbi.Close;
      qryDelCadCbi.SQL.Clear;
      qryDelCadCbi.SQL.Add(sSql);
      qryDelCadCbi.ParamByName('CODBCO').AsString := sCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
          qryDelCadCbi.ParamByName('CODPOR').AsString := edtCodPor.Text;

      IF fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
         qryDelCadCbi.ParamByName('CARTEI').AsString := AstrCartei;

      qryDelCadCbi.ExecSQL;
    Except
      On E : Exception do
         pMensagensErro(E.Message, '[pDeleteCadCbi]');
    End;

  Finally
    If Assigned(qryDelCadCbi) Then
       freeAndNil(qryDelCadCbi);
  End;

End;

procedure TfrmExpArqRemSBCredito_Bradesco.btnGerarClick(Sender: TObject);
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
    strCodRem   : String;
    strCpfCgc   : String;
    strEmpBco   : String;
    strNumAut   : String;
    strCodAge   : String;
    strCntCor   : String;
    strDigCnt   : String;
    strIdeEmp   : String;
    strCodCar   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strInstru2  : String;
    strObserv   : String;
    strNumDup   : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strRespon   : String;
    strNosNum   : String;
    strExpRem   : String;
    strCartei: String;

    strUsaSac   : String;
    strBenefi,
    strSacAva,
    strSacEnd,
    strSacCEP,
    strSacCid,
    strSacEst   : String;

    fltPerMul   : Double;

    qryRemessa  : TUniQuery;

    strAutoIncremRem: String;
    AstrEndereco    : String;

    strSacFone  : String;
begin
  inherited;

  If Not fValidaRemessa() Then
     Exit;

  strSacFone := '';

  intCodSeq  := 1;
  strCodBco  := '987';
  strNomBco  := 'BRADESCO';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG987-' + IntToStr(intCartei), 'PROXNUM'), 7);

  strNumAut  := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'NUMAUTO', '');
  strCodAge  := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'CODAGEN', '');
  strEmpBco  := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'CODEMPR', '');
  strCntCor  := RightStr(fStrZero(fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'NUMCTAC', ''), 7), 7);
  strDigCnt  := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'CODCART', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'INSTRU1', '');

  strInstru2 := fRetornaInstrucao02(strInstru1);

  strObserv  := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'OBSERV1', '');

  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'PERMULT', '') );

  strUsaSac  := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'SACAVAL', '');
  strBenefi  := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'NOMEBEN', '');

  strRespon := fRetornaResponsavelEmissao;

  strDiaPro := '00';

  strExpRem := fRetornaExportarNaRemessa;

  Try
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  E.*,  C.CID_NOMCID, C.CID_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP E ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = E.EMP_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    qryConsultaGen.Close;
    qryConsultaGen.SQL.Clear;
    qryConsultaGen.SQL.Add(strSQL);
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strCgcEmp := qryConsultaGen.FieldByName('EMP_C_G_C_').AsString;

    If strUsaSac = 'S' Then
    Begin
      strSacAva := fPadL(fTiraCaracEspeciaisPonto(strCgcEmp), 015, '0') + '  ' + fPadR(strNomEmp, 043);
      strSacEnd := fPadR(qryConsultaGen.FieldByName('EMP_ENDERE').AsString + ', ' +
                         qryConsultaGen.FieldByName('EMP_ENDNUM').AsString + ' ' +
                         qryConsultaGen.FieldByName('EMP_BAIRRO').AsString, 045);
      strSacCEP := fPadR(FRetSomenteNumeros(qryConsultaGen.FieldByName('EMP_C_E_P_').AsString), 008, '0');
      strSacCid := fPadR(qryConsultaGen.FieldByName('CID_NOMCID').AsString, 020);
      strSacEst := fPadR(qryConsultaGen.FieldByName('CID_ESTADO').AsString, 002);
    End;

    qryConsultaGen.Close;

  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try
    strCartei  := 'CONFIG987-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := fRetornaSqlRemessa();

    qryRemessa.Close;
    qryRemessa.SQL.Clear;
    qryRemessa.SQL.Add(strSQL);
    qryRemessa.ParamByName('CODBCO').AsString := strCodBco;

    If (Not fEmptyStr(edtCodPor.Text)) Then
       qryRemessa.ParamByName('CODPOR').AsString := edtCodPor.Text;

    If fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
       qryRemessa.ParamByName('CARTEI').AsString := StrCartei;

    qryRemessa.Open;

    strCodBco  := '237';
    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      strHeader := '';


      strHeader := fPadR   ('0'                , 001)      + //001
                   fPadR   ('1'                , 001)      + //002
                   fPadR   ('REMESSA'          , 007)      + //003
                   fPadR   ('01'               , 002)      + //010
                   fPadR   ('COBRANCA'         , 015)      + //012
                   fPadL   (strEmpBco          , 020, '0') + //027
                   fPadR   (strNomEmp          , 030)      + //047
                   fPadR   (strCodBco          , 003)      + //077
                   fPadR   (strNomBco          , 015)      + //080
                   fPadR   (strDtaRem          , 006)      + //095
                   fPadR   (' '                , 008)      + //101
                   fPadR   ('MX'               , 002)      + //109
                   fPadR   (strCodRem          , 007)      + //111
                   fPadR   (' '                , 277)      + //118
                   fStrZero('1'                , 006);       //395

      //*************************************************//
      // FOI CRIADO UM CAMPO NA CONFIGURACAO DO Redasset //
      // POIS SEGUNDO OS ATENDENTES EXISTEM 2 SITUACOES  //
      // PARA A GERACAO DE REMESSA BANCARIA.             //
      // O HEADER NAO MUDA.  ....VER ACIMA               //
      //**********************************************ED*//
      If strExpRem = '2' Then
        strEmpBco := strCntCor + strDigCnt;     

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, '987', 'CONFIG987-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);


      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      strTransacao := '';

      While Not qryRemessa.Eof Do
      Begin

        strSacFone  := '';

        strSacFone := fRetornaFoneCliente(qryRemessa.FieldByName('CLI_FONE01').AsString, qryRemessa.FieldByName('CLI_FONE02').AsString);

        strObserv  := fRetornaObservacao( qryRemessa.FieldByName('CBI_ESPDOC').AsString );

        Inc(intCodSeq);
        Application.ProcessMessages;

        fltValAtr := fFormataFloat((qryRemessa.FieldByName('CBI_VALDUP').AsFloat *
                                    qryRemessa.FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

        strCpfCgc := fRetornaCpfCgc( qryRemessa.FieldByName('CBI_CGCCPF').AsInteger );

        strDtaVen := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                     FormatDateTime('yy',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);

        strDtaEmi := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('yy',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime);

        strNumDup := (qryRemessa.FieldByName('CBI_NUMDUP').AsString) + (qryRemessa.FieldByName('CBI_PARCEL').AsString);

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

        strCgcEmp := Trim(strCgcEmp);
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
        strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

        strCgcCli := Trim(qryRemessa.FieldByName('CBI_C_G_C_').AsString);
        strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
        strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
        strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

        {*******************************************}
        {* SE BANCO EMITE BOLETO                   *}
        {****************************************MV*}
        strNosNum := qryRemessa.FieldByName('CBI_NOSNUM').AsString;
        If (strRespon = '1') Then
          strNosNum := '0';

        strIdeEmp := '0'                    + //021
                     RightStr(fStrZero(strCodCar, 3), 3) + //022
                     RightStr(fStrZero(strCodAge, 5), 5) + //025
                     RightStr(fStrZero(strCntCor, 7), 7) + //030
                     RightStr(fStrZero(strDigCnt, 1), 1);  //037

         strTransacao := fPadR     ('1'                                       , 01)      + //001
                        fStrZero   ('0'                                       , 05)      + //002
                        fPadR      (' '                                       , 01)      + //007
                        fStrZero   ('0'                                       , 05)      + //008
                        fStrZero   ('0'                                       , 07)      + //013
                        fPadR      (' '                                       , 01)      + //020
                        fPadR      (strIdeEmp                                 , 17)      + //021
                        fPadR      (strKeyDup                                 , 25)      + //038
                        fPadR      ('000'                                     , 03)      + //063
                        fPadR      (IIF(fltPerMul > 0, '2', '0')              , 01)      + //066 (2) P\ CONSIDERAR O PERCENTUAL DE MULTA
                        fValNumForm(fltPerMul                                 , 04)      + //067 PERCENTUAL DE MULTA A SER CONSIDERADO
                        fStrZero   (strNosNum                                 , 12)      + //071
                        fStrZero   ('0'                                       , 10)      + //083
                        fPadR      (strRespon                                 , 01)      + //093
                        fPadR      (' '                                       , 01)      + //094
                        fPadR      (' '                                       , 10)      + //095
                        fPadR      (' '                                       , 01)      + //105
                        fPadR      ('2'                                       , 01)      + //106
                        fPadR      (' '                                       , 02)      + //107
                        fPadR      ('01'                                      , 02)      + //109
                        fPadR      (RightStr(qryRemessa.FieldByName('CBI_NUMDUP').AsString, 09)+
                                    qryRemessa.FieldByName('CBI_PARCEL').AsString        , 10)      + //111
                        fPadR      (strDtaVen                                 , 06)      + //121
                        fValNumForm(qryRemessa.FieldByName('CBI_VALDUP').AsFloat         , 13)      + //127
                        fStrZero   ('0'                                       , 03)      + //140
                        fStrZero   ('0'                                       , 05)      + //143
                        fPadR      ('01'                                      , 02)      + //148
                        fPadR      ('N'                                       , 01)      + //150
                        fPadR      (strDtaEmi                                 , 06)      + //151
                        fPadR      (strInstru1                                , 02)      + //157
                        fPadR      (IIF(strInstru1 = '06',strDiaPro,strInstru2) , 02)    + //159 Protesto
                        fValNumForm(fltValAtr                                 , 13)      + //161
                        fPadR      (strDtaVen                                 , 06)      + //174
                        fValNumForm(qryRemessa.FieldByName('CBI_DESSUJ').AsFloat         , 13)      + //180
                        fStrZero   ('0'                                       , 13)      + //193
                        fStrZero   ('0'                                       , 13)      + //206
                        fStrZero   (strCpfCgc                                 , 02)      + //219
                        fPadL      (strCgcCli                                 , 14, '0') + //221
                        fPadR      (qryRemessa.FieldByName('CLI_NOMCLI').AsString        , 40)      + //235
                        fPadR      (AstrEndereco                              , 40)      + //275
                        fPadR      (' '                                       , 12)      + //315
                        fPadL      (LeftStr(qryRemessa.FieldByName('C_E_P_').AsString,5) , 05, '0') + //327
                        fPadL      (RightStr(qryRemessa.FieldByName('C_E_P_').AsString,3), 03, '0') + //332
                        fPadR      (strSacFone                                , 10)      + //335
                        fPadR      (IIF(strUsaSac='S',strSacAva,strObserv)    , 50)      + //346
                        fStrZero   (IntToStr(intCodSeq)                       , 06);       //395

        strTransacao := strTransacao + fRetornaChaveNfe( qryRemessa.FieldByName('NFE_ACESSO').AsString );

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************AF*}
        Writeln(txtTexto,strTransacao);

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

        {****************}
        {* GRAVA LOGCTR *}
        {*************JS*}
        untLogCtr.GravaLogCtr(qryRemessa.FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - 987', Self.Name);

        qryRemessa.Next;
      End;

      strCodBco := '987';
      {************}
      {* TRAILLER *}
      {*********AF*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                + //001
                     fPadR   (' '                , 393) + //002
                     fStrZero(IntToStr(intCodSeq), 006);  //395

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      pBackupCnfBco;

      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

      pDeleteCadCbi(strCodBco, strCartei);

    End
    Else
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);

  Finally
    FreeAndNil(qryRemessa);
  End;

end;

procedure TfrmExpArqRemSBCredito_Bradesco.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemSBCredito_Bradesco.edtCodPorKeyPress(Sender: TObject;
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

function TfrmExpArqRemSBCredito_Bradesco.fRetEmpresa: String;
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

  {**************}
  {* 14/01/2011 *}
  {***********RV*}
  intCount := 1;

  If Length(arrResult) > 1 Then
     intCount := fGetMenu('Selecione a Empresa', arrResult, 0);

  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;

function TfrmExpArqRemSBCredito_Bradesco.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemSBCredito_Bradesco.FormCreate(Sender: TObject);
begin
  inherited;
   qryCadPor := fCriaQuery(Self); 
end;

end.
