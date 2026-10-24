{***************************}
{* qryConEmp -> CADEMP     *}
{* qryConCli -> CADCLI     *}
{* qryConCar -> CADCAR     *}
{************************JB*}
unit untCadMovCartoes;

interface

uses
  Classes, Controls, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, DB, Menus, EditFocus, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors,
  Data.Bind.Components, Data.Bind.DBScope, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, untMovCar, untTypesSistema, Winapi.Windows, untCadRcxx, untGravaMovCar,
  untFechamentoFinanceiro, cxDBEdit, Vcl.Forms, untFramePlanoDeContasDBEditFocus,
  System.StrUtils, System.DateUtils, System.JSON;

type
  TRotinaOrigem = (roDesconhecido, roBaixaCartoes);

  TfrmCadMovCartoes = class(TfrmPaiCad)
    pnlGeral: TPanel;
    pnlDetalhe: TPanel;
    pnlDadosBaixa: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeNumDup: TDBEditFocus;
    dbeParcel: TDBEditFocus;
    dbeCodCli: TDBEditFocus;
    Label5: TLabel;
    dbeCodEmp: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeCodCar: TDBEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    dbeValSta: TDBEditFocus;
    Label10: TLabel;
    dbePerCar: TDBEditFocus;
    Label11: TLabel;
    Label12: TLabel;
    dbeValDup: TDBEditFocus;
    Label13: TLabel;
    dbeHist01: TDBEditFocus;
    dbeHist02: TDBEditFocus;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label24: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edtNomEmp: TEditFocus;
    edtNomCli: TEditFocus;
    edtDesCar: TEditFocus;
    edtDtaRec: TEditFocus;
    edtValRec: TEditFocus;
    edtPorBai: TEditFocus;
    edtCtaBai: TEditFocus;
    edtDocBanBai: TEditFocus;
    edtValTax: TEditFocus;
    edtPorBaiTaxa: TEditFocus;
    edtCtaBaiTaxa: TEditFocus;
    edtDocBanTaxa: TEditFocus;
    Label6: TLabel;
    dbeNumLib: TDBEditFocus;
    dtsMovCar: TDataSource;
    btnBaixarCartoes: TBitBtnLocked;
    Label16: TLabel;
    dbeNumNSU: TDBEditFocus;
    lblConNsu: TLabel;
    edtConNsu: TEditFocus;
    btnEspelhoTEF: TBitBtnLocked;
    dbeDtaCad: TcxDBDateEdit;
    dbeDtaVen: TcxDBDateEdit;
    Label17: TLabel;
    dbeDtaCup: TcxDBDateEdit;
    btnAjuVal: TBitBtnLocked;
    btnAjuda: TBitBtnLocked;
    btnHistReceb: TBitBtnLocked;
    btnEstornoMovCartao: TBitBtnLocked;
    grbMovBan: TGroupBox;
    Label25: TLabel;
    dbePorCar: TDBEditFocus;
    edtDesPorCar: TEditFocus;
    btnAltPortador: TBitBtnLocked;
    Label29: TLabel;
    dbeValTax: TDBEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasDBEditFocus;
    pnlAntecipacao: TPanel;
    lblAntTax: TLabel;
    edtAntTax: TEditFocus;
    btnDetalharValoresBaixa: TBitBtnLocked;
    pnlFrete: TPanel;
    lblFreMkt: TLabel;
    dbeFreMkt: TDBEditFocus;
    Label28: TLabel;
    edtValorTaxaAntecipacao: TEditFocus;
    Label30: TLabel;
    Label31: TLabel;
    edtPercentualTaxaBaixa: TEditFocus;
    edtPercentualAntBaixa: TEditFocus;
    Label32: TLabel;
    Label33: TLabel;
    lblCupMkt: TLabel;
    dbeCupMkt: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    function dbeCodEmpChamaCadastro(Key: Word): String;
    function dbeCodCliChamaCadastro(Key: Word): String;
    function dbeCodCarChamaCadastro(Key: Word): String;
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure btnBaixarCartoesClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbePerCarExit(Sender: TObject);
    procedure dbeValStaExit(Sender: TObject);
    procedure dbeNumNSUKeyPress(Sender: TObject; var Key: Char);
    procedure btnEspelhoTEFClick(Sender: TObject);
    procedure dbeDtaCadPropertiesEditValueChanged(Sender: TObject);
    procedure dbeDtaVenPropertiesEditValueChanged(Sender: TObject);
    procedure dbeDtaCupPropertiesEditValueChanged(Sender: TObject);
    procedure btnAjuValClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAjudaClick(Sender: TObject);
    procedure btnHistRecebClick(Sender: TObject);
    procedure btnEstornoMovCartaoClick(Sender: TObject);
    procedure btnAltPortadorClick(Sender: TObject);
    procedure dbePorCarKeyPress(Sender: TObject; var Key: Char);
    procedure dbeValTaxExit(Sender: TObject);
    procedure dbeValDupExit(Sender: TObject);
    procedure dbeParcelKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure btnDetalharValoresBaixaClick(Sender: TObject);
    procedure dbeCodCarExit(Sender: TObject);
    procedure dbeCodCarEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryConCar: TUniQuery;
    qryConCli: TUniQuery;
    qryConEmp: TUniQuery;
    qryConCta: TUniQuery;

    FRotinaOrigem: TRotinaOrigem;

    fltValOriAnt: Double;
    fltValDupAnt: Double;
    fltValStaAnt: Double;
    FCuponDescontoAnt: Double;

    strLibAnt,
    strSeqLan,
    strPorCarAnt,
    strCtaCarAnt,
    strCodPorCredMovBan,
    strCodPlanCredMovBan :String;

    FExtratoVendaCartao: Boolean;
    FExtMca: TUniQuery;

    blnIniciaCadastro: Boolean;
    fltValLanLoc: Double;
    strHist01Loc,
    strCodPorLoc: String;
    dteDataLanLoc: TDate;
    arrSeqLanLoc: TStringArray;
    FAutoincrem: string;
    objFechamento: TFechamentoFinanceiro;
    AValorTotalInicial: Double;
    ADataCadastroInicial: TDateTime;
    ADataTransacaoInicial: TDateTime;
    LUtilizaModuloContabil : Boolean;

    FCartaoAnterior: String;
    LValidarMesmoCartao : Boolean;

    FLiberacaoTransferencia: Boolean;

    blnExitCodCar : boolean;

    FAtualizarBaixa: Boolean;

    FVendaMarketplace: Boolean;
    FVendaMktJson: TJSONObject;
    FVendaMktGravada: Boolean;

    function fOrigemExternaCarregada: Boolean;
    function fVendaMarketplaceValida(out AMotivo: String): Boolean;
    function fDataVendaMarketplace(const AParcela: TJSONValue; const AChave: String; out AData: TDateTime): Boolean;
    procedure CarregaDadosVendaMarketplace;
    function fCartaoPermitidoVendaMarketplace: Boolean;
    function fParcelasVendaMarketplaceValidas: Boolean;
    procedure pDefinePortadorDebitoVendaMarketplace;
    function fGravaParcelasAdicionaisVendaMarketplace(out AErro: String): Boolean;

    procedure pLimpaDadosBaixa;
    procedure pIniciaValoresPadrao;
    procedure pCalculaValorDocumento(blnCalPer: Boolean; blnCalDoc: Boolean = False);
    procedure pCarregaEmpresa;
    procedure pCarregaCliente;
    procedure pCarregaCartao(blnChave: Boolean = True; blnAlteraData: Boolean = True);
    procedure pCarregaDadosAdicionais;
    procedure CarregaDadosCartaoVenda;
    procedure SetValorCampo(ACampo: TWinControl; AValor: String; AEnabled: Boolean = False);
    procedure pCarregaDadosBaixa;
    procedure pAfterOpen(DataSet: TDataSet);
    function fBaixaCaixaVinculado: Boolean;
    procedure pHabDesBotoes(Habilita: Boolean);
    procedure pCarregaDadosCartao(strIncCar: string = '');
    procedure pRecarregaCartaoAberto;
    procedure pAtualizaCartaoMovBan;
    procedure pCarregaCentroCusto;
    procedure pCarregaPortador;

    function fMovimentoBancario(blnConciliado : Boolean = False): Boolean;
    function fGravaMovimentoBancario(strTipo: String;
                                     strPorCar: String = '';
                                     strCtaCar: String = '';
                                     fltValSta: Double = 0;
                                     ACupomDesconto: Double = 0) : Boolean;

    function fGravaDebitoMovBanRefExclusao : Boolean;
    function fObrigatorioPortadorEConta: Boolean;
    function VerificaValorTotalAlterado(Sender: TWinControl): Boolean;

    function CartaoGeradoPeloCaixa: Boolean;
    procedure pAlteraDtaVen(AAlteraData: Boolean = False; ANovaDtaCad: Boolean = False);
  protected
    strTipTax: String;
    procedure pInicializaIndices; override;
    function fExecutaAntesDoDelete : Boolean; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fRetornaValorAntecipacao: String;
  public
    blnChamadoDoManutencao: Boolean;
    strNumDup: String;
    strParcel: String;
    strCodEmp: String;
    strCodCli: String;
    strDocume: String;
    strNumCcd: String;

    class procedure pMostraIniciandoCadastro(fltValLan: Double; strHist01: String; dteDataLan: TDate; strCodPor: String; var arrSeqLan: TStringArray);
    procedure CarregaExtratoVenda(AAutoincrem: String);
    function CarregaVendaMarketplace(const AJsonVenda: String): Boolean;

    property RotinaOrigem: TRotinaOrigem read FRotinaOrigem write FRotinaOrigem;
    property VendaMarketplaceGravada: Boolean read FVendaMktGravada;
  published
    property strAutoincrem: String read FAutoincrem write FAutoincrem;
    property AtualizarBaixa: Boolean read FAtualizarBaixa;
  end;

var
  frmCadMovCartoes: TfrmCadMovCartoes;

implementation

uses SysUtils, Math, untFuncoes, untFuncoesSimples, untPesqAux,
  untConstantes, untFuncIns, untBaixaCartoes, untPai, untConsultas,
  untEspelhoTEF, untCadMovCartoesParcelas, untRelAjudaMod, untRelCartoesLogAcomp,
  untEstornaCartoes, untPorCredMovBan, untTBanMca, untMovBan, untDigPortador,
  untMcaDetalhesBaixa, untRcxTResumoDeCaixa;

{$R *.dfm}

{ TfrmCadMovCartoes }

