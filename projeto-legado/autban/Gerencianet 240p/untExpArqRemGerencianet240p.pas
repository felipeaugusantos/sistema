unit untExpArqRemGerencianet240p;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, untCadRec, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemGerencianet240p = class(TfrmPai)
    pnlFundo: TPanel;
    lblNomArq: TLabel;
    lblPathRem: TLabel;
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
    procedure FormActivate(Sender: TObject);
  private
    {Inforções Carteira}
    strNomEmp   : String;
    strCodBco   : String;
    strCartei   : String;
    strCpfCgc   : String;
    strDiaPro   : String;
    strCodPro: String;
    strCodBaixa: String;
    intQtdPar: Integer;
    strEhCarne: String;
    strDiasBaixa: String;
    fltValDup : Double;
    qryConsultaGen : TUniQuery;
    qryCadPor      : TUniQuery;
    qryRemessa  : TUniQuery;
    function fRetEmpresa: String;

    function fValidacoesParaExportacao:Boolean;
    procedure pValidaInformacoesCarteira;
    function fGetSqlRemessa: String;
    function fCriarQueryRemessa:TUniQuery;
    procedure pValidaInformacoesRemessa;
    procedure pApagarCADCBI;

  	const strBanCfg: String = 'CONFIG364-';

    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
    
  end;

var
  frmExpArqRemGerencianet240p: TfrmExpArqRemGerencianet240p;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutban, Data.DB,untConsultas,untTypesSistema,
 System.DateUtils;

{$R *.dfm}

procedure TfrmExpArqRemGerencianet240p.FormShow(Sender: TObject);
var
  strCodPorRem: String;
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         FormatDateTime('ddmmyy',VS_Date) +
                         FormatDateTime('hhnnss', fTime()) +
                         '.REM';

  strCodPorRem := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'PORREM_', '');

  If (Not fEmptyStr(strCodPorRem)) Then
  Begin
    edtCodPor.Text := strCodPorRem;
    If Not fValidaCampos(edtCodPor) Then
      edtCodPor.Text := ''
    Else
      edtCodPorExit(edtCodPor);
  End;

  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemGerencianet240p.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strNomBco   : String;
    strCodTrans  : String;
    strContCor  : String;
    strDigCtaC  : String;
    LDVContaAgencia : String;
    strDigAgeC  : String;
    strNumAgeC  : String;
    strDtaRem   : String;
    strDtaVen   : String;
    strDtaEmi   : String;
    strKeyDup   : String;
    strCgcEmp   : String;
    strCgcCli   : String;
    strCodAgen  : String;
    strDigAgen  : String;
    strDigCorr  : String;
    strCodCar   : String;
    strInstru1  : String;
    strInstru2  : String;
//    strAgenCob  : String;
    strRespons  : String;
    strHeader   : String;
    strHeaderLote : String;
    strCodMov: String;
    strTipoCob: String;
    strFormaCad: String;
    strTipoDoc: String;
    strSegmentoP: String;
    strSegmentoQ: String;
    LSegmentoR : String;
    stlMensagem : TStringList;
    strTrailler : String;
    strTraillerLote : String;
    strSacAva   : String;
    strCnpjBen  : String;
    strNomeBen  : String;
    intCodSeq   : Integer;
    fltValTot   : Double;
    fltValMora  : Double;
    txtTexto    : TextFile;
    //strCompl    : String;
    strCodRem   : String;
    strFilePath : String;
    strAutoIncremRem: String;
    strCartSeq  : String;
    strMsg1  : String;
    strMsg2  : String;
    strNumPar: String;
    strDtaVenMulta: String;
    dtaDtaVenMulta: TDateTime;
    fltPerMul   : Double;
    strPerMul : String;
    strEsp_ID : String;
    strNomEmp : String;
    strCodConv: String;
    strNosNum : String;
    strNomCli : String;
    strEndCli : String;
    strBaiCli : String;
    strCepCli : String;
    strCidCli : String;
    strHraRem : String;
    strToken  : String;
