unit untExpArqRemFidussia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemFidussia = class(TfrmPai)
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

    function fRetEmpresa: String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemFidussia: TfrmExpArqRemFidussia;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutban, Data.DB, untConsultas,
     untTypesSistema, untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemFidussia.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'PATHREM',''));

  edtNomArquivo.Text  := 'CB' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) + 'A' + IntToStr(intCartei) + '.REM';
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemFidussia.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strNumDup   : String;
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
    strObserv   : String;
    strEmpAgr   : String;
    strCodCli   : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strRespon   : String;
    strNosNum   : String;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strObsAgr   : WideString;
    strCartSeq  : String;
    strCartei: String;
    strCcDigito : String;
    strCodOco   : String;
    AEnviarChaveNFe: Boolean;

    fltPerMul   : Double;

    qryRemessa  : TUniQuery;

    strFilePath : String;
    strAutoIncremRem: String;
    strMensagemErro : String;

    fltValDup : Double;

    fltValDpo       : Double;
    strDtaDpo       : String;
    dtaDtaDpo       : TDateTime;
    blnUsaCnd       : Boolean;
    blnUsaDesPonCli : Boolean;
    blnUsaDesPon    : Boolean;
    AstrEndereco    : String;
    procedure pListaDupAgr(strNumAgr: String);
      Var
        qryDupAgr: TUniQuery;
        strSQL   : String;
    Begin

      qryDupAgr := fCriaQuery(Self);
      strObsAgr := '';

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   CTR_NUMAGR, ';
      strSQL := strSQL + '   CTR_NUMDUP, ';
      strSQL := strSQL + '   CTR_PARCEL, ';
      strSQL := strSQL + '   CTR_ESPDOC, ';
      strSQL := strSQL + '   CTR_CODEMP, ';
      strSQL := strSQL + '   CTR_CODCLI, ';
      strSQL := strSQL + '   CTR_DTACAD, ';
      strSQL := strSQL + '   CTR_VALDUP  ';
      strSQL := strSQL + ' FROM          ';
      strSQL := strSQL + '   DUPAGR      ';
      strSQL := strSQL + ' WHERE         ';
      strSQL := strSQL + '   CTR_NUMAGR = :NUMAGR AND ';
      strSQL := strSQL + '   CTR_EMPAGR = :EMPAGR AND ';
      strSQL := strSQL + '   CTR_CODCLI = :CODCLI ';
      strSQL := strSQL + ' ORDER BY               ';
      strSQL := strSQL + '   CTR_DTACAD, CTR_CODEMP, CTR_ESPDOC, CTR_NUMDUP, CTR_PARCEL ';

      With qryDupAgr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMAGR').AsString := strNumAgr;
        ParamByName('EMPAGR').AsString := strEmpAgr;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;

        First;

        While Not Eof Do
        Begin
          strObsAgr := strObsAgr + FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) +
                                 ' DOC:' + FieldByName('CTR_NUMDUP').AsString +
                                 FieldByName('CTR_PARCEL').AsString +
                                 FieldByName('CTR_ESPDOC').AsString +
                                 '-' + FieldByName('CTR_CODEMP').AsString +
                                 ' V:' + FormatFloat('#,##0.00', FieldByName('CTR_VALDUP').AsFloat) + ' ';

          Next;
        End;

      End;

      FreeAndNil(qryDupAgr);

    End;

