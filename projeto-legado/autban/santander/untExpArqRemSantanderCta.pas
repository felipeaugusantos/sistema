unit untExpArqRemSantanderCta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTCadPag, untTCadPagRepository,untFrameDirectoryEditFocus,untTypesSistema,
  untTFolhaPagamentoSantanderContasPagar, untFuncAutban;

type
  TfrmExpArqRemSantanderCta = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    pnlTopo: TPanel;
    edtNomArquivo: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
  private

    qryConsultaGen : TUniQuery;
    FEnviarCaracterEspecial: Boolean;
    function fRetEmpresa: String;
    function RetornaTextoFormatado(ATexto:String): String;
    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;

  end;

var
  frmExpArqRemSantanderCta: TfrmExpArqRemSantanderCta;

implementation

uses untFuncoes, untfuncoesSimples, DB, untLogCtp;

{$R *.dfm}

procedure TfrmExpArqRemSantanderCta.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(fGetBancoProxNum('CONFIGCTA033-' + IntToStr(intCartei)), 08) +
                         '.TXT';
  pSetFocus(fraPathRemessa);

end;

procedure TfrmExpArqRemSantanderCta.btnGerarClick(Sender: TObject);
  Var
    strSQL         : String;
    strCodBco      : String;
    strNomBco      : String;
    strNomEmp      : String;
    strDtaRem      : String;
    strHorRem      : String;
    strDtaVen      : String;
    strDtaEmi      : String;
    strCgcEmp      : String;
    strCodAgen     : String;
    strContCor     : String;
    strDigCnt      : String;
    strCodCar      : String;
    strDigCar      : String;
//    strCodRem      : String;
//    strDiaPro      : String;
//    strMandMsg     : String;
    strEndEmp      : String;
    strNumEmp      : String;
    strComEmp      : String;
    strCidEmp      : String;
    strCepEmp      : String;
    strEstEmp      : String;
    strDtaPag      : String;
    strAutInc      : String;
    strCodConv     : String;
    strCgcFor      : String;

    strHeader      : String;
    strHeaderLot   : String;
    strTransacao   : String;
    strTraillerLot : String;
    strTrailler    : String;
    strProxNum     : String;

    intProxNum     : Integer;
    intTipIns      : Integer;
    intTipInsFor   : Integer;
    intCodSeq1     : Integer;
    intCodSeq2     : Integer;
    intCodSeq3     : Integer;
    intCodSeqGer   : Integer;
    intTotLot      : Integer;
    fltValPag1     : Double;
    fltValPag2     : Double;
    fltValPag3     : Double;
    fltValPagTot   : Double;
    txtTexto       : TextFile;
    strNovCodEmp   : String;
    blnRemLoc      : Boolean;
    qryRemessa     : TUniQuery;

    intIndLot      : Integer;

    strFilePath : String;

    objPag: TCadPag;
    objRep: TCadPagRepository;
    strGetCodFor: String;
    LDadosRemessa   : TDadosRemessaContasPagar;
    LFolhaPagamentoFuncionario : TFolhaPagamentoSantanderContasPagar;
