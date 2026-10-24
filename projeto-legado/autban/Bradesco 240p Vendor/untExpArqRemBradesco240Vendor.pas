unit untExpArqRemBradesco240Vendor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass, DateUtils,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa;

type
  TfrmExpArqRemBradesco240Vendor = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRem: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    Label1: TLabel;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    fraCheckComboBoxEmpresa: TfraCheckComboBoxEmpresa;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

///    function fRetEmpresa: String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemBradesco240Vendor: TfrmExpArqRemBradesco240Vendor;

implementation

uses untFuncoes, untfuncoesSimples, DB, untFuncAutBan, untTypesSistema, untConsultas,
     untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemBradesco240Vendor.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'PATHREM', ''));
  edtNomArquivo.Text  := 'ARQ' + FormatDateTime('dd', Date) + FormatDateTime('mm', Date) + '.TXT';

  fraCheckComboBoxEmpresa.chkcbEmpresaFocusChanged(fraCheckComboBoxEmpresa.chkcbEmpresa);
  fraCheckComboBoxEmpresa.SelecionaEmpresaLogada(fGetBancoConfig(0,'CONFIG237_VENDOR', 'RELOCAL', '') = 'S');

  pSetFocus(edtCodPor);

end;

function TfrmExpArqRemBradesco240Vendor.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemBradesco240Vendor.btnGerarClick(Sender: TObject);
  Var
    strSQL     : String;
    strCodBco  : String;
    strNomBco  : String;
    strNomEmp  : String;
    strDtaRem  : String;
    strHorRem  : String;
    strCodRem  : String;
    strDtaVen  : String;
    strDtaEmi  : String;
    strKeyDup  : String;
    strNumDup  : String;
    strCgcEmp  : String;
    strCgcCli  : String;
    strDConCor : String;
    strContCor : String;
    strCodAgen : String;
    strDigAgen : String;
    strCodConv : String;
    strDigVeri : String;
    strCpfCgc  : String;
    strDiaPro  : String;

    strProAce  : String;
    strBaiDev  : String;

    strHeader  : String;
    strHeaLot  : String;
    strSegK    : String;
    strSegL    : String;
    strTraLot  : String;
    strTraArq  : String;
    strValMul  : String;
    strSeqRem,
    strCodOpe,
    strFormPag,
    strFormIOF,
    strPerVenc,
    strCodProt,
    strCodCnae,
    strPrazoTrans,
    strCodMul,
    strPriVen: String;

    intSeqLot  : Integer;
    intSeqUen  : Integer;
    intQtdPar  : Integer;
    txtTexto   : TextFile;
    strNovCodEmp: String;
    qryRemessa : TUniQuery;
    intQtdReg  : Integer;
    dtaPriVen  : TDateTime;
    fltValMul  : Double;
    fltJurCom,
    fltJurVen  : Double;
    strFilePath : String;
    strAutoIncremRem: String;

    fltValDup : Double;
    strchkcbEmp : String;
    AstrEndereco: String;
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

  strCodBco  := '237';
  strNomBco  := 'BRADESCO';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);

  strCodAgen := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'DIGAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDConCor := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodConv := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'CODCONV', '');
  fltJurCom  := strToFloat(fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'TAXACOM', '0'));
  fltJurVen  := strToFloat(fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'TAXAVEN', '0'));
  strCodOpe  := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'CODOPER', '');
  strPerVenc := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'PERVENC', '');
  strFormPag := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'FORMPAG', '');
  strFormIOF := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'FORMIOF', '');
  strCodProt := Copy(fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'CODPROT', ''), 1, 1);
  strDiaPro := Copy(fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'DIAPROT', ''), 1, 1);
  fltValMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'VALMULT', '') );
  strPrazoTrans     := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'PRAZTRA', '');

  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorRem  := FormatDateTime('hh',fTime()) + FormatDateTime('mm',fTime()) + FormatDateTime('ss',fTime());

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************KP*//
  strNovCodEmp := VS_strCodEmp;

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

    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
    strSQL := strSQL + '  R.CTR_JURSUJ AS CTR_JURSUJ, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, IFNULL(C.CLI_CODCNA, "")  AS CLI_CODCNA, ';
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
    strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = B.CBI_CODCLI ';
    strSQL := strSQL + '  JOIN CADREC R ON R.CTR_NUMDUP = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                   R.CTR_PARCEL = B.CBI_PARCEL AND ';
    strSQL := strSQL + '                   R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                   R.CTR_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                   R.CTR_CODCLI = B.CBI_CODCLI AND ';
    strSQL := strSQL + '                   R.CTR_DTAREC IS NULL ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO ';

    If fraCheckComboBoxEmpresa.chkcbEmpresa.Text <> 'Todas'Then
    Begin
      strchkcbEmp := fraCheckComboBoxEmpresa.chkcbEmpresa.Text;
      strSQL := strSQL + ' AND CBI_EMPGER IN (' + fRetStrToSQLIn(strchkcbEmp,';') + ') ';
    End;

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

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG237_VENDOR-' + IntToStr(intCartei), 'PROXNUM'), 8);

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      strCgcEmp := Trim(strCgcEmp);
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

      (**********************************
       * GERANDO HEADER DO ARQUIVO      *
       *******************************KP*)

      strHeader := '';
      strHeader := fPadR   (strCodBco              , 003) + //001 a 003
                   fStrZero('0000'                 , 004) + //004 a 007
                   fPadR   ('0'                    , 001) + //008 a 008
                   fPadR   (' '                    , 009) + //009 a 017
                   fPadR   ('2'                    , 001) + //018 a 018
                   fStrZero(strCgcEmp              , 014) + //019 a 032
                   fPadR   (strCodConv             , 020) + //033 a 052
                   fStrZero(strCodAgen             , 005) + //053 a 057
                   fPadR   (strDigAgen             , 001) + //058 a 058
                   fPadR   (strContCor             , 012) + //059 a 070
                   fPadR   (strDConCor             , 001) + //071 a 071
                   fPadR   (strDConCor             , 001) + //072 a 072
                   fPadR   (strNomEmp              , 030) + //073 a 102
                   fPadR   (strNomBco              , 030) + //103 a 132
                   fPadR   (' '                    , 010) + //133 a 142
                   fPadR   ('1'                    , 001) + //143 a 143
                   fPadR   (strDtaRem              , 008) + //144 a 151
                   fPadR   (strHorRem              , 006) + //152 a 157
                   fPadR   (RightStr(strCodRem, 6) , 006) + //158 a 163
                   fPadR   ('060'                  , 003) + //164 a 166
                   fStrZero('0'                    , 005) + //167 a 171
                   fPadR   (' '                    , 020) + //172 a 191
                   fPadR   (' '                    , 020) + //192 a 211
                   fPadR   (' '                    , 029);  //212 a 240

      Writeln(txtTexto, strHeader);

      (**********************************
       * GERANDO HEADER DO LOTE         *
       *******************************KP*)

      strHeaLot := fPadR   (strCodBco              , 003) + //001 a 003
                   fPadR   ('0001'                 , 004) + //004 a 007
                   fPadR   ('1'                    , 001) + //008 a 008
                   fPadR   ('R'                    , 001) + //009 a 009
                   fPadR   ('40'                   , 002) + //010 a 011
                   fPadR   ('  '                   , 002) + //012 a 013
                   fPadR   ('010'                  , 003) + //014 a 016
                   fPadR   (' '                    , 001) + //017 a 017
                   fPadR   ('2'                    , 001) + //018 a 018
                   fStrZero(strCgcEmp              , 014) + //019 a 032
                   fPadR   (strCodConv             , 020) + //033 a 052
                   fStrZero(strCodAgen             , 005) + //053 a 057
                   fPadR   (strDigAgen             , 001) + //058 a 058
                   fPadR   (strContCor             , 012) + //059 a 070
                   fPadR   (strDConCor             , 001) + //071 a 071
                   fPadR   (strDConCor             , 001) + //072 a 072
                   fPadR   (strNomEmp              , 030) + //073 a 102
                   fPadR   (strCodRem              , 008) + //103 a 110
                   fPadR   (strDtaRem              , 008) + //111 a 118
                   fPadR   (' '                    , 122);  //119 a 240

      Writeln(txtTexto, strHeaLot);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG237_VENDOR-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      With qryRemessa Do
      Begin
        intSeqLot := 1;
        intSeqUen := 1;

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          dtaPriVen := IncDay(FieldByName('CBI_DTACAD').AsDateTime, StrToInt(strPerVenc));

          strPriVen := FormatDateTime('dd',  dtaPriVen) +
                       FormatDateTime('mm',  dtaPriVen) +
                       FormatDateTime('yyyy',dtaPriVen);

          strDtaVen := FormatDateTime('dd',  FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',  FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',  FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',  FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTACAD').AsDateTime);


          intQtdPar := MonthsBetween(StartOfTheMonth(dtaPriVen), EndOfTheMonth(FieldByName('CBI_DTAVEN').AsDateTime));

          if intQtdPar = 0 then
             intQtdPar := 1;

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

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          If strCpfCgc = '2' Then
            strCgcEmp := fStrZero(strCgcEmp,15)
          Else
            strCgcEmp := Copy(strCgcEmp, 4, 9) + '0000' + RightStr(strCgcEmp, 2);

          if FieldByName('CLI_CODCNA').AsString <> '' then
            strCodCnae := '0'+Copy(FieldByName('CLI_CODCNA').AsString, 1, 5)
          else
            strCodCnae := '000000';

        (**********************************
         * GERANDO REGISTRO K             *
         *******************************KP*)

          strSegK := fPadR      (strCodBco                                , 03)     + //001 a 003
                     fStrZero   ('1'                                      , 04)     + //004 a 007
                     fPadR      ('3'                                      , 01)     + //008 a 008
                     fStrZero   (IntToStr(intSeqUen)                      , 05)     + //009 a 013
                     fPadR      ('K'                                      , 01)     + //014 a 014
                     fPadR      ('01'                                     , 02)     + //015 a 016
                     fPadR      ('000'                                    , 03)     + //017 a 019
                     fStrZero   (strCpfCgc                                , 01)     + //020 a 020
                     fStrZero   (strCgcCli                                , 14)     + //021 a 034
                     fPadR      (FieldByName('CLI_NOMCLI').AsString       , 40)     + //035 a 074
                     fPadR      (AstrEndereco                             , 40)     + //075 a 114
                     fPadR      (FieldByName('BAIRRO').AsString           , 15)     + //115 a 129
                     fPadR      (Copy(FieldByName('C_E_P_').AsString,1,5) , 05)     + //130 a 134
                     fPadR      (Copy(FieldByName('C_E_P_').AsString,6,3) , 03)     + //135 a 137
                     fPadR      (FieldByName('CIDADE').AsString           , 15)     + //138 a 152
                     fPadR      (FieldByName('ESTADO').AsString           , 02)     + //153 a 154
                     fPadR      ('000'                                    , 03)     + //155 a 157
                     fPadR      ('00000'                                  , 05)     + //158 a 162
                     fPadR      (' '                                      , 01)     + //163 a 163
                     fPadR      ('000000000000'                           , 12)     + //164 a 175
                     fPadR      (' '                                      , 01)     + //176 a 176
                     fPadR      (' '                                      , 01)     + //177 a 177
                     fPadR      ('0'                                      , 20,'0') + //178 a 197
                     fPadR      (strCodCnae                               , 06)     + //198 a 203
                     fPadR      (strCodOpe                                , 05,'0') + //204 a 208
                     fPadR      (' '                                      , 05,' ') + //209 a 213
                     fPadR      (strKeyDup                                , 27);      //214 a 240

          Writeln(txtTexto, strSegK);

          Inc(intSeqUen);
          Inc(intSeqLot);

        (**********************************
         * GERANDO REGISTRO L             *
         *******************************KP*)
          if fltValMul > 0 then
            strCodMul := '1'
          else
            strCodMul := '0';

          strSegL := fPadR   (strCodBco                                   , 03)     + //001 a 003
                     fStrZero('1'                                         , 04)     + //004 a 007
                     fPadR   ('3'                                         , 01)     + //008 a 008
                     fStrZero(IntToStr(intSeqUen)                         , 05)     + //009 a 013
                     fPadR   ('L'                                         , 01)     + //014 a 014
                     fPadR   (' '                                         , 01)     + //015 a 015
                     fPadR   ('01'                                        , 02)     + //016 a 017
                     fPadR   (strNumDup                                   , 15)     + //018 a 032
                     fPadR   ('0'                                         , 10,'0') + //033 a 042
                     fPadR   (strDtaEmi                                   , 08)     + //043 a 050
                     fPadR   (strDtaEmi                                   , 08)     + //051 a 058
                     fValNumForm(fltValDup                                , 15)     + //059 a 073
                     fValNumForm(fltJurVen                                , 08)     + //074 a 081
                     fValNumForm(fltJurCom                                , 08)     + //082 a 089
                     fPadR   ('09'                                        , 02)     + //090 a 091
                     fPadR   ('09'                                        , 02)     + //092 a 093
                     fPadR   (strPriVen                                   , 08)     + //094 a 101
                     fPadR   (strDtaVen                                   , 08)     + //102 a 109
                     fStrZero('4'                                         , 01)     + //110 a 110
                     fStrZero(strPerVenc                                  , 02)     + //111 a 112
                     fStrZero(IntToStr(intQtdPar)                         , 02)     + //113 a 114
                     fPadR   (strFormPag                                  , 01)     + //115 a 115
                     fPadR   ('0'                                         , 01)     + //116 a 116
                     fPadR   ('0'                                         , 01)     + //117 a 117
                     fPadR   ('00000000'                                  , 08)     + //118 a 125
                     fPadR   ('00000000'                                  , 08)     + //126 a 133
                     fPadR   ('00'                                        , 02)     + //134 a 135
                     fStrZero(strCodMul                                   , 01)     + //136 a 136
                     fPadR   ('00000000'                                  , 08)     + //137 a 144
                     fValNumForm(fltValMul                                , 15)     + //145 a 159
                     fStrZero('0'                                         , 01)     + //160 a 160
                     fPadR   ('00000000'                                  , 08)     + //161 a 168
                     fPadR   ('0'                                         , 15,'0') + //169 a 183
                     fPadR   ('00000000'                                  , 08)     + //184 a 191
                     fPadR   ('0'                                         , 08,'0') + //192 a 199
                     fPadR   ('0'                                         , 08,'0') + //200 a 207
                     fPadR   (strFormIOF                                  , 01)     + //208 a 208
                     fStrZero(strPrazoTrans                               , 02)     + //209 a 210
                     fPadR   (strCodProt                                  , 01)     + //211 a 211
                     fStrZero(strDiaPro                                   , 02)     + //212 a 213
                     fValNumForm(0                                        , 15)     + //214 a 228
                     fPadR   ('1'                                         , 01)     + //229 a 229
                     fStrZero('00'                                        , 02)     + //230 a 231
                     fPadR   ('         '                                 , 09);      //232 a 240

          Writeln(txtTexto, strSegL);

          Inc(intSeqUen);
          Inc(intSeqLot);

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

    (**************************************
     * GERANDO REGISTRO TRAILLER DO LOTE  *
     ***********************************KP*)

      strTraLot := fPadR   (strCodBco              , 003) + //001 a 003
                   fStrZero('1'                    , 004) + //004 a 007
                   fPadR   ('5'                    , 001) + //008 a 008
                   fPadR   (' '                    , 001) + //009 a 009
                   fStrZero(IntToStr(intSeqLot + 1), 006) + //010 a 015
                   fPadR   (' '                    , 225);  //016 a 240

      Writeln(txtTexto,strTraLot);

    (****************************************
     * GERANDO REGISTRO TRAILLER DO ARQUIVO *
     *************************************KP*)

      strTraArq := '';
      strTraArq := fPadR   (strCodBco              , 003) + //001 a 003
                   fPadR   ('9999'                 , 004) + //004 a 007
                   fPadR   ('9'                    , 001) + //008 a 008
                   fPadR   (' '                    , 009) + //009 a 017
                   fStrZero('1'                    , 006) + //018 a 023
                   fStrZero(IntToStr(intSeqUen + 3), 006) + //024 a 029
                   fPadR   ('0'                    , 006, '0') + //030 a 035
                   fPadR   (' '                    , 205);  //036 a 240

      Writeln(txtTexto,strTraArq);

    (******************************************************
     * ENCERRANDO A GERAÇÃO E SALVANDO O ARQUIVO REMESSA  *
     ***************************************************KP*)

      CloseFile(txtTexto);

      pDeletaCadCbi(strCodBco, '', edtCodPor.Text);

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

procedure TfrmExpArqRemBradesco240Vendor.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBradesco240Vendor.edtCodPorKeyPress(Sender: TObject;  var Key: Char);
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

{function TfrmExpArqRemBradesco240Vendor.fRetEmpresa: String;
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

  FreeAndNil(qryCadEmp);
end;}

procedure TfrmExpArqRemBradesco240Vendor.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemBradesco240Vendor.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.

