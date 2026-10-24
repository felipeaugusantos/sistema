unit untExpArqRemBradescoCta240;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels, System.DateUtils,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTCadPag, untTCadPagRepository, 
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBradescoCta240 = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    lblConvenioSalarios: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private

    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;
    procedure pGeraTED(qryTED: TUniQuery; blnBancoDiferente: Boolean; AApenasSalarios: Boolean);
    procedure GeraTributos(qryTributos: TUniQuery);
    procedure HeaderConcessionariaTributos(AFormaLancamento: String);
    procedure TrailerConcessionariaTributos;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strTraillerLot : String;
    strCodBco      : String;
    strGetCodFor: String;
    objPag: TCadPag;
    objRep: TCadPagRepository;
    strAvisoTed    : String;
    strCodMovimento: String;
    strAutInc      : String;
    strDtaPag      : String;
    strDtaVen      : String;
    strDtaEmi      : String;
    strCamCentralizadora: String;
    intTipInsFor   : Integer;
    fltValPag4     : Double;
    strTransacao   : String;
    strNomForm : String;
    intCodSeqTED,
    intCodSeqGeralTED,
    intCodSeqRegTED : Integer;
    intTotLot      : Integer;
    strHeaderLot   : String;
    intIndLot      : Integer;
    intCodSeq3,
    intCodSeqTributos,
    intTipIns      : Integer;
    strCgcEmp      : String;
    strCodCon      : String;
    strCodAgen,
    strDigAgen     : String;
    strContCor     : String;
    strDigCnt      : String;
    strNomEmp      : String;
    strEndEmp      : String;
    strNumEmp      : String;
    strComEmp      : String;
    strCidEmp      : String;
    strCepEmp      : String;
    strEstEmp      : String;
    strIE_Emp      : String;
    txtTexto       : TextFile;
    fltValPag2     : Double;
    fltValOutrasEntidades: Double;
    intCodSeq2     : Integer;
    strIdTrib,
    strCodTrib,
    strCompet,
    strCgcFor,
    strEndFor,
    strNumFor,
    strComFor,
    strBairroFor,
    strCidFor,
    strCepFor,
    strEstFor: String;
  end;

var
  frmExpArqRemBradescoCta240: TfrmExpArqRemBradescoCta240;

implementation

uses untFuncoes, untfuncoesSimples, DB, untLogCtp;

{$R *.dfm}

procedure TfrmExpArqRemBradescoCta240.FormShow(Sender: TObject);
begin
  inherited;

  lblConvenioSalarios.Visible := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'CONVSAL','') = 'S';

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(fGetBancoProxNum('CONFIGCTA237_240p-' + IntToStr(intCartei)), 06) +
                         '.TXT';
  pSetFocus(fraPathRemessa);

  If (fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'DSNAME','') = 'S') Then
  Begin
    edtNomArquivo.Text := 'PAGT_' + fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'CONVENI', '')+ '.REM';
  End;

end;

procedure TfrmExpArqRemBradescoCta240.btnGerarClick(Sender: TObject);
  Var
    strSQL         : String;
    strSQLDep      : String;
    strNomBco      : String;
    strDtaRem      : String;
    strHorRem      : String;
    strDtaVen      : String;
    strCodCar      : String;
    strDigCar      : String;

    strHeader      : String;
    strTrailler    : String;
    strSeqArq      : String;
    strCod_Ted     : String;
    strCompTed     : String;

    intISPB        : Integer;
    intCodSeq1     : Integer;
    intCodSeqGer   : Integer;
    fltValPag1     : Double;
    fltValPagTot   : Double;
    strNovCodEmp   : String;
    strCodRem      : String;
    strTipInsFor   : String;
    blnRemLoc      : Boolean;
    qryRemessa     : TUniQuery;
    qryFormaPgto   : TUniQuery;
    blnPodeGerar   : Boolean;

    strFilePath : String;

    objPag: TCadPag;
    objRep: TCadPagRepository;
    strGetCodFor: String;

    strCgcFor,
    strEndFor,
    strNumFor,
    strComFor,
    strBairroFor,
    strCidFor,
    strCepFor,
    strEstFor,
    strRTrEmp: String;
    AGeraHeaderConcessionaria: Boolean;
    AGeraTrailerConcessionaria: Boolean;

    LApenasSalarios: Boolean;
    LQuebraLinhaTrailerArquivo : Boolean;
    LCaracterQuebraLinhaTrailer: String;
