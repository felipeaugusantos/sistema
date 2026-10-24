unit untExpArqRemCxFed7D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untFrameDirectoryEditFocus, untFrameCheckComboBoxEmpresa;

type
  TfrmExpArqRemCxFed7D = class(TfrmPai)
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

   ///BEGIN DADOS CARTEIRA///
    strProAce  : String;
    strEmiBol  : String;
    strEnvBol  : String;
    strCodBco  : String;
    strNomBco  : String;
    strNomEmp  : String;
    strDtaRem  : String;
    strHorRem  : String;
    strCodRem  : String;
    strDtaVen  : String;
    strDtaEmi  : String;
    strDtaJur  : String;
    strDtaMul  : String;
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
    strCodPro  : String;
    strDiaPro  : String;
    strNosNum  : String;
    strBaiDev  : String;
    strCodCarRem: String;
    strHeader  : String;
    strHeaLot  : String;
    strSegP    : String;
    strSegQ    : String;
    strSegR    : String;
    strTraLot  : String;
    strTraArq  : String;
    strCodCar  : String;
    strDiasDev : String;
    strVerArq  : String;
    strVerLot  : String;
    strPerMul  : String;
    strObs001  : String;
    strObs002  : String;
    strObs003  : String;
    strObs004  : String;
    intSeqLot  : Integer;
    intSeqUen  : Integer;
    txtTexto   : TextFile;
    strNovCodEmp: String;
    blnRemLoc   : Boolean;
    qryRemessa : TUniQuery;
    strJurosDia: String;
    intQtdReg  : Integer;
    fltTotCob  : Double;
    strSisCob  : String;
    dtaDtaJur  : TDateTime;
    fltMorDia  : Double;
    fltPerMul  : Double;
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
    AstrEndereco    : String;
   // END DADOS CARTEIRA //

    qryCadPor      : TUniQuery;
    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;
    function fPreparaExportacao : Boolean;
    procedure pCarregaInformacoesCarteira;
    procedure pGravaLogctr;
    function fGetSqlRemessa: String;
    function fCriarQueryRemessa : TUniQuery;
    procedure pValidaInformacoesDetalhe;
    procedure pGerarRemessaSIGCB;
    procedure pGerarSegmentoR;
    procedure pValidaCGCCPF;
    procedure pValidaProtesto;
    procedure pValidaEspecie;
    procedure pAtualizaOcoCrm;
    procedure pValidaDescontoPontualidadeDetalhe;
    procedure pValidaEmpresa;
    procedure pValidaDescontoPontualidadeCarteira;
    procedure pValidaDataDesconto;
    function fUsaDescontoPontualidadeCliente: boolean;
    function fUsaDescontoPontualidadeCnd: boolean;
    function fUtilizaCrm : Boolean;

    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmExpArqRemCxFed7D: TfrmExpArqRemCxFed7D;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutBan, DB, untTypesSistema, untConsultas,
     untConstantes, untLogCtr, untAtualizaOcorrenciasCRM, untTypesCRM;

{$R *.dfm}

function TfrmExpArqRemCxFed7D.fUtilizaCrm: boolean;
Begin
  Result := True;
 If Not fCfgSis('UTICRM', varBoolean) Then
   Result := False;
 If(fEmptyStr(fCfgSis('OCOFIN', varString))) Then
   Result := False;;
End;

function TfrmExpArqRemCxFed7D.fUsaDescontoPontualidadeCnd: boolean;
Begin
  Result := True;
 If Not blnUsaCnd Then
   Result := False;
 If Not blnUsaDesPon Then
   Result := False;
End;

function TfrmExpArqRemCxFed7D.fUsaDescontoPontualidadeCliente: boolean;
Begin
  Result := True;
 If Not blnUsaDesPonCli Then
   Result := False;
 If Not blnUsaDesPon Then
   Result := False;
End;

procedure TfrmExpArqRemCxFed7D.pValidaDataDesconto;
Begin
  If fltValDpo > 0 Then
  Begin
    dtaDtaDpo := qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime - qryRemessa.FieldByName('CLI_QTDDAV').AsInteger;
    strDtaDpo := FormatDateTime('ddmmyyyy', dtaDtaDpo);
  End
  Else
    strDtaDpo := '00000000';
End;

procedure TfrmExpArqRemCxFed7D.pValidaDescontoPontualidadeCarteira;
Begin
  If fCfgSis('DESPON', varBoolean) Then
      blnUsaDesPonCli := (fCfgSis('TDEPON') = '2')
  else
    blnUsaDesPonCli := False;

  If fCfgSis('DESPON', varBoolean) Then
    blnUsaDesPon := True
  Else
    blnUsaDesPon := False;
End;

procedure TfrmExpArqRemCxFed7D.pValidaEmpresa;
Begin
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
End;

procedure TfrmExpArqRemCxFed7D.pValidaDescontoPontualidadeDetalhe;
Begin

  If fUsaDescontoPontualidadeCliente Then
  begin
    fltValDpo := qryRemessa.FieldByName('CLI_PERDPO').AsFloat;
    pValidaDataDesconto;
  end
  else
  If fUsaDescontoPontualidadeCnd Then
  Begin
    fltValDpo := qryRemessa.FieldByName('CND_PERDPO').AsFloat;

    If fltValDpo > 0 Then
    Begin
      dtaDtaDpo := qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime - qryRemessa.FieldByName('CND_QTDDAV').AsInteger;
      strDtaDpo := FormatDateTime('ddmmyyyy', dtaDtaDpo);
    End
    Else
      strDtaDpo := '00000000';
  End
  Else
  Begin
    fltValDpo := 0;
    strDtaDpo := '00000000';
  End;

End;

procedure TfrmExpArqRemCxFed7D.pAtualizaOcoCrm;
Begin
  If fUtilizaCrm Then
  Begin
    TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(qryRemessa.FieldByName('CBI_NUMDUP').AsString,
                                             qryRemessa.FieldByName('CBI_ESPDOC').AsString,
                                             qryRemessa.FieldByName('CBI_CODEMP').AsString,
                                             qryRemessa.FieldByName('CBI_CODCLI').AsString,
                                             qryRemessa.FieldByName('CBI_PARCEL').AsString,
                                             strLoginUsuarioLogado,
                                             fRetCgcCpf(qryRemessa.FieldByName('CBI_CODCLI').AsString),
                                             afcEnviaDuplicataBanco);
  End;
