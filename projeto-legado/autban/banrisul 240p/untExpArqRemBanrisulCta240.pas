unit untExpArqRemBanrisulCta240;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTCadPag, untTCadPagRepository, System.DateUtils,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBanrisulCta240 = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    edtNomArquivo: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    pnlTopo: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private

    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;
    procedure pGeraTED(qryTED: TUniQuery; blnBancoDiferente: Boolean);
    procedure HeaderConcessionariaTributos(AFormaLancamento: String);
    procedure TrailerConcessionariaTributos;
    procedure pGravaLogCTP(GenQryRemessa: TUniQuery);
    procedure pGeraConcessionariasTributos(qryConc: TUniQuery; blnConcessionaria : Boolean);
    function fVerificaValidacoes: Boolean;
    procedure pGeraTributos(qryTributos: TUniQuery);

    { Private declarations }
  public
    { Public declarations }
    intCartei    : Integer;
    intTipInsFor : Integer;

    intCodSeqTED      : Integer;
    intCodSeqGeralTED : Integer;
    intCodSeqRegTED   : Integer;
    intTotLot         : Integer;
    intIndLot         : Integer;

    strNomForm     : String;
    strHeaderLot   : String;
    strTransacao   : String;
    strCodAgen     : String;
    strContCor     : String;
    strDigCnt      : String;
    strEndEmp      : String;
    strNumEmp      : String;
    strComEmp      : String;
    strCidEmp      : String;
    strCepEmp      : String;
    strEstEmp      : String;
    strCgcEmp      : String;
    strDigAgen     : String;
    intTipIns      : Integer;
    strCodConv     : String;
    strNomEmp      : String;

    strCgcFor            : String;
    strEndFor            : String;
    strNumFor            : String;
    strComFor            : String;
    strBairroFor         : String;
    strCidFor            : String;
    strCepFor            : String;
    strEstFor            : String;
    strCamCentralizadora : String;
    strCodBco            : String;
    strTraillerLot       : String;
    strDtaVen            : string;
    strDtaEmi            : string;
    strDtaPag            : string;
    strAutInc            : string;
    strCodMovimento      : string;
    strAvisoTed          : String;
    strGetCodFor         : String;
    strCodCar            : String;
    strDigCar            : String;

    strNomBco    : String;
    strCodCed    : String;
    strDigCed    : String;
    strNomCed    : String;
    strNumCon    : String;
    strConCli    : String;
    strDiasProt  : String;
    strInstProt  : String;
    strDiasCred  : String;
    strProAce    : String;
    strResp      : String;
    strCodPor    : String;
    strCtaBai    : String;
    strInstru1   : String;
    strInstru2   : String;
    strObs001    : String;
    strObs002    : String;
    strComand    : String;
    strModali    : String;
    strNosNum    : String;
    strSeuNum    : String;
    strParcel    : String;
    strAgenCob   : String;
    strCodRem    : String;
    strHeader    : String;
    strHeLote    : String;
    strTrailler  : String;
    strTrLote    : String;
    strCpfCgc    : String;
    strKeyDup    : String;
    strCgcCli    : String;

    intCodSeq    : Integer;
    intCodSq1    : Integer;
    intCodSeq1   : Integer;
    intCodSeq2   : Integer;
    intCodSeq3   : Integer;
    bck_intCodSeq3 : Integer;
    intCodSeqGer : Integer;
    intSeqCrr    : Integer;

    intCodSeqTributos : Integer;

    fltValAtr    : Double;
    fltTotRem    : Double;
    fltValPag1   : Double;
    fltValPag2   : Double;
    fltValPag4   : Double;
    fltValOutrasEntidades: Double;

    strNovCodEmp   : String;

    strPerJur      : String;
    strDatMul      : String;
    dtaDtaMul      : TDateTime;
    fltPerJur      : Double;
    strDtaMul      : String;
    strDiaMora     : string;
    strPerMul      : String;
    fltPerMul      : Double;
    dtaDtaJur      : TDateTime;
    strDtaRem      : String;
    strHorRem      : String;
    strDtaJur      : String;

    strCodBcoResp  : String;
    strNossoNumResp: String;

    strFilePath    : String;
    txtTexto       : TextFile;
    qryFormaPgto   : TUniQuery;
    qryRemessa     : TUniQuery;

    objPag         : TCadPag;
    objRep         : TCadPagRepository;

    strSQLDep      : String;
    strSQL         : String;

    blnRemLoc      : Boolean;
    blnUsaCrr      : Boolean;

  end;

var
  frmExpArqRemBanrisulCta240: TfrmExpArqRemBanrisulCta240;

implementation

uses untFuncoes, untfuncoesSimples, DB, untLogCtp;

{$R *.dfm}

procedure TfrmExpArqRemBanrisulCta240.FormShow(Sender: TObject);
begin
  inherited;
  
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'PROXNUM', ''), 06) +
                         '.TXT';
  pSetFocus(fraPathRemessa);

end;

function TfrmExpArqRemBanrisulCta240.fVerificaValidacoes : Boolean;
 Var
     blnRet : Boolean;
Begin

  blnRet := True;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
  Begin
     blnRet := False;
     //Exit;
  End;

  If blnRet Then
  Begin

    fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

    If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
    Begin
       fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
       pSetFocus(fraPathRemessa);
       //Exit;
       blnRet := False;
    End;

  End;

  //*******************************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERACAO DE REMESSA PARA  //
  //   TODAS AS EMPRESAS OU SOMENTE PARA A EMPRESA ATUAL(LOCAL)        //
  //*******************************************************************//
  If blnRet Then
  Begin

    strNovCodEmp := VS_strCodEmp;

    If Not( blnRemLoc ) Then
       strNovCodEmp := fRetEmpresa;

    strNomEmp := fRetNomeEmpresa(strNovCodEmp);

    //*************************************************//
    // SE OCORRER ALGUM ERRO AO RETORNAR O NOME DA     //
    // EMPRESA, ENTAO DA A MENSAGEM E SKIP A EXPORT.   //
    //*************************************************//
    If fEmptyStr( strNomEmp ) Then
    Begin
       fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!', ['&O K'], 1, True);
       blnRet := False;
       //Exit;
    End;

  End;

  result := blnRet;

End;