begin
  inherited;

  If Not fValidacoesParaExportacao Then
    Exit;

  strCodBco   := '364';
  strNomBco   := 'GERENCIANET';
  strCodTrans := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODTRANS', '');
  strCodAgen  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'NUMAGEC',  '');
  strDigAgen  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIGAGEC',  '');
  strDigCorr  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIGCORR',  '');
  strCodCar   := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODCART',  '');
  strDiaPro   := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIAPROT',  '');
  strContCor  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'NUMCTAC',  '');
  strDigCtaC  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIGCTAC',  '');
  strDigAgeC  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIGAGEC',  '');
  strNumAgeC  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'NUMAGEC',  '');
  strCodMov   := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODMOV',   '');
  strTipoCob  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'TIPOCOB',  '');
  strFormaCad := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'FORMACAD', '');
  strCodBaixa := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODBAIXA', '');
  strDiasBaixa:= fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIASBAIXA','');
  strTipoDoc  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'TIPODOC',  '');
  strCodConv  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODCONV',  '');
  strCodPro   := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODPRO',   '');
  strToken    := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'TOKEN',   '');

  LDVContaAgencia := '';

  If Length(strDigCtaC) = 2 Then
  Begin
    LDVContaAgencia := RightStr(strDigCtaC,1);
    strDigCtaC := LeftStr(strDigCtaC,1);
  End;

  fltPerMul  := fStrToFloat(fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'PERMULT', ''));
  strPerMul  := '0';

  If fltPerMul > 0 Then
  Begin
    strPerMul := FormatFloat('###,##0.00', fltPerMul);
    strPerMul := fTiraCaracEspeciais(strPerMul);
  End;

  //strContCob := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'NUMCTAC', '');
  strRespons := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'RESPONS', '');
  strDtaRem  := FormatDateTime('ddmmyyyy',VS_Date);
  strHraRem :=  FormatDateTime('hhnnss', fTime());

  strInstru1 := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'INSTRU2', '');
  //strAgenCob := '00000';
  strSacAva  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'SACAVAL', '');
  strCnpjBen := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CNPJBEN', '');
  strNomeBen := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'NOMEBEN', '');
  strMsg1    := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'OBSERV1', '');
  strMsg2    := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'OBSERV2', '');

  pValidaInformacoesCarteira;
  Try
    fStartTransaction;

    stlMensagem    := TStringList.Create;
    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_C_G_C_, ';
    strSQL := strSQL + '  EMP_NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    qryConsultaGen.Close;
    qryConsultaGen.SQL.Clear;
    qryConsultaGen.SQL.Add(strSQL);
    qryConsultaGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryConsultaGen.Open;
    strCgcEmp := qryConsultaGen.FieldByName('EMP_C_G_C_').AsString;
    strNomEmp := fRemoveAcento(qryConsultaGen.FieldByName('EMP_NOMEMP').AsString);
    qryConsultaGen.Close;


    strCartei := strBanCfg + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriarQueryRemessa;

    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      strCartSeq := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq(strBanCfg + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 6);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadL   ('364'              , 003)     + //   001 - 003 Código do Banco na compensação N 003 33
                   fPadL   ('0001'             , 004)     + //   004 - 007 Lote de serviço N 004 0000 1
                   fPadL   ('0'                , 001)     + //   008 - 008 Tipo de registro N 001 0 2
                   fPadR   (' '                , 009,' ') + //   009 - 017 Reservado (uso Banco) A 008 Brancos
                   fPadL   ('2'                , 001)     + //   018 - 018 Tipo de inscrição da empresa N 001 1 = CPF, 2 = CNPJ
                   fPadL   (fTiraCaracEspeciaisPonto(strCnpjBen), 014,'0') +//   019 – 032 Nº de inscrição da empresa N 015
                   fPadR   (strCodConv         , 020,' ') + //   033 – 052 Código do Convênio N 015 3
                   fPadR   ('00001'            , 005,' ') + //   053 - 057 Agência - Fixo em '00001'
                   fPadR   (' '                , 001,' ') + //   058 - 058 DV da Agência - Preencher com Espaço
                   fPadL   (strContCor         , 012,'0') + //   059 - 070 Numero da Conta
                   fPadR   (strDigCtaC         , 001,' ') + //   071 - 071 DV Conta
                   fPadR   ('0'                , 001)     + //   072 - 072 DV Agencia Conta - Preencher co zeros
                   fPadR   (strNomEmp          , 030)     + //   073 - 102 Nome Empresa
                   fPadR   ('EFI'              , 030,' ') + //   103 - 132 Fixo GERENCIANET
                   fPadR   (' '                , 010,' ') + //   133 - 142 Espaços
                   fPadR   ('1'                , 001)     + //   143 - 143 1 - Remessa - 2 - Retorno
                   fPadL   (strDtaRem          , 008,'0') + //   144 - 151 Data de Geração do Arquivo 008 no formato ddmmaaaa
                   fPadL   (strHraRem          , 006,'0') + //   152 - 157 Hora de Geração do Arquivo 0006 no formato HHMMSS
                   fPadL   (IntToStr(intCodSeq), 006,'0') + //   158 - 163 Número Sequencial do Arquivo 006 Zeros
                   fPadL   ('103'              , 003,'0') + //   164 - 166 lAYOUT DO aRQUIVO FIXO EM 103
                   fPadL   ('0'                , 005,'0') + //   167 - 171 Densidade
                   fPadL   (' '                , 020,' ') + //   172 - 191 Brancos
                   fPadL   (' '                , 020,' ') + //   192 - 211 Brancos
                   fPadR   (' '                , 029,' ');  //   212 - 240 Brancos

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {******************}
      {* HEADER DO LOTE *}
      {***************AF*}
      strHeaderLote := '';
      strHeaderLote := fPadR   ('364'              , 003)     +// 001 - 003 Código do Banco na compensação N 003 133
                       fPadL   ('1'                , 004,'0') +// 004 - 007 Numero do lote remessa N 004 1
                       fPadR   ('1'                , 001)     +// 008 - 008 Tipo de registro N 001 1
                       fPadR   ('R'                , 001)     +// 009 - 009 Tipo de operação A 001 R (Remessa)
                       fPadR   ('01'               , 002)     +// 010 - 011 Tipo de serviço N 002 01 (Cobrança)
                       fPadR   (' '                , 002,' ') +// 012 - 013 Reservado (uso Banco) A 002 Brancos
                       fPadR   ('060'              , 003)     +// 014 - 016 Nº da versão do layout do lote N 003 042
                       fPadR   (' '                , 001,' ') +// 017 - 017 Reservado (uso Banco) A 001 Branco
                       fPadR   ('2'                , 001)     +// 018 - 018 Tipo de inscrição da empresa N 001 1 = CPF, 2 = CNPJ
                       fPadL   (fTiraCaracEspeciaisPonto(strCnpjBen), 015,'0') +// 019 - 033 Nº de inscrição da empresa N 015
                       fPadR   (strCodConv         , 020,' ') +// 034 - 053 Código do Convênio no Banco 020 Número da conta do cooperado
                       fPadL   ('00001'            , 005,'0') +// 054 - 058 Agência Mantenedora da Conta 005 Código da Cooperativa
                       fPadL   (' '                , 001,' ') +// 059 - 059 Dígito Verificador da AG 001 0
                       fPadL   (strContCor         , 012,'0') +// 060 - 071 Número da Conta Corrente 012 Número da conta corrente na Cresol
                       fPadR   (strDigCtaC         , 001,'0') +// 072 - 072 Dígito Verificador da Conta 001 Dígito Conta Corrente Cresol
                       fPadR   (' '                , 001,' ') +// 073 - 073 Dígito Verificador da Ag/Conta 001 Branco
                       fPadR   (strNomEmp          , 030,' ') +// 074 - 103 Nome da Empresa 030
                       fPadR   (' '                , 040,' ') +// 104 - 143 Mensagem 1 040 Brancos
                       fPadR   (' '                , 040,' ') +// 144 - 183 Mensagem 2 040 Brancos
                       fPadL   (IntToStr(intCodSeq), 008,'0') +// 184 - 191 Número Sequencial Remessa/Retorno 008 Zeros
                       fPadR   (strDtaRem          , 008,'0') +// 192 - 199 Data de Gravação Remessa/Retorno 008 Zeros
                       fPadL   ('0'                , 008,'0') +// 200 - 207 Data do Crédito 008 Zeros
                       fPadR   (' '                , 033,' '); // 208 - 240 Uso Exclusivo FEBRABAN/CNAB 033 Brancos

      {***********************************}
      {* ESCREVE O HEADER DO LOTE NO TXT *}
      {********************************AF*}
      Writeln(txtTexto,strHeaderLote);

      {*****************************}
      {* GRAVAÇÃO DA TABELA REMGER *}
      {** DADOS GERAIS DA REMESSA **}
      {**************************MO*}
      pGravaRemGer(VS_strCodEmp, strCodBco, StrCartei, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AF*}
      strSegmentoP := '';
      strSegmentoQ := '';
      LSegmentoR   := '';

      fltValTot    := 0;
      intCodSeq    := 0;
      While Not qryRemessa.Eof Do
      Begin
        Application.ProcessMessages;

        fltValTot := fltValTot + qryRemessa.FieldByName('CBI_VALDUP').AsFloat;

        fltValMora := ((qryRemessa.FieldByName('CBI_VALDUP').AsFloat ) * (fCfgSis('TAXDIA', varDouble) / 100 ));


        strDtaVen := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime) +
                     FormatDateTime('yyyy',qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);

        dtaDtaVenMulta := IncDay(qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime);

        strDtaVenMulta := FormatDateTime('dd', dtaDtaVenMulta) +
                          FormatDateTime('mm', dtaDtaVenMulta) +
                          FormatDateTime('yyyy', dtaDtaVenMulta);

        strDtaEmi := FormatDateTime('dd',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('mm',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime) +
                     FormatDateTime('yyyy',qryRemessa.FieldByName('CBI_DTACAD').AsDateTime);

        strEsp_ID := TEspecieParaArquivoRemessa.New.fRetornaIndiceParaEspecie(qryRemessa.FieldByName('CBI_ESPDOC').AsString);

        strKeyDup := qryRemessa.FieldByName('CBI_NUMDUP').AsString +
                     qryRemessa.FieldByName('CBI_PARCEL').AsString +
                     strEsp_ID +
                     qryRemessa.FieldByName('CBI_CODEMP').AsString +
                     qryRemessa.FieldByName('CBI_CODCLI').AsString;

        strNumPar := fRetNumParcela(qryRemessa.FieldByName('CBI_PARCEL').AsString);
        intQtdPar := fQtdParcelas(qryRemessa.FieldByName('CBI_NUMDUP').AsString,
                                  qryRemessa.FieldByName('CBI_CODEMP').AsString,
                                  qryRemessa.FieldByName('CBI_ESPDOC').AsString,
                                  qryRemessa.FieldByName('CBI_CODCLI').AsString);

        strCgcCli := Trim(qryRemessa.FieldByName('CBI_C_G_C_').AsString);

        fltValDup := qryRemessa.FieldByName('CBI_VALDUP').AsFloat;

        strNosNum := fPadL(strContCor, 9, '0') +
                     '1' +
                     fPadL(LeftStr(qryRemessa.FieldByName('CBI_NOSNUM').AsString, 10), 10, '0');

        strNomCli := fRemoveAcento(qryRemessa.FieldByName('CLI_NOMCLI').AsString);
        strEndCli := fTiraCaracEspeciais(fRemoveAcento(qryRemessa.FieldByName('ENDERE').AsString));
        strBaiCli := fRemoveAcento(qryRemessa.FieldByName('BAIRRO').AsString);
        strCidCli := fRemoveAcento(qryRemessa.FieldByName('CIDADE').AsString);
        strCepCli := fRetSomenteNumeros(qryRemessa.FieldByName('C_E_P_').AsString);

        pValidaInformacoesRemessa;

        Inc(intCodSeq);
        strSegmentoP := '';
        strSegmentoP :=  fPadR ('364'                       ,003)    + // 001 - 003 Código do Banco na compensação N 003 364
                         fPadL ('0001'                      ,004,'0')+ // 004 - 007 Numero do lote remessa N 004 1
                         fPadR ('3'                         ,001)    + // 008 - 008 Tipo de registro N 001 3 2
                         fPadL ('0'                         ,005,'0')+ // 009 - 013 Nº seqüencial do registro de lote N 005 11
                         fPadR ('P'                         ,001)    + // 014 - 014 Cód. Segmento do registro detalhe A 001 P 13
                         fPadR (' '                         ,001)    + // 015 - 015 Reservado (uso Banco) A 001 Brancos
                         fPadL (LeftStr(strCodMov, 2)       ,002,'0')+ // 016 - 017 Código de movimento remessa N 002 14
                         fPadL ('00001'                     ,005,'0')+ // 018 - 022 Ag Mantenedora da Conta 005 Código da Cooperativa
                         fPadR (' '                         ,001)    + // 023 - 023 Dígito Verificador da Ag 1 0
                         fPadL (strContCor                  ,012,'0')+ // 024 - 035 Número da Conta Corrente 012 Número da conta correntena
                         fPadR (strDigCtaC                  ,001)    + // 036 - 036 Dígito Verificador da Conta 001 Dígito Conta Corrente
                         fPadR (' '                         ,001)    + // 037 - 037 Dígito Verificador da Ag/Conta 001 Branco
                         fPadR (strNosNum                   ,020)    + // 038 - 057 Nosso Número
                         fPadR ('1'                         ,001)    + // 058 - 058 Carteira Fixo '1'
                         fPadL ('1'                         ,001)    + // 059 - 059 Cadastramento - Fixo '1'
                         fPadL ('1'                         ,001)    + // 060 - 060 Cadastramento - Fixo '1'
                         fPadL ('2'                         ,001)    + // 061 - 061 Responsável EMissão - Fixo '2'
                         fPadR ('2'                         ,001)    + // 062 - 062 Distribuição - '1' - Gerencianet / '2' - Emissor
                         fPadL (qryRemessa.FieldByName('CBI_NUMDUP').AsString ,015,'0')+ // 063 - 077 Seu Numero - Número Doc. De Cobrança 015
                         fPadL (strDtaVen                   ,008,'0')+ // 078 - 085 Data de Vencimento 008 no formato ddmmaaaa
                         fValNumForm(fltValDup              ,015)    + // 086 - 100 Valor Nominal do Título 015 com duas casas decimais
                         fPadL ('0'                         ,005,'0')+ // 101 - 105 Agência Encarregada da Cobrança 005 Zeros
                         fPadR (' '                         ,001,' ')+ // 106 - 106 Dígito Verificador da Agência 001 Branco
                         fPadL ('02'                        ,002,'0')+ // 107 - 108 Espécie do Título - Fixo em '02' - Duplicata MErcantil
                         fPadR ('A'                         ,001)    + // 109 - 109 Identific. de Título Aceito/Não Aceito  - Fixo em 'A'
                         fPadL (strDtaEmi                   ,008,'0')+ // 110 - 117 Data da Emissão do Título 008 no formato ddmmaaaa
                         fPadR ('1'                         ,001)    + // 118 - 118 Código do Juros de Mora 001 1 - (real ao dia) 2 – Percentual ao mês
                         fPadL (strDtaVen                   ,008,'0')+ // 119 - 126 Data do Juros de Mora 008 no formato ddmmaaaa
                         fValNumForm(fltValMora             ,015)    + // 127 - 141 Juros de Mora por Dia/Taxa 015 com duas casas decimais
                         fPadL ('0'                         ,001)    + // 142 - 142 Código do Desconto 001
                         fPadL ('0'                         ,008,'0')+ // 143 - 150 Data do Desconto 081 no formato ddmmaaaa
                         fPadL ('0'                         ,015,'0')+ // 151 - 165 Valor do Desconto 015 com duas casas decimais
                         fPadL ('0'                         ,015,'0')+ // 166 - 180 Valor do IOF a ser Recolhido 015
                         fPadL ('0'                         ,015,'0')+ // 181 - 195 Valor do Abatimento 015
                         fPadR (strKeyDup                   ,025,' ')+ // 196 - 220 Identific. do Título na Empresa 025 (somente relevante com ocorrência=1)
                         fPadR ('3'                         ,001,'0')+ // 221 - 221 Código para Protesto - Fixo em '3'
                         fPadL ('00'                        ,002,'0')+ // 222 - 223 Nº de Dias para Protesto - Fixo em '00'
                         fPadR ('1'                         ,001,'0')+ // 224 - 224 Código p/ Baixa - Fixo em '1'
                         fPadR ('090'                       ,003,'0')+ // 225 - 227 Número de Dias para Baixa  -Fixo em '090'
                         fPadR ('09'                        ,002)    + // 228 - 229 Código da Moeda Fixo em '09'
                         fPadL ('0'                         ,010,'0')+ // 230 - 239 Zeros
                         fPadR (' '                         ,001, ' ');// 240 - 240 Brancos
        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {*****SEGMENTO*P************AF*}
        Writeln(txtTexto,strSegmentoP);
        Inc(intCodSeq);
        strSegmentoQ := '';
        strSegmentoQ := fPadR ('364'                                                ,003)    +//  001 - 003 Código do Banco N 003 364
                        fPadL ('0001'                                               ,004,'0')+//  004 - 007 Fixo '0001'
                        fPadR ('3'                                                  ,001)    +//  008 - 008 Tipo de registro Fixo '3'
                        fPadL (IntToStr(intCodSeq)                                  ,005,'0')+//  009 - 013 Nº seqüencial do registro no lote N 005 11
                        fPadR ('Q'                                                  ,001)    +//  014 - 014 Cód. segmento do registro detalhe A 001 Q 13
                        fPadR (' '                                                  ,001,' ')+//  015 - 015 Reservado (uso Banco) A 001 Brancos
                        fPadR (LeftStr(strCodMov, 2)                                ,002,'0')+//  016 - 017 Código de movimento remessa N 002 14
                        fPadR (strCpfCgc                                            ,001)    +//  018 - 018 Tipo de inscrição do Pagador N 001 30
                        fPadL (strCgcCli                                            ,015,'0')+//  019 - 033 CPJ/CNPJ 015 30
                        fPadR (strNomCli                                            ,040,' ')+//  034 - 073 Nome Pagador A 040
                        fPadR (strEndCli                                            ,040,' ')+//  074 - 113 Endereço Pagador A 040 29
                        fPadR (strBaiCli                                            ,015,' ')+//  014 - 128 Bairro Pagador A 015 29
                        fPadL (strCepCli                                            ,008,'0')+//  129 - 136 Cep Pagador N 005 29
                        fPadR (strCidCli                                            ,015,' ')+ // 137 - 151 Cidade do Pagador A 015 29
                        fPadR (qryRemessa.FieldByName('ESTADO').AsString            ,002,' ')+ // 152 - 153 Unidade da Federação do Pagador A 002 29
                        fPadR (IIF(strSacAva <> 'S','0','2')                        ,001)    +//  154 - 154 Tipo de inscrição '1' - PF / '2' - PJ
                        fPadL (IIF(strSacAva <> 'S','0',strCgcEmp)                  ,015,'0')+//  155 - 169 Nº de inscrição Sacador/avalista N 015 30
                        fPadR (IIF(strSacAva <> 'S',' ',strNomEmp)                  ,040,' ')+//  170 - 209 Nome do Sacador/avalista A 040 31
                        fPadR ('0'                                                  ,003,'0')+//  210 – 212 Identificador de carne N 003 28
                        fPadR (' '                                                  ,020,' ')+//  213 – 232 NN Banco Correspondente - Preencher com espaços
                        fPadR (' '                                                  ,008,' ');//  233 - 240 Reservado (uso Banco) Brancos

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {*****SEGMENTO*Q************AF*}
        Writeln(txtTexto,strSegmentoQ);

        If fltPerMul > 0 Then
        Begin
          {************************}
          {* TRANSAÇÃO SEGMENTO R *}
          {*********************MT*}
          Inc(intCodSeq);
          LSegmentoR := '';
          LSegmentoR   := fPadR      ('364'                                , 03, ' ') + //001 - 003  [01] Código do Banco na Compensação
                          fPadR      ('0001'                               , 04, ' ') + //004 - 007  [02] Lote de Serviço
                          fPadL      ('3'                                  , 01, ' ') + //008 - 008  [03] Tipo de Registro
                          fStrZero   (IntToStr(intCodSeq)                  , 05)      + //009 - 013  [04] Nº Sequencial do Registro no Lote
                          fPadL      ('R'                                  , 01, ' ') + //014 - 014  [05] Cód. Segmento do Registro Detalhe
                          fPadL      (' '                                  , 01, ' ') + //015 - 015  [06] Uso Exclusivo FEBRABAN/CNAB
                          fPadL      (LeftStr(strCodMov, 2)                , 02, ' ') + //016 - 017  [07] Código de Movimento Remessa
                          fPadL      ('0'                                  , 48, '0') + //018 - 065  [08] Uso Exclusivo Banco - Zeros
                          fPadR      ('2'                                  , 01, ' ') + //066 - 066  [14] Código da Multa
                          fPadR      (strDtaVenMulta                       , 08, ' ') + //067 - 074  [15] Data da Multa
                          fStrZero   (strPerMul                            , 15)      + //075 - 089  [16] Valor/Percentual a Ser Aplicado
                          fPadR      (' '                                  , 10, ' ') + //090 - 099  [17] Reservado (uso Banco)
                          fPadR      (' '                                  , 40, ' ') + //100 - 139  [18] Mensagem 3
                          fPadR      (' '                                  , 40, ' ') + //140 - 179  [19] Mensagem 4
                          fPadR      (' '                                  , 20, ' ') + //180 - 199  [19] Mensagem 5
                          fPadL      ('0'                                  , 08, '0') + //200 - 207  [19] Código Ocorrencia Pagador - Preencher com zeros
                          fPadL      ('0'                                  , 03, '0') + //208 - 210  [19] Banco para débito em conta - Preencher com zeros
                          fPadL      ('0'                                  , 05, '0') + //211 - 215  [19] Agencia para débito em conta - Preencher com zeros
                          fPadL      ('0'                                  , 01, '0') + //216 - 216  [19] DV para débito em conta - Preencher com zeros
                          fPadL      ('0'                                  , 12, '0') + //217 - 228  [19] Conta para débito em conta - Preencher com zeros
                          fPadR      (' '                                  , 01, ' ') + //229 - 229  [19] DV da Conta
                          fPadR      (' '                                  , 01, ' ') + //230 - 230  [19] DV da Agencia/Conta 5
                          fPadL      ('0'                                  , 01, '0') + //231 - 231  [19] Identidade da emissão do aviso para débito em conta - Preencher com zeros
                          fPadR      (' '                                  , 09, ' ') ; //232 - 240  [20] Uso Exclusivo FEBRABAN/CNAB


          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************MT*}
          Writeln(txtTexto,LSegmentoR);
        End;


        {*****************************}
        {* GRAVAÇÃO DA TABELA REMDET *}
        {**** DETALHES DA REMESSA ****}
        {**************************MO*}
        pGravaRemDet(strAutoIncremRem,
                     qryRemessa.FieldByName('AUTOINCREM').AsString,
                     IfThen(strRespons = 'E', qryRemessa.FieldByName('CBI_NOSNUM').AsString, '0'),
                     fltPerMul,
                     qryRemessa.FieldByName('CBI_VALDUP').AsFloat,
                     qryRemessa.FieldByName('CTR_DTAREC').AsDateTime,
                     qryRemessa.FieldByName('CBI_DTAVEN').AsDateTime,
                     VS_Date,
                     strLoginUsuarioLogado,
                     '');

        {****************}
        {* GRAVA LOGCTR *}
        {*************JS*}
        pGravaLogCtr(qryRemessa.FieldByName('CTR_NUMDUP').AsString,
                     qryRemessa.FieldByName('CTR_ESPDOC').AsString,
                     qryRemessa.FieldByName('CTR_CODCLI').AsString,
                     qryRemessa.FieldByName('CTR_CODEMP').AsString,
                     qryRemessa.FieldByName('CTR_PARCEL').AsString,
                     0,
                     'EXPORTAÇÃO DE ARQUIVO DE REMESSA - ' + strCodBco, Self.Name);

        qryRemessa.Next;
      End;

      {************}
      {* TRAILLER *}
      {*********AF*}

      intCodSeq := intCodSeq + 2;
      strTraillerLote := '';
      strTraillerLote :=  fPadR ('364'    ,003)    +//001 - 003 Código do Banco na compensação N 003 353 / 008 / 364
                          fPadL ('0001'   ,004,'0')+//004 - 007 Numero do lote remessa N 004 1
                          fPadR ('5'      ,001)    +//008 - 008 Tipo de registro N 001 5 2
                          fPadR (' '      ,009,' ')+//009 - 017 Reservado (uso Banco) N 009 Brancos
                          fPadL ('0'      ,006,'0')+//018 - 023 Quantidade de registros do lote - Preencher com zeros
                          fPadL ('0'      ,006,'0')+//024 - 029 Total de cobranças simples - Preencher com zeros
                          fPadL ('0'      ,017,'0')+//030 - 046 Valor das cobranças simples - Preencher com zeros
                          fPadL ('0'      ,006,'0')+//047 - 052 Total de cobranças vinculadas - Preencher com zeros
                          fPadL ('0'      ,017,'0')+//053 - 069 Valor das cobranças vinculadas - Preencher com zeros
                          fPadL ('0'      ,006,'0')+//070 - 075 Total de cobranças caucionadas - Preencher com zeros
                          fPadL ('0'      ,017,'0')+//076 - 092 Valor das cobranças caucionadas - Preencher com zeros
                          fPadL ('0'      ,006,'0')+//093 - 098 Total de cobranças descontadas - Preencher com zeros
                          fPadL ('0'      ,017,'0')+//099 - 115 Valor das cobranças descontadas - Preencher com zeros
                          fPadR (' '      ,008,' ')+//116 - 123 Número do aviso - Preencher com espaços
                          fPadR (' '      ,117,' ');// 124 - 240 Reservado (uso Banco) A 217 Brancos
      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {********LOTE**************AF*}
      Writeln(txtTexto,strTraillerLote);
      intCodSeq := intCodSeq + 2;
      strTrailler := '';
      strTrailler := fPadR ('364'                                     ,003)    +// 001 - 003 Código do Banco na compensação N 003 364
                     fPadR ('0001'                                    ,004)    +// 004 - 007 Numero do lote remessa N 004 1
                     fPadR ('9'                                       ,001)    +// 008 - 008 Tipo de registro N 001 9 2
                     fPadR (' '                                       ,009,' ')+// 009 - 017 Reservado (uso Banco) N 009 Brancos
                     fPadL ('1'                                       ,006,'0')+// 018 - 023 Quantidade de lotes do arquivo N 006 Registros tipo=1
                     fPadL (IntToStr(intCodSeq)                       ,006,'0')+// 024 - 029 Quantidade de registros do arquivo N 006 Registros tipo=0+1+2+3+5+9
                     fPadL ('0'                                       ,006,'0')+// 030 - 035 Quantidade de contas conciliadas- Preencher com zeros
                     fPadR (strToken                                  ,040,' ')+// 036 - 076 - Token para identificação de parceiro Gerencianet se existir
                     fPadR (' '                                       ,163,' ');// 077 - 240 Reservado (uso Banco) A 211 Brancos

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {********REMESSA***********AF*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      pApagarCADCBI;

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
		FreeAndNil(stlMensagem);

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
      FreeAndNil(stlMensagem);
		  pMensagensErro(E.Message,  '[untExpArqRemSantanderBan.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');
   End;
  End;

end;

procedure TfrmExpArqRemGerencianet240p.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If (fEmptyStr(edtCodPor.Text)) Then
    edtDesPor.Text := 'TODOS'
  Else
  Begin
    edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

    If Not CarregaPortador(edtCodPor.Text) Then
       pSetFocus(edtCodPor)
    Else
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

procedure TfrmExpArqRemGerencianet240p.edtCodPorKeyPress(Sender: TObject;var Key: Char);
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

function TfrmExpArqRemGerencianet240p.fCriarQueryRemessa: TUniQuery;
begin
  Result := Nil;
  Try
    Result:= fCriaQuery(Self);
    Result.Close;
    Result.SQL.Clear;
    Result.SQL.Add(fGetSqlRemessa);
    Result.ParamByName('CODBCO').AsString := strCodBco;

    If (Not fEmptyStr(edtCodPor.Text)) Then
      Result.ParamByName('CODPOR').AsString := edtCodPor.Text;

    IF (fCfgSis('CONREM', varString) = 'C') then
      Result.ParamByName('CARTEI').AsString := StrCartei;

    Result.Open;
  Except
  On E: Exception Do
   Begin
     pMensagensErro(E.Message, '[TfrmExpArqRemUnicred400_136.fCriarQueryRemessa]');
   End;
  End

end;

function TfrmExpArqRemGerencianet240p.fGetSqlRemessa: String;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  B.*, ';
  strSQL := strSQL + '  C.CLI_NOMCLI, ';
  strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
  strSQL := strSQL + '  R.CTR_NUMDUP, ';
  strSQL := strSQL + '  R.CTR_ESPDOC, ';
  strSQL := strSQL + '  R.CTR_CODCLI, ';
  strSQL := strSQL + '  R.CTR_CODEMP, ';
  strSQL := strSQL + '  R.CTR_PARCEL, ';
  strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
  strSQL := strSQL + '  R.CTR_DESCOB AS CTR_DESCOB, ';
  strSQL := strSQL + '  R.CTR_JURSUJ AS CTR_JURSUJ, ';
  strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", CONCAT(C.CLI_ENDERE, ", ", IFNULL(C.CLI_ENDNUM, ""), IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM))), C.CLI_ENDCOB) AS ENDERE, ';
  strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
  strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
  strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                   '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
  strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                   '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCBI B, ';
  strSQL := strSQL + '  CADCLI C, ';
  strSQL := strSQL + '  CADREC R ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CBI_CODBCO = :CODBCO AND ';
  strSQL := strSQL + '  CLI_CODCLI = CBI_CODCLI AND ';
  strSQL := strSQL + '  CTR_NUMDUP = CBI_NUMDUP AND ';
  strSQL := strSQL + '  CTR_PARCEL = CBI_PARCEL AND ';
  strSQL := strSQL + '  CTR_ESPDOC = CBI_ESPDOC AND ';
  strSQL := strSQL + '  CTR_CODEMP = CBI_CODEMP AND ';
  strSQL := strSQL + '  CTR_CODCLI = CBI_CODCLI AND ';
  strSQL := strSQL + '  CTR_DTAREC IS NULL ';

  If (Not fEmptyStr(edtCodPor.Text)) Then
    strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + ' AND (IFNULL(CBI_CODPOR, "") = "" ';
    strSQL := strSQL + ' OR LOCATE(CBI_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  if (fCfgSis('CONREM', varString) = 'C') THEN
    strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';
  Result := strSQL;
end;

function TfrmExpArqRemGerencianet240p.fRetEmpresa: String;
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

function TfrmExpArqRemGerencianet240p.fValidacoesParaExportacao: Boolean;
  Var
    blnRemLoc   : Boolean;
    strNovCodEmp: String;
begin
  Result := True;

  If Not fVerificaCampos Then
  Begin
    Result := False;
    Exit;
  End;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
  Begin
    Result := False;
    Exit;
  End;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fraPathRemessa.edtDirectory.text);
  If Not DirectoryExists(fraPathRemessa.edtDirectory.text) Then
  Begin
    fMensagem('Path:', 'Diretório inválido p\ exportação.', ['&O K'], 1, True);
    pSetFocus(fraPathRemessa);
    Result := False;
    Exit;
  End;
  {***************************************************
   * VERIFICA SE EXISTE A CONFIGURACAO PARA A GERA-  *
   * CAO DE REMESSA PARA TODAS AS EMPRESAS OU SOMEN- *
   * TE PARA A EMPRESA ATUAL(LOCAL)                  *
   ***********************************************ED*}
  blnRemLoc  := Not( fGetBancoConfig(0,strBanCfg, 'RELOCAL', '') = 'N' );;
  strNomEmp  := fRetNomeEmpresa(VS_strCodEmp);

  strNovCodEmp := VS_strCodEmp;
  If Not( blnRemLoc ) Then
    strNovCodEmp := fRetEmpresa;  //Abre bloco para escolher a empresa
  strNomEmp := fRetNomeEmpresa(strNovCodEmp);
  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Result := False;
    Exit;
  End;