End;

procedure TfrmExpArqRemCxFed7D.pGerarSegmentoR;
Begin
  If (strSisCob = 'SIGCB') Then
  Begin
    If fEmptyStr(strPerMul) Then
      Exit;

    Inc(intSeqUen);
    Inc(intSeqLot);

    strSegR := fPadR   ('104'                                    , 03) + //001 a 003
               fPadR   ('0001'                                   , 04) + //004 a 007
               fPadR   ('3'                                      , 01) + //008 a 008
               fStrZero(IntToStr(intSeqUen)                      , 05) + //009 a 013
               fPadR   ('R'                                      , 01) + //014 a 014
               fPadR   (' '                                      , 01) + //015 a 015
               fPadR   ('01'                                     , 02) + //016 a 017
               fPadR   ('0'                                      , 01) + //018 a 018
               fPadR   ('0'                                 , 08, '0') + //019 a 026
               fPadR   ('0'                                 , 15, '0') + //027 a 041
               fPadR   ('0'                                      , 01) + //042 a 042
               fPadR   ('0'                                 , 08, '0') + //043 a 050
               fPadR   ('0'                                 , 15, '0') + //051 a 065
               fPadR   ('2'                                      , 01) + //066 a 066
               fPadR   (strDtaMul                                , 08) + //067 a 074
               fPadL   (strPerMul                            , 15,'0') + //075 a 089
               fPadR   (' '                                      , 10) + //090 a 099
               fPadR   (strObs003                                , 40) + //100 a 139
               fPadR   (strObs004                                , 40) + //140 a 179
               fPadR   (' '                                      , 50) + //180 a 229
               fPadR   (' '                                      , 11) ; //230 a 240

    {*******************************}
    {* ESCREVE O SEGMENTO R NO TXT *}
    {****************************JU*}
    Writeln(txtTexto,fRetirarCaracteresEspeciais(strSegR));
  End;

  If (strSisCob = 'SICOB') Then
  Begin

    If fEmptyStr(strPerMul) Then
      Exit;

    Inc(intSeqUen);
    Inc(intSeqLot);

    strSegR := fPadR   ('104'                                    , 03) + //001 a 003
               fPadR   ('0001'                                   , 04) + //004 a 007
               fPadR   ('3'                                      , 01) + //008 a 008
               fStrZero(IntToStr(intSeqUen)                      , 05) + //009 a 013
               fPadR   ('R'                                      , 01) + //014 a 014
               fPadR   (' '                                      , 01) + //015 a 015
               fPadR   ('01'                                     , 02) + //016 a 017
               fPadR   (' '                                      , 48) + //018 a 065
               fPadR   ('2'                                      , 01) + //066 a 066
               fPadR   (strDtaMul                                , 08) + //067 a 074
               fPadL   (strPerMul                            , 15,'0') + //075 a 089
               fPadR   (' '                                      , 10) + //090 a 099
               fPadR   (strObs003                                , 40) + //100 a 139
               fPadR   (strObs004                                , 40) + //140 a 179
               fPadR   (' '                                      , 50) + //180 a 229
               fPadR   (' '                                      , 11) ; //230 a 240

            {*******************************}
            {* ESCREVE O SEGMENTO R NO TXT *}
            {****************************JU*}
    Writeln(txtTexto,fRetirarCaracteresEspeciais(strSegR));

  End;

End;

procedure TfrmExpArqRemCxFed7D.pValidaEspecie;
Begin
  if not TEspecieParaArquivoRemessa.New.fValidaEspecie(qryRemessa.FieldByName('CBI_ESPDOC').AsString) then
  begin
    fRollBack;
    CloseFile(txtTexto);
    If FileExists(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text) Then
      DeleteFile(fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
    Exit;
  end;
End;

procedure TfrmExpArqRemCxFed7D.pValidaProtesto;
Begin
  If (qryRemessa.FieldByName('CBI_PROTES').AsString = 'S') Then
  Begin
    strCodPro := '1';
    strBaiDev := '2';
    strDiasDev:= fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIASDEV', '');
    strDiaPro := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIAPROT', '');
  End
  Else
  Begin
    strBaiDev := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'BAIXDEV', '');
    strDiasDev:= fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIASDEV', '');

    If strBaiDev = '1' Then
    Begin
      strCodPro := '3';
      strDiaPro := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIAPROT', '');
    End
    Else
    Begin
      strCodPro := '1';
      strDiaPro := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIAPROT', '');
    End;
  End;
End;

procedure TfrmExpArqRemCxFed7D.pValidaCGCCPF;
Begin
  If qryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 1 Then
    strCpfCgc := '2'
  Else
    strCpfCgc := '1';

  If strCpfCgc = '2' Then
    strCgcEmp := fStrZero(strCgcEmp,15)
  Else
    strCgcEmp := Copy(strCgcEmp, 4, 9) + '0000' + RightStr(strCgcEmp, 2);
End;

procedure TfrmExpArqRemCxFed7D.pGerarRemessaSIGCB;
  Var
    strSQL : String;
