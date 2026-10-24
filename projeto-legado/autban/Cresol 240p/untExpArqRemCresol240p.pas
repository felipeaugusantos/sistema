unit untExpArqRemCresol240p;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, untCadRec, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemCresol240p = class(TfrmPai)
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
	
	const strBanCfg: String = 'CONFIG133-';

    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
    
  end;

var
  frmExpArqRemCresol240p: TfrmExpArqRemCresol240p;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutban, Data.DB,untConsultas,untTypesSistema,
 System.DateUtils;

{$R *.dfm}

procedure TfrmExpArqRemCresol240p.FormShow(Sender: TObject);
var
  strCodPorRem: String;
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yy',VS_Date),2) +
                         fStrZero(FormatDateTime('hh',fTime()),2) +
                         fStrZero(FormatDateTime('nn',fTime()),2) +
                         fStrZero(FormatDateTime('ss',fTime()),2) +
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

procedure TfrmExpArqRemCresol240p.btnGerarClick(Sender: TObject);
  Var
    strSQL      : String;
    strNomBco   : String;
    strCodTrans  : String;
    strContCor  : String;
    strDigCtaC  : String;
    LDVContaAgencia : String;
    strDigAgeC  : String;
    strNumAgeC  : String;
    strContCob  : String;
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
    //strNomeBen  : String;
    intCodSeq   : Integer;
    fltValTot   : Double;
    fltValMora  : Double;
    txtTexto    : TextFile;
    strCompl    : String;
    strCodRem   : String;
    strFilePath : String;
    strAutoIncremRem: String;
    strCartSeq  : String;
    strDtaVenMulta: String;
    dtaDtaVenMulta: TDateTime;
    fltPerMul   : Double;
    strPerMul : String;
    strEsp_ID : String;
    strNomEmp : String;
    strHraRem : String;
    strNomCli : String;
    strCodConv : String;
