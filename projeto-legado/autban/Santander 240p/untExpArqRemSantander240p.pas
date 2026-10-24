unit untExpArqRemSantander240p;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Buttons, ExtCtrls, StrUtils, Mask,
  DirectoryEditFocus, Menus, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, untCadRec, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, untFrameDirectoryEditFocus;

type
  TfrmExpArqRemSantander240p = class(TfrmPai)
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

    { Private declarations }
  public
    { Public declarations }
    intCartei: Integer;
    strNomForm : String;
    
  end;

var
  frmExpArqRemSantander240p: TfrmExpArqRemSantander240p;

implementation

uses untFuncoes, untfuncoesSimples, untFuncAutban, Data.DB,untConsultas,untTypesSistema,
 System.DateUtils;

{$R *.dfm}

procedure TfrmExpArqRemSantander240p.FormShow(Sender: TObject);
begin
  inherited;

  fraPathRemessa.edtDirectory.text := fVerBarraFinal(fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'PATHREM',''));
  edtNomArquivo.Text  := 'RM' +
                         fStrZero(FormatDateTime('dd',VS_Date),2) +
                         fStrZero(FormatDateTime('mm',VS_Date),2) +
                         fStrZero(FormatDateTime('yy',VS_Date),2) +
                         '.TXT';
  pSetFocus(edtCodPor);

end;