Begin
  inherited;
  strCodCarRem := '';

  If Not fPreparaExportacao Then
    Exit;

  strCodBco  := '104';
  strNomBco  := 'CAIXA ECONOMICA FEDERAL';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);

  strCodCar  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'NUMCART', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIGAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDConCor := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodConv := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'CODCONV', '');
  strDigVeri := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIGVERI', '');

  pCarregaInformacoesCarteira;
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

    qryConsultaGen.Close;
    qryConsultaGen.SQL.Clear;
    qryConsultaGen.SQL.Add(strSQL);
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strCgcEmp := fTiraCaracEspeciais(qryConsultaGen.FieldByName('EMP_C_G_C_').AsString,True,False,True);
    qryConsultaGen.Close;

    strCartei  := 'CONFIG1047D-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriarQueryRemessa;

    If qryRemessa.IsEmpty Then
    Begin
      fRollBack;
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
      Exit;
    End;
    strCodRem  := fStrZero(fAtuCodSeq('CONFIG1047D', 'PROXNUM'), 8);

    AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
    strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
    Rewrite(txtTexto);

      {**********************}
      {* HEADER DO ARQUIVO  *}
      {* REGISTRO DO TIPO 0 *}
      {*******************LB*}
    strHeader := '';

    strHeader := fPadR   (strCodBco              , 003) + //001 a 003
                 fStrZero('0000'                 , 004) + //004 a 007
                 fPadR   ('0'                    , 001) + //008 a 008
                 fPadR   (' '                    , 009) + //009 a 017
                 fPadR   ('2'                    , 001) + //018 a 018
                 fStrZero(strCgcEmp              , 014) + //019 a 032
                 fPadR   ('0',                020, '0') + //033 a 052
                 fStrZero(strCodAgen             , 005) + //053 a 057
                 fPadR   (strDigAgen             , 001) + //058 a 058
                 fPadR   (strCodConv             , 007,'0') + //059 a 065
                 fPadR   ('0'               , 006, '0') + //066 a 071
                 fPadR   ('0'                    , 001) + //072 a 072
                 fPadR   (strNomEmp              , 030) + //073 a 102
                 fPadR   (strNomBco              , 030) + //103 a 132
                 fPadR   (' '                    , 010) + //133 a 142
                 fPadR   ('1'                    , 001) + //143 a 143
                 fPadR   (strDtaRem              , 008) + //144 a 151
                 fPadR   (strHorRem              , 006) + //152 a 157
                 fPadR   (RightStr(strCodRem, 6) , 006) + //158 a 163
                 fPadR   (strVerArq              , 003) + //164 a 166
                 fStrZero('0'                    , 005) + //167 a 171
                 fPadR   (' '                    , 020) + //172 a 191
                 fPadR   ('REMESSA-PRODUCAO'     , 020) + //192 a 211
                 fPadR   (' '                    , 029);  //212 a 240

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************LB*}
      Writeln(txtTexto,strHeader);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
    pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG1047D_240p-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {**********************}
      {* HEADER DO LOTE     *}
      {* REGISTRO DO TIPO 1 *}
      {*******************LB*}
    strHeaLot := '';

    strHeaLot := fPadR   (strCodBco              , 003) + //001 a 003
                 fPadR   ('0001'                 , 004) + //004 a 007
                 fPadR   ('1'                    , 001) + //008 a 008
                 fPadR   ('R'                    , 001) + //009 a 009
                 fPadR   ('01'                   , 002) + //010 a 011
                 fPadR   ('00'                   , 002) + //012 a 013
                 fPadR   (strVerLot              , 003) + //014 a 016
                 fPadR   (' '                    , 001) + //017 a 017
                 fPadR   ('2'                    , 001) + //018 a 018
                 fStrZero(strCgcEmp              , 015) + //019 a 033
                 fPadR   (strCodConv             , 007,'0') + //034 a 040
                 fPadR   ('0'               , 013, '0') + //041 a 053
                 fStrZero(strCodAgen             , 005) + //054 a 058
                 fPadR   (strDigAgen             , 001) + //059 a 059
                 fPadR   (IIF(Length(strCodConv) = 6,strCodConv,'0'), 006,'0') + //060 a 065
                 fPadR   ('0'               , 007, '0') + //066 a 072
                 fPadR   ('0'                    , 001) + //073 a 073
                 fPadR   (strNomEmp              , 030) + //074 a 103
                 fPadR   (strObs001              , 040) + //104 a 143
                 fPadR   (strObs002              , 040) + //144 a 183
                 fPadR   (strCodRem              , 008) + //184 a 191
                 fPadR   (strDtaRem              , 008) + //192 a 199
                 fStrZero('00000000'             , 008) + //200 a 207
                 fPadR   (' '                    , 033);  //208 a 240

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************LB*}
    Writeln(txtTexto,fRetirarCaracteresEspeciais(strHeaLot));



    intSeqLot := 1;
    intSeqUen := 1;
    intQtdReg := 0;
    fltTotCob := 0;

    While Not qryRemessa.Eof Do
    Begin
      intQtdReg := intQtdReg + 1;
      fltTotCob := fltTotCob + qryRemessa.FieldByName('CBI_VALDUP').AsFloat;

      Application.ProcessMessages;

          {***********************}
          {* REGISTRO DE DETALHE *}
          {* REGISTRO DO TIPO3   *}
          {********************LB*}
      strDtaVen := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                   FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                   FormatDateTime('yyyy',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);

      strDtaEmi := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                   FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                   FormatDateTime('yyyy',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime);

      dtaDtaJur := qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime + 1;

      strDtaJur := FormatDateTime('dd',dtaDtaJur) +
                   FormatDateTime('mm',dtaDtaJur) +
                   FormatDateTime('yyyy',dtaDtaJur);

      strDtaMul   := strDtaJur;

      pValidaEspecie;

      strNumDup := qryRemessa.FieldByName('CBI_NUMDUP').AsString + qryRemessa.FieldByName('CBI_PARCEL').AsString;

      strKeyDup := fPadR(qryRemessa.FieldByName('CBI_NUMDUP').AsString, 12) +
                   fPadR(qryRemessa.FieldByName('CBI_PARCEL').AsString, 03) +
                   fPadR(qryRemessa.FieldByName('CBI_ESPDOC').AsString, 02) +
                   fPadR(qryRemessa.FieldByName('CBI_CODEMP').AsString, 03);

          //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
      AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

      strCgcEmp := Trim(strCgcEmp);
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

      strCgcCli := Trim(qryRemessa.FieldByName('CBI_C_G_C_').AsString);
      strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
      strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
      strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

      strNosNum := RightStr(qryRemessa.FieldByName('CBI_NOSNUM').AsString,11);

      fltValDup := qryRemessa.FieldByName('CBI_VALDUP').AsFloat;

      pValidaInformacoesDetalhe;

          {**********************************}
          {* REGISTRO DE DETALHE SEGMENTO P *}
          {*******************************LB*}

      strSegP := fPadR      (strCodBco                         , 03)     + //001 a 003
                 fStrZero   ('1'                               , 04)     + //004 a 007
                 fPadR      ('3'                               , 01)     + //008 a 008
                 fStrZero   (IntToStr(intSeqUen)               , 05)     + //009 a 013
                 fPadR      ('P'                               , 01)     + //014 a 014
                 fPadR      (' '                               , 01)     + //015 a 015
                 fPadR      ('01'                              , 02)     + //016 a 017
                 fStrZero   (strCodAgen                        , 05)     + //018 a 022
                 fPadR      (strDigAgen                        , 01)     + //023 a 023
                 fPadR      (strCodConv                        , 07,'0')     + //024 a 030
                 fPadR      ('0'                          , 10, '0')     + //031 a 040
                 fPadR      (IIF(strEmiBol = '1', '0',strCodCar),02,'0') + //041 a 042
                 fPadL      (IIF(strCodCarRem = '0','0',LeftStr(strNosNum, 10)), 15, '0') + //043 a 057
                 fPadR      ('1'                         , 01)     + //058 a 058 // (1)SIMPLES (3) CAUCIONADA (4)DESCONTADA
                 fPadR      (LeftStr(strCodCar, 01)            , 01)     + //059 a 059 // (1)REGISTRADA (2)SEM REGISTRO
                 fPadR      ('2'                         , 01)     + //060 a 060 // FIXO
                 fPadR      (strEmiBol                   , 01)     + //061 a 061 // (1)BANCO EMITE (2) CLIENTE EMITE
                 fPadR      (strEnvBol                   , 01)     + //062 a 062 // (1)SACADO VIA CORREIOS (2)CEDENTE VIA AGÊNCIA CAIXA (3)SACADO VIA E-MAIL (4)SACADO VIA SMS
                 fPadR      (RightStr(strNumDup, 11)           , 11)     + //063 a 073
                 fPadR      (' '                         , 04)     + //074 a 077
                 fPadR      (strDtaVen                   , 08)     + //078 a 085
                 fValNumForm(fltValDup                   , 15)     + //086 a 100
                 fStrZero   ('00000'                     , 05)     + //101 a 105
                 fPadR      ('0'                         , 01)     + //106 a 106
                 fPadR      ('02'                        , 02)     + //107 a 108 // (02)DM - DUPLICATA
                 fPadR      (IIF(strProAce = 'S', 'A','N')     , 01)     + //109 a 109
                 fPadR      (strDtaEmi                   , 08)     + //110 a 117
                 fPadR      (IIF(fltMorDia > 0,'1','3')        , 01)     + //118 a 118 |     //CÓDIGO (1) VALOR (2) PERCENTUAL (3) ISENTO
                 IIF(fltMorDia>0,fStrZero(strDtaJur, 08),'00000000')     + //119 a 126 |MORA //DATA DE INÍCNIO DA COBRANÇA
                 fValNumForm(fltMorDia                   , 15)     + //127 a 141 |     //VALOR OU PERCENTUAL A SER COBRADO
                 fPadR      (IIF(fltValDpo > 0,'2','0')        , 01)     + //142 a 142
                 fPadL      (IIF(blnUsaDesPon,strDtaDpo,'00000000'),08)     + //143 a 150
                 fValNumForm(fltValDpo                   , 15)     + //151 a 165
                 fStrZero   ('0'                         , 15)     + //166 a 180
                 fStrZero   ('0'                         , 15)     + //181 a 195