procedure TfrmExpArqRemBanrisulCta240.btnGerarClick(Sender: TObject);
begin
  inherited;
  fltValOutrasEntidades := 0;
  qryFormaPgto := fCriaQuery(Self);

  strCodBco       := '041';
  strNomBco       := 'Banrisul240';
  strNomEmp       := fRetNomeEmpresa(VS_strCodEmp);
  strCodConv      := fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'CODCONV', '');
  strCodAgen      := fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen      := fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'DIGAGEN', '');
  strContCor      := fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt       := fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar       := fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'NUMCART', '');
  strDigCar       := fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'CODCART', '');
  strCodRem       := fStrZero(fAtuCodSeq('CONFIGCTA041-' + IntToStr(intCartei), 'PROXNUM'), 6);
  strDtaRem       := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorRem       := FormatDateTime('hh', fTime()) + FormatDateTime('mm',fTime())    + FormatDateTime('ss'  , fTime());
  blnRemLoc       := Not( fGetBancoConfig(0, 'CONFIGCTA041-', 'RELOCAL', '') = 'N' );
  strCodMovimento := fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'CODMOVI', '');
  strCodMovimento := IIF(fEmptyStr(strCodMovimento),'0',strCodMovimento);
  intTotLot       := 0;

  if Not fVerificaValidacoes then
     Exit;

  Try
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  *      ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    qryConsultaGen.Close;
    qryConsultaGen.SQL.Clear;
    qryConsultaGen.SQL.Add(strSQL);
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strCgcEmp := qryConsultaGen.FieldByName('EMP_C_G_C_').AsString;
    strEndEmp := qryConsultaGen.FieldByName('EMP_ENDERE').AsString;
    strNumEmp := qryConsultaGen.FieldByName('EMP_ENDNUM').AsString;
    strComEmp := qryConsultaGen.FieldByName('EMP_ENDCMP').AsString;
    strCidEmp := qryConsultaGen.FieldByName('CID_NOMCID').AsString;
    strCepEmp := fTiraCaracEspeciais(qryConsultaGen.FieldByName('EMP_C_E_P_').AsString);
    strEstEmp := qryConsultaGen.FieldByName('CID_ESTADO').AsString;
    qryConsultaGen.Close;

    intTipIns := IIF( Length(strCgcEmp) > 11, 2, 1 );

    qryRemessa                := fCriaQuery(Self);
    qryRemessa.UniDirectional := False;

    strSQL := '';
    strSQL := strSQL + 'SELECT                     ';
    strSQL := strSQL + '  B.*,                     ';
    strSQL := strSQL + '  F.FOR_NOMFOR,            ';
    strSQL := strSQL + '  F.FOR_ENDERE AS ENDERE,  ';
    strSQL := strSQL + '  F.FOR_BAIRRO AS BAIRRO,  ';
    strSQL := strSQL + '  F.FOR_C_E_P_ AS C_E_P_,  ';
    strSQL := strSQL + '  F.FOR_ENDCOM AS COMPLEMENTO, ';
    strSQL := strSQL + '  F.FOR_ENDNUM AS NUMERO,  ';
    strSQL := strSQL + '  F.FOR_CGCCPF AS CGCCPF,  ';
    strSQL := strSQL + '  F.FOR_C_G_C_ AS CODCGC,  ';
    strSQL := strSQL + '  D.BCF_CAMCEN AS CAMCEN,  ';
    strSQL := strSQL + '  D.BCF_CODBCO AS CODBCO,  ';
    strSQL := strSQL + '  D.BCF_NUMAGE AS CODAGE,  ';
    strSQL := strSQL + '  D.BCF_DIGAGE AS DIGAGE,  ';
    strSQL := strSQL + '  D.BCF_NUMCTA AS NUMCTA,  ';
    strSQL := strSQL + '  D.BCF_DIGCTA AS DIGCTA,  ';
    strSQL := strSQL + '  D.BCF_DIGVER AS DIGVER,  ';
    strSQL := strSQL + '  D.BCF_COMPDES AS COMPDES, ';
    strSQL := strSQL + '  C.CID_NOMCID AS CIDADE,  ';
    strSQL := strSQL + '  C.CID_ESTADO AS ESTADO,  ';
    strSQL := strSQL + '  B.PGI_FORPGT AS FORMAPAGTO, ';
    strSQL := strSQL + '  IFNULL(P.CTP_TIPDOC, 1) AS TIPDOCTO, ';
    strSQL := strSQL + '  IF(B.PGI_FORPGT = "DEP",PGI_CODBCO,LEFT(PGI_CODBAR, 3)) AS CODBAN ';
    strSQL := strSQL + 'FROM                       ';
    strSQL := strSQL + '  CADPGI B                 ';
    strSQL := strSQL + '  LEFT JOIN CADFOR F ON FOR_CODFOR = PGI_CODFOR     ';
    strSQL := strSQL + '  LEFT JOIN CADPAG P ON P.AUTOINCREM = PGI_AUTOIN   ';
    strSQL := strSQL + '  LEFT JOIN BCOFOR D ON D.AUTOINCREM = P.CTP_BCOFOR ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  PGI_CODBCO = :CODBCO     ';

    strSQLDep := '';
    strSQLDep := strSQLDep + strSQL + ' AND PGI_FORPGT = :FORMAPGTO LIMIT 1';

    qryFormaPgto.Close;
    qryFormaPgto.SQL.Clear;
    qryFormaPgto.SQL.Add(strSQLDep);
    qryFormaPgto.ParamByName('CODBCO').AsString := strCodBco;
    qryFormaPgto.ParamByName('FORMAPGTO').AsString := 'DEP';
    qryFormaPgto.Open;

    qryRemessa.Close;
    qryRemessa.SQL.Clear;
    qryRemessa.SQL.Add(strSQL);
    qryRemessa.ParamByName('CODBCO').AsString := strCodBco;
    qryRemessa.Open;

    If Not qryRemessa.IsEmpty Then
    Begin
      fStartTransaction;

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {******************************}
      {* HEADER DO ARQUIVO => Reg 0 *}
      {***************************AF*}
      strHeader :=   '';
      strHeader :=   fPadR   ('041'                          , 003) + //001 - 003  [01]
                     fPadR   ('0000'                         , 004) + //004 - 007  [02]
                     fPadR   ('0'                            , 001) + //008 - 008  [03]
                     fPadR   (' '                            , 009) + //009 - 017  [04]
                     fPadR   ('2'                            , 001) + //018 - 018  [05]
                     fPadR   (strCgcEmp                      , 014) + //019 - 032  [06]
                     fStrZero(strCodConv                     , 006) + //033 - 038  [07]
                     fPadR   (' '                            , 014) + //039 - 052  [08]
                     fStrZero(strCodAgen                     , 005) + //053 - 057  [09]
                     fPadR   (strDigAgen                     , 001) + //058 - 058  [10]
                     fStrZero(strContCor                     , 012) + //059 - 070  [11]
                     fPadR   (strDigCnt                      , 001) + //071 - 071  [12]
                     fPadR   (strDigCnt                      , 001) + //072 - 072  [13]
                     fPadR   (fTiraCaracEspeciais(strNomEmp) , 030) + //073 - 102  [14]
                     fPadR   ('BANRISUL'                     , 030) + //103 - 132  [15]
                     fPadR   (' '                            , 010) + //133 - 142  [16]
                     fPadR   ('1'                            , 001) + //143 - 143  [17]
                     fPadR   (strDtaRem                      , 008) + //144 - 151  [18]
                     fPadR   (strHorRem                      , 006) + //152 - 157  [19]
                     fPadR   (strCodRem                      , 006) + //158 - 163  [20]
                     fPadR   ('105'                          , 003) + //164 - 166  [21]
                     fStrZero('06250'                        , 005) + //167 - 171  [22]
                     fPadR   (' '                            , 009) + //172 - 180  [23]
                     fPadR   (' '                            , 001) + //181 - 181  [24]
                     fPadR   ('0'                            , 010) + //182 - 191  [25]
                     fPadR   (' '                            , 020) + //192 - 211  [26]
                     fPadR   (' '                            , 029);  //212 - 240  [27]

      {*******************************}
      {* ESCREVE O HEADER DO ARQUIVO *}
      {*******************************}
      Writeln(txtTexto, strHeader);

      qryRemessa.Filter   := ' CODBAN = ' + QuotedStr('041') +
                             ' AND ((PGI_Q_GUIA = "") OR (PGI_Q_GUIA IS NULL)) '+
                             ' AND PGI_TIPPAG = "" AND FORMAPAGTO <> ' + QuotedStr('DEP');
      qryRemessa.Filtered := True;

      intIndLot  := 1;
      intCodSeq1 := 0;

      If Not qryRemessa.IsEmpty Then
      Begin
        Inc(intTotLot);

        {*************************************************}
        {* HEADER DO LOTE (TÍTULOS DO Banrisul) => REG 1 *}
        {*************************************************}
        strHeaderLot := '';
        strHeaderLot := fPadR   ('041'                          , 003)      + //001 - 003
                        fPadR   (fStrZero(intIndLot,4)          , 004)      + //004 - 007
                        fPadR   ('1'                            , 001)      + //008 - 008
                        fPadL   ('C'                            , 001)      + //009 - 009
                        fPadR   ('20'                           , 002)      + //010 - 011
                        fPadR   ('30'                           , 002)      + //012 - 013
                        fPadR   ('105'                          , 003)      + //014 - 016
                        fPadL   (' '                            , 001)      + //017 - 017
                        fPadR   (IntToStr(intTipIns)            , 001)      + //018 - 018
                        fPadL   (strCgcEmp                      , 014, '0') + //019 - 032
                        fStrZero(strCodConv                     , 006)      + //033 - 038
                        fPadL   (' '                            , 014)      + //039 - 052
                        fPadL   (strCodAgen                     , 005, '0') + //053 - 057
                        fPadR   (strDigAgen                     , 001)      + //058 - 058
                        fPadL   (strContCor                     , 012, '0') + //059 - 070
                        fPadR   (strDigCnt                      , 001)      + //071 - 071
                        fPadL   ('0'                            , 001, '0') + //072 - 072
                        fPadR   (fTiraCaracEspeciais(strNomEmp) , 030, ' ') + //073 - 102
                        fPadL   (' '                            , 030)      + //103 - 132
                        fPadL   (' '                            , 010)      + //133 - 142
                        fPadR   (fTiraCaracEspeciais(strEndEmp) , 030, ' ') + //143 - 172
                        fPadL   (strNumEmp                      , 005, '0') + //173 - 177
                        fPadR   (fTiraCaracEspeciais(strComEmp) , 015, ' ') + //178 - 192
                        fPadR   (fTiraCaracEspeciais(strCidEmp) , 020, ' ') + //193 - 212
                        fPadL   (strCepEmp                      , 008, '0') + //213 - 220
                        fPadR   (strEstEmp                      , 002, ' ') + //221 - 222
                        fPadR   ('VD'                           , 002)      + //223 - 224
                        fPadR   (' '                            , 006)      + //225 - 230
                        fPadR   (' '                            , 010);       //231 - 240

        {****************************}
        {* ESCREVE O HEADER DO LOTE *}
        {****************************}
        Writeln(txtTexto, strHeaderLot);

        {**********************************************************************}
        {* REGISTRO DE DETALHE (TÍTULOS DO Banrisul) => REG = 3 => SEGMENTO J *}
        {**********************************************************************}

          strTransacao := '';

          fltValPag1 := 0;

          While Not qryRemessa.Eof Do
          Begin
            Inc(intCodSeq1);

            Application.ProcessMessages;

            strDtaVen := FormatDateTime(  'dd',qryRemessa.FieldByName('PGI_DTAVEN').AsDateTime) +
                         FormatDateTime(  'mm',qryRemessa.FieldByName('PGI_DTAVEN').AsDateTime) +
                         FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTAVEN').AsDateTime);

            strDtaEmi := FormatDateTime(  'dd',qryRemessa.FieldByName('PGI_DTACAD').AsDateTime) +
                         FormatDateTime(  'mm',qryRemessa.FieldByName('PGI_DTACAD').AsDateTime) +
                         FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTACAD').AsDateTime);

            strDtaPag := FormatDateTime(  'dd',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                         FormatDateTime(  'mm',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                         FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime);

            strAutInc := qryRemessa.FieldByName('PGI_AUTOIN').AsString;

            fltValPag1 := fltValPag1 + qryRemessa.FieldByName('PGI_VALPAG').AsFloat;

            intTipInsFor := IIF( Length(qryRemessa.FieldByName('CODCGC').AsString) > 11, 2, 1 );

            strTransacao := fPadR      ('041'                                             , 03)                      + //001 - 003
                            fPadR      (fStrZero(intIndLot,4)                             , 04)                      + //004 - 007
                            fPadR      ('3'                                               , 01)                      + //008 - 008
                            fPadL      (IntToStr(intCodSeq1)                              , 05, '0')                 + //009 - 013
                            fPadR      ('J'                                               , 01)                      + //014 - 014
                            fStrZero   ('0'                                               , 01)                      + //015 - 015
                            fStrZero   ('0'                                               , 02)                      + //016 - 017
                            fPadL      (qryRemessa.FieldByName('PGI_CODBAR').AsString     , 44, '0')                 + //018 - 061
                            fPadR      (fTiraCaracEspeciais(qryRemessa.FieldByName('FOR_NOMFOR').AsString), 30, ' ') + //062 - 091
                            fPadR      (strDtaVen                                         , 08)                      + //092 - 099
                            fValNumForm(qryRemessa.FieldByName('PGI_VALDUP').AsFloat      , 15)                      + //100 - 114
                            fValNumForm(qryRemessa.FieldByName('PGI_VALDES').AsFloat      , 15)                      + //115 - 129
                            fValNumForm(qryRemessa.FieldByName('PGI_VALJUR').AsFloat      , 15)                      + //130 - 144
                            fPadR      (strDtaPag                                         , 08)                      + //145 - 152
                            fValNumForm(qryRemessa.FieldByName('PGI_VALPAG').AsFloat      , 15)                      + //153 - 167
                            fStrZero   ('0'                                               , 15)                      + //168 - 182
                            fPadL      (strAutInc                                         , 20, '0')                 + //183 - 202
                            fPadR      (' '                                               , 20)                      + //203 - 222
                            fPadL      ('09'                                              ,  2)                      + //223 - 224
                            fPadL      (' '                                               ,  6)                      + //225 - 230
                            fPadL      (' '                                               , 10);                       //231 - 240

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {******************************}
            Writeln(txtTexto, strTransacao);
            Inc(intCodSeq1);

            {***********************************************************}
            {* REGISTRO DE DETALHE (TÍTULOS DO Banrisul) SEGMENTO J-52 *}
            {***********************************************************}
            strTransacao := fPadR('041'                                         , 03)      + //001 - 003 - CÓDIGO DO BANCO NA COMPENSAÇÃO
                            fPadR(fStrZero(intIndLot,4)                         , 04)      + //004 - 007 - LOTE DE SERVIÇO
                            fPadR('3'                                           , 01)      + //008 - 008 - TIPO DE REGISTRO
                            fPadL(IntToStr(intCodSeq1)                          , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                            fPadR('J'                                           , 01)      + //014 - 014 - CÓD. SEGMENTO DO REGISTRO DETALHE
                            fPadL(' '                                           , 01)      + //015 - 015 - USO EXCLUSIVO FEBRABAN/CNAB
                            fPadL('01'                                          , 02)      + //016 - 017 - CÓDIGO DE MOVIMENTO REMESSA
                            fPadL('52'                                          , 02)      + //018 - 019 - IDENTIFICAÇÃO REGISTRO OBRIGATÓRIO
                            fPadR(IntToStr(intTipIns)                           , 01)      + //020 - 020 - TIPO DE INSCRIÇÃO DO SACADO
                            fPadL(strCgcEmp                                     , 15, '0') + //021 - 035 - NÚMERO DE INSCRIÇÃO DO SACADO
                            fPadR(strNomEmp                                     , 40)      + //036 - 075 - NOME DO SACADO
                            fPadR(IntToStr(intTipInsFor)                        , 01)      + //076 - 076 - TIPO DE INSCRIÇÃO DO CEDENTE
                            fPadL(qryRemessa.FieldByName('CODCGC').AsString     , 15, '0') + //077 - 091 - NÚMERO DE INSCRIÇÃO DO CEDENTE
                            fPadR(qryRemessa.FieldByName('FOR_NOMFOR').AsString , 40)      + //092 - 131 - NOME DO CEDENTE
                            fPadR(IntToStr(intTipInsFor)                        , 01)      + //132 - 132 - TIPO DE INSCRIÇÃO DO SACADOR
                            fPadL(qryRemessa.FieldByName('CODCGC').AsString     , 15, '0') + //133 - 147 - NÚMERO DE INSCRIÇÃO DO SACADOR
                            fPadR(qryRemessa.FieldByName('FOR_NOMFOR').AsString , 40)      + //148 - 187 - NOME DO SACADOR
                            fPadL(' '                                           , 53, ' ');  //188 - 240 - USO EXCLUSIVO FEBRABAN/CNAB

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {******************************}
            Writeln(txtTexto,strTransacao);

            {****************}
            {* GRAVA LOGCTP *}
            {****************}
            pGravaLogCTP(qryRemessa);

            qryRemessa.Next;
          End;

        {***************************************************}
        {* TRAILLER DO LOTE (TÍTULOS DO Banrisul) => Reg 5 *}
        {***************************************************}
        Inc(intCodSeq1);
        Inc(intCodSeq1);
        strTraillerLot := '';
        strTraillerLot := fPadR      ('041'                , 003)       + //001 - 003
                          fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                          fPadR      ('5'                  , 001)       + //008 - 008
                          fPadR      (' '                  , 009)       + //009 - 017
                          fPadL      (IntToStr(intCodSeq1) , 006, '0')  + //018 - 023
                          fValNumForm(fltValPag1           , 018)       + //024 - 041
                          fStrZero   ('0'                  , 018)       + //042 - 059
                          fStrZero   ('0'                  , 006)       + //060 - 065
                          fPadR      (' '                  , 165)       + //066 - 230
                          fPadR      (' '                  , 010);        //231 - 240

        {*************************************}
        {* ESCREVE O TRAILLER DO LOTE NO TXT *}
        {*************************************}
        Writeln(txtTexto, strTraillerLot);
        Inc(intIndLot);
      End;

      {***************************************************************}
      {*   FILTRA OS REGISTROS DOS BANCOS DIFERENTES  DE BANRISUL    *}
      {***************************************************************}
      qryRemessa.Filtered := False;
      qryRemessa.Filter   := ' CODBAN <> ' + QuotedStr('041') +
                             ' AND ((PGI_Q_GUIA = "") OR (PGI_Q_GUIA IS NULL)) '+
                             ' AND PGI_TIPPAG = "" AND FORMAPAGTO <> ' + QuotedStr('DEP');
      qryRemessa.Filtered := True;

      intCodSeq2 := 0;

      If Not qryRemessa.IsEmpty Then
      Begin
        Inc(intTotLot);

        intIndLot := IIF( intIndLot = 0, 1, intIndLot );

        {********************************************************************}
        {* HEADER DO LOTE (TÍTULOS DE OUTROS BANCOS) => REG 1 => SEGMENTO J *}
        {********************************************************************}
        strHeaderLot := '';
        strHeaderLot := fPadR   ('041'                          , 003)      + //001 - 003
                        fPadR   (fStrZero(intIndLot,4)          , 004)      + //004 - 007
                        fPadR   ('1'                            , 001)      + //008 - 008
                        fPadL   ('C'                            , 001)      + //009 - 009
                        fPadR   ('20'                           , 002)      + //010 - 011
                        fPadR   ('31'                           , 002)      + //012 - 013
                        fPadR   ('105'                          , 003)      + //014 - 016
                        fPadL   (' '                            , 001)      + //017 - 017
                        fPadR   (IntToStr(intTipIns)            , 001)      + //018 - 018
                        fPadL   (strCgcEmp                      , 014, '0') + //019 - 032
                        fStrZero(strCodConv                     , 006)      + //033 - 038
                        fPadL   (' '                            , 014)      + //039 - 052
                        fPadL   (strCodAgen                     , 005, '0') + //053 - 057
                        fPadR   (strDigAgen                     , 001)      + //058 - 058
                        fPadL   (strContCor                     , 012, '0') + //059 - 070
                        fPadR   (strDigCnt                      , 001)      + //071 - 071
                        fPadL   ('0'                            , 001, '0') + //072 - 072
                        fPadR   (fTiraCaracEspeciais(strNomEmp) , 030, ' ') + //073 - 102
                        fPadL   (' '                            , 030)      + //103 - 132
                        fPadL   (' '                            , 010)      + //133 - 142
                        fPadR   (fTiraCaracEspeciais(strEndEmp) , 030, ' ') + //143 - 172
                        fPadL   (strNumEmp                      , 005, '0') + //173 - 177
                        fPadR   (fTiraCaracEspeciais(strComEmp) , 015, ' ') + //178 - 192
                        fPadR   (fTiraCaracEspeciais(strCidEmp) , 020, ' ') + //193 - 212
                        fPadL   (strCepEmp                      , 008, '0') + //213 - 220
                        fPadR   (strEstEmp                      , 002, ' ') + //221 - 222
                        fPadR   ('VD'                           , 002)      + //223 - 224
                        fPadR   (' '                            , 006)      + //225 - 230
                        fPadR   (' '                            , 010);       //231 - 240

        {****************************}
        {* ESCREVE O HEADER DO LOTE *}
        {*************************KP*}
        Writeln(txtTexto, strHeaderLot);

        {***************************************************************************}
        {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG = 3 => SEGMENTO J *}
        {************************************************************************KP*}

          strTransacao := '';
          fltValPag2   := 0;
          fltValOutrasEntidades := 0;

          While Not qryRemessa.Eof Do
          Begin
            Inc(intCodSeq2);

            Application.ProcessMessages;

            strDtaVen := FormatDateTime(  'dd',qryRemessa.FieldByName('PGI_DTAVEN').AsDateTime) +
                         FormatDateTime(  'mm',qryRemessa.FieldByName('PGI_DTAVEN').AsDateTime) +
                         FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTAVEN').AsDateTime);

            strDtaEmi := FormatDateTime(  'dd',qryRemessa.FieldByName('PGI_DTACAD').AsDateTime) +
                         FormatDateTime(  'mm',qryRemessa.FieldByName('PGI_DTACAD').AsDateTime) +
                         FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTACAD').AsDateTime);

            strDtaPag := FormatDateTime(  'dd',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                         FormatDateTime(  'mm',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                         FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime);

            strAutInc := qryRemessa.FieldByName('PGI_AUTOIN').AsString;

            fltValPag2 := fltValPag2 + qryRemessa.FieldByName('PGI_VALPAG').AsFloat;

            intTipInsFor := IIF( Length(qryRemessa.FieldByName('CODCGC').AsString) > 11, 2, 1);

            strTransacao := fPadR      ('041'                                                                    , 03)      + //001 - 003
                            fPadR      (fStrZero(intIndLot,4)                                                    , 04)      + //004 - 007
                            fPadR      ('3'                                                                      , 01)      + //008 - 008
                            fPadL      (IntToStr(intCodSeq2)                                                     , 05, '0') + //009 - 013
                            fPadR      ('J'                                                                      , 01)      + //014 - 014
                            fStrZero   ('0'                                                                      , 01)      + //015 - 015
                            fStrZero   ('0'                                                                      , 02)      + //016 - 017
                            fPadL      (qryRemessa.FieldByName('PGI_CODBAR').AsString                            , 44, '0') + //018 - 061
                            fPadR      (fTiraCaracEspeciais(qryRemessa.FieldByName('FOR_NOMFOR').AsString, true) , 30, ' ') + //062 - 091
                            fPadR      (strDtaVen                                                                , 08)      + //092 - 099
                            fValNumForm(qryRemessa.FieldByName('PGI_VALDUP').AsFloat                             , 15)      + //100 - 114
                            fValNumForm(qryRemessa.FieldByName('PGI_VALDES').AsFloat                             , 15)      + //115 - 129
                            fValNumForm(qryRemessa.FieldByName('PGI_VALJUR').AsFloat                             , 15)      + //130 - 144
                            fPadR      (strDtaPag                                                                , 08)      + //145 - 152
                            fValNumForm(qryRemessa.FieldByName('PGI_VALPAG').AsFloat                             , 15)      + //153 - 167
                            fStrZero   ('0'                                                                      , 15)      + //168 - 182
                            fPadL      (strAutInc                                                                , 20, '0') + //183 - 202
                            fPadL      (' '                                                                      , 20)      + //203 - 222
                            fPadL      ('09'                                                                     ,  2)      + //223 - 224
                            fPadL      (' '                                                                      ,  6)      + //225 - 230
                            fPadL      (' '                                                                      , 10);       //231 - 240

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************KP*}
            Writeln(txtTexto, strTransacao);
            Inc(intCodSeq2);

            {***********************************************************}
            {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) SEGMENTO J-52 *}
            {*REQ. 156718********************************************MO*}

            strTransacao := fPadR('041'                                        , 03)      + //001 - 003 - CÓDIGO DO BANCO NA COMPENSAÇÃO
                            fPadR(fStrZero(intIndLot,4)                        , 04)      + //004 - 007 - LOTE DE SERVIÇO
                            fPadR('3'                                          , 01)      + //008 - 008 - TIPO DE REGISTRO
                            fPadL(IntToStr(intCodSeq2)                         , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                            fPadR('J'                                          , 01)      + //014 - 014 - CÓD. SEGMENTO DO REGISTRO DETALHE
                            fPadL(' '                                          , 01)      + //015 - 015 - USO EXCLUSIVO FEBRABAN/CNAB
                            fPadL('01'                                         , 02)      + //016 - 017 - CÓDIGO DE MOVIMENTO REMESSA
                            fPadL('52'                                         , 02)      + //018 - 019 - IDENTIFICAÇÃO REGISTRO OBRIGATÓRIO
                            fPadR(IntToStr(intTipIns)                          , 01)      + //020 - 020 - TIPO DE INSCRIÇÃO DO SACADO
                            fPadL(strCgcEmp                                    , 15, '0') + //021 - 035 - NÚMERO DE INSCRIÇÃO DO SACADO
                            fPadR(strNomEmp                                    , 40)      + //036 - 075 - NOME DO SACADO
                            fPadR(IntToStr(intTipInsFor)                       , 01)      + //076 - 076 - TIPO DE INSCRIÇÃO DO CEDENTE
                            fPadL(qryRemessa.FieldByName('CODCGC').AsString    , 15, '0') + //077 - 091 - NÚMERO DE INSCRIÇÃO DO CEDENTE
                            fPadR(qryRemessa.FieldByName('FOR_NOMFOR').AsString, 40)      + //092 - 131 - NOME DO CEDENTE
                            fPadR(IntToStr(intTipInsFor)                       , 01)      + //132 - 132 - TIPO DE INSCRIÇÃO DO SACADOR
                            fPadL(qryRemessa.FieldByName('CODCGC').AsString    , 15, '0') + //133 - 147 - NÚMERO DE INSCRIÇÃO DO SACADOR
                            fPadR(qryRemessa.FieldByName('FOR_NOMFOR').AsString, 40)      + //148 - 187 - NOME DO SACADOR
                            fPadL(' '                                          , 53, ' ');  //188 - 240 - USO EXCLUSIVO FEBRABAN/CNAB

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************MO*}
            Writeln(txtTexto,strTransacao);

            {****************}
            {* GRAVA LOGCTP *}
            {****************}
            pGravaLogCTP(qryRemessa);

            qryRemessa.Next;
          End;

        {********************************************************}
        {* TRAILLER DO LOTE (TÍTULOS DE OUTROS BANCOS) => Reg 5 *}
        {*****************************************************KP*}
        Inc(intCodSeq2);
        Inc(intCodSeq2);
        strTraillerLot := '';
        strTraillerLot := fPadR      ('041'                , 003)       + //001 - 003
                          fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                          fPadR      ('5'                  , 001)       + //008 - 008
                          fPadR      (' '                  , 009)       + //009 - 017
                          fPadL      (IntToStr(intCodSeq2) , 006, '0')  + //018 - 023
                          fValNumForm(fltValPag2           , 018)       + //024 - 041
                          fStrZero   ('0'                  , 018)       + //042 - 059
                          fStrZero   ('0'                  , 006)       + //060 - 065
                          fPadR      (' '                  , 165)       + //066 - 230
                          fPadR      (' '                  , 010);        //231 - 240

        {*************************************}
        {* ESCREVE O TRAILLER DO LOTE NO TXT *}
        {**********************************KP*}
        Writeln(txtTexto,strTraillerLot);
        Inc(intIndLot);
      End;

      {***************************************************************}
      {* GERAÇÃO DO TED DE 041 PARA 041 E 041 PARA DIFERENTES BANCOS *}
      {* REGISTRO - C                                                *}
      {***************************************************************}
      intCodSeqTED      := 0;
      intCodSeqGeralTED := 0;
      pGeraTED(qryRemessa, True);
      pGeraTED(qryRemessa, False);

      {**************************************************************************}
      {* GERAÇÃO DO REGISTROS DE ->>> CONCESSIONÁRIAS(ARRECADAÇÕES)             *}
      {* REGISTRO - O -> TRIBUTOS E ARRECADAÇÕES *** COM *** CODIGO DE BARRAS   *}
      {**************************************************************************}
      bck_intCodSeq3 := 0;
      pGeraConcessionariasTributos(qryRemessa, True);
      bck_intCodSeq3 := intCodSeq3;

      {**************************************************************************}
      {* GERAÇÃO DO REGISTROS DE ->>> TRIBUTOS                                  *}
      {* REGISTRO - O -> TRIBUTOS E ARRECADAÇÕES *** COM *** CODIGO DE BARRAS   *}
      {**************************************************************************}
      pGeraConcessionariasTributos(qryRemessa, False);
      bck_intCodSeq3 := bck_intCodSeq3 + intCodSeq3;


      {**************************************************************************}
      {* GERAÇÃO DOS REGISTROS DE TRIBUTOS                                      *}
      {* REGISTRO - N -> TRIBUTOS E IMPOSTOS *** SEM *** CODIGO DE BARRAS       *}
      {**************************************************************************}
      pGeraTributos(qryRemessa);
      bck_intCodSeq3 := bck_intCodSeq3 + intCodSeqTributos;  //PEGA O TOTAL DE CODSEQ3 GERADO NA PROCEDURE TRIBUTOS

      intCodSeq3 := bck_intCodSeq3;

      {********************************}
      {* TRAILLER DO ARQUIVO => Reg 9 *}
      {*****************************AF*}
      intCodSeqGer:= intCodSeq1 + intCodSeq2 + intCodSeq3 + intCodSeqGeralTED + 2;
      strTrailler := '';
      strTrailler := fPadR   ('041'                 , 003)      + //001 - 003
                     fPadR   ('9999'                , 004)      + //004 - 007
                     fPadR   ('9'                   , 001)      + //008 - 008
                     fPadR   (' '                   , 009)      + //009 - 017
                     fPadL   (IntToStr(intTotLot)   , 006, '0') + //018 - 023
                     fPadL   (IntToStr(intCodSeqGer), 006, '0') + //024 - 029
                     fPadL   ('0'                   , 006, '0') + //030 - 035
                     fPadR   (' '                   , 205);       //036 - 240

      {****************************************}
      {* ESCREVE O TRAILLER DO ARQUIVO NO TXT *}
      {*************************************AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADPGI          ';
      strSQL := strSQL + ' WHERE PGI_CODBCO = :CODBCO ';

      qryRemessa.Close;
      qryRemessa.SQL.Clear;
      qryRemessa.SQL.Add(strSQL);
      qryRemessa.ParamByName('CODBCO').AsString := strCodBco;
      qryRemessa.ExecSQL;
      qryRemessa.Close;

      pBackupCnfBco;

      If fCommit then
		     fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
				           'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

    End
    Else
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);

		FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);

	Except
	  On E: Exception Do
	  Begin

		  fRollBack;

		  While FileExists(strFilePath) do
		  Begin
			  DeleteFile(strFilePath);
		  End;

		  FreeAndNil(qryRemessa);
      FreeAndNil(qryFormaPgto);
		  FreeAndNil(qryConsultaGen);
		  pMensagensErro(E.Message,  '[untExpArqRemBanrisulCta.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');

		End;

  End;

