unit untExpArqRemBancoobCta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Buttons, ExtCtrls, EditFocus, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTCadPag, untTCadPagRepository,
  untFrameDirectoryEditFocus;

type
  TfrmExpArqRemBancoobCta = class(TfrmPai)
    pnlFundo: TPanel;
    lblPathRem: TLabel;
    lblNomArq: TLabel;
    edtNomArquivo: TEditFocus;
    btnGerar: TBitBtnLocked;
    fraPathRemessa: TfraDirectoryEditFocus;
    pnlTopo: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    function fSolicitaDataPagamento(var Adata : TDatetime) : boolean;
  private

    qryConsultaGen : TUniQuery;

    function fRetEmpresa: String;
    function fRetornaTipoChavePix(PQueryRemessa : TUniQuery): String;
    { Private declarations }
  public
    { Public declarations }
    intCartei    : Integer;
    strNomForm   : String;
    intTipInsFor : Integer;

  end;

var
  frmExpArqRemBancoobCta: TfrmExpArqRemBancoobCta;

implementation

uses untFuncoes, untfuncoesSimples, DB, untLogCtp, untDigDataPagamento;

{$R *.dfm}

procedure TfrmExpArqRemBancoobCta.FormShow(Sender: TObject);
begin
  inherited;
  
  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIGCTA756-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(fGetBancoProxNum('CONFIGCTA756-' + IntToStr(intCartei)), 06) +
                         '.TXT';
  pSetFocus(fraPathRemessa);

end;

function TfrmExpArqRemBancoobCta.fSolicitaDataPagamento(var Adata : TDatetime) : boolean;
Begin
   Result := True;
   If (fGetBancoConfig(0, 'CONFIGCTA756-' + IntToStr(intCartei), 'SOLIDTA', 'N') = 'S') Then
   Begin
      Try
        pCriarFormularios(TfrmDigDataPagamento, frmDigDataPagamento);
        frmDigDataPagamento.ShowModal;
        If frmDigDataPagamento.ModalResult = mrOk Then
        Begin
          If frmDigDataPagamento.rgpTipoData.ItemIndex = 1 Then
            Adata  := frmDigDataPagamento.dtmData.Date;

          Result := True;
        End
        Else
          Result := False;
      Finally
        FreeAndNil(frmDigDataPagamento);
      End;
   End;
End;

procedure TfrmExpArqRemBancoobCta.btnGerarClick(Sender: TObject);
var
    strSQL     : String;
    strCodAgen : String;
    strContCor : String;
    strDigCnt  : String;
    strCodCar  : String;
    strDigCar  : String;
    strCodBco  : String;
    strNomBco  : String;
    strNomEmp  : String;
    strCodCed  : String;
    strDigCed  : String;
    strNomCed  : String;
    strNumCon  : String;
    strConCli  : String;
    strDiasProt: String;
    strInstProt: String;
    strDiasCred: String;
    strProAce  : String;
    strResp    : String;
    strCodPor  : String;
    strCtaBai  : String;
    strInstru1 : String;
    strInstru2 : String;
    strObs001  : String;
    strObs002  : String;
    strComand  : String;
    strModali  : String;
    strNosNum  : String;
    strSeuNum  : String;
    strParcel  : String;

    strDtaRem,
    strTraillerLot,
    strDtaPag   : String;
    strHorRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strDtaJur   : String;
    strEndEmp   : String;
    strNumEmp   : String;
    strComEmp   : String;
    strCidEmp   : String;
    strCepEmp   : String;
    strEstEmp   : String;


    strAgenCob : String;
    strCodRem  : String;

    strHeader   : String;
    strHeLote   : String;
    strTransacao: String;
    strTrailler : String;
    strTrLote   : String;

    strCgcEmp   : String;
    strCpfCgc   : String;

    strKeyDup   : String;
    strHeaderLot,
    strAutInc,
    strDigAgen,
    strCgcCli   : String;

    intCodSeq,
    intTotLot,
    intIndLot,
    intCodSq1,
    intCodSeq1,
    intCodSeq2,
    intCodSeqGer,
    intTipIns   : Integer;
    intSeqCrr   : Integer;

    fltValAtr   : Double;
    fltTotRem,
    fltValPag1,
    fltValPag2  : Double;
    txtTexto    : TextFile;
    strNovCodEmp,
    strCodConv  : String;
    blnRemLoc   : Boolean;
    qryRemessa  : TUniQuery;
    strPerMul   : String;
    fltPerMul   : Double;
    dtaDtaJur   : TDateTime;
    blnUsaCrr   : Boolean;

    strPerJur   : String;
    strDatMul   : String;
    dtaDtaMul   : TDateTime;
    fltPerJur   : Double;
    strDtaMul   : String;
    strDiaMora  : string;

    strCodBcoResp,
    strNossoNumResp: String;

    strFilePath : String;

    objPag: TCadPag;
    objRep: TCadPagRepository;
    strGetCodFor: String;
    dtDtaPag: TDateTime;
    LPossuiRegistroPix : Boolean;
    LAvisoTed : String;
    LValorPago: Double;
    LNomeFornecedor : String;
    LInscricaoDoFavorecido : String;
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

  strCodBco  := '756';
  strNomBco  := 'Bancoob240';
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);
  strCodConv := fGetBancoConfig(0, 'CONFIGCTA756-' + IntToStr(intCartei), 'CODCONV', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIGCTA756-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, 'CONFIGCTA756-' + IntToStr(intCartei), 'DIGAGEN', '');
  strContCor := fGetBancoConfig(0, 'CONFIGCTA756-' + IntToStr(intCartei), 'NUMCTAC', '');
  strDigCnt  := fGetBancoConfig(0, 'CONFIGCTA756-' + IntToStr(intCartei), 'DIGCTAC', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIGCTA756-' + IntToStr(intCartei), 'NUMCART', '');
  strDigCar  := fGetBancoConfig(0, 'CONFIGCTA756-' + IntToStr(intCartei), 'CODCART', '');
  strCodRem  := fStrZero(fAtuCodSeq('CONFIGCTA756-' + IntToStr(intCartei), 'PROXNUM'), 6);
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);
  strHorRem  := FormatDateTime('hh', fTime()) + FormatDateTime('mm', fTime()) + FormatDateTime('ss', fTime());
  blnRemLoc  := Not( fGetBancoConfig(0, 'CONFIGCTA756', 'RELOCAL', '') = 'N' );
  LAvisoTed  := fGetBancoConfig(0, 'CONFIGCTA756-' + IntToStr(intCartei), 'AVISOFA', '');
  if fEmptyStr(LAvisoTed) then
    LAvisoTed := '0';

  intTotLot  := 0;
  dtDtaPag   := 0;

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
      strEndEmp := FieldByName('EMP_ENDERE').AsString;
      strNumEmp := FieldByName('EMP_ENDNUM').AsString;
      strComEmp := FieldByName('EMP_ENDCMP').AsString;
      strCidEmp := FieldByName('CID_NOMCID').AsString;
      strCepEmp := fTiraCaracEspeciais(FieldByName('EMP_C_E_P_').AsString);
      strEstEmp := FieldByName('CID_ESTADO').AsString;
      Close;
    End;