//                 fPadR      (strKeyDup                   , 11)     +
//                 fPadR      (' '                         , 14)     + //196 a 220 ******APENAS PRA HOMOLOGAR ******
                 fPadR      (strKeyDup                   , 25)     + //196 a 220
                 fPadR      (strCodPro                   , 01)     + //221 a 221 // (1)PROTESTAR (3)NAO PROTESTAR (9) CANCELAMENTO DE PROTESTO
                 fPadL      (strDiaPro                     , 02,'0')     + //222 a 223
                 fPadR      (strBaiDev                   , 01)     + //224 a 224 // (1)BAIXAR/DEVOLVER (2)NÃO BAIXAR/NÃO DEVOLVER
                 fPadR      (IIF((strCodPro = '3'),fstrZero(strDiasDev,3),'0'), 03,'0')+ //225 a 227
                 fPadL      ('09'                        , 02)     + //228 a 229
                 fPadR      ('0'                    , 10, '0')     + //230 a 239
                 fPadR      (' '                         , 01);      //240 a 240
          {*******************************}
          {* ESCREVE O SEGMENTO P NO TXT *}
          {****************************AF*}
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strSegP));

      Inc(intSeqUen);
      Inc(intSeqLot);

          {**********************************}
          {* REGISTRO DE DETALHE SEGMENTO Q *}
          {*******************************AF*}
      strSegQ := fPadR   (strCodBco                          , 03) + //001 a 003
                 fStrZero('1'                                , 04) + //004 a 007
                 fPadR   ('3'                                , 01) + //008 a 008
                 fStrZero(IntToStr(intSeqUen)                      , 05) + //009 a 013
                 fPadR   ('Q'                                , 01) + //014 a 014
                 fPadR   (' '                                , 01) + //015 a 015
                 fPadR   ('01'                               , 02) + //016 a 017
                 fStrZero(strCpfCgc                          , 01) + //018 a 018
                 fStrZero(strCgcCli                          , 15) + //019 a 033
                 fPadR   (qryRemessa.FieldByName('CLI_NOMCLI').AsString       , 40) + //034 a 073
                 fPadR   (AstrEndereco                       , 40) + //074 a 113
                 fPadR   (qryRemessa.FieldByName('BAIRRO').AsString           , 15) + //114 a 128
                 fPadR   (Copy(qryRemessa.FieldByName('C_E_P_').AsString,1,5) , 05) + //129 a 133
                 fPadR   (Copy(qryRemessa.FieldByName('C_E_P_').AsString,6,3) , 03) + //134 a 136
                 fPadR   (qryRemessa.FieldByName('CIDADE').AsString           , 15) + //137 a 151
                 fPadR   (qryRemessa.FieldByName('ESTADO').AsString           , 02) + //152 a 153
                 fPadR   ('0'                                , 01) + //154 a 154
                 fStrZero('0'                                , 15) + //155 a 169
                 fPadR   (' '                                , 40) + //170 a 209
                 fPadR   (' '                                , 03) + //210 a 212
                 fPadR   (' '                                , 20) + //213 a 232
                 fPadR   (' '                                , 08);  //233 a 240

          {*******************************}
          {* ESCREVE O SEGMENTO Q NO TXT *}
          {****************************LB*}
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strSegQ));

          {**************}
          {* SEGMENTO R *}
          {***********JU*}
      pGerarSegmentoR;
      Inc(intSeqUen);
      Inc(intSeqLot);

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
      pGravaRemDet(strAutoIncremRem,
                   qryRemessa.FieldByName('AUTOINCREM').AsString,
                   strNosNum,
                   fStrToFloat(strPerMul),
                   qryRemessa.FieldByName('CBI_VALDUP').AsFloat,
                   qryRemessa.FieldByName('CTR_DTAREC').AsDateTime,
                   qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime,
                   VS_Date,
                   strLoginUsuarioLogado,
                   '');
      pAtualizaOcoCrm;
      qryRemessa.Next;
    End;

      {**********************}
      {* TRAILLER DE LOTE   *}
      {* REGISTRO TIPO 5   * }
      {*******************LB*}
    strTraLot := '';

    strTraLot := fPadR   (strCodBco              , 003) + //001 a 003
                 fStrZero('1'                    , 004) + //004 a 007
                 fPadR   ('5'                    , 001) + //008 a 008
                 fPadR   (' '                    , 009) + //009 a 017
                 fStrZero(IntToStr(intSeqLot + 1), 006) + //018 a 023
                 fStrZero('0'                    , 006) + //024 a 029
                 fStrZero('0'                    , 017) + //030 a 046
                 fPadR   ('0'                    , 006, '0') + //047 a 052
                 fPadR   ('0'                    , 017, '0') + //053 a 069
                 fStrZero('0'                    , 006) + //070 a 075
                 fStrZero('0'                    , 017) + //076 a 092
                 fPadR   (' '                    , 031) + //093 a 123
                 fPadR   (' '                    , 117);  //124 a 240

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
    Writeln(txtTexto,fRetirarCaracteresEspeciais(strTraLot));

      {***********************}
      {* TRAILLER DE ARQUIVO *}
      {* REGISTRO DO TIPO 9  *}
      {********************LB*}
    strTraArq := '';
    strTraArq := fPadR   (strCodBco              , 003) + //001 a 003
                 fPadR   ('9999'                 , 004) + //004 a 007
                 fPadR   ('9'                    , 001) + //008 a 008
                 fPadR   (' '                    , 009) + //009 a 017
                 fStrZero('1'                    , 006) + //018 a 023
                 fStrZero(IntToStr(intSeqUen + 3), 006) + //024 a 029
                 fPadR   (' '                    , 006) + //030 a 035
                 fPadR   (' '                    , 205);  //036 a 240

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
    Writeln(txtTexto,fRetirarCaracteresEspeciais(strTraArq));

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