begin
  inherited;

  If Not fValidacoesParaExportacao Then
    Exit;

  strCodBco  := '133';
  strNomBco  := 'Cresol';
  strCodTrans := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODTRANS', '');
  strCodAgen := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIGAGEN', '');
  strDigCorr := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIGCORR', '');
  strCodCar  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIAPROT', '');
  strContCor := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'NUMCTAC', '');

  strDigAgeC := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIGAGEC', '');
  strDigCtaC := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIGCTAC', '');

  strNumAgeC   := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'NUMAGEC', '');
  strCodMov    := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODMOV', '');
  strTipoCob   := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'TIPOCOB', '');
  strFormaCad  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'FORMACAD', '');
  strCodBaixa  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODBAIXA', '');
  strDiasBaixa := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'DIABAIXA', '');
  strTipoDoc   := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'TIPODOC', '');
  strCodPro    := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODPRO', '');
  strCodConv   := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CODCONV', '');
  strEsp_ID    := Copy(fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'ESPDOC_', '02'), 1, 2);
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

  strContCob := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'NUMCTAB', '');

  strCompl   := fStrZero(RightStr(fTiraCaracEspeciais(strContCob, True),2), 02);
  strContCob := LeftStr(strContCob, 8);

  strRespons := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'RESPONS', '');
  strDtaRem  := FormatDateTime('ddmmyyyy',VS_Date);
  strHraRem :=  FormatDateTime('hhnnss', fTime());

  strSacAva  := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'SACAVAL', '');
  //strCnpjBen := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'CNPJBEN', '');
  //strNomeBen := fGetBancoConfig(0, strBanCfg + IntToStr(intCartei), 'NOMEBEN', '');


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
    strNomEmp := qryConsultaGen.FieldByName('EMP_NOMEMP').AsString;
    qryConsultaGen.Close;

    strCnpjBen := strCgcEmp;

    If (Length(strNomEmp) > 30) Then
      strNomEmp := LeftStr(strNomEmp, 30);


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
      strHeader := fPadR   ('133'              , 003)     +//  001 - 003 Código do Banco na Compensação 003 133
                   fPadR   ('0000'             , 004)     +//  004 - 007 Lote de Serviço 004 0000
                   fPadR   ('0'                , 001)     +//  008 - 008 Tipo de Registro 001 0
                   fPadR   (' '                , 009,' ') +//  009 - 017   Brancos 009
                   fPadR   ('2'                , 001)     +//  018 - 018 Tipo de inscrição da empresa N 001 1 = CPF, 2 = CNPJ
                   fPadL   (fTiraCaracEspeciaisPonto(strCnpjBen), 014,'0') +// 019 - 032 Número de Inscrição da Empresa 014 (CPF/CNPJ do Cooperado)
                   fPadL   (strCodConv         , 020,'0') +//  033 - 052 Número do convênio de cobrança CRESOL 020 Número da conta do cooperado
                   fPadL   (strCodAgen         , 005,'0') +//  053 - 057 AG Mantedora da Conta 005 Código da cooperativa
                   fPadL   (strDigAgen         , 001,'0') +//  058 - 058 Dígito Verificador da Agência 001 0 (no convênio Confederação)
                   fPadL   (strContCor         , 012,'0') + // 059 - 070 Número da Conta Corrente 012 Número da conta corrente
                   fPadR   (strDigCtaC         , 001,'0') +//  071 - 071 Dígito Verificador da Conta 002 Dígito Conta Corrente Cresol
                   fPadR   (LDVContaAgencia    , 001)     +//  072 - 072 Dígito Verificador da Ag/Conta 001 Branco
                   fPadR   (strNomEmp          , 030,' ') +//  073 - 102 Nome da Empresa 030 Nome da Empresa
                   fPadR   ('CRESOL CONFEDERAÇÃO', 030,' ')+// 103 - 132 Nome do Banco 030 CRESOL CONFEDERAÇÃO
                   fPadR   (' '                , 010,' ') + // 133 - 142 Uso Exclusivo FEBRABAN / 010 Brancos
                   fPadR   ('1'                , 001,' ') + // 143 - 143 Código Remessa / Retorno 001 1
                   fPadR   (strDtaRem          , 008,'0') + // 144 - 151 Data de Geração do Arquivo 008 no formato ddmmaaaa
                   fPadR   (strHraRem          , 006,'0') + // 152 - 157 Hora de Geração do Arquivo 0006 no formato HHMMSS
                   fPadL   (IntToStr(intCodSeq), 006,'0') + // 158 - 163 Número Sequencial do Arquivo 006 Zeros
                   fPadL   ('084'              , 003,'0') + // 164 - 166 N o da Versão do Layout do Arquivo 003 084
                   fPadR   ('00000'            , 005,'0') + // 167 - 171 Densidade de Gravação do Arquivo 005 00000
                   fPadR   (' '                , 020,' ') + // 172 - 191 Para Uso Reservado do Banco 020 Brancos
                   fPadR   (' '                , 020,' ') + // 192 - 211 Para Uso Reservado da Empresa 020 Brancos
                   fPadR   (' '                , 029,' ');  // 212 - 240 Uso Exclusivo FEBRABAN / CNAB 029 Brancos

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {******************}
      {* HEADER DO LOTE *}
      {***************AF*}
      Inc(intCodSeq);
      strHeaderLote := '';
      strHeaderLote := fPadR   ('133'              , 003)     +// 001 - 003 Código do Banco na compensação N 003 133
                       fPadL   ('1'                , 004,'0') +// 004 - 007 Numero do lote remessa N 004 1
                       fPadR   ('1'                , 001)     +// 008 - 008 Tipo de registro N 001 1
                       fPadR   ('R'                , 001)     +// 009 - 009 Tipo de operação A 001 R (Remessa)
                       fPadR   ('01'               , 002)     +// 010 - 011 Tipo de serviço N 002 01 (Cobrança)
                       fPadR   (' '                , 002,' ') +// 012 - 013 Reservado (uso Banco) A 002 Brancos
                       fPadR   ('042'              , 003)     +// 014 - 016 Nº da versão do layout do lote N 003 042
                       fPadR   (' '                , 001,' ') +// 017 - 017 Reservado (uso Banco) A 001 Branco
                       fPadR   ('2'                , 001)     +// 018 - 018 Tipo de inscrição da empresa N 001 1 = CPF, 2 = CNPJ
                       fPadL   (fTiraCaracEspeciaisPonto(strCnpjBen), 015,'0') +// 019 - 033 Nº de inscrição da empresa N 015
                       fPadR   (strContCor         , 020,' ') +// 034 - 053 Código do Convênio no Banco 020 Número da conta do cooperado
                       fPadL   (strCodAgen         , 005,'0') +// 054 - 058 Agência Mantenedora da Conta 005 Código da Cooperativa
                       fPadL   (strDigAgen         , 001,'0') +// 059 - 059 Dígito Verificador da AG 001 0
                       fPadL   (strContCor         , 012,'0') +// 060 - 071 Número da Conta Corrente 012 Número da conta corrente na Cresol
                       fPadR   (strDigCtaC         , 001,'0') +// 072 - 072 Dígito Verificador da Conta 001 Dígito Conta Corrente Cresol
                       fPadR   (LDVContaAgencia    , 001,' ') +// 073 - 073 Dígito Verificador da Ag/Conta 001 Branco
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
      {**************************MF*}
      pGravaRemGer(VS_strCodEmp, strCodBco, StrCartei, StrToInt(strCodRem), strAutoIncremRem);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {* SEGMENTO P           *}
      {*********************MF*}
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

        strKeyDup := qryRemessa.FieldByName('CBI_NUMDUP').AsString +
                     qryRemessa.FieldByName('CBI_PARCEL').AsString +
                     TEspecieParaArquivoRemessa.New.fRetornaIndiceParaEspecie(qryRemessa.FieldByName('CBI_ESPDOC').AsString) +
                     qryRemessa.FieldByName('CBI_CODEMP').AsString +
                     qryRemessa.FieldByName('CBI_CODCLI').AsString;

        strCgcCli := Trim(qryRemessa.FieldByName('CBI_C_G_C_').AsString);

        fltValDup := qryRemessa.FieldByName('CBI_VALDUP').AsFloat;

        strNomCli := qryRemessa.FieldByName('CLI_NOMCLI').AsString;

        pValidaInformacoesRemessa;
        Inc(intCodSeq);
        strSegmentoP := '';
        strSegmentoP :=  fPadR ('133'                       ,003)    + // 001 - 003 Código do Banco na compensação N 003 133
                         fPadL ('0001'                      ,004,'0')+ // 004 - 007 Numero do lote remessa N 004 1
                         fPadR ('3'                         ,001)    + // 008 - 008 Tipo de registro N 001 3 2
                         fPadL (IntToStr(intCodSeq)         ,005,'0')+ // 009 - 013 Nº seqüencial do registro de lote N 005 11
                         fPadR ('P'                         ,001)    + // 014 - 014 Cód. Segmento do registro detalhe A 001 P 13
                         fPadR (' '                         ,001)    + // 015 - 015 Reservado (uso Banco) A 001 Brancos
                         fPadL (LeftStr(strCodMov, 2)       ,002,'0')+ // 016 - 017 Código de movimento remessa N 002 14
                         fPadL (strCodAgen                  ,005,'0')+ // 018 - 022 Ag Mantenedora da Conta 005 Código da Cooperativa
                         fPadR (strDigAgen                  ,001)    + // 023 - 023 Dígito Verificador da Ag 1 0
                         fPadL (strContCor                  ,012,'0')+ // 024 - 035 Número da Conta Corrente 012 Número da conta correntena Cresol
                         fPadR (strDigCorr                  ,001)    + // 036 - 036 Dígito Verificador da Conta 001 Dígito Conta Corrente Cresol
                         fPadR (LDVContaAgencia             ,001)    + // 037 - 037 Dígito Verificador da Ag/Conta 001 Branco
                         fPadR ('000'                       ,003)    + // 038 - 040 Identific. do Produto 003 Zeros
                         fPadR ('00000'                     ,005)    + // 041 - 045 Zeros 005
                         fPadL (qryRemessa.FieldByName('CBI_NOSNUM').AsString ,012,'0')+// 046 - 056 Nosso Número 011 + 057 - 057 Digito do nosso Número 001
                         fPadL (Copy(strCodCar, 2, 1)       ,001)    + // 058 - 058 Código da Carteira 001 Zero
                         fPadR (LeftStr(strFormaCad, 1)     ,001)    + // 059 - 059 Forma de Cadastr. do Título no Banco 001 Zeros
                         fPadR (LeftStr(strTipoDoc, 1)      ,001,'0')+ // 060 - 060 Tipo de Documento 001 Zeros
                         fPadR ('1'                         ,001)    + // 061 - 061 Identific. da Emissão do Bloqueto 001 “1” = Banco Emitente
                         fPadR ('1'                         ,001)    + // 062 - 062 Identific. da Distribuição 001
                         fPadL (qryRemessa.FieldByName('CBI_NUMDUP').AsString ,015,'0')+ // 063 - 077 Número Doc. De Cobrança 015
                         fPadL (strDtaVen                   ,008,'0')+ // 078 - 085 Data de Vencimento 008 no formato ddmmaaaa
                         fValNumForm(fltValDup              ,015)    + // 086 - 100 Valor Nominal do Título 015 com duas casas decimais
                         fPadL (strNumAgeC                  ,005,'0')+ // 101 - 105 Agência Encarregada da Cobrança 005 Zeros
                         fPadL (strDigAgeC                  ,001,'0')+ // 106 - 106 Dígito Verificador da Agência 001 Branco
                         fPadL (strEsp_ID                   ,002,'0')+ // 107 - 108 Espécie do Título 002
                         fPadR ('N'                         ,001)    + // 109 - 109 Identific. de Título Aceito/Não Aceito 001
                         fPadL (strDtaEmi                   ,008,'0')+ // 110 - 117 Data da Emissão do Título 008 no formato ddmmaaaa
                         fPadR ('1'                         ,001)    + // 118 - 118 Código do Juros de Mora 001 1 - (real ao dia) 2 – Percentual ao mês
                         fPadL (strDtaVen                   ,008,'0')+ // 119 - 126 Data do Juros de Mora 008 no formato ddmmaaaa
                         fValNumForm(fltValMora             ,015)    + // 127 - 141 Juros de Mora por Dia/Taxa 015 com duas casas decimais
                         fPadL ('0'                         ,001)    + // 142 - 142 Código do Desconto 001
                         fPadL ('0'                         ,008,'0')+ // 143 - 150 Data do Desconto 081 no formato ddmmaaaa
                         fPadL ('0'                         ,015,'0')+ // 151 - 165 Valor do Desconto 015 com duas casas decimais
                         fPadL ('0'                         ,015,'0')+ // 166 - 180 Valor do IOF a ser Recolhido 015
                         fPadL ('0'                         ,015,'0')+ // 181 - 195 Valor do Abatimento 015
                         fPadR (strKeyDup                   ,025,' ')+ //196 - 220 Identific. do Título na Empresa 025 (somente relevante com ocorrência=1)
                         fPadR (LeftStr(strCodPro, 1)       ,001,'0')+ // 221 - 221 Código para Protesto 001
                         fPadL (strDiaPro                   ,002,'0')+ // 222 - 223 Nº de Dias para Protesto 002
                         fPadR (LeftStr(strCodBaixa, 1)     ,001,'0')+ // 224 - 224 Código p/ Baixa/Devolução 001
                         fPadR (strDiasBaixa                ,003,'0')+ // 225 - 227 Número de Dias para Baixa/Devolução 003
                         fPadR ('09'                        ,002)    + // 228 - 229 Código da Moeda 002 09
                         fPadL ('0'                         ,011,'0'); // 230 - 240 Zeros 011

        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {* SEGMENTO P               MF*}
        Writeln(txtTexto,strSegmentoP);

        Inc(intCodSeq);
        strSegmentoQ := '';
        strSegmentoQ := fPadR ('133'                                     ,003)    + // 001 - 003 Código do Banco na compensação N 003 133
                        fPadL ('0001'                                    ,004,'0')+ // 004 – 007 Lote de Serviço 004 informar o número do lote ao qual pertence o registro
                        fPadR ('3'                                       ,001)    + // 008 - 008 Tipo de registro N 001 3 2
                        fPadL (IntToStr(intCodSeq)                       ,005,'0')+ // 009 - 013 Nº seqüencial do registro no lote N 005 11
                        fPadR ('Q'                                       ,001)    + // 014 - 014 Cód. segmento do registro detalhe A 001 Q 13
                        fPadR (' '                                       ,001,' ')+ // 015 - 015 Reservado (uso Banco) A 001 Brancos
                        fPadR (LeftStr(strCodMov, 2)                     ,002,'0')+ // 016 - 017 Código de movimento remessa N 002 14
                        fPadR (strCpfCgc                                 ,001)    + // 018 - 018 Tipo de inscrição do Pagador N 001 30
                        fPadL (strCgcCli                                 ,015,'0') +// 019 - 033 Número de inscrição do Pagador N 015 30
                        fPadR (strNomCli                                 ,040,' ')+//  034 - 073 Nome Pagador A 040
                        fPadR (qryRemessa.FieldByName('ENDERE').AsString ,040,' ')+//  074 - 113 Endereço Pagador A 040 29
                        fPadR (qryRemessa.FieldByName('BAIRRO').AsString ,015,' ')+//  14 - 128 Bairro Pagador A 015 29
                        fPadL (LeftStr(qryRemessa.FieldByName('C_E_P_').AsString,5) ,005,'0')+//  129 - 133 Cep Pagador N 005 29
                        fPadL (RightStr(qryRemessa.FieldByName('C_E_P_').AsString,3),003,'0')+//  134 - 136 Sufixo do Cep do Pagador N 003 29
                        fPadR (qryRemessa.FieldByName('CIDADE').AsString            ,015, ' ') + // 137 - 151 Cidade do Pagador A 015 29
                        fPadR (qryRemessa.FieldByName('ESTADO').AsString            ,002, ' ') + // 152 - 153 Unidade da Federação do Pagador A 002 29
                        fPadR (IIF(strSacAva <> 'S','0','2')                        ,001)    +//  154 - 154 Tipo de inscrição Sacador/avalista N 001 30
                        fPadL (IIF(strSacAva <> 'S','0',strCgcEmp)                  ,015,'0')+//  155 - 169 Nº de inscrição Sacador/avalista N 015 30
                        fPadR (IIF(strSacAva <> 'S',' ',strNomEmp)                  ,040,' ')    +//  170 - 209 Nome do Sacador/avalista A 040 31
                        fPadL ('0'                                       ,003,'0') + //210 - 212 Cód. Bco. Corresp. na Compensação 003 Zeros
                        fPadR (' '                                       ,020,' ') + // Nosso Nº no Banco Correspondente 020 Brancos
                        fPadR (' '                                       ,008,' '); //233 - 240 Uso Exclusivo FEBRABAN/CNAB 008 Brancos


        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {*****SEGMENTO Q************MF*}
        Writeln(txtTexto,strSegmentoQ);

        If fltPerMul > 0 Then
        Begin
          {************************}
          {* TRANSAÇÃO SEGMENTO R *}
          {*********************MF*}
          Inc(intCodSeq);
          LSegmentoR := '';
          LSegmentoR   := fPadR      ('133'                      , 03, ' ') + //001 - 003  [01] Código do Banco na Compensação
                          fPadR      ('0001'                     , 04, ' ') + //004 - 007  [02] Lote de Serviço
                          fPadL      ('3'                        , 01, ' ') + //008 - 008  [03] Tipo de Registro
                          fStrZero   (IntToStr(intCodSeq)        , 05)      + //009 - 013  [04] Nº Sequencial do Registro no Lote
                          fPadL      ('R'                        , 01, ' ') + //014 - 014  [05] Cód. Segmento do Registro Detalhe
                          fPadL      (' '                        , 01, ' ') + //015 - 015  [06] Uso Exclusivo FEBRABAN/CNAB
                          fPadL      ('01'                       , 02, '0') + //016 - 017  [07] Código de Movimento Remessa
                          fPadL      ('0'                        , 01, '0') + //018 - 018  [08] Código do Desconto 2
                          fPadR      ('0'                        , 08, '0') + //019 - 026  [09] Data do Desconto 2
                          fPadL      ('0'                        , 15, '0') + //027 - 041  [10] Valor/Percentual a ser concedido
                          fPadL      ('0'                        , 01, '0') + //042 - 042  [11] Código do Desconto 3
                          fPadL      ('0'                        , 08, '0') + //043 - 050  [12] Data do Desconto 3
                          fPadL      ('0'                        , 15, '0') + //051 - 065  [13] Valor/Percentual a Ser Concedido
                          fPadR      ('2'                        , 01, ' ') + //066 - 066  [14] Código da Multa
                          fPadR      (strDtaVenMulta             , 08, '0') + //067 - 074  [15] Data da Multa
                          fStrZero   (strPerMul                  , 15)      + //075 - 089  [16] Valor/Percentual a Ser Aplicado
                          fPadR      (' '                        , 10, ' ') + //090 - 099  [17] Informação ao Pagador
                          fPadR      (' '                        , 40, ' ') + //100 - 139  [18] Mensagem 3
                          fPadR      (' '                        , 40, ' ') + //140 - 179  [19] Mensagem 4
                          fPadR      (' '                        , 20, ' ') + //180 - 199 Uso Exclusivo FEBRABAN/CNAB 020 Branco
                          fPadL      ('0'                        , 08, '0') + //200 - 207 Cód. Ocor. do Pagador 008 Zeros
                          fPadL      ('0'                        , 03, '0') + //208 - 210 Cód. do Banco na Conta do Débito 003 Zeros
                          fPadL      ('0'                        , 05, '0') + //211 - 215 Código da Ag. do Débito 005 Zero
                          fPadL      (' '                        , 01, ' ') + //216 - 216 Dígito Verificador da Agência 001 Branco
                          fPadL      ('0'                        , 12, '0') + //217 - 228 Conta Corrente para Débito 012 Zeros
                          fPadL      (' '                        , 01, ' ') + //229 - 229 Dígito Verificador da Conta 001 Branco
                          fPadL      (' '                        , 01, ' ') + //230 - 230 Dígito Verificador Ag/Conta 001 Branco
                          fPadL      ('0'                        , 01, '0') +//231 - 231 Aviso para Débito Automático Zeros
                          fPadL      (' '                        , 09, ' ') ; //232 - 240 Uso Exclusivo FEBRABAN/CNAB 009 Brancos


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

      {********************}
      {* TRAILLER DO LOTE *}
      {******************MF*}

      intCodSeq := intCodSeq + 2;
      strTraillerLote := '';

      strTraillerLote := fPadR ('133'                    ,003)    + // 001 - 003 Código do Banco na compensação N 003 353 / 008 / 133
                         fPadL ('0001'                   ,004,'0')+ // 004 - 007 Numero do lote remessa N 004 1
                         fPadR ('5'                      ,001)    + // 008 - 008 Tipo de registro N 001 5 2
                         fPadR (' '                      ,009,' ')+ // 009 - 017 Reservado (uso Banco) N 009 Brancos
                         fPadL (IntToStr(intCodSeq)      ,006,'0')+ // 018 - 023 Quantidade de registros do lote N 006 38
                         fPadL ('0'                      ,092,'0')+ // 024 - 115 Zeros 092
                         fPadR (' '                      ,125,' '); // 116 - 240 Brancos 125

      Writeln(txtTexto,strTraillerLote);

      intCodSeq := intCodSeq + 2;
      strTrailler := '';
      strTrailler := fPadR ('133'                         ,003)    +// 001 - 003 Código do Banco na compensação N 003 133
                     fPadR ('9999'                        ,004)    +// 004 – 007 Lote de Serviço 004 9999
                     fPadR ('9'                           ,001)    +// 008 - 008 Tipo de Registro 001 9
                     fPadR (' '                           ,009,' ')+// 009 - 017 Reservado (uso Banco) N 009 Brancos
                     fPadL ('1'                           ,006,'0')+// 018 - 023 Quantidade de Lotes do Arquivo 006 informar quantos lotes o arquivo possui
                     fPadL (IntToStr(intCodSeq)           ,006,'0')+// 024 - 029 Quantidade de Registros do Arquivo 006 quantidade igual ao número total de registros (linhas) do arquivo
                     fPadR ('0'                           ,006,'0')+// 030 - 035 Zeros 006 Zeros
                     fPadR (' '                           ,205,' ');// 036 - 240 Branco 205 Branco

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {********REMESSA***********MF*}
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
		  pMensagensErro(E.Message,  '[untExpArqRemCresol240p.btnGerarClick]','Ocorreu um erro durante a exportação do arquivo. Para tentar novamente por favor fechar o sistema.');
   End;
  End;