{  Finally
    FreeAndNil(qryConsultaGen);
  End;}

  If Length(strCgcEmp) > 11 Then
    intTipIns := 2
  Else
    intTipIns := 1;

//  Try

    qryRemessa := fCriaQuery(Self);
    qryRemessa.UniDirectional := False;

    strSQL := '';
    strSQL := strSQL + 'SELECT                     ';
    strSQL := strSQL + '  B.*,                     ';
    strSQL := strSQL + '  F.FOR_NOMFOR,            ';
    strSQL := strSQL + '  F.FOR_ENDERE AS ENDERE,  ';
    strSQL := strSQL + '  F.FOR_BAIRRO AS BAIRRO,  ';
    strSQL := strSQL + '  F.FOR_C_E_P_ AS C_E_P_,  ';
    strSQL := strSQL + '  F.FOR_CGCCPF AS CGCCPF,  ';
    strSQL := strSQL + '  F.FOR_C_G_C_ AS CODCGC,  ';
    strSQL := strSQL + '  C.CID_NOMCID AS CIDADE,  ';
    strSQL := strSQL + '  C.CID_ESTADO AS ESTADO,  ';
    strSQL := strSQL + '  IFNULL(B.PGI_Q_GUIA, "") AS CODIGO_GUIA,          ';
    strSQL := strSQL + '  B.PGI_FORPGT AS FORMAPAGTO,                       ';
    strSQL := strSQL + '  P.CTP_FORPIX AS AUTOINCREM_FORPIX,                ';
    strSQL := strSQL + '  X.PIX_TIPCHV AS TIPCHV_PIX,                        ';
    strSQL := strSQL + '  X.PIX_CHAVE_ AS CHAVE_PIX,                        ';
    strSQL := strSQL + '  IFNULL(PAG_CODFUN,"") AS CODFUN,                  ';
    strSQL := strSQL + '  IFNULL(BCF_COMPDES,"CC") AS COMPDES,              ';
    strSQL := strSQL + '  IF(B.PGI_FORPGT = "DEP",PGI_CODBCO,LEFT(PGI_CODBAR, 3)) AS CODBAN ';
    strSQL := strSQL + 'FROM                       ';
    strSQL := strSQL + '  CADPGI B                                          ';
    strSQL := strSQL + '  LEFT JOIN CADFOR F ON FOR_CODFOR = PGI_CODFOR     ';
    strSQL := strSQL + '  LEFT JOIN CADPAG P ON P.AUTOINCREM = PGI_AUTOIN   ';
    strSQL := strSQL + '  LEFT JOIN BCOFOR D ON D.AUTOINCREM = P.CTP_BCOFOR ';
    strSQL := strSQL + '  LEFT JOIN FORPIX X ON X.AUTOINCREM = P.CTP_FORPIX ';
    strSQL := strSQL + '  LEFT JOIN CADCID C ON C.CID_CODCID = F.FOR_CODCID ';
    strSQL := strSQL + '  LEFT JOIN CADCTA G ON G.CTA_CODCTA = P.CTP_CODCTA ';
    strSQL := strSQL + '  LEFT JOIN CTRPAG A ON A.PAG_AUTCTP = B.PGI_AUTOIN ';
    strSQL := strSQL + '  LEFT JOIN CADFUN E ON E.FUN_CODFUN = A.PAG_CODFUN ';
    strSQL := strSQL + '  LEFT JOIN CADFNC N ON N.FNC_CODFNC = E.FUN_FUNATU ';
    strSQL := strSQL + '  LEFT JOIN CADVER V ON V.VER_CODVER = A.PAG_CODVER ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  PGI_CODBCO = :CODBCO AND ';
    strSQL := strSQL + '  PGI_BCOPGG IS NULL ';

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

      If Not fSolicitaDataPagamento(dtDtaPag) Then
         Exit;

      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      {******************************}
      {* HEADER DO ARQUIVO => Reg 0 *}
      {***************************AF*}
      strHeader :=   '';
      strHeader :=   fPadR   ('756'              , 003) + //001 - 003  [01]
                     fPadR   ('0000'             , 004) + //004 - 007  [02]
                     fPadR   ('0'                , 001) + //008 - 008  [03]
                     fPadR   (' '                , 009) + //009 - 017  [04]
                     fPadR   ('2'                , 001) + //018 - 018  [05]
                     fPadR   (strCgcEmp          , 014) + //019 - 032  [06]
                     fStrZero(strCodConv         , 020) + //033 - 052  [07]
                     fStrZero(strCodAgen         , 005) + //053 - 057  [08]
                     fPadR   (strDigAgen         , 001) + //058 - 058  [09]
                     fStrZero(strContCor         , 012) + //059 - 070  [10]
                     fPadR   (strDigCnt          , 001) + //071 - 071  [11]
                     fPadR   (strDigCnt          , 001) + //072 - 072  [12]
                     fPadR   (fTiraCaracEspeciais(strNomEmp)          , 030) + //073 - 102  [13]
                     fPadR   ('SICOOB'           , 030) + //103 - 132  [14]
                     fPadR   (' '                , 010) + //133 - 142  [15]
                     fPadR   ('1'                , 001) + //143 - 143  [16]
                     fPadR   (strDtaRem          , 008) + //144 - 151  [17]
                     fPadR   (strHorRem          , 006) + //152 - 157  [18]
                     fPadR   (strCodRem          , 006) + //158 - 163  [19]
                     fPadR   ('087'              , 003) + //164 - 166  [20]
                     fStrZero('0'                , 005) + //167 - 171  [21]
                     fPadR   (' '                , 069);   //172 - 240  [22 23 24]


      {*******************************}
      {* ESCREVE O HEADER DO ARQUIVO *}
      {****************************AF*}
      Writeln(txtTexto, strHeader);

      intIndLot    := 0;
      intCodSeq1   := 0;

      qryRemessa.Filtered := False;
      qryRemessa.Filter   := 'FORMAPAGTO = "DEP" ' +
                             ' AND CODIGO_GUIA = "" ' +
                             ' AND CODFUN = "" AND AUTOINCREM_FORPIX IS NOT NULL ';
      qryRemessa.Filtered := True;

      LPossuiRegistroPix := Not qryRemessa.IsEmpty;
      If LPossuiRegistroPix Then
      begin
        {*******************************************************************************}
        {* HEADER DO LOTE (Pagamento através de crédito PIX) => REG 1 => SEGMENTO ABC  *}
        {****************************************************************************AJ*}
        Inc(intTotLot);
        Inc(intIndLot);
        strHeaderLot := '';
        strHeaderLot := fPadR(Copy(strCodBco,1,3)                 , 003)      + //001 - 003 - CÓD. DO BANCO
                        fPadR(fStrZero(intIndLot,4)               , 004)      + //004 - 007 - LOTE DO SERVIÇO
                        fPadR('1'                                 , 001)      + //008 - 008 - TIPO DE REGISTRO
                        fPadL('C'                                 , 001)      + //009 - 009 - TIPO DE OPERAÇÃO
                        fPadR('20'                                , 002)      + //010 - 011 - TIPO DO SERVIÇO
                        fPadR('45'                                , 002)      + //012 - 013 - FORMA DE LANÇAMENTO
                        fPadR('040'                               , 003)      + //014 - 016 - Nº DA VERSÃO DO LAYOUT DO LOTE
                        fPadL(' '                                 , 001)      + //017 - 017 - USO EXCLUSIVO FEBRABAN
                        fPadR(IntToStr(intTipIns)                 , 001)      + //018 - 018 - TIPO DE INSCRIÇÃO DA EMPRESA
                        fPadL(strCgcEmp                           , 014, '0') + //019 - 032 - Nº DE INSCRIÇÃO DA EMPRESA
                        fPadR(strCodConv                          , 020)      + //033 - 052 - CÓD. DO CONVÊNIO NO BANCO
                        fPadL(strCodAgen                          , 005, '0') + //053 - 057 - AG. MANTENEDORA DA CONTA
                        fPadR(strDigAgen                          , 001)      + //058 - 058 - DIG. BERIFICADOR DA AGÊNCIA
                        fPadL(strContCor                          , 012, '0') + //059 - 070 - Nº DA CONTA CORRENTE
                        fPadR(strDigCnt                           , 001)      + //071 - 071 - DIGITO VERIFICADOR DA CONTA
                        fPadL(strDigCnt                           , 001)      + //072 - 072 - DIGITO VERIFICADOR DA AG/CONTA
                        fPadR(fTiraCaracEspeciais(strNomEmp)      , 030, ' ') + //073 - 102 - NOME DA EMPRESA
                        fPadL(' '                                 , 040)      + //103 - 142 - MENSAGEM
                        fPadR(fTiraCaracEspeciais(strEndEmp)      , 030, ' ') + //143 - 172 - NOME DA RUA, AV, PÇA, ETC
                        fPadL(fTiraCaracEspeciais(strNumEmp)      , 005, '0') + //173 - 177 - Nº DO LOCAL
                        fPadR(fTiraCaracEspeciais(strComEmp)      , 015, ' ') + //178 - 192 - CASA, APTO, SALA, ETC
                        fPadR(fTiraCaracEspeciais(strCidEmp)      , 020, ' ') + //193 - 212 - NOME DA CIDADE
                        fPadL(strCepEmp                           , 008, '0') + //213 - 220 - CEP + COMPLEMENTO DO CEP
                        fPadR(strEstEmp                           , 002, ' ') + //221 - 222 - SIGLA DO ESTADO
                        fPadR('01'                                , 002)      + //223 - 224 - INDICATIVO DE FORMA DE PAGAMENTO DO SERVIÇO
                        fPadR(' '                                 , 006)      + //225 - 230 - USO EXCLUSIVO FEBRABAN
                        fPadR(' '                                 , 010,' ');   //231 - 240 - CPDIGO DAS OCORRÊNCIAS P/ RETORNO

        {****************************}
        {* ESCREVE O HEADER DO LOTE *}
        {*************************AJ*}
        Writeln(txtTexto,strHeaderLot);

        {****************************************************}
        {* REGISTRO DE DETALHE => REG = 3 => SEGMENTO A PIX *}
        {*************************************************AJ*}

        strTransacao := '';
        fltValPag1   := 0;

        While Not qryRemessa.Eof Do
        Begin
          Inc(intCodSeq1);

          Application.ProcessMessages;

          strDtaVen := FormatDateTime('ddmmyyyy', qryRemessa.FieldByName('PGI_DTAVEN').AsDateTime);
          strDtaEmi := FormatDateTime('ddmmyyyy', qryRemessa.FieldByName('PGI_DTACAD').AsDateTime);
          strDtaPag := FormatDateTime('ddmmyyyy', qryRemessa.FieldByName('PGI_DTAPAG').AsDateTime);
          LValorPago := qryRemessa.FieldByName('PGI_VALPAG').AsFloat;
          LNomeFornecedor := LeftStr(fTiraCaracEspeciais(qryRemessa.FieldByName('FOR_NOMFOR').AsString), 30);

          strAutInc := qryRemessa.FieldByName('PGI_AUTOIN').AsString;

          fltValPag1 := fltValPag1 + qryRemessa.FieldByName('PGI_VALPAG').AsFloat;

          strTransacao := fPadL   (Copy(strCodBco,1,3)                       , 03, '0') + //001 - 003 - Código do Banco
                          fPadL   (fStrZero(intIndLot,4)                     , 04, '0') + //004 - 007 - Lote de Serviço (Nota G002)
                          fPadL   ('3'                                       , 01, '0') + //008 - 008 - Tipo de Registro
                          fPadL   (IntToStr(intCodSeq1)                      , 05, '0') + //009 - 013 - Número Sequencial do Registro no Lote (Nota G038)
                          fPadR   ('A'                                       , 01, ' ') + //014 - 014 - Código Segmento do Registro Detalhe
                          fStrZero('0'                                       , 01)      + //015 - 015 - Tipo de Movimento 0 = Inclusão / 3 = Exclusão - Nota G060
                          fStrZero('00'                                      , 02)      + //016 - 017 - Código da Instrução para Movimento 00 = inclusão / 33 = Exclusão (Nota G061)
                          fPadR   ('009'                                     , 03, '0') + //018 - 020 - Código Câmara Compensação 018 = TED (STR,CIP) 009 = Pix (SPI) (Nota P001)
                          fPadR   ('000'                                     , 03, '0') + //021 - 023 - Banco Favorecido (Obrigatório)
                          fPadR   ('00000'                                   , 05, '0') + //024 - 028 - Agência Favorecido (Obrigatório)
                          fPadL   (' '                                       , 01)      + //029 - 029 - Dígito Verificador da Agência (Opcional)
                          fPadR   ('0'                                       , 12, '0') + //030 - 041 - Conta Corrente do Favorecido (Obrigatório)
                          fPadR   ('0'                                       , 01, '0') + //042 - 042 - Dígito Verificador da Conta Corrente (Obrigatório)
                          fPadL   (' '                                       , 01)      + //043 - 043 - Dígito Verificador da Agência/Conta (Opcional)
                          fPadR   (LNomeFornecedor                           , 30, ' ') + //044 - 073 - Nome do Favorecido (Obrigatório)
                          fPadL   (strAutInc                                 , 20, ' ') + //074 - 093 - Nro. do Documento Cliente (Nota G064)
                          fPadR   (strDtaPag                                 , 08, '0') + //094 - 101 - Data do Pagamento (DDMMAAAA)
                          fPadL   ('BRL'                                     , 03, ' ') + //102 - 104 - Tipo da Moeda (BRL)
                          fPadR   ('0'                                       , 15)      + //105 - 119 - Quantidade de Moeda (Zeros)
                          fValNumForm(LValorPago                             , 15)      + //120 - 134 - Valor do Pagamento (Obrigatório)
                          fPadR   (' '                                       , 20)      + //135 - 154 - Nro. do Documento Banco (Brancos)
                          fPadR   (strDtaPag                                 , 08)      + //155 - 162 - Data Real do Pagamento (Retorno) (DDMMAAAA)
                          fValNumForm(LValorPago                             , 15)      + //163 - 177 - Valor Real do Pagamento (Zeros)
                          fPadR   (' '                                       , 40)      + //178 - 217 - Informação 2 - Mensagem (Nota G031)
                          fPadL   (' '                                       , 02)      + //218 - 219 - Filler (Nota G004)
                          fPadL   (qryRemessa.FieldByName('PGI_CODTED').AsString, 05, '0')  + //220 - 224 - Finalidade de TED (Nota P011)
                          fPadL   (IIF(qryRemessa.FieldByName('COMPDES').AsString.Equals('PP'),
                                       'PP', ' ')                            , 02)      + //225 - 226 - Código Finalidade Complementar (Nota P013)
                          fPadL   (' '                                       , 03)      + //227 - 229 - Filler (Brancos)
                          fPadL   (RightStr(LAvisoTed, 1)                    , 01)      + //230 - 230 - Emissão de Aviso ao Favorecido (Zero)
                          fPadR   (' '                                       , 10, ' '); //231 - 240 - Ocorrências para o Retorno (Nota G059)

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AJ*}
          Writeln(txtTexto,strTransacao);

          {*****************************************}
          {* REGISTRO DE DETALHE => SEGMENTO B PIX *}
          {**************************************AJ*}

          strTransacao := '';
          Inc(intCodSeq1);

          strTransacao := fPadR(Copy(strCodBco,1,3)                      , 03)           + //001 - 003
                          fPadR(fStrZero(intIndLot,4)                    , 04)           + //004 - 007
                          fPadR('3'                                      , 01)           + //008 - 008
                          fPadL(IntToStr(intCodSeq1)                     , 05, '0')      + //009 - 013
                          fPadR('B'                                      , 01)           + //014 - 014
                          fPadR(fRetornaTipoChavePix(qryRemessa)         , 02, ' ')      + //015 - 016
                          fPadR(' '                                      , 01, ' ')      + //017 - 017
                          fPadR(IntToStr(intTipIns)                      , 01)           + //018 - 018
                          fPadL(qryRemessa.FieldByName('CODCGC').AsString, 14, '0')      + //019 - 032
                          fPadR(' '                                      , 35, ' ')      + //033 - 067
                          fPadR(' '                                      , 60, ' ')      + //068 - 127
                          fPadR(qryRemessa.FieldByName('CHAVE_PIX').AsString , 99,' ')   + //128 - 226
                          fStrZero('0'                                   , 6)            + //227 - 232
                          fPadL(' '                                      , 8, ' ');        //233 - 240

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AJ*}
          Writeln(txtTexto,strTransacao);

          {****************}
          {* GRAVA LOGCTP *}
          {*************AJ*}
          untLogCtp.GravaLogCtp(qryRemessa.FieldByName('PGI_AUTOIN').AsString,
                                'EXPORTAÇÃO DE ARQUIVO DE REMESSA - CTP - ' + strCodBco,
                                'frmExpArqRemBancoobCta');

          qryRemessa.Next;
        End;

        {****************************}
        {* TRAILER DO LOTE => Reg 5 *}
        {*************************AJ*}

        Inc(intCodSeq1);
        Inc(intCodSeq1);
        strTraillerLot := '';

        strTraillerLot := fPadR      (Copy(strCodBco,1,3)  , 003)       + //001 - 003
                          fPadR      (fStrZero(intIndLot,4), 004)       + //004 - 007
                          fPadR      ('5'                  , 001)       + //008 - 008
                          fPadR      (' '                  , 009)       + //009 - 017
                          fPadL      (IntToStr(intCodSeq1) , 006, '0')  + //018 - 023
                          fValNumForm(fltValPag1           , 018)       + //024 - 041
                          fStrZero   ('0'                  , 018)       + //042 - 059
                          fStrZero   ('0'                  , 006)       + //060 - 065
                          fPadR      (' '                  , 175);        //066 - 240

        {************************************}
        {* ESCREVE O TRAILER DO LOTE NO TXT *}
        {*********************************AJ*}
        Writeln(txtTexto,strTraillerLot);

      end;

      qryRemessa.Filtered := False;
      qryRemessa.Filter   := ' CODBAN = ' + QuotedStr('756') + ' AND AUTOINCREM_FORPIX IS NULL ';
      qryRemessa.Filtered := True;

      If Not qryRemessa.IsEmpty Then
      Begin
        Inc(intIndLot);
        Inc(intTotLot);
        {*************************************************}
        {* HEADER DO LOTE (TÍTULOS DO Bancoob) => REG 1  *}
        {************************************************}
        strHeaderLot := '';
        strHeaderLot := fPadR   ('756'              , 003)      + //001 - 003
                        fPadR   (fStrZero(intIndLot,4), 004)    + //004 - 007
                        fPadR   ('1'                , 001)      + //008 - 008
                        fPadL   ('C'                , 001)      + //009 - 009
                        fPadR   ('20'               , 002)      + //010 - 011
                        fPadR   ('30'               , 002)      + //012 - 013
                        fPadR   ('040'              , 003)      + //014 - 016
                        fPadL   (' '                , 001)      + //017 - 017
                        fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                        fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                        fStrZero(strCodConv         , 020)      + //033 - 052
                        fPadL   (strCodAgen         , 005, '0') + //053 - 057
                        fPadR   (strDigAgen         , 001)      + //058 - 058
                        fPadL   (strContCor         , 012, '0') + //059 - 070
                        fPadR   (strDigCnt          , 001)      + //071 - 071
                        fPadL   (strDigCnt          , 001, '0') + //072 - 072
                        fPadR   (fTiraCaracEspeciais(strNomEmp)          , 030, ' ') + //073 - 102
                        fPadL   (' '                , 030)      + //103 - 132
                        fPadL   (' '                , 010)      + //133 - 142
                        fPadR   (fTiraCaracEspeciais(strEndEmp)          , 030, ' ') + //143 - 172
                        fPadL   (strNumEmp          , 005, '0') + //173 - 177
                        fPadR   (fTiraCaracEspeciais(strComEmp)          , 015, ' ') + //178 - 192
                        fPadR   (fTiraCaracEspeciais(strCidEmp)          , 020, ' ') + //193 - 212
                        fPadL   (strCepEmp          , 008, '0') + //213 - 220
                        fPadR   (strEstEmp          , 002, ' ') + //221 - 222
                        fPadR   (' '                , 008)      + //223 - 230
                        fPadR   (' '                , 010);       //231 - 240

        {****************************}
        {* ESCREVE O HEADER DO LOTE *}
        {*************************AF*}
        Writeln(txtTexto, strHeaderLot);

        {******************************************************************}
        {* REGISTRO DE DETALHE (TÍTULOS DO Bancoob) => REG = 3 => SEGMENTO J *}
        {***************************************************************AF*}

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

            strDtaPag := FormatDateTime(  'dd', IIF(dtDtaPag > 0, dtDtaPag, FieldByName('PGI_DTAPAG').AsDateTime) ) +
                         FormatDateTime(  'mm', IIF(dtDtaPag > 0, dtDtaPag, FieldByName('PGI_DTAPAG').AsDateTime) ) +
                         FormatDateTime('yyyy', IIF(dtDtaPag > 0, dtDtaPag, FieldByName('PGI_DTAPAG').AsDateTime) );

            strAutInc := FieldByName('PGI_AUTOIN').AsString;

            fltValPag1 := fltValPag1 + FieldByName('PGI_VALPAG').AsFloat;

            If Length(FieldByName('CODCGC').AsString) > 11 Then
              intTipInsFor := 2
            Else
              intTipInsFor := 1;

            strTransacao := fPadR      ('756'                                   , 03)      + //001 - 003
                            fPadR      (fStrZero(intIndLot,4)                   , 04)      + //004 - 007
                            fPadR      ('3'                                     , 01)      + //008 - 008
                            fPadL      (IntToStr(intCodSeq1)                    , 05, '0') + //009 - 013
                            fPadR      ('J'                                     , 01)      + //014 - 014
                            fStrZero   ('0'                                     , 03)      + //015 - 017
                            fPadL      (FieldByName('PGI_CODBAR').AsString      , 44, '0') + //018 - 061
                            fPadR      (fTiraCaracEspeciais(FieldByName('FOR_NOMFOR').AsString)      , 30, ' ') + //062 - 091
                            fPadR      (strDtaVen                               , 08)      + //092 - 099
                            fValNumForm(FieldByName('PGI_VALDUP').AsFloat       , 15)      + //100 - 114
                            fValNumForm(FieldByName('PGI_VALDES').AsFloat       , 15)      + //115 - 129
                            fValNumForm(FieldByName('PGI_VALJUR').AsFloat       , 15)      + //130 - 144
                            fPadR      (strDtaPag                               , 08)      + //145 - 152
                            fValNumForm(FieldByName('PGI_VALPAG').AsFloat       , 15)      + //153 - 167
                            fStrZero   ('0'                                     , 15)      + //168 - 182
                            fPadL      (strAutInc                               , 20, '0') + //183 - 202
                            fPadR      (' '                                     , 20)      + //203 - 222
                            fPadL      ('09'                                    ,  2)      + //223 - 224
                            fPadL      (' '                                     ,  6)      + //225 - 230
                            fPadL      (' '                                     , 10);       //231 - 240

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************AF*}
            Writeln(txtTexto, strTransacao);
            Inc(intCodSeq1);

            {***********************************************************}
            {* REGISTRO DE DETALHE (TÍTULOS DO BRADESCO) SEGMENTO J-52 *}
            {*REQ. 156718********************************************MO*}

            strTransacao := fPadR('756'                             , 03)      + //001 - 003 - CÓDIGO DO BANCO NA COMPENSAÇÃO
                            fPadR(fStrZero(intIndLot,4)             , 04)      + //004 - 007 - LOTE DE SERVIÇO
                            fPadR('3'                               , 01)      + //008 - 008 - TIPO DE REGISTRO
                            fPadL(IntToStr(intCodSeq1)              , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                            fPadR('J'                               , 01)      + //014 - 014 - CÓD. SEGMENTO DO REGISTRO DETALHE
                            fPadL(' '                               , 01)      + //015 - 015 - USO EXCLUSIVO FEBRABAN/CNAB
                            fPadL('00'                              , 02)      + //016 - 017 - CÓDIGO DE MOVIMENTO REMESSA
                            fPadL('52'                              , 02)      + //018 - 019 - IDENTIFICAÇÃO REGISTRO OBRIGATÓRIO
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

        {*************************************************}
        {* TRAILLER DO LOTE (TÍTULOS DO Bancoob) => Reg 5   *}
        {**********************************************AF*}
        Inc(intCodSeq1);
        Inc(intCodSeq1);
        strTraillerLot := '';
        strTraillerLot := fPadR      ('756'                , 003)       + //001 - 003
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
        {**********************************AF*}
        Writeln(txtTexto, strTraillerLot);
      End;

      qryRemessa.Filtered := False;
      qryRemessa.Filter   := ' CODBAN <> ' + QuotedStr('756') + ' AND AUTOINCREM_FORPIX IS NULL ';
      qryRemessa.Filtered := True;

      intCodSeq2 := 0;

      If Not qryRemessa.IsEmpty Then
      Begin
        Inc(intIndLot);
        Inc(intTotLot);

        If intIndLot = 0 Then
          intIndLot := 1;

        {********************************************************************}
        {* HEADER DO LOTE (TÍTULOS DE OUTROS BANCOS) => REG 1 => SEGMENTO J *}
        {*****************************************************************KP*}
        strHeaderLot := '';
        strHeaderLot := fPadR   ('756'              , 003)      + //001 - 003
                        fPadR   (fStrZero(intIndLot,4), 004)      + //004 - 007
                        fPadR   ('1'                , 001)      + //008 - 008
                        fPadL   ('C'                , 001)      + //009 - 009
                        fPadR   ('20'               , 002)      + //010 - 011
                        fPadR   ('30'               , 002)      + //012 - 013
                        fPadR   ('040'              , 003)      + //014 - 016
                        fPadL   (' '                , 001)      + //017 - 017
                        fPadR   (IntToStr(intTipIns), 001)      + //018 - 018
                        fPadL   (strCgcEmp          , 014, '0') + //019 - 032
                        fStrZero(strCodConv         , 020)      + //033 - 052
                        fPadL   (strCodAgen         , 005, '0') + //053 - 057
                        fPadR   (strDigAgen         , 001)      + //058 - 058
                        fPadL   (strContCor         , 012, '0') + //059 - 070
                        fPadR   (strDigCnt          , 001)      + //071 - 071
                        fPadL   (strDigCnt          , 001, '0') + //072 - 072
                        fPadR   (fTiraCaracEspeciais(strNomEmp)          , 030, ' ') + //073 - 102
                        fPadL   (' '                , 030)      + //103 - 132
                        fPadL   (' '                , 010)      + //133 - 142
                        fPadR   (fTiraCaracEspeciais(strEndEmp)          , 030, ' ') + //143 - 172
                        fPadL   (strNumEmp          , 005, '0') + //173 - 177
                        fPadR   (fTiraCaracEspeciais(strComEmp)          , 015, ' ') + //178 - 192
                        fPadR   (fTiraCaracEspeciais(strCidEmp)          , 020, ' ') + //193 - 212
                        fPadL   (strCepEmp          , 008, '0') + //213 - 220
                        fPadR   (strEstEmp          , 002, ' ') + //221 - 222
                        fPadR   (' '                , 008)      + //223 - 230
                        fPadR   (' '                , 010);       //231 - 240

        {****************************}
        {* ESCREVE O HEADER DO LOTE *}
        {*************************KP*}
        Writeln(txtTexto, strHeaderLot);

        {***************************************************************************}
        {* REGISTRO DE DETALHE (TÍTULOS DE OUTROS BANCOS) => REG = 3 => SEGMENTO J *}
        {************************************************************************KP*}
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

            strDtaPag := FormatDateTime(  'dd', IIF(dtDtaPag > 0, dtDtaPag, FieldByName('PGI_DTAPAG').AsDateTime) ) +
                         FormatDateTime(  'mm', IIF(dtDtaPag > 0, dtDtaPag, FieldByName('PGI_DTAPAG').AsDateTime) ) +
                         FormatDateTime('yyyy', IIF(dtDtaPag > 0, dtDtaPag, FieldByName('PGI_DTAPAG').AsDateTime) );

            strAutInc := FieldByName('PGI_AUTOIN').AsString;

            fltValPag2 := fltValPag2 + FieldByName('PGI_VALPAG').AsFloat;

            If Length(FieldByName('CODCGC').AsString) > 11 Then
              intTipInsFor := 2
            Else
              intTipInsFor := 1;

            strTransacao := fPadR      ('756'                                                         , 03)      + //001 - 003
                            fPadR      (fStrZero(intIndLot,4)                                         , 04)      + //004 - 007
                            fPadR      ('3'                                                           , 01)      + //008 - 008
                            fPadL      (IntToStr(intCodSeq2)                                          , 05, '0') + //009 - 013
                            fPadR      ('J'                                                           , 01)      + //014 - 014
                            fStrZero   ('0'                                                           , 03)      + //015 - 017
                            fPadL      (FieldByName('PGI_CODBAR').AsString                            , 44, '0') + //018 - 061
                            fPadR      (fTiraCaracEspeciais(FieldByName('FOR_NOMFOR').AsString, true) , 30, ' ') + //062 - 091
                            fPadR      (strDtaVen                                                     , 08)      + //092 - 099
                            fValNumForm(FieldByName('PGI_VALDUP').AsFloat                             , 15)      + //100 - 114
                            fValNumForm(FieldByName('PGI_VALDES').AsFloat                             , 15)      + //115 - 129
                            fValNumForm(FieldByName('PGI_VALJUR').AsFloat                             , 15)      + //130 - 144
                            fPadR      (strDtaPag                                                     , 08)      + //145 - 152
                            fValNumForm(FieldByName('PGI_VALPAG').AsFloat                             , 15)      + //153 - 167
                            fStrZero   ('0'                                                           , 15)      + //168 - 182
                            fPadL      (strAutInc                                                     , 20, '0') + //183 - 202
                            fPadL      (' '                                                           , 20)      + //203 - 222
                            fPadL      ('09'                                                          ,  2)      + //223 - 224
                            fPadL      (' '                                                           ,  6)      + //225 - 230
                            fPadL      (' '                                                           , 10);       //231 - 240

            {******************************}
            {* ESCREVE A TRANSACAO NO TXT *}
            {***************************KP*}
            Writeln(txtTexto, strTransacao);
            Inc(intCodSeq2);

            {***********************************************************}
            {* REGISTRO DE DETALHE (TÍTULOS DO BRADESCO) SEGMENTO J-52 *}
            {*REQ. 156718********************************************MO*}

            strTransacao := fPadR('756'                             , 03)      + //001 - 003 - CÓDIGO DO BANCO NA COMPENSAÇÃO
                            fPadR(fStrZero(intIndLot,4)             , 04)      + //004 - 007 - LOTE DE SERVIÇO
                            fPadR('3'                               , 01)      + //008 - 008 - TIPO DE REGISTRO
                            fPadL(IntToStr(intCodSeq2)              , 05, '0') + //009 - 013 - Nº SEQUENCIAL DO REGISTRO NO LOTE
                            fPadR('J'                               , 01)      + //014 - 014 - CÓD. SEGMENTO DO REGISTRO DETALHE
                            fPadL(' '                               , 01)      + //015 - 015 - USO EXCLUSIVO FEBRABAN/CNAB
                            fPadL('00'                              , 02)      + //016 - 017 - CÓDIGO DE MOVIMENTO REMESSA
                            fPadL('52'                              , 02)      + //018 - 019 - IDENTIFICAÇÃO REGISTRO OBRIGATÓRIO
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

        {********************************************************}
        {* TRAILLER DO LOTE (TÍTULOS DE OUTROS BANCOS) => Reg 5 *}
        {*****************************************************KP*}
        Inc(intCodSeq2);
        Inc(intCodSeq2);
        strTraillerLot := '';
        strTraillerLot := fPadR      ('756'                , 003)       + //001 - 003
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
      End;

      {********************************}
      {* TRAILLER DO ARQUIVO => Reg 9 *}
      {*****************************AF*}

      intCodSeqGer:= intCodSeq1 + intCodSeq2 + 2;
      strTrailler := '';
      strTrailler := fPadR   ('756'                 , 003)      + //001 - 003
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

    End
    Else
    Begin
      fRollBack;
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

		FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);
		//FreeAndNil(stlMensagem);

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
		  pMensagensErro(E.Message,  '[untExpArqRemBancoobCta.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');

		End;
  End;

end;

function TfrmExpArqRemBancoobCta.fRetEmpresa: String;
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


function TfrmExpArqRemBancoobCta.fRetornaTipoChavePix(PQueryRemessa : TUniQuery): String;
begin
  Result := '03';
  If PQueryRemessa.FieldByName('TIPCHV_PIX').AsString.Equals('CELULAR') Then
    Result := '01'
  Else If PQueryRemessa.FieldByName('TIPCHV_PIX').AsString.Equals('EMAIL') Then
    Result := '02'
  Else If PQueryRemessa.FieldByName('TIPCHV_PIX').AsString.Equals('ALEATORIA') Then
    Result := '04';
end;

end.