end;

Procedure TfrmExpArqRemBanrisulCta240.pGravaLogCTP(GenQryRemessa : TUniQuery);
Begin

    {****************}
    {* GRAVA LOGCTP *}
    {****************}
    objRep := TCadPagRepository.Create;
    objPag := objRep.fRetDuplicata(GenQryRemessa.FieldByName('PGI_NUMDUP').AsString,
                                   GenQryRemessa.FieldByName('PGI_PARCEL').AsString,
                                   GenQryRemessa.FieldByName('PGI_SEQBAI').AsInteger,
                                   GenQryRemessa.FieldByName('PGI_CODEMP').AsString,
                                   GenQryRemessa.FieldByName('PGI_CODFOR').AsString,
                                   GenQryRemessa.FieldByName('PGI_SERIE_').AsString);

    If Assigned(objPag) Then
    begin
       strGetCodFor := objPag.objCodFor.FOR_CODFOR;
       untLogCtp.pGravaLogCtp(objPag, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - ' + strCodBco, Self.Name);
    end;

    If Assigned(objRep) Then
       FreeAndNil(objRep);

End;

function TfrmExpArqRemBanrisulCta240.fRetEmpresa: String;
  Var
    intCount  : Integer;
    arrResult : Array Of String;
    qryCadEmp : TUniQuery;

Begin

  qryCadEmp := fCriaQuery(Self);
  qryCadEmp.Close;
  qryCadEmp.SQL.Clear;
  qryCadEmp.SQL.Add('SELECT * FROM CADEMP');
  qryCadEmp.Open;

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

procedure TfrmExpArqRemBanrisulCta240.pGeraTED(qryTED: TUniQuery; blnBancoDiferente: Boolean);
begin

  qryTED.Filtered := False;
  qryTED.Filter   := ' CODBAN = ' + QuotedStr('041') +
                     ' AND FORMAPAGTO = ' + QuotedStr('DEP') +
                     ' AND CODBCO ' + IIF(blnBancoDiferente, ' <> ', ' = ') + QuotedStr('041') +
                     ' AND ((PGI_Q_GUIA = '''') OR (PGI_Q_GUIA IS NULL)) ';
  qryTED.Filtered := True;

  If Not qryTED.IsEmpty Then
  Begin

    intCodSeqRegTED := 0;
    intCodSeqTED    := 0;
    Inc(intTotLot);
    Inc(intCodSeqTED);

    {*********************************************************************}
    {* HEADER DO LOTE (Pagamento através de crédito em conta, cheque, OP, }
    {* DOC, TED ou pagamento com autenticação) => REG 1 => SEGMENTO C    *}
    {******************************************************************MO*}
    strHeaderLot := '';
    strHeaderLot := fPadR   ('041'              , 003)                 + //001 - 003 - CÓD. DO BANCO
                    fPadR   (fStrZero(intIndLot,4), 004)               + //004 - 007 - LOTE DO SERVIÇO
                    fPadR   ('1'                , 001)                 + //008 - 008 - TIPO DE REGISTRO
                    fPadL   ('C'                , 001)                 + //009 - 009 - TIPO DE OPERAÇÃO
                    fPadR   ('20'               , 002)                 + //010 - 011 - TIPO DO SERVIÇO
                    fPadR   (IIF(blnBancoDiferente, '41', '01') , 002) + //012 - 013 - FORMA DE LANÇAMENTO
                    fPadR   ('105'              , 003)                 + //014 - 016 - Nº DA VERSÃO DO LAYOUT DO LOTE
                    fPadL   (' '                , 001)                 + //017 - 017 - USO EXCLUSIVO FEBRABAN
                    fPadR   (IntToStr(intTipIns), 001)                 + //018 - 018 - TIPO DE INSCRIÇÃO DA EMPRESA
                    fPadL   (strCgcEmp          , 014, '0')            + //019 - 032 - Nº DE INSCRIÇÃO DA EMPRESA
                    fPadR   (strCodConv         , 006)                 + //033 - 052 - CÓD. DO CONVÊNIO NO BANCO
                    fPadL   (' '                , 014)                 + //017 - 017 - BRANCOS
                    fPadL   (strCodAgen         , 005, '0')            + //053 - 057 - AG. MANTENEDORA DA CONTA
                    fPadR   (strDigAgen         , 001)                 + //058 - 058 - DIG. BERIFICADOR DA AGÊNCIA
                    fPadL   (strContCor         , 012, '0')            + //059 - 070 - Nº DA CONTA CORRENTE
                    fPadR   (strDigCnt          , 001)                 + //071 - 071 - DIGITO VERIFICADOR DA CONTA
                    fPadL   ('0'                , 001, '0')            + //072 - 072 - DIGITO VERIFICADOR DA AG/CONTA
                    fPadR   (strNomEmp          , 030, ' ')            + //073 - 102 - NOME DA EMPRESA
                    fPadL   (' '                , 030)                 + //103 - 132
                    fPadL   (' '                , 010)                 + //133 - 142
                    fPadR   (strEndEmp          , 030, ' ')            + //143 - 172 - NOME DA RUA, AV, PÇA, ETC
                    fPadL   (strNumEmp          , 005, '0')            + //173 - 177 - Nº DO LOCAL
                    fPadR   (strComEmp          , 015, ' ')            + //178 - 192 - CASA, APTO, SALA, ETC
                    fPadR   (strCidEmp          , 020, ' ')            + //193 - 212 - NOME DA CIDADE
                    fPadL   (strCepEmp          , 008, '0')            + //213 - 220 - CEP + COMPLEMENTO DO CEP
                    fPadR   (strEstEmp          , 002, ' ')            + //221 - 222 - SIGLA DO ESTADO
                    fPadR   ('VD'               , 002)                 + //223 - 224 - INDICATIVO DE FORMA DE PAGAMENTO DO SERVIÇO
                    fPadR   (' '                , 006)                 + //225 - 230 - USO EXCLUSIVO FEBRABAN
                    fPadR   (' '                , 010);                  //231 - 240 - CPDIGO DAS OCORRÊNCIAS P/ RETORNO

    {****************************}
    {* ESCREVE O HEADER DO LOTE *}
    {*************************MO*}
    Writeln(txtTexto,strHeaderLot);

    strTransacao := '';
    fltValPag4   := 0;

    While Not qryTED.Eof Do
    Begin
      Inc(intCodSeqTED);
      Inc(intCodSeqRegTED);

      If Length(qryTED.FieldByName('CODCGC').AsString) > 11 Then
         intTipInsFor := 2
      Else
         intTipInsFor := 1;

      strCgcFor    := qryTED.FieldByName('CODCGC').AsString;
      strEndFor    := qryTED.FieldByName('ENDERE').AsString;
      strNumFor    := qryTED.FieldByName('NUMERO').AsString;
      strComFor    := qryTED.FieldByName('COMPLEMENTO').AsString;
      strBairroFor := qryTED.FieldByName('BAIRRO').AsString;
      strCidFor    := qryTED.FieldByName('CIDADE').AsString;
      strCepFor    := fTiraCaracEspeciais(qryTED.FieldByName('C_E_P_').AsString);
      strEstFor    := qryTED.FieldByName('ESTADO').AsString;
      strCamCentralizadora := qryTED.FieldByName('CAMCEN').AsString;
      strAvisoTed  := '0';

      Application.ProcessMessages;

      strDtaVen := FormatDateTime(  'dd',qryTED.FieldByName('PGI_DTAVEN').AsDateTime) +
                   FormatDateTime(  'mm',qryTED.FieldByName('PGI_DTAVEN').AsDateTime) +
                   FormatDateTime('yyyy',qryTED.FieldByName('PGI_DTAVEN').AsDateTime);

      strDtaEmi := FormatDateTime(  'dd',qryTED.FieldByName('PGI_DTACAD').AsDateTime) +
                   FormatDateTime(  'mm',qryTED.FieldByName('PGI_DTACAD').AsDateTime) +
                   FormatDateTime('yyyy',qryTED.FieldByName('PGI_DTACAD').AsDateTime);

      strDtaPag := FormatDateTime(  'dd',qryTED.FieldByName('PGI_DTAPAG').AsDateTime) +
                   FormatDateTime(  'mm',qryTED.FieldByName('PGI_DTAPAG').AsDateTime) +
                   FormatDateTime('yyyy',qryTED.FieldByName('PGI_DTAPAG').AsDateTime);

      strAutInc  := qryTED.FieldByName('PGI_AUTOIN').AsString;

      fltValPag4 := fltValPag4 + qryTED.FieldByName('PGI_VALPAG').AsFloat;

      {**************}
      {* SEGMENTO A *}
      {**************}
      strTransacao := fPadR      ('041'                                    , 03)      + //001 - 003 - CÓD. DO BANCO
                      fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007 - LOTE DE SERVIÇO
                      fPadR      ('3'                                      , 01)      + //008 - 008 - TIPO DE REGISTRO
                      fPadL      (IntToStr(intCodSeqRegTED)                , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                      fPadR      ('A'                                      , 01)      + //014 - 014 - CÓD. DE SEGMENTO NO REG. DETALHE
                      fStrZero   ('0'                                      , 01)      + //015 - 015
                      fStrZero   (strCodMovimento                          , 02)      + //016 - 017
                      fPadL      (strCamCentralizadora                     , 03, '0') + //018 - 020 - CÓD. DA CÂMARA CENTRALIZADORA
                      fPadL      (qryTED.FieldByName('CODBCO').AsString    , 03, '0') + //021 - 023 - CÓD. DO BANCO DO FAVORECIDO
                      fPadL      (qryTED.FieldByName('CODAGE').AsString    , 05, '0') + //024 - 028 - AG. MANTENEDORA DA CTA. DO FAVOR.
                      fPadR      (qryTED.FieldByName('DIGAGE').AsString    , 01, ' ') + //029 - 029 - DÍGITO VERIFICADOR DA AGÊNCIA
                      fPadL      (qryTED.FieldByName('NUMCTA').AsString    , 12, '0') + //030 - 041 - Nº DA CONTA CORRENTE
                      fPadR      (qryTED.FieldByName('DIGCTA').AsString    , 01, ' ') + //042 - 042 - DÍGITO VERIFICADOR DA CONTA
                      fPadR      (qryTED.FieldByName('DIGVER').AsString    , 01, ' ') + //043 - 043 - DÍGITO VERIFICADOR AG/CONTA
                      fPadR      (qryTED.FieldByName('FOR_NOMFOR').AsString, 30, ' ') + //044 - 073 - NOME DO FAVORECIDO
                      fPadL      (strAutInc                                , 20, ' ') + //074 - 093 - Nº DO DOCUMENTO ATRIBUIDO P/ EMPRESA
                      fPadR      (strDtaPag                                , 08)      + //094 - 101 - DATA DO PAGAMENTO
                      fPadR      ('BRL'                                    , 03)      + //102 - 104 - TIPO DA MOEDA
                      fStrZero   ('0'                                      , 15)      + //105 - 119 - QUANTIDADE DA MOEDA
                      fValNumForm(qryTED.FieldByName('PGI_VALPAG').AsFloat , 15)      + //120 - 134 - VALOR DO PAGAMENTO
                      fPadL      (' '                                      , 20)      + //135 - 154 - Nº DO DOCUM. ATRIBUIDO PELO BANCO
                      fPadR      (strDtaPag                                , 08)      + //155 - 162 - DATA REAL DA EFETIVAÇÃO DO PAGTO.
                      fValNumForm(qryTED.FieldByName('PGI_VALPAG').AsFloat , 15)      + //163 - 177 - VALOR REAL DA EFETIVAÇÃO DO PAGTO.
                      fPadL      (' '                                      , 40)      + //178 - 217 - OUTRAS INFORMAÇÕES
                      fPadR      ('07'                                     , 02)      + //218 - 219 - COMPL. TIPO SERVIÇO
                      fPadR      (qryTED.FieldByName('PGI_CODTED').AsString, 05)      + //220 - 224 - CÓDIGO FINALIDADE DA TED
                      fPadR      (qryTED.FieldByName('COMPDES').AsString   , 02)      + //225 - 226 - COMPL. FINALIDADE DE PAGAMENTO
                      fPadR      (' '                                      , 03, ' ') + //227 - 229 - USO EXCLUSIVO DA FEBRABAN
                      fPadR      (strAvisoTed                              , 01)      + //230 - 230 - AVISO AO FAVORECIDO
                      fPadR      (' '                                      , 010);      //231 - 240 - CÓDIGOS DAS OCORRÊNCIAS P/ RETORNO

      {******************************}
      {* ESCREVE A TRANSACAO NO TXT *}
      {***************************JU*}
      Writeln(txtTexto,strTransacao);
      Inc(intCodSeqRegTED);

      {**************}
      {* SEGMENTO B *}
      {**************}
      Inc(intCodSeqTED);
      strTransacao := '';
      strTransacao := fPadR      ('041'                                    , 03)      + //001 - 003 - CÓD. DO BANCO
                      fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007 - LOTE DE SERVIÇO
                      fPadR      ('3'                                      , 01)      + //008 - 008 - TIPO DE REGISTRO
                      fPadL      (IntToStr(intCodSeqRegTED)                , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                      fPadR      ('B'                                      , 01)      + //014 - 014 - CÓD. DE SEGMENTO NO REG. DETALHE
                      fPadR      (' '                                      , 03)      + //015 - 017 - CÓD. DA INSTRUÇÃO P/ MOVIMENTO
                      fPadR      (IntToStr(intTipInsFor)                   , 001)     + //018 - 018 - TIPO DE INSCRIÇÃO DO FAVORECIDO
                      fPadL      (strCgcFor                                , 14, '0') + //019 - 032 - Nº DE INSCRIÇÃO DO FAVORECIDO
                      fPadR      (strEndFor                                , 30, ' ') + //033 - 062 - NOME DA RUA, AV, PÇA, ETC
                      fPadR      (strNumFor                                , 05, ' ') + //063 - 067 - Nº DO LOCAL
                      fPadR      (strComFor                                , 15, ' ') + //068 - 082 - COMPLEMENTO
                      fPadR      (strBairroFor                             , 15, ' ') + //083 - 097 - BAIRRO
                      fPadR      (strCidFor                                , 20, ' ') + //098 - 117 - NOME DA CIDADE
                      fPadR      (strCepFor                                , 08, '0') + //118 - 125 - CEP
                      fPadR      (strEstFor                                , 02, ' ') + //126 - 127 - ESTADO
                      fPadL      (strDtaVen                                , 08, '0') + //128 - 135 - DATA DO VENCIMENTO
                      fValNumForm(qryTED.FieldByName('PGI_VALDUP').AsFloat , 15)      + //136 - 150 - VALOR DO DOCUMENTO
                      fValNumForm(qryTED.FieldByName('PGI_VALPAG').AsFloat , 15)      + //151 - 165 - VALOR DO ABATIMENTO
                      fValNumForm(qryTED.FieldByName('PGI_VALDES').AsFloat , 15)      + //166 - 180 - VALOR DO DESCONTO
                      fStrZero   ('0'                                      , 15)      + //181 - 195 - VALOR DA MORA
                      fValNumForm(qryTED.FieldByName('PGI_VALJUR').AsFloat , 15)      + //196 - 210 - VALOR DO MULTA
                      fPadR      (qryTED.FieldByName('PGI_NUMDUP').AsString, 15, ' ') + //211 - 225 - Nº DO DOCUMENTO
                      fPadR      (strAvisoTed                              , 01)      + //226 - 226 - AVISO AO FAVORECIDO
                      fStrZero   ('0'                                      , 06)      + //227 - 232 - USO EXCLUSIVO PARA O SIAPE strTipInsFor
                      fStrZero   ('0'                                      , 08);  //233 - 240 - CÓDIGO DO ISPB

      {******************************}
      {* ESCREVE A TRANSACAO NO TXT *}
      {***************************JU*}
      Writeln(txtTexto,strTransacao);

      {****************}
      {* GRAVA LOGCTP *}
      {*************JS*}
      pGravaLogCTP( qryTED );

      qryTED.Next;
    End;

    {*****************************}
    {* TRAILLER DO LOTE => Reg 5 *}
    {**************************MO*}
    Inc(intCodSeqTED);
    strTraillerLot := '';
    strTraillerLot := fPadR      ('041'                 , 003)      + //001 - 003 - CÓD. DO BANCO NA COMPENSAÇÃO
                      fPadR      (fStrZero(intIndLot,4) , 004)      + //004 - 007 - LOTE DE SERVIÇO
                      fPadR      ('5'                   , 001)      + //008 - 008 - TIPO DE REGISTRO
                      fPadR      (' '                   , 009)      + //009 - 017 - USO EXCLUSIVO FEBRABAN
                      fPadL      (IntToStr(intCodSeqTED), 006, '0') + //018 - 023 - QUANTIDADE DE REGISTROS DO LOTE
                      fValNumForm(fltValPag4            , 018)      + //024 - 041 - SOMATÓRIA DE VALORES
                      fStrZero   ('0'                   , 018)      + //042 - 059 - SOMATÓRIA DE QUANTIDADE DE MOEDAS
                      fStrZero   ('0'                   , 006)      + //060 - 065 - N° AVISO DE DÉBITO
                      fPadR      (' '                   , 165)      + //066 - 230 - USO EXCLUSIVO FEBRABAN
                      fPadR      (' '                   , 010);       //231 - 240 - CÓDIGOS DAS OCORRÊNCIAS P/ RETORNO

    Inc(intIndLot);
    intCodSeqGeralTED := intCodSeqGeralTED + intCodSeqTED;

    {*************************************}
    {* ESCREVE O TRAILLER DO LOTE NO TXT *}
    {**********************************MO*}
    Writeln(txtTexto,strTraillerLot);
  End;
end;

procedure TfrmExpArqRemBanrisulCta240.HeaderConcessionariaTributos(AFormaLancamento: String);
begin
  Inc(intTotLot);

  {********************************************************************************************************}
  {* HEADER DO LOTE (Pagamento de Concessionárias e tributos com código de barras) => REG 1 => SEGMENTO O *}
  {*****************************************************************************************************KP*}
  strHeaderLot := '';
  strHeaderLot := fPadR   ('041'              , 003)      + //001 - 003
                  fPadR   (fStrZero(intIndLot,4), 004)    + //004 - 007
                  fPadR   ('1'                , 001)      + //008 - 008
                  fPadL   ('C'                , 001)      + //009 - 009
                  fPadR   ('22'               , 002)      + //010 - 011
                  fPadR   (AFormaLancamento   , 002)      + //012 - 013
                  fPadR   ('105'              , 003)      + //014 - 016
                  fPadL   (' '                , 001)      + //017 - 017
                  fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                  fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                  fPadR   (strCodConv         , 006)      + //033 - 038
                  fPadL   (' '                , 014)      + //039 - 052
                  fPadL   (strCodAgen         , 005, '0') + //053 - 057
                  fPadR   (strDigAgen         , 001)      + //058 - 058
                  fPadL   (strContCor         , 012, '0') + //059 - 070
                  fPadR   (strDigCnt          , 001)      + //071 - 071
                  fPadL   (' '                , 001, ' ') + //072 - 072
                  fPadR   (strNomEmp          , 030, ' ') + //073 - 102
                  fPadL   (' '                , 040)      + //103 - 142
                  fPadR   (strEndEmp          , 030, ' ') + //143 - 172
                  fPadL   (strNumEmp          , 005, '0') + //173 - 177
                  fPadR   (strComEmp          , 015, ' ') + //178 - 192
                  fPadR   (strCidEmp          , 020, ' ') + //193 - 212
                  fPadL   (strCepEmp          , 008, '0') + //213 - 220
                  fPadR   (strEstEmp          , 002, ' ') + //221 - 222
                  fPadR   ('VD'               , 002)      + //223 - 224
                  fPadR   (' '                , 006)      + //225 - 230
                  fPadR   (' '                , 010);       //231 - 240

  {****************************}
  {* ESCREVE O HEADER DO LOTE *}
  {*************************KP*}
  Writeln(txtTexto,strHeaderLot);
end;

procedure TfrmExpArqRemBanrisulCta240.pGeraConcessionariasTributos(qryConc: TUniQuery; blnConcessionaria : Boolean);
begin

      {****************************}
      {* FILTRANDO CONCESSIONARIA *}
      {****************************}
      qryConc.Filtered := False;
      qryConc.Filter   := ' CODBAN <> ' + QuotedStr('041') +
                           IIF(blnConcessionaria, ' AND PGI_TIPPAG = 3 ', ' AND (PGI_TIPPAG <> "" AND PGI_TIPPAG <> 3) ' ) +
                          ' AND (FORMAPAGTO <> ' + QuotedStr('DEP') +
                          '  OR ((PGI_Q_GUIA <> '''') OR (PGI_Q_GUIA IS NOT NULL))) ';
      qryConc.Filtered := True;

      intCodSeq3 := 0;

      If Not qryConc.IsEmpty Then
      Begin

          strTransacao          := '';
          fltValPag2            := 0;
          intCodSeq3            := 0;
          fltValOutrasEntidades := 0;

          {***********************************************************}
          {* HEADER LOTE CONCESSIONÁRIAS                             *}
          {*                                                         *}
          {* 11 - PAGAMENTO DE CONTAS E TRIBUTOS COM CÓDIGO DE BRRAS *}
          {***********************************************************}
          HeaderConcessionariaTributos('11');

          While Not qryConc.Eof Do
          Begin
            {*****************************************************}
            {* SEPARANDO OS TRIBUTOS DOS DADOS DE CONCESSIONÁRIA *}
            {*****************************************************}
            //if fEmptyStr(qryConc.FieldByName('PGI_Q_GUIA').AsString) then
            //begin

              Inc(intCodSeq3);

              Application.ProcessMessages;

              strDtaVen := FormatDateTime(  'dd',qryConc.FieldByName('PGI_DTAVEN').AsDateTime) +
                           FormatDateTime(  'mm',qryConc.FieldByName('PGI_DTAVEN').AsDateTime) +
                           FormatDateTime('yyyy',qryConc.FieldByName('PGI_DTAVEN').AsDateTime);

              strDtaPag := FormatDateTime(  'dd',qryConc.FieldByName('PGI_DTAPAG').AsDateTime) +
                           FormatDateTime(  'mm',qryConc.FieldByName('PGI_DTAPAG').AsDateTime) +
                           FormatDateTime('yyyy',qryConc.FieldByName('PGI_DTAPAG').AsDateTime);

              strAutInc := qryConc.FieldByName('PGI_AUTOIN').AsString;

              fltValPag2 := fltValPag2 + qryConc.FieldByName('PGI_VALPAG').AsFloat;

              strTransacao := fPadR      ('041'                                               , 03)      + //001 - 003
                              fPadR      (fStrZero(intIndLot,4)                               , 04)      + //004 - 007
                              fPadR      ('3'                                                 , 01)      + //008 - 008
                              fPadL      (IntToStr(intCodSeq3)                                , 05, '0') + //009 - 013
                              fPadR      ('O'                                                 , 01)      + //014 - 014
                              fStrZero   ('0'                                                 , 01)      + //015 - 015
                              fStrZero   (strCodMovimento                                     , 02)      + //016 - 017
                              fPadL      (qryConc.FieldByName('PGI_CODBAR').AsString          , 44, '0') + //018 - 061
                              fPadR      (qryConc.FieldByName('FOR_NOMFOR').AsString          , 30, ' ') + //062 - 091
                              fPadR      (strDtaVen                                           , 08)      + //092 - 099
                              fPadR      (strDtaPag                                           , 08)      + //100 - 107
                              fValNumForm(qryConc.FieldByName('PGI_VALDUP').AsFloat           , 15)      + //108 - 122
                              fPadL      (strAutInc                                           , 20, ' ') + //123 - 142
                              fPadL      (' '                                                 , 20, ' ') + //143 - 162
                              fPadL      (' '                                                 , 68)      + //163 - 230
                              fPadL      (' '                                                 , 10);       //231 - 240

              {******************************}
              {* ESCREVE A TRANSACAO NO TXT *}
              {******************************}
              Writeln(txtTexto,strTransacao);

              {****************}
              {* GRAVA LOGCTP *}
              {****************}
              pGravaLogCTP(qryConc);

            //end;

            qryRemessa.Next;
          End;

          {********************}
          {* TRAILLER DO LOTE *}
          {********************}
          TrailerConcessionariaTributos;

      End;

End;

procedure TfrmExpArqRemBanrisulCta240.TrailerConcessionariaTributos;
begin
  {********************************************************}
  {* TRAILLER DO LOTE (CONCESSIONARIAS E TRIBUTOS)        *}
  {********************************************************}
  fltValPag2 := fltValPag2 + fltValOutrasEntidades;
  Inc(intCodSeq3);
  Inc(intCodSeq3);
  strTraillerLot := '';
  strTraillerLot := fPadR      ('041'                , 003)       + //001 - 003
                    fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                    fPadR      ('5'                  , 001)       + //008 - 008
                    fPadR      (' '                  , 009)       + //009 - 017
                    fPadL      (IntToStr(intCodSeq3) , 006, '0')  + //018 - 023
                    fValNumForm(fltValPag2           , 018)       + //024 - 041
                    fStrZero   ('0'                  , 018)       + //042 - 059
                    fStrZero   ('0'                  , 006)       + //060 - 065
                    fPadR      (' '                  , 165)       + //066 - 230
                    fPadR      (' '                  , 010);        //231 - 240


  {*************************************}
  {* ESCREVE O TRAILLER DO LOTE NO TXT *}
  {**********************************KP*}
  Writeln(txtTexto,strTraillerLot);
  Inc(intIndLot);
end;


{**********************************************}
{* CÓDIGO DOS TRIBUTOS - SEGMENTO N 111 - 116 *}
{* 16 - TRIBUTO DARF NORMAL  ******************}
{* 17 - TRIBUTO GPS          ******************}
{* 18 - TRIBUTO DARF SIMPLES ******************}
{* 22 - GARE-SP ICMS **************************}
{* 23 - GARE-SP DR ****************************}
{* 24 - GARE-SP ITCMD *************************}
{**********************************************}
procedure TfrmExpArqRemBanrisulCta240.pGeraTributos(qryTributos: TUniQuery);
var
  intRegN: Integer;
  AGerouHeader: Boolean;
  ATipoInscricao: String;
  ADate: TDateTime;
  AUltimoDiaMes: String;
  AValorTotalTributo: Double;
  strNumeroBanco: String;
  strCompet  : String;
  strCodTrib : String;
  strIdTrib  : String;
  strFiltro  : String;
begin

  intCodSeqTributos := 0;
  AGerouHeader      := False;
  ATipoInscricao    := '';

  If Length(strCgcEmp) > 11 Then
     ATipoInscricao := '1'
  Else
     ATipoInscricao := '2';

  // GERAÇÃO DOS TRIBUTOS
  {**************************************************************}
  {* Registro Detalhe – Segmento N                              *}
  {* Pagamento de Tributos e Impostos sem Código de Barras      *}
  {**************************************************************}
  strFiltro := ' CODBAN = ' + QuotedStr('041') +
               ' AND PGI_TIPPAG <> "" '+
               ' AND ( FORMAPAGTO <> ' + QuotedStr('DEP') + ' OR ((PGI_Q_GUIA <> '''') OR (PGI_Q_GUIA IS NOT NULL)) ) ';

  {**************************************************************}
  {* N1. GPS – Informações complementares para pagamento da GPS *}
  {**************************************************************}
  qryTributos.Filtered := False;
  qryTributos.Filter   := strFiltro + ' AND PGI_Q_GUIA = ' + QuotedStr('1');
  qryTributos.Filtered := True;

  If Not qryTributos.IsEmpty Then
  Begin

    With qryTributos Do
    Begin
      fltValPag2            := 0;
      strTransacao          := '';
      fltValOutrasEntidades := 0;

      While Not Eof Do
      Begin
        Inc(intCodSeq3);

        Application.ProcessMessages;

        strDtaPag  := FormatDateTime('dd',   FieldByName('PGI_DTAPAG').AsDateTime) +
                      FormatDateTime('mm',   FieldByName('PGI_DTAPAG').AsDateTime) +
                      FormatDateTime('yyyy', FieldByName('PGI_DTAPAG').AsDateTime);

        fltValPag2            := fltValPag2 + FieldByName('PGI_VALPAG').AsFloat;
        fltValOutrasEntidades := fltValOutrasEntidades + FieldByName('PGI_OUTENT').AsFloat;

        AValorTotalTributo := FieldByName('PGI_VALPAG').AsFloat + FieldByName('PGI_OUTENT').AsFloat;

        strCompet  := Copy(qryTributos.FieldByName('PGI_COMPET').asString,1,2) + Copy(qryTributos.FieldByName('PGI_COMPET').asString,4,4);

        strCodTrib := qryTributos.FieldByName('PGI_CODREC').asString;

        strNumeroBanco := FieldByName('PGI_NUMDUP').AsString +
                          FieldByName('PGI_PARCEL').AsString +
                          FieldByName('PGI_CODEMP').AsString +
                          fPadR(FieldByName('PGI_SERIE_').AsString, 3, '_');

        strIdTrib := '17';  // 17 - GPS  - (GUIA PREVIDENCIA SOCIAL);

        if Not AGerouHeader Then
        begin
          HeaderConcessionariaTributos(strIdTrib);
          AGerouHeader := True;
        end;

        strTransacao := fPadR      ('041'                                   , 03)      + //Código do Banco na Compensação              001 - 003
                        fPadR      (fStrZero(intIndLot,4)                   , 04)      + //Lote de Serviço                             004 - 007
                        fPadR      ('3'                                     , 01)      + //Tipo de Registro                            008 - 008
                        fPadL      (IntToStr(intCodSeq3)                    , 05, '0') + //Nº Sequencial do Registro no Lote           009 - 013
                        fPadR      ('N'                                     , 01)      + //Cód. Segmento do Registro Detalhe           014 - 014
                        fStrZero   ('0'                                     , 01)      + //015 - 015
                        fStrZero   (strCodMovimento                         , 02)      + //016 - 017
                        fPadR      (FieldByName('PGI_AUTOIN').AsString      , 20, ' ') + //Nº do Docto Atribuído pela Empresa          018 - 037
                        fPadR      (strNumeroBanco                          , 20, ' ') + //Nº do Docto Atribuído pelo Banco            038 - 057
                        fPadR      (strNomEmp                               , 30, ' ') + //Nome do Contribuinte                        058 - 087
                        fPadR      (strDtaPag                               , 08)      + //Data do Pagamento                           088 - 095
                        fValNumForm(AValorTotalTributo                      , 15)      + //Valor do Total do Pagamento                 096 - 110
                        fPadL      (strCodTrib                              , 06, '0') + //Código da Receita do Tributo                111 - 116 //N002
                        fPadL      (ATipoInscricao                          , 02, '0') + //Tipo de Identificação do Contribuinte       117 - 118
                        fPadL      (strCgcEmp                               , 14, '0') + //Identificação do Contribuinte               119 - 132
                        fPadL      (strIdTrib                               , 02)      + //Código de Identificação do Tributo          133 - 134 //N005
                        fPadR      (strCompet                               , 06)      + //Mês e ano de competência                    135 - 140
                        fValNumForm(FieldByName('PGI_VALPAG').AsFloat       , 15)      + //Valor previsto do pagamento do INSS         141 - 155
                        fValNumForm(FieldByName('PGI_OUTENT').AsFloat       , 15)      + //Valor de Outras Entidades                   156 - 170
                        fValNumForm(0                                       , 15)      + //Atualização Monetária                       171 - 185
                        fPadL      (' '                                     , 45)      + //Uso Exclusivo FEBRABAN/CNAB                 186 - 230
                        fPadL      (' '                                     , 10)      ; //Códigos das Ocorrências p/ Retorno          231 - 240

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************CH*}
        Writeln(txtTexto, strTransacao);

        {****************}
        {* GRAVA LOGCTP *}
        {*************CH*}
        objRep := TCadPagRepository.Create;
        objPag := objRep.fRetDuplicata(FieldByName('PGI_NUMDUP').AsString,
                                       FieldByName('PGI_PARCEL').AsString,
                                       FieldByName('PGI_SEQBAI').AsInteger,
                                       FieldByName('PGI_CODEMP').AsString,
                                       FieldByName('PGI_CODFOR').AsString,
                                       FieldByName('PGI_SERIE_').AsString);

        If Assigned(objPag) Then
        begin
          strGetCodFor := objPag.objCodFor.FOR_CODFOR;
          untLogCtp.pGravaLogCtp(objPag, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - ' + strCodBco, Self.Name);
        end;

        If Assigned(objRep) Then
          FreeAndNil(objRep);

        Next;
      End;
      {********************}
      {* TRAILLER DO LOTE *}
      {********************}
      If AGerouHeader Then
        TrailerConcessionariaTributos;
    End;

    intCodSeqTributos := intCodSeqTributos + intCodSeq3;

  End;

  {****************************************************************}
  {* N2. DARF – Informações complementares para pagamento de DARF *}
  {****************************************************************}
  qryTributos.Filtered := False;
  qryTributos.Filter   := strFiltro + ' AND PGI_Q_GUIA = ' + QuotedStr('2');
  qryTributos.Filtered := True;

  If Not qryTributos.IsEmpty Then
  Begin

    //intCodSeqTributos := intCodSeqTributos + intCodSeq3;
    intCodSeq3 := 0;

    With qryTributos Do
    Begin
      AGerouHeader := False;
      strTransacao := '';
      fltValPag2   := 0;
      fltValOutrasEntidades := 0;

      While Not Eof Do
      Begin
        Inc(intCodSeq3);

        Application.ProcessMessages;

        strDtaPag := FormatDateTime('dd', FieldByName('PGI_DTAPAG').AsDateTime) +
                     FormatDateTime('mm', FieldByName('PGI_DTAPAG').AsDateTime) +
                     FormatDateTime('yyyy', FieldByName('PGI_DTAPAG').AsDateTime);

        strDtaVen := FormatDateTime('dd', FieldByName('PGI_DTAVEN').AsDateTime) +
                     FormatDateTime('mm', FieldByName('PGI_DTAVEN').AsDateTime) +
                     FormatDateTime('yyyy', FieldByName('PGI_DTAVEN').AsDateTime);

        fltValPag2 := fltValPag2 + FieldByName('PGI_VALPAG').AsFloat;

        AValorTotalTributo := FieldByName('PGI_VALPAG').AsFloat + FieldByName('PGI_OUTENT').AsFloat;

        ADate         := EndOfTheMonth(StrToDate('01/' + qryTributos.FieldByName('PGI_COMPET').asString));
        AUltimoDiaMes := Copy(DateToStr(ADate),0,2);

        strCompet := AUltimoDiaMes +
                     Copy(qryTributos.FieldByName('PGI_COMPET').asString,1,2)+
                     Copy(qryTributos.FieldByName('PGI_COMPET').asString,4,4);

        strCodTrib := Trim(qryTributos.FieldByName('PGI_CODREC').asString);

        strNumeroBanco := FieldByName('PGI_NUMDUP').AsString +
                          FieldByName('PGI_PARCEL').AsString +
                          FieldByName('PGI_CODEMP').AsString +
                          fPadR(FieldByName('PGI_SERIE_').AsString, 3, '_');

        strIdTrib  := '16';  //16 - TRIBUTO - DARF NORMAL SEM CODIGO DE BARRAS;

        if Not AGerouHeader Then
        begin
          HeaderConcessionariaTributos(strIdTrib);
          AGerouHeader := True;
        end;


        strTransacao := fPadR      ('041'                                   , 03)      + //Código do Banco na Compensação              001 - 003
                        fPadR      (fStrZero(intIndLot,4)                   , 04)      + //Lote de Serviço                             004 - 007
                        fPadR      ('3'                                     , 01)      + //Tipo de Registro                            008 - 008
                        fPadL      (IntToStr(intCodSeq3)                    , 05, '0') + //Nº Sequencial do Registro no Lote           009 - 013
                        fPadR      ('N'                                     , 01)      + //Cód. Segmento do Registro Detalhe           014 - 014
                        fPadR      ('0'                                     , 01)      + //Tipo de Movimento                           015 - 015
                        fPadR      ('00'                                    , 02)      + //Código da Instrução de Movimento            016 - 017
                        fPadR      (FieldByName('PGI_AUTOIN').AsString      , 20, ' ') + //Nº do Docto Atribuído pela Empresa          018 - 037
                        fPadR      (strNumeroBanco                          , 20, ' ') + //Nº do Docto Atribuído pelo Banco            038 - 057
                        fPadR      (strNomEmp                               , 30, ' ') + //Nome do Contribuinte                        058 - 087
                        fPadR      (strDtaPag                               , 08)      + //Data do Pagamento                           088 - 095
                        fValNumForm(AValorTotalTributo                      , 15)      + //Valor do Total do Pagamento                 096 - 110
                        fPadL      (strCodTrib                              , 06, '0') + //Código da Receita do Tributo                111 - 116 // (N002)
                        fPadL      (ATipoInscricao                          , 02, '0') + //Tipo de Identificação do Contribuinte       117 - 118
                        fPadL      (strCgcEmp                               , 14, '0') + //Identificação do Contribuinte               119 - 132
                        fPadL      (strIdTrib                               , 02)      + //Código de Identificação do Tributo          133 - 134
                        fPadR      (strCompet                               , 08)      + //Período de Apuração                         135 - 142
                        fValNumForm(0                                       , 17)      + //Número de Referência                        143 - 159
                        fValNumForm(FieldByName('PGI_VALPAG').AsFloat       , 15)      + //Valor Principal                             160 - 174
                        fValNumForm(0                                       , 15)      + //Valor da Multa                              175 - 189
                        fValNumForm(0                                       , 15)      + //Valor dos Juros / Encargos                  190 - 204
                        fPadR      (strDtaVen                               , 08)      + //Data de Vencimento                          205 - 212
                        fPadL      (' '                                     , 18)      + //Uso Exclusivo FEBRABAN/CNAB                 213 - 230
                        fPadL      (' '                                     , 10)      ; //Códigos das Ocorrências p/ Retorno          231 - 240

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************CH*}
        Writeln(txtTexto,strTransacao);

        {****************}
        {* GRAVA LOGCTP *}
        {*************CH*}
        objRep := TCadPagRepository.Create;
        objPag := objRep.fRetDuplicata(FieldByName('PGI_NUMDUP').AsString,
                                       FieldByName('PGI_PARCEL').AsString,
                                       FieldByName('PGI_SEQBAI').AsInteger,
                                       FieldByName('PGI_CODEMP').AsString,
                                       FieldByName('PGI_CODFOR').AsString,
                                       FieldByName('PGI_SERIE_').AsString);

        If Assigned(objPag) Then
        begin
          strGetCodFor := objPag.objCodFor.FOR_CODFOR;
          untLogCtp.pGravaLogCtp(objPag, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - ' + strCodBco, Self.Name);
        end;

        If Assigned(objRep) Then
          FreeAndNil(objRep);

        Next;
      End;
      {********************}
      {* TRAILLER DO LOTE *}
      {********************}
      If AGerouHeader Then
        TrailerConcessionariaTributos;
    End;

    intCodSeqTributos := intCodSeqTributos + intCodSeq3;

  End;

  {********************************************************************************}
  {* N3. DARF Simples – Informações complementares para pagamento de DARF SIMPLES *}
  {********************************************************************************}
  qryTributos.Filtered := False;
  qryTributos.Filter   := strFiltro + ' AND PGI_Q_GUIA = ' + QuotedStr('3');
  qryTributos.Filtered := True;

  If Not qryTributos.IsEmpty Then
  Begin

    //intCodSeqTributos := intCodSeqTributos + intCodSeq3;
    intCodSeq3 := 0;

    With qryTributos Do
    Begin
      AGerouHeader := False;
      strTransacao := '';
      fltValPag2   := 0;
      fltValOutrasEntidades := 0;

      While Not Eof Do
      Begin
        strIdTrib  := '18';
        Inc(intCodSeq3);

        Application.ProcessMessages;

        strDtaPag := FormatDateTime('dd', FieldByName('PGI_DTAPAG').AsDateTime) +
                     FormatDateTime('mm', FieldByName('PGI_DTAPAG').AsDateTime) +
                     FormatDateTime('yyyy', FieldByName('PGI_DTAPAG').AsDateTime);

        fltValPag2 := fltValPag2 + FieldByName('PGI_VALPAG').AsFloat;

        AValorTotalTributo := FieldByName('PGI_VALPAG').AsFloat + FieldByName('PGI_OUTENT').AsFloat;

        strCompet := '01'+
                     Copy(qryTributos.FieldByName('PGI_COMPET').asString,1,2)+
                     Copy(qryTributos.FieldByName('PGI_COMPET').asString,4,4);

        strCodTrib := qryTributos.FieldByName('PGI_CODREC').asString;

        strNumeroBanco := FieldByName('PGI_NUMDUP').AsString +
                          FieldByName('PGI_PARCEL').AsString +
                          FieldByName('PGI_CODEMP').AsString +
                          fPadR(FieldByName('PGI_SERIE_').AsString, 3, '_');

        strIdTrib  := '18'; //TRIBUTO - 18 - DARF SIMPLES SEM CODIGO DE BARRAS;
        if Not AGerouHeader Then
        begin
          HeaderConcessionariaTributos(strIdTrib);
          AGerouHeader := True;
        end;

        strTransacao := fPadR      ('041'                                   , 03)      + //Código do Banco na Compensação              001 - 003
                        fPadR      (fStrZero(intIndLot,4)                   , 04)      + //Lote de Serviço                             004 - 007
                        fPadR      ('3'                                     , 01)      + //Tipo de Registro                            008 - 008
                        fPadL      (IntToStr(intCodSeq3)                    , 05, '0') + //Nº Sequencial do Registro no Lote           009 - 013
                        fPadR      ('N'                                     , 01)      + //Cód. Segmento do Registro Detalhe           014 - 014
                        fStrZero   ('0'                                     , 01)      + //015 - 015
                        fStrZero   (strCodMovimento                         , 02)      + //016 - 017
                        fPadR      (FieldByName('PGI_AUTOIN').AsString      , 20, ' ') + //Nº do Docto Atribuído pela Empresa          018 - 037
                        fPadR      (strNumeroBanco                          , 20, ' ') + //Nº do Docto Atribuído pelo Banco            038 - 057
                        fPadR      (strNomEmp                               , 30, ' ') + //Nome do Contribuinte                        058 - 087
                        fPadR      (strDtaPag                               , 08)      + //Data do Pagamento                           088 - 095
                        fValNumForm(AValorTotalTributo                      , 15)      + //Valor do Total do Pagamento                 096 - 110
                        fPadL      (strCodTrib                              , 06, '0') + //Código da Receita do Tributo                111 - 116
                        fPadL      (ATipoInscricao                          , 02, '0') + //Tipo de Identificação do Contribuinte       117 - 118
                        fPadL      (strCgcEmp                               , 14, '0') + //Identificação do Contribuinte               119 - 132
                        fPadL      (strIdTrib                               , 02)      + //Código de Identificação do Tributo          133 - 134
                        fPadR      (strCompet                               , 08)      + //Período de Apuração                         135 - 142
                        fValNumForm(0                                       , 15)      + //Valor da Receita Bruta Acumulada            143 - 157
                        fValNumForm(0                                       , 07)      + //Percentual sobre a Receita Bruta            158 - 164
                        fValNumForm(FieldByName('PGI_VALPAG').AsFloat       , 15)      + //Valor Principal                             165 - 179
                        fValNumForm(0                                       , 15)      + //Valor da Multa                              180 - 194
                        fValNumForm(0                                       , 15)      + //Valor dos Juros / Encargos                  195 - 209
                        fPadL      (' '                                     , 21)      + //Uso Exclusivo FEBRABAN/CNAB                 210 - 230
                        fPadL      (' '                                     , 10)      ; //Códigos das Ocorrências p/ Retorno          231 - 240

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {***************************CH*}
        Writeln(txtTexto,strTransacao);

        {****************}
        {* GRAVA LOGCTP *}
        {*************CH*}
        objRep := TCadPagRepository.Create;
        objPag := objRep.fRetDuplicata(FieldByName('PGI_NUMDUP').AsString,
                                       FieldByName('PGI_PARCEL').AsString,
                                       FieldByName('PGI_SEQBAI').AsInteger,
                                       FieldByName('PGI_CODEMP').AsString,
                                       FieldByName('PGI_CODFOR').AsString,
                                       FieldByName('PGI_SERIE_').AsString);

        If Assigned(objPag) Then
        begin
          strGetCodFor := objPag.objCodFor.FOR_CODFOR;
          untLogCtp.pGravaLogCtp(objPag, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - ' + strCodBco, Self.Name);
        end;

        If Assigned(objRep) Then
          FreeAndNil(objRep);

        Next;
      End;
      {********************}
      {* TRAILLER DO LOTE *}
      {********************}
      If AGerouHeader Then
         TrailerConcessionariaTributos;
    End;

    intCodSeqTributos := intCodSeqTributos + intCodSeq3;
  End;

end;

end.