end;

procedure TfrmExpArqRemCresol240p.edtCodPorExit(Sender: TObject);
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

procedure TfrmExpArqRemCresol240p.edtCodPorKeyPress(Sender: TObject;var Key: Char);
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

function TfrmExpArqRemCresol240p.fCriarQueryRemessa: TUniQuery;
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
     pMensagensErro(E.Message, '[TfrmExpArqRemCresol240p.fCriarQueryRemessa]');
   End;
  End

end;

function TfrmExpArqRemCresol240p.fGetSqlRemessa: String;
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

function TfrmExpArqRemCresol240p.fRetEmpresa: String;
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

function TfrmExpArqRemCresol240p.fValidacoesParaExportacao: Boolean;
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
  blnRemLoc  := Not( fGetBancoConfig(0,'CONFIG033B240p', 'RELOCAL', '') = 'N' );;
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


procedure TfrmExpArqRemCresol240p.pApagarCADCBI;
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

procedure TfrmExpArqRemCresol240p.pValidaInformacoesCarteira;
begin
  If (Pos(LeftStr(strCodPro,1),'1_2_') <= 0) Then
    strDiaPro := '0';

  If (LeftStr(strCodBaixa,1) <> '1') Then
    strDiasBaixa := '0';
end;

procedure TfrmExpArqRemCresol240p.pValidaInformacoesRemessa;
begin
  If qryRemessa.FieldByName('CBI_CGCCPF').AsInteger = 1 Then
    strCpfCgc := '2'
  Else
    strCpfCgc := '1';

  If fCfgSis('VALIMP', varBoolean) then
  begin
    fltValDup := fltValDup + qryRemessa.FieldByName('CTR_JURSUJ').AsFloat +
                             qryRemessa.FieldByName('CTR_DESCOB').AsFloat;
  end;

end;

procedure TfrmExpArqRemCresol240p.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemCresol240p.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;
end.
