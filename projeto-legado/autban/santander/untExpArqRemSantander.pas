unit untExpArqRemSantander;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, JvExMask,
  JvToolEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemSantander = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRem: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    Label1: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    btnGerar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private

    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;
    function fRetEmpresa: String;
    function fRetDupAgrupadas(strNumAgr, strCodCli: String): String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
    
  end;

var
  frmExpArqRemSantander: TfrmExpArqRemSantander;

implementation

uses untFuncoes, untfuncoesSimples,  Data.DB;

{$R *.dfm}

procedure TfrmExpArqRemSantander.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yy',VS_Date),2) +
                         '.TXT';
  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemSantander.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strContBco  : String;
    strContCor  : String;
    strContCob  : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
//    strSeqTit   : String;
    strCodCar   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strInstru1  : String;
    strInstru2  : String;
    strLivre    : String;
    strAgenCob  : String;

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;
    strSacAva   : String;
    strDupAgr   : String;
    strEnvDpAg  : String;
    strMensagem : String;

    intCodSeq   : Integer;
    intQtdTot   : Integer;
    fltValTot   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    fltMulAtr   : Double;
//    fltValMor   : Double;

    qryRemessa  : TUniQuery;

begin
  inherited;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco  := '353';
  strNomBco  := 'SANTANDER';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strContBco := fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'IDENTBC', '');
  strCodAgen := fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'DIAPROT', '');
  strContCor := fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'NUMCTAC', '');
  strContCob := fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'NUMCTAB', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'INSTRU2', '');
  blnRemLoc  := Not( fArqIniAutban(0, 'CONFIG353', 'RELOCAL', '') = 'N' );
  strAgenCob := '00000';

  If fEmptyStr(fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'MULATR_', '')) Then
    fltMulAtr := 0
  Else
    fltMulAtr := fStrToFloat(fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'MULATR_', ''));

  strSacAva  := fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'MSACAVA', '');
  strEnvDpAg := fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'ENVDPAG', '');

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

  Finally
    FreeAndNil(qryConsultaGen);
  End;

  Try

    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", CONCAT(C.CLI_ENDERE, ", ", IFNULL(C.CLI_ENDNUM, ""), IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM))), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B, ';
    strSQL := strSQL + '  CADCLI C ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
    //strSQL := strSQL + '  CBI_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CLI_CODCLI = CBI_CODCLI ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
      strSQL := strSQL + '  AND LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0 ';

    strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL,'CADCBI','CADCBIX');

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        ParamByName('CODPOR').AsString := edtCodPor.Text;

      //ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      Rewrite(txtTexto);

      {***************************************}
      {* VERIFICA SE MOSTRA SACADOR AVALISTA *}
      {************************************PZ*}
      If (strSacAva = 'N') Then
        strNomEmp := '';

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('0'                , 001)      + //001 - 001
                   fPadR   ('1'                , 001)      + //002 - 002
                   fPadR   ('REMESSA'          , 007)      + //003 - 009
                   fPadR   ('01'               , 002)      + //010 - 011
                   fPadR   ('COBRANCA'         , 015, ' ') + //012 - 026
                   fPadL   (strContBco         , 020, '0') + //027 - 046 - Código do Cedente
                   fPadR   (strNomEmp          , 030, ' ') + //047 - 076
                   fPadR   (strCodBco          , 003)      + //077 - 079
                   fPadR   (strNomBco          , 015, ' ') + //080 - 094
                   fPadR   (strDtaRem          , 006)      + //095 - 100
                   fStrZero('0'                , 016)      + //101 - 116
                   fPadR   (fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'OBSERV1', ''), 47) + //117 - 163
                   fPadR   (fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'OBSERV2', ''), 47) + //164 - 210
                   fPadR   (fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'OBSERV3', ''), 47) + //211 - 257
                   fPadR   (fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'OBSERV4', ''), 47) + //258 - 304
                   fPadR   (fArqIniAutban(0, 'CONFIG353-' + IntToStr(intCartei), 'OBSERV5', ''), 47) + //305 - 351
                   fPadR   (' '                , 40 )      + //352 - 391                   
                   fStrZero('0'                , 003)      + //392 - 394
                   fPadL   (IntToStr(intCodSeq), 006, '0');  //395 - 400

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      With qryRemessa Do
      Begin
        strTransacao := '';
        intQtdTot    := 0;
        fltValTot    := 0;

        While Not Eof Do
        Begin
        
          Inc(intCodSeq);
          Application.ProcessMessages;