procedure TfrmCadMovCartoes.fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;

  If fPesqCentroCusto(Self, fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If (fValidaCampos(fraPlanoDeContas.dbeCodCta, True)) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
    pCarregaCentroCusto;
  End;

end;

function TfrmCadMovCartoes.fRetornaValorAntecipacao: String;
begin
  Result := FormatFloat('#,##0.00',qryTabela.FieldByName('MCA_ANTTAX').AsFloat);
end;

function TfrmCadMovCartoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    LAlterarVencimento: Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O NUMERO DA DUPLICATA          *}
    {**************************************MV*}
    If (Sender = dbeNumDup) Then
    Begin
      If fEmptyStr(dbeNumDup.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Documento deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A PARCELA                      *}
    {**************************************MV*}
    Else If (Sender = dbeParcel) Then
    Begin
      If fEmptyStr(dbeParcel.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Parcela deve ser preenchida!', ['&O k']);
        Result := False;
      End
      (*********************************************************************************)
      (* RETIRADA A RESTRIÇÃO POR CAUSA DA FINANCEIRA QUE PODE GRAVAR ATE 999 PARCELAS *)
      (******************************************************************************LA*)
     { Else If Not (dbeParcel.Text[1] In ['A'..'Z']) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Parcela deve estar entre A e Z!', ['&O k']);
        Result := False;
      End;
      }
    End

    {*****************************************}
    {* VALIDA O CODIGO DA EMPRESA            *}
    {**************************************MV*}
    Else If (Sender = dbeCodEmp) Then
    Begin
      If fEmptyStr(dbeCodEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaEmpresa;
        If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End
        Else If Pos(dbeCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO CLIENTE            *}
    {**************************************MV*}
    Else If (Sender = dbeCodCli) Then
    Begin
      If fEmptyStr(dbeCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          If (Not fBuscaPorCamposChave) and (not blnIniciaCadastro) Then
          Begin
            If Not fOrigemExternaCarregada Then
              pLimparCampos;

            dbePorCar.Field.Value := strCodPorCredMovBan;
            fraPlanoDeContas.dbeCodCta.Field.Value := strCodPlanCredMovBan;
            pCarregaPortador;
            pCarregaCentroCusto;
          End
          Else
          Begin
            pCarregaDadosBaixa;
          End;

          pCarregaDadosAdicionais;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA O CODIGO DO CARTÃO             *}
    {**************************************MV*}
    Else If (Sender = dbeCodCar) Then
    Begin

      If fEmptyStr(dbeCodCar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do Cartão deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        LAlterarVencimento := qryTabela.FieldByName('MCA_DTAVEN').AsString.IsEmpty;
        If Not LAlterarVencimento Then
          LAlterarVencimento := FCartaoAnterior <> dbeCodCar.Text;

        pCarregaCartao(blnBuscaPorChave, LAlterarVencimento);
        If qryConCar.FieldbyName('CAR_CODCAR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cartão não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (qryConCar.FieldByName('CAR_STATUS').AsString = 'N') And (Not blnExitCodCar) Then
        Begin
           fMensagem('ATENÇÃO', 'Esse cartão está inativo!', ['&Ok']);
           Result := False;
        End
        Else If (Not fVerificaAcessoCartao(dbeCodCar.Text)) Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso a esse Cartão!', ['&Ok']);
          Result := False;
        End
        Else If (Not fEmptyStr(qryConCar.FieldbyName('CAR_CODEMP').AsString)) And
                (qryConCar.FieldbyName('CAR_CODEMP').AsString <> dbeCodEmp.Text) Then
        Begin
          fMensagem('', 'Esse cartão não pode ser utilizado pela empresa selecionada!', ['&Ok']);
          Result := False;
        End
        Else If Not VerificaValorTotalAlterado(Sender) Then
          Result := False;

        blnExitCodCar := False;
      End

    End

    {*****************************************}
    {* VALIDA A DATA DE CADASTRO             *}
    {**************************************MV*}
    Else If (Sender = dbeDtaCad) Then
    Begin
      if dteDataLanLoc <> 0 then
        dtsMovCar.DataSet.FieldByName('MCA_DTACAD').Value := dteDataLanLoc;

      If fEmptyStr(fTiraCaracEspeciais(dbeDtaCad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDate(dbeDtaCad.Text) > VS_Date) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser menor ou igual a Data Atual!', ['&O k']);
        Result := False;
      End;

      //FECHAMENTO FINANCEIRO
      //VERIFICA SE É INSERÇÃO OU UMA ALTERAÇÃO DE DATA DE CADASTRO
      if (qryTabela.State = dsInsert) then
      Begin
        if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
          Result := False;

        If Result Then
          pAlteraDtaVen(ADataCadastroInicial <> StrToDate(dbeDtaCad.Text),True);
      End;

      if ((qryTabela.State = dsEdit) And
          ((ADataCadastroInicial <> StrToDate(dbeDtaCad.Text)) Or (ADataTransacaoInicial <> StrToDate(dbeDtaCup.Text)))) then
      begin
        if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, ADataCadastroInicial) then
          Result := False
        else
        if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
          Result := False;

        pAlteraDtaVen(Result,True);
      end;
    End

    {*****************************************}
    {* VALIDA A DATA DE VENCIMENTO           *}
    {**************************************MV*}
    Else If (Sender = dbeDtaVen) Then
    Begin
      if dteDataLanLoc <> 0 then
        dtsMovCar.DataSet.FieldByName('MCA_DTAVEN').Value := dteDataLanLoc;

      If fEmptyStr(fTiraCaracEspeciais(dbeDtaVen.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDate(dbeDtaVen.Text) < StrToDate(dbeDtaCad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser maior ou igual a Data de Cadastro!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA DA TRANSAÇÃO (CUPOM)    *}
    {**************************************AJ*}
    Else If (Sender = dbeDtaCup) Then
    Begin
      if dteDataLanLoc <> 0 then
        dtsMovCar.DataSet.FieldByName('MCA_DTACUP').Value := dteDataLanLoc;

      If fEmptyStr(fTiraCaracEspeciais(dbeDtaCup.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data da Transação deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDate(dbeDtaVen.Text) < StrToDate(dbeDtaCup.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser maior ou igual a Data da Transação!', ['&O k']);
        Result := False;
      End
      Else If (StrToDate(dbeDtaCad.Text) < StrToDate(dbeDtaCup.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser maior ou igual a Data da Transação!', ['&O k']);
        Result := False;
      End;

      //FECHAMENTO FINANCEIRO
      //VERIFICA SE É INSERÇÃO OU UMA ALTERAÇÃO DE DATA DE TRANSAÇÃO
      if (qryTabela.State = dsInsert) then
      Begin
        if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCup.Text)) then
          Result := False;

        If Result Then
          pAlteraDtaVen(ADataTransacaoInicial <> StrToDate(dbeDtaCup.Text),True);
      End;

      if ((qryTabela.State = dsEdit) And (ADataTransacaoInicial <> StrToDate(dbeDtaCup.Text))) then
      begin
        if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, ADataTransacaoInicial) then
          Result := False
        else
        if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCup.Text)) then
          Result := False;

        pAlteraDtaVen(Result,True);
      end;
    End

    {*****************************************}
    {* VALIDA O VALOR TOTAL                  *}
    {**************************************MV*}
    Else If (Sender = dbeValSta) Then
    Begin
      if fltValLanLoc <> 0 then
        dbeValSta.DataSource.DataSet.FieldByName('MCA_VALSTA').Value := fltValLanLoc;

      If blnBuscaPorChave Then
         pCalculaValorDocumento(strTipTax = 'P');

      If fEmptyStr(dbeValSta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor total deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If ((fStrToFloat(dbeValDup.Text) <= 0) And (fEmptyStr(edtDtaRec.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor total deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else If Not VerificaValorTotalAlterado(Sender) Then
        Result := False;
    End

    {*****************************************}
    {* VALIDA A TAXA ADMINISTRATIVA          *}
    {**************************************MV*}
    Else If (Sender = dbePerCar) Then
    Begin
      If fEmptyStr(dbePerCar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Taxa Administrativa deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(dbePercar.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Taxa Administrativa deve ser maior ou igual a Zero!', ['&O k']);
        Result := False;
      End
      else If not VerificaValorTotalAlterado(Sender) Then
        Result := False;

       pCalculaValorDocumento(True);
    End

    Else If (Sender = dbeValTax) Then
    Begin
      Result := VerificaValorTotalAlterado(Sender);
    End

    Else If (Sender = dbeValDup) Then
    Begin

      If fEmptyStr(dbeValDup.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do documento deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (fStrToFloat(dbeValDup.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do documento deve ser maior que Zero!', ['&O k']);
        Result := False;
      End

      Else If (fStrToFloat(dbeValDup.Text) > fStrToFloat(dbeValSta.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor do Documento não pode ser maior que o Valor sem Taxa!', ['&O k']);
        Result := False;
      End
      Else If not VerificaValorTotalAlterado(Sender) then
        Result := False;

    End


    Else If (Sender = dbeNumNsu) Then
    Begin
      If Not fCfgSis('VALNSU', VarBoolean) Then
      Begin
        If Not fEmptyStr(dbeNumNsu.Text) Then
        Begin
          If qryConCar.FieldByName('CAR_MKTPLA').AsString <> 'S' Then
            dbeNumNsu.Text := fPadL(dbeNumNsu.Text, 14, '0');
        End;
      End
      Else
      Begin
        If fEmptyStr(dbeNumNsu.Text) Then
        Begin
          fMensagem('', 'O NSU deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else If (Length(dbeNumNsu.Text) < 14) And (qryConCar.FieldByName('CAR_MKTPLA').AsString <> 'S') Then
        Begin
          fMensagem('', 'O NSU deve ter 14 caracteres!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtConNsu) And (edtConNsu.Visible) Then
    Begin
      If fEmptyStr(edtConNsu.Text) Then
      Begin
        fMensagem('','O NSU deve ser confirmado!', ['&Ok']);
        Result := False;
      End
      Else If edtConNsu.Text <> dbeNumNsu.Text Then
      Begin
        fMensagem('','Valor informado diferente do número do cupom!', ['&Ok']);
        Sender := dbeNumNsu;
        dbeNumNsu.Clear;
        dbeNumNsu.Field.AsString := EmptyStr;
        edtConNsu.Clear;
        Result := False;
      End;
    End

    Else If (Sender = dbePorCar) And blnChamadoDoManutencao Then
    Begin
      If fEmptyStr(dbePorCar.Text) Then
      begin
        If fObrigatorioPortadorEConta Then
        Begin
          fMensagem('ATENÇÃO!', 'O Portador do Movimento Bancário deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
          edtDesPorCar.Clear;
      End
      Else
      Begin
        edtDesPorCar.Text := fRetNomPortador(dbePorCar.Text);
        If fEmptyStr(edtDesPorCar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não encontrado!', ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(dbePorCar.Text, dbeCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(dbePorCar.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = fraPlanoDeContas.dbeCodCta) And blnChamadoDoManutencao Then
    Begin
      If fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
      begin
        If fObrigatorioPortadorEConta Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas do Movimento Bancário deve ser preenchido!', ['&Ok']);
          Result := False;
        End
        Else
          fraPlanoDeContas.edtDesCta.Clear;
      End
      Else
      Begin
        If (qryTabela.State = dsInsert) Then
        Begin
          If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
            Result := False;

          pCarregaCentroCusto;
        End
        Else
        Begin
          If qryConCta.FieldByName('CTA_CODCTA').AsString <> fraPlanoDeContas.dbeCodCta.Text Then
          Begin
            If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
              Result := False
          End;
          pCarregaCentroCusto;
        End;

        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) then
        Begin
          fMensagem('ATENÇÃO!', 'Plano de Contas não encontrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadMovCartoes.pAfterOpen(DataSet: TDataSet);
begin
  TDateField(DataSet.FieldByName('MCA_DTACAD')).EditMask := '99/99/9999';
  TDateField(DataSet.FieldByName('MCA_DTAVEN')).EditMask := '99/99/9999';

  TFloatField(DataSet.FieldByName('MCA_VALORI')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('MCA_VALDUP')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('MCA_VALREC')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('MCA_PERCAR')).DisplayFormat := ',0.000000';
  TFloatField(DataSet.FieldByName('MCA_VALSTA')).DisplayFormat := '#,##0.00';
  TFloatField(DataSet.FieldByName('MCA_VALTAX')).DisplayFormat := '#,##0.00';

  If DataSet.FindField('MCA_FREMKT') <> nil Then
    TFloatField(DataSet.FieldByName('MCA_FREMKT')).DisplayFormat := '#,##0.00';

  If DataSet.FindField('MCA_CUPMKT') <> nil Then
    TFloatField(DataSet.FieldByName('MCA_CUPMKT')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadMovCartoes.pAlteraDtaVen(AAlteraData, ANovaDtaCad: Boolean);
  Var
    LParcela: Integer;
begin
  If Not AAlteraData Then
    Exit;

  If Not ANovaDtaCad Then
    Exit;

  If (qryConCar.FieldByName('CAR_PERIOD').AsInteger > 0) And Not fOrigemExternaCarregada Then
  Begin
    LParcela := 1;
    If fRetSomenteNumeros(dbeParcel.Text).IsEmpty Then
    Begin
      LParcela := fGetPosLetraAlfa(dbeParcel.Text);

      If LParcela < 1 Then
        LParcela := 1;
    End;
    
    If Not fCfgSis('CTCDCV', VarBoolean) Then
      dbeDtaVen.Date := IncDay(StrToDate(dbeDtaCup.Text), qryConCar.FieldByName('CAR_PERIOD').AsInteger * LParcela)
    Else
      dbeDtaVen.Date := IncDay(StrToDate(dbeDtaCad.Text), qryConCar.FieldByName('CAR_PERIOD').AsInteger * LParcela);
  End;

  If dbeDtaVen.Date < dbeDtaCad.Date Then
    dbeDtaVen.Date := dbeDtaCad.Date;

  ADataCadastroInicial := StrToDate(dbeDtaCad.Text);
  ADataTransacaoInicial := StrToDate(dbeDtaCup.Text);
end;

//FECHAMENTO FINANCEIRO
//SE O VALOR TOTAL FOR ALTERADO VERIFICA FECHAMENTO
function TfrmCadMovCartoes.VerificaValorTotalAlterado(Sender: TWinControl): Boolean;
  Var
    LCalPer : Boolean;
begin
  Result := True;

  if (qryTabela.State = dsEdit) And
     (AValorTotalInicial <> fStrToFloat(dbeValDup.Text)) Then
  begin
    if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
      Result := False
    Else If LUtilizaModuloContabil Then
    Begin

      If (TDBEditFocus(Sender).Name = 'dbeCodCar') Then
      Begin
        If dbeCodCar.Field.AsString = dbeCodCar.Field.OldValue Then
        Begin
          If LValidarMesmoCartao Then
            fMensagem('ATENÇÃO!', 'Não será considerado a nova taxa cadastrada no cartão,'+#13#10+
                                  ' pois não é permitido alteração de valor quando configurado para utilizar a rotina de contabilidade!' , ['&O k']);

          dbePerCar.Field.AsFloat := dbePerCar.Field.OldValue;
          dbeValTax.Field.AsFloat := dbeValTax.Field.OldValue;
          LValidarMesmoCartao := False;

          If dbeValSta.Field.Value > 0 Then
            pCalculaValorDocumento(qryConCar.FieldByName('CAR_TIPTAX').AsString.ToUpper = 'P');

          Exit(True);
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Cartão informado possui taxas diferentes do anterior'+#13#10+
                                ' e não é permitido alteração de valor quando configurado para utilizar a rotina de contabilidade!', ['&O k']);
        End;
      End
      Else
        fMensagem('ATENÇÃO!', 'Não é permitido alteração de valor quando configurado para utilizar a rotina de contabilidade!', ['&O k']);

      TDBEditFocus(Sender).Field.AsString := TDBEditFocus(Sender).Field.OldValue;

      LCalPer := (TDBEditFocus(Sender).Name = 'dbePerCar') Or
                 (MatchStr(TDBEditFocus(Sender).Name,['dbeValSta','dbeFreMkt','dbeCupMkt']) And (strTipTax.ToUpper = 'P'));

      pCalculaValorDocumento(LCalPer, (TDBEditFocus(Sender).Name = 'dbeValDup') );
      Result := False;
    End;

  end;
end;

procedure TfrmCadMovCartoes.pCarregaCentroCusto;
begin
  if not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) then
  begin
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.dbeCodCta.Text);
    fraPlanoDeContas.edtDesCta.Text := qryConCta.FieldByName('CTA_DESCTA').AsString;
  end else
    fraPlanoDeContas.edtDesCta.Clear;
end;

Procedure TfrmCadMovCartoes.pAtualizaCartaoMovBan;
var
  qryAux : TUniQuery;
Begin

  If (Not fEmptyStr(strPorCarAnt)) And
     (strPorCarAnt <> dbePorCar.Text) Then
  Begin
    fGravaMovimentoBancario('D', strPorCarAnt, strCtaCarAnt, fltValStaAnt, FCuponDescontoAnt);
    fGravaMovimentoBancario('C');
    strPorCarAnt := '';
    strCtaCarAnt := '';
    fltValStaAnt := 0;
    FCuponDescontoAnt := 0;
    Exit;
  End;

  qryAux := fCriaQuery;

  Try

    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add(' UPDATE MOVBAN MV ');
      SQL.Add(' INNER JOIN BANMCA BC ON BC.CTB_SEQLAN = MV.CTB_SEQLAN ');
      SQL.Add(' SET MV.CTB_DTALAN = :DTALAN, ');
      SQL.Add('     MV.CTB_CODCTA = :CODCTA, ');
      SQL.Add('     MV.CTB_VALLAN = :VALLAN, ');
      SQL.Add('     BC.MCA_HIST01 = :HIST01, ');
      SQL.Add('     BC.MCA_HIST02 = :HIST02, ');
      SQL.Add('     BC.MCA_VALSTA = :VALLAN  ');
      SQL.Add(' WHERE MV.CTB_SEQLAN = :SEQLAN ');
      ParamByName('DTALAN').AsDate   := strToDateDef(dbeDtaCad.Text, 0);
      ParamByName('CODCTA').AsString := fraPlanoDeContas.dbeCodCta.Text;
      ParamByname('VALLAN').AsFloat  := dbeValSta.Field.Value;
      ParamByname('HIST01').AsString := dbeHIST01.Text;
      ParamByname('HIST02').AsString := dbeHIST02.Text;
      ParamByName('SEQLAN').AsString := strSeqLan;

      ExecSQL;

    End;

  Finally
    FreeAndNil(qryAux);
  End;

End;

procedure TfrmCadMovCartoes.pHabDesBotoes(Habilita: Boolean);
begin
  btnIncluir.Enabled       := Habilita;
  btnAjuVal.Enabled        := Habilita;
  btnAlterar.Enabled       := (fEmptyStr(edtDtaRec.Text)) And
                              (fBaixaCaixaVinculado)     And
                              (Habilita);
  btnExcluir.Enabled       := btnAlterar.Enabled;

  btnPesquisa.Enabled      := Habilita;
  btnSair.Enabled          := Habilita;
  btnbaixarCartoes.Enabled := Habilita And blnChamadoDoManutencao;
  btnEspelhoTEF.Enabled    := Habilita;

  btnGravar.Enabled        := Not Habilita;
  btnCancela.Enabled       := Not Habilita;

  btnEstornoMovCartao.Enabled := (Not qryTabela.IsEmpty) And
                                 (Not fEmptyStr(edtDtaRec.Text)) And
                                 (fVerificaAcessoSistema('frmEstornaCartoes'));
end;

procedure TfrmCadMovCartoes.pCalculaValorDocumento(blnCalPer: Boolean; blnCalDoc: Boolean = False);
  Var
    fltValDup,
    LValorTaxaPeloPercentual: Double;
begin
  If fEmptyStr(dbeValSta.Text) Then
    dbeValSta.Text := '0,00';

  If fEmptyStr(dbePerCar.Text) Then
    dbePerCar.Text := '0,000000';

  If (blnCalDoc) And (Not fEmptyStr(dbeValDup.Text)) Then
  Begin
    blnCalPer := False;
    dbeValTax.Text := FloatToStrF(fStrToFloat(dbeValSta.Text) -
                                  (fStrToFloat(dbeValDup.Text) +
                                   fStrToFloat(dbeFreMkt.Text) -
                                   fStrtoFloat(dbeCupMkt.Text)), ffNumber, 12, 2);
  End;

  If Not blnCalPer Then
  Begin
    LValorTaxaPeloPercentual := fFormataFloat(fStrToFloat(dbeValSta.Text) * (fStrToFloat(dbePerCar.Text) / 100), 2);

    If (LValorTaxaPeloPercentual <> fStrToFloat(dbeValTax.Text)) Then
    Begin
      dbePerCar.Text          := FloatToStrF(((fStrToFloat(dbeValTax.Text) / fStrToFloat(dbeValSta.Text)) * 100), ffNumber, 12, 6);
      dbePerCar.Field.AsFloat := fStrtoFloat(dbePerCar.Text);
    End;
  End;

  dbeValDup.Text := FloatToStrF(fCalculaValDocCartao(fStrToFloat(dbeValSta.Text),
                                                     fStrToFloat(dbePerCar.Text),
                                                     fStrToFloat(dbeFreMkt.Text),
                                                     fStrToFloat(dbeCupMkt.Text)),
                                ffFixed, 12, 2);

  If (FloatToStrF(fltValDupAnt, ffNumber, 12, 2) <> dbeValDup.Text) Then
  Begin
    fltValDup := fStrToFloat(dbeValDup.Text);
    If fltValDup > MAX_VALMON Then
    Begin
      fltValDupAnt   := MAX_VALMON;
      dbeValDup.Text := FloatToStr(fltValDupAnt);
    End;

    fltValOriAnt := fltValOriAnt + (fStrToFloat(dbeValDup.Text) - fltValDupAnt);
    fltValDupAnt := fStrToFloat(dbeValDup.Text);
    qryTabela.FieldByName('MCA_VALORI').AsFloat := fltValOriAnt;
  End;

  dbeValDup.Field.Value := fltValDupAnt;
  dbeValTax.Text        := FloatToStrF(fStrtoFloat(dbeValSta.Text) -
                                       (fStrtoFloat(dbeValDup.Text) +
                                       fStrToFloat(dbeFreMkt.Text) -
                                       fStrtoFloat(dbeCupMkt.Text)), ffNumber, 12, 2);
  dbeValTax.Field.Value := fStrToFloat(dbeValTax.Text);

  If fStrToFloat(dbeFreMkt.Text) + fStrToFloat(dbeCupMkt.Text) = 0 Then
  Begin
    if fAjustarTaxaDeAdministracao(qryTabela.FieldByName('MCA_CODCAR'),
                                   qryTabela.FieldByName('MCA_VALSTA'),
                                   qryTabela.FieldByName('MCA_VALTAX'),
                                   qryTabela.FieldByName('MCA_VALORI'),
                                   qryTabela.FieldByName('MCA_VALDUP'),
                                   qryTabela.FieldByName('MCA_PERCAR')) then
    begin
      fltValOriAnt := qryTabela.FieldByName('MCA_VALORI').AsFloat;
      fltValDupAnt := qryTabela.FieldByName('MCA_VALDUP').AsFloat;
    end;
  End;
end;

procedure TfrmCadMovCartoes.pCarregaCartao(blnChave: Boolean = True;
                                           blnAlteraData: Boolean = True);
begin
  pPesquisaCadCar(qryConCar, qryConCar, dbeCodCar.Text);

  edtDesCar.Text := qryConCar.FieldByName('CAR_DESCAR').AsString;
  strTipTax      := qryConCar.FieldByName('CAR_TIPTAX').AsString.ToUpper;

  If blnChave Then
  Begin
    If (qryTabela.State In [dsInsert, dsEdit]) And Not fOrigemExternaCarregada Then
    BEGIN
      If qryConCar.FieldByName('CAR_TIPTAX').AsString.ToUpper = 'P' Then
      Begin
        dbePerCar.Field.AsFloat := qryConCar.FieldByName('CAR_PERDES').AsFloat;
        dbeValTax.Field.AsFloat := 0;
      End
      Else
      Begin
        dbeValTax.Field.AsFloat := qryConCar.FieldByName('CAR_PERDES').AsFloat;
        dbePerCar.Field.AsFloat := 0;
      End;
      If dbeValSta.Field.Value > 0 Then
        pCalculaValorDocumento(qryConCar.FieldByName('CAR_TIPTAX').AsString.ToUpper = 'P');

      pAlteraDtaVen(blnAlteraData, blnAlteraData);

    END;

    pnlFrete.Visible :=((qryConCar.FieldByName('CAR_MKTPLA').AsString = 'S') Or
                        (qryTabela.FieldByName('MCA_FREMKT').AsFloat > 0));

    If qryTabela.State in [dsInsert, dsEdit] Then
    Begin
      If Not pnlFrete.Visible Then
      Begin
        dbeFreMkt.Field.AsFloat := 0;
        dbeCupMkt.Field.AsFloat := 0;
      End;
    End;

    If Not fCfgSis('VALNSU', VarBoolean) Then
      dbeNumNsu.CompZeros := qryConCar.FieldByName('CAR_MKTPLA').AsString <> 'S';
  End;

  If (qryTabela.State <> dsEdit) Then
    AValorTotalInicial := fStrToFloat(dbeValDup.Text);

  FCartaoAnterior := dbeCodCar.Text;
end;

procedure TfrmCadMovCartoes.pRecarregaCartaoAberto;
Var
  strAutoincrem : String;
begin
  strAutoincrem  := qryTabela.FieldByName('AUTOINCREM').AsString;
  if not fEmptyStr(strAutoincrem) then
   begin
    qryTabela.Close;
    qryTabela.SQL.Text := 'SELECT * FROM MOVCAR WHERE AUTOINCREM = ' + strAutoincrem.QuotedString;
    qryTabela.Open;
   end;
end;

procedure TfrmCadMovCartoes.SetValorCampo(ACampo: TWinControl; AValor: String; AEnabled: Boolean = False);
begin

  If MatchStr(ACampo.ClassName, ['TDBEditFocus']) Then
  Begin

    TDBEditFocus(ACampo).Field.AsString := AValor;
    If Assigned(TEdit(ACampo).OnExit) Then
      TEdit(ACampo).OnExit(TEdit(ACampo));

    If fValidaCampos(ACampo) Then
      TEdit(ACampo).Enabled := AEnabled;

  End

  Else If MatchStr(ACampo.ClassName, ['TcxDBDateEdit']) Then
  Begin

    TcxDBDateEdit(ACampo).Date := StrToDate(AValor);
    If Assigned(TcxDBDateEdit(ACampo).OnExit) Then
      TcxDBDateEdit(ACampo).OnExit(TcxDBDateEdit(ACampo));

    If fValidaCampos(ACampo) Then
      TcxDBDateEdit(ACampo).Enabled := AEnabled;
  End;

end;

procedure TfrmCadMovCartoes.pCarregaCliente;
begin

  pPesquisaCadCli(qryConCli, qryConCli, dbeCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmCadMovCartoes.pCarregaDadosAdicionais;
begin
  fltValOriAnt  := qryTabela.FieldByName('MCA_VALORI').AsFloat;
  fltValDupAnt  := qryTabela.FieldByName('MCA_VALDUP').AsFloat;
  edtConNsu.Text:= qryTabela.FieldByName('MCA_NUMNSU').AsString;

  pCarregaEmpresa;
  pCarregaCliente;
  pCarregaCartao;
  pCarregaDadosBaixa;
  pCarregaPortador;
  pCarregaCentroCusto;

  If Not (qryTabela.State In [dsInsert, dsEdit]) Then
    pHabDesBotoes(True);

  If pnlAntecipacao.Visible Then
    pnlAntecipacao.Visible := Not pnlFrete.Visible;
end;

procedure TfrmCadMovCartoes.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, dbeCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmCadMovCartoes.pCarregaPortador;
begin
  If Not fEmptyStr(dbePorCar.Text) Then
    edtDesPorCar.Text := fRetNomPortador(dbePorCar.Text)
  Else
    edtDesPorCar.Clear;
end;

function TfrmCadMovCartoes.fExecutaAntesDoDelete : Boolean;
begin
  Result := True;

  Try
    If fMovimentoBancario Then
    Begin
      If Not fGravaDebitoMovBanRefExclusao Then
      Begin
        fRollback;
        fMensagem('ATENÇÃO','Não gravou movimento bancário. Operação será cancelada!',['&OK']);
        Exit(False);
      End;
    End;

    pGravaLogMca(qryTabela.FieldByName('AUTOINCREM').AsString, 'EXCLUSÃO', Self.Name);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadMovCartoes.fExecutaAntesDoDelete]');
      Exit(False);
    End;
  End;
end;

procedure TfrmCadMovCartoes.pInicializaIndices;
begin
  inherited;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('MCA_NUMDUP');
  stlCamInd.Add('MCA_DOCUME');
  stlCamInd.Add('MCA_NUMCCD');
  stlCamInd.Add('MCA_VALDUP');
  stlCamInd.Add('MCA_VALSTA');
  stlCamInd.Add('MCA_VALORI');
  stlCamInd.Add('MCA_VALREC');
  stlCamInd.Add('MCA_CODCLI+CLI_NOMCLI');

  stlDesInd.Add('Duplicata');
  stlDesInd.Add('Documento');
  stlDesInd.Add('Liberação');
  stlDesInd.Add('Vr. Duplicata');
  stlDesInd.Add('Vr. sem Taxa');
  stlDesInd.Add('Vr. Original');
  stlDesInd.Add('Vr. Recebido');
  stlDesInd.Add('Cód. Cliente / Nome do Cliente');

end;

procedure TfrmCadMovCartoes.FormCreate(Sender: TObject);
begin
  inherited;

  FRotinaOrigem := roDesconhecido;

  FAutoincrem := '';
  FExtratoVendaCartao := False;
  FVendaMarketplace   := False;
  FVendaMktGravada    := False;
  strNomeTabela       := 'MOVCAR';
  strNomeCampo        := 'MCA_NUMDUP';

  qryTabela           := fCriarQuery('SELECT * FROM MOVCAR WHERE FALSE', Self);
  qryTabela.AfterOpen := pAfterOpen;
  dtsMovCar.DataSet   := qryTabela;

  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConCar := fCriaQuery(Self);

  SetLength(arrCamposChave, 4);
  arrCamposChave[0] := dbeNumDup;
  arrCamposChave[1] := dbeParcel;
  arrCamposChave[2] := dbeCodEmp;
  arrCamposChave[3] := dbeCodCli;

  If fCfgSis('VALNSU', VarBoolean) Then
  Begin
    dbeNumNSU.PasswordChar := '*';
    dbeNumNSU.CompZeros    := False;
    edtConNsu.Visible      := True;
    lblConNsu.Visible      := True;
  End
  Else
  Begin
    dbeNumNSU.PasswordChar := #0;
    dbeNumNSU.CompZeros    := True;
    edtConNsu.Visible      := False;
    lblConNsu.Visible      := False;
  End;

  blnIniciaCadastro := False;
  strLibAnt := '';
  SetLength(arrSeqLanLoc, 0);

  FCartaoAnterior := '';

  FLiberacaoTransferencia := fCfgSis('USAAUT', varBoolean);

  FAtualizarBaixa := False;
end;

procedure TfrmCadMovCartoes.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(FExtMca) Then
    FreeAndNil(FExtMca);
  If Assigned(FVendaMktJson) Then
    FreeAndNil(FVendaMktJson);
end;

procedure TfrmCadMovCartoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F2) Then
    btnAjuVal.Click
  Else
  If (Key = VK_F4) And (btnAltPortador.Enabled) Then
    btnAltPortador.Click;
end;

procedure TfrmCadMovCartoes.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSE CAMPO É ZERADO PARA QUE O PAICAD *}
  {* NÃO PREENCHA O CÓDIGO DA EMPRESA AU-  *}
  {* TOMATICAMENTE                         *}
  {**************************************MV*}
  strCampoEmp := '';

  If Not (fCfgSis('EMPGER', varBoolean)) Then
  Begin
    dbeCodEmp.Enabled := False;
    dbeCodEmp.TabStop := False;

    btnAlterar.Tag := 88;
    btnExcluir.Tag := 88;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  if blnIniciaCadastro then
  begin
    btnIncluir.Click;

    if fltValLanLoc <> 0 then
      dbeValSta.DataSource.DataSet.FieldByName('MCA_VALSTA').Value := fltValLanLoc;

    if dteDataLanLoc <> 0 then
    begin
      dtsMovCar.DataSet.FieldByName('MCA_DTACAD').Value := dteDataLanLoc;
      dtsMovCar.DataSet.FieldByName('MCA_DTAVEN').Value := dteDataLanLoc;
      dtsMovCar.DataSet.FieldByName('MCA_DTACUP').Value := dteDataLanLoc;
    end;

    if strHist01Loc <> '' then
      dbeHist01.DataSource.DataSet.FieldByName('MCA_HIST01').Value := strHist01Loc;

    blnChamadoDoManutencao := True;
  end;

  strCodPorCredMovBan  := '';
  strCodPlanCredMovBan := '';
  grbMovBan.Visible    := blnChamadoDoManutencao;

  If (Not fEmptyStr(strNumDup)) Or (Not fEmptyStr(FAutoincrem)) Then
  Begin
    pCarregaDadosCartao(FAutoincrem);
    If btnAlterar.Enabled Then
      pSetFocus(btnAlterar)
    Else
      pSetFocus(btnIncluir);
  End
  Else
    pSetFocus(btnIncluir);

  pCarregaDadosAdicionais;

  //Verifica se o layout do help está cadastrado, para exibir o botão de ajuda.
  pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);
  btnAjuda.Visible := frmRelAjudaMod.fVerificaHelpExiste(Self.Name, 'CUPONS_CARTOES');
  pFreeAndNil(frmRelAjudaMod);

  LUtilizaModuloContabil :=  fCfgSis('UTICON', varBoolean);

  If FExtratoVendaCartao Then
  Begin
    btnIncluir.Click;
    CarregaDadosCartaoVenda;
    blnChamadoDoManutencao := True;
    grbMovBan.Visible  := blnChamadoDoManutencao;
  End;

  If FVendaMarketplace Then
  Begin
    btnIncluir.Click;
    If qryTabela.State = dsInsert Then
      CarregaDadosVendaMarketplace;
  End;

end;

procedure TfrmCadMovCartoes.btnIncluirClick(Sender: TObject);
  Var
    frmPorCredMovban: TfrmPorCredMovban;
begin
  If LUtilizaModuloContabil Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido inclusão manual quando configurado para utilizar a rotina de contabilidade!', ['&O k']);
    Exit;
  End;

  inherited;
  btnBaixarCartoes.Enabled := False;
  pIniciaValoresPadrao;
  pCarregaDadosAdicionais;
  pLimpaDadosBaixa;
  pHabilitaCodigo(dbeNumDup, dbeNumDup, True);
  strLibAnt := '';
  pHabDesBotoes(False);
  btnEspelhoTEF.Enabled := False;
  dbeDtaCad.Enabled:= True;
  dbeDtaVen.Enabled:= True;
  dbeDtaCup.Enabled:= True;
  btnAltPortador.Enabled := False;

  ADataCadastroInicial := dbeDtaCad.Date;
  ADataTransacaoInicial := dbeDtaCup.Date;

  If blnChamadoDoManutencao Then
  Begin
    pCriarFormularios(TfrmPorCredMovban, frmPorCredMovban);
    frmPorCredMovban.Caption := 'Dados para crédito no Movimento Bancário';
    frmPorCredMovban.rdgTipoCheque.Hide;
    frmPorCredMovban.Height := 190;
    frmPorCredMovban.edtPorBai.Text := fCfgSis('PORCRT');
    frmPorCredMovban.fraPlanoDeContas.MskCodCta.Text := fCfgSis('CTTRCR');
    frmPorCredMovban.ShowModal;

    If Not frmPorCredMovban.blnConfirma then
    Begin
      fMensagem('Atenção', 'Seleção obrigatória de portador e plano de contas',['&OK']);
      FreeAndNil(frmPorCredMovBan);
      btnCancela.Click;
      Exit;
    End;

    {*REQ*145940**********RP*}
    If Not fEmpresaTemAcessoPortador(frmPorCredMovban.edtPorBai.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      FreeAndNil(frmPorCredMovBan);
      btnCancela.Click;
      Exit;
    End;

    strCodPorCredMovBan  := frmPorCredMovBan.edtPorBai.Text;
    strCodPlanCredMovBan := frmPorCredMovBan.fraPlanoDeContas.MskCodCta.Text;

    dbePorCar.Field.Value := strCodPorCredMovBan;
    fraPlanoDeContas.dbeCodCta.Field.Value := strCodPlanCredMovBan;

    pCarregaPortador;
    pCarregaCentroCusto;

    FreeAndNil(frmPorCredMovBan);
  End;

  FCartaoAnterior := '';
  CarregaDadosCartaoVenda;
end;

procedure TfrmCadMovCartoes.btnEspelhoTEFClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmEspelhoTEF, frmEspelhoTEF);
  Try
    frmEspelhoTEF.strNumCar := qryTabela.FieldByName('MCA_NUMDUP').AsString;
    frmEspelhoTEF.strCodEmp := qryTabela.FieldByName('MCA_CODEMP').AsString;
    frmEspelhoTEF.strCodCli := qryTabela.FieldByName('MCA_CODCLI').AsString;
    frmEspelhoTEF.SeqCon := qryTabela.FieldByName('MCA_SEQCON').AsString;
    frmEspelhoTEF.DtaCad := qryTabela.FieldByName('MCA_DTACAD').AsDateTime;
    frmEspelhoTEF.NumNsu := qryTabela.FieldByName('MCA_NUMNSU').AsString;
    frmEspelhoTEF.TipCar := qryTabela.FieldByName('MCA_TIPCAR').AsString;
    if frmEspelhoTEF.fEspelhoTEFCartao then
      frmEspelhoTEF.ShowModal;
  Finally
    FreeAndNil(frmEspelhoTEF);
  End;
end;

procedure TfrmCadMovCartoes.btnEstornoMovCartaoClick(Sender: TObject);
  Var
    frmEstornaCartoes : TfrmEstornaCartoes;
begin
  If (btnEstornoMovCartao.Enabled) And (Not qryTabela.IsEmpty) Then
    begin
      try
        pCriarFormularios(TfrmEstornaCartoes, frmEstornaCartoes);

        frmEstornaCartoes.edtCodCar.Text := qryTabela.FieldByName('MCA_CODCAR').AsString;
        frmEstornaCartoes.edtDesCar.Text := fRetNomeCartao(qryTabela.FieldByName('MCA_CODCAR').AsString);
        frmEstornaCartoes.mskDtaIni.Text := qryTabela.FieldByName('MCA_DTAVEN').AsString;
        frmEstornaCartoes.mskDtaFin.Text := qryTabela.FieldByName('MCA_DTAVEN').AsString;
        frmEstornaCartoes.EmpresaCadastroMovimento := qryTabela.FieldByName('MCA_CODEMP').AsString;
        frmEstornaCartoes.ShowModal;

        qryTabela.Refresh;

        pCarregaDadosAdicionais;

        pHabDesBotoes(True);

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmCadMovCartoes.btnEstornoMovCartaoClick]');
      End;

      pFreeAndNil(frmEstornaCartoes);
    end;
end;

procedure TfrmCadMovCartoes.btnAjudaClick(Sender: TObject);
begin
  inherited;
  If Not TBitBtnLocked(Sender).Visible Then
    Exit;

  pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);
  frmRelAjudaMod.pAbreAjuda(Self.Name, 'CUPONS_CARTOES');
  pFreeAndNil(frmRelAjudaMod);
end;

procedure TfrmCadMovCartoes.btnAjuValClick(Sender: TObject);
begin
  inherited;
  If Not TBitBtnLocked(Sender).Enabled Then
    Exit;

  If (Not fVerificaAcessoSistema('CARALTTODAS', strLoginUsuarioLogado)) then
  Begin
    pMensagemOK('Usuário sem direito de acesso para utilizar a função.');
    Exit;
  End;

  If (Not qryTabela.Active) Or (qryTabela.IsEmpty) Then
  Begin
    pMensagemOK('É necessário possuir algum registro selecionado para utilizar essa função.');
    Exit;
  End;

  pCriarFormularios(TfrmCadMovCartoesParcelas, frmCadMovCartoesParcelas);
  frmCadMovCartoesParcelas.pCarregaParcelas(qryTabela.FieldByName('MCA_NUMDUP').AsString,
                                            qryTabela.FieldByName('MCA_CODEMP').AsString,
                                            qryTabela.FieldByName('MCA_CODCLI').AsString,
                                            0);
  If frmCadMovCartoesParcelas.blnAltPar Then
  Begin
    frmCadMovCartoesParcelas.AlterarCartaoCaixaVinculado := fBaixaCaixaVinculado;
    frmCadMovCartoesParcelas.ShowModal;

    If Not blnChamadoDoManutencao Then
      FAtualizarBaixa := frmCadMovCartoesParcelas.MudouQuantidadeParcelas;
  End
  Else
    frmCadMovCartoesParcelas.Close;

  FreeAndNil(frmCadMovCartoesParcelas);

  qryTabela.Close;
  qryTabela.Open;
  pCarregaDadosAdicionais;
  pCarregaDadosBaixa;
  pHabDesBotoes(True);
  pSetFocus(btnAlterar);
end;

procedure TfrmCadMovCartoes.btnAlterarClick(Sender: TObject);
  Var
    blnPodeAlterar: Boolean;
    blnCfg_UtiCon : Boolean;
begin
  blnPodeAlterar := True;
  If Not (fCfgSis('EMPGER', varBoolean)) Then
  Begin
    If (Not fEmptyStr(dbeCodEmp.Text)) Then
    Begin
      If dbeCodEmp.Text = VS_strCodEmp Then
        blnPodeAlterar := True
      Else
        blnPodeAlterar := False;
    End;
  End;

  blnCfg_UtiCon := fCfgSis('UTICON', varBoolean);

  If blnPodeAlterar Then
  Begin
    strLibAnt    := dbeNumLib.Text;
    strPorCarAnt := dbePorCar.Text;
    strCtaCarAnt := fraPlanoDeContas.dbeCodCta.Text;
    fltValStaAnt := fStrToFloat(dbeValSta.Text);
    FCuponDescontoAnt := fStrToFloat(dbeCupMkt.Text);

    inherited;

    dbeDtaCad.Enabled:= True;
    dbeDtaVen.Enabled:= True;
    dbeDtaCup.Enabled:= True;

    ADataCadastroInicial := dbeDtaCad.Date;
    ADataTransacaoInicial := dbeDtaCup.Date;

    If blnAlterou Then
    Begin
      btnBaixarCartoes.Enabled := False;
      pHabilitaCodigo(dbeNumDup, dbeNumLib, False);
      dbeParcel.Enabled := False;
      dbeCodEmp.Enabled := False;
      dbeCodCli.Enabled := False;

      If (Not blnCfg_UtiCon) Then
      Begin
        dbeCodCar.Enabled := True;
        dbeDtaCad.Enabled := True;
        dbePorCar.Enabled := True;
        FraPlanoDeContas.dbeCodCta.Enabled := True;
        FraPlanoDeContas.edtDesCta.Enabled := True;

        dbeValSta.Enabled := fVerificaAcessoSistema('CARALTVLSTX'  , strLoginUsuarioLogado);
        dbePerCar.Enabled := fVerificaAcessoSistema('CARALTTXVLADM', strLoginUsuarioLogado);
        dbeValTax.Enabled := fVerificaAcessoSistema('CARALTTXVLADM', strLoginUsuarioLogado);
        dbeValDup.Enabled := fVerificaAcessoSistema('CARALTVLDOC'  , strLoginUsuarioLogado);

        dbeNumLib.enabled := True;
        dbeNumNSU.enabled := True;
        dbeDtaCup.enabled := True;
        //dbeDtaVen.enabled := True;

      End
      Else
      Begin
        dbeCodCar.Enabled := False;
        dbeDtaCad.Enabled := False;
        dbePorCar.Enabled := False;
        FraPlanoDeContas.dbeCodCta.Enabled := False;
        FraPlanoDeContas.edtDesCta.Enabled := False;

        dbeValSta.Enabled := False; //fVerificaAcessoSistema('CARALTVLSTX'  , strLoginUsuarioLogado);
        dbePerCar.Enabled := False; //fVerificaAcessoSistema('CARALTTXVLADM', strLoginUsuarioLogado);
        dbeValTax.Enabled := False; //fVerificaAcessoSistema('CARALTTXVLADM', strLoginUsuarioLogado);
        dbeValDup.Enabled := False; //fVerificaAcessoSistema('CARALTVLDOC'  , strLoginUsuarioLogado);

        dbeNumLib.enabled := False;
        dbeNumNSU.enabled := False;
        dbeDtaCup.enabled := False;
        //dbeDtaVen.enabled := False;

      End;

      If (Not dtsMovCar.Dataset.IsEmpty) Then
        pHabDesBotoes(False);
      btnEspelhoTEF.Enabled := True;

      If (Not fEmptyStr(dbeCodEmp.Text)) Then
      Begin
        {******************************************}
        {* EMPRESA MATRIZ ALTERA QUALQUER EMPRESA *}
        {***************************************RV*}
        If (VS_strCodEmp = fCfgSis('EMPMAT')) Then
        Begin
          dbeCodEmp.Enabled := True;
          dbeCodEmp.TabStop := True;
        End
        {******************************************}
        {* EMPRESA NÃO-MATRIZ - SOMENTE MESMA EMP *}
        {***************************************RV*}
        Else
        Begin
          If (dbeCodEmp.Text = VS_strCodEmp) Then
          Begin
            dbeCodEmp.Enabled := True;
            dbeCodEmp.TabStop := True;
          End;
        End;
      End;

      If Not blnChamadoDoManutencao Then
      Begin
        dbeCodEmp.Enabled := False;
        dbeNumLib.Enabled := FRotinaOrigem = roBaixaCartoes;

        If dbeNumLib.Enabled Then
          pSetFocus(dbeNumLib)
        Else
          pSetFocus(dbeNumNSU);
      End;
    End;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Uma Loja Filial só pode alterar Duplicatas por ela Gerada!', ['&O k']);
  End;

  If fMovimentoBancario(True) Then
  Begin
    dbeNumLib.Enabled := False;
    dbeNumNsu.Enabled := False;
    dbeCodCar.enabled := False;
    fraPlanoDeContas.dbeCodCta.enabled := False;
    dbeDtaCad.enabled := False;
    dbeDtaCup.enabled := False;
    dbeDtaVen.enabled := False;
    dbeValSta.Enabled := False;
    dbeValSta.Enabled := False;
    dbeValDup.Enabled := False;
    dbeDtaVen.Enabled := False;
    dbePerCar.Enabled := False;
    dbePorCar.Enabled := False;
    fraPlanoDeContas.dbeCodCta.Enabled := False;
    dbeCodEmp.Enabled := False;

    fMensagem('Atenção','A movimentação bancária do cartão já está conciliada, é possível '  +
                        'alterar somente os dados histórico do cartão.',['&OK']);
    pSetFocus(dbeHist01);
  End
  Else
  Begin

    If (Not blnCfg_UtiCon) Then
       dbePorCar.Enabled := (qryTabela.FieldByName('AUTOINCREM').IsNull)
    Else
       dbePorCar.Enabled := False;

    btnAltPortador.Enabled   := (qryTabela.State = dsEdit)     and
                                (not dbePorCar.Enabled)        and
                                (blnChamadoDoManutencao);

    If (Not blnCfg_UtiCon) Then
       fraPlanoDeContas.dbeCodCta.Enabled :=  btnAltPortador.Enabled
    Else
       fraPlanoDeContas.dbeCodCta.Enabled := False;

  End;

  FCartaoAnterior := dbeCodCar.Text;
end;

procedure TfrmCadMovCartoes.btnAltPortadorClick(Sender: TObject);
  Var
    frmDigPortador : TfrmDigPortador;
begin
  inherited;

  pCriarFormularios(TfrmDigPortador, frmDigPortador);
  frmDigPortador.Caption           := 'Dados para Crédito no Movimento Bancário';
  frmDigPortador.edtPorBai.Text    := qryTabela.FieldByName('MCA_PORCAR').AsString;
  frmDigPortador.bolMostraVendedor := False;
  frmDigPortador.pCarregaPortador;
  frmDigPortador.ShowModal;

  If frmDigPortador.blnConfirma Then
  Begin
    {*REQ*145940**********RP*}
    If Not fEmpresaTemAcessoPortador(frmDigPortador.strCodPor, dbeCodEmp.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
      FreeAndNil(frmDigPortador);
      Exit;
    End;

    qryTabela.FieldByName('MCA_PORCAR').AsString := frmDigPortador.strCodPor;
    edtDesPorCar.Text := fRetNomPortador(dbePorCar.Text);
  End;

  If (qryTabela.State = dsEdit) And (frmDigPortador.blnConfirma) Then
  Begin
    dbePorCar.Field.Value := frmDigPortador.strCodPor;
    edtDesPorCar.text     := fRetNomPortador(dbePorCar.Text);
  End;

  FreeAndNil(frmDigPortador);
  pSetFocus(btnGravar);
end;

procedure TfrmCadMovCartoes.pIniciaValoresPadrao;
begin
  qryTabela.FieldByName('MCA_DTACAD').AsString := FormatDateTime('dd/mm/yyyy', VS_Date);
  qryTabela.FieldByName('MCA_DTAVEN').AsString := FormatDateTime('dd/mm/yyyy', VS_Date);
  qryTabela.FieldByName('MCA_DTACUP').AsString := FormatDateTime('dd/mm/yyyy', VS_Date);

  qryTabela.FieldByName('MCA_TRFLIB').AsString := 'S';

  dbeCodEmp.Field.AsString   := VS_strCodEmp;
  dbeCodEmp.DataSource.Dataset.FieldByName('MCA_TIPCAR').AsString := 'POS';
  dbeCodEmp.DataSource.Dataset.FieldByName('MCA_TIPBAI').AsString := 'B';
  dbeFreMkt.Field.AsFloat := 0.00;
  dbeFreMkt.Text := '0,00';
  dbeCupMkt.Field.AsFloat := 0.00;
  dbeCupMkt.Text := '0,00';
end;

procedure TfrmCadMovCartoes.btnExcluirClick(Sender: TObject);
  Var
    blnPodeExcluir: Boolean;
    strSenha: String;
Begin
  if qryTabela.isempty then
  begin
    pMensagemOK('Favor escolher um registro para essa operação!');
    exit;
  end;
  {****************************************}
  {* BLOQUEIA A EXCLUSÃO DE DOCS BAIXADOS *}
  {*************************************AJ*}
  If Not fEmptyStr(edtDtaRec.Text) Then
  Begin
    pMensagemOK('Esse documento não pode ser excluído, pois já foi baixado. Deverá ser feito o estorno antes de excluí-lo!');
    Exit;
  End;

  If fMovimentoBancario(True) Then
  Begin
    fMensagem('ATENÇÃO','A movimentação bancária do cartão já está conciliada, portanto não é possível excluir o registro.',['&OK']);
    Exit;
  End;

  //FECHAMENTO FINANCEIRO
  if objFechamento.FechamentoFinanceiroJaRealizado(qryTabela.FieldByName('MCA_CODEMP').AsString, qryTabela.FieldByName('MCA_DTACAD').AsDateTime) then
    Exit;

  if objFechamento.FechamentoFinanceiroJaRealizado(qryTabela.FieldByName('MCA_CODEMP').AsString, qryTabela.FieldByName('MCA_DTACUP').AsDateTime) then
    Exit;

  strSenha := '';
  blnPodeExcluir := True;
  {*****************************************}
  {* FAZ VALIDAÇÕES SOBRE A EMPRESA GEREN- *}
  {* CIAL                                  *}
  {**************************************MV*}
  If Not (fCfgSis('EMPGER', varBoolean)) Then
  Begin
    If (Not fEmptyStr(dbeCodEmp.Text)) Then
    Begin
      If dbeCodEmp.Text = VS_strCodEmp Then
        blnPodeExcluir := True
      Else
        blnPodeExcluir := False;
    End;
  End;

  {*****************************************}
  {* CASO SEJA EMPRESA GERENCIAL, OU SEJA  *}
  {* UMA DUPLICATA DA PROPRIA LOJA, PODE   *}
  {* EXCLUIR                               *}
  {**************************************MV*}
  If blnPodeExcluir Then
  Begin
    If ffrmSenha(strSenha) Then
    Begin
      If strSenha = fCfgSis('SEXCRT') Then
      Begin
        blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
        inherited;

        If (blnExcluiu) Then
          fCommit
        Else
          fRollBack;

        If Not blnChamadoDoManutencao Then
          FAtualizarBaixa := blnExcluiu;

        pCarregaDadosAdicionais;
        pHabDesBotoes(True);
      End;
    End;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Uma Loja Filial só pode Excluir Duplicatas por ela Gerada!', ['&O k']);
  End;
end;

procedure TfrmCadMovCartoes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaDadosAdicionais;
  btnBaixarCartoes.Enabled := blnChamadoDoManutencao;
  pHabDesBotoes(True);
  dbeDtaCad.Enabled:= False;
  dbeDtaVen.Enabled:= False;
  dbeDtaCup.Enabled:= False;
  btnAltPortador.Enabled := False;
  blnExitCodCar := False;
end;

procedure TfrmCadMovCartoes.btnDetalharValoresBaixaClick(Sender: TObject);
  Var
    LMcaDetalhesBaixa: TfrmMcaDetalhesBaixa;
begin
  pCriarFormularios(TfrmMcaDetalhesBaixa, LMcaDetalhesBaixa);
  Try
    LMcaDetalhesBaixa.edtValorBruto.Text := FormatFloat(',0.00', qryTabela.FieldByName('MCA_VALSTA').AsFloat);
    LMcaDetalhesBaixa.edtValorRecebido.Text := FormatFloat(',0.00', qryTabela.FieldByName('MCA_VALREC').AsFloat);
    LMcaDetalhesBaixa.edtValorDeTaxas.Text := FormatFloat(',0.00', qryTabela.FieldByName('MCA_VALTAX').AsFloat);
    LMcaDetalhesBaixa.edtValorDeFrete.Text := FormatFloat(',0.00', qryTabela.FieldByName('MCA_FREMKT').AsFloat);
    LMcaDetalhesBaixa.edtValorDeAjustes.Text := FormatFloat(',0.00', qryTabela.FieldByName('MCA_VALAJU').AsFloat);
    LMcaDetalhesBaixa.edtValorDeCupomDesconto.Text := FormatFloat(',0.00', qryTabela.FieldByName('MCA_CUPMKT').AsFloat);
    LMcaDetalhesBaixa.ShowModal;
  Finally
    FreeAndNil(LMcaDetalhesBaixa);
  End;
end;

procedure TfrmCadMovCartoes.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrMov: TConsultasArray;
    intOpcao: Integer;
begin
  intOpcao := fMensagem('', 'OPÇÃO',['TODOS', 'BAIXADOS', 'ABERTOS']);
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  chrKey := '/';
  strPorCarAnt := '';
  If fPesqMovtoCartao(Self, Nil, qryTabela, chrKey, arrMov, True, intOpcao) Then
  Begin
    pCarregaDadosAdicionais;
    pCarregaDadosBaixa;
    pHabDesBotoes(True);
    pSetFocus(btnAlterar);
    ADataCadastroInicial  := qryTabela.FieldByName('MCA_DTACAD').AsDateTime;
    ADataTransacaoInicial := qryTabela.FieldByName('MCA_DTACUP').AsDateTime;
  End;

  fraPlanoDeContas.dbeCodCta.Field.EditMask := '99.99.999;0;_';
end;

procedure TfrmCadMovCartoes.CarregaDadosCartaoVenda;
begin
  If Not FExtratoVendaCartao Then
    Exit;

  SetValorCampo(dbeParcel,FExtMca.FieldByName('EXT_PARCEL').AsString);
  SetValorCampo(dbeNumLib,FExtMca.FieldByName('EXT_CODAUT').AsString);
  SetValorCampo(dbeNumNSU,FExtMca.FieldByName('EXT_NUMNSU').AsString);
  SetValorCampo(dbeDtaCup,FExtMca.FieldByName('EXT_DTACUP').AsString);
  SetValorCampo(dbeDtaCad,FExtMca.FieldByName('EXT_DTACUP').AsString, True);
  SetValorCampo(dbeDtaVen,FExtMca.FieldByName('EXT_DTAVEN').AsString, True);


  SetValorCampo(dbeValSta,FormatFloat('#,##0.00',FExtMca.FieldByName('EXT_VALBRU').AsFloat).Replace('.',''));
  SetValorCampo(dbeValTax,FormatFloat('#,##0.00',FExtMca.FieldByName('EXT_VALTAX').AsFloat).Replace('.',''));
  SetValorCampo(dbeValDup,FormatFloat('#,##0.00',FExtMca.FieldByName('EXT_VALLIQ').AsFloat).Replace('.',''));
  dbePerCar.Enabled := False;

end;

procedure TfrmCadMovCartoes.CarregaExtratoVenda(AAutoincrem: String);
begin
  FExtratoVendaCartao := True;

  Try
    FExtMca := fCriaQuery(Nil);
    FExtMca.Close;
    FExtMca.SQL.Clear;
    FExtMca.SQL.Text := 'SELECT * FROM EXTMCA WHERE AUTOINCREM = :AUTINC';
    FExtMca.ParamByName('AUTINC').AsString := AAutoincrem;
    FExtMca.Open;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create (E.Message);
    End;
  End;

end;

function TfrmCadMovCartoes.fOrigemExternaCarregada: Boolean;
begin
  Result := FExtratoVendaCartao Or FVendaMarketplace;
end;

function TfrmCadMovCartoes.CarregaVendaMarketplace(const AJsonVenda: String): Boolean;
  Var
    LJson: TJSONValue;
    LMotivo: String;
begin
  If Assigned(FVendaMktJson) Then
    FreeAndNil(FVendaMktJson);

  LJson := TJSONObject.ParseJSONValue(AJsonVenda);
  If LJson Is TJSONObject Then
    FVendaMktJson := TJSONObject(LJson)
  Else
    FreeAndNil(LJson);

  LMotivo := 'Dados da venda em formato inválido.';
  Result := Assigned(FVendaMktJson) And fVendaMarketplaceValida(LMotivo);

  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível carregar os dados da venda do marketplace.' + #13 + LMotivo, ['&OK']);
    Exit;
  End;

  FVendaMarketplace := True;
  FVendaMktGravada  := False;
end;

function TfrmCadMovCartoes.fDataVendaMarketplace(const AParcela: TJSONValue; const AChave: String;
  out AData: TDateTime): Boolean;
  Var
    LTexto: String;
begin
  AData := 0;
  Result := AParcela.TryGetValue<String>(AChave, LTexto) And (LTexto.Length = 10);
  If Not Result Then
    Exit;

  Result := TryEncodeDate(StrToIntDef(Copy(LTexto, 1, 4), 0),
                          StrToIntDef(Copy(LTexto, 6, 2), 0),
                          StrToIntDef(Copy(LTexto, 9, 2), 0), AData);
end;

function TfrmCadMovCartoes.fVendaMarketplaceValida(out AMotivo: String): Boolean;
  Var
    LParcelas: TJSONArray;
    LParcela: TJSONValue;
    LTexto: String;
    LValor: Double;
    LData: TDateTime;
begin
  Result := False;
  AMotivo := 'Dados da venda em formato inválido.';

  If (Not FVendaMktJson.TryGetValue<String>('CODEMP', LTexto)) Or LTexto.IsEmpty Then
    Exit;
  If (Not FVendaMktJson.TryGetValue<String>('NUMNSU', LTexto)) Or LTexto.IsEmpty Then
    Exit;
  If (Not FVendaMktJson.TryGetValue<TJSONArray>('PARCELAS', LParcelas)) Or (LParcelas.Count = 0) Then
    Exit;

  If LParcelas.Count > 26 Then
  Begin
    AMotivo := 'O envio ' + LTexto + ' possui ' + LParcelas.Count.ToString + ' pedidos, e o lançamento de cartão ' +
               'comporta no máximo 26 parcelas (A a Z).';
    Exit;
  End;

  For LParcela In LParcelas Do
  Begin
    If Not (LParcela Is TJSONObject) Then
      Exit;
    If (Not LParcela.TryGetValue<String>('ORDEID', LTexto)) Or LTexto.IsEmpty Then
      Exit;
    If Not (LParcela.TryGetValue<Double>('VALBRU', LValor) And LParcela.TryGetValue<Double>('VALLIQ', LValor)) Then
      Exit;
    If Not (LParcela.TryGetValue<Double>('VALFRE', LValor) And LParcela.TryGetValue<Double>('VALCUP', LValor)) Then
      Exit;
    If Not (fDataVendaMarketplace(LParcela, 'DTATRA', LData) And fDataVendaMarketplace(LParcela, 'DTAVEN', LData)) Then
      Exit;
  End;

  AMotivo := '';
  Result := True;
end;

procedure TfrmCadMovCartoes.CarregaDadosVendaMarketplace;
  Var
    LParcelas: TJSONArray;
    LParcelaA: TJSONObject;
    LCartoes: TArray<String>;
    LCartao: String;
    LQtdCartoes,
    LIndice: Integer;
    LTotalBruto: Double;
    LDataTransacao,
    LDataVencimento: TDateTime;

  function fFormataValor(AValor: Double): String;
  begin
    Result := FormatFloat('#,##0.00', AValor).Replace('.', '');
  end;

begin
  LParcelas := FVendaMktJson.GetValue<TJSONArray>('PARCELAS');
  LParcelaA := LParcelas.Items[0] As TJSONObject;

  SetValorCampo(dbeCodEmp, FVendaMktJson.GetValue<String>('CODEMP'));
  SetValorCampo(dbeNumDup, fRetSequencialMovCar('MOVCAR', dbeCodEmp.Text));
  SetValorCampo(dbeParcel, 'A');

  LQtdCartoes := 0;
  LCartoes := String(fCfgSis('MERCAR', varString, dbeCodEmp.Text)).Split(['_']);
  For LIndice := 0 To High(LCartoes) Do
    If Not LCartoes[LIndice].Trim.IsEmpty Then
    Begin
      Inc(LQtdCartoes);
      LCartao := LCartoes[LIndice].Trim;
    End;
  If LQtdCartoes = 1 Then
    SetValorCampo(dbeCodCar, LCartao);

  SetValorCampo(dbeNumNSU, FVendaMktJson.GetValue<String>('NUMNSU'));
  SetValorCampo(dbeNumLib, FVendaMktJson.GetValue<String>('NUMNSU'));
  qryTabela.FieldByName('MCA_ORDEID').AsString := LParcelaA.GetValue<String>('ORDEID');

  fDataVendaMarketplace(LParcelaA, 'DTATRA', LDataTransacao);
  fDataVendaMarketplace(LParcelaA, 'DTAVEN', LDataVencimento);
  SetValorCampo(dbeDtaCup, DateToStr(LDataTransacao));
  SetValorCampo(dbeDtaCad, DateToStr(LDataTransacao), True);
  SetValorCampo(dbeDtaVen, DateToStr(LDataVencimento), True);

  dbeFreMkt.Field.AsFloat := LParcelaA.GetValue<Double>('VALFRE');
  dbeCupMkt.Field.AsFloat := LParcelaA.GetValue<Double>('VALCUP');
  dbeFreMkt.Enabled := False;
  dbeCupMkt.Enabled := False;
  SetValorCampo(dbeValSta, fFormataValor(LParcelaA.GetValue<Double>('VALBRU')));
  SetValorCampo(dbeValDup, fFormataValor(LParcelaA.GetValue<Double>('VALLIQ')));
  dbePerCar.Enabled := False;

  LTotalBruto := 0;
  For LIndice := 0 To LParcelas.Count - 1 Do
    LTotalBruto := LTotalBruto + (LParcelas.Items[LIndice] As TJSONObject).GetValue<Double>('VALBRU');

  Caption := Caption + ' - Mercado Livre: envio ' + FVendaMktJson.GetValue<String>('NUMNSU') +
             ', ' + LParcelas.Count.ToString + ' parcela(s), total R$ ' + FormatFloat('#,##0.00', LTotalBruto);

  pSetFocus(dbeCodCli);
end;

function TfrmCadMovCartoes.fCartaoPermitidoVendaMarketplace: Boolean;
  Var
    LCartoes: TArray<String>;
    LIndice: Integer;
begin
  Result := False;

  LCartoes := String(fCfgSis('MERCAR', varString, dbeCodEmp.Text)).Split(['_']);
  For LIndice := 0 To High(LCartoes) Do
    If (Not LCartoes[LIndice].Trim.IsEmpty) And (LCartoes[LIndice].Trim = dbeCodCar.Text) Then
      Exit(True);

  fMensagem('ATENÇÃO', 'O cartão ' + dbeCodCar.Text + ' não faz parte dos cartões configurados para o Mercado Livre na empresa ' +
                       dbeCodEmp.Text + '.' + #13 +
                       'Verifique em Útil > Configuração do Sistema, grupo CARTÕES: ' +
                       '"MERCADO LIVRE - Cartões para os lançamentos de baixa de recebíveis".', ['&OK']);
  pSetFocus(dbeCodCar);
end;

function TfrmCadMovCartoes.fParcelasVendaMarketplaceValidas: Boolean;
  Var
    LParcelas: TJSONArray;
    LIndice: Integer;
    LDataTransacao,
    LDataVencimento: TDateTime;
    LMotivo: String;
begin
  Result := True;

  LParcelas := FVendaMktJson.GetValue<TJSONArray>('PARCELAS');
  For LIndice := 1 To LParcelas.Count - 1 Do
  Begin
    fDataVendaMarketplace(LParcelas.Items[LIndice], 'DTATRA', LDataTransacao);
    fDataVendaMarketplace(LParcelas.Items[LIndice], 'DTAVEN', LDataVencimento);

    LMotivo := '';
    If LDataTransacao > VS_Date Then
      LMotivo := 'a data de cadastro é maior que a data atual'
    Else If LDataVencimento < LDataTransacao Then
      LMotivo := 'a data de vencimento é menor que a data de cadastro'
    Else If objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, LDataTransacao, False) Then
      LMotivo := 'a data de cadastro está em período com fechamento financeiro já realizado';

    If Not LMotivo.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Não é possível gravar a venda: na parcela ' + Chr(Ord('A') + LIndice) +
                           ' (pedido ' + LParcelas.Items[LIndice].GetValue<String>('ORDEID') + ', data ' +
                           DateToStr(LDataTransacao) + '), ' + LMotivo + '.', ['&OK']);
      Exit(False);
    End;
  End;
end;

procedure TfrmCadMovCartoes.pDefinePortadorDebitoVendaMarketplace;
  Var
    qryConPor: TUniQuery;
    strPorDeb,
    strCtaDeb: String;
begin
  pPesquisaCadCar(qryConCar, qryConCar, dbeCodCar.Text);
  strPorDeb := qryConCar.FieldByName('CAR_PORBAD').AsString;
  strCtaDeb := qryConCar.FieldByName('CAR_CTABAD').AsString;

  qryConPor := fCriaQuery;
  Try
    qryConPor.SQL.Text := 'SELECT CON_PORDEB, CON_CTADEB FROM CONPOR WHERE CON_CODCAR = :CODCAR AND CON_CODEMP = :CODEMP';
    qryConPor.ParamByName('CODCAR').AsString := dbeCodCar.Text;
    qryConPor.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
    qryConPor.Open;

    If Not qryConPor.IsEmpty Then
    Begin
      strPorDeb := qryConPor.FieldByName('CON_PORDEB').AsString;
      strCtaDeb := qryConPor.FieldByName('CON_CTADEB').AsString;
    End;
  Finally
    FreeAndNil(qryConPor);
  End;

  blnChamadoDoManutencao := Not fEmptyStr(strPorDeb);
  grbMovBan.Visible      := blnChamadoDoManutencao;

  If Not blnChamadoDoManutencao Then
  Begin
    fMensagem('ATENÇÃO', 'Não será lançado o crédito no portador de débito, pois o cartão ' + dbeCodCar.Text +
                         ' não possui portador de débito configurado.', ['&OK']);
    Exit;
  End;

  strCodPorCredMovBan  := strPorDeb;
  strCodPlanCredMovBan := strCtaDeb;

  dbePorCar.Field.Value := strCodPorCredMovBan;
  fraPlanoDeContas.dbeCodCta.Field.Value := strCodPlanCredMovBan;
  pCarregaPortador;
  pCarregaCentroCusto;
end;

function TfrmCadMovCartoes.fGravaParcelasAdicionaisVendaMarketplace(out AErro: String): Boolean;
  Var
    LParcelas: TJSONArray;
    LParcela: TJSONObject;
    LValoresParcelaA: Array Of Variant;
    LIndice,
    LCampo: Integer;
    LBruto,
    LLiquido,
    LFrete,
    LCupom: Double;
    LDataTransacao,
    LDataVencimento: TDateTime;
begin
  Result := True;
  AErro  := '';

  LParcelas := FVendaMktJson.GetValue<TJSONArray>('PARCELAS');
  If LParcelas.Count <= 1 Then
    Exit;

  Try
    SetLength(LValoresParcelaA, qryTabela.FieldCount);
    For LCampo := 0 To qryTabela.FieldCount - 1 Do
      LValoresParcelaA[LCampo] := qryTabela.Fields[LCampo].Value;

    For LIndice := 1 To LParcelas.Count - 1 Do
    Begin
      LParcela := LParcelas.Items[LIndice] As TJSONObject;

      LBruto   := LParcela.GetValue<Double>('VALBRU');
      LLiquido := LParcela.GetValue<Double>('VALLIQ');
      LFrete   := LParcela.GetValue<Double>('VALFRE');
      LCupom   := LParcela.GetValue<Double>('VALCUP');

      qryTabela.Append;
      For LCampo := 0 To qryTabela.FieldCount - 1 Do
        qryTabela.Fields[LCampo].Value := LValoresParcelaA[LCampo];

      qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('MOVCAR', VS_strCodEmp);
      qryTabela.FieldByName('MCA_PARCEL').AsString := Chr(Ord('A') + LIndice);
      qryTabela.FieldByName('MCA_ORDEID').AsString := LParcela.GetValue<String>('ORDEID');
      fDataVendaMarketplace(LParcela, 'DTATRA', LDataTransacao);
      fDataVendaMarketplace(LParcela, 'DTAVEN', LDataVencimento);
      qryTabela.FieldByName('MCA_DTACUP').AsDateTime := LDataTransacao;
      qryTabela.FieldByName('MCA_DTACAD').AsDateTime := LDataTransacao;
      qryTabela.FieldByName('MCA_DTAVEN').AsDateTime := LDataVencimento;

      qryTabela.FieldByName('MCA_VALSTA').AsFloat := LBruto;
      qryTabela.FieldByName('MCA_FREMKT').AsFloat := LFrete;
      qryTabela.FieldByName('MCA_CUPMKT').AsFloat := LCupom;
      qryTabela.FieldByName('MCA_VALDUP').AsFloat := LLiquido;
      qryTabela.FieldByName('MCA_VALORI').AsFloat := LLiquido;
      qryTabela.FieldByName('MCA_VALTAX').AsFloat := fFormataFloat(LBruto - (LLiquido + LFrete - LCupom), 2);
      qryTabela.FieldByName('MCA_PERCAR').AsFloat := 0;
      If LBruto > 0 Then
        qryTabela.FieldByName('MCA_PERCAR').AsFloat := fFormataFloat(qryTabela.FieldByName('MCA_VALTAX').AsFloat / LBruto * 100, 6);

      qryTabela.Post;

      pGravaLogMca(qryTabela.FieldByName('AUTOINCREM').AsString, 'INCLUSÃO', Self.Name);

      If blnChamadoDoManutencao And (Not fGravaMovimentoBancario('C')) Then
        Exit(False);
    End;
  Except
    On E: Exception Do
    Begin
      If qryTabela.State In [dsInsert, dsEdit] Then
        qryTabela.Cancel;

      AErro  := E.Message;
      Result := False;
    End;
  End;
end;

function TfrmCadMovCartoes.CartaoGeradoPeloCaixa: Boolean;
begin
  Result := Not qryTabela.FieldByName('MCA_EMPRCX').IsNull;

  If Result Then
    Result := qryTabela.FieldByName('MCA_RESCAI').AsString = '1';
end;

function TfrmCadMovCartoes.dbeCodEmpChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadEmp(Key);
end;

function TfrmCadMovCartoes.dbeCodCliChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCli(Key);
end;

function TfrmCadMovCartoes.dbeCodCarChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCar(Key);
end;

procedure TfrmCadMovCartoes.dbeCodCarEnter(Sender: TObject);
begin
  inherited;
  LValidarMesmoCartao := True;
end;

procedure TfrmCadMovCartoes.dbeCodCarExit(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(dbeCodCar.Text) Then
  Begin
    blnExitCodCar := True;
    fValidaCampos(dbeCodCar);
  End;
end;

procedure TfrmCadMovCartoes.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmp, True, True) Then
  Begin
    If fValidaCampos(dbeCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovCartoes.dbeDtaCadPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if qryTabela.State in  [dsEdit, dsInsert] then
    qryTabela.FieldByName('MCA_DTACAD').AsString := dbeDtaCad.Text;
end;

procedure TfrmCadMovCartoes.dbeDtaCupPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if qryTabela.State in  [dsEdit, dsInsert] then
    qryTabela.FieldByName('MCA_DTACUP').AsString := dbeDtaCup.Text;
end;

procedure TfrmCadMovCartoes.dbeDtaVenPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  if qryTabela.State in  [dsEdit, dsInsert] then
    qryTabela.FieldByName('MCA_DTAVEN').AsString := dbeDtaVen.Text;
end;

procedure TfrmCadMovCartoes.dbeNumNSUKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Not CharInSet(Key, ['0'..'9', #8, #9]) Then
    Key := #0

end;

procedure TfrmCadMovCartoes.dbeCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovCartoes.dbeCodCarKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCartao : TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE CARTOES  *}
  {**************************DP*}
  If fPesqCartao(Self, dbeCodCar, edtDesCar, Nil, Key, arrCartao, True, False, False, False, False, False, dbeCodEmp.Text) Then
  Begin
      If (fValidaCampos(Self, True)) Then
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCartao;
  End;
end;

procedure TfrmCadMovCartoes.btnBaixarCartoesClick(Sender: TObject);
  Var
    frmBaixaCartoes : TfrmBaixaCartoes;
begin
  inherited;
  If Not fVerificaAcessoSistema('frmBaixaCartoes') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso para baixa de cartões!', ['&O k']);
    Exit;
  End;

  pCriarFormularios(TfrmBaixaCartoes, frmBaixaCartoes);

  if dteDataLanLoc <> 0 then
    frmBaixaCartoes.dteDtaRecFix   := dteDataLanLoc;
  if strCodPorLoc  <> '' then
    frmBaixaCartoes.strCodPorFix   := strCodPorLoc;
  if fltValLanLoc <> 0 then
    frmBaixaCartoes.fltValorBaixa  := fltValLanLoc;

  try
    frmBaixaCartoes.ShowModal;
  finally
    arrSeqLanloc := frmBaixaCartoes.arrSeqLanLoc;
    FreeAndNil(frmBaixaCartoes);
  end;

  if Length(arrSeqLanLoc) > 0 then
  begin
    btnSair.Click;
    Exit;
  end;

  // Comentado conforme requisito 118869
  //edtNomEmp.Clear;
  //edtNomCli.Clear;
  //edtDesCar.Clear;
  pRecarregaCartaoAberto;
  pCarregaDadosBaixa;
  pHabDesBotoes(True);
end;

procedure TfrmCadMovCartoes.pCarregaDadosBaixa;
  Var
    strSQL   : String;
    qryGenCar: TUniQuery;

    LMarketPlace: Boolean;

    LValorDaAntecipacao: Double;
begin
  Try

    qryGenCar := fCriaQuery(Self);

    {*****************************************}
    {* SE A DUPLICATA NAO ESTA BAIXADA, SAI  *}
    {**************************************MV*}
    If Not fDuplicataCartaoBaixada(qryTabela.FieldByName('MCA_NUMDUP').AsString,
                                   qryTabela.FieldByName('MCA_PARCEL').AsString,
                                   qryTabela.FieldByName('MCA_CODCLI').AsString,
                                   qryTabela.FieldByName('MCA_CODEMP').AsString) Then
    Begin

      pLimpaDadosBaixa;

      If (qryTabela.State = dsBrowse) Then
      Begin
        {******************************************}
        {* EMPRESA NÃO-GERENCIAL - NÃO ALTERA NADA*}
        {***************************************RV*}
        If Not (fCfgSis('EMPGER', varBoolean)) Then
        Begin
          dbeCodEmp.Enabled := False;
          dbeCodEmp.TabStop := False;

          btnAlterar.Tag := 88;
          btnExcluir.Tag := 88;
          btnAlterar.Enabled := False;
          btnExcluir.Enabled := False;
        End
        {******************************************}
        {* EMPRESA GERENCIAL                      *}
        {***************************************RV*}
        Else
        Begin
          If (Not fEmptyStr(dbeCodEmp.Text)) Then
          Begin
            {******************************************}
            {* EMPRESA MATRIZ ALTERA QUALQUER EMPRESA *}
            {***************************************RV*}
            If (VS_strCodEmp = fCfgSis('EMPMAT')) Then
            Begin
              dbeCodEmp.TabStop := True;

              btnAlterar.Tag := 0;
              btnExcluir.Tag := 0;
              btnAlterar.Enabled := True;
              btnExcluir.Enabled := True;
            End
            {******************************************}
            {* EMPRESA NÃO-MATRIZ - SOMENTE MESMA EMP *}
            {***************************************RV*}
            Else
            Begin
              If (dbeCodEmp.Text = VS_strCodEmp) Then
              Begin
                dbeCodEmp.TabStop := True;

                btnAlterar.Tag := 0;
                btnExcluir.Tag := 0;
                btnAlterar.Enabled := True;
                btnExcluir.Enabled := True;
              End
              Else
              Begin
                dbeCodEmp.Enabled := False;
                dbeCodEmp.TabStop := False;

                btnAlterar.Tag := 88;
                btnExcluir.Tag := 88;
                btnAlterar.Enabled := False;
                btnExcluir.Enabled := False;
              End;
            End;
          End;

          If (fCfgSis('RCXTCC') = '2') And
           (qryTabela.FieldByName('MCA_DTATRA').AsDateTime = 0) And
           (qryTabela.FieldByName('MCA_RESCAI').AsString = '1') Then
          Begin
            btnAlterar.Enabled := False;
            btnExcluir.Enabled := False;
          End;

        End;

      End;

      Exit;

    End;

    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;

    LValorDaAntecipacao := 0.00;
    If Not qryTabela.FieldByName('MCA_ANTTAX').IsNull Then
      LValorDaAntecipacao := qryTabela.FieldByName('MCA_ANTTAX').AsFloat;

    edtDtaRec.Text  := qryTabela.FieldByName('MCA_DTAREC').AsString;
    edtValRec.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('MCA_VALREC').AsFloat);
    edtValTax.Text  := FormatFloat('#,##0.00', qryTabela.FieldByName('MCA_VALTAX').AsFloat -
                                               LValorDaAntecipacao);

    edtValorTaxaAntecipacao.Text := FormatFloat('#,##0.00', LValorDaAntecipacao);

    If fFormataFloat(qryTabela.FieldByName('MCA_VALSTA').AsFloat, 2) > 0 Then
    Begin
      edtPercentualAntBaixa.Text := FormatFloat(',0.000000', (LValorDaAntecipacao /
                                                              qryTabela.FieldByName('MCA_VALSTA').AsFloat) * 100);

      edtPercentualTaxaBaixa.Text := FormatFloat(',0.000000', ((qryTabela.FieldByName('MCA_VALTAX').AsFloat -
                                                                LValorDaAntecipacao) /
                                                                qryTabela.FieldByName('MCA_VALSTA').AsFloat) * 100);
    End;

    LMarketPlace := fCampoTabela('CAR_MKTPLA', 'CADCAR', ['CAR_CODCAR'], [qryTabela.FieldByName('MCA_CODCAR').AsString]) = 'S';
    btnDetalharValoresBaixa.Visible := LMarketPlace;
    btnDetalharValoresBaixa.Enabled := Not qryTabela.FieldByName('MCA_DTAREC').AsString.IsEmpty;

    {*****************************************}
    {* CARREGA O PORTADOR E A CONTA DA BAIXA *}
    {**************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(MCA_CTABAI, " - ", CTA_DESCTA) AS CTABAI, ';
    strSQL := strSQL + '  CONCAT(MCA_PORBAI, " - ", POR_NOMPOR) AS PORBAI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVCAR, ';
    strSQL := strSQL + '  CADCTA, ';
    strSQL := strSQL + '  CADPOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MCA_CTABAI = CTA_CODCTA AND ';
    strSQL := strSQL + '  MCA_PORBAI = POR_CODPOR AND ';
    strSQL := strSQL + '  MCA_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  MCA_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  MCA_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  MCA_CODEMP = :CODEMP ';

    If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (IFNULL(MCA_PORBAI, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(MCA_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(MCA_PORBTX, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(MCA_PORBTX, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(MCA_PORDEB, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(MCA_PORDEB, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    With qryGenCar Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := qryTabela.FieldByName('MCA_NUMDUP').AsString;
      ParamByName('PARCEL').AsString := qryTabela.FieldByName('MCA_PARCEL').AsString;
      ParamByName('CODCLI').AsString := qryTabela.FieldByName('MCA_CODCLI').AsString;
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('MCA_CODEMP').AsString;
      Open;
      edtPorBai.Text := FieldByName('PORBAI').AsString;
      edtCtaBai.Text := FieldByName('CTABAI').AsString;
      Close;
    End;

    {*****************************************}
    {* CARREGA O PORTADOR E A CONTA DA BAIXA *}
    {**************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(MCA_CTABTX, " - ", CTA_DESCTA) AS CTABTX, ';
    strSQL := strSQL + '  CONCAT(MCA_PORBTX, " - ", POR_NOMPOR) AS PORBTX ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVCAR, ';
    strSQL := strSQL + '  CADCTA, ';
    strSQL := strSQL + '  CADPOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MCA_CTABTX = CTA_CODCTA AND ';
    strSQL := strSQL + '  MCA_PORBTX = POR_CODPOR AND ';
    strSQL := strSQL + '  MCA_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  MCA_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  MCA_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  MCA_CODEMP = :CODEMP ';

    If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (IFNULL(MCA_PORBTX, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(MCA_PORBTX, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(MCA_PORBAI, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(MCA_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
      strSQL := strSQL + '  AND (IFNULL(MCA_PORDEB, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(MCA_PORDEB, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    With qryGenCar Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := qryTabela.FieldByName('MCA_NUMDUP').AsString;
      ParamByName('PARCEL').AsString := qryTabela.FieldByName('MCA_PARCEL').AsString;
      ParamByName('CODCLI').AsString := qryTabela.FieldByName('MCA_CODCLI').AsString;
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('MCA_CODEMP').AsString;
      Open;
      edtPorBaiTaxa.Text := FieldByName('PORBTX').AsString;
      edtCtaBaiTaxa.Text := FieldByName('CTABTX').AsString;
      Close;
    End;

    edtDocBanBai.Text   := qryTabela.FieldByName('MCA_DOCBAN').AsString;
    edtDocBanTaxa.Text  := qryTabela.FieldByName('MCA_DOCBTX').AsString;

  Finally
    FreeAndNil(qryGenCar);
  End;

end;

procedure TfrmCadMovCartoes.pCarregaDadosCartao(strIncCar: string = '');
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
  strSQL := strSQL + '   *                        ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   MOVCAR                   ';
  strSQL := strSQL + ' WHERE                      ';

  if fEmptyStr(strIncCar) then
  begin
    strSQL := strSQL + '   MCA_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   MCA_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   MCA_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   MCA_CODCLI = :CODCLI AND ';
    If fEmptyStr(strDocume) Then
      strSQL := strSQL + '   (MCA_DOCUME IS NULL OR MCA_DOCUME = "") AND '
    Else
      strSQL := strSQL + '   MCA_DOCUME = :DOCUME AND ';
    strSQL := strSQL + '   MCA_NUMCCD = :NUMCCD     ';
  end
  else
    strSQL := strSQL + ' MOVCAR.AUTOINCREM = ' + QuotedStr(strIncCar);

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    if fEmptyStr(strIncCar) then
    begin
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      If Not fEmptyStr(strDocume) Then
        ParamByName('DOCUME').AsString := strDocume;
      ParamByName('NUMCCD').AsString := strNumCcd;
    end;

    Open;
  End;

  pCarregaDadosAdicionais;
  pCarregaDadosBaixa;
  pHabDesBotoes(True);
end;

procedure TfrmCadMovCartoes.btnGravarClick(Sender: TObject);
  Var
    blnInserindo,
    LFecharJanela: Boolean;
    strErroParcelas: String;

begin
  blnExitCodCar := False;

  If Not fValidacoesBotaoGravarPai Then
     Exit;

  If FVendaMarketplace And (qryTabela.State = dsInsert) Then
  Begin
    If Not fCartaoPermitidoVendaMarketplace Then
      Exit;

    If Not fParcelasVendaMarketplaceValidas Then
      Exit;

    pDefinePortadorDebitoVendaMarketplace;
  End;

  LFecharJanela := False;

  qryTabela.FieldByName('MCA_CODOPE').AsString := strLoginUsuarioLogado;

  If Not CartaoGeradoPeloCaixa Then
    qryTabela.FieldByName('MCA_EMPRCX').AsString := qryTabela.FieldByName('MCA_CODEMP').AsString;

  blnInserindo := qryTabela.State = dsInsert;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadMovCartoes.btnGravarClick]');
    End;
  End;

  If qryTabela.State = dsBrowse Then
  Begin
    Try
      blnGravou := Not fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString);
      If Not blnGravou Then
      Begin
        LFecharJanela := True;

        Raise Exception.Create('Não foi possível gravar o sequencial para o registro. Operação cancelada!');
      End;

      {**********************************************}
      {* CASO GRAVOU, GRAVA A TABELA LOGMCA         *}
      {*******************************************AJ*}
      pGravaLogMca(qryTabela.FieldByName('AUTOINCREM').AsString, IIF(blnInserindo,'INCLUSÃO','ALTERAÇÃO'),
                   Self.Name);

      If blnChamadoDoManutencao Then
      Begin
        If blnInserindo Then
        Begin
          If Not fGravaMovimentoBancario('C') Then
          Begin
            fRollBack;
            fMensagem('ATENÇÃO','Não gravou movimento bancário. Operação será cancelada!',['&OK']);

            If FVendaMarketplace Then
            Begin
              blnGravou := False;
              qryTabela.Close;
              Self.Close;
            End;

            Exit;
          End;
        End
        Else
        If fMovimentoBancario Then
          pAtualizaCartaoMovBan;
      End;

      If FVendaMarketplace And blnInserindo Then
      Begin
        If Not fGravaParcelasAdicionaisVendaMarketplace(strErroParcelas) Then
        Begin
          fRollBack;
          blnGravou := False;
          fMensagem('ATENÇÃO','Não gravou as demais parcelas da venda. Operação será cancelada!' +
                    IIF(strErroParcelas.IsEmpty, '', #13 + strErroParcelas),['&OK']);
          qryTabela.Close;
          Self.Close;
          Exit;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[btnGravarClick]');

        If LFecharJanela Then
        Begin
          If qryTabela.State <> dsBrowse Then
            qryTabela.Cancel;

          Self.Close;
        End;
      End;
    End;
  End;

  pHabDesBotoes(blnGravou);
  If blnGravou Then
  Begin
    fCommit;
    btnBaixarCartoes.Enabled := blnChamadoDoManutencao;

    If FVendaMarketplace Then
    Begin
      FVendaMktGravada := True;
      Self.Close;
      Exit;
    End;
  End
  Else
    fRollBack;

  dbeDtaCad.Enabled:= not blnGravou;
  dbeDtaVen.Enabled:= not blnGravou;
  dbeDtaCup.Enabled:= not blnGravou;
  btnAltPortador.Enabled := not blnGravou;
end;

procedure TfrmCadMovCartoes.btnHistRecebClick(Sender: TObject);
  Var
    frmRelCartoesLogAcomp: TfrmRelCartoesLogAcomp;
begin
  inherited;
 If (qryTabela.IsEmpty) Or (fEmptyStr(dbeNumDup.Text))Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmRelCartoesLogAcomp, frmRelCartoesLogAcomp);
    frmRelCartoesLogAcomp.edtCodEmp.Text := qryTabela.FieldByName('MCA_CODEMP').AsString;
    frmRelCartoesLogAcomp.edtCodCli.Text := qryTabela.FieldByName('MCA_CODCLI').AsString;
    frmRelCartoesLogAcomp.edtNumDup.Text := qryTabela.FieldByName('MCA_NUMDUP').AsString;
    frmRelCartoesLogAcomp.edtParcel.Text := qryTabela.FieldByName('MCA_PARCEL').AsString;
    frmRelCartoesLogAcomp.blnVeioManutencao  := True;
    frmRelCartoesLogAcomp.pCarregaCampos;
    if frmRelCartoesLogAcomp.qryConsulta.IsEmpty then
      fMensagem('ATENÇÃO!', 'Sem dados para exibir!', ['&O k'])
    else
      frmRelCartoesLogAcomp.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadMovCartoes.btnHistReceb]');
  End;
  pFreeAndNil(frmRelCartoesLogAcomp);
end;

procedure TfrmCadMovCartoes.pLimpaDadosBaixa;
begin
  edtDtaRec.Clear;
  edtValRec.Clear;
  edtValTax.Clear;
  edtPorBai.Clear;
  edtCtaBai.Clear;
  edtPorBaiTaxa.Clear;
  edtCtaBaiTaxa.Clear;
  edtDocBanBai.Clear;
  edtDocBanTaxa.Clear;
  edtValorTaxaAntecipacao.Clear;
  edtPercentualTaxaBaixa.Clear;
  edtPercentualAntBaixa.Clear;

  btnDetalharValoresBaixa.Visible := False;
end;

class procedure TfrmCadMovCartoes.pMostraIniciandoCadastro(fltValLan: Double;
  strHist01: String; dteDataLan: TDate; strCodPor: String; var arrSeqLan: TStringArray);
begin
  pCriarFormularios(TfrmCadMovCartoes, frmCadMovCartoes);
  try
    with frmCadMovCartoes do
    begin
      blnIniciaCadastro := True;

      fltValLanLoc  := fltValLan;
      strHist01Loc  := strHist01;
      dteDataLanLoc := dteDataLan;
      strCodPorLoc  := strCodPor;

      ShowModal;

      arrSeqLan     := arrSeqLanLoc;
    end;
  except
    On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadMovCartoes.pMostraIniciandoCadastro]');
  end;
  pFreeAndNil(frmCadMovCartoes);
end;

procedure TfrmCadMovCartoes.dbeParcelKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not CharInSet(Key, ['0'..'9', 'A'..'Z', 'a'..'z', #8, #9]) Then
    Key := #0;
end;

procedure TfrmCadMovCartoes.dbePerCarExit(Sender: TObject);
begin
  inherited;
  pCalculaValorDocumento(True);
  fValidaCampos(dbePerCar);
end;

procedure TfrmCadMovCartoes.dbePorCarKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  If fPesqPortador(conSimples,
                   Self,
                   dbePorCar,
                   edtDesPorCar,
                   nil,
                   Key,
                   arrSel,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   dbeCodEmp.Text) Then
  Begin
    If fValidaCampos(dbePorCar) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadMovCartoes.dbeValDupExit(Sender: TObject);
begin
  inherited;
  pCalculaValorDocumento(False, True);
  fValidaCampos(dbeValDup);
end;

procedure TfrmCadMovCartoes.dbeValStaExit(Sender: TObject);
begin
  inherited;
  pCalculaValorDocumento(strTipTax = 'P');
  fValidaCampos(dbeValSta);
end;

procedure TfrmCadMovCartoes.dbeValTaxExit(Sender: TObject);
begin
  inherited;
  pCalculaValorDocumento(False);
  fValidaCampos(dbeValTax);
end;

{******************************************}
{* VERIFICANDO SE FOR VINCULADO, O CARTÃO *}
{* DEVE TER SIDO TRANSFERIDO E O CAIXA    *}
{* FECHADO PARA PODER ALTERAR/EXCLUIR     *}
{***************************************AJ*}
function TfrmCadMovCartoes.fBaixaCaixaVinculado: Boolean;
  Var
    fltUltFec: Double;
    dtaDtaFec: TDateTime;

    LDataLancamentoCaixa: TDateTime;

    LJaTransferido: Boolean;
begin
  pRetornaUltimoFechamento(fltUltFec,
                           dtaDtaFec,
                           qryTabela.FieldByName('MCA_EMPRCX').AsString,
                           qryTabela.FieldByName('MCA_CODCAX').AsString);

  Result := (fCfgSis('RCXTCC') = 1);

  If Not Result Then
    Result := qryTabela.FieldByName('MCA_RESCAI').AsString <> '1';

  LJaTransferido := Result;

  If Not Result Then
  Begin
    If qryTabela.FieldByName('MCA_DTATRA').AsDateTime <> 0 Then
    Begin
      LDataLancamentoCaixa := TResumoDeCaixa.RetornaDataDoLancamentoCaixa(qryTabela.FieldByName('MCA_SEQCON').AsInteger,
                                                                          qryTabela.FieldByName('MCA_DTACAD').AsDateTime,
                                                                          qryTabela.FieldByName('MCA_EMPRCX').AsString,
                                                                          qryTabela.FieldByName('MCA_CODCAX').AsString);

      Result := LDataLancamentoCaixa <= dtaDtaFec;

      If Result Then
        Result := LDataLancamentoCaixa < VS_Date;

      LJaTransferido := qryTabela.FieldByName('MCA_DTAREC').IsNull;
    End;
  End;

  If Result Then
  Begin
    Result := untMovCar.TransferenciaLiberada(FLiberacaoTransferencia,
                                              qryTabela.FieldByName('MCA_RESCAI').AsString = '1',
                                              qryTabela.FieldByName('MCA_TRFLIB').AsString);

    If Not Result Then
      fMensagem('ATENÇÃO', 'Não é possível alterar o registro pois a transferência não foi liberada.', ['&Ok']);
  End;

  btnAlterar.Enabled := Result;
  btnExcluir.Enabled := Result;
  btnAjuVal.Enabled  := Result;

  If Not btnAjuVal.Enabled Then
    btnAjuVal.Enabled := LJaTransferido;
end;

function TfrmCadMovCartoes.fGravaDebitoMovBanRefExclusao: Boolean;
var
  strHisMca: String;

  LBanMcaDS: TBanMcaDS;

  LListaBanMca: TListaBanMca;
begin
  strHisMca := 'EXC.CARTÃO ' + Concat(qryTabela.FieldByName('MCA_NUMDUP').AsString,'-',
                                      qryTabela.FieldByName('MCA_PARCEL').AsString,'-',
                                      qryTabela.FieldByName('MCA_CODCLI').AsString,'-',
                                      qryTabela.FieldByName('MCA_CODEMP').AsString);

  LListaBanMca := TListaBanMca.Create;
  Try
    LBanMcaDS := TBanMcaDS.Create;
    LBanMcaDS.strNumDup := dbeNumDup.Text;
    LBanMcaDS.strParcel := dbeParcel.Text;
    LBanMcaDS.strCodEmp := dbeCodEmp.Text;
    LBanMcaDS.strCodCli := dbeCodCli.Text;
    LBanMcaDS.strCodCar := dbeCodCar.Text;
    LBanMcaDS.strHist01 := dbeHist01.Text;
    LBanMcaDS.strHist02 := dbeHist02.Text;
    LBanMcaDS.strNumCCD := dbeNumLib.Text;
    LBanMcaDS.strNumNsu := dbeNumNsu.Text;
    LBanMcaDS.fltValSta := fStrToFloat(dbeValSta.Text);
    LBanMcaDS.fltValTax := 0;
    LBanMcaDS.fltValRec := 0;
    LBanMcaDS.fltFreMkt := 0;
    LBanMcaDS.fltValAju := 0;
    LBanMcaDS.fltCupMkt := fStrToFloat(dbeCupMkt.Text);
    LBanMcaDS.strIdenti := 'VALSTA';

    LListaBanMca.Add(LBanMcaDS);

    Result := fGravaMovBan(fraPlanoDeContas.dbeCodCta.Text,      // Centro de Custo
                           dbePorCar.Text,                       // Portador da Baixa
                           strLoginUsuarioLogado,                // Operador da Baixa
                           VS_Date,                              // Data do Lançamento
                           fTime(),                              // Hora do Lançamento
                           dbeNumDup.Text,                       // Numero do Documento
                           'D',                                  // Credito / Debito
                           VS_strCodEmp,                         // Empresa da Baixa
                           fStrToFloat(dbeValSta.Text) +
                             fStrToFloat(dbeCupMkt.Text),        // Valor Do Lançamento
                           strHisMca,                            // Histórico 1
                           '',                                   // Histórico 2
                           '',                                   // Cliente da Duplicata
                           '',                                   // Fornecedor da Duplicata
                           dbeNumDup.Text,                       // Número da Duplicata
                           0,                                    // Sequencial de Baixa
                           '',                                   // Parcela da Duplicata
                           '',                                   // Empresa da Duplicata
                           '',                                   // Série
                           '',                                   // Código do Evento
                           '',                                   // Documento da Baixa
                           Nil,                                  // Log Bancário
                           0,
                           0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           1,
                           True,
                           LListaBanMca) <> '';

  Finally
    FreeAndNil(LListaBanMca);
  End;
end;

function TfrmCadMovCartoes.fGravaMovimentoBancario(strTipo: String;
                                                   strPorCar: String = '';
                                                   strCtaCar: String = '';
                                                   fltValSta: Double = 0;
                                                   ACupomDesconto: Double = 0) : Boolean;
var
  strHisMca: String;

  LBanMcaDS: TBanMcaDS;

  LListaBanMca: TListaBanMca;
begin
  strHisMca := 'REF.CARTÃO ' + Concat(qryTabela.FieldByName('MCA_NUMDUP').AsString,'-',
                                      qryTabela.FieldByName('MCA_PARCEL').AsString,'-',
                                      qryTabela.FieldByName('MCA_CODCLI').AsString,'-',
                                      qryTabela.FieldByName('MCA_CODEMP').AsString);

  LListaBanMca := TListaBanMca.Create;
  Try
    LBanMcaDS := TBanMcaDS.Create;
    LBanMcaDS.strNumDup := dbeNumDup.Text;
    LBanMcaDS.strParcel := dbeParcel.Text;
    LBanMcaDS.strCodEmp := dbeCodEmp.Text;
    LBanMcaDS.strCodCli := dbeCodCli.Text;
    LBanMcaDS.strCodCar := dbeCodCar.Text;
    LBanMcaDS.strHist01 := dbeHist01.Text;
    LBanMcaDS.strHist02 := dbeHist02.Text;
    LBanMcaDS.strNumCCD := dbeNumLib.Text;
    LBanMcaDS.strNumNsu := dbeNumNsu.Text;
    LBanMcaDS.fltValSta := IIF(fltValSta=0,fStrToFloat(dbeValSta.Text),fltValSta);
    LBanMcaDS.fltValTax := 0;
    LBanMcaDS.fltValRec := 0;
    LBanMcaDS.fltFreMkt := 0;
    LBanMcaDS.fltValAju := 0;
    LBanMcaDS.fltCupMkt := IIF(ACupomDesconto=0,fStrToFloat(dbeCupMkt.Text),ACupomDesconto);
    LBanMcaDS.strIdenti := 'VALSTA';

    LListaBanMca.Add(LBanMcaDS);

    Result := fGravaMovBan(IIF(fEmptyStr(strCtaCar),fraPlanoDeContas.dbeCodCta.Text,strCtaCar), // Centro de Custo
                           IIF(fEmptyStr(strPorCar),dbePorCar.Text,strPorCar), // Portador da Baixa
                           strLoginUsuarioLogado,                // Operador da Baixa
                           VS_Date,                              // Data do Lançamento
                           fTime(),                              // Hora do Lançamento
                           dbeNumDup.Text,                       // Numero do Documento
                           strTipo,                              // Credito / Debito
                           VS_strCodEmp,                         // Empresa da Baixa
                           IIF(fltValSta=0,fStrToFloat(dbeValSta.Text),fltValSta) +
                           IIF(ACupomDesconto=0,fStrToFloat(dbeCupMkt.Text),ACupomDesconto), // Valor Do Lançamento
                           strHisMca,                            // Histórico 1
                           '',                                   // Histórico 2
                           '',                                   // Cliente da Duplicata
                           '',                                   // Fornecedor da Duplicata
                           dbeNumDup.Text,                       // Número da Duplicata
                           0,                                    // Sequencial de Baixa
                           '',                                   // Parcela da Duplicata
                           '',                                   // Empresa da Duplicata
                           '',                                   // Série
                           '',                                   // Código do Evento
                           '',                                   // Documento da Baixa
                           Nil,                                  // Log Bancário
                           0,
                           0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           qryTabela.FieldByName('AUTOINCREM').AsString,
                           1,
                           True,
                           LListaBanMca
                          ) <> '';

  Finally
    FreeAndNil(LListaBanMca);
  End;
end;

function TfrmCadMovCartoes.fMovimentoBancario(blnConciliado : Boolean = False): Boolean;
var
  qryAux:TUniQuery;
begin

  strSeqLan := '';

  qryAux := fCriaQuery;

  Try
    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT CTB_SEQLAN, CTB_DTACON FROM MOVBAN  ');
      SQL.Add(' WHERE CTB_CREDEB = "C" AND     ');
      SQL.Add('       CTB_CODPOR = :PORCAR AND ');
      SQL.Add('       CTB_CODCAR = :AUTINC     ');
      SQL.Add(' ORDER BY CTB_SEQLAN DESC LIMIT 1 ');
      ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      ParamByName('PORCAR').AsString := IIF(fEmptyStr(strPorCarAnt),qryTabela.FieldByName('MCA_PORCAR').AsString,strPorCarAnt);
      Open;

      Result := Not IsEmpty;

      If Result Then
        strSeqLan := FieldByName('CTB_SEQLAN').AsString;

      If Result And blnConciliado Then
        Result := Not FieldByName('CTB_DTACON').IsNull;

      Close;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadMovCartoes.fObrigatorioPortadorEConta: Boolean;
begin
  Result := qryTabela.FieldByName('AUTOINCREM').IsNull Or fMovimentoBancario;
end;

end.


