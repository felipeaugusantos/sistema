unit untExpArqRemNossaCx;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, JvExMask,
  JvToolEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemNossaCx = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRemessa: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    fraPathRemessa: TfraDirectoryEditFocus;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    Label1: TLabel;
    btnGerar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;
    { Private declarations }
  public
    { Public declarations }
    strSimDes: String;
    intCartei: Integer;
    strNomForm : String;
    
  end;

var
  frmExpArqRemNossaCx: TfrmExpArqRemNossaCx;

implementation

uses untFuncoes, untfuncoesSimples, Data.DB;

{$R *.dfm}

procedure TfrmExpArqRemNossaCx.FormShow(Sender: TObject);
begin
  inherited;
  
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fArqIniAutban(0, 'CONFIG151-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'NCN' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         '1.TXT';
  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemNossaCx.btnGerarClick(Sender: TObject);
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
    {strEmpBco   : String;
    strNumAut   : String;}
    strCodAge   : String;
    strDigAge   : String;
    strCntCor   : String;
    strDigCnt   : String;
    strIdeEmp   : String;
    {strCodCar   : String;}
    strInsPro   : String;
    strDiaPro   : String;
    strCodMod   : String;
    strDtaHea   : String;
    strHorHea   : String;
    strCodCar   : String;
    
    strHeader   : String;
    strHeaderLot: String;
    strTransacao: String;
    strTrans2   : String;
    strTrailler : String;
    strTrailLot : String;
    strNosNum   : String;

    intCodSeq   : Integer;
    fltTaxEfe   : Double;
    fltTacTar   : Double;
    txtTexto    : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
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

  intCodSeq := 1;
  strCodBco := '151';
  strNomBco := 'NOSSA CAIXA-NOSSO BANCO';
  strNomEmp := fRetNomeEmpresa(VS_strCodEmp);
  strCodRem := fStrZero(fAtuCodSeq('CONFIG151-' + IntToStr(intCartei), 'PROXNUM'), 7);
  strCodAge := fArqIniAutban(0, 'CONFIG151-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAge := fArqIniAutban(0, 'CONFIG151-' + IntToStr(intCartei), 'DIGAGEN', '');
  strCodMod := fArqIniAutban(0, 'CONFIG151-' + IntToStr(intCartei), 'MODALID', '');
  strCntCor := fArqIniAutban(0, 'CONFIG151-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt := fArqIniAutban(0, 'CONFIG151-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar := fArqIniAutban(0, 'CONFIG151-' + IntToStr(intCartei), 'CODCART', '');
  fltTaxEfe := fStrToFloat(fArqIniAutban(0, 'CONFIG151-' + IntToStr(intCartei), 'TAXAEFE', ''));
  fltTacTar := fStrToFloat(fArqIniAutban(0, 'CONFIG151-' + IntToStr(intCartei), 'TACTARC', ''));
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yy',VS_Date);
  strDtaHea  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorHea  := FormatDateTime('hh',Time) + FormatDateTime('mm',Time) + FormatDateTime('ss',Time);
  blnRemLoc  := Not( fArqIniAutban(0, 'CONFIG409', 'RELOCAL', '') = 'N' );
                 
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


  If strSimDes = 'S' Then
  Begin
    strInsPro := '06';
    strDiaPro := fStrZero(fArqIniAutban(1, 'CONFIG151-' + IntToStr(intCartei), 'DIAPROT', ''),2);
  End
  Else
  Begin
    strInsPro := '00';
    strDiaPro := '00';
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
      strSQL := strSQL + '  AND LOCATE(CBI_CODPOR, ' +  QuotedStr(strPortadoresOperador) + ') > 0 ';

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

      strCgcEmp := Trim(strCgcEmp);
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      strHeader := '';
      strHeader := fPadR   (strCodBco          , 03) + //001 a 003
                   fStrZero('0'                , 04) + //004 a 007
                   fPadR   ('0'                , 01) + //008 a 008
                   fPadR   (' '                , 09) + //009 a 017
                   fPadR   ('2'                , 01) + //018 a 018
                   fStrZero(strCgcEmp          , 14) + //019 a 032
                   fPadR   (' '                , 20) + //033 a 052

                   fPadR   ('0'                , 01) + //053 a 053 *************** Primeira Posição
                   fStrZero(strCodAge          , 04) + //054 a 057 *   053 a 058 * Número da Agência
                   fStrZero(strDigAge          , 01) + //058 a 058 *************** Dígito da Agência

                   fPadR   ('0000'             , 04) + //059 a 062 *************** preencher com 0
                   fStrZero(strCodMod          , 02) + //063 a 064 *   059 a 071 * Modalidade
                   fStrZero(strCntCor          , 06) + //065 a 070 *             * Número
                   fStrZero(strDigCnt          , 01) + //071 a 071 *************** Dígito
                   fPadR   (' '                , 01) + //072 a 072
                   fPadR   (strNomEmp          , 30) + //073 a 102
                   fPadR   (strNomBco          , 30) + //103 a 132
                   fPadR   (' '                , 10) + //133 a 142
                   fPadR   ('1'                , 01) + //143 a 143
                   fPadR   (strDtaHea          , 08) + //144 a 151
                   fPadR   (strHorHea          , 06) + //152 a 157
                   fPadR   (strCodRem          , 06) + //158 a 163
                   fPadR   ('020'              , 03) + //164 a 166
                   fStrZero('0'                , 05) + //167 a 171
                   fPadR   (' '                , 69);  //172 a 240

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {******************}
      {* HEADER DE LOTE *}
      {***************AF*}

      If (strSimDes = 'S') And (strCodCar <> '03') And (strCodCar <> '04') Then
        strHorHea := fPadR(' ',33)
      Else
      Begin
        strHorHea := FormatDateTime('dd',VS_Date) +
                     FormatDateTime('mm',VS_Date) +
                     FormatDateTime('hh',Time) +
                     FormatDateTime('mm',Time) +
                     FormatDateTime('ss',Time);
        strHorHea := strDtaHea;
        strHorHea := fPadR(' ', 15);
      End;

      strHeaderLot := '';
      strHeaderLot := fPadR   (strCodBco          , 03) + //001 a 003
                      fStrZero('1'                , 04) + //004 a 007
                      fPadR   ('1'                , 01) + //008 a 008
                      fPadR   ('R'                , 01) + //009 a 009
                      fPadR   ('01'               , 02) + //010 a 011
                      fPadR   ('00'               , 02) + //012 a 013
                      fPadR   ('020'              , 03) + //014 a 016
                      fPadR   (' '                , 01) + //017 a 017
                      fPadR   ('2'                , 01) + //018 a 018
                      fPadR   ('0'                , 01) + //019 a 019 * ************** * Primeira Posicao com 0
                      fStrZero(strCgcEmp          , 14) + //020 a 033 *    019 a 033   * CNPJ da Empresa
                      fPadR   (' '                , 20) + //034 a 053

                      fPadR   ('0'                , 01) + //054 a 055 * ************** * Primeira Posição com 0
                      fStrZero(strCodAge          , 04) + //056 a 058 *    054 a 059   * Número da Agência
                      fStrZero(strDigAge          , 01) + //059 a 059 * ++++++++++++++ * Dígito da Agência

                      fPadR   ('0000'             , 04) + //060 a 063 * ************** * Preencher com Zeros
                      fStrZero(strCodMod          , 02) + //064 a 065 *                * Modalidade
                      fStrZero(strCntCor          , 06) + //066 a 071 *    060 a 072   * Número
                      fStrZero(strDigCnt          , 01) + //072 a 072 * ************** * Dígito
                      fPadR   (' '                , 01) + //073 a 073
                      fPadR   (strNomEmp          , 30) + //074 a 103
                      fStrZero('0'                , 03) + //104 a 106
                      fStrZero('0'                , 03) + //107 a 109
                      fPadR   (' '                , 40) + //110 a 149
                      fPadR   (' '                , 34) + //150 a 183
                      fStrZero('1'                , 08) + //184 a 191
                      fPadR   (strDtaHea          , 08) + //192 a 199
                      fStrZero('0'                , 08) + //200 a 207
                      fPadR   (strHorHea          , 33);  //208 a 240

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeaderLot);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin
          Application.ProcessMessages;

          If FieldByName('CBI_CGCCPF').AsInteger = 0 Then
            strCpfCgc := '0'
          Else If FieldByName('CBI_CGCCPF').AsInteger = 1 Then
            strCpfCgc := '2'
          Else
            strCpfCgc := '1';

          strDtaVen := FormatDateTime('dd',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTAVEN').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('dd',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('mm',FieldByName('CBI_DTACAD').AsDateTime) +
                       FormatDateTime('yyyy',FieldByName('CBI_DTACAD').AsDateTime);

          strKeyDup := FieldByName('CBI_NUMDUP').AsString +
                       FieldByName('CBI_PARCEL').AsString +
                       FieldByName('CBI_ESPDOC').AsString +
                       FieldByName('CBI_CODEMP').AsString +
                       FieldByName('CBI_CODCLI').AsString;

          strCgcCli := Trim(FieldByName('CBI_C_G_C_').AsString);
          strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
          strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

          If CharInSet(strCodCar[1], ['1','3','4']) Then
            strNosNum := '0'
          Else
            strNosNum := FieldByName('CBI_NOSNUM').AsString;

          If strCodCar = '4' Then
            strIdeEmp := fValNumForm(fltTaxEfe, 07, 4) +
                         fStrZero('201'       , 03)    +
                         fValNumForm(fltTacTar, 05)    +
                         fPadR(' '            , 15)
          Else
            strIdeEmp := fPadR(' ',30);

          {***********}
          {* LINHA 1 *}
          {********AF*}
          strTransacao := fPadR      (strCodBco                                 , 03) + //001 a 003
                          fStrZero   ('1'                                       , 04) + //004 a 007
                          fPadR      ('3'                                       , 01) + //008 a 008
                          fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 a 013
                          fPadR      ('P'                                       , 01) + //014 a 014
                          fPadR      (' '                                       , 01) + //015 a 015
                          fPadR      ('01'                                      , 02) + //016 a 017
                          fPadR      ('0'                                       , 01) + //018 a 018 * *********** * Primeira Posição 0
                          fStrZero   (strCodAge                                 , 04) + //019 a 022 *  018 a 023  * Número Agência
                          fStrZero   (strDigAge                                 , 01) + //023 a 023 * *********** * Dígito Agência
                          fStrZero   ('0'                                       , 04) + //024 a 027 * *********** * 4 primeiras posições com 0
                          fStrZero   (strCodMod                                 , 02) + //028 a 029 *  024 a 036  * Modalidade
                          fStrZero   (strCntCor                                 , 06) + //030 a 035 *             * Número
                          fStrZero   (strDigCnt                                 , 01) + //036 a 036 * *********** * Dígito
                          fPadR      (' '                                       , 05) + //037 a 041
                          fStrZero   ('0'                                       , 06) + //042 a 047
                          fStrZero   (strNosNum                                 , 10) + //048 a 057
                          fPadR      (strCodCar                                 , 02) + //058 a 059
                          fPadR      ('1'                                       , 01) + //060 a 060
                          fPadR      ('1'                                       , 01) + //061 a 061
                          fPadR      ('0'                                       , 01) + //062 a 062
                          fPadR      (' '                                       , 03) + //063 a 065
                          fStrZero   (FieldByName('CBI_NUMDUP').AsString        , 13) + //066 a 078
                          fStrZero   (strDtaVen                                 , 08) + //079 a 086
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat         , 15) + //087 a 101
                          fStrZero   ('0'                                       , 06) + //102 a 107
                          fPadR      ('02'                                      , 02) + //108 a 109
                          fPadR      ('N'                                       , 01) + //110 a 110
                          fPadR      (strDtaEmi                                 , 08) + //111 a 118
                          fPadR      ('1'                                       , 01) + //119 a 119
                          fPadR      (' '                                       , 08) + //120 a 127
                          fValNumForm(FieldByName('CBI_PORCEN').AsFloat         , 15) + //128 a 142
                          fPadR      ('0'                                       , 01) + //143 a 143
                          fStrZero   ('0'                                       , 08) + //144 a 151
                          fStrZero   ('0'                                       , 15) + //152 a 166
                          fPadR      (strIdeEmp                                 , 30) + //167 a 196
                          fPadR      (strKeyDup                                 , 25) + //197 a 221
                          fPadR      (' '                                       , 01) + //222 a 222
                          fStrZero   (strDiaPro                                 , 02) + //223 a 224
                          fPadR      (' '                                       , 04) + //225 a 228
                          fPadR      ('01'                                      , 02) + //229 a 230
                          fPadR      (' '                                       , 03) + //231 a 233
                          fStrZero   ('0'                                       , 03) + //234 a 236
                          fPadR      (' '                                       , 04);  //237 a 240

          Inc(intCodSeq);
          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTransacao);

          {***********}
          {* LINHA 2 *}
          {********AF*}
          strTrans2 := '';
          strTrans2 := fPadR      (strCodBco                                 , 03) + //001 a 003
                       fStrZero   ('1'                                       , 04) + //004 a 007
                       fPadR      ('3'                                       , 01) + //008 a 008
                       fStrZero   (IntToStr(intCodSeq)                       , 05) + //009 a 013
                       fPadR      ('Q'                                       , 01) + //014 a 014
                       fPadR      (' '                                       , 01) + //015 a 015
                       fPadR      ('01'                                      , 02) + //016 a 017
                       fStrZero   (strCpfCgc                                 , 01) + //018 a 018
                       fPadR      ('0'                                       , 01) + //019 a 019 * *********** * Primeiro Dígito com 0
                       fPadR      (strCgcCli                                 , 14) + //020 a 033 *  019 a 033  * CNPJ Sacado
                       fPadR      (FieldByName('CLI_NOMCLI').AsString        , 40) + //034 a 073
                       fPadR      (FieldByName('ENDERE').AsString            , 40) + //074 a 113
                       fPadR      (FieldByName('BAIRRO').AsString            , 15) + //114 a 128
                       fStrZero   (FieldByName('C_E_P_').AsString            , 08) + //129 a 136 Obs : CEP do Socado + Sufixo do Sacado
                       fPadR      (FieldByName('CIDADE').AsString            , 15) + //137 a 151
                       fPadR      (FieldByName('ESTADO').AsString            , 02) + //152 a 153
                       fPadR      ('2'                                       , 01) + //154 a 154
                       fPadR      ('0'                                       , 01) + //155 a 155 * *********** * Primeiro Dígito com 0
                       fPadR      (strCgcEmp                                 , 14) + //156 a 169 *  019 a 033  * CNPJ Sacador
                       fPadR      (strNomEmp                                 , 40) + //170 a 209
                       fPadR      (' '                                       , 31);  //210 a 240

          Inc(intCodSeq);
          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AF*}
          Writeln(txtTexto,strTrans2);

          Next;
        End;

      End;

      {********************}
      {* TRAILLER DE LOTE *}
      {*****************AF*}
      strTrailler := '';
      strTrailler := fPadR   (strCodBco              , 003) +
                     fStrZero('1'                    , 004) +
                     fPadR   ('5'                    , 001) +
                     fPadR   (' '                    , 009) +
                     fStrZero(IntToStr(intCodSeq + 1), 006) +
                     fPadR   (' '                    , 217);

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(txtTexto,strTrailler);

      {********************}
      {* TRAILLER DE LOTE *}
      {*****************AF*}
      strTrailLot := '';
      strTrailLot := fPadR   (strCodBco              , 003) +
                     fPadR   ('9999'                 , 004) +
                     fPadR   ('9'                    , 001) +
                     fPadR   (' '                    , 009) +
                     fStrZero('1'                    , 006) +
                     fStrZero(IntToStr(intCodSeq + 3), 006) +
                     fStrZero('0'                    , 006) +
                     fPadR   (' '                    , 205);

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
      Writeln(txtTexto,strTrailLot);

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

procedure TfrmExpArqRemNossaCx.edtCodPorExit(Sender: TObject);
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

procedure TfrmExpArqRemNossaCx.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlIndicePor: TStringList;
    stlDesIndPor: TStringList;
    strSQL : String;
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

function TfrmExpArqRemNossaCx.fRetEmpresa: String;
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


procedure TfrmExpArqRemNossaCx.FormCreate(Sender: TObject);
begin
  inherited;
     qryCadPor := fCriaQuery(Self);

end;

end.

