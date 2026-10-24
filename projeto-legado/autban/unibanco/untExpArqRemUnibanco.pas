unit untExpArqRemUnibanco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, JvExMask,
  JvToolEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemUnibanco = class(TfrmPai)
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
    { Private declarations }
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    blnRemLoc : Boolean;
    function fRetEmpresa: String;

  public
    { Public declarations }
    intCartei  : Integer;
    strNomForm : String;


  end;

var
  frmExpArqRemUnibanco: TfrmExpArqRemUnibanco;

implementation

uses untFuncoes, untfuncoesSimples, Data.DB,
  untCfgGenericas_AutBan;

{$R *.dfm}

procedure TfrmExpArqRemUnibanco.FormShow(Sender: TObject);
begin
  inherited;

  Application.CreateForm(tfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
  frmCfgGenericas_AutBan.strNomForm := strNomForm;
  frmCfgGenericas_AutBan.strCodBco  := '409';
  blnRemLoc := (frmCfgGenericas_AutBan.fRetRemessaLocal = 'S');
  FreeAndNil(frmCfgGenericas_AutBan);

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fArqIniAutban(0, 'CONFIG409-' + IntToStr(intCartei), 'PATHREM',''));

  //*************************************************//
  // A PEDIDO DO MARIO FOI ALTERADO O NOME DO ARQ.   //
  // NO DIA 05/10/2007.                              //
  //**********************************************ED*//
  edtNomArquivo.Text  := 'UNI' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         '5.REM';


  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemUnibanco.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
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

    strHeader   : String;
    strTransacao: String;
    strTrailler : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;

    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa  : TUniQuery;

    strComReg   : String;
    strGrupoEmp : String;
    strTipFor   : String;
    strTipCri   : String;
    strTipPos   : String;
    strRefCli   : String;
    strDigRef   : String;
    strAgeDep   : String;

    strNumCta   : String;
    strProAce   : String;
    strDtaMul   : String;
    strDtaReg   : String;
    strNumParcel: String;

    fltTotTitulos: Double;
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

  strCodBco  := '409';
  strNomBco  := 'UNIBANCO';
  strContBco := fArqIniAutban(0, 'CONFIG409-' + IntToStr(intCartei), 'IDENTBC', '');
  strCodAgen := fArqIniAutban(0, 'CONFIG409-' + IntToStr(intCartei), 'CODAGEN', '');
  strCodCar  := fArqIniAutban(0, 'CONFIG409-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fArqIniAutban(0, 'CONFIG409-' + IntToStr(intCartei), 'DIAPROT', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fArqIniAutban(0, 'CONFIG409-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fArqIniAutban(0, 'CONFIG409-' + IntToStr(intCartei), 'INSTRU2', '');
  blnRemLoc  := Not( fArqIniAutban(0, 'CONFIG409', 'RELOCAL', '') = 'N');

  strComReg   := fArqIniAutban(0,'CONFIG409', 'COMREGI', 'S');
  strGrupoEmp := fArqIniAutban(0,'CONFIG409-' + IntToStr(intCartei), 'GRUPEMP', '');
  strTipFor   := fArqIniAutban(0,'CONFIG409-' + IntToStr(intCartei), 'TIPFORM', '');
  strTipCri   := fArqIniAutban(0,'CONFIG409-' + IntToStr(intCartei), 'TIPCRIT', '');
  strTipPos   := fArqIniAutban(0,'CONFIG409-' + IntToStr(intCartei), 'TIPPOST', '');
  strRefCli   := fArqIniAutban(0,'CONFIG409-' + IntToStr(intCartei), 'REFECLI', '');
  strDigRef   := fArqIniAutban(0,'CONFIG409-' + IntToStr(intCartei), 'DIGREFE', '');
  strAgeDep   := fArqIniAutban(0,'CONFIG409-' + IntToStr(intCartei), 'AGEDEPO', '');

  strNumCta   := fArqIniAutban(0,'CONFIG409-' + IntToStr(intCartei), 'NUMCTAC', '');
  strProAce   := fArqIniAutban(0,'CONFIG409-' + IntToStr(intCartei), 'PROACEI', '');

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
      strSeqTit := fStrZero(fAtuCodSeq('CONFIG409', 'PROXNUM'), 3);

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      Rewrite(txtTexto);

      //*************************************************//
      // HEADER DO ARQUIVO                               //
      //**********************************************ED*//
      intCodSeq := 1;
      strHeader := '';

      If strComReg = 'S' Then
      Begin
        strHeader := fPadR   ('0'                , 001)      + //001
                     fPadR   ('1'                , 001)      + //002
                     fPadR   ('REMESSA'          , 007)      + //003
                     fPadR   ('01'               , 002)      + //010
                     fPadR   ('COBRANCA'         , 015)      + //012
                     fPadR   (strCodAgen         , 004)      + //027
                     fPadL   (strContBco         , 007, '0') + //031
                     fPadR   (' '                , 009)      + //038
                     fPadR   (strNomEmp          , 030)      + //047
                     fPadR   (strCodBco          , 003)      + //077
                     fPadR   (strNomBco          , 008)      + //080
                     fPadR   (' '                , 007)      + //088
                     fPadR   (strDtaRem          , 006)      + //095
                     fPadR   ('01600'            , 005)      + //101
                     fPadR   ('BPI'              , 003)      + //106
                     fPadR   (' '                , 286)      + //109
                     fStrZero(IntToStr(intCodSeq), 006);       //395
      End
      Else
      Begin
        strProAce := IIF(strProAce='S', 'A', 'N');
        
        strHeader := fPadR   ('0'                , 001)      + //001
                     fPadR   ('1'                , 001)      + //002
                     fPadR   ('REMESSA'          , 007)      + //003
                     fPadR   ('03'               , 002)      + //010
                     fPadR   ('COBR.  ESPECIAL'  , 015)      + //012 - ATENÇÃO POIS TEM 2 ESPAÇOS.
                     fPadR   (strCodAgen         , 004)      + //027
                     fPadR   (strNumCta          , 007)      + //|||
                     fPadR   (strGrupoEmp        , 004)      + //038
                     fPadR   (strTipFor          , 001)      + //042
                     fPadR   (strTipCri          , 001)      + //043
                     fPadR   (strTipPos          , 001)      + //044
                     fPadR   (strGrupoEmp        , 007)      + //045
                     fPadR   (' '                , 043)      + //052
                     fPadR   (strDtaRem          , 006)      + //095
                     fPadR   ('01600'            , 005)      + //101
                     fPadR   ('BPI'              , 003)      + //106
                     fPadR   (' '                , 116)      + //109
                     fPadR   ('0'                , 167, '0') + //225
                     fPadR   (strSeqTit          , 003)      + //392
                     fStrZero(IntToStr(intCodSeq), 006);       //395

      End;

      //*************************************************//
      // ESCREVE O HEADER NO TXT                         //
      //**********************************************ED*//
      Writeln(txtTexto,strHeader);

      //*************************************************//
      // TRANSAÇÃO DO ARQUIVO                            //
      //**********************************************ED*//
      With qryRemessa Do
      Begin
        strTransacao := '';
        fltTotTitulos := 0.0;

        While Not Eof Do
        Begin
          Inc(intCodSeq);
          Application.ProcessMessages;

          fltValAtr := fFormataFloat((FieldByName('CBI_VALDUP').AsFloat *
                              FieldByName('CBI_PORCEN').AsFloat) / 100, 2);

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

          If strComReg = 'S' Then
          Begin
            strKeyDup := FieldByName('CBI_NUMDUP').AsString +
                         FieldByName('CBI_PARCEL').AsString +
                         FieldByName('CBI_ESPDOC').AsString +
                         FieldByName('CBI_CODEMP').AsString +
                         FieldByName('CBI_CODCLI').AsString;
          End
          Else
          Begin
            strKeyDup := FieldByName('CBI_NUMDUP').AsString +
                         FieldByName('CBI_PARCEL').AsString +
                         FieldByName('CBI_ESPDOC').AsString +
                         FieldByName('CBI_CODEMP').AsString;
          End;

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          fltTotTitulos := fltTotTitulos + FieldByName('CBI_VALDUP').AsFloat;

          If strComReg = 'S' Then
          Begin
            strTransacao := fPadR      ('1'                                  , 01)      + //001 001
                            fPadR      ('02'                                 , 02)      + //002 003
                            fPadL      (strCgcEmp                            , 14, '0') + //004 017     CGC DA EMPRESA
                            fPadR      (strCodAgen                           , 04, '0') + //018 021     CODIGO DA AGENCIA
                            fPadL      (strContBco                           , 07, '0') + //022 028     CONTA CORRENTE + DIGITO
                            fPadR      ('0'                                  , 01)      + //029 029     INDICA SE EXISTE MENSAGEM 0=n/1s
                            fPadR      (' '                                  , 08)      + //030 037     USO DO BANCO
                            fPadR      (strKeyDup                            , 25)      + //038 062     IDENT. DO TIT. NA EMPRESA
                            fStrZero   (FieldByName('CBI_NOSNUM').AsString   , 11)      + //063 072     NOSSO NUMERO(10) + DIG(1)
                            fPadR      (' '                                  , 30)      + //074 103     MENSAGEM DO BLOQUETO         *
                            fPadR      (' '                                  , 04)      + //104 107     CODIGO DA MOEDA
                            fPadR      (strCodCar                            , 01)      + //108 108     CODIGO DA CARTEIRA
                            fPadR      ('01'                                 , 02)      + //109 110     IDENT. DA TRANSACAO
    //                        fPadR      (FieldByName('CBI_NUMDUP').AsString   , 10)      + //111 120     N. DUPL. PROMISSORIA, NF, ETC
                            fPadR      (LeftStr( strKeyDup, 7)               , 10)      + //111 120     N. DUPL. PROMISSORIA, NF, ETC
                            fPadR      (strDtaVen                            , 06)      + //121 126     VENCIMENTO
                            fValNumForm(FieldByName('CBI_VALDUP').AsFloat    , 13)      + //127 139     VALOR DUP
                            fPadR      (strCodBco                            , 03)      + //140 142     COD DO BANCO RESP. PELA COBRANCA
                            fPadR      (' '                                  , 01)      + //143 143     USO DO BANCO
                            fPadR      (strCodAgen                           , 04)      + //144 147     AGENCIA ENC. DA COBRANCA
                            fPadR      ('01'                                 , 02)      + //148 149     ESPECIE DO TITULO
                            fPadR      ('N'                                  , 01)      + //150 150     IDENT. ACEITE
                            fPadR      (strDtaEmi                            , 06)      + //151 156     DATA DA EMISSAO
                            fPadR      (strInstru1                           , 02)      + //157 158     INSTRUCAO 1
                            fPadR      (strInstru2                           , 02)      + //159 160     INSTRUCAO 2
                            fValNumForm(fltValAtr                            , 13)      + //161 173     VALOR DA MORA DE ATRAZO
                            fStrZero   ('0'                                  , 06)      + //174 179     DATA LIMITE PARA DESCONTO
                            fStrZero   ('0'                                  , 13)      + //180 192     VALOR DESCONTO A SER CONCEDIDO
                            fStrZero   ('0'                                  , 13)      + //193 205     USO DO BANCO
                            fStrZero   ('0'                                  , 13)      + //206 218     VALOR DO ABATIMENTO
                            fStrZero   (strCpfCgc                            , 02)      + //219 220     TIPO DE INSCRICAO DO SACADO
                            fPadL      (strCgcCli                            , 14, '0') + //221 234     N. INSCRICAO DO SACADO
                            fPadR      (FieldByName('CLI_NOMCLI').AsString   , 30)      + //235 264     NOME DO SACADO
                            fPadR      (' '                                  , 10)      + //265 274     USO DO BANCO
                            fPadR      (FieldByName('ENDERE').AsString       , 40)      + //275 314     ENDERECO DO SACADO
                            fPadR      (FieldByName('BAIRRO').AsString       , 12)      + //315 326     BAIRRO DO SACADO
                            fPadR      (FieldByName('C_E_P_').AsString       , 08, '0') + //327 334     CEP DO SACADO
                            fPadR      (FieldByName('CIDADE').AsString       , 15)      + //335 349     CIDADE DO SACADO
                            fPadR      (FieldByName('ESTADO').AsString       , 02)      + //350 351     ESTADO DO SACADO
                            fPadR      (' '                                  , 30)      + //352 381     NOME DO SACADO/AVALISTA
                            fPadR      (' '                                  , 10)      + //382 391     USO DO BANCO
                            fStrZero   (strDiaPro                            , 02)      + //392 393     PRAZO PARA PROTESTO
                            fPadR      (' '                                  , 01)      + //394 394     USO DO BANCO
                            fStrZero   (IntToStr(intCodSeq)                  , 06);       //395 400     SEQUECIAL DE REGISTRO
          End
          Else
          Begin
            strNumParcel := IntToStr(Ord(FieldByName('CBI_PARCEL').AsString[1])-64);
            strDtaMul    := FormatDateTime('ddmmyy', FieldByName('CBI_DTAVEN').AsDateTime+1);
            strDtaReg    := FormatDateTime('ddmmyy', VS_Date);

            strTransacao := fPadR      ('2'                                            , 01)      + //001 001 CÓDIGO DO REGISTRO
                            fPadR      (strRefCli                                      , 14)      + //002 015 NÚMERO DE REFERÊNCIA DO CLIENTE
                            fPadR      (strDigRef                                      , 01)      + //016 016 DÍGITO DE REFERÊNCIA DO CLIENTE
                            fPadR      (strDtaVen                                      , 06)      + //017 022 DATA DE VENCIMENTO DO TÍTULO
                            fPadR      (strAgeDep                                      , 04)      + //023 026 AGÊNCIA DEPOSITÁRIA
                            fPadR      (strCodAgen + strNumCta                         , 11)      + //027 037 AGÊNCIA + C/C. DO CEDENTE
                            fPadR      (LeftStr(FieldByName('CLI_NOMCLI').AsString, 30), 30)      + //038 067 NOME DO SACADO
                            fPadR      (LeftStr(FieldByName('ENDERE').AsString, 30)    , 30)      + //068 097 ENDEREÇO DO SACADO
                            fPadR      (LeftStr(FieldByName('BAIRRO').AsString, 20)    , 20)      + //098 117 BAIRRO DO SACADO
                            fPadR      (LeftStr(FieldByName('CIDADE').AsString, 20)    , 20)      + //118 137 CIDADE DO SACADO
                            fPadR      (FieldByName('ESTADO').AsString                 , 02)      + //138 139 ESTADO DO SACADO
                            fPadR      (FieldByName('C_E_P_').AsString                 , 08)      + //140 147 CEP DO SACADO
                            fPadR      (strDtaReg                                      , 06)      + //148 153 DATA DO REGISTRO
                            fPadR      (' '                                            , 02)      + //154 155 USO DO BANCO
                            fPadR      ('0'                                            , 10, '0') + //156 165 QUANTIDADE DE MOEDA
                            fValNumForm(FieldByName('CBI_VALDUP').AsFloat              , 15)      + //166 180 VALOR DO TÍTULO
                            fPadR      ('0'                                            , 15, '0') + //181 195 VALOR DO DESCONTO
                            fValNumForm(fltValAtr                                      , 12)      + //196 207 JUROS DE MORA DIÁRIA
                            fPadR      ('0'                                            , 12, '0') + //208 219 MULTA POR ATRASO NO PAGAMENTO
                            fPadL      (strNumParcel                                   , 03, '0') + //220 222 NÚMERO DA PARCELA
                            fPadR      (' '                                            , 42)      + //223 264 USO DO BANCO
                            fPadR      (strKeyDup                                      , 18)      + //265 282 NÚMERO DO DOCUMENTO
                            fPadR      ('Mercan'                                       , 06)      + //283 288 ESPÉCIE DE DOCUMENTO
                            fPadR      (strProAce                                      , 02)      + //289 290 ACEITE
                            fPadR      (strDtaRem                                      , 06)      + //291 296 DATA DE PROCESSAMENTO
                            fPadR      ('20'                                           , 02)      + //297 298 CÓDIGO DA CARTEIRA
                            fPadR      ('0'                                            , 01)      + //299 299 INDICADOR DE MENSAGEM
                            fPadR      ('000000'                                       , 06)      + //300 305 DATA DE DESCONTO
                            fPadR      (strDtaMul                                      , 06)      + //306 311 DATA PARA MULTA
                            fPadR      ('000'                                          , 03)      + //312 314 PRAZO DE MORA DIÁRIA
                            fPadR      (' '                                            , 04)      + //315 318 CODIGO DA MOEDA
                            fPadR      (' '                                            , 13)      + //319 331 USO DO BANCO
                            fPadR      (' '                                            , 60)      + //332 391 ENDEREÇO DO SACADO (VER NOTA 5)
                            fPadR      (' '                                            , 03)      + //392 394 USO DO BANCO
                            fStrZero   (IntToStr(intCodSeq)                            , 06);       //395 400 SEQUENCIAL DE REGISTRO
          End;

          //*************************************************//
          // ESCREVE A TRANSACAO NO TXT                      //
          //**********************************************ED*//
          Writeln(txtTexto,strTransacao);

          Next;
        End;

      End;

      //*************************************************//
      // TRAILLER                                        //
      //**********************************************ED*//
      Inc(intCodSeq);
      strTrailler := '';

      If strComReg = 'S' Then
      Begin
        strTrailler := '9'                                + //001
                       fPadR   (' '                , 393) + //002
                       fStrZero(IntToStr(intCodSeq), 006);  //395
      End
      Else
      Begin
        strTrailler := '9'                                       + //001
                       fPadR      (' '                    , 025) + //002
                       fPadR      (strCodAgen + strNumCta , 011) + //027
                       fPadR      (' '                    , 334) + //038
                       fStrZero(IntToStr(intCodSeq)       , 006) + //372
                       fValNumForm(fltTotTitulos          , 017) + //378
                       fStrZero(IntToStr(intCodSeq)       , 006);  //395
      End;


      //*************************************************//
      // ESCREVE O TRAILLER NO TXT                       //
      //**********************************************ED*//
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

procedure TfrmExpArqRemUnibanco.edtCodPorExit(Sender: TObject);
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

procedure TfrmExpArqRemUnibanco.edtCodPorKeyPress(Sender: TObject;
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

function TfrmExpArqRemUnibanco.fRetEmpresa: String;
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

procedure TfrmExpArqRemUnibanco.FormCreate(Sender: TObject);
begin
  inherited;
     qryCadPor := fCriaQuery(Self);
end;

end.
