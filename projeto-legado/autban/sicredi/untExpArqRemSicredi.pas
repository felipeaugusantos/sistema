unit untExpArqRemSicredi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, cxProgressBar, Data.DB;

type
  TfrmExpArqRemSicredi = class(TfrmPai)
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
    { Private declarations }
    qryCadPor      : TUniQuery;

    blnRemLoc : Boolean;
    function fRetEmpresa: String;

    function GerarArquivoRemessa(prgStatus: TcxProgressBar): Boolean;
    procedure GravaLogctr(ADataset: TDataset);
  public
    { Public declarations }
    intCartei  : Integer;
    strNomForm : String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemSicredi: TfrmExpArqRemSicredi;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, untCfgGenericas_AutBan,
     untConsultas, untTypesSistema, untConstantes, untLogCtr, untGravando;

{$R *.dfm}

procedure TfrmExpArqRemSicredi.FormShow(Sender: TObject);
  Var
    strCodCed : String;
    strCodMes : String;
    intCodMes : Integer;

begin
  inherited;

  pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
  frmCfgGenericas_AutBan.strNomForm := strNomForm;
  frmCfgGenericas_AutBan.strCodBco  := '748';
  blnRemLoc := (frmCfgGenericas_AutBan.fRetRemessaLocal = 'S');
  FreeAndNil(frmCfgGenericas_AutBan);


  strCodCed := fGetBancoConfig(0,'CONFIG748-' + IntToStr(intCartei), 'IDENTBC', '');
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intCartei), 'PATHREM',''));


  //*************************************************//
  // TABELA DE CODIFICACAO PARA OS MESES             //
  // 1- JANEIRO             7- JULHO                 //
  // 2- FEVEREIRO           8- AGOSTO                //
  // 3- MARÇO               9- SETEMBRO              //
  // 4- ABRIL         LETRA(O)-OUTUBRO               //
  // 5- MAIO                N- NOVEMBRO              //
  // 6- JUNHO               D- DEZEMBRO              //
  //**********************************************ED*//
  strCodMes := FormatDateTime('mm',VS_Date);
  {**********************************}
  {* CORRIJIDO MES DEVE TER APENAS  *}
  {* UMA POSIÇÃO NO NOME DO ARQUIVO *}
  {* HOMOLOGAÇÃO VIASUL 27/09/2013  *}
  {*******************************JU*}
  intCodMes := StrToInt(strCodMes);

  If intCodMes = 10 Then strCodMes := 'O'
  Else If intCodMes = 11 Then strCodMes := 'N'
  Else If intCodMes = 12 Then strCodMes := 'D'
  Else strCodMes := IntToStr(intCodMes);

  //*************************************************//
  // A PEDIDO DO MARIO FOI ALTERADO O NOME DO ARQ.   //
  // NO DIA 05/10/2007.                              //
  //**********************************************ED*//
  edtNomArquivo.Text  := LeftStr(strCodCed, 5) +
                         strCodMes             +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         '.CRM';


  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemSicredi.btnGerarClick(Sender: TObject);
  Var
    LGravando: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, LGravando);
    LGravando.fExecutarAcao := GerarArquivoRemessa;
    LGravando.Caption := 'Aguarde... Gerando arquivo remessa.';
    LGravando.ShowModal;
  Finally
    FreeAndNil(LGravando);
  End;

  inherited;
end;

procedure TfrmExpArqRemSicredi.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemSicredi.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
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

function TfrmExpArqRemSicredi.fRetEmpresa: String;
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

