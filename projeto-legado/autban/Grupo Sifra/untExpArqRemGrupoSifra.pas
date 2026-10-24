unit untExpArqRemGrupoSifra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, frxClass,  Data.DB,
  untTypesSistema, untConsultas, frxExportCSVTestabilidade, untFuncAutban,
  untLogCtr, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemGrupoSifra = class(TfrmPai)
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
   { Private declarations }
    qryRemessa  : TUniQuery;

    {Inforções Carteira}
    strInstru2  : String;
    strInstru1  : String;
    strRespon   : String;
    strNomEmp   : String;
    strCodBco   : String;
    strCartei   : String;
    strCpfCgc   : String;
    strNosNum   : String;
    strDiaPro   : String;
    qryConsultaGen : TUniQuery;
    qryCadPor   : TUniQuery;
    function fRetEmpresa: String;
    function fRetornaSequencialRemessa(strIdeBanco : String): String;
    procedure pAtualizaSequencialRemessa;
    function fValidaInstrucao02(strInstrucao01: String): Boolean;
    function fValidacoesParaExportacao:Boolean;
    procedure pValidaInformacoesCarteira;
    procedure pValidaInformacoesRemessa;
    function fCriarQueryRemessa:TUniQuery;
    function fGetSqlRemessa: String;
    procedure pApagarCADCBI;
    procedure pGravarLOGCTR;
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemGrupoSifra: TfrmExpArqRemGrupoSifra;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmExpArqRemGrupoSifra.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'PATHREM',''));

  edtNomArquivo.Text  := fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'CODSACA', '') +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         '.C'+
                         fStrZero(fRetornaSequencialRemessa('CONFIG979-' + IntToStr(intCartei)),02);

  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemGrupoSifra.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strNomBco   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodRem   : String;
    strEmpBco   : String;
    strNumAut   : String;
    strCodAge   : String;
    strCntCor   : String;
    strDigCnt   : String;
    strIdeEmp   : String;
    strCodCar   : String;
    strHeader   : String;
    strTransacao: String;
    strTransXML : String;
    strTrailler : String;
    intCodSeq   : Integer;
    //fltValAtr   : Double;
    txtTexto    : TextFile;
    strAutoIncremRem: String;
    AstrEndereco : String;