//          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat * FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

          Inc(intQtdTot);
//          fltValTot := fltValTot + FieldByName('CBI_VALDUP').AsFloat;

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

//          strSeqTit := fStrZero(fAtuCodSeq('CONFIG353', 'PROXNUM'), 7);

          strKeyDup := FieldByName('CBI_NUMDUP').AsString +
                       FieldByName('CBI_PARCEL').AsString +
                       FieldByName('CBI_ESPDOC').AsString +
                       FieldByName('CBI_CODEMP').AsString +
                       FieldByName('CBI_CODCLI').AsString;

          strLivre  := FieldByName('CBI_NUMDUP').AsString +
                       FieldByName('CBI_PARCEL').AsString +
                       FieldByName('CBI_CODEMP').AsString; //Campoo denominado seu número 

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          {**********************************}
          {* CALCULA O VALOR DA MORA DIARIA *}
          {*******************************JB*}
          fltValTot := FieldByName('CBI_VALDUP').AsFloat * (FieldByName('CBI_PORCEN').AsFloat / 100);

          strTransacao := fPadR      ('1'                                  , 01)      + //001 - 001
                          fPadR      ('02'                                 , 02)      + //002 - 003
                          fPadL      (strCgcEmp                            , 14, '0') + //004 - 017
                          fPadL      (strCodAgen                           , 04, '0') + //018 - 021
                          fPadL      (strContCor                           , 08, '0') + //022 - 029
                          fPadL      (strContCob                           , 08, '0') + //030 - 037
                          fPadR      (strKeyDup                            , 25, ' ') + //038 - 062
                          fStrZero   (FieldByName('CBI_NOSNUM').AsString   , 08)      + //063 - 070
                          fStrZero   ('0'                                  , 06)      + //071 - 076
                          fPadR      (' '                                  , 01)      + //077 - 077
                          fPadR      ('4'                                  , 01)      + //078 - 078
                          //fValNumForm(FieldByName('CBI_PORCEN').AsFloat    , 04)      + //079 - 082
                          fValNumForm(fltMulAtr                            , 04)      + //079 - 082
                          fPadR      ('00'                                 , 02)      + //083 - 084
                          fStrZero   ('0'                                  , 13)      + //085 - 097
                          fPadR      (' '                                  , 04)      + //098 - 101
                          fStrZero   ('0'                                  , 06)      + //102 - 107
                          fPadR      (strCodCar                            , 01)      + //108 - 108
                          fPadR      ('01'                                 , 02)      + //109 - 110
                          fPadR      (strLivre                             , 10)      + //111 - 120
                          fPadR      (strDtaVen                            , 06)      + //121 - 126
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat    , 13)      + //127 - 139
                          fPadR      (strCodBco                            , 03)      + //140 - 142
                          fPadL      (strAgenCob                           , 05, '0') + //143 - 147
                          fPadR      ('01'                                 , 02)      + //148 - 149
                          fPadR      ('N'                                  , 01)      + //150 - 150
                          fPadR      (strDtaEmi                            , 06)      + //151 - 156
                          fPadL      (strInstru1                           , 02, '0') + //157 - 158
                          fPadL      (strInstru2                           , 02, '0') + //159 - 160
                          //fValNumForm(FieldByName('CBI_PORCEN').AsFloat    , 13)      + //161 - 173
                          fValNumForm(fltValTot                            , 13)      + //161 - 173  
                          fStrZero   ('0'                                  , 06)      + //174 - 179
                          fStrZero   ('0'                                  , 13)      + //180 - 192
                          fStrZero   ('0'                                  , 13)      + //193 - 205
                          fStrZero   ('0'                                  , 13)      + //206 - 218
                          fPadL      (strCpfCgc                            , 02, '0') + //219 - 220
                          fPadL      (strCgcCli                            , 14, '0') + //221 - 234
                          fPadR      (FieldByName('CLI_NOMCLI').AsString   , 40, ' ') + //235 - 274
                          fPadR      (FieldByName('ENDERE').AsString       , 40, ' ') + //275 - 314
                          fPadR      (FieldByName('BAIRRO').AsString       , 12, ' ') + //315 - 326
                          fPadL      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 - 334
                          fPadR      (FieldByName('CIDADE').AsString       , 15, ' ') + //335 - 349
                          fPadR      (FieldByName('ESTADO').AsString       , 02, ' ') + //350 - 351
                          fPadR      (strNomEmp                            , 30, ' ') + //352 - 381
                          fPadR      (' '                                  , 01)      + //382 - 382
                          fPadL      ('0'                                  , 01)      + //383 - 383
                          fStrZero   ('0'                                  , 02)      + //384 - 385
                          fPadR      (' '                                  , 06)      + //386 - 391
                          fPadL      (strDiaPro                            , 02, '0') + //392 - 393
                          fPadL      (' '                                  , 01)      + //394 - 394
                          fPadL      (IntToStr(intCodSeq)                  , 06, '0');  //395 - 400

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);

          {******************************}
          {* DADOS DA MENSAGEM VARIÁVEL *}
          {***************************RV*}
          If (strEnvDpAg = 'S') Then
          Begin
            strMensagem := '';
            Inc(intCodSeq);
            Inc(intQtdTot);

            {***********************************************}
            {* SE FOR AGRUPAMENTO, INSERE OS NUMEROS DAS   *}
            {* DUPLICATAS AGRUPADAS, SENÃO DEIXA EM BRANCO *}
            {********************************************RV*}
            If (FieldByName('CBI_ESPDOC').AsString = 'AG') Then
            Begin
              strDupAgr := fRetDupAgrupadas(FieldByName('CBI_NUMDUP').AsString, FieldByName('CBI_CODCLI').AsString);
            End
            Else
            Begin
              strDupAgr := '';
            End;

            strMensagem := fPadR   ('2'                                  , 01)      + //001 - 001
                           fPadR   (' '                                  , 16)      + //002 - 017
                           fPadL   (strCodAgen                           , 04, '0') + //018 - 021
                           fPadL   (strContCor                           , 08, '0') + //022 - 029
                           fPadL   (strContCob                           , 08, '0') + //030 - 037
                           fPadR   (' '                                  , 10)      + //038 - 047
                           fPadR   ('01'                                 , 02)      + //048 - 049
                           fPadR   (strDupAgr                            , 50)      + //050 - 099
                           fPadR   (' '                                  ,283)      + //100 - 382
                           fPadR   ('I'                                  , 01)      + //383 - 383
                           fStrZero(RightStr(strContCob,2)               , 02)      + //384 - 385
                           fPadR   (' '                                  , 09)      + //386 - 394
                           fPadL   (IntToStr(intCodSeq)                  , 06, '0');  //395 - 400

            {**************************************}
            {* ESCREVE A MENSAGEM VARIAVEL NO TXT *}
            {***********************************RV*}
            Writeln(txtTexto, strMensagem);

          End;

          Next;
        End;

      End;

      {************}
      {* TRAILLER *}
      {*********AF*}
      Inc(intCodSeq);
      strTrailler := '';
      strTrailler := '9'                                        + //001 - 001
                     fPadL      (IntToStr(intQtdTot), 006, '0') + //002 - 007
                     fValNumForm(fltValTot          , 013)      + //008 - 020
                     fStrZero   ('0'                , 374)      + //021 - 394                     
                     fPadL      (IntToStr(intCodSeq), 006, '0');  //395 - 400

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CADCBI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';

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

        ExecSQL;
        Close;

        strSQL := AnsiReplaceStr(strSQL, 'CADCBI', 'CADCBIX');

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;

        If (Not fEmptyStr(edtCodPor.Text)) Then
          ParamByName('CODPOR').AsString := edtCodPor.Text;

        ExecSQL;
        Close;
      End;

    End
    Else
    Begin
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

  Finally
    FreeAndNil(qryRemessa);
  End;

