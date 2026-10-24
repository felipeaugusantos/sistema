unit untExpArqRemNordeste400;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFuncAutban, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemNordeste400 = class(TfrmPai)
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
    strSeqDia      : String;
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;

  public
    { Public declarations }
    intCartei  : Integer;
    strNomForm : String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemNordeste400: TfrmExpArqRemNordeste400;

implementation

uses untFuncoes, untfuncoesSimples, DB,
  untCfgGenericas_AutBan, untConsultas, untConstantes, untTypesSistema, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemNordeste400.FormShow(Sender: TObject);
  Var
    strCodCed : String;

begin
  inherited;
  strCodCed           := fGetBancoConfig(0,'CONFIG004-' + IntToStr(intCartei), 'CODCEDE', '');
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'PATHREM',''));
  strSeqDia           := fStrZero(fAtuCodSeq('CONFIG004-' + IntToStr(intCartei), 'PROXNUM'), 7);

  edtNomArquivo.Text  := 'R400_' +
                         fStrZero(fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'NUMCTAC',''), 06) +
                         fGetBancoConfig(0,'CONFIG004-' + IntToStr(intCartei), 'DIGCTAC', '')               + '_' +
                         fStrZero(fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'CODAGEN',''), 04) + '_' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yyyy',VS_Date),4) + '_' +
                         strSeqDia +
                         '.REM';
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemNordeste400.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strContBco  : String;
    strDigCont  : String;
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
    strInstru1  : String;
    strTaxComPer   : String;
    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    intCodSeq   : Integer;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    strRespon   : String;
    strDtaIns   : String;
    qryRemessa  : TUniQuery;
    strFilePath : String;
    strNumContr : String;
    fltValMor,
    fltPerMul,
    fltValDup   : Double;

    strNosNum   : String;
    strAceite   : String;
    strObser1   : String;
    strDiaProt  : String;
    strSeuNum   : String;
    strCartei: String;
    strAutoIncremRem: String;
    strCodRem   : String;

    strNomCliente: String;
    AstrEndereco : String;

    procedure pDeletaCadCbi;
      Var
        strSQL: String;
        qryDel: TUniQuery;
    begin
      qryDel := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADCBI ';
      strSQL := strSQL + 'WHERE CBI_CODBCO = :CODBCO ';

      If (Not fEmptyStr(edtCodPor.Text)) Then
        strSQL := strSQL + ' AND CBI_CODPOR = :CODPOR ';

      If (fCfgSis('CONREM', varString) = 'C') Then
      Begin
        If fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'RESPONS', '') = 'E' Then
          strSQL := strSQL + ' AND CBI_CARTEI = :CARTEI ';
      End;

      With qryDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;

        If (Not fEmptyStr(edtCodPor.Text)) Then
          ParamByName('CODPOR').AsString := edtCodPor.Text;

        If (fCfgSis('CONREM', varString) = 'C') Then
        Begin
          If fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'RESPONS', '') = 'E' Then
            ParamByName('CARTEI').AsString := strCartei;
        End;

        ExecSQL;
        Close;
        fGetBancoConfig(1, 'CONFIG004-' + IntToStr(intCartei), 'ULTREME', FormatDateTime('dd/mm/yyyy', VS_Date));
      End;

      FreeAndNil(qryDel);
    end;

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

  strCodBco  := '004';
  strNomBco  := 'B. DO NORDESTE';
  strContBco := fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCont := fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'CODCART', '');
  strRespon  := fGetBancoConfig(0,'CONFIG004-' + IntToStr(intCartei), 'RESPONS', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  strInstru1 := fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'INSTRU1', '');
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG004-', 'RELOCAL', '') = 'N');
  strNumContr:= fGetBancoConfig(0,'CONFIG004-' + IntToStr(intCartei), 'NUMCONT', '');
  strObser1  := fGetBancoConfig(0,'CONFIG004-' + IntToStr(intCartei), 'OBSERV1', '');
  strAceite  := fGetBancoConfig(0,'CONFIG004-' + IntToStr(intCartei), 'PROACEI', '');
  strDiaProt := fGetBancoConfig(0,'CONFIG004-' + IntToStr(intCartei), 'DIAPROT', '');
  fltPerMul  := fStrToFloat(fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'PERMULT', ''));
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG004-' + IntToStr(intCartei), 'PROXNUM'), 7);

  If ((fEmptyStr(strDiaProt)) or (strDiaProt = '0')) then
      strDiaProt := '99';

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************KP*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);


  //*************************************************//
  // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
  // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
  //**********************************************KP*//
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try
    fStartTransaction;
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM CADEMP ';
    strSQL := strSQL + 'WHERE EMP_CODEMP = :CODEMP ';

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

    strCartei  := 'CONFIG004-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(qryRemessa);

    strSQL := '';
    strSQL := strSQL + 'SELECT B.*, C.CLI_NOMCLI, ';
    strSQL := strSQL + '       R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '       R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '       IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDERE, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), C.CLI_ENDERE), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '       IF(IFNULL(C.CLI_ENDCOB, "") = "", IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM)), "")  AS COMPLEMENTO, ';
    strSQL := strSQL + '       IF(IFNULL(C.CLI_ENDCOB, "") = "", IFNULL(C.CLI_ENDNUM, ""), " ") AS NUMERO, ';
    strSQL := strSQL + '       IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '       IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '       IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                          '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '       IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                          '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM CADCBI B, ';
    strSQL := strSQL + '     CADCLI C, ';
    strSQL := strSQL + '     CADREC R ';
    strSQL := strSQL + 'WHERE CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '      CLI_CODCLI = CBI_CODCLI AND ';
    strSQL := strSQL + '      CTR_NUMDUP = CBI_NUMDUP AND ';
    strSQL := strSQL + '      CTR_PARCEL = CBI_PARCEL AND ';
    strSQL := strSQL + '      CTR_ESPDOC = CBI_ESPDOC AND ';
    strSQL := strSQL + '      CTR_CODEMP = CBI_CODEMP AND ';
    strSQL := strSQL + '      CTR_CODCLI = CBI_CODCLI AND ';
    strSQL := strSQL + '      CTR_DTAREC IS NULL ';

    if (fCfgSis('CONREM', varString) = 'C') THEN
    BEGIN
      IF fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
        strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';
    END;

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      if (fCfgSis('CONREM', varString) = 'C') THEN
      BEGIN
        IF fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'RESPONS', '') = 'E' then
          ParamByName('CARTEI').AsString := strCartei;
      END;

      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      //*************************************************//
      // HEADER DO ARQUIVO                               //
      //**********************************************KP*//
      intCodSeq := 1;
      strHeader := '';

      strHeader := fPadR   ('0'                                      , 001)      + //001 001
                   fPadR   ('1'                                      , 001)      + //002 002
                   fPadR   ('REMESSA'                                , 007)      + //003 009
                   fPadR   ('01'                                     , 002)      + //010 011
                   fPadR   ('COBRANCA'                               , 015)      + //012 026
                   fPadL   (strCodAgen                               , 004, '0') + //027 030
                   fPadR   ('0'                                      , 002, '0') + //031 032
                   fPadL   (strContBco                               , 007, '0') + //033 039
                   fPadR   (strDigCont                               , 001)      + //040 040
                   fPadR   (' '                                      , 006)      + //041 046
                   fPadR   (fTiraCaracEspeciais(UpperCase(strNomEmp)), 030)      + //047 076
                   fPadR   (strCodBco                                , 003, '0') + //077 079
                   fPadR   (fTiraCaracEspeciais(UpperCase(strNomBco)), 015)      + //080 094
                   fPadR   (strDtaRem                                , 006)      + //095 100
                   fPadR   (' '                                      , 003)      + //100 103 FALTA CRIAR CONFIGURAÇÃO
                   fPadR   (' '                                      , 291)      + //104 394
                   fStrZero(IntToStr(intCodSeq)                      , 006);       //395 400


      //*************************************************//
      // ESCREVE O HEADER NO TXT                         //
      //**********************************************KP*//
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG004-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      //*************************************************//
      // TRANSAÇÃO DO ARQUIVO                            //
      //**********************************************KP*//
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

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          {If FieldByName('CBI_DTAVEN').AsDateTime >= FieldByName('CBI_DTACAD').AsDateTime + 7 Then
            strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                         FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime)
          Else
          Begin
            dtaDtaVen := FieldByName('CBI_DTACAD').AsDateTime + 7;

            strDtaVen := FormatDateTime('dd',dtaDtaVen) +
                         FormatDateTime('mm',dtaDtaVen) +
                         FormatDateTime('yy',dtaDtaVen) ;
          End;}

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime) ;

          strDtaIns := FormatDateTime('yyyy',  FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',  FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) ;


          strSeqTit := fStrZero(fAtuCodSeq('CONFIG004', 'PROXNUM'), 7);

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
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03) ;

          //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
          AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

          strSeuNum := FieldByName('CBI_NUMDUP').AsString +
                       FieldByName('CBI_PARCEL').AsString;             

          strNosNum := FieldByName('CBI_NOSNUM').AsString;

          If strRespon = 'B' Then
            strNosNum := '00000000000';

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          fltValMor := ((FieldByName('CBI_VALDUP').AsFloat) * (FieldByName('CBI_PORCEN').AsFloat / 100));
          fltValDup := (FieldByName('CBI_VALDUP').AsFloat);

          strNomCliente := FieldByName('CLI_NOMCLI').AsString;
          strNomCliente := AnsiReplaceStr(strNomCliente, chr(10), '');

          If strRespon = 'E' Then
          Begin
            strTransacao := fPadR      ('1'                                                               , 01)      + //001 001
                            fPadR      (' '                                                               , 16)      + //002 017
                            fPadL      (strCodAgen                                                        , 04, '0') + //018 021
                            fPadR      ('0'                                                               , 02, '0') + //022 023
                            fPadL      (strContBco                                                        , 07, '0') + //024 030
                            fPadR      (strDigCont                                                        , 01, '0') + //031 031
                            fValNumForm(fltPerMul                                                         , 02,  0 ) + //032 033
                            fPadR      (' '                                                               , 04)      + //034 037
                            fPadR      (strKeyDup                                                         , 25)      + //038 062
                            fPadL      (strNosNum                                                         , 08, '0') + //063 070
                            fPadL      (strNumContr                                                       , 10, '0') + //071 080
                            fPadR      ('0'                                                               , 06, '0') + //081 086
                            fPadR      ('0'                                                               , 13, '0') + //087 099
                            fPadR      (' '                                                               , 08)      + //100 107
                            fPadR      (strCodCar                                                         , 01, '0') + //108 108
                            fPadR      ('01'                                                              , 02)      + //109 110
                            fPadL      (strSeuNum                                                         , 10, '0') + //111 120
                            fPadR      (strDtaVen                                                         , 06, '0') + //121 126
                            fValNumForm(fltValDup                                                         , 13)      + //127 139
                            fPadR      ('0'                                                               , 03, '0') + //140 142
                            fPadR      ('0'                                                               , 04, '0') + //143 146
                            fPadR      (' '                                                               , 01)      + //147 147
                            fPadR      ('01'                                                              , 02)      + //148 149
                            fPadR      (strAceite                                                         , 01)      + //150 150
                            fPadR      (strDtaEmi                                                         , 06, '0') + //151 156
                            fPadR      (strInstru1                                                        , 04, '0') + //157 160
                            fValNumForm(fltValMor                                                         , 13     ) + //161 173
                            fPadR      ('0'                                                               , 06, '0') + //174 179
                            fPadR      ('0'                                                               , 13, '0') + //180 192
                            fPadR      ('0'                                                               , 13, '0') + //293 205
                            fPadR      ('0'                                                               , 13, '0') + //206 218
                            fPadL      (strCpfCgc                                                         , 02, '0') + //219 220
                            fPadL      (strCgcCli                                                         , 14, '0') + //221 234
                            fPadR      (fTiraCaracEspeciais(UpperCase(strNomCliente)), 40)      + //235 274
                            fPadR      (fTiraCaracEspeciais(UpperCase(AstrEndereco))                      , 40)      + //275 314
                            fPadR      (fTiraCaracEspeciais(UpperCase(FieldByName('BAIRRO').AsString))    , 12)      + //315 326
                            fPadR      (UpperCase(FieldByName('C_E_P_').AsString)                         , 08, '0') + //327 334
                            fPadR      (fTiraCaracEspeciais(UpperCase(FieldByName('CIDADE').AsString))    , 15)      + //335 349
                            fPadR      (FieldByName('ESTADO').AsString                                    , 02)      + //350 351
                            fPadR      (strObser1                                                         , 40)      + //352 391
                            fPadL      (strDiaProt                                                        , 02,  '0')+ //392 393
                            fPadR      ('0'                                                               , 01)      + //394 394
                            fStrZero   (IntToStr(intCodSeq)                                               , 06);       //395 400
          End
          Else
            strTransacao := fPadR      ('1'                                                               , 01)      + //001 001
                            fPadR      (' '                                                               , 16)      + //002 017
                            fPadL      (strCodAgen                                                        , 04, '0') + //018 021
                            fPadR      ('0'                                                               , 02, '0') + //022 023
                            fPadL      (strContBco                                                        , 07, '0') + //024 030
                            fPadR      (strDigCont                                                        , 01, '0') + //031 031
                            fPadR      (strTaxComPer                                                      , 02, '0') + //032 033
                            fPadR      (' '                                                               , 04)      + //034 037
                            fPadR      (strKeyDup                                                         , 25)      + //038 062
                            fPadL      ('0'                                                               , 07, '0') + //063 069
                            fPadL      ('0'                                                               , 01, '0') + //070 070
                            fPadL      (strNumContr                                                       , 10, '0') + //071 080
                            fPadR      ('0'                                                               , 06, '0') + //081 086
                            fPadR      ('0'                                                               , 13, '0') + //087 099
                            fPadR      (' '                                                               , 08)      + //100 107
                            fPadR      (strCodCar                                                         , 01, '0') + //108 108
                            fPadR      ('01'                                                              , 02)      + //109 110
                            fPadL      (strSeuNum                                                         , 10, '0') + //111 120
                            fPadR      (strDtaVen                                                         , 06, '0') + //121 126
                            fValNumForm(fltValDup                                                         , 13)      + //127 139
                            fPadR      ('0'                                                               , 03, '0') + //140 142
                            fPadR      ('0'                                                               , 04, '0') + //143 146
                            fPadR      (' '                                                               , 01)      + //147 147
                            fPadR      ('01'                                                              , 02)      + //148 149
                            fPadR      (strAceite                                                         , 01)      + //150 150
                            fPadR      (strDtaEmi                                                         , 06, '0') + //151 156
                            fPadR      (strInstru1                                                        , 04, '0') + //157 160
                            fValNumForm(fltValMor                                                         , 13)      + //161 173
                            fPadR      ('0'                                                               , 06, '0') + //174 179
                            fPadR      ('0'                                                               , 13, '0') + //180 192
                            fPadR      ('0'                                                               , 13, '0') + //293 205
                            fPadR      ('0'                                                               , 13, '0') + //206 218
                            fPadL      (strCpfCgc                                                         , 02, '0') + //219 220
                            fPadL      (strCgcCli                                                         , 14, '0') + //221 234
                            fPadR      (fTiraCaracEspeciais(UpperCase(FieldByName('CLI_NOMCLI').AsString)), 40)      + //235 274
                            fPadR      (fTiraCaracEspeciais(UpperCase(AstrEndereco))                      , 40)      + //275 314
                            fPadR      (fTiraCaracEspeciais(UpperCase(FieldByName('BAIRRO').AsString))    , 12)      + //315 326
                            fPadR      (FieldByName('C_E_P_').AsString                                    , 08, '0') + //327 334
                            fPadR      (fTiraCaracEspeciais(UpperCase(FieldByName('CIDADE').AsString))    , 15)      + //335 349
                            fPadR      (FieldByName('ESTADO').AsString                                    , 02)      + //350 351
                            fPadR      (fTiraCaracEspeciais(UpperCase(strObser1))                         , 40)      + //352 391
                            fPadL      (strDiaProt                                                        , 02, '0') + //392 393
                            fPadR      ('0'                                                               , 01)      + //394 394
                            fStrZero   (IntToStr(intCodSeq)                                               , 06);       //395 400

          //*************************************************//
          // ESCREVE A TRANSACAO NO TXT                      //
          //**********************************************KP*//
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
        End;

      End;

      //*************************************************//
      // TRAILLER                                        //
      //**********************************************KP*//
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                + //001 001
                     fPadR   (' '                , 393) + //002 394
                     fStrZero(IntToStr(intCodSeq), 006);  //395 400


      //*************************************************//
      // ESCREVE O TRAILLER NO TXT                       //
      //**********************************************KP*//
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      pDeletaCadCbi;

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

procedure TfrmExpArqRemNordeste400.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemNordeste400.edtCodPorKeyPress(Sender: TObject;
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
        Self.SelectNext((Sender As TWinControl), True, True);
    End;
  End;
end;

function TfrmExpArqRemNordeste400.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniquery;

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

function TfrmExpArqRemNordeste400.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemNordeste400.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemNordeste400.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
