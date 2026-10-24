unit untExpArqRemBMPMoneyPlus_LP_400;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, AppEvnts, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, frxClass,
  frxExportCSVTestabilidade, Uni, untTypesSistema, untConsultas,
  untFrameDirectoryEditFocus, Data.DB;

type
  TfrmExpArqRemBMPMoneyPlus_LP_400 = class(TfrmPai)
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
    Function  fRetornaChaveNfe(StrChvNfe : String) : String;
  private

    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;

    function fRetEmpresa: String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;       
  end;

var
  frmExpArqRemBMPMoneyPlus_LP_400: TfrmExpArqRemBMPMoneyPlus_LP_400;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

procedure TfrmExpArqRemBMPMoneyPlus_LP_400.FormShow(Sender: TObject);
  Var strSeq : String;
      iseq : Integer;
begin
  inherited;

  fraPathRemessa.edtDirectory.Text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'PATHREM',''));
  strSeq := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'PROXNUM','');

  If fEmptyStr(strSeq) Then
     strSeq := '0';

  iseq := StrToInt(strSeq);

  inc(iseq);

  edtNomArquivo.Text  := 'CB' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero( IntToStr(iSeq),7) +
                         '.REM';

  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemBMPMoneyPlus_LP_400.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strCodBco   : String;
    strNomBco   : String;
    strNomEmp   : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
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
    strInstru2  : String;
    strObserv   : String;
    strHeader   : String;
    strTransacao: String;
    strAvalista : String;
    strTrailler : String;

    intCodSeq   : Integer;
    fltValAtr   : Double;
    txtTexto    : TextFile;
    strRespon   : String;
    strNosNum   : String;
//    strExpBol   : String;
    strExpRem   : String;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;

    fltPerMul   : Double;

    qryRemessa  : TUniQuery;

    strUsaSac,
    strSacAva,
    strBenefi,
    strSacEnd,
    strSacCEP,
    strSacCid,
    strSacEst : String;
    LDocumento: String;
    strChvNfe : String;
    strPos335_394 : String;