begin
  inherited;
  If Not fValidacoesParaExportacao Then
    Exit;

  intCodSeq  := 1;
  strCodBco  := '979';
  strNomBco  := 'SIFRA';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG979-' + IntToStr(intCartei), 'PROXNUM'), 7);
  strNumAut  := fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'NUMAUTO', '');
  strCodAge  := fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'CODAGEN', '');
  strEmpBco  := fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'CODEMPR', '');
  strCntCor  := RightStr(fStrZero(fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'NUMCTAC', ''), 7), 7);
  strDigCnt  := fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'CODCART', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  strInstru1 := fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'INSTRU1', '');
  strDiaPro := '00';

  pValidaInformacoesCarteira;

  Try
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
  Finally
    pFreeAndNil(qryConsultaGen);
  End;

  Try
    strCartei  := 'CONFIG979-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriarQueryRemessa;
    //strCodBco  := '237';

    If qryRemessa.IsEmpty Then
    Begin
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
      Exit;
    End;

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
                 fPadR   ('000'              , 003)      + //077
                 fPadR   (strNomBco          , 015)      + //080
                 fPadR   (strDtaRem          , 006)      + //095
                 fPadR   (' '                , 008)      + //101
                 fPadR   ('MX'               , 002)      + //109
                 fPadR   (strCodRem          , 007)      + //111
                 fPadR   (' '                , 277)      + //118
                 fStrZero('1'                , 006);       //395

    {***************************}
    {* ESCREVE O HEADER NO TXT *}
    {************************AF*}
    Writeln(txtTexto,strHeader);

    {*****************************}
    {* GRAVAÇÃO DA TABELA REMGER *}
    {** DADOS GERAIS DA REMESSA **}
    {**************************MO*}
    pGravaRemGer(VS_strCodEmp, '979', 'CONFIG979-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

    {************************}
    {* TRANSAÇÃO DO ARQUIVO *}
    {*********************AF*}
    strTransacao := '';

    While Not qryRemessa.Eof Do
    Begin

      Inc(intCodSeq);
      Application.ProcessMessages;

//      fltValAtr := fFormataFloat((qryRemessa.FieldByName('CBI_VALDUP').AsFloat *
//                                  qryRemessa.FieldByName('CBI_PORCEN').AsFloat) / 100, 2);
      pValidaInformacoesRemessa;

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

      strCgcEmp := Trim(strCgcEmp);
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

      strCgcCli := Trim(qryRemessa.FieldByName('CBI_C_G_C_').AsString);
      strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
      strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
      strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

      strIdeEmp := '0'                                 + //021 A 021
                   RightStr(fStrZero(strCodCar, 3), 3) + //022 A 024
                   RightStr(fStrZero(strCodAge, 5), 5) + //025 A 029
                   RightStr(fStrZero(strCntCor, 7), 7) + //030 A 036
                   RightStr(fStrZero(strDigCnt, 1), 1);  //037 A 037

       strTransacao := fPadR     ('1'                                            , 01) + //001
                      fStrZero   ('0'                                            , 05) + //002
                      fStrZero   ('0'                                            , 01) + //007
                      fStrZero   ('0'                                            , 05) + //008
                      fStrZero   ('0'                                            , 07) + //013
                      fStrZero   ('0'                                            , 01) + //020
                      fPadR      (strIdeEmp                                      , 17) + //021 A 037
                      fPadR      (qryRemessa.FieldByName('CLI_FONE01').AsString  , 25) + //038
                      fPadR      ('000'                                          , 03) + //063
                      fStrZero   ('0'                                            , 05) + //066
                      fPadR      (strNosNum                                      , 12) + //071
                      fStrZero   ('0'                                            , 10) + //083 Numero do pedido do cliente
                      fPadR      (' '                                            , 02) + //093 A 094
                      fPadR      (qryRemessa.FieldByName('NFE_NUMDOC').AsString  , 10) + //095 Numero da Nota Fiscal
                      fPadR      (' '                                            , 06) + //105 A 110
                      fPadR      (RightStr(qryRemessa.FieldByName('CBI_NUMDUP').AsString, 09)+
                                  qryRemessa.FieldByName('CBI_PARCEL').AsString  , 10) + //111
                      fPadR      (strDtaVen                                      , 06) + //121 A 126
                      fValNumForm(qryRemessa.FieldByName('CBI_VALDUP').AsFloat   , 13) + //127 A 139
                      fStrZero   ('0'                                            , 08) + //140 A 147
                      fPadR      ('01'                                           , 02) + //148 A 149
                      fPadR      ('N'                                            , 01) + //150
                      fPadR      (strDtaEmi                                      , 06) + //151 A 156
                      fPadR      (' '                                            , 17) + //157 A 173
                      fPadR      (strDtaVen                                      , 06) + //174 A 179
                      fValNumForm(qryRemessa.FieldByName('CBI_DESSUJ').AsFloat   , 13) + //180 A 192
                      fPadR      (' '                                            , 26) + //193 A 218
                      fStrZero   (strCpfCgc                                      , 02) + //219 A 220
                      fPadL      (strCgcCli                                      , 14, '0') + //221
                      fPadR      (qryRemessa.FieldByName('CLI_NOMCLI').AsString  , 40) + //235 A 274
                      fPadR      (AstrEndereco                                   , 40) + //275 A 314
                      fPadR      (' '                                            , 12) + //315 A 326
                      fPadL      (LeftStr(qryRemessa.FieldByName('C_E_P_').AsString,5) , 05, '0') + //327 A 331
                      fPadL      (RightStr(qryRemessa.FieldByName('C_E_P_').AsString,3), 03, '0') + //332 A 334
                      fPadR      (qryRemessa.FieldByName('CID_NOMCID').AsString        , 15)      + //335 A 349
                      fPadR      (qryRemessa.FieldByName('ESTADO').AsString            , 02)      + //350 A 351 - UF
                      fPadR      (strKeyDup                                      , 25) + //352 A 376
                      fPadR      (' '                                            , 14) + //377 A 390
                      fPadR      (' '                                            , 04) + //391 A 394
                      fStrZero   (IntToStr(intCodSeq)                            , 06);  //395 A 400

      {******************************}
      {* ESCREVE A TRANSACAO NO TXT *}
      {***************************AF*}
      Writeln(txtTexto,strTransacao);

      {*****************************}
      {* CHAVE XML                 *}
      {**************************MT*}
      Inc(intCodSeq);
      strTransXML :=  fStrZero('4'                                                       ,001) + //001
                      fPadR   (qryRemessa.FieldByName('NFE_ACESSO').AsString             ,044) + //002 A 045
                      fPadR   (IIF(qryRemessa.FieldByName('NFE_STATUS').AsString = 'AT','01','02')  ,002) + //046 A 047
                      fPadR   ('01'                                                      ,002) + //048 A 049
                      fPadR   (' '                                                       ,345) + //050 A 394
                     fStrZero(IntToStr(intCodSeq)                                        ,006);  //395
      Writeln(txtTexto,strTransXML);

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
      pGravarLOGCTR;
      qryRemessa.Next;
    End;

    strCodBco := '979';
    {************}
    {* TRAILLER *}
    {*********AF*}
    Inc(intCodSeq);
    strTrailler := '';
    strTrailler := '9'                                + //001 A 001
                   fPadR   (' '                , 393) + //002 A 394
                   fStrZero(IntToStr(intCodSeq), 006);  //395 A 400

    {*****************************}
    {* ESCREVE O TRAILLER NO TXT *}
    {**************************AF*}
    Writeln(txtTexto,strTrailler);
    CloseFile(txtTexto);
    pBackupCnfBco;
    fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                 'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
    pAtualizaSequencialRemessa;
    pApagarCADCBI;

  Finally
    FreeAndNil(qryRemessa);
  End;
end;

procedure TfrmExpArqRemGrupoSifra.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemGrupoSifra.edtCodPorKeyPress(Sender: TObject;
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

function TfrmExpArqRemGrupoSifra.fCriarQueryRemessa: TUniQuery;
begin
  Result := Nil;
  Try
    Result:= fCriaQuery(Self);
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Add(fGetSqlRemessa);
    Result.ParamByName('CODBCO').AsString := strCodBco;

    If (Not fEmptyStr(edtCodPor.Text)) Then
      Result.ParamByName('CODPOR').AsString := edtCodPor.Text;

    IF fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
      Result.ParamByName('CARTEI').AsString := StrCartei;

    Result.Open;
  Except
  On E: Exception Do
   Begin
     pMensagensErro(E.Message, '[TfrmExpArqRemGrupoSifra.fCriarQueryRemessa]');
   End;
  End
end;

function TfrmExpArqRemGrupoSifra.fGetSqlRemessa: String;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  B.*, ';
  strSQL := strSQL + '  C.CLI_NOMCLI, ';
  strSQL := strSQL + '  C.CLI_FONE01, ';
  strSQL := strSQL + '  I.CID_NOMCID, ';
  strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  L.NFE_ACESSO, ';
  strSQL := strSQL + '  L.NFE_STATUS, ';
  strSQL := strSQL + '  L.NFE_NUMDOC, ';
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
  strSQL := strSQL + '  CADCBI B ';
  strSQL := strSQL + '  JOIN CADREC R ON R.CTR_NUMDUP = B.CBI_NUMDUP AND ';
  strSQL := strSQL + '                   R.CTR_PARCEL = B.CBI_PARCEL AND ';
  strSQL := strSQL + '                   R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
  strSQL := strSQL + '                   R.CTR_CODEMP = B.CBI_CODEMP AND ';
  strSQL := strSQL + '                   R.CTR_CODCLI = B.CBI_CODCLI ';
  strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = R.CTR_CODCLI ';
  strSQL := strSQL + '  JOIN CADCID I ON I.CID_CODCID = C.CLI_CODCID ';
  strSQL := strSQL + '  LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = B.CBI_NUMDUP AND ';
  strSQL := strSQL + '                        L.NFE_ESPDOC = B.CBI_ESPDOC AND ';
  strSQL := strSQL + '                        L.NFE_CODEMP = B.CBI_CODEMP AND ';
  strSQL := strSQL + '                        L.NFE_CODCLI = B.CBI_CODCLI AND ';
  strSQL := strSQL + '                        L.NFE_TIP_FC = "C" ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  B.CBI_CODBCO = :CODBCO AND ';
  strSQL := strSQL + '  R.CTR_DTAREC IS NULL ';

  IF fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'RESPONS', '') = 'E'  Then
    strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

  If (Not fEmptyStr(edtCodPor.Text)) Then
    strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (CBI_CODPOR IS NULL OR CBI_CODPOR = "" OR ';
    strSQL := strSQL + ' CBI_CODPOR IN (' + fRetStrToSQLIn(strPortadoresOperador) + ')) ';
  End;

  Result := strSQL;
end;

function TfrmExpArqRemGrupoSifra.fRetEmpresa: String;
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

function TfrmExpArqRemGrupoSifra.fRetornaSequencialRemessa(strIdeBanco: String): String;
begin
  If StrToDate(fGetBancoConfig(0, strIdeBanco, 'DTAULTREM', '')) <> VS_DATE Then
  Begin
    fGetBancoConfig(1, strIdeBanco, 'DTAULTREM', DateToStr(VS_DATE) );
    fGetBancoConfig(1, strIdeBanco, 'SEQULTREM', '1' );
  End;
  Result := fGetBancoConfig(0, strIdeBanco, 'SEQULTREM', '');
end;

function TfrmExpArqRemGrupoSifra.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemGrupoSifra.pValidaInformacoesCarteira;
begin
  strInstru2 := fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'INSTRU2', '');
  If fValidaInstrucao02(strInstru1) Then
    strInstru2 := fStrZero(fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'DIAPROT', ''),2);

  strRespon := '1';
  If (fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'RESPONS', '') = 'E') Then
    strRespon := '2';