begin
  inherited;
  fltValOutrasEntidades := 0;
  blnPodeGerar := True;
  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  qryFormaPgto := fCriaQuery(Self);
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  strCodBco   := '237';
  strNomBco   := 'BANCO BRADESCO S.A.';
  strNomEmp   := fRetNomeEmpresa(VS_strCodEmp);
  strCodCon   := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'CONVENI', '');
  strCodAgen  := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen  := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'DIGAGEN', '');
  strContCor  := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt   := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar   := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'NUMCART', '');
  strDigCar   := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'CODCART', '');
  strCodRem   := fStrZero(fAtuCodSeq('CONFIGCTA237_240p-' + IntToStr(intCartei), 'PROXNUM'), 6);
  strSeqArq   := fStrZero(fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'SEQARQU', '0'), 6);
  strDtaRem   := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorRem   := FormatDateTime('hh',fTime()) + FormatDateTime('mm',fTime()) + FormatDateTime('ss',fTime());
  blnRemLoc   := Not( fGetBancoConfig(0, 'CONFIGCTA237_240p', 'RELOCAL', '') = 'N' );
  strAvisoTed := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'AVISOFA', '');
  strCodMovimento:= fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'CODMOVI', '');
  strCodMovimento:= IIF(fEmptyStr(strCodMovimento),'0',strCodMovimento);
  LApenasSalarios := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'CONVSAL', '') = 'S';
  intTotLot   := 0;
  LQuebraLinhaTrailerArquivo := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'QUEBRALINTRAILER', '') <> 'N';
  LCaracterQuebraLinhaTrailer := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'CARACTERQUEBRALINHA', '');

  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp);

  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try
    fStartTransaction;

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  *      ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      strTipInsFor := Copy(FieldByName('EMP_C_G_C_').AsString, 1, 8);
      strEndEmp := FieldByName('EMP_ENDERE').AsString;
      strNumEmp := FieldByName('EMP_ENDNUM').AsString;
      strComEmp := FieldByName('EMP_ENDCMP').AsString;
      strCidEmp := FieldByName('CID_NOMCID').AsString;
      strCepEmp := fTiraCaracEspeciais(FieldByName('EMP_C_E_P_').AsString);
      strEstEmp := FieldByName('CID_ESTADO').AsString;
      strRTrEmp := FieldByName('EMP_REGTRI').AsString;
      strIE_Emp := FieldByName('EMP_I_E_S_').AsString;
      Close;
    End;

    If Length(strCgcEmp) > 11 Then
      intTipIns := 2
    Else
      intTipIns := 1;

    qryRemessa := fCriaQuery(Self);
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
    strSQL := strSQL + '  IF(B.PGI_FORPGT = "DEP",PGI_CODBCO,LEFT(PGI_CODBAR, 3)) AS CODBAN ';
    strSQL := strSQL + 'FROM                       ';
    strSQL := strSQL + '  CADPGI B                 ';
    strSQL := strSQL + '  LEFT JOIN CADFOR F ON FOR_CODFOR = PGI_CODFOR     ';
    strSQL := strSQL + '  LEFT JOIN CADPAG P ON P.AUTOINCREM = PGI_AUTOIN   ';
    strSQL := strSQL + '  LEFT JOIN BCOFOR D ON D.AUTOINCREM = P.CTP_BCOFOR ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  PGI_CODBCO = :CODBCO     ';

    if LApenasSalarios Then
      strSQL := strSQL + '  AND PGI_SEQSAL IS NOT NULL ';

    strSQLDep := '';
    strSQLDep := strSQLDep + strSQL + ' AND PGI_FORPGT = :FORMAPGTO LIMIT 1';

    With qryFormaPgto Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLDep);
      ParamByName('CODBCO').AsString := strCodBco;
      ParamByName('FORMAPGTO').AsString := 'DEP';
      Open;
    End;

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin

      If (Not qryFormaPgto.IsEmpty) Then
      Begin
        If fEmptyStr (strAvisoTed) Then
        Begin
          blnPodeGerar := False;
          fRollBack;
          fMensagem('','Existem inconsistências nas configurações de "Dados de Depósito" na carteira do banco selecionado. Portanto, o arquivo de remessa não será exportado!',['&O K']);
        End;
      End;

      If blnPodeGerar Then
      Begin
        AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
        strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
        Rewrite(txtTexto);

        {******************************}
        {* HEADER DO ARQUIVO => Reg 0 *}
        {***************************KP*}
        strHeader := '';
        strHeader := fPadR   ('237'              , 003)      + //001 - 003
                     fPadR   ('0000'             , 004)      + //004 - 007
                     fStrZero('0'                , 001)      + //008 - 008
                     fPadL   (' '                , 009)      + //009 - 017
                     fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                     fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                     fPadR   (strCodCon          , 020)      + //033 - 052
                     fPadL   (strCodAgen         , 005, '0') + //053 - 057
                     fPadR   (strDigAgen         , 001     ) + //058 - 058
                     fPadL   (strContCor         , 012, '0') + //059 - 070
                     fPadR   (strDigCnt          , 001     ) + //071 - 071
                     fPadL   (' '                , 001, ' ') + //072 - 072
                     fPadR   (strNomEmp          , 030     ) + //073 - 102
                     fPadR   (strNomBco          , 030     ) + //103 - 132
                     fPadR   (' '                , 010)      + //133 - 142
                     fPadR   ('1'                , 001)      + //143 - 143
                     fPadR   (strDtaRem          , 008)      + //144 - 151
                     fPadR   (strHorRem          , 006)      + //152 - 157
                     fPadR   (strSeqArq          , 006)      + //158 - 163
                     fPadR   ('089'              , 003)      + //164 - 166
                     fPadR   ('01600'            , 005)      + //167 - 171
                     fPadR   (' '                , 069);       //172 - 240

        {*******************************}
        {* ESCREVE O HEADER DO ARQUIVO *}
        {****************************KP*}
        Writeln(txtTexto,strHeader);

        qryRemessa.Filtered := False;
        qryRemessa.Filter   := ' CODBAN = ' + QuotedStr('237') + ' AND '+
                               ' ((PGI_Q_GUIA = "") OR (PGI_Q_GUIA IS NULL)) AND '+
                               ' FORMAPAGTO <> ' + QuotedStr('DEP');
        qryRemessa.Filtered := True;

        intIndLot  := 1;
        intCodSeq1 := 0;

        If Not qryRemessa.IsEmpty Then
        Begin
          Inc(intTotLot);
          {***************************************************************}
          {* HEADER DO LOTE (TÍTULOS DO BRADESCO) => REG 1 => SEGMENTO J *}
          {************************************************************KP*}
          strHeaderLot := '';
          strHeaderLot := fPadR   ('237'              , 003)      + //001 - 003
                          fPadR   (fStrZero(intIndLot,4), 004)    + //004 - 007
                          fPadR   ('1'                , 001)      + //008 - 008
                          fPadL   ('C'                , 001)      + //009 - 009
                          fPadR   ('20'               , 002)      + //010 - 011
                          fPadR   ('30'               , 002)      + //012 - 013
                          fPadR   ('040'              , 003)      + //014 - 016
                          fPadL   (' '                , 001)      + //017 - 017
                          fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                          fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                          fPadR   (strCodCon          , 020)      + //033 - 052
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
                          fPadR   (' '                , 008)      + //223 - 230
                          fPadR   (' '                , 010);       //231 - 240

          {****************************}
          {* ESCREVE O HEADER DO LOTE *}
          {*************************KP*}
          Writeln(txtTexto,strHeaderLot);

          {**********************************************************************}
          {* REGISTRO DE DETALHE (TÍTULOS DO BRADESCO) => REG = 3 => SEGMENTO J *}
          {*******************************************************************KP*}
          With qryRemessa Do
          Begin

            strTransacao := '';

            fltValPag1 := 0;

            While Not Eof Do
            Begin
              Inc(intCodSeq1);

              Application.ProcessMessages;

              strDtaVen := FormatDateTime('dd',FieldByName('PGI_DTAVEN').AsDateTime) +
                           FormatDateTime('mm',FieldByName('PGI_DTAVEN').AsDateTime) +
                           FormatDateTime('yyyy',FieldByName('PGI_DTAVEN').AsDateTime);

              strDtaPag := FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime) +
                           FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                           FormatDateTime('yyyy',FieldByName('PGI_DTAPAG').AsDateTime);

              strAutInc := FieldByName('PGI_AUTOIN').AsString;

              fltValPag1 := fltValPag1 + FieldByName('PGI_VALPAG').AsFloat;

              If Length(FieldByName('CODCGC').AsString) > 11 Then
                intTipInsFor := 2
              Else
                intTipInsFor := 1;

              {*******************************************************************}
              {* REGISTRO DE DETALHE (TÍTULOS DO BRADESCO) => REG 3 - SEGMENTO A *}
              {****************************************************************KP*}

              strTransacao := fPadR      ('237'                                   , 03)      + //001 - 003
                              fPadR      (fStrZero(intIndLot,4)                   , 04)      + //004 - 007
                              fPadR      ('3'                                     , 01)      + //008 - 008
                              fPadL      (IntToStr(intCodSeq1)                    , 05, '0') + //009 - 013
                              fPadR      ('J'                                     , 01)      + //014 - 014
                              fStrZero   ('0'                                     , 01)      + //015 - 015
                              fStrZero   (strCodMovimento                         , 02)      + //016 - 017
                              fPadL      (FieldByName('PGI_CODBAR').AsString      , 44, '0') + //018 - 061
                              fPadR      (FieldByName('FOR_NOMFOR').AsString      , 30, ' ') + //062 - 091
                              fPadR      (strDtaVen                               , 08)      + //092 - 099
                              fValNumForm(FieldByName('PGI_VALDUP').AsFloat       , 15)      + //100 - 114
                              fValNumForm(FieldByName('PGI_VALDES').AsFloat       , 15)      + //115 - 129
                              fValNumForm(0                                       , 15)      + //130 - 144
                              fPadR      (strDtaPag                               , 08)      + //145 - 152
                              fValNumForm(FieldByName('PGI_VALPAG').AsFloat       , 15)      + //153 - 167
                              fStrZero   ('0'                                     , 15)      + //168 - 182
                              fPadL      (strAutInc                               , 20, '0') + //183 - 202
                              fPadL      (' '                                     , 20)      + //203 - 222
                              fPadL      ('09'                                    , 02)      + //223 - 224
                              fPadL      (' '                                     , 16)      ; //225 - 240

              {******************************}
              {* ESCREVE A TRANSACAO NO TXT *}
              {***************************KP*}
              Writeln(txtTexto,strTransacao);
              Inc(intCodSeq1);

              {***********************************************************}
              {* REGISTRO DE DETALHE (TÍTULOS DO BRADESCO) SEGMENTO J-52 *}
              {*REQ. 135402 *******************************************MO*}

              strTransacao := fPadR('237'                             , 03)      + //001 - 003 - CÓDIGO DO BANCO NA COMPENSAÇÃO
                              fPadR(fStrZero(intIndLot,4)             , 04)      + //004 - 007 - LOTE DE SERVIÇO
                              fPadR('3'                               , 01)      + //008 - 008 - TIPO DE REGISTRO
                              fPadL(IntToStr(intCodSeq1)              , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                              fPadR('J'                               , 01)      + //014 - 014 - CÓD. SEGMENTO DO REGISTRO DETALHE
                              fPadL(' '                               , 01)      + //015 - 015 - USO EXCLUSIVO FEBRABAN/CNAB
                              fPadL('00'                              , 02)      + //016 - 017 - CÓDIGO DE MOVIMENTO REMESSA
                              fPadL('52'                              , 02)      + //018 - 019 - IDENTIFICAÇÃO REGISTRO OPCIONAL
                              fPadR(IntToStr(intTipIns)               , 01)      + //020 - 020 - TIPO DE INSCRIÇÃO DO SACADO
                              fPadL(strCgcEmp                         , 15, '0') + //021 - 035 - NÚMERO DE INSCRIÇÃO DO SACADO
                              fPadR(strNomEmp                         , 40)      + //036 - 075 - NOME DO SACADO
                              fPadR(IntToStr(intTipInsFor)            , 01)      + //076 - 076 - TIPO DE INSCRIÇÃO DO CEDENTE
                              fPadL(FieldByName('CODCGC').AsString    , 15, '0') + //077 - 091 - NÚMERO DE INSCRIÇÃO DO CEDENTE
                              fPadR(FieldByName('FOR_NOMFOR').AsString, 40)      + //092 - 131 - NOME DO CEDENTE
                              fPadR(IntToStr(intTipInsFor)            , 01)      + //132 - 132 - TIPO DE INSCRIÇÃO DO SACADOR
                              fPadL(FieldByName('CODCGC').AsString    , 15, '0') + //133 - 147 - NÚMERO DE INSCRIÇÃO DO SACADOR
                              fPadR(FieldByName('FOR_NOMFOR').AsString, 40)      + //148 - 187 - NOME DO SACADOR
                              fPadL(' '                               , 53, ' ');  //188 - 240 - USO EXCLUSIVO FEBRABAN/CNAB

              {******************************}
              {* ESCREVE A TRANSACAO NO TXT *}
              {***************************MO*}
              Writeln(txtTexto,strTransacao);

              {****************}
              {* GRAVA LOGCTP *}
              {*************JS*}
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

          End;

          {*****************************************************}
          {* TRAILLER DO LOTE (TÍTULOS DO BRADESCO) => Reg 5   *}
          {**************************************************KP*}
          Inc(intCodSeq1);
          Inc(intCodSeq1);
          strTraillerLot := '';
          strTraillerLot := fPadR      ('237'               , 003)       + //001 - 003
                            fPadR      (fStrZero(intIndLot,4), 004)      + //004 - 007
                            fPadR      ('5'                 , 001)       + //008 - 008
                            fPadR      (' '                 , 009)       + //009 - 017
                            fPadL      (IntToStr(intCodSeq1), 006, '0')  + //018 - 023
                            fValNumForm(fltValPag1          , 018)       + //024 - 041
                            fStrZero   ('0'                 , 018)       + //042 - 059
                            fStrZero   ('0'                 , 006)       + //060 - 065
                            fPadR      (' '                 , 165)       + //066 - 230
                            fPadR      (' '                 , 010);        //231 - 240

          {*************************************}
          {* ESCREVE O TRAILLER DO LOTE NO TXT *}
          {**********************************KP*}
          Writeln(txtTexto,strTraillerLot);
          Inc(intIndLot);
        End;

        //BUSCA REGISTROS PARA O SEGMENTO J
        qryRemessa.Filtered := False;
        qryRemessa.Filter   := ' CODBAN <> ' + QuotedStr('237') + ' AND ' +
                               ' PGI_TIPPAG = "" AND '+
                               ' FORMAPAGTO <> ' + QuotedStr('DEP');
        qryRemessa.Filtered := True;

        intCodSeq2 := 0;

        If Not qryRemessa.IsEmpty Then
        Begin
          Inc(intTotLot);

          If intIndLot = 0 Then
            intIndLot := 1;

          {***************************************************************}
          {* HEADER DO LOTE (TÍTULOS DO BRADESCO) => REG 1 => SEGMENTO J *}
          {************************************************************KP*}
          strHeaderLot := '';
          strHeaderLot := fPadR   ('237'              , 003)      + //001 - 003
                          fPadR   (fStrZero(intIndLot,4), 004)    + //004 - 007
                          fPadR   ('1'                , 001)      + //008 - 008
                          fPadL   ('C'                , 001)      + //009 - 009
                          fPadR   ('20'               , 002)      + //010 - 011
                          fPadR   ('31'               , 002)      + //012 - 013
                          fPadR   ('040'              , 003)      + //014 - 016
                          fPadL   (' '                , 001)      + //017 - 017
                          fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                          fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                          fPadR   (strCodCon          , 020)      + //033 - 052
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
                          fPadR   (' '                , 008)      + //223 - 230
                          fPadR   (' '                , 010);       //231 - 240

          {****************************}
          {* ESCREVE O HEADER DO LOTE *}
          {*************************KP*}
          Writeln(txtTexto,strHeaderLot);

          {***************************************************************************}
          {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG = 3 => SEGMENTO J *}
          {************************************************************************KP*}
          With qryRemessa Do
          Begin

            strTransacao := '';
            fltValPag2   := 0;
            fltValOutrasEntidades := 0;

            While Not Eof Do
            Begin
              Inc(intCodSeq2);

              Application.ProcessMessages;

              strDtaVen := FormatDateTime('dd',FieldByName('PGI_DTAVEN').AsDateTime) +
                           FormatDateTime('mm',FieldByName('PGI_DTAVEN').AsDateTime) +
                           FormatDateTime('yyyy',FieldByName('PGI_DTAVEN').AsDateTime);

              strDtaPag := FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime) +
                           FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                           FormatDateTime('yyyy',FieldByName('PGI_DTAPAG').AsDateTime);

              strAutInc := FieldByName('PGI_AUTOIN').AsString;

              fltValPag2 := fltValPag2 + FieldByName('PGI_VALPAG').AsFloat;

              If Length(FieldByName('CODCGC').AsString) > 11 Then
                intTipInsFor := 2
              Else
                intTipInsFor := 1;

              {************************************************************************}
              {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG 3 - SEGMENTO A *}
              {*********************************************************************KP*}

              strTransacao := fPadR      ('237'                                   , 03)      + //001 - 003
                              fPadR      (fStrZero(intIndLot,4)                   , 04)      + //004 - 007
                              fPadR      ('3'                                     , 01)      + //008 - 008
                              fPadL      (IntToStr(intCodSeq2)                    , 05, '0') + //009 - 013
                              fPadR      ('J'                                     , 01)      + //014 - 014
                              fStrZero   ('0'                                     , 01)      + //015 - 015
                              fStrZero   (strCodMovimento                         , 02)      + //016 - 017
                              fPadL      (FieldByName('PGI_CODBAR').AsString      , 44, '0') + //018 - 061
                              fPadR      (FieldByName('FOR_NOMFOR').AsString      , 30, ' ') + //062 - 091
                              fPadR      (strDtaVen                               , 08)      + //092 - 099
                              fValNumForm(FieldByName('PGI_VALDUP').AsFloat       , 15)      + //100 - 114
                              fValNumForm(FieldByName('PGI_VALDES').AsFloat       , 15)      + //115 - 129
                              fValNumForm(0                                       , 15)      + //130 - 144
                              fPadR      (strDtaPag                               , 08)      + //145 - 152
                              fValNumForm(FieldByName('PGI_VALPAG').AsFloat       , 15)      + //153 - 167
                              fStrZero   ('0'                                     , 15)      + //168 - 182
                              fPadL      (strAutInc                               , 20, '0') + //183 - 202
                              fPadL      (' '                                     , 20)      + //203 - 222
                              fPadL      ('09'                                    , 02)      + //223 - 224
                              fPadL      (' '                                     , 16)      ; //225 - 240

              {******************************}
              {* ESCREVE A TRANSACAO NO TXT *}
              {***************************KP*}
              Writeln(txtTexto,strTransacao);
              Inc(intCodSeq2);

              {****************************************************************}
              {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) SEGMENTO J-52 *}
              {*REQ. 135402 ************************************************MO*}

              strTransacao := fPadR('237'                             , 03)      + //001 - 003 - CÓDIGO DO BANCO NA COMPENSAÇÃO
                              fPadR(fStrZero(intIndLot,4)             , 04)      + //004 - 007 - LOTE DE SERVIÇO
                              fPadR('3'                               , 01)      + //008 - 008 - TIPO DE REGISTRO
                              fPadL(IntToStr(intCodSeq2)              , 05, '0') + //009 - 013 - Nº SEQUÊNCIAL DO REGISTRO NO LOTE
                              fPadR('J'                               , 01)      + //014 - 014 - CÓD. SEGMENTO DO REGISTRO DETALHE
                              fPadL(' '                               , 01)      + //015 - 015 - USO EXCLUSIVO FEBRABAN/CNAB
                              fPadL('00'                              , 02)      + //016 - 017 - CÓDIGO DE MOVIMENTO REMESSA
                              fPadL('52'                              , 02)      + //018 - 019 - IDENTIFICAÇÃO REGISTRO OPCIONAL
                              fPadR(IntToStr(intTipIns)               , 01)      + //020 - 020 - TIPO DE INSCRIÇÃO DO SACADO
                              fPadL(strCgcEmp                         , 15, '0') + //021 - 035 - NÚMERO DE INSCRIÇÃO DO SACADO
                              fPadR(strNomEmp                         , 40)      + //036 - 075 - NOME DO SACADO
                              fPadR(IntToStr(intTipInsFor)            , 01)      + //076 - 076 - TIPO DE INSCRIÇÃO DO CEDENTE
                              fPadL(FieldByName('CODCGC').AsString    , 15, '0') + //077 - 091 - NÚMERO DE INSCRIÇÃO DO CEDENTE
                              fPadR(FieldByName('FOR_NOMFOR').AsString, 40)      + //092 - 131 - NOME DO CEDENTE
                              fPadR(IntToStr(intTipInsFor)            , 01)      + //132 - 132 - TIPO DE INSCRIÇÃO DO SACADOR
                              fPadL(FieldByName('CODCGC').AsString    , 15, '0') + //133 - 147 - NÚMERO DE INSCRIÇÃO DO SACADOR
                              fPadR(FieldByName('FOR_NOMFOR').AsString, 40)      + //148 - 187 - NOME DO SACADOR
                              fPadL(' '                               , 53, ' ');  //188 - 240 - USO EXCLUSIVO FEBRABAN/CNAB

              {******************************}
              {* ESCREVE A TRANSACAO NO TXT *}
              {***************************MO*}
              Writeln(txtTexto,strTransacao);

              {****************}
              {* GRAVA LOGCTP *}
              {*************JS*}
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

          End;

          {*****************************************************}
          {* TRAILLER DO LOTE (TÍTULOS DO BRADESCO) => Reg 5   *}
          {**************************************************KP*}
          Inc(intCodSeq2);
          Inc(intCodSeq2);
          strTraillerLot := '';
          strTraillerLot := fPadR      ('237'               , 003)       + //001 - 003
                            fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                            fPadR      ('5'                 , 001)       + //008 - 008
                            fPadR      (' '                 , 009)       + //009 - 017
                            fPadL      (IntToStr(intCodSeq2), 006, '0')  + //018 - 023
                            fValNumForm(fltValPag2          , 018)       + //024 - 041
                            fStrZero   ('0'                 , 018)       + //042 - 059
                            fStrZero   ('0'                 , 006)       + //060 - 065
                            fPadR      (' '                 , 165)       + //066 - 230
                            fPadR      (' '                 , 010);        //231 - 240


          {*************************************}
          {* ESCREVE O TRAILLER DO LOTE NO TXT *}
          {**********************************KP*}
          Writeln(txtTexto,strTraillerLot);
          Inc(intIndLot);

        End;

        {**************************************}
        {* FILTRANDO CONCESSIONARIA E TRIBUTO *}
        {**************************************}
        qryRemessa.Filtered := False;
        qryRemessa.Filter   := ' CODBAN <> ' + QuotedStr('341') +
                               ' AND PGI_TIPPAG <> "" '+
                               ' AND (FORMAPAGTO <> ' + QuotedStr('DEP') +
                               ' OR ((PGI_Q_GUIA <> '''') OR (PGI_Q_GUIA IS NOT NULL))) ';
        qryRemessa.Filtered := True;

        intCodSeq3 := 0;

        If Not qryRemessa.IsEmpty Then
        Begin
          {********************}
          {* GERANDO TRIBUTOS *}
          {*REQ*112543******MO*}
          GeraTributos(qryRemessa);

          {**********************************************************************************************************************************}
          {* FILTRANDO NOVAMENTE A QUERY PARA VERIFICAR SE EXISTE DADOS DE CONCESSIONÁRIA, SE GEROU DADOS DE TRIBUTOS, **********************}
          {* A QUERY VAI PARA O ÚLTIMO REGISTRO, COM ISSO SE TEM DADOS DE CONCESSIONÁRIA TEMOS QUE VOLTAR AO INÍCIO PARA GERAR ESSES DADOS. *}
          {*REQ*112543********************************************************************************************************************MO*}
          qryRemessa.Filtered := False;
          qryRemessa.Filter   := ' CODBAN <> ' + QuotedStr('341') +
                                 ' AND PGI_TIPPAG <> "" '+
                                 ' AND (FORMAPAGTO <> ' + QuotedStr('DEP') +
                                 ' OR ((PGI_Q_GUIA <> '''') OR (PGI_Q_GUIA IS NOT NULL))) ';
          qryRemessa.Filtered := True;

          With qryRemessa Do
          Begin
            strTransacao := '';
            fltValPag2   := 0;
            intCodSeq3   := 0;
            fltValOutrasEntidades      := 0;
            AGeraHeaderConcessionaria  := True;
            AGeraTrailerConcessionaria := False;

            While Not Eof Do
            Begin
              {*****************************************************}
              {* SEPARANDO OS TRIBUTOS DOS DADOS DE CONCESSIONÁRIA *}
              {*REQ*112543***************************************MO*}
              if fEmptyStr(FieldByName('PGI_Q_GUIA').AsString) then
              begin
                {*********************************************************************************}
                {* GARANTINDO QUE QUANDO FOR CONCESSIONÁRIA O HEADER SERÁ CRIADO SOMENTE UMA VEZ *}
                {*********************************************************************************}
                If AGeraHeaderConcessionaria Then
                begin
                  {***********************************************************}
                  {* 11 - PAGAMENTO DE CONTAS E TRIBUTOS COM CÓDIGO DE BRRAS *}
                  {***********************************************************}
                  HeaderConcessionariaTributos('11');
                  AGeraHeaderConcessionaria  := False;
                  AGeraTrailerConcessionaria := True;
                end;

                Inc(intCodSeq3);

                Application.ProcessMessages;

                strDtaVen := FormatDateTime('dd',FieldByName('PGI_DTAVEN').AsDateTime) +
                             FormatDateTime('mm',FieldByName('PGI_DTAVEN').AsDateTime) +
                             FormatDateTime('yyyy',FieldByName('PGI_DTAVEN').AsDateTime);

                strDtaPag := FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime) +
                             FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                             FormatDateTime('yyyy',FieldByName('PGI_DTAPAG').AsDateTime);

                strAutInc := FieldByName('PGI_AUTOIN').AsString;

                fltValPag2 := fltValPag2 + FieldByName('PGI_VALPAG').AsFloat;


                strTransacao := fPadR      ('237'                                    , 03)      + //001 - 003
                                fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007
                                fPadR      ('3'                                      , 01)      + //008 - 008
                                fPadL      (IntToStr(intCodSeq3)                     , 05, '0') + //009 - 013
                                fPadR      ('O'                                      , 01)      + //014 - 014
                                fStrZero   ('0'                                      , 01)      + //015 - 015
                                fStrZero   (strCodMovimento                          , 02)      + //016 - 017
                                fPadR      (FieldByName('PGI_CODBAR').AsString       , 44, ' ') + //018 - 061
                                fPadR      (FieldByName('FOR_NOMFOR').AsString       , 30, ' ') + //062 - 091
                                fPadR      (strDtaVen                                , 08)      + //092 - 099
                                fPadR      (strDtaPag                                , 08)      + //100 - 107
                                fValNumForm(FieldByName('PGI_VALDUP').AsFloat        , 15)      + //108 - 122
                                fPadL      (strAutInc                                , 20, ' ') + //123 - 142
                                fPadL      (' '                                      , 20, ' ') + //143 - 162
                                fPadL      (' '                                      , 68)      + //163 - 230
                                fPadL      (' '                                      , 10);       //231 - 240

                {******************************}
                {* ESCREVE A TRANSACAO NO TXT *}
                {***************************JU*}
                Writeln(txtTexto,strTransacao);

                {****************}
                {* GRAVA LOGCTP *}
                {*************JS*}
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
              end;

              Next;
            End;
            {********************}
            {* TRAILLER DO LOTE *}
            {********************}
            if AGeraTrailerConcessionaria then
              TrailerConcessionariaTributos;
          End;

        End;

        {***************************************************************}
        {* GERAÇÃO DO TED DE 237 PARA 237 E 237 PARA DIFERENTES BANCOS *}
        {************************************************************MO*}
        intCodSeqTED      := 0;
        intCodSeqGeralTED := 0;
        pGeraTED(qryRemessa, True, LApenasSalarios);
        pGeraTED(qryRemessa, False, LApenasSalarios);

        {********************************}
        {* TRAILLER DO ARQUIVO => Reg 9 *}
        {*****************************KP*}
        intCodSeqGer:= intCodSeq1 + intCodSeq2 + intCodSeq3 + intCodSeqTributos + intCodSeqGeralTED + 2;
        strTrailler := '';
        strTrailler := fPadR   ('237'                 , 003)      + //001 - 003
                       fPadR   ('9999'                , 004)      + //004 - 007
                       fPadR   ('9'                   , 001)      + //008 - 008
                       fPadR   (' '                   , 009)      + //009 - 017
                       fPadL   (IntToStr(intTotLot)   , 006, '0') + //018 - 023
                       fPadL   (IntToStr(intCodSeqGer), 006, '0') + //024 - 029
                       fStrZero('0'                   , 006)      + //030 - 035
                       fPadR   (' '                   , 205);       //036 - 240

        {****************************************}
        {* ESCREVE O TRAILLER DO ARQUIVO NO TXT *}
        {*************************************KP*}
        If LQuebraLinhaTrailerArquivo Then
        Begin
           {**************
           * -1 = VAZIO *
           *  0 = CR    *
           *  1 = CR LF *
           **************}
          If LCaracterQuebraLinhaTrailer.Equals('1') Then
            Writeln(txtTexto,strTrailler)
          Else
            Write(txtTexto,strTrailler + #13);

        End
        Else Write(txtTexto,strTrailler);


        CloseFile(txtTexto);

        strSQL := '';
        strSQL := strSQL + 'DELETE FROM CADPGI          ';
        strSQL := strSQL + ' WHERE PGI_CODBCO = :CODBCO ';

        If LApenasSalarios Then
          strSQL := strSQL + ' AND PGI_SEQSAL IS NOT NULL ';

        With qryRemessa Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODBCO').AsString := strCodBco;
          ExecSQL;
          Close;
        End;

        pBackupCnfBco;

        If fCommit then
          fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                    'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);

        fGetBancoConfig(1, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'SEQARQU', IntToStr(StrToInt(strSeqArq)+1));
      End;
    end
    Else
    Begin
      fRollBack;
      If LApenasSalarios Then
        fMensagem('AVISO','Convênio exclusivo para pagamento de salários e não foi ' +
                          'encontrado nenhum registro referente a pagamento salarial para gerar o arquivo!',['&O K'])
      Else
        fMensagem('AVISO','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

    FreeAndNil(qryFormaPgto);
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
		  FreeAndNil(qryConsultaGen);
		  pMensagensErro(E.Message,  '[untExpArqRemBradescoCta240.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');

		End;
  End;

end;

function TfrmExpArqRemBradescoCta240.fRetEmpresa: String;
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


{**********************************************}
{* CÓDIGO DOS TRIBUTOS - SEGMENTO N 111 - 116 *}
{* 16 - DARF **********************************}
{* 17 - GPS ***********************************}
{* 18 - DARF SIMPLES **************************}
{* 22 - GARE-SP ICMS **************************}
{* 23 - GARE-SP DR ****************************}
{* 24 - GARE-SP ITCMD *************************}
{**********************************************}
procedure TfrmExpArqRemBradescoCta240.GeraTributos(qryTributos: TUniQuery);
var
  intRegN: Integer;
  AGerouHeader: Boolean;
  AJaZerou: Boolean;
  ATipoInscricao: String;
  ADate: TDateTime;
  AUltimoDiaMes: String;
  AValorTotalTributo: Double;
  strNumeroBanco: String;
begin
  AJaZerou              := False;
  AGerouHeader          := False;
  ATipoInscricao        := '';
  fltValPag2            := 0;
  fltValOutrasEntidades := 0;

  If Length(strCgcEmp) > 11 Then
    ATipoInscricao := '1'
  Else
    ATipoInscricao := '2';

  // GERAÇÃO DOS TRIBUTOS
  {*****************************************************************************************}
  {* Registro Detalhe – Segmento N – Pagamento de Tributos e Impostos sem Código de Barras *}
  {**************************************************************************************CH*}

  {**************************************************************}
  {* N1. GPS – Informações complementares para pagamento da GPS *}
  {***********************************************************CH*}

  qryTributos.Filtered := False;
  qryTributos.Filter   := ' PGI_Q_GUIA = ' + QuotedStr('1');
  qryTributos.Filtered := True;

  With qryTributos Do
  Begin
    fltValPag2   := 0;
    strTransacao := '';
    fltValOutrasEntidades := 0;

    While Not Eof Do
    Begin
      Inc(intCodSeq3);

      Application.ProcessMessages;

      strDtaPag  := FormatDateTime('dd', FieldByName('PGI_DTAPAG').AsDateTime) +
                    FormatDateTime('mm', FieldByName('PGI_DTAPAG').AsDateTime) +
                    FormatDateTime('yyyy', FieldByName('PGI_DTAPAG').AsDateTime);

      fltValPag2 := fltValPag2 + FieldByName('PGI_VALPAG').AsFloat;
      fltValOutrasEntidades := fltValOutrasEntidades + FieldByName('PGI_OUTENT').AsFloat;

      AValorTotalTributo := FieldByName('PGI_VALPAG').AsFloat + FieldByName('PGI_OUTENT').AsFloat;

      strCompet  := Copy(qryTributos.FieldByName('PGI_COMPET').asString,1,2)+
                    Copy(qryTributos.FieldByName('PGI_COMPET').asString,4,4);

      strCodTrib := qryTributos.FieldByName('PGI_CODREC').asString;

      strNumeroBanco := FieldByName('PGI_NUMDUP').AsString +
                        FieldByName('PGI_PARCEL').AsString +
                        FieldByName('PGI_CODEMP').AsString +
                        fPadR(FieldByName('PGI_SERIE_').AsString, 3, '_');

      strIdTrib := '17';
      if Not AGerouHeader Then
      begin
        HeaderConcessionariaTributos(strIdTrib);
        AGerouHeader := True;
      end;

      strTransacao := fPadR      ('237'                                   , 03)      + //Código do Banco na Compensação              001 - 003
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
                      fPadR      (strCodTrib                              , 06, ' ') + //Código da Receita do Tributo                111 - 116
                      fPadL      (ATipoInscricao                          , 02, '0') + //Tipo de Identificação do Contribuinte       117 - 118
                      fPadL      (strCgcEmp                               , 14, '0') + //Identificação do Contribuinte               119 - 132
                      fPadL      (strIdTrib                               , 02)      + //Código de Identificação do Tributo          133 - 134
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

  {****************************************************************}
  {* N2. DARF – Informações complementares para pagamento de DARF *}
  {*************************************************************CH*}

  qryTributos.Filtered := False;
  qryTributos.Filter   := ' PGI_Q_GUIA = ' + QuotedStr('2');
  qryTributos.Filtered := True;
  intCodSeqTributos := intCodSeqTributos + intCodSeq3;
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

      strIdTrib  := '16';

      if Not AGerouHeader Then
      begin
        HeaderConcessionariaTributos(strIdTrib);
        AGerouHeader := True;
      end;


      strTransacao := fPadR      ('237'                                   , 03)      + //Código do Banco na Compensação              001 - 003
                      fPadR      (fStrZero(intIndLot,4)                   , 04)      + //Lote de Serviço                             004 - 007
                      fPadR      ('3'                                     , 01)      + //Tipo de Registro                            008 - 008
                      fPadL      (IntToStr(intCodSeq3)                    , 05, '0') + //Nº Sequencial do Registro no Lote           009 - 013
                      fPadR      ('N'                                     , 01)      + //Cód. Segmento do Registro Detalhe           014 - 014
                      fPadR      ('0'                                     , 01)      + //Tipo de Movimento                           015 - 015
                      fPadL      (strCodMovimento                         , 02, '0')      + //Código da Instrução de Movimento            016 - 017
                      fPadR      (FieldByName('PGI_AUTOIN').AsString      , 20, ' ') + //Nº do Docto Atribuído pela Empresa          018 - 037
                      fPadR      (strNumeroBanco                          , 20, ' ') + //Nº do Docto Atribuído pelo Banco            038 - 057
                      fPadR      (strNomEmp                               , 30, ' ') + //Nome do Contribuinte                        058 - 087
                      fPadR      (strDtaPag                               , 08)      + //Data do Pagamento                           088 - 095
                      fValNumForm(AValorTotalTributo                      , 15)      + //Valor do Total do Pagamento                 096 - 110
                      fPadR      (strCodTrib                              , 06, ' ') + //Código da Receita do Tributo                111 - 116
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

  {********************************************************************************}
  {* N3. DARF Simples – Informações complementares para pagamento de DARF SIMPLES *}
  {*****************************************************************************CH*}

  qryTributos.Filtered := False;
  qryTributos.Filter   := ' PGI_Q_GUIA = ' + QuotedStr('3');
  qryTributos.Filtered := True;
  intCodSeqTributos := intCodSeqTributos + intCodSeq3;
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

      strIdTrib  := '18';
      if Not AGerouHeader Then
      begin
        HeaderConcessionariaTributos(strIdTrib);
        AGerouHeader := True;
      end;

      strTransacao := fPadR      ('237'                                   , 03)      + //Código do Banco na Compensação              001 - 003
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

  {**************************************************************************************}
  {* N4. GARE-SP (ICMS/DR/ITCMD) – Informações complementares para pagamento de GARE-SP *}
  {***********************************************************************************CH*}

  For intRegN := 4 to 6 Do
  Begin

    qryTributos.Filtered := False;
    qryTributos.Filter   := ' PGI_Q_GUIA = ' + IntToStr(intRegN);
    qryTributos.Filtered := True;

    if qryTributos.Recordcount > 0 then
    begin
      intCodSeqTributos := intCodSeqTributos + intCodSeq3;
      intCodSeq3 := 0;
      AJaZerou := True;
    end;

    With qryTributos Do
    Begin
      AGerouHeader := False;
      strTransacao := '';

      While Not Eof Do
      Begin
        if AJaZerou then
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

        strCompet := Copy(qryTributos.FieldByName('PGI_COMPET').asString,1,2)+
                     Copy(qryTributos.FieldByName('PGI_COMPET').asString,4,4);

        strCodTrib := qryTributos.FieldByName('PGI_CODREC').asString;

        strNumeroBanco := FieldByName('PGI_NUMDUP').AsString +
                          FieldByName('PGI_PARCEL').AsString +
                          FieldByName('PGI_CODEMP').AsString +
                          fPadR(FieldByName('PGI_SERIE_').AsString, 3, '_');

        If qryTributos.FieldByName('PGI_Q_GUIA').asInteger = 4 Then
          strIdTrib  := '22';
        If qryTributos.FieldByName('PGI_Q_GUIA').asInteger = 5 Then
          strIdTrib  := '23';
        If qryTributos.FieldByName('PGI_Q_GUIA').asInteger = 6 Then
          strIdTrib  := '24';

        if Not AGerouHeader Then
        begin
          HeaderConcessionariaTributos(strIdTrib);
          AGerouHeader := True;
        end;

        strTransacao := fPadR      ('237'                                   , 03)      + //Código do Banco na Compensação              001 - 003
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
                        fPadR      (strDtaVen                               , 08)      + //Data de Vencimento                          135 - 142
                        fPadR      (strIE_Emp                               , 12)      + //IE / Código Município / Nº Declaração       143 - 154
                        fValNumForm(0                                       , 13)      + //Dívida Ativa / N. Etiqueta                  155 - 167
                        fPadR      (strCompet                               , 06)      + //Período de Referência                       168 - 173
                        fValNumForm(0                                       , 13)      + //Núm. Parcela / Notificação                  174 - 186
                        fValNumForm(FieldByName('PGI_VALDUP').AsFloat       , 15)      + //Valor da Receita                            187 - 201
                        fValNumForm(0                                       , 14)      + //Valor dos Juros / Encargos                  202 - 215
                        fValNumForm(0                                       , 14)      + //Valor da Multa                              216 - 229
                        fPadL      (' '                                     , 01)      + //Uso Exclusivo FEBRABAN/CNAB                 230 - 230
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

  End;

  {****************************************************************}
  {* N7. GNRE – Informações complementares para pagamento de GNRE *}
  {*************************************************************AJ*}

  qryTributos.Filtered := False;
  qryTributos.Filter   := ' PGI_Q_GUIA = ' + QuotedStr('7');
  qryTributos.Filtered := True;
  intCodSeqTributos := intCodSeqTributos + intCodSeq3;
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

      strCompet := '01'+
                   Copy(qryTributos.FieldByName('PGI_COMPET').asString,1,2)+
                   Copy(qryTributos.FieldByName('PGI_COMPET').asString,4,4);

      strCodTrib := qryTributos.FieldByName('PGI_CODREC').asString;

      strIdTrib  := '11';
      if Not AGerouHeader Then
      begin
        HeaderConcessionariaTributos(strIdTrib);
        AGerouHeader := True;
      end;

      strTransacao := fPadR      ('237'                                    , 03)      + //001 - 003
                      fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007
                      fPadR      ('3'                                      , 01)      + //008 - 008
                      fPadL      (IntToStr(intCodSeq3)                     , 05, '0') + //009 - 013
                      fPadR      ('O'                                      , 01)      + //014 - 014
                      fStrZero   ('0'                                      , 01)      + //015 - 015
                      fStrZero   (strCodMovimento                          , 02)      + //016 - 017
                      fPadR      (FieldByName('PGI_CODBAR').AsString       , 44, ' ') + //018 - 061
                      fPadR      (FieldByName('FOR_NOMFOR').AsString       , 30, ' ') + //062 - 091
                      fPadR      (strDtaVen                                , 08)      + //092 - 099
                      fPadR      (strDtaPag                                , 08)      + //100 - 107
                      fValNumForm(AValorTotalTributo                       , 15)      + //108 - 122
                      fPadL      (FieldByName('PGI_AUTOIN').AsString       , 20, ' ') + //123 - 142
                      fPadL      (' '                                      , 20, ' ') + //143 - 162
                      fPadL      (' '                                      , 68)      + //163 - 230
                      fPadL      (' '                                      , 10);       //231 - 240

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
end;

procedure TfrmExpArqRemBradescoCta240.HeaderConcessionariaTributos(AFormaLancamento: String);
begin
  Inc(intTotLot);

  {********************************************************************************************************}
  {* HEADER DO LOTE (Pagamento de Concessionárias e tributos com código de barras) => REG 1 => SEGMENTO O *}
  {*****************************************************************************************************KP*}
  strHeaderLot := '';
  strHeaderLot := fPadR   ('237'              , 003)      + //001 - 003
                  fPadR   (fStrZero(intIndLot,4), 004)    + //004 - 007
                  fPadR   ('1'                , 001)      + //008 - 008
                  fPadL   ('C'                , 001)      + //009 - 009
                  fPadR   ('22'               , 002)      + //010 - 011
                  fPadR   (AFormaLancamento   , 002)      + //012 - 013
                  fPadR   ('012'              , 003)      + //014 - 016
                  fPadL   (' '                , 001)      + //017 - 017
                  fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                  fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                  fPadR   (strCodCon          , 020)      + //033 - 052
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
                  fPadR   ('01 '              , 002)      + //223 - 224
                  fPadR   (' '                , 008)      + //225 - 230
                  fPadR   (' '                , 008);       //231 - 240

  {****************************}
  {* ESCREVE O HEADER DO LOTE *}
  {*************************KP*}
  Writeln(txtTexto,strHeaderLot);
end;

procedure TfrmExpArqRemBradescoCta240.pGeraTED(qryTED: TUniQuery; blnBancoDiferente: Boolean; AApenasSalarios: Boolean);
  Var
    FCodTed,
    FCompDes : String;
begin
  qryTED.Filtered := False;
  qryTED.Filter   := ' CODBAN = ' + QuotedStr('237') +
                     ' AND FORMAPAGTO = ' + QuotedStr('DEP') +
                     ' AND CODBCO ' + IIF(blnBancoDiferente, ' <> ', ' = ') + QuotedStr('237') +
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
    strHeaderLot := fPadR   ('237'              , 003)                 + //001 - 003 - CÓD. DO BANCO
                    fPadR   (fStrZero(intIndLot,4), 004)               + //004 - 007 - LOTE DO SERVIÇO
                    fPadR   ('1'                , 001)                 + //008 - 008 - TIPO DE REGISTRO
                    fPadL   ('C'                , 001)                 + //009 - 009 - TIPO DE OPERAÇÃO
                    fPadR   (IIF(AApenasSalarios, '30', '20'), 002)    + //010 - 011 - TIPO DO SERVIÇO
                    fPadR   (IIF(blnBancoDiferente, '41', '01') , 002) + //012 - 013 - FORMA DE LANÇAMENTO
                    fPadR   ('045'              , 003)                 + //014 - 016 - Nº DA VERSÃO DO LAYOUT DO LOTE
                    fPadL   (' '                , 001)                 + //017 - 017 - USO EXCLUSIVO FEBRABAN
                    fPadR   (IntToStr(intTipIns), 001)                 + //018 - 018 - TIPO DE INSCRIÇÃO DA EMPRESA
                    fPadL   (strCgcEmp          , 014, '0')            + //019 - 032 - Nº DE INSCRIÇÃO DA EMPRESA
                    fPadR   (strCodCon          , 020)                 + //033 - 052 - CÓD. DO CONVÊNIO NO BANCO
                    fPadL   (strCodAgen         , 005, '0')            + //053 - 057 - AG. MANTENEDORA DA CONTA
                    fPadR   (strDigAgen         , 001)                 + //058 - 058 - DIG. BERIFICADOR DA AGÊNCIA
                    fPadL   (strContCor         , 012, '0')            + //059 - 070 - Nº DA CONTA CORRENTE
                    fPadR   (strDigCnt          , 001)                 + //071 - 071 - DIGITO VERIFICADOR DA CONTA
                    fPadL   (' '                , 001, ' ')            + //072 - 072 - DIGITO VERIFICADOR DA AG/CONTA
                    fPadR   (strNomEmp          , 030, ' ')            + //073 - 102 - NOME DA EMPRESA
                    fPadL   (' '                , 040)                 + //103 - 142 - MENSAGEM
                    fPadR   (strEndEmp          , 030, ' ')            + //143 - 172 - NOME DA RUA, AV, PÇA, ETC
                    fPadL   (strNumEmp          , 005, '0')            + //173 - 177 - Nº DO LOCAL
                    fPadR   (strComEmp          , 015, ' ')            + //178 - 192 - CASA, APTO, SALA, ETC
                    fPadR   (strCidEmp          , 020, ' ')            + //193 - 212 - NOME DA CIDADE
                    fPadL   (strCepEmp          , 008, '0')            + //213 - 220 - CEP + COMPLEMENTO DO CEP
                    fPadR   (strEstEmp          , 002, ' ')            + //221 - 222 - SIGLA DO ESTADO
                    fPadR   ('01 '              , 002)                 + //223 - 224 - INDICATIVO DE FORMA DE PAGAMENTO DO SERVIÇO
                    fPadR   (' '                , 006)                 + //225 - 230 - USO EXCLUSIVO FEBRABAN
                    fPadR   (' '                , 010);                  //231 - 240 - CPDIGO DAS OCORRÊNCIAS P/ RETORNO

    {****************************}
    {* ESCREVE O HEADER DO LOTE *}
    {*************************MO*}
    Writeln(txtTexto,strHeaderLot);

    With qryTED Do
    Begin
      strTransacao := '';
      fltValPag4   := 0;

      While Not Eof Do
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

        Application.ProcessMessages;

        strDtaVen := FormatDateTime('dd',FieldByName('PGI_DTAVEN').AsDateTime) +
                     FormatDateTime('mm',FieldByName('PGI_DTAVEN').AsDateTime) +
                     FormatDateTime('yyyy',FieldByName('PGI_DTAVEN').AsDateTime);

        strDtaEmi := FormatDateTime('dd',FieldByName('PGI_DTACAD').AsDateTime) +
                     FormatDateTime('mm',FieldByName('PGI_DTACAD').AsDateTime) +
                     FormatDateTime('yyyy',FieldByName('PGI_DTACAD').AsDateTime);

        strDtaPag := FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime) +
                     FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                     FormatDateTime('yyyy',FieldByName('PGI_DTAPAG').AsDateTime);

        strAutInc := FieldByName('PGI_AUTOIN').AsString;

        fltValPag4 := fltValPag4 + FieldByName('PGI_VALPAG').AsFloat;

        FCodTed  := IIF(blnBancoDiferente,FieldByName('PGI_CODTED').AsString,'');
        FCompDes := IIF(blnBancoDiferente,FieldByName('COMPDES').AsString,'');

        strTransacao := fPadR      ('237'                                    , 03)      + //001 - 003 - CÓD. DO BANCO
                        fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007 - LOTE DE SERVIÇO
                        fPadR      ('3'                                      , 01)      + //008 - 008 - TIPO DE REGISTRO
                        fPadL      (IntToStr(intCodSeqRegTED)                 , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                        fPadR      ('A'                                      , 01)      + //014 - 014 - CÓD. DE SEGMENTO NO REG. DETALHE
                        fStrZero   ('0'                                      , 01)      + //015 - 015
                        fStrZero   (strCodMovimento                          , 02)      + //016 - 017
                        fPadL      (strCamCentralizadora                     , 03, '0') + //018 - 020 - CÓD. DA CÂMARA CENTRALIZADORA
                        fPadL      (FieldByName('CODBCO').AsString           , 03, '0') + //021 - 023 - CÓD. DO BANCO DO FAVORECIDO
                        fPadL      (FieldByName('CODAGE').AsString           , 05, '0') + //024 - 028 - AG. MANTENEDORA DA CTA. DO FAVOR.
                        fPadR      (FieldByName('DIGAGE').AsString           , 01, ' ') + //029 - 029 - DÍGITO VERIFICADOR DA AGÊNCIA
                        fPadL      (FieldByName('NUMCTA').AsString           , 12, '0') + //030 - 041 - Nº DA CONTA CORRENTE
                        fPadR      (FieldByName('DIGCTA').AsString           , 01, ' ') + //042 - 042 - DÍGITO VERIFICADOR DA CONTA
                        fPadR      (FieldByName('DIGVER').AsString           , 01, ' ') + //043 - 043 - DÍGITO VERIFICADOR AG/CONTA
                        fPadR      (FieldByName('FOR_NOMFOR').AsString       , 30, ' ') + //044 - 073 - NOME DO FAVORECIDO
                        fPadL      (strAutInc                                , 20, ' ') + //074 - 093 - Nº DO DOCUMENTO ATRIBUIDO P/ EMPRESA
                        fPadR      (strDtaPag                                , 08)      + //094 - 101 - DATA DO PAGAMENTO
                        fPadR      ('BRL'                                    , 03)      + //102 - 104 - TIPO DA MOEDA
                        fStrZero   ('0'                                      , 15)      + //105 - 119 - QUANTIDADE DA MOEDA
                        fValNumForm(FieldByName('PGI_VALPAG').AsFloat        , 15)      + //120 - 134 - VALOR DO PAGAMENTO
                        fPadL      (' '                                      , 20)      + //135 - 154 - Nº DO DOCUM. ATRIBUIDO PELO BANCO
                        fPadR      (strDtaPag                                , 08)      + //155 - 162 - DATA REAL DA EFETIVAÇÃO DO PAGTO.
                        fValNumForm(FieldByName('PGI_VALPAG').AsFloat        , 15)      + //163 - 177 - VALOR REAL DA EFETIVAÇÃO DO PAGTO.
                        fPadL      (' '                                      , 040)     + //178 - 217 - OUTRAS INFORMAÇÕES
                        fPadR      (' '                                      , 02)      + //218 - 219 - COMPL. TIPO SERVIÇO
                        fPadL      (FCodTed                                  , 05,'0')  + //220 - 224 - CÓDIGO FINALIDADE DA TED
                        fPadR      (FCompDes                                 , 02,' ')  + //225 - 226 - COMPL. FINALIDADE DE PAGAMENTO
                        fPadR      (' '                                      , 03,' ')  + //227 - 229 - USO EXCLUSIVO DA FEBRABAN
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
        strTransacao := fPadR      ('237'                                    , 03)      + //001 - 003 - CÓD. DO BANCO
                        fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007 - LOTE DE SERVIÇO
                        fPadR      ('3'                                      , 01)      + //008 - 008 - TIPO DE REGISTRO
                        fPadL      (IntToStr(intCodSeqRegTED)                 , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
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
                        fValNumForm(FieldByName('PGI_VALDUP').AsFloat        , 15)      + //136 - 150 - VALOR DO DOCUMENTO
                        fValNumForm(FieldByName('PGI_VALPAG').AsFloat        , 15)      + //151 - 165 - VALOR DO ABATIMENTO
                        fValNumForm(FieldByName('PGI_VALDES').AsFloat        , 15)      + //166 - 180 - VALOR DO DESCONTO
                        fStrZero   ('0'                                      , 15)      + //181 - 195 - VALOR DA MORA
                        fValNumForm(FieldByName('PGI_VALJUR').AsFloat        , 15)      + //196 - 210 - VALOR DO MULTA
                        fPadR      (FieldByName('PGI_NUMDUP').AsString       , 15, ' ') + //211 - 225 - Nº DO DOCUMENTO
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

    End;

    {*****************************}
    {* TRAILLER DO LOTE => Reg 5 *}
    {**************************MO*}
    Inc(intCodSeqTED);
    strTraillerLot := '';
    strTraillerLot := fPadR      ('237'                 , 003)      + //001 - 003 - CÓD. DO BANCO NA COMPENSAÇÃO
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

procedure TfrmExpArqRemBradescoCta240.TrailerConcessionariaTributos;
begin
  {********************************************************}
  {* TRAILLER DO LOTE (TÍTULOS DE OUTROS BANCOS) => Reg 5 *}
  {*****************************************************KP*}
  fltValPag2 := fltValPag2 + fltValOutrasEntidades;
  Inc(intCodSeq3);
  Inc(intCodSeq3);
  strTraillerLot := '';
  strTraillerLot := fPadR      ('237'               , 003)       + //001 - 003
                    fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                    fPadR      ('5'                 , 001)       + //008 - 008
                    fPadR      (' '                 , 009)       + //009 - 017
                    fPadL      (IntToStr(intCodSeq3), 006, '0')  + //018 - 023
                    fValNumForm(fltValPag2          , 018)       + //024 - 041
                    fStrZero   ('0'                 , 018)       + //042 - 059
                    fStrZero   ('0'                 , 006)       + //060 - 065
                    fPadR      (' '                 , 165)       + //066 - 230
                    fPadR      (' '                 , 010);        //231 - 240


  {*************************************}
  {* ESCREVE O TRAILLER DO LOTE NO TXT *}
  {**********************************KP*}
  Writeln(txtTexto,strTraillerLot);
  Inc(intIndLot);
end;

end.