end;

procedure TfrmExpArqRemSantander.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS'
  Else
  Begin
    edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

    If fEmptyStr(edtDesPor.Text) Then
    Begin
      fMensagem('', 'Portador não cadastrado!', ['&Ok']);
      pSetFocus(edtCodPor);
    End
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
      Begin
        fMensagem('', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
        pSetFocus(edtCodPor);
      End;
    End;

  End;

end;

procedure TfrmExpArqRemSantander.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndicePor: TStringList;
    stlDesIndPor: TStringList;
    strSQL: String;

begin
  inherited;
    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  POR_CODPOR  AS "Código",  ';
    strSQL := strSQL + '  POR_NOMPOR  AS "Nome",  ';
    strSQL := strSQL + '  AUTOINCREM  ';
    strSQL := strSQL + 'FROM  ';
    strSQL := strSQL + '  CADPOR  ';
    strSQL := strSQL + 'WHERE   ';
    strSQL := strSQL + '  TRUE  ';

  If fEntraCons(Key) Then
  Begin

    Try

      stlIndicePor := TStringList.Create;
      stlDesIndPor := TStringList.Create;

      Key := #0;

      stlIndicePor.Add('POR_NOMPOR');
      stlIndicePor.Add('POR_CODPOR');
      stlDesIndPor.Add('Nome');
      stlDesIndPor.Add('Código');

      If pConsultaComp(Self, qryCadPor,'CADPOR',strSQL,stlIndicePor,stlDesIndPor) Then
      Begin
        edtCodPor.Text := qryCadPor.FieldByName('POR_CODPOR').AsString;
        Self.SelectNext((Sender As TWinControl), True, True);
      End;

    Finally
      FreeAndNil(stlIndicePor);
      FreeAndNil(stlDesIndPor);
    End;

  End;

end;



function TfrmExpArqRemSantander.fRetDupAgrupadas(strNumAgr,
  strCodCli: String): String;
Var
  strSQL   : String;
  strDupAgr: String;
  strInsBar: String;
  intQtdDup: Integer;
  qryAgr   : TUniQuery;
begin

  Try

    Try

      qryAgr := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + 'SELECT   ';
      strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS NUMDUP ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  DUPAGR ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  CTR_NUMAGR = :NUMAGR AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI     ';

      With qryAgr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('NUMAGR').AsString := strNumAgr;
        ParamByName('CODCLI').AsString := strCodCli;

        Open;

        strDupAgr := '';
        intQtdDup := 1;
        strInsBar := 'N';

        While Not Eof Do
        Begin
          {***************************************}
          {* LIMITA A QUANTIDADE DE 6 DUPLICATAS *}
          {* PARA NÃO EXCEDER A QTDE DE CARACTER *}
          {* DISPONÍVEL.(TOTAL = 50)             *}
          {************************************RV*}
          If (intQtdDup <= 6) Then
          Begin
            If (strInsBar = 'N') Then
            Begin
              strDupAgr := FieldByName('NUMDUP').AsString;
              strInsBar := 'S';
            End
            Else
            Begin
              strDupAgr := strDupAgr + '/' + FieldByName('NUMDUP').AsString;
            End;
          End;

          Inc(intQtdDup);

          Next;
        End;

        Result := strDupAgr;

      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TfrmExpArqRemSantander.fRetDupAgrupadas]');
    End;

  Finally
    FreeAndNil(qryAgr);
  End;
end;

function TfrmExpArqRemSantander.fRetEmpresa: String;
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



procedure TfrmExpArqRemSantander.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.