begin
  inherited;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  fraPathRemessa.edtDirectory.Text := fVerBarraFinal(fraPathRemessa.edtDirectory.Text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.Text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa.edtDirectory);
    Exit;
  End;

  intCodSeq  := 1;
  strCodBco  := '274';
  strNomBco  := 'BMP MONEY PLUS';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodRem  := fStrZero(fAtuCodSeq('CONFIG274LP400p-' + IntToStr(intCartei), 'PROXNUM'), 7);

  strNumAut  := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'NUMAUTO', '');
  strCodAge  := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'CODAGEN', '');
  strEmpBco  := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'CODEMPR', '');
  strCntCor  := RightStr(fStrZero(fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'NUMCTAC', ''), 7), 7);
  strDigCnt  := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'CODCART', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'INSTRU1', '');

  If (strInstru1 = '06') Or (strInstru1 = '05') Or (strInstru1 = '18') Then
    strInstru2 := fStrZero(fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'DIAPROT', ''),2)
  Else
    strInstru2 := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'INSTRU2', '');

  strObserv  := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'OBSERV1', '');
  blnRemLoc  := Not( fGetBancoConfig(0,'CONFIG274LP400p', 'RELOCAL', '') = 'N' );

  fltPerMul  :=  fStrToFloat ( fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'PERMULT', '') );

  strUsaSac  := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'SACAVAL', '');
  strBenefi  := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'NOMEBEN', '');

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
  If (fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'RESPONS', '') = 'E') Then
    strRespon := '2';


  strDiaPro := '00';

  strExpRem := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'EXPOREM', '');
  If fEmptyStr( strExpRem ) Then
    strExpRem := '1';

  Try

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
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;

      If strUsaSac = 'S' Then
      Begin
        strSacAva := '2' + fPadL(fTiraCaracEspeciaisPonto(strCgcEmp), 015, '0') + fPadR(strNomEmp, 044);
        strSacEnd := fPadR(FieldByName('EMP_ENDERE').AsString + ', ' +
                           FieldByName('EMP_ENDNUM').AsString + ' ' +
                           FieldByName('EMP_BAIRRO').AsString, 045);
        strSacCEP := fPadR(fRetSomenteNumeros(FieldByName('EMP_C_E_P_').AsString), 008, '0');
        strSacCid := fPadR(FieldByName('CID_NOMCID').AsString, 020);
        strSacEst := fPadR(FieldByName('CID_ESTADO').AsString, 002);
      End;

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
    strSQL := strSQL + '  ,L.NFE_ACESSO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B ';
    strSQL := strSQL + 'INNER JOIN CADCLI C ON CLI_CODCLI = CBI_CODCLI ';
    strSQL := strSQL + 'INNER JOIN CADREC R ON R.CTR_NUMDUP = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                  R.CTR_PARCEL = B.CBI_PARCEL AND ';
    strSQL := strSQL + '                  R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                  R.CTR_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                  R.CTR_CODCLI = B.CBI_CODCLI AND ';
    strSQL := strSQL + '                  R.CTR_SEQBAI = 0 ';
    strSQL := strSQL + ' LEFT JOIN LOGNFE L ON L.NFE_NUMDOC = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '                       L.NFE_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '                       L.NFE_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '                       L.NFE_CODCLI = B.CBI_CODCLI AND ';
    strSQL := strSQL + '                       L.NFE_TIP_FC = "C" ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO ';

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

      Open;
    End;

    strCodBco  := '274';
    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.Text + edtNomArquivo.Text);
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      strHeader := '';


      strHeader := fPadR   ('0'                , 001)      + //001
                   fPadR   ('1'                , 001)      + //002
                   fPadR   ('REMESSA'          , 007)      + //003
                   fPadR   ('01'               , 002)      + //010
                   fPadR   ('COBRANCA'         , 015)      + //012
                   fPadL   (strEmpBco          , 020, '0') + //027
                   fPadR   (fTiracaracEspeciais(strNomEmp), 030)      + //047
                   fPadR   (strCodBco          , 003)      + //077
                   fPadR   (strNomBco          , 015)      + //080
                   fPadR   (strDtaRem          , 006)      + //095
                   fPadR   (' '                , 008)      + //101
                   fPadR   ('MX'               , 002)      + //109
                   fPadR   (strCodRem          , 007)      + //111
                   fPadR   (' '                , 277)      + //118
                   fStrZero('1'                , 006);       //395


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

        While Not Eof Do
        Begin

          strChvNfe := fRetornaChaveNfe(qryRemessa.FieldByName('NFE_ACESSO').AsString); //44 posicoes;

          If strUsaSac = 'S' Then
             strPos335_394 := strSacAva
          Else
          If strRespon = '1' Then
             strPos335_394 := strObserv
          Else
          Begin
            strPos335_394 := fPadL(' ',60);
            If Not fEmptyStr(strChvNfe) Then
               strPos335_394 := fPadL(strChvNfe, 60, ' ');
          End;

          strAvalista := '';

          If FieldByName('CBI_ESPDOC').AsString = 'AG' Then
            strObserv  := Trim(Copy(FieldByName('CBI_OBSAG1').AsString, 11, 60))
          Else
            strObserv  := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'OBSERV1', '');

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

          strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                       fPadR(FieldByName('CBI_PARCEL').AsString, 03) +
                       fPadR(FieldByName('CBI_ESPDOC').AsString, 02) +
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03);

          LDocumento := fPadR(RightStr(FieldByName('CBI_NUMDUP').AsString,7),7) +
                              RightStr(FieldByName('CBI_PARCEL').AsString,1) +
                              RightStr(FieldByName('CBI_ESPDOC').AsString,2);

          If (FieldByName('CBI_PARCEL').AsString.Length = 3) Then
            LDocumento := fPadR(RightStr(FieldByName('CBI_NUMDUP').AsString,5),5) +
                                RightStr(FieldByName('CBI_PARCEL').AsString,3) +
                                RightStr(FieldByName('CBI_ESPDOC').AsString,2);

          strCgcEmp := Trim(strCgcEmp);
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
          strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          {*******************************************}
          {* SE BANCO EMITE BOLETO                   *}
          {****************************************MV*}
          strNosNum := FieldByName('CBI_NOSNUM').AsString;
          If (strRespon = '1') Then
            strNosNum := '0';

          strIdeEmp := '0'                    + //021
                       RightStr(fStrZero(strCodCar, 3), 3) + //022
                       RightStr(fStrZero(strCodAge, 5), 5) + //025
                       RightStr(fStrZero(strCntCor, 7), 7) + //030
                       RightStr(fStrZero(strDigCnt, 1), 1);  //037


          strTransacao := fPadR      ('1'                                       , 01)      + //001
                          fStrZero   ('0'                                       , 05)      + //002
                          fPadR      (' '                                       , 01)      + //007
                          fStrZero   ('0'                                       , 05)      + //008
                          fStrZero   ('0'                                       , 07)      + //013
                          fPadR      (' '                                       , 01)      + //020
                          fPadR      (strIdeEmp                                 , 17)      + //021
                          fPadR      (strKeyDup                                 , 25)      + //038
                          fPadR      ('274'                                     , 03)      + //063
                          fPadR      (IIF(fltPerMul > 0, '2', '0')              , 01)      + //066 (2) P\ CONSIDERAR O PERCENTUAL DE MULTA
                          fValNumForm(fltPerMul                                 , 04)      + //067 PERCENTUAL DE MULTA A SER CONSIDERADO
                          fStrZero   (strNosNum                                 , 12)      + //071
                          fStrZero   ('0'                                       , 10)      + //083
                          fPadR      ('2'                                       , 01)      + //093
                          fPadR      ('N'                                       , 01)      + //094
                          fPadR      (' '                                       , 10)      + //095
                          fPadR      (' '                                       , 01)      + //105
                          fPadR      ('0'                                       , 01)      + //106
                          fPadR      (' '                                       , 02)      + //107
                          fPadR      ('01'                                      , 02)      + //109
                          fPadR      (LDocumento                                , 10)      + //111
                          fPadR      (strDtaVen                                 , 06)      + //121
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat         , 13)      + //127
                          fStrZero   ('0'                                       , 03)      + //140
                          fStrZero   ('0'                                       , 05)      + //143
                          fPadR      ('01'                                      , 02)      + //148
                          fPadR      ('N'                                       , 01)      + //150
                          fPadR      (strDtaEmi                                 , 06)      + //151
                          fPadR      ('00'                                      , 02)      + //157
                          fPadR      ('00'                                      , 02)      + //159
                          fValNumForm(fltValAtr                                 , 13)      + //161
                          fPadR      ('000000'                                  , 06)      + //174
                          fValNumForm(FieldByName('CBI_DESSUJ').AsFloat         , 13)      + //180
                          fStrZero   ('0'                                       , 13)      + //193
                          fStrZero   ('0'                                       , 13)      + //206
                          fStrZero   (strCpfCgc                                 , 02)      + //219
                          fPadL      (strCgcCli                                 , 14, '0') + //221
                          fPadR      (qryRemessa.FieldByName('CLI_NOMCLI').AsString        , 40)      + //235
                          fPadR      (qryRemessa.FieldByName('ENDERE').AsString            , 40)      + //275
                          fPadR      (' '                                       , 12)      + //315
                          fPadL      (LeftStr(FieldByName('C_E_P_').AsString,5) , 05, '0') + //327
                          fPadL      (RightStr(FieldByName('C_E_P_').AsString,3), 03, '0') + //332
                          strPos335_394 + //335 á 394
                          fStrZero   (IntToStr(intCodSeq)                       , 06);       //395

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);

          {************************************}
          {* QUANDO UTILIZAR SACADOR/AVALISTA *}
          {*********************************AJ*}
          {If strUsaSac = 'S' Then
          Begin
            Inc(intCodSeq);

            strAvalista := fPadR('7'                    , 001) + //001 - 001
                           fPadR(strSacEnd              , 045) + //001 - 046
                           fPadL(strSacCep, 008         , '0') + //047 - 054
                           fPadR(strSacCid              , 020) + //055 - 074
                           fPadR(strSacEst              , 002) + //075 - 076
                           fPadL(' '                    , 290) + //077 - 366
                           fPadL(strCodCar, 003         , '0') + //367 - 369
                           fPadL(strCodAge, 005         , '0') + //370 - 374
                           RightStr(fStrZero(strCntCor, 7), 7) +
                           RightStr(fStrZero(strDigCnt, 1), 1) +
                           fPadL(strNosNum, 012         , '0') + //383 - 394
                           fStrZero(IntToStr(intCodSeq) , 006);  //395 - 400

            Writeln(txtTexto,strAvalista);
          End; }

          Next;
        End;

      End;

      strCodBco := '274';
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

      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.Text + edtNomArquivo.Text, ['&O K']);

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