end;


procedure TfrmExpArqRemGerencianet240p.pApagarCADCBI;
  Var
   qryAux : TUniQuery;
   strSQL : String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  CADCBI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';
    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';
    IF (fCfgSis('CONREM', varString) = 'C') then
      strSQL := strSQL + '  AND CBI_CARTEI = :CARTEI ';
    qryAux := fCriaQuery(Self);
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(edtCodPor.Text)) Then
        qryAux.ParamByName('CODPOR').AsString := edtCodPor.Text;

      IF (fCfgSis('CONREM', varString) = 'C') then
        qryAux.ParamByName('CARTEI').AsString := StrCartei;

      qryAux.ExecSQL;
      qryAux.Close;
    Except
    On E: Exception Do
      Begin
         pMensagensErro(E.Message, '[TfrmExpArqRemUnicred400_136.fCriarQueryRemessa]');
      End;
    End;
  Finally
    pFreeAndNil(qryAux);
  End;
end;

procedure TfrmExpArqRemGerencianet240p.pValidaInformacoesCarteira;
begin
  If (Pos(LeftStr(strCodPro,1),'1_2_') <= 0) Then
    strDiaPro := '0';

  If (LeftStr(strCodBaixa,1) <> '1') Then
    strDiasBaixa := '0';
end;

procedure TfrmExpArqRemGerencianet240p.pValidaInformacoesRemessa;
begin
  If qryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 1 Then
    strCpfCgc := '2'
  Else
    strCpfCgc := '1';

  If intQtdPar > 1 then
    strEhCarne := '001'
  Else
    strEhCarne := '000';

  If fCfgSis('VALIMP', varBoolean) then
  begin
    fltValDup := fltValDup + qryRemessa.FieldByName('CTR_JURSUJ').AsFloat +
                             qryRemessa.FieldByName('CTR_DESCOB').AsFloat;
  end;

end;

procedure TfrmExpArqRemGerencianet240p.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemGerencianet240p.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;
end.