function TfrmExpArqRemSicredi.fValidaCampos(Sender: TWinControl;
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

function TfrmExpArqRemSicredi.GerarArquivoRemessa(
  prgStatus: TcxProgressBar): Boolean;
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strContBco  : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
    LMsgErro    : String;
    strCodCar   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strInstru2  : String;
    strNumDup   : String;
    strEsp_ID   : String;

    dtaDtaVen   : TDateTime;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;

    intCodSeq   : Integer;
    txtTexto    : TextFile;

    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strSeqArq   : String;
    strRespon   : String;
    strCobReg   : String;
    strDtaIns   : String;
    qryRemessa  : TUniQuery;
    strProAce   : String;

    fltPerMul   : Double;
    strPerMul   : String;

    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;
    strCodOco   : String;

    fltValDpo       : Double;
    strDtaDpo       : String;
    dtaDtaDpo       : TDateTime;
    blnUsaCnd       : Boolean;
    blnUsaDesPonCli : Boolean;
    blnUsaDesPon    : Boolean;
    strConRem       : String;
    InstrucaoNegativar: String;
    DiasParaNegativar: String;
    AstrEndereco     : String;
    blnRecDtaVen : Boolean; // Recalcular data de vencimento Req:  178124
    fltValDup: Double;

    LDescontoSugerido : Double;
Begin
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

  strCodBco  := '748';
  strNomBco  := 'SICREDI';
  strContBco := fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intCartei), 'IDENTBC', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intCartei), 'DIAPROT', '');
  DiasParaNegativar := fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intCartei), 'DIANEGATIVAR', '');

  If fEmptyStr(strDiaPro) Then
    strDiaPro := '00';

  If fEmptyStr(DiasParaNegativar) Then
    DiasParaNegativar := '00';

  strDtaRem  := FormatDateTime('yyyy',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('dd',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intCartei), 'INSTRU2', '');
  InstrucaoNegativar := fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intCartei), 'INSTNEG', '');
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG748', 'RELOCAL', '') = 'N');
  strRespon  := fGetBancoConfig(0,'CONFIG748-' + IntToStr(intCartei), 'RESPONS', '');
  strCobReg  := fGetBancoConfig(0,'CONFIG748-' + IntToStr(intCartei), 'COBREGI', '');
  strProAce  := fGetBancoConfig(0,'CONFIG748-' + IntToStr(intCartei), 'PROACEI', 'N');
  fltPerMul  := fStrToFloat(fGetBancoConfig(0,'CONFIG748-' + IntToStr(intCartei), 'PERMULT', ''));
  strPerMul  := FormatFloat('00.00', fltPerMul);
  strPerMul  := fTiraCaracEspeciais(strPerMul);
  blnRecDtaVen :=  (fGetBancoConfig(0,'CONFIG748-' + IntToStr(intCartei), 'RECDTAVEN', 'S') <> 'N');
  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  blnUsaDesPonCli := (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2'));

  blnUsaDesPon := fCfgSis('DESPON', varBoolean);

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
    strCartei := 'CONFIG748-' + IntToStr(intCartei) + '-' + VS_strCodEmp;

    strCgcEmp := fRetCGCEmpresa(VS_strCodEmp);

    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, R.CTR_CONREM, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_CODEMP AS CTR_CODEMP, ';
    strSQL := strSQL + '  SUM(R.CTR_DESCOB) AS CTR_DESCOB, ';
    strSQL := strSQL + '  SUM(R.CTR_JURSUJ) AS CTR_JURSUJ, ';
    strSQL := strSQL + '  R.CTR_DESSUJ AS CTR_DESSUJ, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, C.CLI_PERDPO, C.CLI_QTDDAV, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    If blnUsaDesPon Then
    Begin
      strSQL := strSQL + '  ,D.CND_PERDPO ';
      strSQL := strSQL + '  ,D.CND_QTDDAV ';
    End;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B  ';
    strSQL := strSQL + '  JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI     ';
    strSQL := strSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '              CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '              CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '              CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '              CTR_CODCLI = CBI_CODCLI     ';

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND  ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND (B.CBI_CODOCO = "01" OR B.CBI_CODOCO = "06" OR B.CBI_CODOCO = "04" OR B.CBI_CODOCO = "05" ';
    strSQL := strSQL + '    OR B.CBI_CODOCO = "09" OR B.CBI_CODOCO = "18" OR B.CBI_CODOCO = "19" OR B.CBI_CODOCO = "31" )) OR';
    strSQL := strSQL + '  (CTR_DTAREC IS NOT NULL AND B.CBI_CODOCO = "02"))';

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

    qryRemessa.Close;
    qryRemessa.SQL.Text := strSQL;
    qryRemessa.ParamByName('CODBCO').AsString := strCodBco;

    if (fCfgSis('CONREM', varString) = 'C') THEN
      qryRemessa.ParamByName('CARTEI').AsString := strCartei;

    If (Not fEmptyStr(edtCodPor.Text)) Then
      qryRemessa.ParamByName('CODPOR').AsString := edtCodPor.Text;

    qryRemessa.Open;
    
    If Not qryRemessa.IsEmpty Then
    Begin
      strSeqArq  := fStrZero(fAtuCodSeq('CONFIG748-' + IntToStr(intCartei), 'PROXNUM'), 7);
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      //*************************************************//
      // HEADER DO ARQUIVO                               //
      //**********************************************ED*//
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001)      + //001 001
                   fPadR   ('1'                , 001)      + //002 002
                   fPadR   ('REMESSA'          , 007)      + //003 009
                   fPadR   ('01'               , 002)      + //010 011
                   fPadR   ('COBRANCA'         , 015)      + //012 026
                   fPadL   (strContBco         , 005, '0') + //027 031
                   fPadL   (strCgcEmp          , 014)      + //032 045
                   fPadR   (' '                , 031)      + //046 076
                   fPadR   (strCodBco          , 003)      + //077 079
                   fPadR   (strNomBco          , 015)      + //080 094
                   fPadR   (strDtaRem          , 008)      + //095 102
                   fPadR   (' '                , 008)      + //103 110
                   fPadR   (strSeqArq          , 007, '0') + //111 117
                   fPadR   (' '                , 273)      + //118 390
                   fPadR   ('2.00'             , 004)      + //391 394
                   fStrZero(IntToStr(intCodSeq), 006);       //395 400



      //*************************************************//
      // ESCREVE O HEADER NO TXT                         //
      //**********************************************ED*//
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG748-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strSeqArq), strAutoIncremRem);

      prgStatus.Properties.Max := qryRemessa.RecordCount;
      prgStatus.Position := 0;
      prgStatus.Visible := True;

      //*************************************************//
      // TRANSAÇÃO DO ARQUIVO                            //
      //**********************************************ED*//
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

          If (FieldByName('CBI_DTAVEN').AsDateTime >= (FieldByName('CBI_DTACAD').AsDateTime + 7)) Or Not blnRecDtaVen Then
            strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime)
          Else
          Begin
            dtaDtaVen := FieldByName('CBI_DTACAD').AsDateTime + 7;

            strDtaVen := FormatDateTime('dd',dtaDtaVen) +
                         FormatDateTime('mm',dtaDtaVen) +
                         FormatDateTime('yy',dtaDtaVen) ;
          End;

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime) ;

          strDtaIns := FormatDateTime('yyyy',  FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',  FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) ;

          strNumDup := fPadR(RightStr(FieldByName('CBI_NUMDUP').AsString, 6), 6) +
                       FieldByName('CBI_PARCEL').AsString;

          {***************************************************************************************************************}
          {* SE O TAMANHO DA VARIÁVEL DER 9 CARACTERES SIGNIFICA QUE A PARCELA TEM 3 DIGITOS, ****************************}
          {* COM ISSO DEVEMOS CONVERTER A ESPÉCIE EM NÚMERO PARA TOTALIZAR O MÁXIMO QUE O SICREDI ACEITA NA NOSSA CHAVE, *}
          {* QUE É UM TOTAL DE 10 CARACTERS. CASO CONTRÁRIO, SEGUE A ROTINA NORMAL. **************************************}
          {************************************************************************************************************MO*}
          If (Length(Trim(strNumDup)) = 9) Then
          begin
            strEsp_ID := TEspecieParaArquivoRemessa.New.fRetornaIndiceParaEspecie(FieldByName('CBI_ESPDOC').AsString);
            strKeyDup := strNumDup + strEsp_ID;
          end
          else
          begin
            strKeyDup := fPadR(RightStr(FieldByName('CBI_NUMDUP').AsString, 6), 6) +
                         FieldByName('CBI_PARCEL').AsString +
                         fPadR(FieldByName('CBI_ESPDOC').AsString, 2);
          end;

          If fEmptyStr(FieldByName('CTR_CONREM').AsString) Then
          Begin
            strConRem := fAtualizaProCod('CONREM', 'CTR_CONREM', 'CADREC');
            fExecutaSQL(' UPDATE   ' +
                        '   CADREC ' +
                        ' SET      ' +
                        '   CTR_CONREM = "'+strConRem+'" ' +
                        ' WHERE    ' +
                        '    CTR_NUMDUP = "'+FieldByName('CBI_NUMDUP').AsString+'" AND ' +
                        '    CTR_PARCEL = "'+FieldByName('CBI_PARCEL').AsString+'" AND ' +
                        '    CTR_SEQBAI = 0 AND ' +
                        '    CTR_ESPDOC = "'+FieldByName('CBI_ESPDOC').AsString+'" AND ' +
                        '    CTR_CODCLI = "'+FieldByName('CBI_CODCLI').AsString+'" AND ' +
                        '    CTR_CODEMP = "'+FieldByName('CBI_CODEMP').AsString+'" ');
          End
          Else
            strConREm := FieldByName('CTR_CONREM').AsString;

{          strKeyDup := FieldByName('CBI_CODEMP').AsString+
                       fPadR(strConRem, 07); }

          //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
          AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

          strCodOco := FieldByName('CBI_CODOCO').AsString;
          if fEmptyStr(strCodOco) Then
             strCodOco := '01';

          If strCodOco = '01' Then
             strCodOco := strInstru1;

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

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

          fltValDup := FieldByName('CBI_VALDUP').AsFloat;

          If fCfgSis('VALIMP', varBoolean) then
          begin
            fltValDup := fltValDup + FieldByName('CTR_JURSUJ').AsFloat +
                                     FieldByName('CTR_DESCOB').AsFloat;
          end;

          LDescontoSugerido := qryRemessa.FieldByName('CBI_DESSUJ').AsFloat;

          If fCfgSis('DESBOL', varBoolean) Then
          Begin
            fltValDup := fFormataFloat((fltValDup - qryRemessa.FieldByName('CTR_DESSUJ').AsFloat),2);
            LDescontoSugerido := 0.00;
          End;

          If strCobReg = 'S' Then
          Begin

            strTransacao := fPadR      ('1'                                                                    , 01)      + //001 001
                            fPadR      ('A'                                                                    , 01)      + //002 002 "A" SICREDI COM REGISTRO
                            fPadR      ('A'                                                                    , 01)      + //003 003 "A" TIPO DE CARTEIRA - SIMPLES
                            fPadR      ('A'                                                                    , 01)      + //004 004 "A" TIPO DE IMPRESSÃO
                            fPadR      (' '                                                                    , 12)      + //005 016 BRANCOS USO DO BANCO
                            fPadR      ('A'                                                                    , 01)      + //017 017 "A" TIPO DE MOEDA
                            fPadR      ('A'                                                                    , 01)      + //018 018 "A" TIPO DE DESCONTO A-VALOR B-PERCENTUAL
                            fPadR      ('B'                                                                    , 01)      + //019 019 "A" TIPO DE JUROS A-VALOR B-PERCENTUAL
                            fPadR      (' '                                                                    , 28)      + //020 047 BRANCOS USO DO BANCO
                            fStrZero   (FieldByName('CBI_NOSNUM').AsString                                     , 09)      + //048 056 NOSSO NUMERO(09)
                            fPadR      (' '                                                                    , 06)      + //057 062 BRANCOS USO DO BANCO
                            fPadR      (strDtaIns                                                              , 08)      + //063 070 DATA DA INSTRUCAO
                            fPadR      (IIF(strCodOco = '31', 'A', ' ')                                        , 01)      + //071 071 "A" ESP. DOC A-DUPLICATA MERCANTIL
                            fPadR      ('N'                                                                    , 01)      + //072 072 "N" POSTAR - N-IMPRESSAO PELO CEDENTE
                            fPadR      (' '                                                                    , 01)      + //073 073 BRANCOS USO DO BANCO
                            fPadR      (IIF(strRespon = 'B', 'A', 'B')                                         , 01)      + //074 074 B-IMPRESSAO PELO CEDENTE, A IMP. PELA SICREDI
                            fPadR      ('00'                                                                   , 02)      + //075 076 NUMERO DA PARCELA DO CARNE
                            fPadR      ('00'                                                                   , 02)      + //077 078 NUMERO TOTAL DE PARCELA
                            fPadR      (' '                                                                    , 04)      + //079 082 BRANCOS USO DO BANCO
                            fStrZero   ('0'                                                                    , 10)      + //083 092 VALOR DESCONTO A SER CONCEDIDO
                            fStrZero   (strPerMul                                                              , 04)      + //093 096 % MULTA POR PAGAMENTO EM ATRASO
                            fPadR      (' '                                                                    , 12)      + //097 108 BRANCOS USO DO BANCO
                            fPadR      (strCodOco                                                              , 02)      + //109 110 INSTRUCAO 1
                            fPadR      (strKeyDup                                                              , 10)      + //111 120 N. DUPL. PROMISSORIA, NF, ETC
                            fPadR      (strDtaVen                                                              , 06)      + //121 126 VENCIMENTO
                            fValNumForm(fltValDup                                                              , 13)      + //127 139 VALOR DUP
                            fPadR      (' '                                                                    , 09)      + //140 148 BRANCOS USO DO BANCO
                            fPadR      ('A'                                                                    , 01)      + //149 149 "A" ESP. DOC A-DUPLICATA MERCANTIL
                            fPadR      (strProAce                                                              , 01)      + //150 150 IDENT. ACEITE
                            fPadR      (strDtaEmi                                                              , 06)      + //151 156 DATA DA INSTRUCAO
                            fPadR      (strInstru2                                                              ,02)      + //157 158 00-NAO PROTESTAR AUTOMATICAMENTE, 06-SIM
                            fStrZero   (strDiaPro                                                              , 02)      + //159 160 PRAZO PARA PROTESTO
                            fValNumForm(FieldByName('CBI_PORCEN').AsFloat                                      , 13)      + //161 173 % VALOR DE JUROS POR DIA DE ATRASO
                            fPadR(IIF(fltValDpo > 0,strDtaDpo,IIF(LDescontoSugerido > 0,strDtaVen, '0')), 06,'0')         + //174 179 DTA LIMITE PARA CONCESS. DE DESCONTO
                            IIF(fltValDpo > 0, fValNumForm(fltValDpo, 13), fValNumForm(LDescontoSugerido, 13))            + //180 192 % VALOR DO DESCONTO
                            fPadR      (InstrucaoNegativar                                                     , 02)      + //193 194 00-NAO NEGATIVAR AUTOMATICAMENTE, 06-SIM
                            fStrZero   (DiasParaNegativar                                                      , 02)      + //195 196 PRAZO PARA NEGATIVAR
                            fStrZero   ('0'                                                                    , 09)      + //197 205 ZEROS
                            fStrZero   ('0'                                                                    , 13)      + //206 218 VALOR DO ABATIMENTO
                            fPadR      (RightStr(strCpfCgc, 1)                                                 , 01)      + //219 219 TIPO DE INSCRICAO DO SACADO
                            fStrZero   ('0'                                                                    , 01)      + //220 220 ZEROS
                            fPadL      (strCgcCli                                                              , 14, '0') + //221 234 N. INSCRICAO DO SACADO
                            fPadR      (LeftStr(fTiraCaracEspeciais(FieldByName('CLI_NOMCLI').AsString), 40)   , 40)      + //235 274 NOME DO SACADO
                            fPadR      (LeftStr(fTiraCaracEspeciais(AstrEndereco), 40)                         , 40)      + //275 314 ENDERECO DO SACADO
                            fStrZero   ('0'                                                                    , 05)      + //315 319 CODIGO DO SACADO NO SICREDI - NOVO=00000
                            fPadR      ('0'                                                                    , 06, '0') + //320 325 CODIGO DA PRACA DO SACADO
                            fPadR      (' '                                                                    , 01)      + //326 326 BRANCOS USO DO BANCO
                            fPadR      (fTiraCaracEspeciais(FieldByName('C_E_P_').AsString)                    , 08, '0') + //327 334 CEP DO SACADO
                            fPadL      ('E' + FieldByName('CTR_CODEMP').AsString                               , 05, '0') + //335 339 CODIGO DO SACADO JUNTO AO CEDENTE
                            fPadL      (' '                                                                    , 14, ' ') + //340 353 N. INSCRICAO DO SACADO
                            fPadR      (' '                                                                    , 41)      + //354 394 NOME DO SACADO
                            fStrZero   (IntToStr(intCodSeq)                                                    , 06);       //395 400 SEQUECIAL DE REGISTRO
          End
          Else
          Begin
            strTransacao := fPadR      ('1'                                                       , 01)      + //001 001
                            fPadR      ('C'                                                       , 01)      + //002 002 "C" SICREDI SEM REGISTRO
                            fPadR      (' '                                                       , 01)      + //003 003 BRANCO
                            fPadR      ('A'                                                       , 01)      + //004 004 "A" TIPO DE IMPRESSÃO
                            fPadR      (' '                                                       , 12)      + //005 016 BRANCOS USO DO BANCO
                            fPadR      ('A'                                                       , 01)      + //017 017 "A" TIPO DE MOEDA
                            fPadR      ('A'                                                       , 01)      + //018 018 "A" TIPO DE DESCONTO A-VALOR B-PERCENTUAL
                            fPadR      ('B'                                                       , 01)      + //019 019 "A" TIPO DE JUROS A-VALOR B-PERCENTUAL
                            fPadR      (' '                                                       , 28)      + //020 047 BRANCOS USO DO BANCO
                            fStrZero   (FieldByName('CBI_NOSNUM').AsString                        , 09)      + //048 056 NOSSO NUMERO(09)
                            fPadR      (' '                                                       , 01)      + //057 057 BRANCOS USO DO BANCO
                            fPadR      ('B'                                                       , 01)      + //058 058 TIPO DE IMPRESSAO
                            fPadR      (' '                                                       , 13)      + //059 071 BRANCOS USO DO BANCO
                            fPadR      ('N'                                                       , 01)      + //072 072 "N" POSTAR - N-IMPRESSAO PELO CEDENTE
                            fPadR      (' '                                                       , 02)      + //073 074 BRANCOS USO DO BANCO
                            fPadR      ('00'                                                      , 02)      + //075 076 NUMERO DA PARCELA DO CARNE
                            fPadR      ('00'                                                      , 02)      + //077 078 NUMERO TOTAL DE PARCELA
                            fPadR      (' '                                                       , 04)      + //079 082 BRANCOS USO DO BANCO
                            fStrZero   ('0'                                                       , 10)      + //083 092 % DESCONTO POR DIA DE ANTECIP.
                            fStrZero   (strPerMul                                                 , 04)      + //093 096 % MULTA POR PAGAMENTO EM ATRASO
                            fPadR      (' '                                                       , 12)      + //097 108 BRANCOS USO DO BANCO
                            fPadR      (strCodOco                                                 , 02)      + //109 110 INSTRUCAO 1
                            fPadR      (FieldByName('CBI_NUMDUP').AsString                        , 10)      + //111 120 N. DUPL. PROMISSORIA, NF, ETC
                            fPadR      (strDtaVen                                                 , 06)      + //121 126 VENCIMENTO
                            fValNumForm(fltValDup                                                 , 13)      + //127 139 VALOR DUP
                            fPadR      (' '                                                       , 09)      + //140 148 BRANCOS USO DO BANCO
                            fPadR      ('A'                                                       , 01)      + //149 149 "A" ESP. DOC A-DUPLICATA MERCANTIL
                            fPadR      (' '                                                       , 01)      + //150 150 BRANCOS USO DO BANCO
                            fPadR      (strDtaEmi                                                 , 06)      + //151 156 DATA DA INSTRUCAO
                            fPadR      (' '                                                       , 04)      + //157 160 BRANCOS USO DO BANCO
                            fValNumForm(FieldByName('CBI_PORCEN').AsFloat                         , 13)      + //161 173 % VALOR DE JUROS POR DIA DE ATRASO
                            fPadR(IIF(fltValDpo > 0,strDtaDpo,IIF(LDescontoSugerido > 0,strDtaVen, '0')), 06,'0') + //174 179 DTA LIMITE PARA CONCESS. DE DESCONTO
                            IIF(fltValDpo > 0, fValNumForm(fltValDpo, 13), fValNumForm(LDescontoSugerido, 13))    + //180 192 % VALOR DO DESCONTO
                            fStrZero   ('0'                                                       , 26)      + //193 218 ZEROS USO DO BANCO
                            fPadR      (RightStr(strCpfCgc, 1)                                    , 01)      + //219 219 TIPO DE INSCRICAO DO SACADO
                            fPadR      (' '                                                       , 01)      + //220 220 BRANCOS USO DO BANCO
                            fPadL      (strCgcCli                                                 , 14, '0') + //221 234 N. INSCRICAO DO SACADO
                            fPadR      (fTiraCaracEspeciais(FieldByName('CLI_NOMCLI').AsString)   , 40)      + //235 274 NOME DO SACADO
                            fPadR      (fTiraCaracEspeciais(AstrEndereco)                         , 40)      + //275 314 ENDERECO DO SACADO
                            fStrZero   ('0'                                                       , 05)      + //315 319 CODIGO DO SACADO NO SICREDI - NOVO=00000
                            fPadR      ('0'                                                       , 06, '0') + //320 325 CODIGO DA PRACA DO SACADO
                            fPadR      (' '                                                       , 01)      + //326 326 BRANCOS USO DO BANCO
                            fPadR      (fTiraCaracEspeciais(FieldByName('C_E_P_').AsString)       , 08, '0') + //327 334 CEP DO SACADO
                            fPadR      (fTiraCaracEspeciais(FieldByName('CIDADE').AsString)       , 25)      + //335 359 CIDADE DO SACADO
                            fPadR      (FieldByName('ESTADO').AsString                            , 02)      + //360 361 ESTADO DO SACADO
                            fStrZero   ('0'                                                       , 05)      + //362 366 CODIGO DO SACADO NO SICREDI - NOVO=00000
                            fPadR      (' '                                                       , 28)      + //367 394 NOME DO SACADO
                            fStrZero   (IntToStr(intCodSeq)                                       , 06);       //395 400 SEQUECIAL DE REGISTRO
          End;

          //*************************************************//
          // ESCREVE A TRANSACAO NO TXT                      //
          //**********************************************ED*//
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

          Next;

          pStep(prgStatus);
        End;

      End;

      //*************************************************//
      // TRAILLER                                        //
      //**********************************************ED*//
      Inc(intCodSeq);
      strTrailler := '';


      strTrailler := '9'                                + //001 001 IDENTIFICACAO DO TRAILLER
                     fPadR   ('1'                , 001) + //002 002 IDENTIFICACAO DO ARQUIVO DE REMESSA
                     fPadR   (strCodBco          , 003) + //003 005 NUMERO DO SICREDI
                     fPadR   (strContBco         , 005) + //006 010 CODIGO DO CEDENTE
                     fPadR   (' '                , 384) + //011 394 FILLER BRANCOS
                     fStrZero(IntToStr(intCodSeq), 006);  //395 400 NUMERDO SEQUECIAL DO REGISTRO


      //*************************************************//
      // ESCREVE O TRAILLER NO TXT                       //
      //**********************************************ED*//
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      pDeletaCadCbi(strCodBco, strCartei, edtCodPor.Text);

      pBackupCnfBco;

      If fCommit then
      Begin
        {*******************************************}
        {* GRAVA A TABELA LOGCTR FORA DA TRANSAÇÃO *}
        {* POIS ESTAVA CAUSANDO TIMEOUT EM OUTRAS  *}
        {* ROTINAS DO SISTEMA.                     *}
        {*REQ*145737*****************************RP*}
        GravaLogctr(qryRemessa);

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

      LMsgErro := 'Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + '-' + strNomBco + #13 +
                  'Erro gerado: ' + E.Message;

      If (UpperCase(E.Message) = 'I/O ERROR 1331') Then
        LMsgErro := 'O caminho/nome do compartilhamento onde o arquivo remessa será salvo não está acessível. '+#13#10+
                    'Erro Gerado: I/O Error 1331 - Falha de Login, conta desabilitada no momento.' +#13#10 +
                    'Causa: O perfil do Windows foi desativado para o nome de usuário com o qual você está tentando fazer login no compartilhamento.'  +#13#10 +
                    'Solução: Você precisará entrar em contato com o administrador do computador host ou tentar usar um nome de usuário e senha diferentes.';

      Raise Exception.Create(LMsgErro);
		End;
  End;
end;

procedure TfrmExpArqRemSicredi.GravaLogctr(ADataset: TDataset);
begin
  ADataset.DisableControls;
  ADataset.First;
  While Not ADataset.Eof Do
  Begin
    {****************}
    {* GRAVA LOGCTR *}
    {*************JS*}
    untLogCtr.GravaLogCtr(ADataset.FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - 748', Self.Name);

    ADataset.Next;
  End;
end;

procedure TfrmExpArqRemSicredi.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemSicredi.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