procedure TfrmExpArqRemCxFed7D.pValidaInformacoesDetalhe;
Begin
  If fCfgSis('VALIMP', varBoolean) then
  begin
    fltValDup := fltValDup + qryRemessa.FieldByName('CTR_JURSUJ').AsFloat +
             qryRemessa.FieldByName('CTR_DESCOB').AsFloat;
  end;

  pValidaCGCCPF;

  pValidaProtesto;

  If fEmptyStr(strBaiDev)Then
    strBaiDev := '1';

  fltMorDia := fFormataFloat((qryRemessa.FieldByName('CBI_VALDUP').AsFloat) * (fStrToFloat(strJurosDia) / 100), 2);

  pValidaDescontoPontualidadeDetalhe;

  if (strCodCar = '12') then
    strCodCarRem := '0'
  else If(strCodCar = '11') Then
    strCodCarRem := '0'
  Else
    strCodCarRem := '';

End;

function TfrmExpArqRemCxFed7D.fCriarQueryRemessa: TUniQuery;
Begin
  Result := fCriaQuery(Self);
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Add(fGetSqlRemessa);
  Result.ParamByName('CODBCO').AsString := strCodBco;

  if (fCfgSis('CONREM', varString) = 'C') THEN
    Result.ParamByName('CARTEI').AsString := strCartei;

  If (Not fEmptyStr(edtCodPor.Text)) Then
    Result.ParamByName('CODPOR').AsString := edtCodPor.Text;

  Result.Open;
End;

function TfrmExpArqRemCxFed7D.fGetSqlRemessa: String;
  Var
    strSQL     : String;
Begin
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
  strSQL := strSQL + '           R.CTR_PARCEL = B.CBI_PARCEL AND ';
  strSQL := strSQL + '           R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
  strSQL := strSQL + '           R.CTR_CODEMP = B.CBI_CODEMP AND ';
  strSQL := strSQL + '           R.CTR_CODCLI = B.CBI_CODCLI AND ';
  strSQL := strSQL + '           R.CTR_DTAREC IS NULL ';

  if (fCfgSis('CONREM', varString) = 'C') THEN
    strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';

  If blnUsaDesPon Then
    strSQL := strSQL + ' LEFT JOIN CADCND D ON D.CND_CODIGO = B.CBI_CODCND ';

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
  Result := strSQL;
End;

procedure TfrmExpArqRemCxFed7D.pGravaLogctr;
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

procedure TfrmExpArqRemCxFed7D.pCarregaInformacoesCarteira;
Begin
  If fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'RESPONS', '') = 'E' Then
  Begin
    strEmiBol := '2';
    strEnvBol := '0';
  End
  Else
  Begin
    strEmiBol := '1';
    strEnvBol := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DISTRI', '2');
  End;

  strProAce  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'PROACEI', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorRem  := FormatDateTime('hh',fTime()) + FormatDateTime('mm',fTime()) + FormatDateTime('ss',fTime());
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIG1047D', 'RELOCAL', '') = 'N' );

  strJurosDia := fGetBancoConfig(0, 'CONFIG1047D', 'JUROSDI', '0');

  If (fStrToFloat(strJurosDia) > 0) Then
    strJurosDia := FormatFloat('###,##0.00',(fStrToFloat(strJurosDia) / 30)) ;

  strSisCob  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'SISCOB', '');

  fltPerMul  := fStrToFloat(fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'PERMULT', ''));

  If fltPerMul > 0 Then
  Begin
    strPerMul:= FormatFloat('###,##0.00', fltPerMul);
    strPerMul:= fTiraCaracEspeciais(strPerMul);
  End
  Else
    strPerMul:= '';

  strObs001  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'OBSERV1', '');
  strObs002  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'OBSERV2', '');
  strObs003  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'OBSERV3', '');
  strObs004  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'OBSERV4', '');
  strVerArq  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'VERARQ', '');
  strVerLot  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'VERLOT', '');

  blnUsaCnd := fCfgSis('USACND', VarBoolean);

  pValidaDescontoPontualidadeCarteira;

  pValidaEmpresa;
End;