begin
  inherited;
  LDadosRemessa := TDadosRemessaContasPagar.Create;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);

  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Exit;
  End;

  If fEmptyStr(fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'PROXNUM', '')) Then
  Begin
    fMensagem('', 'A configuração Próximo Num. Arq. Remessa da carteira ' + IntToStr(intCartei) + ' deve ser preenchida!', ['&O K']);
    pSetFocus(btnSair);
    Exit;
  End;

  strCodBco  := '033'; LDadosRemessa.LCodBco := strCodBco;
  strNomBco  := 'BANCO SANTANDER'; LDadosRemessa.LNomBco := strNomBco;
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp); LDadosRemessa.LNomEmp := strNomEmp;
  strCodAgen := LeftStr(fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'CODAGEN', ''), 4); LDadosRemessa.LCodAge := strCodAgen;
  strContCor := fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'NUMCTAC', ''); LDadosRemessa.LConCor := strContCor;
  strDigCnt  := fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'DIGCTAC', ''); LDadosRemessa.LDigCnt := strDigCnt;
  strCodCar  := fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'NUMCART', ''); LDadosRemessa.LCodCar := strCodCar;
  strDigCar  := fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'CODCART', ''); LDadosRemessa.LDigCar := strDigCar;
  strProxNum := fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'PROXNUM', ''); LDadosRemessa.LProNum := strProxNum;
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date); LDadosRemessa.LDtaRem := strDtaRem;
  strHorRem  := FormatDateTime('hh',fTime()) + FormatDateTime('mm',fTime()) + FormatDateTime('ss',fTime()); LDadosRemessa.LHorRem := strHorRem;
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIGCTA033', 'RELOCAL', '') = 'N' ); LDadosRemessa.LRemLoc := blnRemLoc;
  strCodConv := fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'IDENTBC', ''); LDadosRemessa.LCodCon := strCodConv;
  FEnviarCaracterEspecial := (Trim(fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'ENVCESP', '')) <> 'N'); LDadosRemessa.FEnviarCaracterEspecial := FEnviarCaracterEspecial;

  //*************************************************//
  // VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  //
  // CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- //
  // TE PARA A EMPRESA ATUAL(LOCAL)                  //
  //**********************************************ED*//
  strNovCodEmp := VS_strCodEmp;

  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;

  strNomEmp := fRetNomeEmpresa(strNovCodEmp); LDadosRemessa.LNomEmp := strNomEmp;


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
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString; LDadosRemessa.LCgcEmp := strCgcEmp;
      strEndEmp := FieldByName('EMP_ENDERE').AsString; LDadosRemessa.LEndEmp := strEndEmp;
      strNumEmp := FieldByName('EMP_ENDNUM').AsString; LDadosRemessa.LNumEmp := strNumEmp;
      strComEmp := FieldByName('EMP_ENDCMP').AsString; LDadosRemessa.LComEmp := strComEmp;
      strCidEmp := FieldByName('CID_NOMCID').AsString; LDadosRemessa.LCidEmp := strCidEmp;
      strCepEmp := fTiraCaracEspeciais(FieldByName('EMP_C_E_P_').AsString); LDadosRemessa.LCepEmp := strCepEmp;
      strEstEmp := FieldByName('CID_ESTADO').AsString; LDadosRemessa.LEstEmp := strEstEmp;
      Close;
    End;


    If Length(strCgcEmp) > 11 Then
      intTipIns := 2
    Else
      intTipIns := 1; LDadosRemessa.LTipIns := intTipIns;



    qryRemessa := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT                                              ';
    strSQL := strSQL + '  B.*,                                              ';
    strSQL := strSQL + '  F.FOR_NOMFOR,                                     ';
    strSQL := strSQL + '  F.FOR_ENDERE AS ENDERE,                           ';
    strSQL := strSQL + '  F.FOR_BAIRRO AS BAIRRO,                           ';
    strSQL := strSQL + '  F.FOR_C_E_P_ AS C_E_P_,                           ';
    strSQL := strSQL + '  F.FOR_CGCCPF AS CGCCPF,                           ';
    strSQL := strSQL + '  F.FOR_C_G_C_ AS NUMINS,                           ';
    strSQL := strSQL + '  D.BCF_CAMCEN AS CAMCEN,                           ';
    strSQL := strSQL + '  D.BCF_CODBCO AS CODBCO,                           ';
    strSQL := strSQL + '  D.BCF_NUMAGE AS CODAGE,                           ';
    strSQL := strSQL + '  D.BCF_DIGAGE AS DIGAGE,                           ';
    strSQL := strSQL + '  D.BCF_NUMCTA AS NUMCTA,                           ';
    strSQL := strSQL + '  D.BCF_DIGCTA AS DIGCTA,                           ';
    strSQL := strSQL + '  D.BCF_DIGVER AS DIGVER,                           ';
    strSQL := strSQL + '  D.BCF_COMPDES AS COMPDES,                         ';
    strSQL := strSQL + '  C.CID_NOMCID AS CIDADE,                           ';
    strSQL := strSQL + '  C.CID_ESTADO AS ESTADO,                           ';
    strSQL := strSQL + '  B.PGI_FORPGT AS FORMAPAGTO,                       ';
    strSQL := strSQL + '  P.CTP_NUMDOC AS NUMDOCUMENTO,                     ';
    strSQL := strSQL + '  IF(PGI_CODBAR = "", PGI_CODBCO,                   ';
    strSQL := strSQL + '                     LEFT(PGI_CODBAR, 3)) AS CODBAN,';
    strSQL := strSQL + '  PAG_CODFUN AS CODFUN,                             ';
    strSQL := strSQL + '  CTA_DESCTA AS DESCTA,                             ';
    strSQL := strSQL + '  FUN_FUNCAO AS FUNCAO,                             ';
    strSQL := strSQL + '  SUM(IF(VER_DEBCRE = "C",PAG_VALLAN,0)) TOTCRE,    ';
    strSQL := strSQL + '  SUM(IF(VER_DEBCRE = "D",PAG_VALLAN*(-1), 0)) TOTDEB, ';
    strSQL := strSQL + '  SUM(IF(VER_SALBAS = "S",PAG_VALLAN,0)) SALBAS,    ';
    strSQL := strSQL + '  A.PAG_MESBAS                                      ';
    strSQL := strSQL + 'FROM                                                ';
    strSQL := strSQL + '  CADPGI B                                          ';
    strSQL := strSQL + '  LEFT JOIN CADFOR F ON FOR_CODFOR = PGI_CODFOR     ';
    strSQL := strSQL + '  LEFT JOIN CADPAG P ON P.AUTOINCREM = PGI_AUTOIN   ';
    strSQL := strSQL + '  LEFT JOIN BCOFOR D ON D.AUTOINCREM = P.CTP_BCOFOR ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID ';
    strSQL := strSQL + '  LEFT JOIN CADCTA G ON G.CTA_CODCTA = P.CTP_CODCTA ';
    strSQL := strSQL + '  LEFT JOIN CTRPAG A ON A.PAG_AUTCTP = B.PGI_AUTOIN ';
    strSQL := strSQL + '  LEFT JOIN CADFUN E ON E.FUN_CODFUN = A.PAG_CODFUN ';
    strSQL := strSQL + '  LEFT JOIN CADVER V ON V.VER_CODVER = A.PAG_CODVER ';
    strSQL := strSQL + 'WHERE                                               ';
    strSQL := strSQL + '  PGI_CODBCO = :CODBCO                              ';
    strSQL := strSQL + 'GROUP BY B.PGI_AUTOIN                               ';

    qryRemessa.Close;
    qryRemessa.SQL.Clear;
    qryRemessa.SQL.Add(strSQL);
    qryRemessa.ParamByName('CODBCO').AsString := strCodBco;
    qryRemessa.Open;

    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {******************************}
      {* HEADER DO ARQUIVO => Reg 0 *}
      {***************************AF*}
      strHeader := '';
      strHeader := fPadR   ('033'              , 003)      + //001 - 003
                   fPadR   ('0000'             , 004)      + //004 - 007
                   fStrZero('0'                , 001)      + //008 - 008
                   fPadL   (' '                , 009)      + //009 - 017
                   fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                   fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                   fPadR   (strCodConv         , 020)      + //033 - 052
                   fPadL   (strCodAgen         , 005, '0') + //053 - 057
                   fPadR   (' '                , 001)      + //058 - 058
                   fPadL   (strContCor         , 012, '0') + //059 - 070
                   fPadR   (strDigCnt          , 001)      + //071 - 071
                   fPadL   (' '                , 001, '0') + //072 - 072
                   fPadR   (strNomEmp          , 030, ' ') + //073 - 102
                   fPadR   (strNomBco          , 030, ' ') + //103 - 132
                   fPadR   (' '                , 010)      + //133 - 142
                   fPadR   ('1'                , 001)      + //143 - 143
                   fPadR   (strDtaRem          , 008)      + //144 - 151
                   fPadR   (strHorRem          , 006)      + //152 - 157
                   fStrZero(strProxNum         , 006)      + //158 - 163
                   fPadR   ('060'              , 003)      + //164 - 166
                   fStrZero('0'                , 005)      + //167 - 171
                   fPadR   (' '                , 059)      + //172 - 230
                   fPadL   (' '                , 010)      ; //231 - 240


      {*******************************}
      {* ESCREVE O HEADER DO ARQUIVO *}
      {****************************AF*}
      Writeln(txtTexto,RetornaTextoFormatado(strHeader));


      LDadosRemessa.LQryRemessa := qryRemessa;
      LFolhaPagamentoFuncionario := TFolhaPagamentoSantanderContasPagar.Create(LDadosRemessa);

      If Not LFolhaPagamentoFuncionario.GerarRemessaFolhaDePagamentoFuncionario(txtTexto) Then
      Begin
        While FileExists(strFilePath) do
        Begin
          DeleteFile(strFilePath);
        End;
        Exit;
      End;

      intTotLot := LFolhaPagamentoFuncionario.GetTotalDeLotes;

      qryRemessa.Filtered := False;
      qryRemessa.Filter   := ' CODBAN = ' + QuotedStr('033') +
                             ' AND ((PGI_Q_GUIA = "") OR (PGI_Q_GUIA IS NULL)) '+
                             ' AND PGI_TIPPAG = "" AND FORMAPAGTO <> ' + QuotedStr('DEP')  + 'AND CODFUN IS NULL';;

      qryRemessa.Filtered := True;

      intIndLot  := LFolhaPagamentoFuncionario.GetIdentificacaoLote;
      intCodSeq1 := 0;

      If Not qryRemessa.IsEmpty Then
      Begin
        Inc(intTotLot);

        {***********************************************************}
        {* HEADER DO LOTE (TÍTULOS DO SANTANDER) => REG 1          *}
        {********************************************************AF*}
        strHeaderLot := '';
        strHeaderLot := fPadR   ('033'              , 003)      + //001 - 003
                        fPadR   (fStrZero(intIndLot,4), 004)    + //004 - 007
                        fPadR   ('1'                , 001)      + //008 - 008
                        fPadL   ('C'                , 001)      + //009 - 009
                        fPadR   ('20'               , 002)      + //010 - 011
                        fPadR   ('30'               , 002)      + //012 - 013
                        fPadR   ('030'              , 003)      + //014 - 016
                        fPadL   (' '                , 001)      + //017 - 017
                        fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                        fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                        fPadR   (strCodConv         , 020)      + //033 - 052
                        fPadL   (strCodAgen         , 005, '0') + //053 - 057
                        fPadR   (' '                , 001)      + //058 - 058
                        fPadL   (strContCor         , 012, '0') + //059 - 070
                        fPadR   (strDigCnt          , 001)      + //071 - 071
                        fPadL   (' '                , 001, '0') + //072 - 072
                        fPadR   (strNomEmp          , 030, ' ') + //073 - 102
                        fPadL   (' '                , 040)      + //103 - 142
                        fPadR   (strEndEmp          , 030, ' ') + //143 - 172
                        fPadL   (strNumEmp          , 005, '0') + //173 - 177
                        fPadR   (strComEmp          , 015, ' ') + //178 - 192
                        fPadR   (strCidEmp          , 020, ' ') + //193 - 212
                        fPadL   (strCepEmp          , 008, '0') + //213 - 220
                        fPadR   (strEstEmp          , 002, ' ') + //221 - 222
                        fPadR   (' '                , 008)      + //223 - 230
                        fPadL   (' '                , 010);       //231 - 240

        {****************************}
        {* ESCREVE O HEADER DO LOTE *}
        {*************************AF*}
        Writeln(txtTexto,RetornaTextoFormatado(strHeaderLot));

        {***********************************************************************}
        {* REGISTRO DE DETALHE (TÍTULOS DO SANTANDER) => REG = 3 => SEGMENTO J *}
        {********************************************************************AF*}
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

            strDtaEmi := FormatDateTime('dd',FieldByName('PGI_DTACAD').AsDateTime) +
                         FormatDateTime('mm',FieldByName('PGI_DTACAD').AsDateTime) +
                         FormatDateTime('yyyy',FieldByName('PGI_DTACAD').AsDateTime);

            strDtaPag := FormatDateTime('dd',FieldByName('PGI_DTAPAG').AsDateTime) +
                         FormatDateTime('mm',FieldByName('PGI_DTAPAG').AsDateTime) +
                         FormatDateTime('yyyy',FieldByName('PGI_DTAPAG').AsDateTime);

            strAutInc := FieldByName('PGI_AUTOIN').AsString;

            fltValPag1 := fltValPag1 + FieldByName('PGI_VALPAG').AsFloat;

            {********************************************************************}
            {* REGISTRO DE DETALHE (TÍTULOS DO SANTANDER) => REG 3 - SEGMENTO J *}
            {*****************************************************************AF*}

            strTransacao := fPadR      ('033'                                   , 03)      + //001 - 003
                            fPadR      (fStrZero(intIndLot,4)                   , 04)      + //004 - 007
                            fPadR      ('3'                                     , 01)      + //008 - 008
                            fPadL      (IntToStr(intCodSeq1)                    , 05, '0') + //009 - 013
                            fPadR      ('J'                                     , 01)      + //014 - 014
                            fStrZero   ('0'                                     , 03)      + //015 - 017
                            fPadL      (FieldByName('PGI_CODBAR').AsString      , 44, '0') + //018 - 061
                            fPadR      (FieldByName('FOR_NOMFOR').AsString      , 30, ' ') + //062 - 091
                            fPadR      (strDtaVen                               , 08)      + //092 - 099
                            fValNumForm(FieldByName('PGI_VALDUP').AsFloat       , 15)      + //100 - 114
                            fValNumForm(FieldByName('PGI_VALDES').AsFloat       , 15)      + //115 - 129
                            fValNumForm(FieldByName('PGI_VALJUR').AsFloat       , 15)      + //130 - 144
                            fPadR      (strDtaPag                               , 08)      + //145 - 152
                            fValNumForm(FieldByName('PGI_VALPAG').AsFloat       , 15)      + //153 - 167
                            fStrZero   ('0'                                     , 15)      + //168 - 182
                            fPadL      (strAutInc                               , 20, '0') + //183 - 202
                            fPadL      (' '                                     , 20)      + //203 - 222
                            fPadL      ('09'                                    , 02)      + //223 - 224
                            fPadL      (' '                                     , 06)      + //225 - 230
                            fPadL      (' '                                     , 10)      ; //231 - 240

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************AF*}
            Writeln(txtTexto,RetornaTextoFormatado(strTransacao));

            {**************************************************************************}
            {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG 3 - SEGMENTO J52 *}
            {***********************************************************************KP*}

            If Length(FieldByName('NUMINS').AsString) > 11 Then
            begin
              intTipInsFor := 2;
              strCgcFor    := '0' + fPadR(FieldByName('NUMINS').AsString, 14, '0');
            end
            Else
            begin
              intTipInsFor := 1;
              strCgcFor    := '0' + fPadR(FieldByName('NUMINS').AsString, 14, ' ');
            end;

            Inc(intCodSeq1);
            strTransacao := fPadR      ('033'                                    , 03)      + //001 - 003
                            fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007
                            fPadR      ('3'                                      , 01)      + //008 - 008
                            fPadL      (IntToStr(intCodSeq1)                     , 05, '0') + //009 - 013
                            fPadR      ('J'                                      , 01)      + //014 - 014
                            fPadR      (' '                                      , 01)      + //015 - 015
                            fStrZero   ('0'                                      , 02)      + //016 - 017
                            fPadR      ('52'                                     , 02)      + //018 - 019
                            fPadR      (IntToStr(intTipIns)                      , 01)      + //020 - 020
                            fPadL      ('0'+strCgcEmp                            , 15, '0') + //021 - 035
                            fPadR      (strNomEmp                                , 40, ' ') + //036 - 075
                            fPadR      (IntToStr(intTipInsFor)                   , 01)      + //076 - 076
                            fPadL      (strCgcFor                                , 15, '0') + //077 - 091
                            fPadR      (FieldByName('FOR_NOMFOR').AsString       , 40, ' ') + //092 - 131
                            fStrZero   (IntToStr(intTipIns)                      , 01)      + //132 - 132
                            fPadL      ('0'+strCgcEmp                            , 15, '0') + //133 - 147
                            fPadR      (strNomEmp                                , 40)      + //148 - 187
                            fPadL      (' '                                      , 53);       //188 - 240

            {**************************************************}
            {* ESCREVE O REGISTRO DETALHE DA TRANSACAO NO TXT *}
            {***********************************************AJ*}
            Writeln(txtTexto,RetornaTextoFormatado(strTransacao));

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

        {******************************************************}
        {* TRAILLER DO LOTE (TÍTULOS DO SANTANDER) => Reg 5   *}
        {***************************************************AF*}
        Inc(intCodSeq1);
        Inc(intCodSeq1);
        strTraillerLot := '';
        strTraillerLot := fPadR      ('033'               , 003)       + //001 - 003
                          fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                          fPadR      ('5'                 , 001)       + //008 - 008
                          fPadR      (' '                 , 009)       + //009 - 017
                          fPadL      (IntToStr(intCodSeq1), 006, '0')  + //018 - 023
                          fValNumForm(fltValPag1          , 018)       + //024 - 041
                          fStrZero   ('0'                 , 018)       + //042 - 059
                          fPadL      ('0'                 , 006, '0')  + //060 - 065
                          fPadR      (' '                 , 165)       + //066 - 230
                          fPadR      (' '                 , 010);        //231 - 240

        {*************************************}
        {* ESCREVE O TRAILLER DO LOTE NO TXT *}
        {**********************************AF*}
        Writeln(txtTexto,RetornaTextoFormatado(strTraillerLot));
        Inc(intIndLot);
      End;

      qryRemessa.Filtered := False;
      qryRemessa.Filter   := ' CODBAN <> ' + QuotedStr('033') +
                             ' AND ((PGI_Q_GUIA = "") OR (PGI_Q_GUIA IS NULL)) '+
                             ' AND PGI_TIPPAG = "" AND FORMAPAGTO <> ' + QuotedStr('DEP') + 'AND CODFUN IS NULL';
      qryRemessa.Filtered := True;

      intCodSeq2   := 0;

      If Not qryRemessa.IsEmpty Then
      Begin
        Inc(intTotLot);

        If intIndLot = 0 Then
          intIndLot := 1;

        {********************************************************************}
        {* HEADER DO LOTE (TÍTULOS DE OUTROS BANCOS) => REG 1 => SEGMENTO J *}
        {*****************************************************************JU*}
        strHeaderLot := '';
        strHeaderLot := fPadR   ('033'              , 003)      + //001 - 003
                        fPadR   (fStrZero(intIndLot,4), 004)    + //004 - 007
                        fPadR   ('1'                , 001)      + //008 - 008
                        fPadL   ('C'                , 001)      + //009 - 009
                        fPadR   ('20'               , 002)      + //010 - 011
                        fPadR   ('31'               , 002)      + //012 - 013
                        fPadR   ('030'              , 003)      + //014 - 016
                        fPadL   (' '                , 001)      + //017 - 017
                        fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                        fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                        fPadR   (strCodConv         , 020)      + //033 - 052
                        fPadL   (strCodAgen         , 005, '0') + //053 - 057
                        fPadR   (' '                , 001)      + //058 - 058
                        fPadL   (strContCor         , 012, '0') + //059 - 070
                        fPadR   (strDigCnt          , 001)      + //071 - 071
                        fPadL   (' '                , 001, '0') + //072 - 072
                        fPadR   (strNomEmp          , 030, ' ') + //073 - 102
                        fPadL   (' '                , 040)      + //103 - 142
                        fPadR   (strEndEmp          , 030, ' ') + //143 - 172
                        fPadL   (strNumEmp          , 005, '0') + //173 - 177
                        fPadR   (strComEmp          , 015, ' ') + //178 - 192
                        fPadR   (strCidEmp          , 020, ' ') + //193 - 212
                        fPadL   (strCepEmp          , 008, '0') + //213 - 220
                        fPadR   (strEstEmp          , 002, ' ') + //221 - 222
                        fPadR   (' '                , 008)      + //223 - 230
                        fPadL   (' '                , 010);       //231 - 240

        {****************************}
        {* ESCREVE O HEADER DO LOTE *}
        {*************************JU*}
        Writeln(txtTexto,RetornaTextoFormatado(strHeaderLot));

        {***************************************************************************}
        {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG = 3 => SEGMENTO J *}
        {************************************************************************JU*}
        With qryRemessa Do
        Begin

          strTransacao := '';
          fltValPag2   := 0;

          While Not Eof Do
          Begin
            Inc(intCodSeq2);

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

            fltValPag2 := fltValPag2 + FieldByName('PGI_VALPAG').AsFloat;

            {************************************************************************}
            {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG 3 - SEGMENTO J *}
            {*********************************************************************JU*}

            strTransacao := fPadR      ('033'                                   , 03)      + //001 - 003
                            fPadR      (fStrZero(intIndLot,4)                   , 04)      + //004 - 007
                            fPadR      ('3'                                     , 01)      + //008 - 008
                            fPadL      (IntToStr(intCodSeq2)                    , 05, '0') + //009 - 013
                            fPadR      ('J'                                     , 01)      + //014 - 014
                            fStrZero   ('0'                                     , 03)      + //015 - 017
                            fPadL      (FieldByName('PGI_CODBAR').AsString      , 44, '0') + //018 - 061
                            fPadR      (FieldByName('FOR_NOMFOR').AsString      , 30, ' ') + //062 - 091
                            fPadR      (strDtaVen                               , 08)      + //092 - 099
                            fValNumForm(FieldByName('PGI_VALDUP').AsFloat       , 15)      + //100 - 114
                            fValNumForm(FieldByName('PGI_VALDES').AsFloat       , 15)      + //115 - 129
                            fValNumForm(FieldByName('PGI_VALJUR').AsFloat       , 15)      + //130 - 144
                            fPadR      (strDtaPag                               , 08)      + //145 - 152
                            fValNumForm(FieldByName('PGI_VALPAG').AsFloat       , 15)      + //153 - 167
                            fStrZero   ('0'                                     , 15)      + //168 - 182
                            fPadL      (strAutInc                               , 20, '0') + //183 - 202
                            fPadL      (' '                                     , 20)      + //203 - 222
                            fPadL      ('09'                                    , 02)      + //223 - 224
                            fPadL      (' '                                     , 06)      + //225 - 230
                            fPadL      (' '                                     , 10)      ; //231 - 240

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************JU*}
            Writeln(txtTexto,RetornaTextoFormatado(strTransacao));

            {**************************************************************************}
            {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG 3 - SEGMENTO J52 *}
            {***********************************************************************KP*}

            If Length(FieldByName('NUMINS').AsString) > 11 Then
            begin
              intTipInsFor := 2;
              strCgcFor    := '0' + fPadR(FieldByName('NUMINS').AsString, 14, '0');
            end
            Else
            begin
              intTipInsFor := 1;
              strCgcFor    := '0' + fPadR(FieldByName('NUMINS').AsString, 14, ' ');
            end;

            Inc(intCodSeq2);
            strTransacao := fPadR      ('033'                                    , 03)      + //001 - 003
                            fPadR      (fStrZero(intIndLot,4)                    , 04)      + //004 - 007
                            fPadR      ('3'                                      , 01)      + //008 - 008
                            fPadL      (IntToStr(intCodSeq2)                     , 05, '0') + //009 - 013
                            fPadR      ('J'                                      , 01)      + //014 - 014
                            fPadR      (' '                                      , 01)      + //015 - 015
                            fStrZero   ('0'                                      , 02)      + //016 - 017
                            fPadR      ('52'                                     , 02)      + //018 - 019
                            fPadR      (IntToStr(intTipIns)                      , 01)      + //020 - 020
                            fPadL      ('0'+strCgcEmp                            , 15, '0') + //021 - 035
                            fPadR      (strNomEmp                                , 40, ' ') + //036 - 075
                            fPadR      (IntToStr(intTipInsFor)                   , 01)      + //076 - 076
                            fPadL      (strCgcFor                                , 15, '0') + //077 - 091
                            fPadR      (FieldByName('FOR_NOMFOR').AsString       , 40, ' ') + //092 - 131
                            fStrZero   (IntToStr(intTipIns)                      , 01)      + //132 - 132
                            fPadL      ('0'+strCgcEmp                            , 15, '0') + //133 - 147
                            fPadR      (strNomEmp                                , 40)      + //148 - 187
                            fPadL      (' '                                      , 53);       //188 - 240

            {**************************************************}
            {* ESCREVE O REGISTRO DETALHE DA TRANSACAO NO TXT *}
            {***********************************************AJ*}
            Writeln(txtTexto,RetornaTextoFormatado(strTransacao));

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

        {********************************************************}
        {* TRAILLER DO LOTE (TÍTULOS DE OUTROS BANCOS) => Reg 5 *}
        {*****************************************************JU*}
        Inc(intCodSeq2);
        Inc(intCodSeq2);
        strTraillerLot := '';
        strTraillerLot := fPadR      ('033'               , 003)       + //001 - 003
                          fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                          fPadR      ('5'                 , 001)       + //008 - 008
                          fPadR      (' '                 , 009)       + //009 - 017
                          fPadL      (IntToStr(intCodSeq2), 006, '0')  + //018 - 023
                          fValNumForm(fltValPag2          , 018)       + //024 - 041
                          fStrZero   ('0'                 , 018)       + //042 - 059
                          fPadL      ('0'                 , 006, '0')  + //060 - 065
                          fPadR      (' '                 , 165)       + //066 - 230
                          fPadR      (' '                 , 010);        //231 - 240

        {*************************************}
        {* ESCREVE O TRAILLER DO LOTE NO TXT *}
        {**********************************JU*}
        Writeln(txtTexto,RetornaTextoFormatado(strTraillerLot));
        Inc(intIndLot);
      End;


        {********}
        {* GNRE *}
        {********}
      qryRemessa.Filtered := False;
      qryRemessa.Filter   :=  ' CODBAN <> ' + QuotedStr('033') +
                              ' AND (PGI_TIPPAG <> "" AND PGI_TIPPAG <> 3) '  +
                              ' AND (FORMAPAGTO <> ' + QuotedStr('DEP') +
                              ' OR ((PGI_Q_GUIA <> '''') OR (PGI_Q_GUIA IS NOT NULL))) '  + 'AND CODFUN IS NULL';;
      qryRemessa.Filtered := True;

      intCodSeq3   := 0;

      If Not qryRemessa.IsEmpty Then
      Begin
        Inc(intTotLot);

        If intIndLot = 0 Then
          intIndLot := 1;

        {********************************************************************************************************}
        {* HEADER DO LOTE (Pagamento de Concessionárias e tributos com código de barras) => REG 1 => SEGMENTO O *}
        {*****************************************************************************************************MT*}
        strHeaderLot := '';
        strHeaderLot := fPadR   ('033'              , 003)      + //001 - 003
                        fPadR   (fStrZero(intIndLot,4), 004)    + //004 - 007
                        fPadR   ('1'                , 001)      + //008 - 008
                        fPadL   ('C'                , 001)      + //009 - 009
                        fPadR   ('22'               , 002)      + //010 - 011
                        fPadR   ('11'               , 002)      + //012 - 013
                        fPadR   ('031'              , 003)      + //014 - 016
                        fPadL   (' '                , 001)      + //017 - 017
                        fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                        fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                        fPadR   (strCodConv         , 020)      + //033 - 052
                        fPadL   (strCodAgen         , 005, '0') + //053 - 057
                        fPadR   (' '                , 001)      + //058 - 058
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
                        fPadR   (' '                , 002, ' ') + //223 - 224
                        fPadR   (' '                , 008, ' ') + //225 - 230
                        fPadR   (' '                , 008, ' ');  //231 - 240

        {****************************}
        {* ESCREVE O HEADER DO LOTE *}
        {*************************JU*}
        Writeln(txtTexto,RetornaTextoFormatado(strHeaderLot));

        {***************************************************************************}
        {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG = 3 => SEGMENTO O *}
        {************************************************************************MT*}
        With qryRemessa Do
        Begin

          strTransacao := '';
          fltValPag3   := 0;

          While Not Eof Do
          Begin
            Inc(intCodSeq3);

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

            fltValPag3 := fltValPag3 + FieldByName('PGI_VALPAG').AsFloat;

            {************************************************************************}
            {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG 3 - SEGMENTO O *}
            {*********************************************************************MT*}


            strTransacao := fPadR      ('033'                                                       , 03)      + //001 - 003 CÓDIGO DO BANCO NA COMPENSAÇÃO
                            fPadR      (fStrZero(intIndLot,4)                                       , 04)      + //004 - 007 LOTE DE SERVIÇO
                            fPadR      ('3'                                                         , 01)      + //008 - 008 REGISTRO DETALHE DE LOTE
                            fPadL      (IntToStr(intCodSeq3)                                        , 05, '0') + //009 - 013 Nº SEQUENCIAL REGISTRO NO LOTE
                            fPadR      ('O'                                                         , 01)      + //014 - 014 CÓDIGO SEGMENTO REG. DETALHE
                            fStrZero   ('0'                                                         , 03)      + //015 - 017 TIPO DE MOVIMENTO / Código da Instrução para Movimento
                            fPadL      (FieldByName('PGI_CODBAR').AsString                          , 44, '0') + //018 - 061 Código de Barras
                            fPadR      (fTiraCaracEspeciais(FieldByName('FOR_NOMFOR').AsString)     , 30, ' ') + //062 - 091
                            fPadR      (strDtaVen                                                   , 08)      + //092 - 099
                            fPadR      (strDtaPag                                                   , 08)      + //100 - 107
                            fValNumForm(FieldByName('PGI_VALDUP').AsFloat                           , 15)      + //108 - 122
                            fPadL      (strAutInc                                                   , 20, ' ') + //123 - 142
                            fPadL      (' '                                                         , 20, ' ') + //143 - 162
                            fPadL      (' '                                                         , 68)      + //163 - 230
                            fPadL      (' '                                                         , 10, ' ');   //231 - 240


            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************JU*}
            Writeln(txtTexto,RetornaTextoFormatado(strTransacao));

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


        {********************************************************}
        {* TRAILLER DO LOTE (TÍTULOS DE OUTROS BANCOS) => Reg 5 *}
        {*****************************************************JU*}
        Inc(intCodSeq3);
        Inc(intCodSeq3);
        strTraillerLot := '';

        strTraillerLot := fPadR      ('033'                , 003)       + //001 - 003
                          fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                          fPadR      ('5'                  , 001)       + //008 - 008
                          fPadR      (' '                  , 009)       + //009 - 017
                          fPadL      (IntToStr(intCodSeq3) , 006, '0')  + //018 - 023
                          fValNumForm(fltValPag3           , 018)       + //024 - 041
                          fStrZero   ('0'                  , 018)       + //042 - 059
                          fStrZero   ('0'                  , 006)       + //060 - 065
                          fPadR      (' '                  , 175);        //066 - 240


        {*************************************}
        {* ESCREVE O TRAILLER DO LOTE NO TXT *}
        {**********************************JU*}
        Writeln(txtTexto,RetornaTextoFormatado(strTraillerLot));
      End;


      {********************************}
      {* TRAILLER DO ARQUIVO => Reg 9 *}
      {*****************************AF*}
      intCodSeqGer:= intCodSeq1 + intCodSeq2 + intCodSeq3 + LFolhaPagamentoFuncionario.GetTotalTransacao + 2;
      strTrailler := '';
      strTrailler := fPadR   ('033'                 , 003)      + //001 - 003
                     fPadR   ('9999'                , 004)      + //004 - 007
                     fPadR   ('9'                   , 001)      + //008 - 008
                     fPadR   (' '                   , 009)      + //009 - 017
                     fPadL   (IntToStr(intTotLot)   , 006, '0') + //018 - 023
                     fPadL   (IntToStr(intCodSeqGer), 006, '0') + //024 - 029
                     fPadR   (' '                   , 211);       //030 - 240

      {****************************************}
      {* ESCREVE O TRAILLER DO ARQUIVO NO TXT *}
      {*************************************AF*}
      Writeln(txtTexto,RetornaTextoFormatado(strTrailler));

      CloseFile(txtTexto);

{      fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
                   'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);
}
      intProxNum := StrToInt(strProxNum);

      Inc(intProxNum);

      fGetBancoConfig(1, 'CONFIGCTA033-' + IntToStr(intCartei), 'PROXNUM', IntToStr(intProxNum));

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM CADPGI          ';
      strSQL := strSQL + ' WHERE PGI_CODBCO = :CODBCO ';

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
      If Assigned(LDadosRemessa) Then FreeAndNil(LDadosRemessa);
      If Assigned(LFolhaPagamentoFuncionario) Then FreeAndNil(LFolhaPagamentoFuncionario);

      If fCommit then
		    fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
				          'Arquivo Gerado: ' + fraPathRemessa.edtDirectory.text + edtNomArquivo.Text, ['&O K']);


    End
    Else
    Begin
      fRollBack;
      If Assigned(LDadosRemessa) Then FreeAndNil(LDadosRemessa);
      If Assigned(LFolhaPagamentoFuncionario) Then FreeAndNil(LFolhaPagamentoFuncionario);
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

		FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);
		//FreeAndNil(stlMensagem);

	  Except
		On E: Exception Do
		Begin

		  fRollBack;

      If Assigned(LDadosRemessa) Then FreeAndNil(LDadosRemessa);
      If Assigned(LFolhaPagamentoFuncionario) Then FreeAndNil(LFolhaPagamentoFuncionario);

		  While FileExists(strFilePath) do
		  Begin
			  DeleteFile(strFilePath);
		  End;

		  FreeAndNil(qryRemessa);
		  FreeAndNil(qryConsultaGen);
		  pMensagensErro(E.Message,  '[untExpArqRemSantanderCta.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');

		End;
  End;

end;

function TfrmExpArqRemSantanderCta.fRetEmpresa: String;
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


function TfrmExpArqRemSantanderCta.RetornaTextoFormatado(
  ATexto: String): String;
begin
  Result := ATexto;

  If Not FEnviarCaracterEspecial Then
    Result := untFuncAutban.fRetirarCaracteresEspeciais(Result);
end;

end.
