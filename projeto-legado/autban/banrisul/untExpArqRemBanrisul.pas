unit untExpArqRemBanrisul;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBanrisul = class(TfrmPai)
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

  private
    { Private declarations }
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    blnRemLoc : Boolean;
    function fRetEmpresa: String;

  public
    { Public declarations }
    intCartei  : Integer;
    strNomForm : String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemBanrisul: TfrmExpArqRemBanrisul;

implementation

uses untFuncoes, untfuncoesSimples, Data.DB, untFuncAutBan,
   untCfgGenericas_AutBan, untTypesSistema, untConsultas, untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemBanrisul.FormShow(Sender: TObject);
begin
  inherited;

  pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
  frmCfgGenericas_AutBan.strNomForm := strNomForm;
  frmCfgGenericas_AutBan.strCodBco  := '041';
  blnRemLoc := (frmCfgGenericas_AutBan.fRetRemessaLocal = 'S');
  FreeAndNil(frmCfgGenericas_AutBan);

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'PATHREM',''));

  edtNomArquivo.Text  := 'ARQR' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         '.REM';


  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemBanrisul.btnGerarClick(Sender: TObject);
  Var
    strSQL,
    strSeuNum   : String;
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
    strSeqTit   : String;
    strCodCar   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strInstru2  : String;
    strObs01    : String;
    strObs02    : String;
    strObs03    : String;
    strNosNum   : String;
    strTipDoc   : String;
    strJurosDia : String;
    strJurosDup : String;

    strHeader   : String;
    strTransacao: String;
    strMensagens: String;
    strTrailler : String;
    strIdeAce   : string;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    fltMorDia   : Double;
    fltMulAtr   : Double;

    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strRespon   : String;
    fltTotDup   : Double;
    qryRemessa  : TUniQuery;

    strBanrimicro : String;

    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;
    strCodRem: String;

    fltValDpo       : Double;
    strDtaDpo       : String;
    dtaDtaDpo       : TDateTime;
    blnUsaCnd       : Boolean;
    blnUsaDesPonCli : Boolean;
    blnUsaDesPon    : Boolean;
    AstrEndereco    : String;
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

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&OK'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco  := '041';
  strNomBco  := 'BANRISUL';
  strContBco := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'IDENTBC', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'DIAPROT', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1    := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2    := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'INSTRU2', '');
  strRespon     := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'RESPONS', '');
  strBanrimicro := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'BANRIMI', '');
  strObs01      := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'OBSERV1', '');
  strObs02      := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'OBSERV2', '');
  strObs03      := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'OBSERV3', '');
  strIdeAce     := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'PROACEI', '');
  strCodRem     := fStrZero(fAtuCodSeq('CONFIG041-' + IntToStr(intCartei), 'PROXNUM'), 3);

  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG041', 'RELOCAL', '') = 'N');
  strJurosDia:= fGetBancoConfig(0, 'CONFIG041', 'JUROSDI', '');

  if ((fGetBancoConfig(0,'CONFIG041-' + IntToStr(intCartei), 'MULATR_', '') <> '') and
      (fGetBancoConfig(0,'CONFIG041-' + IntToStr(intCartei), 'PERMULT', '') = ''))   then
  Begin
    fGetBancoConfig(1, 'CONFIG041-' + IntToStr(intCartei), 'PERMULT', fGetBancoConfig(0,'CONFIG041-' + IntToStr(intCartei), 'MULATR_', ''));
  end;


  If fEmptyStr(fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'PERMULT', '')) Then
    fltMulAtr := 0
  Else
    fltMulAtr := fStrToFloat(fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'PERMULT', ''));

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  If (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2')) Then
    blnUsaDesPonCli := True
  Else
    blnUsaDesPonCli := False;

  If fCfgSis('DESPON', varBoolean) Then
    blnUsaDesPon := True
  Else
    blnUsaDesPon := False;

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

  {Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try}
    strCartei  := 'CONFIG041-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
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
    strSQL := strSQL + '                   CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '                   CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '                   CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '                   CTR_CODCLI = CBI_CODCLI     ';

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND  ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL ';

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

      //ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*************************************************}
      { CARTEIRA "1" (COBRANÇA SIMPLES)                 }
      {**********************************************RN*}
      If strCodCar = '1' Then
      Begin

        //*************************************************//
        // HEADER DO ARQUIVO                               //
        //**********************************************ED*//
        intCodSeq := 1;
        strHeader := '';
        strHeader := fPadR   ('01REMESSA'            , 009) + //001 009 009
                     fPadR   (' '                    , 017) + //010 026 017
                     fPadR   (strCodAgen + strContBco, 013) + //027 039 013
                     fPadR   (' '                    , 007) + //040 046 007
                     fPadR   (strNomEmp              , 030) + //047 076 030
                     fPadR   ('041BANRISUL'          , 011) + //077 087 011
                     fPadR   (' '                    , 007) + //088 094 007
                     fPadR   (strDtaRem              , 006) + //095 100 006
                     fPadR   (' '                    , 009) + //101 109 009
                     fPadR   (' '                    , 004) + //110 113 004
                     fPadR   (' '                    , 001) + //114 114 001
                     fPadR   (' '                    , 001) + //115 115 001
                     fPadR   (' '                    , 001) + //116 116 001
                     fPadR   (' '                    , 010) + //117 126 010
                     fPadR   (' '                    , 268) + //127 394 268
                     fStrZero(IntToStr(intCodSeq)    , 006);  //395 400 006
                                                                 // --- //
                                                                 // 400

        //*************************************************//
        // ESCREVE O HEADER NO TXT                         //
        //**********************************************ED*//
        Writeln(txtTexto,fRetirarCaracteresEspeciais(strHeader));

        {*****************************}
        {* GRAVAÇÃO DA TABELA REMGER *}
        {** DADOS GERAIS DA REMESSA **}
        {**************************MO*}
        pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG041-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

        //*************************************************//
        // TRANSAÇÃO DO ARQUIVO                            //
        //**********************************************ED*//
        With qryRemessa Do
        Begin
          strTransacao := '';
          fltTotDup    := 0.00;

          While Not Eof Do
          Begin
            Inc(intCodSeq);
            Application.ProcessMessages;

            fltTotDup := fltTotDup + FieldByName('CBI_VALDUP').AsFloat;

            fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                                FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

            fltMorDia := ((FieldByName('CBI_VALDUP').AsFloat) * (fStrToFloat(strJurosDia) / 100) / 30);

            strJurosDup := FormatFloat('#,#0.0', fltMorDia);
            strJurosDup := AnsiReplaceStr(strJurosDup, ',', '');
            strJurosDup := AnsiReplaceStr(strJurosDup, '.', '');

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

            strSeqTit := fStrZero(fAtuCodSeq('CONFIG041-' + IntToStr(intCartei), 'PROXNUM'), 7);

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

            strSeuNum := RightStr(FieldByName('CBI_NUMDUP').AsString + FieldByName('CBI_PARCEL').AsString, 10);

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
            End
            Else
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
              strDtaDpo := '0';
            End;

            If strRespon = 'E' Then
            Begin
              strNosNum := FieldByName('CBI_NOSNUM').AsString;
              strTipDoc := '08';
            End
            Else
            Begin
              strNosNum := ' ';
              strTipDoc := '06';
            End;

            strTransacao := fPadR      ('1'                                 , 001)      + //001 001 TIPO DE REGISTRO                             001
                            fPadR      (' '                                 , 016)      + //002 017 BRANCOS                                      016
                            fPadR      (strCodAgen + strContBco             , 013)      + //018 030 CONTA CORRENTE + DIGITO                      013
                            fPadR      (' '                                 , 007)      + //031 037 BRANCOS                                      007
                            fPadR      (strKeyDup                           , 025)      + //038 062 IDENT. DO TIT. NA EMPRESA                    025
                            fStrZero   (strNosNum                           , 010)      + //063 072 NOSSO NUMERO                                 010
                            fPadR      (' '                                 , 032)      + //073 104 MENSAGEM                                     032
                            fPadR      (' '                                 , 003)      + //105 107 BRANCOS                                      003
                            fPadR      ('1'                                 , 001)      + //108 108 1 - COBRANCA SIMPLES                         001
                            fPadR      ('01'                                , 002)      + //109 110 01 - REMESSA (CODIGO DA OCORRENCIA)          002
                            fPadR      (strSeuNum                           , 010)      + //111 120 IDENT. DO TIT. NA EMPRESA                    010
                            fPadR      (strDtaVen                           , 006)      + //121 126 VENCIMENTO                                   006
                            fValNumForm(FieldByName('CBI_VALDUP').AsFloat   , 013)      + //127 139 VALOR DUP                                    013
                            fPadR      ('041'                               , 003)      + //140 142 CONSTANTE BANCO COBRADOR                     003
                            fPadR      (' '                                 , 005)      + //143 147 BRANCOS                                      005
                            fPadR      (strTipDoc                           , 002)      + //148 149 TIPO DE DOCUMENTO                            002
                            fPadR      (IIF(strIdeAce = 'S','A','N')        , 001)      + //150 150 IDENT. ACEITE                                001
                            fPadR      (strDtaEmi                           , 006)      + //151 156 DATA DA EMISSAO                              006
                            fPadR      (strInstru1                          , 002)      + //157 158 INSTRUCAO 1                                  002
                            fPadR      (strInstru2                          , 002)      + //159 160 INSTRUCAO 2                                  002
                            fPadR      ('0'                                 , 001)      + //161 161 CODIGO DE MORA 0=DIARIO, 1=MENSAL            001
                            fValNumForm(fltValAtr                           , 012)      + //162 173 VALOR DA MORA DE ATRAZO                      012
                            fPadR      (' '                                 , 006)      + //174 179 DATA LIMITE PARA DESCONTO OPCIONAL           006
                            fPadR      (' '                                 , 013)      + //180 192 VALOR DESCONTO A SER CONCEDIDO OPCIONAL      013
                            fPadR      (' '                                 , 013)      + //193 205 VALOR IOF                                    013
                            fStrZero   ('0'                                 , 013)      + //206 218 VALOR DO ABATIMENTO                          013
                            fStrZero   (strCpfCgc                           , 002)      + //219 220 TIPO DE INSCRICAO DO SACADO                  002
                            fPadL      (strCgcCli                           , 014, '0') + //221 234 N. INSCRICAO DO SACADO                       014
                            fPadR      (FieldByName('CLI_NOMCLI').AsString  , 035)      + //235 269 NOME DO SACADO                               035
                            fPadR      (' '                                 , 005)      + //270 274 USO DO BANCO                                 005
                            fPadR      (AstrEndereco                        , 040)      + //275 314 ENDERECO DO SACADO                           040
                            fPadR      (' '                                 , 007)      + //315 321 USO DO BANCO                                 007
                            fValNumForm(fltMulAtr                        , 03, 01)      + //322 324 TAXA DE MULTA APOS O VENCIMENTO              003
                            fStrZero   ('0'                                 , 002)      + //325 326 NUM. DE DIAS PARA MULTA APOS O VENCIMENTO    002
                            fPadR      (FieldByName('C_E_P_').AsString      , 008, '0') + //327 334 CEP DO SACADO                                008
                            fPadR      (FieldByName('CIDADE').AsString      , 015)      + //335 349 CIDADE DO SACADO                             015
                            fPadR      (FieldByName('ESTADO').AsString      , 002)      + //350 351 ESTADO DO SACADO                             002
                            fPadR      (' '                                 , 018)      + //352 369 BRANCOS                                      018
                            fStrZero   (strDiaPro                           , 002)      + //370 371 PRAZO PARA PROTESTO                          002
                            fPadR      (' '                                 , 023)      + //372 394 USO DO BANCO                                 023
                            fStrZero   (IntToStr(intCodSeq)                 , 006);       //395 400 SEQUECIAL DE REGISTRO                        006
                                                                                                                                               // --- //
                                                                                                                                               // 400

            //*************************************************//
            // ESCREVE A TRANSACAO NO TXT                      //
            //**********************************************ED*//
            Writeln(txtTexto,fRetirarCaracteresEspeciais(strTransacao));

            {*************}
            {* MENSAGENS *}
            {**********JU*}

            Inc(intCodSeq);

            strMensagens := '';

            strMensagens := fPadR      ('1'                                 , 001) + //001 001
                            fPadR      ('02'                                , 002) + //002 003
                            fPadR      (strCgcEmp                           , 014) + //004 017
                            fPadR      (strCodAgen + strContBco             , 013) + //018 030
                            fPadR      (' '                                 , 007) + //031 037
                            fPadR      (strKeyDup                           , 025) + //038 062
                            fStrZero   (strNosNum                           , 010) + //063 072
                            fPadR      (' '                                 , 035) + //073 107
                            fPadR      ('1'                                 , 001) + //108 108
                            fPadR      ('98'                                , 002) + //109 110
                            fPadR      ('0'                                 , 001) + //111 111
                            fPadR      (strObs01                            , 090) + //112 201
                            fPadR      ('0'                                 , 001) + //202 202
                            fPadR      (strObs02                            , 090) + //203 292
                            fPadR      ('0'                                 , 001) + //293 293
                            fPadR      (strObs03                            , 090) + //294 383
                            fPadR      (' '                                 , 011) + //384 394
                            fStrZero   (IntToStr(intCodSeq)                 , 006);  //395 400

            Writeln(txtTexto,fRetirarCaracteresEspeciais(strMensagens));

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
          End;

        End;



        //*************************************************//
        // TRAILLER                                        //
        //**********************************************ED*//
        Inc(intCodSeq);
        strTrailler := '';
        strTrailler := '9'                                + //001 001                           001
                       fPadR   (' '                , 026) + //002 027 BRANCOS                   026
                       fValNumForm(fltTotDup       , 013) + //028 040 SOMATORIA DAS DUPLICATAS  013
                       fPadR   (' '                , 354) + //041 394 BRANCOS                   354
                       fStrZero(IntToStr(intCodSeq), 006);  //395 400 SEQUENCIAL                006
                                                                                             // --- //
                                                                                             // 400
      End

      {*************************************************}
      { CARTEIRA "R" (DESCONTO DE DUPLICATA)            }
      {**********************************************RN*}
      Else If strCodCar = 'R' Then
      Begin
        {*************************************************}
        { HEADER DO ARQUIVO                               }
        {**********************************************RN*}
        intCodSeq := 1;
        strHeader := '';
        strHeader := fPadR   ('01REMESSA'            , 009) + //001 009 009
                     fPadR   (' '                    , 017) + //010 026 017
                     fPadR   (strCodAgen + strContBco, 013) + //027 039 013
                     fPadR   (' '                    , 007) + //040 046 007
                     fPadR   (strNomEmp              , 030) + //047 076 030
                     fPadR   ('041BANRISUL'          , 011) + //077 087 011
                     fPadR   (' '                    , 007) + //088 094 007
                     fPadR   (strDtaRem              , 006) + //095 100 006
                     fPadR   (' '                    , 009) + //101 109 009
                     fPadR   ('0808'                 , 004) + //110 113 004
                     fPadR   (' '                    , 001) + //114 114 001
                     fPadR   ('P'                    , 001) + //115 115 001
                     fPadR   (' '                    , 001) + //116 116 001
                     fPadR   (strBanrimicro          , 010) + //117 126 010
                     fPadR   (' '                    , 268) + //127 394 268
                     fStrZero(IntToStr(intCodSeq)    , 006);  //395 400 006

        Writeln(txtTexto,fRetirarCaracteresEspeciais(strHeader));

        {*****************************}
        {* GRAVAÇÃO DA TABELA REMGER *}
        {** DADOS GERAIS DA REMESSA **}
        {**************************MO*}
        pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG041-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

        With qryRemessa Do
        Begin
          strTransacao := '';
          fltTotDup    := 0.00;

          While Not Eof Do
          Begin
            Inc(intCodSeq);
            Application.ProcessMessages;

            fltTotDup := fltTotDup + FieldByName('CBI_VALDUP').AsFloat;

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

            strSeqTit := fStrZero(fAtuCodSeq('CONFIG041-' + IntToStr(intCartei), 'PROXNUM'), 7);

            if not TEspecieParaArquivoRemessa.New.fValidaEspecie(FieldByName('CBI_ESPDOC').AsString) then
            begin
              CloseFile(txtTexto);
              Exit;
            end;

            strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                         fPadR(FieldByName('CBI_PARCEL').AsString, 03) +
                         fPadR(FieldByName('CBI_ESPDOC').AsString, 02) +
                         fPadR(FieldByName('CBI_CODEMP').AsString, 03);

            strCgcEmp := Trim(strCgcEmp);
            strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
            strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
            strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

            strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
            strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
            strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
            strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

            strTransacao := fPadR      ('1'                                 , 001)      + //001 001                                              001
                            fPadR      (' '                                 , 016)      + //002 017                                              016
                            fPadR      (strCodAgen + strContBco             , 013)      + //018 030 CONTA CORRENTE + DIGITO                      013
                            fPadR      (' '                                 , 007)      + //031 037                                              007
                            fPadR      (strKeyDup                           , 025)      + //038 062 IDENT. DO TIT. NA EMPRESA                    025
                            fStrZero   (FieldByName('CBI_NOSNUM').AsString  , 010)      + //063 072 NOSSO NUMERO                                 010
                            fPadR      (' '                                 , 032)      + //073 104                                              032
                            fPadR      (' '                                 , 003)      + //105 107                                              003
                            fPadR      ('R'                                 , 001)      + //108 108 R - DESCONTO DE DUPLICATA                    001
                            fPadR      ('01'                                , 002)      + //109 110 01 - REMESSA (CODIGO DA OCORRENCIA)          002
                            fPadR      (strKeyDup                           , 010)      + //111 120 IDENT. DO TIT. NA EMPRESA                    010
                            fPadR      (strDtaVen                           , 006)      + //121 126 VENCIMENTO                                   006
                            fValNumForm(FieldByName('CBI_VALDUP').AsFloat   , 013)      + //127 139 VALOR DUP                                    013
                            fPadR      ('041'                               , 003)      + //140 142 CONSTANTE BANCO COBRADOR                     003
                            fPadR      (' '                                 , 005)      + //143 147                                              005
                            fPadR      (' '                                 , 002)      + //148 149                                              002
                            fPadR      (IIF(strIdeAce = 'S','A','N')        , 001)      + //150 150 IDENT. ACEITE                                001
                            fPadR      (strDtaEmi                           , 006)      + //151 156 DATA DA EMISSAO                              006
                            fPadR      (' '                                 , 002)      + //157 158 INSTRUCAO 1                                  002
                            fPadR      (' '                                 , 002)      + //159 160 INSTRUCAO 2                                  002
                            fPadR      (' '                                 , 001)      + //161 161 CODIGO DE MORA 0=DIARIO, 1=MENSAL            001
                            fPadR      (' '                                 , 012)      + //162 173 VALOR DA MORA DE ATRAZO                      012
                            fStrZero   ('0'                                 , 006)      + //174 179 DATA LIMITE PARA DESCONTO                    006
                            fStrZero   ('0'                                 , 013)      + //180 192 VALOR DESCONTO A SER CONCEDIDO               013
                            fPadR      (' '                                 , 013)      + //193 205                                              013
                            fStrZero   ('0'                                 , 013)      + //206 218 VALOR DO ABATIMENTO                          013
                            fStrZero   (strCpfCgc                           , 002)      + //219 220 TIPO DE INSCRICAO DO SACADO                  002
                            fPadL      (strCgcCli                           , 014, '0') + //221 234 N. INSCRICAO DO SACADO                       014
                            fPadR      (FieldByName('CLI_NOMCLI').AsString  , 035)      + //235 269 NOME DO SACADO                               035
                            fPadR      (' '                                 , 005)      + //270 274 USO DO BANCO                                 005
                            fPadR      (AstrEndereco                        , 040)      + //275 314 ENDERECO DO SACADO                           040
                            fPadR      (' '                                 , 007)      + //315 321 USO DO BANCO                                 007
                            fValNumForm(fltMulAtr                        , 03, 01)      + //322 324 TAXA DE MULTA APOS O VENCIMENTO              005
                            fStrZero   ('0'                                 , 002)      + //325 326 NUM. DE DIAS PARA MULTA APOS O VENCIMENTO    002
                            fPadR      (FieldByName('C_E_P_').AsString      , 008, '0') + //327 334 CEP DO SACADO                                008
                            fPadR      (FieldByName('CIDADE').AsString      , 015)      + //335 349 CIDADE DO SACADO                             015
                            fPadR      (FieldByName('ESTADO').AsString      , 002)      + //350 351 ESTADO DO SACADO                             002
                            fPadR      (' '                                 , 004)      + //352 355 NUM. DE DIAS PARA PAGTO ANTECIPADO           004
                            fPadR      (' '                                 , 001)      + //356 356 USO DO BANCO                                 001
                            fPadR      (' '                                 , 013)      + //357 369 VALOR DO CALCULO DO DESCONTO                 013
                            fPadR      (' '                                 , 002)      + //370 371 PRAZO PARA PROTESTO                          002
                            fPadR      (' '                                 , 023)      + //372 394 USO DO BANCO                                 023
                            fStrZero   (IntToStr(intCodSeq)                 , 006);       //395 400 SEQUECIAL DE REGISTRO                        006
                                                                                                                                               // --- //
                                                                                                                                               // 400

            {*************************************************}
            { ESCREVE A TRANSACAO NO TXT                      }
            {**********************************************RN*}
            Writeln(txtTexto,fRetirarCaracteresEspeciais(strTransacao));

            {*************}
            {* MENSAGENS *}
            {**********JU*}

            Inc(intCodSeq);

            strMensagens := '';

            strMensagens := fPadR      ('1'                                 , 001) + //001 001
                            fPadR      ('02'                                , 002) + //002 003
                            fPadR      (strCgcEmp                           , 014) + //004 017
                            fPadR      (strCodAgen + strContBco             , 013) + //018 030
                            fPadR      (' '                                 , 007) + //031 037
                            fPadR      (strKeyDup                           , 025) + //038 062
                            fStrZero   (strNosNum                           , 010) + //063 072
                            fPadR      (' '                                 , 035) + //073 107
                            fPadR      ('R'                                 , 001) + //108 108
                            fPadR      ('98'                                , 002) + //109 110
                            fPadR      ('0'                                 , 001) + //111 111
                            fPadR      (strObs01                            , 090) + //112 201
                            fPadR      ('0'                                 , 001) + //202 202
                            fPadR      (strObs02                            , 090) + //203 292
                            fPadR      ('0'                                 , 001) + //293 293
                            fPadR      (strObs03                            , 090) + //294 383
                            fPadR      (' '                                 , 011) + //384 394
                            fStrZero   (IntToStr(intCodSeq)                 , 006);  //395 400

            Writeln(txtTexto,fRetirarCaracteresEspeciais(strMensagens));

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
          End;

        End;

        {*************************************************}
        { TRAILLER                                        }
        {**********************************************RN*}
        Inc(intCodSeq);
        strTrailler := '';
        strTrailler := '9'                                + //001 001                           001
                       fPadR   (' '                , 026) + //002 027 BRANCOS                   026
                       fValNumForm(fltTotDup       , 013) + //028 040 SOMATORIA DAS DUPLICATAS  013
                       fPadR   (' '                , 354) + //041 394 BRANCOS                   354
                       fStrZero(IntToStr(intCodSeq), 006);  //395 400 SEQUENCIAL                006

      End
      else
      begin
        fRollBack;
        fMensagem('','Não foi possível gerar o arquivo de remessa, código de carteira não corresponde ao permitido!', ['&O K']);
        CloseFile(txtTexto);
        DeleteFile(strFilePath);
        FreeAndNil(qryRemessa);
        FreeAndNil(qryConsultaGen);
        Exit;
      end;

      //*************************************************//
      // ESCREVE O TRAILLER NO TXT                       //
      //**********************************************ED*//
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strTrailler));

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

procedure TfrmExpArqRemBanrisul.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBanrisul.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

function TfrmExpArqRemBanrisul.fRetEmpresa: String;
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

function TfrmExpArqRemBanrisul.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemBanrisul.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