function TfrmExpArqRemCxFed7D.fPreparaExportacao : Boolean;
Begin
  Result := True;
  If Not fVerificaCampos Then
    Result := False;

  If Not Result Then
     Exit;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Result := False;

  If fEmptyStr(fTiraCaracEspeciais(fraPathRemessa.edtDirectory.text)) Then
  Begin
    fMensagem('Path:', 'Diretório p\ exportação deve ser informado!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Result := False;
  End;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação!', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Result := False;
  End;
End;

procedure TfrmExpArqRemCxFed7D.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'PATHREM', ''));
  edtNomArquivo.Text  := 'ARQ' + FormatDateTime('dd', Date) + FormatDateTime('mm', Date) + '.TXT';
  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemCxFed7D.btnGerarClick(Sender: TObject);
  Var
    strSQL : String;
begin
  inherited;

  If fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'SISCOB', '') = 'SIGCB' Then
  Begin
    pGerarRemessaSIGCB;
    Exit;
  End;

  strCodCarRem := '';

  If Not fPreparaExportacao Then
    Exit;

  strCodBco  := '104';
  strNomBco  := 'CAIXA ECONOMICA FEDERAL';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);

  strCodCar  := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'NUMCART', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIGAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDConCor := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodConv := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'CODCONV', '');
  strDigVeri := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'DIGVERI', '');

  pCarregaInformacoesCarteira;
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

    qryConsultaGen.Close;
    qryConsultaGen.SQL.Clear;
    qryConsultaGen.SQL.Add(strSQL);
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strCgcEmp := fTiraCaracEspeciais(qryConsultaGen
    .FieldByName('EMP_C_G_C_').AsString,True,False,True);
    qryConsultaGen.Close;

    strCartei  := 'CONFIG1047D-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriarQueryRemessa;

    If qryRemessa.IsEmpty Then
    Begin
      fRollBack;
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
      Exit;
    End;

    strCodRem  := fStrZero(fAtuCodSeq('CONFIG1047D', 'PROXNUM'), 8);

    AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
    strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
    Rewrite(txtTexto);

      {**********************}
      {* HEADER DO ARQUIVO  *}
      {* REGISTRO DO TIPO 0 *}
      {*******************LB*}
    strHeader := '';

    strHeader := fPadR   (strCodBco              , 003) + //001 a 003
                 fStrZero('0000'                 , 004) + //004 a 007
                 fPadR   ('0'                    , 001) + //008 a 008
                 fPadR   (' '                    , 009) + //009 a 017
                 fPadR   ('2'                    , 001) + //018 a 018
                 fPadL   (strCgcEmp         , 014, '0') + //019 a 032
                 fPadL(strCodAgen+strCodConv, 016, '0') + //033 a 048
                 fPadR   (' '                    , 004) + //049 a 052
                 fStrZero(strCodAgen             , 005) + //053 a 057
                 fPadR   (strDigAgen             , 001) + //058 a 058
                 fPadL   (strContCor        , 012, '0') + //059 a 070
                 fPadR   (strDConCor             , 001) + //071 a 071
                 fPadR   (strDigVeri             , 001) + //072 a 072
                 fPadR   (strNomEmp              , 030) + //073 a 102
                 fPadR   (strNomBco              , 030) + //103 a 132
                 fPadR   (' '                    , 010) + //133 a 142
                 fPadR   ('1'                    , 001) + //143 a 143
                 fPadR   (strDtaRem              , 008) + //144 a 151
                 fPadR   (strHorRem              , 006) + //152 a 157
                 fPadR   (RightStr(strCodRem, 6) , 006) + //158 a 163
                 fPadR   (strVerArq              , 003) + //164 a 166
                 fStrZero('0'                    , 005) + //167 a 171
                 fPadR   (' '                    , 020) + //172 a 191
                 fPadR   ('REMESSA-PRODUCAO'     , 020) + //192 a 211
                 fPadR   (' '                    , 029);   //212 a 240

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************LB*}
    Writeln(txtTexto,fRetirarCaracteresEspeciais(strHeader));

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
    pGravaRemGer(VS_strCodEmp, strCodBco, 'CONFIG1047D_240p-' + IntToStr(intCartei) + '-' + VS_strCodEmp, StrToInt(strCodRem), strAutoIncremRem);

      {**********************}
      {* HEADER DO LOTE     *}
      {* REGISTRO DO TIPO 1 *}
      {*******************LB*}
    strHeaLot := '';
    strHeaLot := fPadR   (strCodBco              , 003) + //001 a 003
                 fPadR   ('0001'                 , 004) + //004 a 007
                 fPadR   ('1'                    , 001) + //008 a 008
                 fPadR   ('R'                    , 001) + //009 a 009
                 fPadR   ('01'                   , 002) + //010 a 011
                 fPadR   ('00'                   , 002) + //012 a 013
                 fPadR   (strVerLot              , 003) + //014 a 016
                 fPadR   (' '                    , 001) + //017 a 017
                 fPadR   ('2'                    , 001) + //018 a 018
                 fPadL(strCgcEmp            , 015, '0') + //019 a 033
                 fPadL(strCodAgen+strCodConv, 016, '0') + //034 a 049
                 fPadR   (' '                    , 004) + //050 a 053
                 fStrZero(strCodAgen             , 005) + //054 a 058
                 fPadR   (strDigAgen             , 001) + //059 a 059
                 fPadL   (strContCor        , 012, '0') + //060 a 071
                 fPadR   (strDConCor             , 001) + //072 a 072
                 fPadR   (strDigVeri             , 001) + //073 a 073
                 fPadR   (strNomEmp              , 030) + //074 a 103
                 fPadR   (strObs001              , 040) + //104 a 143
                 fPadR   (strObs002              , 040) + //144 a 183
                 fPadR   (strCodRem              , 008) + //184 a 191
                 fPadR   (strDtaRem              , 008) + //192 a 199
                 fStrZero(strDtaRem              , 008) + //200 a 207
                 fPadR   (' '                    , 033);   //208 a 240

    {***************************}
    {* ESCREVE O HEADER NO TXT *}
    {************************LB*}
    Writeln(txtTexto,fRetirarCaracteresEspeciais(strHeaLot));

    intSeqLot := 1;
    intSeqUen := 1;
    intQtdReg := 0;
    fltTotCob := 0;

    While Not qryRemessa.Eof Do
    Begin
      intQtdReg := intQtdReg + 1;
      fltTotCob := fltTotCob + qryRemessa.FieldByName('CBI_VALDUP').AsFloat;

      Application.ProcessMessages;

      {***********************}
      {* REGISTRO DE DETALHE *}
      {* REGISTRO DO TIPO3   *}
      {********************LB*}
      strDtaVen := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                   FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                   FormatDateTime('yyyy',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);

      strDtaEmi := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                   FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                   FormatDateTime('yyyy',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime);

      dtaDtaJur := qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime + 1;

      strDtaJur := FormatDateTime('dd',dtaDtaJur) +
                   FormatDateTime('mm',dtaDtaJur) +
                   FormatDateTime('yyyy',dtaDtaJur);
      strDtaMul := strDtaJur;

      pValidaEspecie;

      strNumDup := qryRemessa.FieldByName('CBI_NUMDUP').AsString + qryRemessa.FieldByName('CBI_PARCEL').AsString;

      strKeyDup := fPadR(qryRemessa.FieldByName('CBI_NUMDUP').AsString, 12) +
                   fPadR(qryRemessa.FieldByName('CBI_PARCEL').AsString, 03) +
                   fPadR(qryRemessa.FieldByName('CBI_ESPDOC').AsString, 02) +
                   fPadR(qryRemessa.FieldByName('CBI_CODEMP').AsString, 03);

      //AJUSTANDO ENDEREÇO PARA FICAR COMPLETO DENTRO DE 40 CARACTERES
      AstrEndereco := RetornaEnderecoENumeroCom40Caracteres(qryRemessa.FieldByName('ENDERE').AsString, qryRemessa.FieldByName('NUMERO').AsString);

      strCgcEmp := Trim(strCgcEmp);
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '.', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '/', '');
      strCgcEmp := AnsiReplaceStr(strCgcEmp, '-', '');

      strCgcCli := Trim(qryRemessa.FieldByName('CBI_C_G_C_').AsString);
      strCgcCli := AnsiReplaceStr(strCgcCli, '.', '');
      strCgcCli := AnsiReplaceStr(strCgcCli, '/', '');
      strCgcCli := AnsiReplaceStr(strCgcCli, '-', '');

      strNosNum := RightStr(qryRemessa.FieldByName('CBI_NOSNUM').AsString,11);

      fltValDup := qryRemessa.FieldByName('CBI_VALDUP').AsFloat;

      pValidaInformacoesDetalhe;

          {**********************************}
          {* REGISTRO DE DETALHE SEGMENTO P *}
          {*******************************LB*}

      strSegP := fPadR      (strCodBco                         , 03)     + //001 a 003
                 fStrZero   ('1'                               , 04)     + //004 a 007
                 fPadR      ('3'                               , 01)     + //008 a 008
                 fStrZero   (IntToStr(intSeqUen)               , 05)     + //009 a 013
                 fPadR      ('P'                               , 01)     + //014 a 014
                 fPadR      (' '                               , 01)     + //015 a 015
                 fPadR      ('01'                              , 02)     + //016 a 017
                 fStrZero   (strCodAgen                        , 05)     + //018 a 022
                 fPadR      (strDigAgen                        , 01)     + //023 a 023
                 fPadL      (strContCor                    , 12,'0')     + //024 a 035
                 fPadR      (strDConCor                        , 01)     + //036 a 036
                 fPadR      (strDigVeri                        , 01)     + //037 a 037
                 fPadR      (' '                               , 09)     + //038 a 046
                 fStrZero   (strNosNum                         , 11)     + //047 a 057
                 fPadR      (strCodCar                         , 01)     + //058 a 058
                 fPadR      ('1'                               , 01)     + //059 a 059 // (1)COBRANCA REGISTRADA  (2)SEM REGISTRO
                 fPadR      ('2'                               , 01)     + //060 a 060 // FIXO
                 fPadR      (strEmiBol                         , 01)     + //061 a 061 // (1)BANCO EMITE (2) CLIENTE EMITE
                 fPadR      (strEmiBol                         , 01)     + //062 a 062
                 fPadR      (RightStr(strNumDup, 11)           , 11)     + //063 a 073
                 fPadR      (' '                               , 04)     + //074 a 077
                 fPadR      (strDtaVen                         , 08)     + //078 a 085
                 fValNumForm(fltValDup                         , 15)     + //086 a 100
                 fStrZero   ('00000'                           , 05)     + //101 a 105
                 fPadR      ('0'                               , 01)     + //106 a 106
                 fPadR      ('02'                              , 02)     + //107 a 108 // (02)DM - DUPLICATA
                 fPadR      (IIF(strProAce = 'S', 'A','N')     , 01)     + //109 a 109
                 fPadR      (strDtaEmi                         , 08)     + //110 a 117
                 fPadR      ('1'                               , 01)     + //118 a 118 // (1) AO DIA (2) AO MENSAL
                 fStrZero   (strDtaVen                         , 08)     + //119 a 126