end;

procedure TfrmExpArqRemGrupoSifra.pValidaInformacoesRemessa;
begin

  If qryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 0 Then
    strCpfCgc := '99'
  Else If qryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 1 Then
    strCpfCgc := '2'
  Else
    strCpfCgc := '1';

  {*******************************************}
  {* SE BANCO EMITE BOLETO                   *}
  {****************************************MV*}
  strNosNum := qryRemessa.FieldByName('CBI_NOSNUM').AsString;
  If (strRespon = '1') Then
    strNosNum := '0';

end;

function TfrmExpArqRemGrupoSifra.fValidaInstrucao02(strInstrucao01: String): Boolean;
begin
  Result := False;
  If (strInstrucao01 = '05') Then
    Result:=True
  Else If (strInstrucao01 = '06')Then
    Result := True
  Else If (strInstrucao01 = '18')Then
    Result := True;
end;

procedure TfrmExpArqRemGrupoSifra.pAtualizaSequencialRemessa;
  Var
    intAutoIncrem : Integer;
begin
  intAutoIncrem := StrToInt(fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'SEQULTREM', ''));
  inc(intAutoIncrem);
  fGetBancoConfig(1, 'CONFIG979-' + IntToStr(intCartei), 'SEQULTREM', IntToStr(intAutoIncrem));
