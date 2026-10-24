unit untExpArqRemBanrisul240;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBanrisul240 = class(TfrmPai)
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
  frmExpArqRemBanrisul240: TfrmExpArqRemBanrisul240;

implementation

uses untFuncoes, untfuncoesSimples, Data.DB, untFuncAutBan,
   untCfgGenericas_AutBan, untTypesSistema, untConsultas, untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemBanrisul240.FormShow(Sender: TObject);
begin
  inherited;

  pCriarFormularios(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
  frmCfgGenericas_AutBan.strNomForm := strNomForm;
  frmCfgGenericas_AutBan.strCodBco  := '041';
  blnRemLoc := (frmCfgGenericas_AutBan.fRetRemessaLocal = 'S');
  FreeAndNil(frmCfgGenericas_AutBan);

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'PATHREM',''));

  edtNomArquivo.Text  := 'ARQR' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         '.240';


  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemBanrisul240.btnGerarClick(Sender: TObject);
  Var
    strSQL,
    strSeuNum   : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomBenef : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strHraRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strEsp_ID   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodConv  : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strCodPro   : String;
    strInstru1  : String;
    strInstru2  : String;
    strObs01    : String;
    strObs02    : String;
    strObs03    : String;
    strObs04    : String;
    strObs05    : String;
    strNosNum   : String;
    strTipDoc   : String;
    strJurosDia : String;
    strJurosDup : String;
    strCodCobr  : String;

    strHeader   : String;
    strTransacao: String;
    strMensagens: String;
    strTrailler : String;
    strIdeAce   : string;
    strTipoImp  : String;

    intQtdTit   : Integer;
    intCodSeq   : Integer;
    intSeqLot   : Integer;
    intRegArq   : Integer;
    intRegLot   : Integer;
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

    blnUsaDesPon    : Boolean;
    AstrEndereco    : String;
    strDiasbaixa    : String;

    blnInfoAdicionalNF: Boolean;
    strNota     : string;
    strDataNF   : string;
    strChaveNFE : string;
    fltValorNF  : Double;

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
  strNomBenef:= fTiraCaracEspeciais(fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'IDENTBC', ''));
  strCodConv := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'CODCONV', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'DIAPROT', '');
  strCodPro  := IIF(StrToIntDef(strDiaPro, 0) = 0, '0', '1');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHraRem  := FormatDateTime('hh',fTime()) + FormatDateTime('nn',fTime()) + FormatDateTime('ss',fTime());

  strInstru1    := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2    := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'INSTRU2', '');
  strRespon     := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'RESPONS', '');
  strBanrimicro := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'BANRIMI', '');
  strObs01      := fTiraCaracEspeciais(fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'OBSERV1', ''));
  strObs02      := fTiraCaracEspeciais(fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'OBSERV2', ''));
  strObs03      := fTiraCaracEspeciais(fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'OBSERV3', ''));
  strObs04      := fTiraCaracEspeciais(fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'OBSERV4', ''));
  strObs05      := fTiraCaracEspeciais(fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'OBSERV4', ''));
  strIdeAce     := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'PROACEI', '');
  strTipoImp    := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'TIPOIMP', '');
  strCodRem     := fStrZero(fAtuCodSeq('CONFIG041_240p-' + IntToStr(intCartei), 'PROXNUM'), 3);
  strCodCobr    := fPadL('805076', 010, '0');

  strDiasbaixa   := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'DIASBAI', '');

  If ((Not FEmptyStr(strDiasbaixa)) And ((strInstru1 = '02') or (strInstru2 = '02')))  Then
     strDiasbaixa := fPadL(strDiasbaixa, 03, '0')
  Else
     strDiasbaixa := '';

  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG041_240p-', 'RELOCAL', '') = 'N');
  strJurosDia:= fGetBancoConfig(0, 'CONFIG041_240p-', 'JUROSDI', '');

  if ((fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(intCartei), 'MULATR_', '') <> '') and
      (fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(intCartei), 'PERMULT', '') = ''))   then
  Begin
    fGetBancoConfig(1, 'CONFIG041_240p-' + IntToStr(intCartei), 'PERMULT', fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(intCartei), 'MULATR_', ''));
  end;


  If fEmptyStr(fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'PERMULT', '')) Then
    fltMulAtr := 0
  Else
    fltMulAtr := fStrToFloat(fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'PERMULT', ''));

  If fCfgSis('DESPON', varBoolean) Then
    blnUsaDesPon := True
  Else
    blnUsaDesPon := False;

  blnInfoAdicionalNF := fGetBancoConfig(0,'CONFIG041_240p-' + IntToStr(intCartei), 'ENVADNF', '') = 'S';

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************ED*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fTiraCaracEspeciais(fRetNomeEmpresa(strNovCodEmp));


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
    strCartei  := 'CONFIG041_240p-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
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

    If blnInfoAdicionalNF Then
    Begin
      strSQL := strSQL + '  ,R.CTR_NUMDUP ';
      strSQL := strSQL + '  ,R.CTR_ESPDOC ';
      strSQL := strSQL + '  ,R.CTR_VALDUP ';
      strSQL := strSQL + '  ,L.NFE_NUMDOC ';
      strSQL := strSQL + '  ,L.NFE_DTAEMI ';
      strSQL := strSQL + '  ,L.NFE_ACESSO ';
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

    if blnInfoAdicionalNF then
    begin
      strSQL := strSQL + '  LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = B.CBI_NUMDUP AND ';
      strSQL := strSQL + '                        L.NFE_ESPDOC = B.CBI_ESPDOC AND ';
      strSQL := strSQL + '                        L.NFE_CODEMP = B.CBI_CODEMP AND ';
      strSQL := strSQL + '                        L.NFE_CODCLI = B.CBI_CODCLI AND ';
      strSQL := strSQL + '                        L.NFE_STATUS = "AT" AND ';
      strSQL := strSQL + '                        L.NFE_TIP_FC = "C" ';
    end;

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

      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      //*************************************************//
      // HEADER DO ARQUIVO                               //
      //*************************************************//
      intSeqLot := 0;
      intRegArq := 0;
      strHeader := '';
      strHeader := fPadR   (strCodBco              , 003) + //001 003 003
                   fPadR   ('00000'                , 005) + //004 008 005
                   fPadR   (' '                    , 009) + //009 017 009
                   fPadR   ('2'                    , 001) + //018 018 001
                   fPadR   (strCgcEmp              , 014) + //019 032 014
                   fPadR   (strCodConv             , 020) + //033 052 020
                   fPadR   (' '                    , 020) + //053 072 020
                   fPadR   (strNomEmp              , 030) + //073 102 030
                   fPadR   (strNomBco              , 030) + //103 132 030
                   fPadR   (' '                    , 010) + //133 142 010
                   fPadR   ('1'                    , 001) + //143 143 001
                   fPadR   (strDtaRem              , 008) + //144 151 008
                   fPadR   (strHraRem              , 006) + //152 157 006
                   fPadL   (strCodRem              , 006, '0') + //158 163 006
                   fPadR   ('103'                  , 003) + //164 166 003
                   fPadR   (' '                    , 074);  //167 240 074

      Writeln(txtTexto,strHeader);
      Inc(intRegArq);

      //*************************************************//
      // HEADER DO LOTE                                  //
      //*************************************************//
      intCodSeq    := 0;
      Inc(intSeqLot);
      strTransacao := fPadR      (strCodBco                           , 003)      + //001 003 BANCO                                        003
                      fStrZero   (IntToStr(intSeqLot)                 , 004)      + //004 007 LOTE DE SERVIÇO                              004
                      fPadR      ('1'                                 , 001)      + //008 008 REGISTRO                                     001
                      fPadR      ('R'                                 , 001)      + //009 009 TIPO DE OPERAÇÃO                             001
                      fPadR      ('01'                                , 002)      + //010 011 SERVIÇO                                      002
                      fPadR      (' '                                 , 002)      + //012 013 BRANCOS                                      002
                      fPadR      ('060'                               , 003)      + //014 016 LEIAUTE                                      002
                      fPadR      (' '                                 , 001)      + //017 017 BRANCOS                                      001
                      fPadR      ('2'                                 , 001)      + //018 018 TIPO INSCRIÇÃO                               001
                      fPadL      (strCgcEmp                           , 015, '0') + //019 033 INSCRIÇÃO DA EMPRESA                         015
                      fPadR      (strCodConv                          , 020)      + //034 053 CONVÊNIO                                     020
                      fPadR      (' '                                 , 020)      + //054 073 BRANCOS                                      020
                      fPadR      (strNomEmp                           , 030)      + //074 103 NOME DA EMPRESA                              030
                      fPadR      (strObs01                            , 040)      + //104 143 MENSAGEM 1                                   040
                      fPadR      (strObs02                            , 040)      + //144 183 MENSAGEM 2                                   040
                      fPadL      (strCodRem                           , 008, '0') + //184 191 NRO REMESSA                                  008
                      fPadR      (strDtaRem                           , 008)      + //192 199 DATA GRAVAÇÃO                                008
                      fPadR      (' '                                 , 041);       //200 240 BRANCOS                                      041

      Writeln(txtTexto,strTransacao);
      Inc(intRegArq);

      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG041_240p-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      //*************************************************//
      // TRANSAÇÃO DO ARQUIVO                            //
      //*************************************************//
      With qryRemessa Do
      Begin
        strTransacao := '';
        fltTotDup    := 0.00;
        intQtdTit    := 0;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          fltTotDup := fltTotDup + FieldByName('CBI_VALDUP').AsFloat;
          Inc(intQtdTit);

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
                       FormatDateTime('yyyy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTACAD').AsDateTime);

          strEsp_ID := TEspecieParaArquivoRemessa.New.fRetornaIndiceParaEspecie(FieldByName('CBI_ESPDOC').AsString);

          if blnInfoAdicionalNF then
          begin
            strNota     := FieldByName('NFE_NUMDOC').AsString;
            strChaveNFE := FieldByName('NFE_ACESSO').AsString;
            fltValorNF  := FieldByName('CTR_VALDUP').AsFloat;

            strChaveNFE := StringReplace(strChaveNFE, '.', '', [rfReplaceAll]);
            strChaveNFE := StringReplace(strChaveNFE, '-', '', [rfReplaceAll]);
            strChaveNFE := StringReplace(strChaveNFE, '/', '', [rfReplaceAll]);

            strDataNF   := FormatDateTime('dd',FieldByName('NFE_DTAEMI').AsDateTime) +
                           FormatDateTime('mm',FieldByName('NFE_DTAEMI').AsDateTime) +
                           FormatDateTime('yyyy',FieldByName('NFE_DTAEMI').AsDateTime);
          end;

          if fEmptyStr(strEsp_ID) then
          begin
            CloseFile(txtTexto);
            If FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) Then
              DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
            Exit;
          end;

          strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString + strEsp_ID +
                       FieldByName('CBI_PARCEL').AsString +
                       FieldByName('CBI_CODEMP').AsString +
                       FieldByName('CBI_CODCLI').AsString, 25, ' ');

          //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
          AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

          strSeuNum := RightStr(FieldByName('CBI_NUMDUP').AsString, 12) +
                       FieldByName('CBI_PARCEL').AsString;

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          If strRespon = 'E' Then
          Begin
            strNosNum := FieldByName('CBI_NOSNUM').AsString;
            strTipDoc := '2';
          End
          Else
          Begin
            strNosNum := '';
            strTipDoc := '1';
          End;

          Inc(intCodSeq);
          strTransacao := fPadR      (strCodBco                           , 003)      + //001 003 BANCO                                        003
                          fStrZero   (IntToStr(intSeqLot)                 , 004)      + //004 007 LOTE DE SERVIÇO                              004
                          fPadR      ('3'                                 , 001)      + //008 008 REGISTRO                                     001
                          fStrZero   (IntToStr(intCodSeq)                 , 005)      + //009 013 SEQUENCIAL NO LOTE                           005
                          fPadR      ('P'                                 , 001)      + //014 014 SEGMENTO                                     001
                          fPadR      (' '                                 , 001)      + //015 015 CNAB                                         001
                          fPadR      ('01'                                , 002)      + //016 017 CÓD. MOVIMENTO                               002
                          fPadR      (' '                                 , 020)      + //018 037 AGÊNCIA                                      020
                          fPadR      (strNosNum                           , 020)      + //038 057 NOSSO NUMERO                                 020
                          fPadR      ('1'                                 , 001)      + //058 058 CÓDIGO CARTEIRA                              001
                          fPadR      ('1'                                 , 001)      + //059 059 CADASTRAMENTO                                001
                          fPadR      ('1'                                 , 001)      + //060 060 TIPO DOCUMENTO                               001
                          fPadR      (strTipDoc                           , 001)      + //061 061 EMISSÃO BLOQUETO                             001
                          fPadR      (strTipDoc                           , 001)      + //062 062 DISTRIB. BLOQUETO                            001
                          fPadL      (strSeuNum                           , 013, '0') + //063 075 NRO DOCUMENTO                                013
                          fPadL      (' '                                 , 002)      + //076 077 ESPACOS                                      002
                          fPadR      (strDtaVen                           , 008)      + //078 085 VENCIMENTO                                   008
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat   , 015)      + //086 100 VALOR DUP                                    013
                          fPadR      (' '                                 , 006)      + //101 106 BRANCOS                                      006
                          fPadR      ('02'                                , 002)      + //107 108 02 - DUPLICATA MERCANTIL                     002
                          fPadR      (IIF(strIdeAce = 'S','A','N')        , 001)      + //109 109 ACEITE                                       001
                          fPadR      (strDtaEmi                           , 008)      + //110 117 DATA DA EMISSAO                              008
                          fPadR      ('1'                                 , 001)      + //118 118 CODIGO DE MORA 1=DIARIO, 2=MENSAL            001
                          fPadR      ('0'                                 , 008, '0') + //119 126 DATA JUROS MORA                              008
                          fValNumForm(fltValAtr                           , 015)      + //127 141 VALOR DA MORA DE ATRAZO                      013
                          fPadR      (' '                                 , 009)      + //142 150 DESCONTO                                     009
                          fPadR      ('0'                                 , 015, '0') + //151 165 VALOR DO DESCONTO                            013
                          fPadR      ('0'                                 , 015, '0') + //166 180 VALOR IOF                                    013
                          fPadR      ('0'                                 , 015, '0') + //181 195 VALOR ABATIMENTO                             013
                          fPadR      (strKeyDup                           , 025)      + //196 220 IDENT. DO TIT. NA EMPRESA                    025
                          fStrZero   (strCodPro                           , 001)      + //221 221 CÓDIGO PROTESTO                              001
                          fStrZero   (strDiaPro                           , 002)      + //222 223 PRAZO PARA PROTESTO                          002
                          fPadR      (IIF( Not fEmptyStr(strDiasbaixa),'1',' '), 001) + //224 224 CÓD. BAIXA                                   001
                          fPadR      (IIF( Not fEmptyStr(strDiasbaixa),strDiasbaixa,' '), 003,' ') + //225 227 PRAZO BAIXA                     003
                          fPadR      ('09'                                , 002)      + //228 229 CÓD. MOEDA                                   002
                          fPadR      (strCodCobr                          , 010)      + //230 239 CÓDIGO COBRANÇA                              010
                          fPadR      ('1'                                 , 001);       //240 240 1 - NÃO AUTORIZA PAGAMENTO PARCIAL

          Writeln(txtTexto,strTransacao);
          Inc(intRegArq);

          Inc(intCodSeq);
          strTransacao := fPadR      (strCodBco                                              , 003)      + //001 003 BANCO                                        003
                          fStrZero   (IntToStr(intSeqLot)                                    , 004)      + //004 007 LOTE DE SERVIÇO                              004
                          fPadR      ('3'                                                    , 001)      + //008 008 REGISTRO                                     001
                          fStrZero   (IntToStr(intCodSeq)                                    , 005)      + //009 013 SEQUENCIAL NO LOTE                           005
                          fPadR      ('Q'                                                    , 001)      + //014 014 SEGMENTO                                     001
                          fPadR      (' '                                                    , 001)      + //015 015 CNAB                                         001
                          fPadR      ('01'                                                   , 002)      + //016 017 CÓD. MOVIMENTO                               002
                          fStrZero   (strCpfCgc                                              , 001)      + //018 018 TIPO DE INSCRICAO DO SACADO                  001
                          fPadL      (strCgcCli                                              , 015, '0') + //019 033 N. INSCRICAO DO SACADO                       015
                          fPadR      (fTiraCaracEspeciais(FieldByName('CLI_NOMCLI').AsString), 040)      + //034 073 NOME DO SACADO                               040
                          fPadR      (fTiraCaracEspeciais(AstrEndereco)                      , 040)      + //074 113 ENDERECO DO SACADO                           040
                          fPadR      (fTiraCaracEspeciais(FieldByName('BAIRRO').AsString)    , 015)      + //114 128 BAIRRO DO SACADO                             015
                          fPadR      (FieldByName('C_E_P_').AsString                         , 008, '0') + //129 136 CEP DO SACADO                                008
                          fPadR      (fTiraCaracEspeciais(FieldByName('CIDADE').AsString)    , 015)      + //137 151 CIDADE DO SACADO                             015
                          fPadR      (FieldByName('ESTADO').AsString                         , 002)      + //152 153 ESTADO DO SACADO                             002
                          fPadR      (' '                                                    , 087);       //154 240 USO DO BANCO                                 087

          Writeln(txtTexto,strTransacao);
          Inc(intRegArq);

          Inc(intCodSeq);
          strTransacao := fPadR      (strCodBco                           , 003)      + //001 003 BANCO                                        003
                          fStrZero   (IntToStr(intSeqLot)                 , 004)      + //004 007 LOTE DE SERVIÇO                              004
                          fPadR      ('3'                                 , 001)      + //008 008 REGISTRO                                     001
                          fStrZero   (IntToStr(intCodSeq)                 , 005)      + //009 013 SEQUENCIAL NO LOTE                           005
                          fPadR      ('R'                                 , 001)      + //014 014 SEGMENTO                                     001
                          fPadR      (' '                                 , 001)      + //015 015 CNAB                                         001
                          fPadR      ('01'                                , 002)      + //016 017 CÓD. MOVIMENTO                               002
                          fPadR      ('0'                                 , 024, '0') + //018 041 DESCONTO 2                                   022
                          fPadR      ('0'                                 , 024, '0') + //042 065 DESCONTO 3                                   022
                          fPadR      (IIF(fltMulAtr > 0, '2', ' ')        , 001)      + //066 066 CÓD. MULTA - 2 - PERCENTUAL                  001
                          fPadR      ('0'                                 , 008, '0') + //067 074 DATA MULTA                                   008
                          fValNumForm(fltMulAtr                        , 15, 02)      + //075 089 TAXA DE MULTA APOS O VENCIMENTO              013
                          fPadR      (' '                                 , 010)      + //090 099 BRANCOS                                      010
                          fPadR      (strObs03                            , 040)      + //100 139 MENSAGEM 3                                   040
                          fPadR      (strObs04                            , 040)      + //140 179 MENSAGEM 4                                   040
                          fPadR      (' '                                 , 061);       //180 240 BRANCOS                                      061

          Writeln(txtTexto,strTransacao);
          Inc(intRegArq);

          if blnInfoAdicionalNF and (not FieldByName('NFE_ACESSO').IsNull)
             and (not fEmptyStr(FieldByName('NFE_ACESSO').AsString))
             and (not FieldByName('NFE_DTAEMI').IsNull) then
          begin
            Inc(intCodSeq);

            strTransacao := fPadR(strCodBco, 003) +                        // 001-003 Código do Banco
                            fStrZero(IntToStr(intSeqLot), 004) +           // 004-007 Lote de Serviço
                            fPadR('3', 001) +                              // 008-008 Tipo de Registro
                            fStrZero(IntToStr(intCodSeq), 005) +           // 009-013 Nº Sequencial do Registro no Lote
                            fPadR('Y', 001) +                              // 014-014 Código do Segmento do Registro Detalhe
                            fPadR('', 001) +                               // 015-015 Uso Exclusivo FEBRABAN/CNAB
                            fPadR('01', 002) +                             // 016-017 Código de Movimento
                            fPadR('52', 002) +                             // 018-019 Código do Registro Opcional

                            fPadL(strNota, 015, '0') +                     // 020-034 Número da Nota Fiscal 1
                            fValNumForm(fltValorNF, 015) +                 // 035-049 Valor da Nota Fiscal 1
                            fPadR(strDataNF, 008) +                        // 050-057 Data de Emissão da Nota Fiscal 1
                            fPadR(strChaveNFE, 044) +                      // 058-101 Chave de Acesso da NF-e 1

                            fPadL('', 015, '0') +                          // 102-116 Número da Nota Fiscal 2
                            fValNumForm(0, 015) +                          // 117-131 Valor da Nota Fiscal 2
                            fPadR('', 008) +                               // 132-139 Data de Emissão da Nota Fiscal 2
                            fPadR('', 044) +                               // 140-183 Chave de Acesso da NF-e 2

                            fPadR('', 057);                                // 184-240 Uso Exclusivo FEBRABAN/CNAB

            Writeln(txtTexto, strTransacao);
            Inc(intRegArq);
          end;

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

      intCodSeq := intCodSeq + 2;
      //*************************************************//
      // TRAILER DO LOTE                                 //
      //*************************************************//
      strTransacao := fPadR      (strCodBco                           , 003)      + //001 003 BANCO                                        003
                      fStrZero   (IntToStr(intSeqLot)                 , 004)      + //004 007 LOTE DE SERVIÇO                              004
                      fPadR      ('5'                                 , 001)      + //008 008 REGISTRO                                     001
                      fPadR      (' '                                 , 009)      + //009 017 BRANCOS                                      009
                      fStrZero   (IntToStr(intCodSeq)                 , 006)      + //018 023 QTD REGISTROS LOTE                           006
                      fStrZero   (IntToStr(intQtdTit)                 , 006)      + //024 029 QTD TÍTULOS EM COBRANÇA                      006
                      fValNumForm(fltTotDup                           , 017)      + //030 046 SOMATORIA DAS DUPLICATAS                     017
                      fPadR      ('0'                                 , 069, '0') + //047 115 ZEROS                                        069
                      fPadR      (' '                                 , 125);       //116 240 BRANCOS                                      125

      Writeln(txtTexto,strTransacao);
      Inc(intRegArq);

      //*************************************************//
      // TRAILLER DO ARQUIVO                             //
      //*************************************************//
      Inc(intRegArq);
      strTrailler := fPadR     (strCodBco                           , 003) + //001 003 BANCO                        003
                     fPadR     ('9999'                              , 004) + //004 007 LOTE DE SERVIÇO              004
                     fPadR     ('9'                                 , 001) + //008 008 REGISTRO                     001
                     fPadR     (' '                                 , 009) + //009 017 BRANCOS                      009
                     fStrZero  ('1'                                 , 006) + //018 023 QTD LOTES ARQUIVO            006
                     fStrZero  (IntToStr(intRegArq)                 , 006) + //024 029 QTD REGISTROS ARQUIVO        006
                     fStrZero  ('0'                                 , 006) + //030 035 QTD CONTAS CONSIL            006
                     fPadR     (' '                                 , 205);  //036 240 BRANCOS                      205

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

	Except
		On E: Exception Do
		Begin

		  fRollBack;

      Try
        CloseFile(txtTexto);
      Except
        //Caso o erro acontecer ap�s o arquivo j� estiver fechado
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

procedure TfrmExpArqRemBanrisul240.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBanrisul240.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

function TfrmExpArqRemBanrisul240.fRetEmpresa: String;
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

function TfrmExpArqRemBanrisul240.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemBanrisul240.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
