unit untExpArqRemDaycoval;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit,  cxTextEdit, cxMaskEdit,
  cxButtonEdit, DateUtils, FilenameEditFocus,
  cxClasses, cxShellBrowserDialog,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemDaycoval = class(TfrmPai)
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
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private

    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;
    fltPerMul   : Double;
    blnVirtualUI: Boolean;

    function fRetEmpresa: String;
    function fRetSequencialDiaArquivo: Integer;

    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemDaycoval: TfrmExpArqRemDaycoval;

implementation

uses untFuncoes, untFuncoesSimples, untFuncAutBan, DB, untTypesSistema, untConsultas,
     untConstantes, untLogCtr, VirtualUI_SDK;

{$R *.dfm}

procedure TfrmExpArqRemDaycoval.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'ZPD' +
                          FormatDateTime('dd', VS_Date) +
                          FormatDateTime('mm', VS_Date) +
                          fRetSequencialDiaArquivo.ToString() +
                         '.TXT';
  pSetFocus(edtCodPor);

  blnVirtualUI := VirtualUI.Active;

  fraPathRemessa.Enabled  := Not blnVirtualUI;
  lblPathRem.Enabled      := Not blnVirtualUI;
end;

procedure TfrmExpArqRemDaycoval.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaMor   : String;
    strDtaEmi,
    strDtaMul   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcEmpMsg: String;
    strEndEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
    strContCor  : String;
    strDigCnt   : String;
    strCodCar   : String;
    strDigCar   : String;
    strCpfCgc   : String;
    strCodRem   : String;
    strInstru1  : String;
    strInstru2  : String;
    strDiaPro   : String;
    strObsAgru  : String;
    strCep      : String;

    strHeader   : String;
    strTransacao: String;
    strMensagem : String;
    strMsgLin1  : String;
    strMsgLin2  : String;
    strMsgLin3  : String;
    strValDup   : String;
    strNumDup   : String;
    strTrailler : String;
    strMsg1     : String;
    strMsg2     : String;
    strMsg3     : String;
    strCodFlash : String;
    strCartSeq  : String;
    strPagador  : String;
    strEndPagador: String;
    strIdenBan  : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa  : TUniQuery;

    strFilePath : String;
    strCartei: String;
    strAutoIncremRem: String;

    fltValDpo       : Double;
    strDtaDpo       : String;
    dtaDtaDpo       : TDateTime;
    blnUsaCnd       : Boolean;
    blnUsaDesPonCli : Boolean;

    fltValDup : Double;

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

  strCodBco  := '707';
  strNomBco  := 'BANCO DAYCOVAL';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodAgen := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'CODAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt  := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'NUMCART', '');
  strDigCar  := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'CODCART', '');
  strInstru1 := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'INSTRU1', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'DIAPROT', '');
  strIdenBan := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'IDENTBC', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG995', 'RELOCAL', '') = 'N' );
  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'PERMULT', '0') );

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  If (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '2')) Then
    blnUsaDesPonCli := True
  else
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

  If Not fEmptyStr(fCfgSis('NOMCED')) Then
    strNomEmp := fCfgSis('NOMCED');

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
    strSQL := strSQL + '  EMP_C_G_C_, ';
    strSQL := strSQL +  fRetSQLCGCCPFFormatado('1','EMP_C_G_C_') + ' AS EMP_C_G_C_FMT,';
    strSQL := strSQL + '  CONCAT(IFNULL(EMP_ENDERE,""), ", ", IFNULL(EMP_ENDNUM, ""), IF(IFNULL(EMP_ENDCOM, "") = "", "", CONCAT("  ", EMP_ENDCOM)), ';
    strSQL := strSQL + '  CONCAT(IF(IFNULL(EMP_BAIRRO,"")="","",CONCAT(", ", EMP_BAIRRO)), ';
    strSQL := strSQL + '  CONCAT(IF(IFNULL(EMP_C_E_P_,"")="","",CONCAT(" - CEP ",EMP_C_E_P_))), ';
    strSQL := strSQL + '  CONCAT(IF(IFNULL(CID_NOMCID,"")="","",CONCAT(" - ",CID_NOMCID))), ';
    strSQL := strSQL + '  CONCAT(IF(IFNULL(CID_ESTADO,"")="","",CONCAT(" - ",CID_ESTADO))))) AS EMP_ENDERE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp    := FieldByName('EMP_C_G_C_').AsString;
      strCgcEmpMsg := FieldByName('EMP_C_G_C_FMT').AsString;
      strEndEmp    := FieldByName('EMP_ENDERE').AsString;
      Close;
    End;