procedure TfrmExpArqRemBMPMoneyPlus_LP_400.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS'
  Else
    edtDesPor.Text := fRetNomPortador(edtCodPor.Text);
end;

procedure TfrmExpArqRemBMPMoneyPlus_LP_400.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strSQL : String;
    ArrSel: TConsultasArray;
begin
  inherited;

      strSQL := '';
      strSQL := strSQL + 'SELECT  ';
      strSQL := strSQL + '  POR_CODPOR AS "Código", ';
      strSQL := strSQL + '  POR_NOMPOR AS "Nome", ';
      strSQL := strSQL + '  AUTOINCREM  ';
      strSQL := strSQL + 'FROM  ';
      strSQL := strSQL + '  CADPOR  ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  TRUE ';

  If fEntraCons(Key) Then
  Begin

    Try

      Key := #0;


      If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, qryCadPor, Key, arrSel) then
      Begin
        edtCodPor.Text := qryCadPor.FieldByName('POR_CODPOR').AsString;
        Self.SelectNext((Sender As TWinControl), True, True);
      End;

    Finally

    End;

  End;
end;

function TfrmExpArqRemBMPMoneyPlus_LP_400.fRetEmpresa: String;
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
  {**************}
  {* 14/01/2011 *}
  {***********RV*}
  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);

  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;


procedure TfrmExpArqRemBMPMoneyPlus_LP_400.FormCreate(Sender: TObject);
begin
  inherited;
   qryCadPor := fCriaQuery(Self); 
end;

Function TfrmExpArqRemBMPMoneyPlus_LP_400.fRetornaChaveNfe(StrChvNfe : String) : String;
Begin

  Result := '';

  If (Not fEmptyStr(StrChvNfe)) then
     Result := fPadL(StrChvNfe, 044, '0') //401 - 444 CHAVE DA NF-E
  Else
     Result := fPadL(StrChvNfe, 044, ' ');//401 - 444 CHAVE DA NF-E

End;

end.