//               fValNumForm(fStrToFloat(strJurosDia)          , 15)     + //127 a 141
                 fValNumForm(fltMorDia                         , 15)     + //127 a 141
                 fPadR      (IIF(fltValDpo > 0,'2','0')        , 01)     + //142 a 142
                 fPadL      (strDtaDpo                         , 08)     + //143 a 150
                 fValNumForm(fltValDpo                         , 15)     + //151 a 165
                 fStrZero   ('0'                               , 15)     + //166 a 180
                 fStrZero   ('0'                               , 15)     + //181 a 195
                 fPadR      (strKeyDup                         , 25)     + //196 a 220
                 fPadR      (strCodPro                         , 01)     + //221 a 221 // (1)DIAS CORRIDOS (2)DIAS UTEIS (3)NAO PROTESTAR
                 fPadL      (strDiaPro                     , 02,'0')     + //222 a 223
                 fPadR      (strBaiDev                         , 01)     + //224 a 224
                 fPadR      (fStrZero(strDiasDev,3)            , 03)     + //225 a 227
                 fPadR      ('09'                              , 02)     + //228 a 229
                 fPadR      (' '                               , 10)     + //230 a 239
                 fPadR      (' '                               , 01);       //240 a 240
          {*******************************}
          {* ESCREVE O SEGMENTO P NO TXT *}
          {****************************AF*}
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strSegP));

      Inc(intSeqUen);
      Inc(intSeqLot);

          {**********************************}
          {* REGISTRO DE DETALHE SEGMENTO Q *}
          {*******************************AF*}
      strSegQ := fPadR   (strCodBco                                , 03) + //001 a 003
                 fStrZero('1'                                      , 04) + //004 a 007
                 fPadR   ('3'                                      , 01) + //008 a 008
                 fStrZero(IntToStr(intSeqUen)                      , 05) + //009 a 013
                 fPadR   ('Q'                                      , 01) + //014 a 014
                 fPadR   (' '                                      , 01) + //015 a 015
                 fPadR   ('01'                                     , 02) + //016 a 017
                 fStrZero(strCpfCgc                                , 01) + //018 a 018
                 fStrZero(strCgcCli                                , 15) + //019 a 033
                 fPadR   (qryRemessa.FieldByName('CLI_NOMCLI').AsString       , 40) + //034 a 073
                 fPadR   (AstrEndereco                             , 40) + //074 a 113
                 fPadR   (qryRemessa.FieldByName('BAIRRO').AsString           , 15) + //114 a 128
                 fPadR   (Copy(qryRemessa.FieldByName('C_E_P_').AsString,1,5) , 05) + //129 a 133
                 fPadR   (Copy(qryRemessa.FieldByName('C_E_P_').AsString,6,3) , 03) + //134 a 136
                 fPadR   (qryRemessa.FieldByName('CIDADE').AsString           , 15) + //137 a 151
                 fPadR   (qryRemessa.FieldByName('ESTADO').AsString           , 02) + //152 a 153
                 fPadR   ('1'                                      , 01) + //154 a 154
                 fStrZero('0'                                      , 15) + //155 a 169
    //                   fPadR   (FieldByName('CLI_NOMCLI').AsString       , 40) + //170 a 209
                 fPadR   (' '                                      , 40) + //170 a 209
                 fPadR   (' '                                      , 03) + //210 a 212
                 fPadR   (' '                                      , 20) + //213 a 232
                 fPadR   (' '                                      , 08);   //233 a 240

          {*******************************}
          {* ESCREVE O SEGMENTO Q NO TXT *}
          {****************************LB*}
      Writeln(txtTexto,fRetirarCaracteresEspeciais(strSegQ));

          {**************}
          {* SEGMENTO R *}
          {***********JU*}
      pGerarSegmentoR;
      Inc(intSeqUen);
      Inc(intSeqLot);

          {*****************************}
          {* GRAVAÇÃO DA TABELA REMDET *}
          {**** DETALHES DA REMESSA ****}
          {**************************MO*}
      pGravaRemDet(strAutoIncremRem,
                   qryRemessa.FieldByName('AUTOINCREM').AsString,
                   strNosNum,
                   fStrToFloat(strPerMul),
                   qryRemessa.FieldByName('CBI_VALDUP').AsFloat,
                   qryRemessa.FieldByName('CTR_DTAREC').AsDateTime,
                   qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime,
                   VS_Date,
                   strLoginUsuarioLogado,
                   '');

      pAtualizaOcoCrm;
      qryRemessa.Next;
    End;


      {**********************}
      {* TRAILLER DE LOTE   *}
      {* REGISTRO TIPO 5   * }
      {*******************LB*}
    strTraLot := '';
    strTraLot := fPadR   (strCodBco              , 003) + //001 a 003
                 fStrZero('1'                    , 004) + //004 a 007
                 fPadR   ('5'                    , 001) + //008 a 008
                 fPadR   (' '                    , 009) + //009 a 017
                 fStrZero(IntToStr(intSeqLot + 1), 006) + //018 a 023
                 fStrZero('0'                    , 006) + //024 a 029
                 fStrZero('0'                    , 017) + //030 a 046
                 fPadR   ('0'                    , 006, '0') + //047 a 052
                 fPadR   ('0'                    , 017, '0') + //053 a 069
                 fStrZero('0'                    , 006) + //070 a 075
                 fStrZero('0'                    , 017) + //076 a 092
                 fPadR   (IntToStr(intQtdReg)    , 006, '0') + //093 a 098
                 fValNumForm(fltTotCob           , 017) + //099 a 115
                 fPadR   (' '                    , 008) + //116 a 123
                 fPadR   (' '                    , 117);   //124 a 240

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
    Writeln(txtTexto,fRetirarCaracteresEspeciais(strTraLot));

      {***********************}
      {* TRAILLER DE ARQUIVO *}
      {* REGISTRO DO TIPO 9  *}
      {********************LB*}
    strTraArq := '';
    strTraArq := fPadR   (strCodBco              , 003) + //001 a 003
                 fPadR   ('9999'                 , 004) + //004 a 007
                 fPadR   ('9'                    , 001) + //008 a 008
                 fPadR   (' '                    , 009) + //009 a 017
                 fStrZero('1'                    , 006) + //018 a 023
                 fStrZero(IntToStr(intSeqUen + 3), 006) + //024 a 029
                 fPadR   (' '                    , 006) + //030 a 035
                 fPadR   (' '                    , 205);  //036 a 240

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AF*}
    Writeln(txtTexto,fRetirarCaracteresEspeciais(strTraArq));

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