procedure TfrmExpArqRemSantander240p.btnGerarClick(Sender: TObject);
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
    strInstru1  : String;
    strInstru2  : String;
    strAgenCob  : String;
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
    strCompl    : String;
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
begin
  inherited;

  If Not fValidacoesParaExportacao Then
    Exit;

  strCodBco  := '033';
  strNomBco  := 'SANTANDER';
  strCodTrans := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'CODTRANS', '');
  strCodAgen := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'CODAGEN', '');
  strDigAgen := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'DIGAGEN', '');
  strDigCorr := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'DIGCORR', '');
  strCodCar  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'CODCART', '');
  strDiaPro  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'DIAPROT', '');
  strContCor := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'NUMCTAC', '');

  // deixa assim porque no cadastro os campos também está alterado, o digitado
  // da agencia está sendo gravado no digito da conta corrente
  // vice versa.
  strDigCtaC := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'DIGAGEC', '');
  strDigAgeC := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'DIGCTAC', '');

  strNumAgeC := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'NUMAGEC', '');
  strCodMov  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'CODMOV', '');
  strTipoCob  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'TIPOCOB', '');
  strFormaCad  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'FORMACAD', '');
  strCodBaixa  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'CODBAIXA', '');
  strDiasBaixa  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'DIASBAIXA', '');
  strTipoDoc  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'TIPODOC', '');
  strCodPro  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'CODPRO', '');
  LDVContaAgencia := '';

  If Length(strDigCtaC) = 2 Then
  Begin
    LDVContaAgencia := RightStr(strDigCtaC,1);
    strDigCtaC := LeftStr(strDigCtaC,1);
  End;

  fltPerMul  := fStrToFloat(fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'PERMULT', ''));
  strPerMul  := '0';

  If fltPerMul > 0 Then
  Begin
    strPerMul := FormatFloat('###,##0.00', fltPerMul);
    strPerMul := fTiraCaracEspeciais(strPerMul);
  End;

  //DEVE SER CONFIGURADO A CONTA DE COBRANCA 8 POSICOES E O COMPLEMENTO 2 POSICOES
  strContCob := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'NUMCTAB', '');

  strCompl   := fStrZero(RightStr(fTiraCaracEspeciais(strContCob, True),2), 02);
  strContCob := LeftStr(strContCob, 8);

  strRespons := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'RESPONS', '');
  strDtaRem  := FormatDateTime('dd',VS_Date) + FormatDateTime('mm',VS_Date) + FormatDateTime('yyyy',VS_Date);

  strInstru1 := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'INSTRU1', '');
  strInstru2 := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'INSTRU2', '');
  strAgenCob := '00000';
  strSacAva  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'SACAVAL', '');
  strCnpjBen := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'CNPJBEN', '');
  strNomeBen := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'NOMEBEN', '');
  strMsg1    := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'OBSERV1', '');
  strMsg2    := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'OBSERV2', '');

  pValidaInformacoesCarteira;
  Try
    fStartTransaction;

    stlMensagem    := TStringList.Create;
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
    strCgcEmp := qryConsultaGen.FieldByName('EMP_C_G_C_').AsString;
    qryConsultaGen.Close;


    strCartei := 'CONFIG033B240p-' + IntToStr(intCartei) + '-' + VS_strCodEmp;
    qryRemessa := fCriarQueryRemessa;

    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, fraPathRemessa.edtDirectory.text + edtNomArquivo.Text);
      strFilePath := fraPathRemessa.edtDirectory.text + edtNomArquivo.Text;
      Rewrite(txtTexto);

      strCartSeq := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'SEQCART', '');
      strCodRem  := fStrZero(fAtuCodSeq('CONFIG033B240p-' + IIF(fEmptyStr(strCartSeq), IntToStr(intCartei), strCartSeq), 'PROXNUM'), 6);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AF*}
      intCodSeq := 1;
      strHeader := '';
      strHeader := fPadR   ('033'              , 003)     +//   001 - 003 Código do Banco na compensação N 003 33
                   fPadR   ('0000'             , 004)     +//   004 - 007 Lote de serviço N 004 0000 1
                   fPadR   ('0'                , 001)     +//   008 - 008 Tipo de registro N 001 0 2
                   fPadR   (' '                , 008,' ')  +//   009 - 016 Reservado (uso Banco) A 008 Brancos
                   fPadR   ('2'                , 001)     +//   017 - 017 Tipo de inscrição da empresa N 001 1 = CPF, 2 = CNPJ
                   fPadL   (IIF(strSacAva <> 'S', strCgcEmp, fTiraCaracEspeciaisPonto(strCnpjBen)), 015,'0') +//   018 – 032 Nº de inscrição da empresa N 015
                   fPadL   (strCodTrans        , 015,'0') +//   033 – 047 Código de Transmissão N 015 3
                   fPadR   (' '                , 025,' ') +//   048 - 072 Reservado (uso Banco) A 025 Brancos
                   fPadR   (IIF(strSacAva <> 'S', strNomEmp, strNomeBen), 030,' ') +//   073 - 102 Nome da empresa A 030
                   fPadR   ('Banco Santander'  , 030,' ') +//   103 - 132 Nome do Banco A 030 Banco Santander
                   fPadR   (''                 , 010,' ') +//   133 - 142 Reservado (uso Banco) A 010 Brancos
                   fPadR   ('1'                , 001)     +//   143 - 143 Código remessa N 001 1 = Remessa
                   fPadR   (strDtaRem          , 008)     +//   144 - 151 Data de geração do arquivo N 008 DDMMAAAA
                   fPadR   (' '                , 006,' ') +//   152 - 157 Reservado (uso Banco) A 006 Brancos
                   fPadL   (IntToStr(intCodSeq), 006,'0') +//   158 - 163 Nº seqüencial do arquivo N 006 4
                   fPadR   ('040'              , 003)     +//   164 - 166 Nº da versão do layout do arquivo N 003 040
                   fPadR   (' '                , 074,' '); //  167 - 240 Reservado (uso Banco) A 074 Brancos

      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AF*}
      Writeln(txtTexto,strHeader);

      {******************}
      {* HEADER DO LOTE *}
      {***************AF*}
      strHeaderLote := '';
      strHeaderLote := fPadR   ('033'              , 003)     +//   001 - 003 Código do Banco na compensação N 003 033
                       fPadL   (IntToStr(intCodSeq), 004,'0') +//   004 - 007 Numero do lote remessa N 004 1
                       fPadR   ('1'                , 001)     +//   008 - 008 Tipo de registro N 001 1 2
                       fPadR   ('R'                , 001)     +//   009 - 009 Tipo de operação A 001 R (Remessa)
                       fPadR   ('01'               , 002)     +//   010 - 011 Tipo de serviço N 002 01 (Cobrança)
                       fPadR   (' '                , 002,' ') +//   012 - 013 Reservado (uso Banco) A 002 Brancos
                       fPadR   ('030'              , 003)     +//   014 - 016 Nº da versão do layout do lote N 003 030
                       fPadR   (' '                , 001,' ') +//   017 - 017 Reservado (uso Banco) A 001 Brancos
                       fPadR   ('2'                , 001)     +//   018 - 018 Tipo de inscrição da empresa N 001 1 = CPF, 2 = CNPJ
                       fPadL   (IIF(strSacAva <> 'S', strCgcEmp, fTiraCaracEspeciaisPonto(strCnpjBen)), 015,'0') +//   019 - 033 Nº de inscrição da empresa N 015
                       fPadR   (' '                , 020,' ') +//   034 – 053 Reservado (uso Banco) A 020 Brancos
                       fPadL   (strCodTrans        , 015,'0') +//   054 - 068 Código de Transmissão N 015 3
                       fPadR   (' '                , 005,' ') +//   069 – 073 Reservado uso Banco A 005 Brancos
                       fPadR   (IIF(strSacAva <> 'S', strNomEmp, strNomeBen) , 030,' ') +//   074 - 103 Nome do Beneficiário A 030
                       fPadR   (strMsg1            , 040,' ') +//   104 - 143 Mensagem 1 A 040 9
                       fPadR   (strMsg2            , 040,' ') +//   144 - 183 Mensagem 2 A 040 9
                       fPadL   (strCodRem          , 008,'0') +//   184 - 191 Número remessa/retorno N 008 10
                       fPadR   (strDtaRem          , 008,'0') +//   192 - 199 Data da gravação remessa/retorno N 008 DDMMAAAA
                       fPadR   (' '                , 041,' ') ;//   200 - 240 Reservado (uso Banco) A 041 Brancos

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

        pValidaInformacoesRemessa;
        Inc(intCodSeq);
        strSegmentoP := '';
        strSegmentoP :=  fPadR ('033'                       ,003)    + // 001 - 003 Código do Banco na compensação N 003 033
                         fPadL ('0001'                      ,004,'0')+ // 004 - 007 Numero do lote remessa N 004 1
                         fPadR ('3'                         ,001)    + // 008 - 008 Tipo de registro N 001 3 2
                         fPadL (IntToStr(intCodSeq)         ,005,'0')+ // 009 - 013 Nº seqüencial do registro de lote N 005 11
                         fPadR ('P'                         ,001)    + // 014 - 014 Cód. Segmento do registro detalhe A 001 P 13
                         fPadR (' '                         ,001)    + // 015 - 015 Reservado (uso Banco) A 001 Brancos
                         fPadL (LeftStr(strCodMov, 2)       ,002,'0')+ // 016 - 017 Código de movimento remessa N 002 14
                         fPadL (strCodAgen                  ,004,'0')+ // 018 – 021 Agência do Destinatária N 004
                         fPadR (strDigAgen                  ,001)    + // 022 – 022 Dígito da Ag do Destinatária N 001
                         fPadL (strContCor                  ,009,'0')+ // 023 - 031 Número da conta corrente N 009
                         fPadR (strDigCorr                  ,001)    + // 032 – 032 Dígito verificador da conta N 001
                         fPadL (strContCob                  ,009,'0')+ // 033 - 041 Conta cobrança Destinatária FIDC N 009 45
                         fPadR (strDigCtaC                  ,001,'0')+ // 042 - 042 Dígito da conta cobrança Destinatária FIDC N 001
                         fPadR (' '                         ,002,' ')+ // 043 - 044 Reservado (uso Banco) A 002 Brancos
                         fPadL (IIF(strRespons = 'E',qryRemessa.FieldByName('CBI_NOSNUM').AsString,'0')                  ,013,'0')+ // 045 – 057 Identificação do título no Banco N 013 Nosso Número 15
                         fPadL (LeftStr(strTipoCob, 1)      ,001,'0')+ // 058 - 058 Tipo de cobrança A 001 5
                         fPadL (LeftStr(strFormaCad, 1)     ,001,'0')+ // 059 - 059 Forma de Cadastramento N 001 6
                         fPadL (LeftStr(strTipoDoc, 1)      ,001,'0')+ // 060 - 060 Tipo de documento N 001 1- Tradicional , 2- Escritural
                         fPadR (' '                         ,001,' ')+ // 061 – 061 Reservado (uso Banco) A 001 Brancos
                         fPadR (' '                         ,001,' ')+ // 062 - 062 Reservado (uso Banco) A 001 Brancos
                         fPadL (qryRemessa.FieldByName('CBI_NUMDUP').AsString ,015,'0')+// 063 - 077 Nº do documento A 015 Seu número 16
                         fPadL (strDtaVen                   ,008,'0')+//  078 - 085 Data de vencimento do título N 008 DDMMAAAA 17
                         fValNumForm(fltValDup              , 15)    +//  086 - 100 Valor nominal do título N 015 2 Decimais sem separador 18
                         fPadL (strNumAgeC                  ,004,'0')+//  101 - 104 Agência encarregada da cobrança FIDC N 004 45
                         fPadL (strDigAgeC                  ,001,'0')+//  105 – 105 Dígito da Agência do Beneficiário FIDC N 001 45
                         fPadR (' '                         ,001,' ')+//  106 - 106 Reservado (uso Banco) A 001 Brancos
                         fPadL ('02'                        ,002,'0')+//  107 – 108 Espécie do título N 002 20
                         fPadR ('N'                         ,001)    +//  109 - 109 Identif. de título Aceito/Não Aceito A 001 N- Não Aceite
                         fPadL (strDtaEmi                   ,008,'0')+//  110 - 117 Data da emissão do título N 008 DDMMAAAA
                         fPadR ('1'                         ,001)    +//  118 - 118 Código do juros de mora N 001 21
                         fPadL (strDtaVen                   ,008,'0')+//  119 - 126 Data do juros de mora N 008 DDMMAAAA 22
                         fValNumForm(fltValMora             , 15)    +//  127 - 141 Valor da mora/dia ou Taxa mensal N 015 2 Decimais, sem separador 18
                         fPadL ('0'                         ,001)    +//  142 - 142 Código do desconto 1 N 001 23
                         fPadL ('0'                         ,008,'0')+//  143 - 150 Data de desconto 1 N 008 DDMMAAAA 23
                         fPadL ('0'                         ,015,'0')+//  151 - 165 Valor ou Percentual do descontoconcedido N 015 2 Decimais sem separador
                         fPadL ('0'                         ,015,'0')+//  166 - 180 Valor do IOF a ser recolhido N 015 2 Decimais sem separador 18
                         fPadL ('0'                         ,015,'0')+//  181 - 195 Valor do abatimento N 015 2 Decimais sem separador 18 io (opcional) 24
                         fPadR (strKeyDup                   ,025,' ')+//  196 - 220 Identificação do título na empresa A 025 Uso Beneficiário (opcional) 24
                         fPadR (LeftStr(strCodPro, 1)       ,001,'0')+//  221 - 221 Código para protesto N 001 25
                         fPadL (strDiaPro                   ,002,'0')+//  222 - 223 Número de dias para protesto N 002
                         fPadR (LeftStr(strCodBaixa, 1)     ,001,'0')+//  224 - 224 Código para Baixa/Devolução N 001 26
                         fPadR ('0'                         ,001)    +//  225 – 225 Reservado (uso Banco) N 001 Zero Fixo
                         fPadR (strDiasBaixa                ,002,'0')+//  226 - 227 Número de dias para Baixa/Devolução N 002
                         fPadR ('00'                        ,002)    +//  228 - 229 Código da moeda N 002 27
                         fPadR (' '                         ,011,' ');//  230 – 240 Reservado (uso Banco) A 011 Brancos
        {******************************}
        {* ESCREVE A TRANSACAO NO TXT *}
        {*****SEGMENTO*P************AF*}
        Writeln(txtTexto,strSegmentoP);
        Inc(intCodSeq);
        strSegmentoQ := '';
        strSegmentoQ := fPadR ('033'                                     ,003)    +//  001 - 003 Código do Banco na compensação N 003 033
                        fPadL ('0001'                                    ,004,'0')+//  004 - 007 Numero do lote remessa N 004 1
                        fPadR ('3'                                       ,001)    +//  008 - 008 Tipo de registro N 001 3 2
                        fPadL (IntToStr(intCodSeq)                    ,005,'0')+//  009 - 013 Nº seqüencial do registro no lote N 005 11
                        fPadR ('Q'                                       ,001)    +//  014 - 014 Cód. segmento do registro detalhe A 001 Q 13
                        fPadR (' '                                       ,001,' ')+//  015 - 015 Reservado (uso Banco) A 001 Brancos
                        fPadR (LeftStr(strCodMov, 2)                     ,002,'0')+//  016 - 017 Código de movimento remessa N 002 14
                        fPadR (strCpfCgc                                 ,001)    +//  018 - 018 Tipo de inscrição do Pagador N 001 30
                        fPadL (strCgcCli                                 ,015,'0') +//  019 - 033 Número de inscrição do Pagador N 015 30
                        fPadR (qryRemessa.FieldByName('CLI_NOMCLI').AsString        ,040,' ')+//  034 - 073 Nome Pagador A 040
                        fPadR (qryRemessa.FieldByName('ENDERE').AsString            ,040,' ')+//  074 - 113 Endereço Pagador A 040 29
                        fPadR (qryRemessa.FieldByName('BAIRRO').AsString            ,015,' ')+//  14 - 128 Bairro Pagador A 015 29
                        fPadL (LeftStr(qryRemessa.FieldByName('C_E_P_').AsString,5) ,005,'0')+//  129 - 133 Cep Pagador N 005 29
                        fPadL (RightStr(qryRemessa.FieldByName('C_E_P_').AsString,3),003,'0')+//  134 - 136 Sufixo do Cep do Pagador N 003 29
                        fPadR (qryRemessa.FieldByName('CIDADE').AsString            ,015, ' ') + // 137 - 151 Cidade do Pagador A 015 29
                        fPadR (qryRemessa.FieldByName('ESTADO').AsString            ,002, ' ') + // 152 - 153 Unidade da Federação do Pagador A 002 29
                        fPadR (IIF(strSacAva <> 'S','0','2')                        ,001)    +//  154 - 154 Tipo de inscrição Sacador/avalista N 001 30
                        fPadL (IIF(strSacAva <> 'S','0',strCgcEmp)                  ,015,'0')+//  155 - 169 Nº de inscrição Sacador/avalista N 015 30
                        fPadR (IIF(strSacAva <> 'S',' ',strNomEmp)                  ,040,' ')    +//  170 - 209 Nome do Sacador/avalista A 040 31
                        fPadR (strEhCarne                                ,003)    +//  210 –212 Identificador de carne N 003 28
                        fPadL (IIF(strEhCarne = '001',strNumPar,'0')     ,003,'0')+//  213 –215 Seqüencial da Parcela ou número  inicial da parcela N 003 28
                        fPadL (IIF(strEhCarne = '001',IntToStr(intQtdPar),'0') ,003,'0')+//  216 –218 Quantidade total de parcelas N 003 28
                        fPadL ('0'                                       ,003,'0')    +//  219 – 221 Número do plano N 003 28
                        fPadR (' '                                       ,019,' ');//  222 - 240 Reservado (uso Banco) A 019 Brancos

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
          LSegmentoR   := fPadR      ('033'                                , 03, ' ') + //001 - 003  [01] Código do Banco na Compensação
                          fPadR      ('0001'                               , 04, ' ') + //004 - 007  [02] Lote de Serviço
                          fPadL      ('3'                                  , 01, ' ') + //008 - 008  [03] Tipo de Registro
                          fStrZero   (IntToStr(intCodSeq)                  , 05)      + //009 - 013  [04] Nº Sequencial do Registro no Lote
                          fPadL      ('R'                                  , 01, ' ') + //014 - 014  [05] Cód. Segmento do Registro Detalhe
                          fPadL      (' '                                  , 01, ' ') + //015 - 015  [06] Uso Exclusivo FEBRABAN/CNAB
                          fPadL      ('01'                                 , 02, ' ') + //016 - 017  [07] Código de Movimento Remessa
                          fPadL      ('0'                                  , 01, ' ') + //018 - 018  [08] Código do Desconto 2
                          fPadR      ('0'                                  , 08, '0') + //019 - 026  [09] Data do Desconto 2
                          fPadL      ('0'                                  , 15, '0') + //027 - 041  [10] Valor/Percentual a ser concedido
                          fPadL      (' '                                  , 01, ' ') + //042 - 042  [11] Código do Desconto 3
                          fPadR      (' '                                  , 08, ' ') + //043 - 050  [12] Data do Desconto 3
                          fPadL      (' '                                  , 15, ' ') + //051 - 065  [13] Valor/Percentual a Ser Concedido
                          fPadR      ('2'                                  , 01, ' ') + //066 - 066  [14] Código da Multa
                          fPadR      (strDtaVenMulta                       , 08, ' ') + //067 - 074  [15] Data da Multa
                          fStrZero   (strPerMul                            , 15)      + //075 - 089  [16] Valor/Percentual a Ser Aplicado
                          fPadR      (' '                                  , 10, ' ') + //090 - 099  [17] Reservado (uso Banco)
                          fPadR      (' '                                  , 40, ' ') + //100 - 139  [18] Mensagem 3
                          fPadR      (' '                                  , 40, ' ') + //140 - 179  [19] Mensagem 4
                          fPadR      (' '                                  , 61, ' ') ; //180 - 240  [20] Reservado


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
      strTraillerLote :=  fPadR ('033'                                     ,003)    +//001 - 003 Código do Banco na compensação N 003 353 / 008 / 033
                          fPadL ('0001'                                    ,004,'0')+//004 - 007 Numero do lote remessa N 004 1
                          fPadR ('5'                                       ,001)    +//008 - 008 Tipo de registro N 001 5 2
                          fPadR (' '                                       ,009,' ')+//009 - 017 Reservado (uso Banco) N 009 Brancos
                          fPadL (IntToStr(intCodSeq)                       ,006,'0')+//018 - 023 Quantidade de registros do lote N 006 38
                          fPadR (' '                                       ,217,' ');//  024 - 240 Reservado (uso Banco) A 217 Brancos
      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {********LOTE**************AF*}
      Writeln(txtTexto,strTraillerLote);
      intCodSeq := intCodSeq + 2;
      strTrailler := '';
      strTrailler := fPadR ('033'                                     ,003)    +//001 - 003 Código do Banco na compensação N 003 033
                     fPadR ('9999'                                    ,004)    +//004 - 007 Numero do lote remessa N 004 1
                     fPadR ('9'                                       ,001)    +// 008 - 008 Tipo de registro N 001 9 2
                     fPadR (' '                                       ,009,' ')+// 009 - 017 Reservado (uso Banco) N 009 Brancos
                     fPadL ('1'                                       ,006,'0')+// 018 - 023 Quantidade de lotes do arquivo N 006 Registros tipo=1
                     fPadL (IntToStr(intCodSeq)                       ,006,'0')+// 024 - 029 Quantidade de registros do arquivo N 006 Registros tipo=0+1+2+3+5+9
                     fPadR (' '                                       ,211,' ');// 030 - 240 Reservado (uso Banco) A 211 Brancos
                     fPadR (' '                                       ,211,' ');// 030 - 240 Reservado (uso Banco) A 211 Brancos

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

