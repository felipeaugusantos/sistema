unit untExpArqRemCxFed400p;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Menus, Buttons,
  ExtCtrls, StrUtils, Uni, AppEvnts, Math, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa;

type
  TfrmExpArqRemCxFed400p = class(TfrmPai)
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
    fraCheckComboBoxEmpresa: TfraCheckComboBoxEmpresa;
    procedure FormShow(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;  

    function fRetEmpresa: String;
    { Private declarations }
  public
    intCartei: Integer;
    strNomForm : String;
    
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemCxFed400p: TfrmExpArqRemCxFed400p;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutban, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

procedure TfrmExpArqRemCxFed400p.FormShow(Sender: TObject);
begin
  inherited;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'PATHREM', ''));
  edtNomArquivo.Text  := 'ARQ01.TXT';
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemCxFed400p.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var 
    ArrSel: TConsultasArray;
begin
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

procedure TfrmExpArqRemCxFed400p.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemCxFed400p.btnGerarClick(Sender: TObject);
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
    strDtaJur  : String;
    strKeyDup  : String;
    strCgcEmp  : String;
    strCgcCli  : String;
    strDConCor : String;
    strContCor : String;
    strCodAgen : String;
    strDigAgen : String;
    strCodConv : String;
    strDigVeri : String;
    strCpfCgc  : String;
//    strCodPro  : String;
    strDiaPro  : String;
    strNosNum  : String;
    strTaxComPer: String;
    strAgeCob  : String;
    strInstru1 : String;
    strCep     : String;
    strCodOperacao: String;
    strIdentEmpBco: String;
    strRespons : String;

    strHeader   : String;
    strTransacao: String;
    strTrailer  : String;

    intCodCar  : Integer;
    intCodSeq  : Integer;
//    intSeqUen  : Integer;
//    intEmiBol  : Integer;
    txtTexto   : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa : TUniQuery;
    strJurosDia: String;
    fltMorDia  : Double;

    intDiasMul: Integer;
    fltPerMul:  Double;

    strDtaMul,
    strValMul: String;

    strFilePath : String;
    fltValDpo   : Double;
    strDtaDpo   : String;
    dtaDtaDpo   : TDateTime;
    blnUsaCnd   : Boolean;
    blnUsaDesPonCli: Boolean;
    blnUsaDesPon   : Boolean;
    strCartei: String;
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

  If fMensagem('','Confirma Geração do Arquivo de Remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  If fEmptyStr(fTiraCaracEspeciais(fraPathRemessa.edtDirectory.text)) Then
  Begin
    fMensagem('Path:', 'Diretório p\ exportação deve ser informado!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  intCodSeq := 1;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco := '104';
  strNomBco := 'CAIXA ECONOMICA FEDERAL';
  strNomEmp := fRetNomeEmpresa(VS_strCodEmp);

  strCodAgen :=          fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen :=          fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'DIGAGEN', '');
  strContCor :=          fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDConCor :=          fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodConv :=          fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'CODCONV', '');
  strDigVeri :=          fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'DIGVERI', '');
  strDiaPro  := fStrZero(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'DIAPROT', ''), 02);
  strCodOperacao :=      fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'OPERACA', '');
  strTaxComPer   :=      fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'TAXCOMP', '');
  strRespons     :=      fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'RESPONS', '');

  intCodCar := StrToInt(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'NUMCART', ''));

  intDiasMul := StrToIntDef(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'DIAMULT', ''), 0);
  fltPerMul  := fStrToFloat(fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'PERMULT', ''));

  strAgeCob := strCodAgen + strDigVeri;
  strIdentEmpBco := strCodAgen + strCodOperacao + strContCor + strDConCor;

  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  strHorRem  := FormatDateTime('hh',fTime()) + FormatDateTime('mm',fTime()) + FormatDateTime('ss',fTime());
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG104p400', 'RELOCAL', '') = 'N' );

  strJurosDia := fGetBancoConfig(0, 'CONFIG104p400', 'JUROSDI', '');
  strJurosDia := IIF(fEmptyStr(strJurosDia), '0', strJurosDia); //Divide por 30 abaixo

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