end;

procedure TfrmExpArqRemGrupoSifra.pGravarLOGCTR;
begin
  untLogCtr.GravaLogCtr(qryRemessa.FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - 979', Self.Name);
end;

procedure TfrmExpArqRemGrupoSifra.pApagarCADCBI;
  Var
   qryAux : TUniQuery;
   strSQL : String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CADCBI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';
    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';
    IF fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';
    qryAux := fCriaQuery(Self);
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        qryAux.ParamByName('CODPOR').AsString := edtCodPor.Text;

      IF fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
        qryAux.ParamByName('CARTEI').AsString := StrCartei;

      qryAux.ExecSQL;
      qryAux.Close;
    Except
    On E: Exception Do
      Begin
         pMensagensErro(E.Message, '[TfrmExpArqRemGrupoSifra.fCriarQueryRemessa]');
      End;
    End;
  Finally
    pFreeAndNil(qryAux);
  End;
end;

function TfrmExpArqRemGrupoSifra.fValidacoesParaExportacao: Boolean;
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
  blnRemLoc  := Not( fGetBancoConfig(0,'CONFIG979', 'RELOCAL', '') = 'N' );
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

procedure TfrmExpArqRemGrupoSifra.FormCreate(Sender: TObject);
begin
  inherited;
   qryCadPor := fCriaQuery(Self);
end;

end.