{  Finally
    FreeAndNil(qryConsultaGen);
  ENd;

  Try}
    strCartei := 'CONFIG995-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
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

    strSQL := strSQL + 'FROM              ';
    strSQL := strSQL + '  CADCBI B        ';
    strSQL := strSQL + '  JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI     ';
    strSQL := strSQL + '  JOIN CADREC R ON CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '                   CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '                   CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '                   CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '                   CTR_CODCLI = CBI_CODCLI ';

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND  ';

    strSQL := strSQL + 'WHERE                                                 ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND                            ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL                                  ';

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
      ParamByName('CODBCO').AsString := '995';

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      if (fCfgSis('CONREM', varString) = 'C') THEN
        ParamByName('CARTEI').AsString := strCartei;

      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      //Gerando número da remessa e atualizando carteiras "filhas"
      strCartSeq := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG995-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 7);
      pAtualizaProxNumCartsAutBan('CONFIG995-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq));

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001) + //001
                   fPadR   ('1'                , 001) + //002
                   fPadR   ('REMESSA'          , 007) + //003
                   fPadR   ('01'               , 002) + //010
                   fPadR   ('COBRANCA'         , 015) + //012
                   fStrZero(strIdenBan         , 012) + //038
                   fPadR   (' '                , 008) + //039
                   fPadR   (strNomEmp          , 030) + //047
                   fPadR   (strCodBco          , 003) + //077
                   fPadR   (strNomBco          , 015) + //080
                   fPadR   (strDtaRem          , 006) + //095
                   fPadR   (' '                , 294) + //101
                   fStrZero(IntToStr(intCodSeq), 006);  //395

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, '995', StrCartei, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          strObsAgru  := '';
          strCodFlash := '';
          strMsg1     := '';
          strMsg2     := '';
          strMsg3     := '';
          Inc(intCodSeq);
          Application.ProcessMessages;

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          if (fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'ENVDUPAG', '') = 'S'){{ or
             (fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'ENVDUPAG', '') = '')} then
          begin
            If (qryRemessa.FieldByName('CBI_ESPDOC').AsString = 'AG') Then
              strObsAgru := 'REF:_' + COPY(qryRemessa.FieldByName('CBI_OBSAG1').AsString,11,23);
          end;

          strInstru1 := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'INSTRU1', '');
          strInstru2 := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'INSTRU2', '');

          if  ((strInstru1 = '93') or (strInstru1 = '94') or (strInstru2 = '93') or (strInstru2 = '94')) then
          begin
            strObsAgru := qryRemessa.FieldByName('CBI_OBSAG1').AsString + ' ' +
                          qryRemessa.FieldByName('CBI_OBSAG2').AsString + ' ' +
                          qryRemessa.FieldByName('CBI_OBSAG3').AsString;

            if fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'OBSERV1', '') <> '' then
            begin
              strMsg1    := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'OBSERV1', '');
              strMsg2    := Copy(strObsAgru, 001, 128);
              strMsg3    := Copy(strObsAgru, 129, 127);
            end
            else
            begin
              strMsg1    := Copy(strObsAgru, 001, 128);
              strMsg2    := Copy(strObsAgru, 129, 128);
              strMsg3    := Copy(strObsAgru, 257, 127);;
            end;

            if fEmptyStr(fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'CDFLASH', '')) Then
            Begin
              strObsAgru := strMsg1    + ' ' + strMsg2 + ' ' + strMsg3;
              strCodFlash:= '';
            End
            Else
            begin
              strCodFlash:= fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'CDFLASH', '');
              strObsAgru := '';
            end;
          end;

          strPagador    := FieldByName('CLI_NOMCLI').AsString;
          strEndPagador := FieldByName('ENDERE').AsString + ', ' +
                           FieldByName('BAIRRO').AsString + ', ' +
                           strCep + ' - ' +
                           FieldByName('CIDADE').AsString + ' - ' +
                           FieldByName('ESTADO').AsString;

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaMor := FormatDateTime('ddmmyy', FieldByName('CBI_DTAVEN').AsDateTime +
                                      StrToInt(fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'DIAMORA', '')));

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

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          strCep := Trim(FieldByName('C_E_P_').AsString);
          strCep := AnsiReplaceStr(strCep, '-', '');


          fltValDup := FieldByName('CBI_VALDUP').AsFloat;

          If fCfgSis('VALIMP', varBoolean) then
          begin
            fltValDup := fltValDup + FieldByName('CTR_JURSUJ').AsFloat +
                                     FieldByName('CTR_DESCOB').AsFloat;
          end;

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

          strTransacao := fPadR      ('1'                                                                    , 01)      + //001
                          fPadR      ('02'                                                                   , 02)      + //002
                          fPadL      (strCgcEmp                                                              , 14, '0') + //004
                          fStrZero   (strIdenBan                                                             , 12)      + //018
                          fPadR      (' '                                                                    , 04)      + //030
                          fStrZero   ('0'                                                                    , 04)      + //034
                          fPadR      (strKeyDup                                                              , 25)      + //038
                          fPadR      (LeftStr(fStrZero(FieldByName('CBI_NOSNUM').AsString,8)                 ,8), 08, '0') + //063
                          fPadL      ('00000'                                                                , 05)      + //071
                          fPadR      (LeftStr(fStrZero(FieldByName('CBI_NOSNUM').AsString,8),8)              , 08, '0') + //076
                          fPadR      (' '                                                                    , 24)      + //084
                          fPadR      ('4'                                                                    , 01)      + //108
                          fPadR      ('01'                                                                   , 02)      + //109
                          fPadR      (RightStr(FieldByName('CBI_NUMDUP').AsString, 09) + FieldByName('CBI_PARCEL').AsString, 10) + //111
                          fPadR      (strDtaVen                                                              , 06)      + //121
                          fValNumForm(fltValDup                                                              , 13)      + //127
                          fPadR      (strCodBco                                                              , 03)      + //140
                          fStrZero   ('0'                                                                    , 05)      + //143
                          fPadR      ('01'                                                                   , 02)      + //148
                          fPadR      ('N'                                                                    , 01)      + //150
                          fPadR      (strDtaEmi                                                              , 06)      + //151
                          fPadR      (strInstru1 {85}                                                        , 02)      + //157
                          fPadR      (strInstru2 {'05'}                                                      , 02)      + //159
                          fValNumForm(fltValAtr                                                              , 13)      + //161
                          fPadR(IIF(fltValDpo > 0,strDtaDpo,IIF(FieldByName('CBI_DESSUJ').AsFloat > 0,strDtaVen, '0')), 06,'0')  + //174
                          IIF(fltValDpo > 0, fValNumForm(fltValDpo, 13), fValNumForm(FieldByName('CBI_DESSUJ').AsFloat, 13))     + //180
                          fStrZero   ('0'                                                                    , 13)      + //193
                          fStrZero   ('0'                                                                    , 13)      + //206
                          fStrZero   (strCpfCgc                                                              , 02)      + //219
                          fPadL      (strCgcCli                                                              , 14, '0') + //221
                          fPadR      (FieldByName('CLI_NOMCLI').AsString                                     , 30)      + //235
                          fPadR      (' '                                                                    , 10)      + //265
                          fPadR      (AstrEndereco                                                           , 40)      + //275
                          fPadR      (FieldByName('BAIRRO').AsString                                         , 12)      + //315
                          fPadR      (strCep                                                                 , 08, '0') + //327
                          fPadR      (FieldByName('CIDADE').AsString                                         , 15)      + //335
                          fPadR      (FieldByName('ESTADO').AsString                                         , 02)      + //350
                          fPadR      (strNomEmp                                                              , 30)      + //352
                          fPadR      (' '                                                                    , 04)      + //382
                          fPadR      (' '                                                                    , 06)      + //386
                          fStrZero   (strDiaPro                                                              , 02)      + //392
                          fPadR      ('0'                                                                    , 01)      + //394
                          fStrZero   (IntToStr(intCodSeq)                                                    , 06);       //395

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);

          {************************}
          {* REGISTRO 7 MENSAGENS *}
          {*********************JU*}
          If Not fEmptyStr(strCodFlash) Then
          Begin
            Inc(intCodSeq);

            strMensagem := '';
            strMsgLin1  := '';
            strMsgLin2  := '';
            strMsgLin3  := '';

            {********************************************************************************************}
            {********************** CONFORME O GABARITO ENVIADO NO REQUISITO 85317 **********************}
            {********* AS POSIÇÕES 5, 135 E 265 SÃO REFERENTES AS LINHAS DO RECIBO DO PAGADOR ***********}
            {*** ONDE 1 É BENEFICIÁRIO, 3 É CPI, 5 É DATA DO DOCUMENTO, 7 É ENDEREÇO E 8 OBSERVAÇÕES ****}
            {* NESSE CASO EM QUESTÃO ESTOU ENVIANDO FIXO 01 BENEFICIÁRIO, 07 ENDEREÇO DO MESMO E 08 OBS *}
            {*REQ*85317*******************************************************************************MO*}

            strValDup := FormatFloat('#,##0.00', FieldByName('CBI_VALDUP').AsFloat);
            strNumDup := IntToStr(StrToInt64(FieldByName('CBI_NUMDUP').AsString)) + FieldByName('CBI_PARCEL').AsString;
            strDtaVen := FormatDateTime('dd/mm/yyyy', FieldByName('CBI_DTAVEN').AsDateTime);
            strDtaEmi := FormatDateTime('dd/mm/yyyy', FieldByName('CBI_DTACAD').AsDateTime);
            strDtaRem := FormatDateTime('dd/mm/yyyy',VS_Date);

            // 128 posições
            strMsgLin1  := fPadR   (strNomEmp,                                  60) +
                           fPadR   (strCgcEmpMsg,                               20) +
                           fPadR   (strDtaVen,                                  20) +
                           fPadR   (' ',                                        28);

            // 128 posições
            strMsgLin2  := fPadR   (' ',                                        20) +
                           fPadR   (strCodCar,                                   8) +
                           fPadR   ('R$',                                       31) +
                           fPadR   (strValDup,                                  20) +
                           fPadR   (strCodAgen + '/' + strContCor + '-' + strDigCnt,  49);

            // 127 posições
            strMsgLin3  := fPadR   (' ',                                         3) +
                           fPadR   (strDtaEmi,                                  15) +
                           fPadR   (strNumDup,                                  20) +
                           fPadR   ('DMI',                                      15) +
                           fPadR   ('N',                                        10) +
                           fPadR   (strDtaRem,                                  16) +
                           fPadR   (strValDup,                                  34);

            strMensagem := fPadR   ('7',                                       001) + //001
                           fPadR   (strCodFlash,                               003) + //002
                           fPadR   ('01',                                      002) + //005
                           fPadR   (strMsgLin1,                                128) + //007
                           fPadR   ('03',                                      002) + //135
                           fPadR   (strMsgLin2,                                128) + //137
                           fPadR   ('05',                                      002) + //265
                           fPadR   (strMsgLin3,                                127) + //267
                           fPadR   ('1',                                       001) + //394
                           fStrZero(IntToStr(intCodSeq),                       006);  //395

            {************************}
            {* ESCREVE AS MENSAGENS *}
            {*********************JU*}
            Writeln(txtTexto,strMensagem);

            Inc(intCodSeq);

            strMensagem := fPadR   ('7',                                     001) + //001
                           fPadR   (strCodFlash,                             003) + //002
                           fPadR   ('07',                                    002) + //005
                           fPadR   (strEndEmp,                               128) + //007
                           fPadR   ('08',                                    002) + //135
                           fPadR   (strMsg1 + ' ' + strMsg2 + ' ' + strMsg3, 128) + //137
                           fPadR   ('09',                                    002) + //265
                           fPadR   (' ',                                     127) + //267
                           fPadR   ('1',                                     001) + //394
                           fStrZero(IntToStr(intCodSeq),                     006);  //395

            {************************}
            {* ESCREVE AS MENSAGENS *}
            {*********************JU*}
            Writeln(txtTexto,strMensagem);
          End;

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       FieldByName('CBI_NOSNUM').AsString,
                       fltPerMul,
                       FieldByName('CBI_VALDUP').AsFloat,
                       FieldByName('CTR_DTAREC').AsDateTime,
                       FieldByName('CBI_DTAVEN').AsDateTime,
                       VS_Date,
                       strLoginUsuarioLogado,
                       '');

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

      pDeletaCadCbi('995', strCartei, edtCodPor.Text);

      pBackupCnfBco;

      If blnVirtualUI Then
        VirtualUI.DownloadFile(strFilePath);

      If fCommit then
      Begin
        {*******************************************}
        {* GRAVA A TABELA LOGCTR FORA DA TRANSAÇÃO *}
        {* POIS ESTAVA CAUSANDO TIMEOUT EM OUTRAS  *}
        {* ROTINAS DO SISTEMA.                     *}
        {*REQ*145737*****************************RP*}
        pGravaLogctr;

		    fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
				          IIF(Not blnVirtualUI, 'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ''), ['&O K']);
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

procedure TfrmExpArqRemDaycoval.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemDaycoval.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

function TfrmExpArqRemDaycoval.fRetEmpresa: String;
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

  FreeAndnil(qryCadEmp);
end;


function TfrmExpArqRemDaycoval.fRetSequencialDiaArquivo: Integer;
var
  qryCons: TUniQuery;
begin
  qryCons := fCriaQuery();
  with qryCons do
  begin
    Sql.Clear;
    Sql.Text := ' SELECT * FROM REMGER WHERE ' +
                '   GER_CODBCO = :CODBCO AND ' +
                '   GER_CODEMP = :CODEMP AND ' +
                '   GER_CARTEI = :CARTEI AND ' +
                '   GER_DTACAD = :DTACAD ';

    ParamByName('CODBCO').AsString := '995';
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CARTEI').AsString := 'CONFIG995-' + IntToStr(intCartei)+ '-' + VS_strCodEmp;
    ParamByName('DTACAD').AsDateTime := VS_Date;

    Open;

    Result := RecordCount + 1;
  end;

  FreeAndNil(qryCons);
end;

function TfrmExpArqRemDaycoval.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemDaycoval.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemDaycoval.FormCreate(Sender: TObject);
begin
  inherited;
     qryCadPor := fCriaQuery(Self);
end;

end.