{  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try}
    strCartei := 'CONFIG104p400-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
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

    If blnUsaDesPon Then
    Begin
      strSQL := strSQL + '  D.CND_PERDPO, ';
      strSQL := strSQL + '  D.CND_QTDDAV, ';
    End;

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

    If blnUsaDesPon Then
      strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL ';

    If fraCheckComboBoxEmpresa.chkcbEmpresa.Text <> 'Todas'Then
    Begin
      strchkcbEmp := fraCheckComboBoxEmpresa.chkcbEmpresa.Text;
      strSQL := strSQL + ' AND CBI_EMPGER IN (' + fRetStrToSQLIn(strchkcbEmp,';') + ') ';
    End;


    if (fCfgSis('CONREM', varString) = 'C') THEN
      strSQL := strSQL + '  AND CTR_CARTEI = :CARTEI ';

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
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG104p400', 'PROXNUM'), 5);

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {***************************************************}
      {* HEADER DO ARQUIVO / REGISTRO DO TIPO 0          *}
      {************************************************LB*}
      strHeader := '';
      strHeader := fPadR   ('0'                , 001)      + //001 a 001
                   fPadR   ('1'                , 001)      + //002 a 002
                   fPadR   ('REMESSA'          , 007)      + //003 a 009
                   fPadR   ('01'               , 002)      + //010 a 011
                   fPadR   ('COBRANCA'         , 015)      + //012 a 026
                   fPadR   (strIdentEmpBco     , 016)      + //027 a 042
                   fPadR   (' '                , 004)      + //043 a 046
                   fPadR   (strNomEmp          , 030)      + //047 a 076
                   fPadR   ('104'              , 003)      + //077 a 079
                   fPadR   ('C ECON FEDERAL'   , 015)      + //080 a 094
                   fPadR   (strDtaRem          , 006)      + //095 a 100
                   fPadR   (' '                , 289)      + //101 a 389
                   fStrZero(strCodRem          , 005)      + //390 a 394
                   fStrZero(IntToStr(intCodSeq), 006);       //395 a 400

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************LB*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG104_400p-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      With qryRemessa Do
      Begin

        While Not Eof Do
        Begin
          Inc(intCodSeq);

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yy',FieldByName('CBI_DTACAD').AsDateTime);

          strDtaJur := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime + 1) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime + 1) +
                       FormatDateTime('yy',FieldByName('CBI_DTAVEN').AsDateTime);

          If (intDiasMul > 0) And (fltPerMul > 0) And
             ((FieldByName('CBI_DTAVEN').AsDateTime + intDiasMul) >= VS_Date) Then
          Begin
            strDtaMul := FormatDateTime('ddmmyy',FieldByName('CBI_DTAVEN').AsDateTime + intDiasMul);
            strValMul := fValNumForm( RoundTo(FieldByName('CBI_VALDUP').AsFloat * fltPerMul / 100, -2) , 010);
          End Else
          Begin
            strDtaMul := fStrZero('0', 006);
            strValMul := fStrZero('0', 010);
          End;

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

          strCep :=  AnsiReplaceStr( FieldByName('C_E_P_').AsString,'-','');

          strInstru1 := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'INSTRU1', '');

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '02'
          Else
            strCpfCgc := '01';

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

          {*************************************}
          { PEGA NOSSO NUMERO NO BANCO DE DADOS }
          {**********************************JB*}
          strNosNum := FieldByName('CBI_NOSNUM').AsString;

          If strRespons = 'B' Then
            strNosNum := '00000000000';

          {***********************************}
          { CALCULA A MORA DIARIA             }
          {********************************JB*}
          fltMorDia := ((FieldByName('CBI_VALDUP').AsFloat) * (fStrToFloat(strJurosDia) / 100) / 30);

          If blnUsaDesPonCli And blnUsaDesPon Then
          begin
            fltValDpo := ( ( FieldByName('CBI_VALDUP').AsFloat ) * ( FieldByName('CLI_PERDPO').AsFloat / 100 ) );

            If fltValDpo > 0 Then
            Begin
              dtaDtaDpo := FieldByName('CBI_DTAVEN').AsDateTime - FieldByName('CLI_QTDDAV').AsInteger;
              strDtaDpo := FormatDateTime('ddmmyyyy', dtaDtaDpo);
            End
            Else
              strDtaDpo := '00000000';
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
              strDtaDpo := '000000';
          End
          Else
          Begin
            fltValDpo := 0;
            strDtaDpo := '000000';
          End;

          strTransacao := '';
          strTransacao := fStrZero   ('1'                               , 001)     + //001 a 001
                          fStrZero   ('02'                              , 002)     + //002 a 003
                          fStrZero   (strCgcEmp                         , 014)     + //004 a 017
                          fStrZero   (strIdentEmpBco                    , 016)     + //018 a 033
                          fPadR      (' '                               , 002)     + //034 a 035
                          fPadR      (strTaxComPer                      , 002)     + //036 a 037
                          fPadR      (strKeyDup                         , 025)     + //038 a 062
                          fStrZero   (strNosNum                         , 011)     + //063 a 073
                          fPadR      (' '                               , 003)     + //074 a 076
                          fPadR      (' '                               , 030)     + //077 a 106
                          fStrZero   (IntToStr(intCodCar)               , 002)     + //107 a 108
                          fStrZero   ('01'                              , 002)     + //109 a 110
                          fPadL      (RightStr(FieldByName('CBI_NUMDUP').AsString +
                                               FieldByName('CBI_PARCEL').AsString, 10), 010,'0') + //111 a 120
                          fPadR      (strDtaVen                         , 006)     + //121 a 126
                          fValNumForm(fltValDup                         , 013)     + //127 a 139
                          fPadR      ('104'                             , 003)     + //140 a 142
                          fPadR      ('00000'                           , 005)     + //143 a 147
                          fPadR      ('01'                              , 002)     + //148 a 149
                          fPadR      ('N'                               , 001)     + //150 a 150
                          fPadR      (strDtaEmi                         , 006)     + //151 a 156
                          fPadR      (strInstru1                        , 002)     + //157 a 158
                          fPadR      ('00'                              , 002)     + //159 a 160
                          fValNumForm(fltMorDia                         , 013)     + //161 a 173
                          fPadR      (strDtaDpo                         , 006)     + //174 a 179
                          fValNumForm(fltValDpo                         , 013)     + //180 a 192
                          fStrZero   ('0'                               , 013)     + //192 a 205
                          fStrZero   ('0'                               , 013)     + //206 a 218
                          fPadR      (strCpfCgc                         , 002)     + //219 a 220
                          fPadL      (strCgcCli                         , 014,'0') + //221 a 234
                          fPadR      (FieldByName('CLI_NOMCLI').AsString, 040)     + //235 a 274
                          fPadR      (AstrEndereco                      , 040)     + //275 a 314
                          fPadR      (FieldByName('BAIRRO').AsString    , 012)     + //315 a 326
                          fPadR      (strCep                            , 008)     + //327 a 334
                          fPadR      (FieldByName('CIDADE').AsString    , 015)     + //335 a 349
                          fPadR      (FieldByName('ESTADO').AsString    , 002)     + //350 a 351
                          fPadR      (strDtaMul                         , 006)     + //352 a 357
                          fPadR      (strValMul                         , 010)     + //358 a 367
                          fPadR      (''                                , 022)     + //368 a 389
                          fPadR      ('00'                              , 002)     + //390 a 391
                          fStrZero   (strDiaPro                         , 002)     + //392 a 393
                          fPadR      ('1'                               , 001)     + //394 a 394
                          fStrZero   (IntToStr(intCodSeq)               , 006);      //395 a 400

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************LB*}
          Writeln(txtTexto,strTransacao);

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
          pGravaRemDet(strAutoIncremRem,
                       FieldByName('AUTOINCREM').AsString,
                       strNosNum,
                       fStrToFloat(strValMul),
                       FieldByName('CBI_VALDUP').AsFloat,
                       FieldByName('CTR_DTAREC').AsDateTime,
                       FieldByName('CBI_DTAVEN').AsDateTime,
                       VS_Date,
                       strLoginUsuarioLogado,
                       '');

          If fCfgSis('UTICRM', varBoolean) And (Not fEmptyStr(fCfgSis('OCOFIN', varString))) Then
          Begin
            TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(FieldByName('CBI_NUMDUP').AsString,
                                                     FieldByName('CBI_ESPDOC').AsString,
                                                     FieldByName('CBI_CODEMP').AsString,
                                                     FieldByName('CBI_CODCLI').AsString,
                                                     FieldByName('CBI_PARCEL').AsString,
                                                     strLoginUsuarioLogado,
                                                     fRetCgcCpf(FieldByName('CBI_CODCLI').AsString),
                                                     afcEnviaDuplicataBanco);
          End;

          Next;
        End;

      End;

      {************}
      {* TRAILLER *}
      {*********LB*}
      Inc(intCodSeq);
      strTrailer :=  '';
      strTrailer :=  '9'                                 + //001 a 001
                     fPadR   (' '                 , 393) + //002 a 394
                     fStrZero(IntToStr(intCodSeq) , 006);  //395 a 400

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************LB*}
      Writeln(txtTexto,strTrailer);

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


function TfrmExpArqRemCxFed400p.fRetEmpresa: String;
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
end;

function TfrmExpArqRemCxFed400p.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemCxFed400p.FormCreate(Sender: TObject);
begin
  inherited;
     qryCadPor := fCriaQuery(Self);
end;

end.
