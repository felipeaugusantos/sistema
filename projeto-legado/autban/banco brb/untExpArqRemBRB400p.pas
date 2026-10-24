unit untExpArqRemBRB400p;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Menus, Buttons,
  ExtCtrls, StrUtils, Uni, AppEvnts, Math, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBRB400p = class(TfrmPai)
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
    strCodRem: String;
    
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemBRB400p: TfrmExpArqRemBRB400p;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, Data.DB, untConsultas, untTypesSistema,
     untConstantes, untLogCtr;

{$R *.dfm}

procedure TfrmExpArqRemBRB400p.FormShow(Sender: TObject);
var
 strProxNum: String;
begin
  inherited;
  strProxNum := fStrZero(fAtuCodSeq('CONFIG070p400', 'PROXNUM'), 5);
  strCodRem  := strProxNum;
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'PATHREM', ''));
  edtNomArquivo.Text  := 'ARQREM_' + strProxNum + '.TXT';
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemBRB400p.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmExpArqRemBRB400p.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemBRB400p.btnGerarClick(Sender: TObject);
Var
  strSQL     : String;
  strCodBco  : String;
  strNomEmp  : String;
  strDtaVen  : String;
  strDtaEmi  : String;
  strDtaJur  : String;
  strCgcEmp  : String;
  strCgcCli  : String;
  strContCor : String;
  strCodAgen : String;
  strCpfCgc  : String;
  strDiaPro  : String;
  strDiaNRec : String;
  strNosNum  : String;
  strInstru1 : String;
  strInstru2 : String;
  strCep     : String;

  strRespons : String;

  strHeader   : String;
  strTransacao: String;

  strCodMod_  : String;
  strMorDia,
  strObs001   : String;

  strPrazInst1,
  strPrazInst2: String;

  txtTexto   : TextFile;
  strNovCodEmp: String;
  blnRemLoc   : Boolean;
  qryRemessa : TUniQuery;
  strJurosDia: String;
  fltMorDia  : Double;
  strKeyDup  : String;
  strTaxa    : String;
  strDataArq : String;
  strHoraArq : String;

  intDiasMul: Integer;
  fltPerMul:  Double;

  strValMul: String;

  strFilePath : String;
  strCartei: String;
  strAutoIncremRem: String;
  strAgCC: String;
  strImprimeAgCC: String;
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

  If fMensagem('','Confirma Geração do Arquivo de Remessa?',['&Sim','&Não']) = 2 Then
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

  strCodBco := '070';
  strNomEmp := fRetNomeEmpresa(VS_strCodEmp);

  strCodAgen :=          fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'CODAGEN', '');
  strContCor :=          fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDiaPro  := fStrZero(fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'DIAPROT', ''), 02);
  strDiaNRec := fStrZero(fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'DIANREC', ''), 02);
  strRespons :=          fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'RESPONS', '');
  strInstru1 :=     Copy(fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'INSTRU1', '00'), 1, 2);
  strInstru2 :=     Copy(fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'INSTRU2', '00'), 1, 2);
  strCodMod_ :=     Copy(fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'CODMOD_', '00'), 1, 1);
  strObs001  := fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'OBSERV1', '');
  strObs001  := Copy(strObs001, 1, 40);
  strImprimeAgCC := fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'IMPAGBENEF', '');

  If strImprimeAgCC = 'N' Then
    strAgCC := Copy(strCodAgen, 2, 4) + Copy(strContCor,4 , 10);

  intDiasMul := StrToIntDef(fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'DIAMULT', ''), 0);
  fltPerMul  := fStrToFloat(fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'PERMULT', ''));

  Case  AnsiIndexText(strInstru1, ['04', '06', '09', '94']) of
    0..1 : strPrazInst1 := fPadL(IntToStr(intDiasMul), 002,'0');
    2    : strPrazInst1 := strDiaPro;
    3    : strPrazInst1 := strDiaNRec;
  end;

  Case  AnsiIndexText(strInstru2, ['04', '06', '09', '94']) of
    0..1 : strPrazInst2 := fPadL(IntToStr(intDiasMul), 002,'0');
    2    : strPrazInst2 := strDiaPro;
    3    : strPrazInst2 := strDiaNRec;
  end;


  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG070p400', 'RELOCAL', '') = 'N' );

  strJurosDia := fGetBancoConfig(0, 'CONFIG070p400', 'JUROSDI', '');
  strJurosDia := IIF(fEmptyStr(strJurosDia), '0', strJurosDia); //Divide por 30 abaixo
  strDataArq  := FormatDateTime('yyyymmdd', vs_Date);
  strHoraArq  := FormatDateTime('hhnnss', fTime());

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

    strCartei := 'CONFIG070p400-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, R.CTR_CONREM, R.CTR_BCOBOL, R.CTR_LINDIG, ';
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
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  CTR_DTAREC IS NULL ';

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

      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
      AstrEndereco := RetornaEnderecoENumeroCom35Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {***************************************************}
      {* HEADER DO ARQUIVO / REGISTRO DO TIPO 0          *}
      {************************************************KP*}
      strHeader := '';
      strHeader := fPadR   ('DCB'              , 003)      + //001 a 003
                   fPadR   ('001'              , 003)      + //004 a 006
                   fPadR   ('075'              , 003)      + //007 a 009
                   fPadL   (IIF(strImprimeAgCC = 'N', strAgCC, strContCor), 010, '0') + //010 a 019
                   fPadR   (strDataArq         , 008)      + //020 a 027
                   fPadR   (strHoraArq         , 006)      + //028 a 033
                   fStrZero(IntToStr(qryRemessa.RecordCount+1), 006) + //034 a 039
                   fPadR   (' '                , 361)      ; //040 a 400

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************KP*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG070p400-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);


      With qryRemessa Do
      Begin

        While Not Eof Do
        Begin

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTACAD').AsDateTime);

          strDtaJur := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime + 1) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime + 1) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTAVEN').AsDateTime);

          If (intDiasMul > 0) And (fltPerMul > 0) And
             ((FieldByName('CBI_DTAVEN').AsDateTime + intDiasMul) >= VS_Date) Then
            strValMul := fValNumForm( RoundTo(FieldByName('CBI_VALDUP').AsFloat * fltPerMul / 100, -2) , 005)
          Else
            strValMul := fStrZero('0', 010);

          Case  AnsiIndexText(strInstru1, ['02', '03', '04', '05', '06']) of
            0    : strTaxa   := strValMul;
            1..4 : strTaxa := fValNumForm(fltPerMul, 005);
          end;

          strKeyDup := FieldByName('CTR_BCOBOL').AsString+
                       FieldByName('CBI_CODEMP').AsString+
                       fPadR(FieldByName('CTR_CONREM').AsString, 07);

          strCep :=  AnsiReplaceStr( FieldByName('C_E_P_').AsString,'-','');

          If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          {*************************************}
          { PEGA NOSSO NUMERO NO BANCO DE DADOS }
          {**********************************JB*}
          strNosNum := Copy(FieldByName('CTR_LINDIG').AsString, 19, 2) + Copy(FieldByName('CTR_LINDIG').AsString, 22, 10);

          If strRespons = 'B' Then
            strNosNum := '00000000000';

          {***********************************}
          { CALCULA A MORA DIARIA             }
          {********************************JB*}
          fltMorDia := (fStrToFloat(strJurosDia));

          if ((strInstru1 = '08') or (strInstru2 = '08')) then
             fltMorDia := 0;

          if fltMorDia = 0 then
            strMorDia := '00'
          else
            strMorDia := '51';

          strTransacao := '';
          strTransacao := fStrZero   ('01'                              , 002)     + //001 a 002
                          fPadL      (IIF(strImprimeAgCC = 'N', strAgCC, strContCor), 010, '0') + //003 a 012
                          fPadR      (strCgcCli                         , 014,' ') + //013 a 026
                          fPadR      (FieldByName('CLI_NOMCLI').AsString, 035)     + //027 a 061
                          fPadR      (AstrEndereco                      , 035)     + //062 a 096
                          fPadR      (FieldByName('CIDADE').AsString    , 015)     + //097 a 111
                          fPadR      (FieldByName('ESTADO').AsString    , 002)     + //112 a 113
                          fPadR      (strCep                            , 008)     + //114 a 121
                          fPadR      (strCpfCgc                         , 001)     + //122 a 122
                          fPadR      (strKeyDup                         , 013)     + //123 a 135
                          fPadR      (strCodMod_                        , 001)     + //136 a 136
                          fPadR      (strDtaEmi                         , 008)     + //137 a 144
                          fStrZero   ('21'                              , 002)     + //145 a 146
                          fStrZero   ('0'                               , 001)     + //147 a 147
                          fStrZero   ('0'                               , 001)     + //148 a 148
                          fStrZero   ('02'                              , 002)     + //149 a 150
                          fStrZero   ('070'                             , 003)     + //151 a 153
                          fPadL      (strCodAgen                        , 004,'0') + //154 a 157
                          fPadR      (FieldByName('CIDADE').AsString    , 030)     + //158 a 187
                          fPadR      (strDtaVen                         , 008)     + //188 a 195
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat , 014)     + //196 a 209
                          fStrZero   (strNosNum                         , 012)     + //210 a 221
                          fPadR      (strMorDia                         , 002)     + //222 a 223
                          fValNumForm(fltMorDia                         , 014)     + //224 a 237
                          fValNumForm(0                                 , 014)     + //238 a 251
                          fPadR      ('00'                              , 002)     + //252 a 253
                          fPadR      ('00000000'                        , 008)     + //254 a 261
                          fValNumForm(0                                 , 014)     + //262 a 275
                          fPadR      (strInstru1                        , 002)     + //276 a 277
                          fPadL      (strPrazInst1                      , 002,'0') + //278 a 279
                          fPadR      (strInstru2                        , 002)     + //280 a 281
                          fPadL      (strPrazInst2                      , 002,'0') + //282 a 283
                          fPadR      (strTaxa                           , 005,'0') + //284 a 288
                          fPadR      (strNomEmp                         , 040)     + //289 a 328
                          fPadR      (strObs001                         , 040)     + //329 a 368
                          fPadR      (' '                               , 029)     + //369 a 397
                          fPadR      (' '                               , 003)     ; //398 a 400

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************KP*}
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
        //Caso o erro acontecer após o arquivo já estiver fechado
      End;

      If FileExists(strFilePath) Then
        DeleteFile(strFilePath);

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);

      Raise Exception.Create('Ocorreu um erro ao gerar o arquivo de remessa do banco ' + strCodBco + #13 +
                             'Erro gerado: ' + E.Message);
		End;
  End;

end;


function TfrmExpArqRemBRB400p.fRetEmpresa: String;
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

function TfrmExpArqRemBRB400p.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemBRB400p.FormCreate(Sender: TObject);
begin
  inherited;
     qryCadPor := fCriaQuery(Self);
end;

end.