procedure TfrmExpArqRemSantander240p.edtCodPorExit(Sender: TObject);
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

procedure TfrmExpArqRemSantander240p.edtCodPorKeyPress(Sender: TObject;var Key: Char);
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

function TfrmExpArqRemSantander240p.fCriarQueryRemessa: TUniQuery;
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

function TfrmExpArqRemSantander240p.fGetSqlRemessa: String;
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

function TfrmExpArqRemSantander240p.fRetEmpresa: String;
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

function TfrmExpArqRemSantander240p.fValidacoesParaExportacao: Boolean;
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


procedure TfrmExpArqRemSantander240p.pApagarCADCBI;
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

procedure TfrmExpArqRemSantander240p.pValidaInformacoesCarteira;
begin
  If (Pos(LeftStr(strCodPro,1),'1_2_') <= 0) Then
    strDiaPro := '0';

  If (LeftStr(strCodBaixa,1) <> '1') Then
    strDiasBaixa := '0';
end;

procedure TfrmExpArqRemSantander240p.pValidaInformacoesRemessa;
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

procedure TfrmExpArqRemSantander240p.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPor);
end;

procedure TfrmExpArqRemSantander240p.FormCreate(Sender: TObject);
begin
  inherited;
    qryCadPor := fCriaQuery(Self);
end;
end.