procedure TfrmExpArqRemCxFed7D.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS';
end;

procedure TfrmExpArqRemCxFed7D.edtCodPorKeyPress(Sender: TObject;  var Key: Char);
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

function TfrmExpArqRemCxFed7D.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

Begin

  qryCadEmp := fCriaQuery(Self);
  qryCadEmp.Close;
  qryCadEmp.SQL.Clear;
  qryCadEmp.SQL.Add('SELECT * FROM CADEMP');
  qryCadEmp.SQL.Add('ORDER BY EMP_CODEMP ');
  qryCadEmp.Open;
  qryCadEmp.First;

  SetLength(arrResult, qryCadEmp.RecordCount);
  intCount := 0;

  While Not qryCadEmp.Eof Do
  Begin
    arrResult[intCount] := fStrZero(qryCadEmp.FieldByName('EMP_CODEMP').AsString, 3) + ' - ' + qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
    qryCadEmp.Next;
    Inc(intCount);
  End;

  intCount := 1;

  If Length(arrResult) > 1 Then
    intCount := fGetMenu('Selecione a Empresa', arrResult, 0);

  Result   := LeftStr(arrResult[intCount -1], 3);

  FreeAndNil(qryCadEmp);
end;

function TfrmExpArqRemCxFed7D.fValidaCampos(Sender: TWinControl;
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

procedure TfrmExpArqRemCxFed7D.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemCxFed7D.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;

end.

