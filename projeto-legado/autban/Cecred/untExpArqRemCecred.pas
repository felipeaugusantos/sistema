unit untExpArqRemCecred;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, DirectoryEditFocus, EditFocus,
  StrUtils, Uni, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, DateUtils,
  cxButtonEdit, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemCecred = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRem: TLabel;
    Label1: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

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
  frmExpArqRemCecred: TfrmExpArqRemCecred;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemCecred.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;

    strCodBco  : String;
    strNomBco  : String;
    strNomEmp  : String;
    strCodCar  : String;
    strCodCop  : String;
    strDigCop  : String;
    strCtaCor  : String;
    strDigCor  : String;
    strCodCed  : String;
    strDigCed  : String;
    strNomCed  : String;
    strNumCon  : String;
    strConCli  : String;
    strDiasProt: String;
    strInstProt: String;
    strDiasCred: String;
    strProAce  : String;
    strResp    : String;
    strCodPor  : String;
    strCtaBai  : String;
    strInstru1 : String;
    strInstru2 : String;
    strObs001  : String;
    strObs002  : String;
    strComand  : String;
    strModali  : String;
    strNosNum  : String;
    strSeuNum  : String;
    strParcel  : String;

    strDtaRem   : String;
    strHorRem   : String;
    strDtaVen   : String;
    strDtaVenMulta: String;
    strDtaEmi   : String;
    strDtaMor   : String;

    strAgenCob : String;
    strCodRem  : String;

    strHeader   : String;
    strHeLote   : String;
    strTransacao: String;
    strTrailler : String;
    strTrLote   : String;

    strCgcEmp   : String;
    strCpfCgc   : String;

    strKeyDup   : String;
    strCgcCli   : String;

    intCodSeq   : Integer;
    intSeqCrr   : Integer;

    fltValMor   : Double;
    fltPerMul   : Double;
    fltTotRem   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa  : TUniQuery;
    strPerMul   : String;
    dtaDtaJur   : TDateTime;
    dtaDtaVenMulta: TDateTime;

    strFilePath : String;
    strCartei : String;
    strAutoIncremRem: String;
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
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco      := '085';
  strNomBco      := 'CEDRED';
  strNomEmp      := fRetNomeEmpresa(VS_strCodEmp);
  strCodCar      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'CODCART', '');
  strCodCop      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'CODCOPE', '');
  strDigCop      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'DIGCOPE', '');
  strCodCed      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'CODCEDE', '');
  strDigCed      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'DIGCEDE', '');
  strNomCed      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'NOMCEDE', '');
  strNumCon      := RightStr(fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'NUMCONV', ''), 6);
  intSeqCrr      := 0;

  strConCli      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'CONVCLI', '');
  strDiasProt    := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'DIAPROT', '');
  strDiasCred    := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'DIACRED', '');
  strProAce      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'PROACEI', '');
  strResp        := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'RESPONS', '');
  strCodPor      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'PORBAI_', '');
  strCtaBai      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'CTABAI_', '');
  strInstru1     := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2     := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'INSTRU2', '');
  blnRemLoc      := Not( fGetBancoConfig(0, 'CONFIG085', 'RELOCAL', '') = 'N' );
  strAgenCob     := IIF(strCodCar = '5', strAgenCob,'00000');

  If StrToIntDef(strDiasProt, 0) <> 0 Then
    strInstProt := '1'
  Else
    strInstProt := '3';

  strDtaRem      := FormatDateTime('dd', VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorRem      := FormatDateTime('HH', fNow()) + FormatDateTime('MM', fNow()) + FormatDateTime('SS', fNow());
  strCodRem      := fStrZero(fAtuCodSeq('CONFIG085-' + IntToStr(intCartei), 'PROXNUM'), 6);
  strObs001      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'OBSERV1', '');
  strObs002      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'OBSERV2', '');
  strComand      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'COMANDO', '');
  strModali      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'MODALID', '');

  fltPerMul  := fStrToFloat(fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'PERMULT', ''));

  If fltPerMul > 0 Then
  Begin
    strPerMul := FormatFloat('###,##0.00', fltPerMul);
    strPerMul := fTiraCaracEspeciais(strPerMul);
  End
  Else
    strPerMul := '';

  strCtaCor      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'CODCEDE', '');
  strDigCor      := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'DIGCEDE', '');

  If fEmptyStr(strPerMul) Then
    strPerMul := '0';

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
    strCartei := 'CONFIG085-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
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

    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
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
                                                                     '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B, ';
    strSQL := strSQL + '  CADCLI C, ';
    strSQL := strSQL + '  CADREC R ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CLI_CODCLI = CBI_CODCLI AND ';
    strSQL := strSQL + '  CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = CBI_CODCLI AND ';
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

      strCgcEmp := Trim(strCgcEmp);
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');


      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************JU*}
      strHeader := '';

      strHeader := fPadR   ('085'              , 003) + //001 - 003  [01]
                   fPadR   ('0000'             , 004) + //004 - 007  [02]
                   fPadR   ('0'                , 001) + //008 - 008  [03]
                   fPadR   (' '                , 009) + //009 - 017  [04]
                   fPadR   ('2'                , 001) + //018 - 018  [05]
                   fPadR   (strCgcEmp          , 014) + //019 - 032  [06]
                   fPadR   (strNumCon          , 020) + //033 - 052  [07]
                   fStrZero(strCodCop          , 005) + //053 - 057  [08]
                   fPadR   (strDigCop          , 001) + //058 - 058  [09]
                   fStrZero(strCtaCor          , 012) + //059 - 070  [10]
                   fPadR   (strDigCor          , 001) + //071 - 071  [11]
                   fPadR   (' '                , 001) + //072 - 072  [12]
                   fPadR   (strNomEmp          , 030) + //073 - 102  [13]
                   fPadR   ('CECRED'           , 030) + //103 - 132  [14]
                   fPadR   (' '                , 010) + //133 - 142  [15]
                   fPadR   ('1'                , 001) + //143 - 143  [16]
                   fPadR   (strDtaRem          , 008) + //144 - 151  [17]
                   fPadR   (strHorRem          , 006) + //152 - 157  [18]
                   fPadL   (strCodRem     , 006, '0') + //158 - 163  [19]
                   fPadR   ('087'              , 003) + //164 - 166  [20]
                   fPadR   ('01600'            , 005) + //167 - 171  [21]
                   fPadR   (' '                , 069);  //172 - 240  [22 23 24]

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************JU*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG085-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);


      {******************}
      {* HEADER DO LOTE *}
      {***************JU*}
      strHeLote := '';
      strHeLote := fPadR   ('085'              , 003) + //001 - 003  [01]
                   fPadR   ('0001'             , 004) + //004 - 007  [02]
                   fPadR   ('1'                , 001) + //008 - 008  [03]
                   fPadR   ('R'                , 001) + //009 - 009  [04]
                   fPadR   ('01'               , 002) + //010 - 011  [05]
                   fPadR   (' '                , 002) + //012 - 013  [06]
                   fPadR   ('045'              , 003) + //014 - 016  [07]
                   fPadR   (' '                , 001) + //017 - 017  [08]
                   fStrZero('2'                , 001) + //018 - 018  [09]
                   fStrZero(strCgcEmp          , 015) + //019 - 033  [10]
                   fPadR   (strNumCon          , 020) + //034 - 053  [11]
                   fStrZero(strCodCop          , 005) + //054 - 058  [12]
                   fPadR   (strDigCop          , 001) + //059 - 059  [13]
                   fStrZero(strCtaCor          , 012) + //060 - 071  [14]
                   fPadR   (strDigCor          , 001) + //072 - 072  [15]
                   fPadR   (' '                , 001) + //073 - 073  [16]
                   fPadR   (strNomEmp          , 030) + //074 - 103  [17]
                   fPadR   (strObs001          , 040) + //104 - 143  [18]
                   fPadR   (strObs002          , 040) + //144 - 183  [19]
                   fPadL   (strCodRem     , 008, '0') + //184 - 191  [20]
                   fPadR   (strDtaRem          , 008) + //192 - 199  [21]
                   fPadR   ('00000000'         , 008) + //200 - 207  [22]
                   fPadR   (' '                , 033);  //208 - 240  [28]

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************JU*}
      Writeln(txtTexto,strHeLote);

      With qryRemessa Do
      Begin
        strTransacao := '';
        intCodSeq := 0;
        fltTotRem := 0;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';


          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTAVEN').AsDateTime);

          dtaDtaVenMulta := IncDay(FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaVenMulta := FormatDateTime('dd', dtaDtaVenMulta) +
                            FormatDateTime('mm', dtaDtaVenMulta) +
                            FormatDateTime('yyyy', dtaDtaVenMulta);

          strDtaMor := FormatDateTime('ddmmyyyy', FieldByName('CBI_DTAVEN').AsDateTime + 1);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTACAD').AsDateTime);

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

          strSeuNum := RightStr(FieldByName('CBI_NUMDUP').AsString +
                                FieldByName('CBI_PARCEL').AsString +
                                FieldByName('CBI_ESPDOC').AsString, 15);

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          strNosNum := FieldByName('CBI_NOSNUM').AsString;

          strParcel := IntToStr(fGetPosLetraAlfa(FieldByName('CBI_PARCEL').AsString));

          fltValMor := ((FieldByName('CBI_VALDUP').AsFloat) * (FieldByName('CBI_PORCEN').AsFloat / 100));

          Inc(intCodSeq);
          {************************}
          {* TRANSAÇÃO SEGMENTO P *}
          {*********************JU*}
          strTransacao := fPadR      ('085'                                , 03, ' ') + //001 - 003  [01]
                          fPadR      ('0001'                               , 04, ' ') + //004 - 007  [02]
                          fPadL      ('3'                                  , 01, ' ') + //008 - 008  [03]
                          fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 - 013  [04]
                          fPadL      ('P'                                  , 01, ' ') + //014 - 014  [05]
                          fPadL      (' '                                  , 01, ' ') + //015 - 015  [06]
                          fPadL      ('01'                                 , 02, ' ') + //016 - 017  [07]
                          fStrZero   (strCodCop                                 , 05) + //018 - 022  [08]
                          fPadR      (strDigCop                            , 01, ' ') + //023 - 023  [09]
                          fStrZero   (strCtaCor                                 , 12) + //024 - 035  [10]
                          fPadR      (strDigCor                            , 01     ) + //036 - 036  [11]
                          fPadR      (' '                                  , 01, ' ') + //037 - 037  [12]
                          fPadR      (strCodCed + strDigCed + strNosNum         , 20) + //038 - 057  [13]
                          fPadR      ('1'                                  , 01, ' ') + //058 - 058  [14]
                          fPadR      ('0'                                  , 01, ' ') + //059 - 059  [15]
                          fPadR      ('1'                                  , 01, ' ') + //060 - 060  [16]
                          fPadR      ('2'                                  , 01, ' ') + //061 - 061  [17]
                          fPadR      ('2'                                  , 01, ' ') + //062 - 062  [18]
                          fPadL      (strSeuNum                            , 15, '0') + //063 - 077  [19]
                          fPadR      (strDtaVen                            , 08, ' ') + //078 - 085  [20]
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat    , 15     ) + //086 - 100  [21]
                          fPadR      ('0'                                  , 05, '0') + //101 - 105  [22]
                          fPadR      (' '                                  , 01, ' ') + //106 - 106  [23]
                          fPadR      ('02'                                 , 02, ' ') + //107 - 108  [24]
                          fPadR      (IIF(strProAce = 'S', 'A', 'N')       , 01, ' ') + //109 - 109  [25]
                          fPadR      (strDtaEmi                            , 08, ' ') + //110 - 117  [26]
                          fPadR      ('1'                                  , 01, ' ') + //118 - 118  [27]
                          fPadR      (strDtaMor                            , 08, ' ') + //119 - 126  [28]
                          fValNumForm(fltValMor                            , 15     ) + //127 - 141  [29]
                          fPadR      ('0'                                  , 01, ' ') + //142 - 142  [30]
                          fPadR      ('0'                                  , 08, '0') + //143 - 150  [31]
                          fPadR      ('0'                                  , 15, '0') + //151 - 165  [32]
                          fPadR      ('0'                                  , 15, '0') + //166 - 180  [33]
                          fPadR      ('0'                                  , 15, '0') + //181 - 195  [34]
                          fPadR      (strKeyDup                            , 25, ' ') + //196 - 220  [35]
                          fPadR      (strInstProt                          , 01, ' ') + //221 - 221  [36]
                          fPadL      (strDiasProt                          , 02, '0') + //222 - 223  [37]
                          fPadR      ('2'                                  , 01, ' ') + //224 - 224  [38]
                          fPadR      (' '                                  , 03, ' ') + //225 - 227  [39]
                          fPadL      ('9'                                  , 02, '0') + //228 - 229  [40]
                          fPadL      ('0'                                  , 10, '0') + //230 - 239  [41]
                          fPadR      (' '                                  , 01, ' ');  //240 - 240  [42]

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************JU*}
          Writeln(txtTexto,strTransacao);

          Inc(intCodSeq);
          {************************}
          {* TRANSAÇÃO SEGMENTO Q *}
          {*********************JU*}
          strTransacao := '';
          strTransacao := fPadR      ('085'                                , 03, ' ') + //001 - 003  [01]
                          fPadR      ('0001'                               , 04, ' ') + //004 - 007  [02]
                          fPadL      ('3'                                  , 01, ' ') + //008 - 008  [03]
                          fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 - 013  [04]
                          fPadL      ('Q'                                  , 01, ' ') + //014 - 014  [05]
                          fPadL      (' '                                  , 01, ' ') + //015 - 015  [06]
                          fPadL      ('01'                                 , 02, ' ') + //016 - 017  [07]
                          fPadR      (IIF(Length(Trim(strCgcCli)) > 11, '2', '1'), 01)+ //018 - 018  [08]
                          fPadL      (strCgcCli                            , 15, '0') + //019 - 033  [09]
                          fPadR      (FieldByName('CLI_NOMCLI').AsString   , 40, ' ') + //034 - 073  [10]
                          fPadR      (AstrEndereco                         , 40, ' ') + //074 - 113  [11]
                          fPadR      (FieldByName('BAIRRO').AsString       , 15, ' ') + //114 - 128  [12]
                          fPadR      (LeftStr(FieldByName('C_E_P_').AsString, 5), 05) + //129 - 133  [13]
                          fPadR      (RightStr(FieldByName('C_E_P_').AsString,3), 03) + //134 - 136  [14]
                          fPadR      (FieldByName('CIDADE').AsString       , 15, ' ') + //137 - 151  [15]
                          fPadR      (FieldByName('ESTADO').AsString       , 02, ' ') + //152 - 153  [16]
                          fPadL      ('0'                                  , 16, '0') + //154 - 169  [17 18]
                          fPadR      (' '                                  , 40, ' ') + //170 - 209  [19]
                          fPadL      ('0'                                  , 03, '0') + //210 - 212  [20]
                          fPadR      (' '                                  , 28, ' ');  //213 - 240  [21 22]

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************JU*}
          Writeln(txtTexto,strTransacao);

          Inc(intCodSeq);
          {************************}
          {* TRANSAÇÃO SEGMENTO R *}
          {*********************MO*}
          strTransacao := '';
          strTransacao := fPadR      ('085'                                , 03, ' ') + //001 - 003  [01] Código do Banco na Compensação
                          fPadR      ('0001'                               , 04, ' ') + //004 - 007  [02] Lote de Serviço
                          fPadL      ('3'                                  , 01, ' ') + //008 - 008  [03] Tipo de Registro
                          fStrZero   (IntToStr(intCodSeq)                  , 05)      + //009 - 013  [04] Nº Sequencial do Registro no Lote
                          fPadL      ('R'                                  , 01, ' ') + //014 - 014  [05] Cód. Segmento do Registro Detalhe
                          fPadL      (' '                                  , 01, ' ') + //015 - 015  [06] Uso Exclusivo FEBRABAN/CNAB
                          fPadL      ('01'                                 , 02, ' ') + //016 - 017  [07] Código de Movimento Remessa
                          fPadL      ('0'                                  , 01, ' ') + //018 - 018  [08] Código do Desconto 2
                          fPadR      ('0'                                  , 08, '0') + //019 - 026  [09] Data do Desconto 2
                          fPadL      ('0'                                  , 15, '0') + //027 - 041  [10] Valor/Percentual a ser concedido
                          fPadL      ('0'                                  , 01, ' ') + //042 - 042  [11] Código do Desconto 3
                          fPadR      ('0'                                  , 08, '0') + //043 - 050  [12] Data do Desconto 3
                          fPadL      ('0'                                  , 15, '0') + //051 - 065  [13] Valor/Percentual a Ser Concedido
                          fPadR      ('2'                                  , 01, ' ') + //066 - 066  [14] Código da Multa
                          fPadR      (strDtaVenMulta                       , 08, ' ') + //067 - 074  [15] Data da Multa
                          fStrZero   (strPerMul                            , 15)      + //075 - 089  [16] Valor/Percentual a Ser Aplicado
                          fPadR      (' '                                  , 10, ' ') + //090 - 099  [17] Informação ao Sacado
                          fPadR      (' '                                  , 40, ' ') + //100 - 139  [18] Mensagem 3
                          fPadR      (' '                                  , 40, ' ') + //140 - 179  [19] Mensagem 4
                          fPadR      (' '                                  , 20, ' ') + //180 - 199  [20] Uso Exclusivo FEBRABAN/CNAB
                          fPadR      ('0'                                  , 08, '0') + //200 - 207  [21] Cód. Ocor. do Sacado
                          fPadR      ('085'                                , 03, ' ') + //208 - 210  [22] Cód. do Banco na Conta do Débito
                          fStrZero   (strCodCop                            , 05)      + //211 - 215  [23] Código da Agência do Débito
                          fPadR      (strDigCop                            , 01)      + //216 - 216  [24] Dígito Verificador da Agência
                          fStrZero   (strCtaCor                            , 12)      + //217 - 228  [25] Conta Corrente para Débito
                          fPadR      (strDigCor                            , 01)      + //229 - 229  [26] Dígito Verificador da Conta
                          fPadR      (strDigCor                            , 01)      + //230 - 230  [27] Dígito Verificador Ag/Conta
                          fPadR      ('0'                                  , 01, '0') + //231 - 231  [28] Aviso para Débito Automático
                          fPadR      (' '                                  , 09, ' ');  //232 - 240  [29] Uso Exclusivo FEBRABAN/CNAB

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************MO*}
          Writeln(txtTexto,strTransacao);

          fltTotRem := fltTotRem + FieldByName('CBI_VALDUP').AsFloat;

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

      {********************}
      {* TRAILLER DO LOTE *}
      {*****************JU*}
      strTrLote := '';
      strTrLote := '085'                  +             //001 - 003  [01]
                   fPadR('0001', 04, ' ') +             //004 - 007  [02]
                   fPadR('5'   , 01, ' ') +             //008 - 008  [03]
                   fPadR(' '   , 09, ' ') +             //009 - 017  [04]
                   fPadL(IntToStr(intCodSeq), 06, '0')+ //018 - 023  [05]
                   fPadL(IntToStr(intCodSeq), 06, '0')+ //024 - 029  [06]
                   fValNumForm(fltTotRem         , 17)+ //030 - 046  [07]
                   fPadL('0'   , 23, '0') +             //047 - 069  [08 09]
                   fPadL('0'   , 23, '0') +             //070 - 092  [10 11]
                   fPadL('0'   , 23, '0') +             //093 - 115  [12 13]
                   fPadL('0'   , 08, '0') +             //116 - 123  [14]
                   fPadL(' '   , 117, ' ');             //116 - 240  [15]
      {******************************}
      {* ESCREVE O TRAILLER DO LOTE *}
      {***************************JU*}
      Writeln(txtTexto,strTrLote);

      {***********************}
      {* TRAILLER DO ARQUIVO *}
      {********************JU*}
      intCodSeq := intCodSeq + 4;
      strTrailler := '';
      strTrailler := '085'                        +        //001 - 003  [01]
                     fPadL    ('9', 5, '9')       +        //004 - 008  [02 03]
                     fPadR    (' ', 9, ' ')       +        //009 - 017  [04]
                     fStrZero (1       , 6)       +        //018 - 023  [05]
                     fStrZero (intCodSeq, 006)    +        //024 - 029  [06]
                     fPadL    ('0', 6, '0')       +        //030 - 035  [07]
                     fPadR    (' ', 205, ' ')     ;        //036 - 240  [08]

      {*********************************}
      {* ESCREVE O TRAILLER DO ARQUIVO *}
      {******************************JU*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      If  intSeqCrr < 99 Then
        Inc(intSeqCrr)
      Else
        intSeqCrr := 1;

      fGetBancoConfig(1, 'CONFIG085-' + IntToStr(intCartei), 'SEQRMBB', fStrZero(intSeqCrr, 02));

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

procedure TfrmExpArqRemCecred.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemCecred.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmExpArqRemCecred.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemCecred.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadPor := fCriaQuery(Self);
end;

procedure TfrmExpArqRemCecred.FormShow(Sender: TObject);
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'PATHREM',''));
  If fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'USACRR_','') <> 'S' Then
    edtNomArquivo.Text  := 'RM' +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) +
                           fStrZero(FormatDateTime('yy',VS_Date),2) +
                           '.REM'
  Else
    edtNomArquivo.Text  := 'CBR' +
                           fStrZero(FormatDateTime('yyyy',VS_Date),4) +
                           fStrZero(FormatDateTime('mm',VS_Date),2) +
                           fStrZero(FormatDateTime('dd',VS_Date),2) +
                           fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'SEQRMBB','') +
                           '.REM';
  pSetFocus(edtCodPor);

end;

function TfrmExpArqRemCecred.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

begin

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

function TfrmExpArqRemCecred.fValidaCampos(Sender: TWinControl;
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

end.