begin
  inherited;
  strNumDup := '';

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

  intCodSeq  := 1;
  strCodBco  := '970';
  strNomBco  := 'Fidussia';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);

  strNumAut  := fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'NUMAUTO', '');
  strCodAge  := fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'CODAGEN', '');
  strEmpBco  := fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'CODEMPR', '');
  strCntCor  := RightStr(fStrZero(fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'NUMCTAC', ''), 7), 7);
  strDigCnt  := fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'CODCART', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'INSTRU1', '');
  strObserv  := fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'OBSERV1', '');
  blnRemLoc  := Not( fGetBancoConfig(0,'CONFIG970', 'RELOCAL', '') = 'N' );

  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'PERMULT', '') );


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

  strRespon := '1';
  If (fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'RESPONS', '') = 'E') Then
    strRespon := '2';

  strDiaPro := IIF(Pos(strInstru1, '06_05_07_18_') > 0, fStrZero(fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'DIAPROT', ''),2), '00');

  Try
    fStartTransaction;
    strCartei  := 'CONFIG970-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  E.*,  C.CID_NOMCID, C.CID_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP E ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = E.EMP_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strNovCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      Close;
    End;

    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, C.CLI_PERDPO, C.CLI_QTDDAV, ';
    strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
    strSQL := strSQL + '  R.CTR_JURSUJ AS CTR_JURSUJ, ';


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
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND ';


    strSQL := strSQL + 'WHERE                                       ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND                  ';
    strSQL := strSQL + '  ((CTR_DTAREC IS NULL AND (B.CBI_CODOCO = "01" OR B.CBI_CODOCO = "06" OR B.CBI_CODOCO = "20")) OR';
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
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG970-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG970-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      strEmpAgr := qryRemessa.FieldByName('CBI_CODEMP').AsString;
      strCodCli := qryRemessa.FieldByName('CBI_CODCLI').AsString;

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      strHeader := '';

      strHeader := fPadR   ('0'                      , 001)      + //001 - 001 IDENTIFICAÇÃO DO REGISTRO
                   fPadR   ('1'                      , 001)      + //002 - 002 IDENTIFICAÇÃO DO ARQUIVO REMESSA
                   fPadR   ('REMESSA'                , 007)      + //003 - 009 LITERAL REMESSA
                   fPadR   ('01'                     , 002)      + //010 - 011 CÓDIGO DE SERVIÇO
                   fPadR   ('COBRANCA'               , 015)      + //012 - 026 LITERAL SERVIÇO
                   fPadL   (strEmpBco                , 020, '0') + //027 - 046 CÓDIGO DA EMPRESA
                   fPadR   (strNomEmp                , 030)      + //047 - 076 NOME DA EMPRESA
                   fPadR   ('237'                    , 003)      + //077 - 079 Nº DO BANCO
                   fPadR   ('BRADESCO'               , 015)      + //080 - 094 NOME DO BANCO POR EXTENSO
                   fPadR   (strDtaRem                , 006)      + //095 - 100 DATA DA GRAVAÇÃO DO ARQUIVO
                   fPadR   (' '                      , 008)      + //101 - 108 BRANCO
                   fPadR   ('MX'                     , 002)      + //109 - 110 IDENTIFICAÇÃO DO SISTEMA
                   fPadR   (strCodRem                , 007)      + //111 - 117 Nº SEQUÊNCIAL DE REMESSA
                   fPadR   (' '                      , 277)      + //118 - 394 BRANCO
                   fStrZero('1'                      , 006);       //395 - 400 Nº SEQUÊNCIAL DO REGISTRO DE UM EM UM

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

        While Not Eof Do
        Begin

          strObserv  := fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'OBSERV1', '');

          //Req 108135
          If (fEmptyStr(strObserv)) And
             (Pos(strInstru1, '06_05_07_18_') > 0) Then
            strObserv := 'PROTESTAR APOS ' + strDiaPro + IIF(StrToInt(strDiaPro) = 1,' DIA ', ' DIAS ') + 'DO VENCIMENTO';

          Inc(intCodSeq);
          Application.ProcessMessages;

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          If FieldByName('CBI_CGCCPF').AsInteger = 0 Then
            strCpfCgc := '99'
          Else If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime);

          strNumDup := (FieldByName('CBI_NUMDUP').AsString) + (FieldByName('CBI_PARCEL').AsString);

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

          If blnUsaDesPonCli And blnUsaDesPon Then

          Begin
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
            fltValDpo := 0;
            strDtaDpo := '0';
          End;

          {*******************************************}
          {* SE BANCO EMITE BOLETO                   *}
          {****************************************MV*}
          strNosNum := FieldByName('CBI_NOSNUM').AsString;
          If (strRespon = '1') Then
            strNosNum := '0';

          strIdeEmp := '0'                                 + //021
                       RightStr(fStrZero(strCodCar, 3), 3) + //022
                       RightStr(fStrZero(strCodAge, 5), 5) + //025
                       RightStr(fStrZero(strCntCor, 7), 7) + //030
                       RightStr(fStrZero(strDigCnt, 1), 1);  //037

           strTransacao := fPadR       ('1'                                            , 001)      + //001 - 001 IDENTIFICAÇÃO DO REGISTRO
                           fStrZero    ('0'                                            , 005)      + //002 - 006 AG DE DÉBITO (OPCIONAL)
                           fStrZero    ('0'                                            , 001)      + //007 - 007 DIGITO DA AG DE DÉBITO (OPCIONAL)
                           fStrZero    ('0'                                            , 005)      + //008 - 012 RAZÃO DA CONTA CORRENTE (OPCIONAL)
                           fStrZero    ('0'                                            , 007)      + //013 - 019 CONTA CORRENTE (OPCIONAL)
                           fStrZero    ('0'                                            , 001)      + //020 - 020 DIGITO DA CONTA CORRENTE (OPCIONAL)
                           fPadR       (strIdeEmp                                      , 017)      + //021 - 037 IDENTIFICAÇÃO DA EMPRESA CEDENTE NO BANCO
                           fPadR       (strKeyDup                                      , 025)      + //038 - 062 Nº CONTROLE DO PARTICIPANTE
                           fPadR       ('000'                                          , 003)      + //063 - 065 CÓDIGO DO BANCO A SER DEBITADO NA CÂMARA DE COMPENSAÇÃO
                           fPadR       (IIF(fltPerMul > 0, '2', '0')                   , 001)      + //066 - 066 (2) P\ CONSIDERAR O PERCENTUAL DE MULTA (0) SEM MULTA
                           fValNumForm (fltPerMul                                      , 004)      + //067 - 070 PERCENTUAL DE MULTA A SER CONSIDERADO
                           fStrZero    (strNosNum                                      , 012)      + //071 - 081 IDENTIFICAÇÃO DO TÍTULO NO BANCO
                           fStrZero    ('0'                                            , 010)      + //083 - 092 DESCONTO BONIFICAÇÃO POR DIA
                           fPadR       (strRespon                                      , 001)      + //093 - 093 CONDIÇÃO PARA EMISSÃO DA PAPELETA DE COBRANÇA
                           fPadR       (' '                                            , 001)      + //094 - 094 IDENTIFICAÇÃO SE EMITE BOLETO PARA DÉBITO AUTOMÁTICO
                           fPadR       (' '                                            , 010)      + //095 - 104 IDENTIFICAÇÃO DA OPERAÇÃO
                           fPadR       (' '                                            , 001)      + //105 - INDICADOR RATEIO CRÉDITO (OPCIONAL)
                           fPadR       ('2'                                            , 001)      + //106 - ENDEREÇAMENTO PARA AVISO DO DÉBITO AUTOMATICO EM CONTA CORRENTE (OPCIONAL)
                           fPadR       (' '                                            , 002)      + //107 - 108 BRANCO
                           fPadR       (strCodOco                                      , 002)      + //109 - 110 IDENTIFICAÇÃO DA OCORRÊNCIA
                           fPadR       (RightStr(strNumDup, 10)                        , 010)      + //111 - 120 Nº DO DOCUMENTO
                           fPadR       (strDtaVen                                      , 006)      + //121 - 126 DATA DO VENCIMENTO DO TÍTULO
                           fValNumForm (fltValDup                                      , 013)      + //127 - 139 VALOR DO TÍTULO
                           fStrZero    ('0'                                            , 003)      + //140 - 142 BANCO ENCARREGADO DA COBRANÇA
                           fStrZero    ('0'                                            , 005)      + //143 - 147 AG DEPOSITÁRIA
                           fPadR       ('01'                                           , 002)      + //148 - 149 ESPÉCIE DO TÍTULO
                           fPadR       ('N'                                            , 001)      + //150 - 150 IDENTIFICAÇÃO
                           fPadR       (strDtaEmi                                      , 006)      + //151 - 156 DATA DA EMISSÃO DO TÍTULO
                           fPadR       (strInstru1                                     , 002)      + //157 - 158 1ª INSTRUÇÃO
                           fPadR       (strDiaPro                                      , 002)      + //159 - 160 2ª INSTRUÇÃO
                           fValNumForm (fltValAtr                                      , 013)      + //161 - 173 VALOR A SER COBRADO POR DIA DE ATRASO
                           fPadR       (IIF(fltValDpo > 0, strDtaDpo,
                                            IIF(FieldByName('CBI_DESSUJ').AsFloat > 0,
                                                strDtaVen, '0'))                       , 006,'0')  + //174 - 179 DATA LIMITE P/ CONCESSÃO DE DESCONTO
                           IIF(fltValDpo > 0,
                               fValNumForm (fltValDpo, 13),
                               fValNumForm (FieldByName('CBI_DESSUJ').AsFloat          , 013))     + //180 - 192 VALOR DO DESCONTO
                           fStrZero    ('0'                                            , 013)      + //193 - 205 VALOR IOF
                           fStrZero    ('0'                                            , 013)      + //206 - 218 VALOR DO ABATIMENTO A SER CONCEDIDO OU CANCELADO
                           fStrZero    (strCpfCgc                                      , 002)      + //219 - 220 IDENTIFICAÇÃO DO TIPO DE INSCRIÇÃO DO SACADO
                           fPadL       (strCgcCli                                      , 014, '0') + //221 - 234 Nº INSCRIÇÃO DO SACADO
                           fPadR       (FieldByName('CLI_NOMCLI').AsString             , 040)      + //235 - 274 NOME DO SACADO
                           fPadR       (AstrEndereco                                   , 040)      + //275 - 314 LOGRADOURO (ENDEREÇO)
                           fPadR       (' '                                            , 012)      + //315 - 1ª MENSAGEM
                           fPadL       (LeftStr(FieldByName('C_E_P_').AsString,5)      , 005, '0') + //327 - 331 CEP
                           fPadL       (RightStr(FieldByName('C_E_P_').AsString,3)     , 003, '0') + //332 - 334 SUFIXO
                           fPadR       (strObserv                                      , 060)      + //335 - 394 SACADOR/AVALISTA OU 2ª MENSAGEM
                           fStrZero    (IntToStr(intCodSeq)                            , 006);       //395 - 400 Nº SEQUÊNCIAL DO REGISTRO

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
                       fltPerMul,
                       FieldByName('CBI_VALDUP').AsFloat,
                       FieldByName('CTR_DTAREC').AsDateTime,
                       FieldByName('CBI_DTAVEN').AsDateTime,
                       VS_Date,
                       strLoginUsuarioLogado,
                       '');

          {****************}
          {* GRAVA LOGCTR *}
          {*************JS*}
          untLogCtr.GravaLogCtr(FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - ' + strCodBco, Self.Name);

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

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

{      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
 }
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CADCBI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';

      If (Not fEmptyStr(edtCodPor.Text)) Then
        strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

      if (fCfgSis('CONREM', varString) = 'C') THEN
        strSQL := strSQL + ' AND CBI_CARTEI = :CARTEI ';

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

        ExecSQL;
        Close;
      End;

      pBackupCnfBco;

      If fCommit then
			  fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
					        'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

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

procedure TfrmExpArqRemFidussia.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemFidussia.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

function TfrmExpArqRemFidussia.fRetEmpresa: String;
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
    SQL.Add('SELECT * FROM CADEMP ');
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
  {**************}
  {* 14/01/2011 *}
  {***********RV*}
  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);

  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;


function TfrmExpArqRemFidussia.fValidaCampos(Sender: TWinControl;
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
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmExpArqRemFidussia.FormCreate(Sender: TObject);
begin
  inherited;
   qryCadPor := fCriaQuery(Self);
end;

end.
