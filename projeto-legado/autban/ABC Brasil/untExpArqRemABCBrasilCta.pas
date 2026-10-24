unit untExpArqRemABCBrasilCta;

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
  TfrmExpArqRemABCBrasilCta = class(TfrmPai)
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

    strDtaPagLote        : String;
    strDtaPagLoteConcessTribut : String;
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
  frmExpArqRemABCBrasilCta: TfrmExpArqRemABCBrasilCta;

implementation

uses untFuncoes, untfuncoesSimples, DB, untLogCtp;

{$R *.dfm}

procedure TfrmExpArqRemABCBrasilCta.FormShow(Sender: TObject);
begin
  inherited;
  
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIGCTA246-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(fGetBancoConfig(0, 'CONFIGCTA246-' + IntToStr(intCartei), 'PROXNUM', ''), 06) +
                         '.TXT';
  pSetFocus(fraPathRemessa);

end;

function TfrmExpArqRemABCBrasilCta.fVerificaValidacoes : Boolean;
 Var
     blnRet : Boolean;
Begin

  blnRet := True;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
     blnRet := False;

  If blnRet Then
  Begin

    fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

    If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
    Begin
       fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
       pSetFocus(fraPathRemessa);
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
    End;

  End;

  result := blnRet;

End;

procedure TfrmExpArqRemABCBrasilCta.btnGerarClick(Sender: TObject);
begin
  inherited;
  fltValOutrasEntidades := 0;
  qryFormaPgto := fCriaQuery(Self);

  strCodBco       := '246';
  strNomBco       := 'ABC Brasil';
  strNomEmp       := fRetNomeEmpresa(VS_strCodEmp);
  strCodConv      := fGetBancoConfig(0, 'CONFIGCTA246-' + IntToStr(intCartei), 'CODCONV', '');
  strCodAgen      := fGetBancoConfig(0, 'CONFIGCTA246-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen      := fGetBancoConfig(0, 'CONFIGCTA246-' + IntToStr(intCartei), 'DIGAGEN', '');
  strContCor      := fGetBancoConfig(0, 'CONFIGCTA246-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt       := fGetBancoConfig(0, 'CONFIGCTA246-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar       := fGetBancoConfig(0, 'CONFIGCTA246-' + IntToStr(intCartei), 'NUMCART', '');
  strDigCar       := fGetBancoConfig(0, 'CONFIGCTA246-' + IntToStr(intCartei), 'CODCART', '');
  strCodRem       := fStrZero(fAtuCodSeq('CONFIGCTA246-' + IntToStr(intCartei), 'PROXNUM'), 6);
  strDtaRem       := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorRem       := FormatDateTime('hh', fTime()) + FormatDateTime('mm',fTime())    + FormatDateTime('ss'  , fTime());
  blnRemLoc       := Not( fGetBancoConfig(0, 'CONFIGCTA246-', 'RELOCAL', '') = 'N' );
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

     // strDtaPagLote :=  '00000000';  // ESTAMOS ENVIANDO O TIPO "1" NO TIPO DE TRATAMENTO DO HEADER;
                       //FormatDateTime(  'dd',VS_Date) +
                       //FormatDateTime(  'mm',VS_Date) +
                       //FormatDateTime('yyyy',VS_Date);

      {******************************}
      {* HEADER DO ARQUIVO => Reg 0 *}
      {***************************AF*}
      strHeader :=   '';
      strHeader :=   fPadR   ('246'                          , 003) + //001 - 003  [01]
                     fPadR   ('0000'                         , 004) + //004 - 007  [02]
                     fPadR   ('0'                            , 001) + //008 - 008  [03]
                     fPadR   (' '                            , 006) + //009 - 014  [04]
                     fPadR   ('080'                          , 003) + //014 - 017  [05]
                     fPadR   ('2'                            , 001) + //018 - 018  [06]
                     fPadR   (strCgcEmp                      , 014) + //019 - 032  [07]
                     fPadR   ('1'                            , 001) + //033 - 033  [08]  //1-Individual; 2-Ted Lote;
                     fPadR   (' '                            , 019) + //034 - 052  [09]
                     fStrZero(strCodAgen                     , 005) + //053 - 057  [10]
                     fPadR   (' '                            , 001) + //058 - 058  [11]
                     fStrZero(strContCor                     , 012) + //059 - 070  [12]
                     fPadR   (' '                            , 001) + //071 - 071  [13]
                     fPadR   (strDigCnt                      , 001) + //072 - 072  [14]
                     fPadR   (fTiraCaracEspeciais(strNomEmp) , 030) + //073 - 102  [15]
                     fPadR   ('ABC BRASIL'                   , 030) + //103 - 132  [16]
                     fPadR   (' '                            , 010) + //133 - 142  [17]
                     fPadR   ('1'                            , 001) + //143 - 143  [18]
                     fPadR   (strDtaRem                      , 008) + //144 - 151  [19]
                     fPadR   (strHorRem                      , 006) + //152 - 157  [20]
                     fStrZero('0'                            , 009) + //158 - 166  [21]
                     fStrZero('0'                            , 005) + //167 - 171  [22]
                     fPadR   (' '                            , 069);  //172 - 240  [23]

      {*******************************}
      {* ESCREVE O HEADER DO ARQUIVO *}
      {*******************************}
      Writeln(txtTexto, strHeader);

      qryRemessa.Filter   := ' CODBAN = ' + QuotedStr('246') +
                             ' AND ((PGI_Q_GUIA = "") OR (PGI_Q_GUIA IS NULL)) '+
                             ' AND PGI_TIPPAG = "" AND FORMAPAGTO <> ' + QuotedStr('DEP');

      qryRemessa.Filtered := True;

      intIndLot  := 1;
      intCodSeq1 := 0;

      If Not qryRemessa.IsEmpty Then
      Begin
        Inc(intTotLot);

        {********************************}
        {* HEADER DO LOTE DE SERVIÇO    *}
        {* TODOS REGISTROS DO BANCO 246 *}
        {********************************}

        strDtaPagLote :=  FormatDateTime(  'dd',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                          FormatDateTime(  'mm',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                          FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime);

        strHeaderLot := '';
        strHeaderLot := fPadR   ('246'                          , 003)      + //001 - 003
                        fPadR   (fStrZero(intIndLot,4)          , 004)      + //004 - 007
                        fPadR   ('1'                            , 001)      + //008 - 008
                        fPadL   ('C'                            , 001)      + //009 - 009
                        fPadR   ('98'                           , 002)      + //010 - 011  // DIVERSOS
                        fPadR   ('30'                           , 002)      + //012 - 013  // TITULOS DO BANCO ABC
                        fPadR   ('030'                          , 003)      + //014 - 016
                        fPadL   (' '                            , 001)      + //017 - 017
                        fPadR   (IntToStr(intTipIns)            , 001)      + //018 - 018
                        fPadL   (strCgcEmp                      , 014, '0') + //019 - 032
                        fPadL   (strDtaPagLote                  , 008)      + //033 - 040  // DTA. PAGTO.
                        fPadL   (' '                            , 012)      + //041 - 052
                        fPadL   (strCodAgen                     , 005, '0') + //053 - 057
                        fPadR   (' '                            , 001)      + //058 - 058
                        fPadL   (strContCor                     , 012, '0') + //059 - 070
                        fPadR   (' '                            , 001)      + //071 - 071
                        fPadL   (strDigCnt                      , 001, '0') + //072 - 072
                        fPadR   (fTiraCaracEspeciais(strNomEmp) , 030, ' ') + //073 - 102
                        fPadL   (' '                            , 030)      + //103 - 132
                        fPadL   (' '                            , 010)      + //133 - 142
                        fPadR   (fTiraCaracEspeciais(strEndEmp) , 030, ' ') + //143 - 172
                        fPadL   (strNumEmp                      , 005, '0') + //173 - 177
                        fPadR   (fTiraCaracEspeciais(strComEmp) , 015, ' ') + //178 - 192
                        fPadR   (fTiraCaracEspeciais(strCidEmp) , 020, ' ') + //193 - 212
                        fPadL   (strCepEmp                      , 008, '0') + //213 - 220
                        fPadR   (strEstEmp                      , 002, ' ') + //221 - 222
                        fPadR   (' '                            , 008)      + //223 - 230
                        fPadR   (' '                            , 010);       //231 - 240

        {****************************}
        {* ESCREVE O HEADER DO LOTE *}
        {****************************}
        Writeln(txtTexto, strHeaderLot);

        {************************************************}
        {* REGISTRO DE DETALHE => TED => SEGMENTO J     *}
        {************************************************}

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

            strTransacao := fPadR      ('246'                                             , 03)                      + //001 - 003
                            fPadR      (fStrZero(intIndLot,4)                             , 04)                      + //004 - 007
                            fPadR      ('3'                                               , 01)                      + //008 - 008
                            fPadL      (IntToStr(intCodSeq1)                              , 05, '0')                 + //009 - 013
                            fPadR      ('J'                                               , 01)                      + //014 - 014
                            fStrZero   ('0'                                               , 03)                      + //015 - 017
                            fPadL      (qryRemessa.FieldByName('PGI_CODBAR').AsString     , 44, '0')                 + //018 - 061
                            fPadR      (fTiraCaracEspeciais(qryRemessa.FieldByName('FOR_NOMFOR').AsString), 30, ' ') + //062 - 091
                            fPadR      (strDtaVen                                         , 08)                      + //092 - 099
                            fValNumForm(qryRemessa.FieldByName('PGI_VALDUP').AsFloat      , 15)                      + //100 - 114
                            fValNumForm(qryRemessa.FieldByName('PGI_VALDES').AsFloat      , 15)                      + //115 - 129
                            fValNumForm(qryRemessa.FieldByName('PGI_VALJUR').AsFloat      , 15)                      + //130 - 144
                            fPadR      (strDtaPag                                         , 08)                      + //145 - 152
                            fValNumForm(qryRemessa.FieldByName('PGI_VALPAG').AsFloat      , 15)                      + //153 - 167
                            fStrZero   ('0'                                               , 14)                      + //168 - 181
                            fStrZero   ('0'                                               , 01)                      + //182 - 182
                            fPadL      (strAutInc                                         , 20, '0')                 + //183 - 202
                            fPadR      ('2'                                               , 01)                      + //203 - 203
                            fPadR      (' '                                               , 12)                      + //204 - 215
                            fPadL      (' '                                               , 15)                      + //216 - 230
                            fPadL      (' '                                               , 10);                       //231 - 240

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {******************************}
            Writeln(txtTexto, strTransacao);
            Inc(intCodSeq1);

            {****************}
            {* GRAVA LOGCTP *}
            {****************}
            pGravaLogCTP(qryRemessa);

            qryRemessa.Next;
          End;

        {*****************************************************}
        {* TRAILLER DO LOTE (TÍTULOS DO ABC BRASIL) => Reg 5 *}
        {*****************************************************}
        Inc(intCodSeq1);
        strTraillerLot := '';
        strTraillerLot := fPadR      ('246'                , 003)       + //001 - 003
                          fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                          fPadR      ('5'                  , 001)       + //008 - 008
                          fPadR      (' '                  , 009)       + //009 - 017
                          fPadL      (IntToStr(intCodSeq1) , 006, '0')  + //018 - 023
                          fValNumForm(fltValPag1           , 018)       + //024 - 041
                          fStrZero   ('0'                  , 018)       + //042 - 059
                          fPadR      (' '                  , 171)       + //060 - 230
                          fPadR      (' '                  , 010);        //231 - 240

        {*************************************}
        {* ESCREVE O TRAILLER DO LOTE NO TXT *}
        {*************************************}
        Writeln(txtTexto, strTraillerLot);
        Inc(intIndLot);
      End;

      {***************************************************************}
      {*   FILTRA OS REGISTROS DOS BANCOS DIFERENTES DE ABC BRASIL   *}
      {***************************************************************}
      qryRemessa.Filtered := False;
      qryRemessa.Filter   := ' CODBAN <> ' + QuotedStr('246') +
                             ' AND ((PGI_Q_GUIA = "") OR (PGI_Q_GUIA IS NULL)) '+
                             ' AND PGI_TIPPAG = "" AND FORMAPAGTO <> ' + QuotedStr('DEP');

      qryRemessa.Filtered := True;

      intCodSeq2 := 0;

      If Not qryRemessa.IsEmpty Then
      Begin
        Inc(intTotLot);

        strDtaPagLote :=  FormatDateTime(  'dd',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                          FormatDateTime(  'mm',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime) +
                          FormatDateTime('yyyy',qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime);

        intIndLot := IIF( intIndLot = 0, 1, intIndLot );

        {********************************************************************}
        {* HEADER DO LOTE (TÍTULOS DE OUTROS BANCOS) => REG 1 => SEGMENTO J *}
        {********************************************************************}
        strHeaderLot := '';
        strHeaderLot := fPadR   ('246'                          , 003)      + //001 - 003
                        fPadR   (fStrZero(intIndLot,4)          , 004)      + //004 - 007
                        fPadR   ('1'                            , 001)      + //008 - 008
                        fPadL   ('C'                            , 001)      + //009 - 009
                        fPadR   ('98'                           , 002)      + //010 - 011  // DIVERSOS
                        fPadR   ('31'                           , 002)      + //012 - 013
                        fPadR   ('030'                          , 003)      + //014 - 016
                        fPadL   (' '                            , 001)      + //017 - 017
                        fPadR   (IntToStr(intTipIns)            , 001)      + //018 - 018
                        fPadL   (strCgcEmp                      , 014, '0') + //019 - 032
                        fPadL   (strDtaPagLote                  , 008)      + //033 - 040  // DTA. PAGTO.
                        fPadL   (' '                            , 012)      + //041 - 052
                        fPadL   (strCodAgen                     , 005, '0') + //053 - 057
                        fPadR   (' '                            , 001)      + //058 - 058
                        fPadL   (strContCor                     , 012, '0') + //059 - 070
                        fPadR   (' '                            , 001)      + //071 - 071
                        fPadL   (strDigCnt                      , 001, '0') + //072 - 072
                        fPadR   (fTiraCaracEspeciais(strNomEmp) , 030, ' ') + //073 - 102
                        fPadL   (' '                            , 030)      + //103 - 132
                        fPadL   (' '                            , 010)      + //133 - 142
                        fPadR   (fTiraCaracEspeciais(strEndEmp) , 030, ' ') + //143 - 172
                        fPadL   (strNumEmp                      , 005, '0') + //173 - 177
                        fPadR   (fTiraCaracEspeciais(strComEmp) , 015, ' ') + //178 - 192
                        fPadR   (fTiraCaracEspeciais(strCidEmp) , 020, ' ') + //193 - 212
                        fPadL   (strCepEmp                      , 008, '0') + //213 - 220
                        fPadR   (strEstEmp                      , 002, ' ') + //221 - 222
                        fPadR   (' '                            , 008)      + //223 - 230
                        fPadR   (' '                            , 010);       //231 - 240

        {****************************}
        {* ESCREVE O HEADER DO LOTE *}
        {*************************KP*}
        Writeln(txtTexto, strHeaderLot);

        {***************************************************************************}
        {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG = 3 => SEGMENTO J *}
        {***************************************************************************}

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

            strTransacao := fPadR      ('246'                                                                    , 03)      + //001 - 003
                            fPadR      (fStrZero(intIndLot,4)                                                    , 04)      + //004 - 007
                            fPadR      ('3'                                                                      , 01)      + //008 - 008
                            fPadL      (IntToStr(intCodSeq2)                                                     , 05, '0') + //009 - 013
                            fPadR      ('J'                                                                      , 01)      + //014 - 014
                            fStrZero   ('0'                                                                      , 03)      + //015 - 017
                            fPadL      (qryRemessa.FieldByName('PGI_CODBAR').AsString                            , 44, '0') + //018 - 061
                            fPadR      (fTiraCaracEspeciais(qryRemessa.FieldByName('FOR_NOMFOR').AsString, true) , 30, ' ') + //062 - 091
                            fPadR      (strDtaVen                                                                , 08)      + //092 - 099
                            fValNumForm(qryRemessa.FieldByName('PGI_VALDUP').AsFloat                             , 15)      + //100 - 114
                            fValNumForm(qryRemessa.FieldByName('PGI_VALDES').AsFloat                             , 15)      + //115 - 129
                            fValNumForm(qryRemessa.FieldByName('PGI_VALJUR').AsFloat                             , 15)      + //130 - 144
                            fPadR      (strDtaPag                                                                , 08)      + //145 - 152
                            fValNumForm(qryRemessa.FieldByName('PGI_VALPAG').AsFloat                             , 15)      + //153 - 167
                            fStrZero   ('0'                                                                      , 14)      + //168 - 181
                            fStrZero   ('0'                                                                      , 01)      + //182 - 182
                            fPadL      (strAutInc                                                                , 20, '0') + //183 - 202
                            fPadR      ('2'                                                                      , 01)      + //203 - 203
                            fPadR      (' '                                                                      , 12)      + //204 - 215
                            fPadL      (' '                                                                      , 15)      + //216 - 230
                            fPadL      (' '                                                                      , 10);       //231 - 240

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************KP*}
            Writeln(txtTexto, strTransacao);

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
        strTraillerLot := fPadR      ('246'                , 003)       + //001 - 003
                          fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                          fPadR      ('5'                  , 001)       + //008 - 008
                          fPadR      (' '                  , 009)       + //009 - 017
                          fPadL      (IntToStr(intCodSeq2) , 006, '0')  + //018 - 023
                          fValNumForm(fltValPag2           , 018)       + //024 - 041
                          fStrZero   ('0'                  , 018)       + //042 - 059
                          fPadR      (' '                  , 171)       + //060 - 230
                          fPadR      (' '                  , 010);        //231 - 240

        {*************************************}
        {* ESCREVE O TRAILLER DO LOTE NO TXT *}
        {**********************************KP*}
        Writeln(txtTexto,strTraillerLot);
        Inc(intIndLot);
      End;

      {***************************************************************}
      {* GERAÇÃO DO TED DE 246 PARA 246 E 246 PARA DIFERENTES BANCOS *}
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

      intCodSeq3 := bck_intCodSeq3;

      {********************************}
      {* TRAILLER DO ARQUIVO => Reg 9 *}
      {*****************************AF*}
      intCodSeqGer:= intCodSeq1 + intCodSeq2 + intCodSeq3 + intCodSeqGeralTED + 2;
      strTrailler := '';
      strTrailler := fPadR   ('246'                 , 003)      + //001 - 003
                     fPadR   ('9999'                , 004)      + //004 - 007
                     fPadR   ('9'                   , 001)      + //008 - 008
                     fPadR   (' '                   , 009)      + //009 - 017
                     fPadL   (IntToStr(intTotLot)   , 006, '0') + //018 - 023
                     fPadL   (IntToStr(intCodSeqGer), 006, '0') + //024 - 029
                     fPadR   (' '                   , 211);       //030 - 240

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
		  pMensagensErro(E.Message,  '[untExpArqRemABCBrasil.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');

		End;

  End;

end;

Procedure TfrmExpArqRemABCBrasilCta.pGravaLogCTP(GenQryRemessa : TUniQuery);
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

function TfrmExpArqRemABCBrasilCta.fRetEmpresa: String;
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

procedure TfrmExpArqRemABCBrasilCta.pGeraTED(qryTED: TUniQuery; blnBancoDiferente: Boolean);
begin

  qryTED.Filtered := False;
  qryTED.Filter   := ' CODBAN = ' + QuotedStr('246') +
                     ' AND FORMAPAGTO = ' + QuotedStr('DEP') +
                     ' AND CODBCO ' + IIF(blnBancoDiferente, ' <> ', ' = ') + QuotedStr('246') +
                     ' AND ((PGI_Q_GUIA = '''') OR (PGI_Q_GUIA IS NULL)) ';

  qryTED.Filtered := True;

  If Not qryTED.IsEmpty Then
  Begin

    strDtaPagLote := FormatDateTime(  'dd',qryTED.FieldByName('PGI_DTAPAG').AsDateTime) +
                     FormatDateTime(  'mm',qryTED.FieldByName('PGI_DTAPAG').AsDateTime) +
                     FormatDateTime('yyyy',qryTED.FieldByName('PGI_DTAPAG').AsDateTime);

    intCodSeqRegTED := 0;
    intCodSeqTED    := 0;
    Inc(intTotLot);
    Inc(intCodSeqTED);

    {*********************************************************************}
    {* HEADER DO LOTE (Pagamento através de crédito em conta, cheque, OP, }
    {* DOC, TED ou pagamento com autenticação) => REG 1 => SEGMENTO C    *}
    {******************************************************************MO*}

    strHeaderLot := '';
    strHeaderLot := fPadR   ('246'                             , 003)      + //001 - 003 - CÓD. DO BANCO
                    fPadR   (fStrZero(intIndLot,4)             , 004)      + //004 - 007 - LOTE DO SERVIÇO
                    fPadR   ('1'                               , 001)      + //008 - 008 - TIPO DE REGISTRO
                    fPadL   ('C'                               , 001)      + //009 - 009 - TIPO DE OPERAÇÃO
                    fPadR   ('98'                              , 002)      + //010 - 011 - TIPO DO SERVIÇO
                    fPadR   (IIF(blnBancoDiferente, '43', '41'), 002)      + //012 - 013 - FORMA DE LANÇAMENTO  -TED D - MESMA TITULARIDADE; TED C - DIFERENTE TITULARIDADE;
                    fPadR   ('030'                             , 003)      + //014 - 016 - Nº DA VERSÃO DO LAYOUT DO LOTE
                    fPadL   (' '                               , 001)      + //017 - 017 - USO EXCLUSIVO FEBRABAN
                    fPadR   (IntToStr(intTipIns)               , 001)      + //018 - 018 - TIPO DE INSCRIÇÃO DA EMPRESA
                    fPadL   (strCgcEmp                         , 014, '0') + //019 - 032 - Nº DE INSCRIÇÃO DA EMPRESA
                    fPadL   (strDtaPagLote                     , 008)      + //033 - 040  // DTA. PAGTO.
                    fPadL   (' '                               , 012)      + //041 - 052
                    fPadL   (strCodAgen                        , 005, '0') + //053 - 057
                    fPadR   (' '                               , 001)      + //058 - 058
                    fPadL   (strContCor                        , 012, '0') + //059 - 070
                    fPadR   (' '                               , 001)      + //071 - 071
                    fPadL   (strDigCnt                         , 001, '0') + //072 - 072
                    fPadR   (fTiraCaracEspeciais(strNomEmp)    , 030, ' ') + //073 - 102
                    fPadL   (' '                               , 030)      + //103 - 132
                    fPadL   (' '                               , 010)      + //133 - 142
                    fPadR   (fTiraCaracEspeciais(strEndEmp)    , 030, ' ') + //143 - 172
                    fPadL   (strNumEmp                         , 005, '0') + //173 - 177
                    fPadR   (fTiraCaracEspeciais(strComEmp)    , 015, ' ') + //178 - 192
                    fPadR   (fTiraCaracEspeciais(strCidEmp)    , 020, ' ') + //193 - 212
                    fPadL   (strCepEmp                         , 008, '0') + //213 - 220
                    fPadR   (strEstEmp                         , 002, ' ') + //221 - 222
                    fPadR   (' '                               , 008)      + //223 - 230
                    fPadR   (' '                               , 010);       //231 - 240

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
      strTransacao := fPadR      ('246'                                    , 03)      + //001 - 003 - CÓD. DO BANCO
                      fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007 - LOTE DE SERVIÇO
                      fPadR      ('3'                                      , 01)      + //008 - 008 - TIPO DE REGISTRO
                      fPadL      (IntToStr(intCodSeqRegTED)                , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                      fPadR      ('A'                                      , 01)      + //014 - 014 - CÓD. DE SEGMENTO NO REG. DETALHE
                      fStrZero   ('0'                                      , 03)      + //015 - 017
                      fPadL      ('0'                                      , 03, '0') + //018 - 020 - CÓD. DA CÂMARA CENTRALIZADORA
                      fPadL      (qryTED.FieldByName('CODBCO').AsString    , 03, '0') + //021 - 023 - CÓD. DO BANCO DO FAVORECIDO
                      fPadL      (qryTED.FieldByName('CODAGE').AsString    , 05, '0') + //024 - 028 - AG. MANTENEDORA DA CTA. DO FAVOR.
                      fPadR      (' '                                      , 01)      + //029 - 029 - DÍGITO VERIFICADOR DA AGÊNCIA
                      fPadL      (qryTED.FieldByName('NUMCTA').AsString    , 12, '0') + //030 - 041 - Nº DA CONTA CORRENTE
                      fPadR      (' '                                      , 01)      + //042 - 042 - DÍGITO VERIFICADOR DA CONTA
                      fPadR      (qryTED.FieldByName('DIGVER').AsString    , 01, ' ') + //043 - 043 - DÍGITO VERIFICADOR AG/CONTA
                      fPadR      (qryTED.FieldByName('FOR_NOMFOR').AsString, 30, ' ') + //044 - 073 - NOME DO FAVORECIDO
                      fPadL      (strAutInc                                , 20, ' ') + //074 - 093 - Nº DO DOCUMENTO ATRIBUIDO P/ EMPRESA
                      fPadR      (strDtaPag                                , 08)      + //094 - 101 - DATA DO PAGAMENTO
                      fPadR      ('REA'                                    , 03)      + //102 - 104 - TIPO DA MOEDA
                      fStrZero   ('0'                                      , 15)      + //105 - 119 - QUANTIDADE DA MOEDA
                      fValNumForm(qryTED.FieldByName('PGI_VALPAG').AsFloat , 15)      + //120 - 134 - VALOR DO PAGAMENTO
                      fPadL      (' '                                      , 15)      + //135 - 149 - Nº DO DOCUM. ATRIBUIDO PELO BANCO
                      fPadL      (' '                                      , 05)      + //150 - 154 - COMPLEMENTO DO REGISTRO
                      fPadR      (' '                                      , 08)      + //155 - 162 - DATA REAL DA EFETIVAÇÃO DO PAGTO. mandar em branco.
                      fStrZero   ('0'                                      , 15)      + //163 - 177 - VALOR REAL DA EFETIVAÇÃO DO PAGTO. mandar em branco.
                      //fPadR      (strDtaPag                                , 08)      + //155 - 162 - DATA REAL DA EFETIVAÇÃO DO PAGTO. mandar em branco.
                      //fValNumForm(qryTED.FieldByName('PGI_VALPAG').AsFloat , 15)      + //163 - 177 - VALOR REAL DA EFETIVAÇÃO DO PAGTO. mandar em branco.
                      fPadL      (' '                                      , 20)      + //178 - 197 - FNALIDADE DETALHE
                      fPadL      (' '                                      , 06)      + //198 - 203 - NUMERO DOCUMENTO
                      fPadL      (strCgcFor                                , 14)      + //204 - 217 - NUMERO DOCUMENTO
                      fPadL      (IntToStr(intTipInsFor)                   , 01)      + //218 - 218 - TIPO DOCUMENTO FAVORECIDO
                      fPadR      ('0'                                      , 01)      + //219 - 219 - COMPL. TIPO SERVIÇO
                      fPadR      (qryTED.FieldByName('PGI_CODTED').AsString, 05)      + //220 - 224 - CÓDIGO FINALIDADE DA TED
                      fPadR      (' '                                      , 05, ' ') + //225 - 229 - USO EXCLUSIVO DA FEBRABAN
                      fPadR      (strAvisoTed                              , 01)      + //230 - 230 - AVISO AO FAVORECIDO
                      fPadR      (' '                                      , 010);      //231 - 240 - CÓDIGOS DAS OCORRÊNCIAS P/ RETORNO

      {******************************}
      {* ESCREVE A TRANSACAO NO TXT *}
      {***************************JU*}
      Writeln(txtTexto,strTransacao);
      Inc(intCodSeqRegTED);

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
    strTraillerLot := fPadR      ('246'                 , 003)      + //001 - 003 - CÓD. DO BANCO NA COMPENSAÇÃO
                      fPadR      (fStrZero(intIndLot,4) , 004)      + //004 - 007 - LOTE DE SERVIÇO
                      fPadR      ('5'                   , 001)      + //008 - 008 - TIPO DE REGISTRO
                      fPadR      (' '                   , 009)      + //009 - 017 - USO EXCLUSIVO FEBRABAN
                      fPadL      (IntToStr(intCodSeqTED), 006, '0') + //018 - 023 - QUANTIDADE DE REGISTROS DO LOTE
                      fValNumForm(fltValPag4            , 018)      + //024 - 041 - SOMATÓRIA DE VALORES
                      fStrZero   ('0'                   , 018)      + //042 - 059 - SOMATÓRIA DE QUANTIDADE DE MOEDAS
                      fPadR      (' '                   , 171)      + //060 - 230 - USO EXCLUSIVO FEBRABAN
                      fPadR      (' '                   , 010);       //231 - 240 - CÓDIGOS DAS OCORRÊNCIAS P/ RETORNO

    Inc(intIndLot);
    intCodSeqGeralTED := intCodSeqGeralTED + intCodSeqTED;

    {*************************************}
    {* ESCREVE O TRAILLER DO LOTE NO TXT *}
    {**********************************MO*}
    Writeln(txtTexto,strTraillerLot);
  End;
end;

procedure TfrmExpArqRemABCBrasilCta.HeaderConcessionariaTributos(AFormaLancamento: String);
begin
  Inc(intTotLot);

  {********************************************************************************************************}
  {* HEADER DO LOTE (Pagamento de Concessionárias e tributos com código de barras) => REG 1 => SEGMENTO O *}
  {*****************************************************************************************************KP*}

  strHeaderLot := '';
  strHeaderLot := fPadR   ('246'                          , 003)      + //001 - 003
                  fPadR   (fStrZero(intIndLot,4)          , 004)      + //004 - 007
                  fPadR   ('1'                            , 001)      + //008 - 008
                  fPadL   ('C'                            , 001)      + //009 - 009
                  fPadR   ('98'                           , 002)      + //010 - 011
                  fPadR   (AFormaLancamento               , 002)      + //012 - 013
                  fPadR   ('030'                          , 003)      + //014 - 016
                  fPadL   (' '                            , 001)      + //017 - 017
                  fPadR   (IntToStr(intTipIns)            , 001)      + //018 - 018
                  fPadL   (strCgcEmp                      , 014, '0') + //019 - 032
                  fPadL   (strDtaPagLoteConcessTribut     , 008)      + //033 - 040  // DTA. PAGTO.
                  fPadL   (' '                            , 012)      + //041 - 052
                  fPadL   (strCodAgen                     , 005, '0') + //053 - 057
                  fPadR   (' '                            , 001)      + //058 - 058
                  fPadL   (strContCor                     , 012, '0') + //059 - 070
                  fPadR   (' '                            , 001)      + //071 - 071
                  fPadL   (strDigCnt                      , 001, '0') + //072 - 072
                  fPadR   (fTiraCaracEspeciais(strNomEmp) , 030, ' ') + //073 - 102
                  fPadL   (' '                            , 030)      + //103 - 132
                  fPadL   (' '                            , 010)      + //133 - 142
                  fPadR   (fTiraCaracEspeciais(strEndEmp) , 030, ' ') + //143 - 172
                  fPadL   (strNumEmp                      , 005, '0') + //173 - 177
                  fPadR   (fTiraCaracEspeciais(strComEmp) , 015, ' ') + //178 - 192
                  fPadR   (fTiraCaracEspeciais(strCidEmp) , 020, ' ') + //193 - 212
                  fPadL   (strCepEmp                      , 008, '0') + //213 - 220
                  fPadR   (strEstEmp                      , 002, ' ') + //221 - 222
                  fPadR   (' '                            , 008)      + //223 - 230
                  fPadR   (' '                            , 010);       //231 - 240

  {****************************}
  {* ESCREVE O HEADER DO LOTE *}
  {*************************KP*}
  Writeln(txtTexto,strHeaderLot);
end;

procedure TfrmExpArqRemABCBrasilCta.pGeraConcessionariasTributos(qryConc: TUniQuery; blnConcessionaria : Boolean);
begin

      {****************************}
      {* FILTRANDO CONCESSIONARIA *}
      {****************************}
      qryConc.Filtered := False;
      qryConc.Filter   := ' CODBAN <> ' + QuotedStr('246') +
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

          strDtaPagLoteConcessTribut := FormatDateTime(  'dd',qryConc.FieldByName('PGI_DTAPAG').AsDateTime) +
                                        FormatDateTime(  'mm',qryConc.FieldByName('PGI_DTAPAG').AsDateTime) +
                                        FormatDateTime('yyyy',qryConc.FieldByName('PGI_DTAPAG').AsDateTime);

          {***********************************************************}
          {* HEADER LOTE CONCESSIONÁRIAS/TRIBUTOS                    *}
          {* 13 - CONCESSIONÁRIAS                                    *}
          {* 19 - TRIBUTOS                                           *}
          {***********************************************************}
          HeaderConcessionariaTributos( IIF(blnConcessionaria,'13','19') );

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

              strTransacao := fPadR      ('246'                                               , 03)      + //001 - 003
                              fPadR      (fStrZero(intIndLot,4)                               , 04)      + //004 - 007
                              fPadR      ('3'                                                 , 01)      + //008 - 008
                              fPadL      (IntToStr(intCodSeq3)                                , 05, '0') + //009 - 013
                              fPadR      ('O'                                                 , 01)      + //014 - 014
                              fStrZero   ('0'                                                 , 03)      + //015 - 017
                              fPadL      (qryConc.FieldByName('PGI_CODBAR').AsString          , 48, '0') + //018 - 065
                              fPadR      (qryConc.FieldByName('FOR_NOMFOR').AsString          , 30, ' ') + //066 - 095
                              fPadR      (strDtaVen                                           , 08)      + //096 - 103
                              fPadR      ('REA'                                               , 03)      + //104 - 106
                              fStrZero   ('0'                                                 , 14)      + //107 - 121
                              fValNumForm(qryConc.FieldByName('PGI_VALDUP').AsFloat           , 14)      + //122 - 136
                              fPadR      (strDtaPag                                           , 08)      + //137 - 144
                              fPadL      (strAutInc                                           , 20, ' ') + //123 - 142
                              fStrZero   ('0'                                                 , 15)      + //145 - 159
                              fPadL      (' '                                                 , 03)      + //160 - 162
                              fPadL      ('0'                                                 , 09)      + //163 - 171
                              fPadL      (' '                                                 , 03, ' ') + //172 - 174
                              fPadL      (strAutInc                                           , 20, '0') + //175 - 194
                              fPadL      (' '                                                 , 21, ' ') + //195 - 215
                              fPadL      (' '                                                 , 15)      + //216 - 230
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

procedure TfrmExpArqRemABCBrasilCta.TrailerConcessionariaTributos;
begin
  {********************************************************}
  {* TRAILLER DO LOTE (CONCESSIONARIAS E TRIBUTOS)        *}
  {********************************************************}
  fltValPag2 := fltValPag2 + fltValOutrasEntidades;
  Inc(intCodSeq3);
  Inc(intCodSeq3);
  strTraillerLot := '';
  strTraillerLot := fPadR      ('246'                , 003)       + //001 - 003
                    fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                    fPadR      ('5'                  , 001)       + //008 - 008
                    fPadR      (' '                  , 009)       + //009 - 017
                    fPadL      (IntToStr(intCodSeq3) , 006, '0')  + //018 - 023
                    fValNumForm(fltValPag2           , 018)       + //024 - 041
                    fStrZero   ('0'                  , 018)       + //042 - 059
                    fPadR      (' '                  , 171)       + //060 - 230
                    fPadR      (' '                  , 010);        //231 - 240


  {*************************************}
  {* ESCREVE O TRAILLER DO LOTE NO TXT *}
  {**********************************KP*}
  Writeln(txtTexto,strTraillerLot);
  Inc(intIndLot);
end;

end.


