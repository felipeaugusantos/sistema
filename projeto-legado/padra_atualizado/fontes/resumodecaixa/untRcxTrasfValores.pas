{**********************}
{* qryConPor = CADPOR *}
{*******************JB*}
unit untRcxTrasfValores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Uni,
  AppEvnts, DB, UniClientDataSet, frxClass, StrUtils, frxDBSet, BitBtnLockedIncrem,
  frxExportCSVTestabilidade, Datasnap.DBClient, Math, untLiberacao,
  untRcxTResumoDeCaixa, untTypesSistema;

type
  TfrmRcxTrasfValores = class(TfrmPai)
    pnlPortador: TPanel;
    pnlTotal: TPanel;
    pnlFundo: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    edtTotalAtu: TEditFocus;
    edtTotalTra: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    cdsChqAVi: TUniClientDataSet;
    cdsChqPre: TUniClientDataSet;
    cdsCarCre: TUniClientDataSet;
    edtDinheiroAtu: TEditFocus;
    edtChqVistaAtu: TEditFocus;
    edtChqPreAtu: TEditFocus;
    edtCartaoAtu: TEditFocus;
    EdtOrdPagAtu: TEditFocus;
    Label7: TLabel;
    edtCodPorDin: TEditFocus;
    edtDesPortadorDin: TEditFocus;
    edtDesPortadorChv: TEditFocus;
    edtCodPorChv: TEditFocus;
    edtCodPorChp: TEditFocus;
    edtDesPortadorChp: TEditFocus;
    edtDesPortadorCrt: TEditFocus;
    edtCodPorCrt: TEditFocus;
    edtCodPorOrd: TEditFocus;
    edtDesPortadorOrd: TEditFocus;
    Label8: TLabel;
    edtDinheiroTra: TEditFocus;
    edtChqVistaTra: TEditFocus;
    edtChqPreTra: TEditFocus;
    edtCartaoTra: TEditFocus;
    edtOrdPagTra: TEditFocus;
    lblTransf1: TLabel;
    Label10: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    lblTransf2: TLabel;
    edtDinheiroTra2: TEditFocus;
    edtChqVistaTra2: TEditFocus;
    edtChqPreTra2: TEditFocus;
    edtCartaoTra2: TEditFocus;
    edtOrdPagTra2: TEditFocus;
    edtTotalTra2: TEditFocus;
    Label9: TLabel;
    edtGruGpo: TEditFocus;
    edtDesGpo: TEditFocus;
    Label11: TLabel;
    edtCodPorFin: TEditFocus;
    edtDesPortadorFin: TEditFocus;
    edtValFinAtu: TEditFocus;
    edtValFinTra: TEditFocus;
    edtValFinTra2: TEditFocus;
    chkFechamento: TCheckBox;
    btnConfirmaDados: TBitBtnLocked;
    btnAltSeqFec: TBitBtnLocked;
    btnSelChAvi: TBitBtnLocked;
    btnSelChPre: TBitBtnLocked;
    btnSelCartao: TBitBtnLocked;
    btnCancTranf: TBitBtnLocked;
    btnConsTran: TBitBtnLocked;
    pnlMensagem: TPanel;
    Label12: TLabel;
    pnlFundoDeCaixa: TPanel;
    Label13: TLabel;
    edtFundoDeCaixaAtualizado: TEditFocus;
    chkPixAvulso: TCheckBox;
    pnlMensagemSaldoDinheiro: TPanel;
    lblMensagemSaldoDinheiro: TLabel;
    pnlSaldoNegativoOperador: TPanel;
    lblSaldoNegativoOperador: TLabel;
    pnlMensagemSaldoOrdemPagamento: TPanel;
    lblMensagemSaldoOrdemPagamento: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure edtCodPorDinExit(Sender: TObject);
    procedure edtCodPorChvExit(Sender: TObject);
    procedure edtCodPorChpExit(Sender: TObject);
    procedure edtCodPorCrtExit(Sender: TObject);
    procedure edtCodPorOrdExit(Sender: TObject);
    procedure edtCodPorDinKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorChvKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorChpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorCrtKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorOrdKeyPress(Sender: TObject; var Key: Char);
    procedure btnAltSeqFecClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSelChAviClick(Sender: TObject);
    procedure btnSelChPreClick(Sender: TObject);
    procedure btnSelCartaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruGpoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorEnter(Sender: TObject);
    procedure edtGruGpoEnter(Sender: TObject);
    procedure edtCodPorFinExit(Sender: TObject);
    procedure edtCodPorFinKeyPress(Sender: TObject; var Key: Char);
    procedure chkFechamentoClick(Sender: TObject);
    procedure btnCancTranfClick(Sender: TObject);
    procedure btnConsTranClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkPixAvulsoClick(Sender: TObject);
  private
    qryConPor: TUniQuery;
    qryCadOpe: TUniQuery;
    qryCadGpo: TUniQuery;
    strVenAnt: String;
    objLiberacao : TLiberacao;

    blnTransferenciaCega,
    blnTransferenciaMeioSeparada: Boolean;

    FOperadorObrigatorio,
    FTransferenciaPixAvulso,
    FTFVinculada: Boolean;

    FOperadorFechamento: String;

    FSaldoFechamentoDinheiro,
    FSaldoFechamentoOrdemPagamento,
    FValorTransferenciaDinheiro,
    FValorTransferenciaOrdemPagamento,
    FValorTransferenciaOperadorDinheiro,
    FValorTransferenciaOperadorOrdemPagamento: Double;

    FAutoIncremsCartoes,
    FAutoIncremsChequesAVista,
    FAutoIncremsChequesPre: TStringList;

    function fEdtCodPorExit(edtCodPor, edtDesPortador: TEditFocus; AModalidade: TModalidadeTransferencia):Boolean;
    procedure pEdtCodPorKeyPress(edtCodPor, edtDesPortador: TEditFocus; var Key: Char);
    procedure pAtualizaValDig;
    procedure pCarregaVendedor(strCodVen: String);
    procedure pCarregaValores;
    procedure pCarregaGrupoOpe(strCodGpo: String);

    procedure CalculaValoresDinheiroOrdemPgtoInicial;
    procedure ExibeMensagensFechamentoAnterior;
    procedure AjustaCamposDinheiroOrdemPagamentoSaldoInicial;

    function OperadorDeveSerObrigatorio: Boolean;
    function DeveCarregarETravarOperadorLogado: Boolean;
    function OperadorValidoParaTransferir: Boolean;
    { Private declarations }

  public
    fltValTot: Double;
    fltValDig: Double;
    fltDinhei: Double;
    fltChqVis: Double;
    fltChqPre: Double;
    fltCartao: Double;
    fltOrdPag: Double;
    fltValFin: Double;

    fltValDi2: Double;
    fltDinhe2: Double;
    fltChqVi2: Double;
    fltChqPr2: Double;
    fltCarta2: Double;
    fltOrdPa2: Double;
    fltValFi2: Double;
    strCodOpe: String;

    strCodigoCaixa  : String;
    objResumoDeCaixa: TResumoDeCaixa;

    FOrdemPagamento,
    FPixAvulso: Double;

    property TransferenciaPixAvulso: Boolean read FTransferenciaPixAvulso;

    property AutoIncremsCartoes: TStringList read FAutoIncremsCartoes;
    property AutoIncremsChequesAVista: TStringList read FAutoIncremsChequesAVista;
    property AutoIncremsChequesPre: TStringList read FAutoIncremsChequesPre;

    function fValidaValorMod(fltValDig, fltValAtu: Double; strModalidade: String; var edtPor: TEditFocus): Boolean;
    { Public declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaPortadores : Boolean;
    procedure pEscapePressed; Override;
  end;

implementation

uses untFuncoes, untfuncoesSimples, untRcxTransfDocs, untPaiOrdena, untPesqAux,
  untCadRcxx, untConsultas, untRcxCancTransfValores,
  untRcxConsTransfValores, untFuncFat;

{$R *.dfm}

function TfrmRcxTrasfValores.fEdtCodPorExit(edtCodPor, edtDesPortador: TEditFocus; AModalidade: TModalidadeTransferencia):Boolean;
begin
  Result := True;

  edtDesPortador.Text := '';
  If Not fEmptyStr(edtCodPor.Text) Then
    edtDesPortador.Text := fRetNomPortador(edtCodPor.Text);


  If fEmptyStr(edtDesPortador.Text) Then
  Begin
    fMensagem('AVISO','Código do portador não encontrado.', ['&O K']);
    edtCodPor.Clear;
    pSetFocus(edtCodPor);
    Result := False;
    Exit;
  End
  {*REQ*145940**********RP*}
  Else If Not fEmptyStr(edtCodPor.Text) And Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
    pSetFocus(edtCodPor);
    Result := False;
    Exit;
  End
  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    If Not fEmptyStr(edtCodPor.Text) Then
    Begin
      If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
      Begin
        fMensagem('','Usuário sem permissão de acesso a este portador!', ['&O K']);
        edtCodPor.Clear;
        pSetFocus(edtCodPor);
        Result := False;
        Exit;
      End;
    End;
  End;

  if not fPortadorTransfere(edtCodPor.Text, AModalidade) then
  Begin
    fMensagem('AVISO','Código do portador informado não permite transferências ou está desabilitado para a modalidade!', ['&O K']);
    edtCodPor.Clear;
    pSetFocus(edtCodPor);
    Result := False;
    Exit;
  End

end;

procedure TfrmRcxTrasfValores.PEdtCodPorKeyPress(edtCodPor, edtDesPortador: TEditFocus; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin

    if fPesqPortador(conTransfCx, Self, edtCodPor, edtDesPortador, qryConPor, Key, arrSel) then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;

  End;

end;

{*****************************************************}
{* COM A NOVA CONSULTA ESSE PROCEDURE CAIU EM DESUSO *}
{**************************************************JU*}
//procedure TfrmRcxTrasfValores.pCarregaPortador(edtCodPor, edtDesPortador: TEditFocus);


{************************************}
{* ATUALIZA VARIAVEIS E PANEL       *}
{*********************************AF*}
procedure TfrmRcxTrasfValores.pAtualizaValDig;
Begin
  fltDinhei := 0;
  fltChqVis := 0;
  fltChqPre := 0;
  fltCartao := 0;
  fltOrdPag := 0;
  fltValFin := 0;
  fltValDig := 0;

  fltDinhe2 := 0;
  fltChqVi2 := 0;
  fltChqPr2 := 0;
  fltCarta2 := 0;
  fltOrdPa2 := 0;
  fltValFi2 := 0;
  fltValDi2 := 0;

  If Not fEmptyStr(edtDinheiroTra.Text) Then fltDinhei := fStrToFloat(edtDinheiroTra.Text);
  If Not fEmptyStr(edtChqVistaTra.Text) Then fltChqVis := fStrToFloat(edtChqVistaTra.Text);
  If Not fEmptyStr(edtChqPreTra.Text)   Then fltChqPre := fStrToFloat(edtChqPreTra.Text);
  If Not fEmptyStr(edtCartaoTra.Text)   Then fltCartao := fStrToFloat(edtCartaoTra.Text);
  If Not fEmptyStr(edtOrdPagTra.Text)   Then fltOrdPag := fStrToFloat(edtOrdPagTra.Text);
  If Not fEmptyStr(edtValFinTra.Text)   Then fltValFin := fStrToFloat(edtValFinTra.Text);

  fltValDig := fltDinhei + fltChqVis + fltChqPre + fltCartao + fltOrdPag + fltValFin;
  edtTotalTra.Text := FloatToStrF(fltValDig,ffFixed,12,2);

  If (pnlFundoDeCaixa.Visible) And
     (Not blnTransferenciaCega) Then
    edtFundoDeCaixaAtualizado.Text := FormatFloat(',0.00', fFormataFloat(fStrToFloat(edtDinheiroAtu.Text) - fltDinhei, 2));

  If blnTransferenciaMeioSeparada Then
  Begin
    If Not fEmptyStr(edtDinheiroTra2.Text) Then fltDinhe2 := fStrToFloat(edtDinheiroTra2.Text);
    If Not fEmptyStr(edtChqVistaTra2.Text) Then fltChqVi2 := fStrToFloat(edtChqVistaTra2.Text);
    If Not fEmptyStr(edtChqPreTra2.Text)   Then fltChqPr2 := fStrToFloat(edtChqPreTra2.Text);
    If Not fEmptyStr(edtCartaoTra2.Text)   Then fltCarta2 := fStrToFloat(edtCartaoTra2.Text);
    If Not fEmptyStr(edtOrdPagTra2.Text)   Then fltOrdPa2 := fStrToFloat(edtOrdPagTra2.Text);
    If Not fEmptyStr(edtValFinTra2.Text)   Then fltValFi2 := fStrToFloat(edtValFinTra2.Text);

    fltValDi2 := fltDinhe2 + fltChqVi2 + fltChqPr2 + fltCarta2 + fltOrdPa2 + fltValFi2;
    edtTotalTra2.Text := FloatToStrF(fltValDi2,ffFixed,12,2);

    If (pnlFundoDeCaixa.Visible) And
       (Not blnTransferenciaCega) Then
      edtFundoDeCaixaAtualizado.Text := FormatFloat(',0.00', fFormataFloat(fStrToFloat(edtFundoDeCaixaAtualizado.Text) - fltDinhe2, 2));
  End;

End;

function TfrmRcxTrasfValores.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Var
  blnFocus: Boolean;
begin

  Result := True;
  blnFocus := True;

  If (Sender = edtCodVendedor) Then
  Begin
    If fEmptyStr(edtCodVendedor.Text) Then
    Begin
      If FOperadorObrigatorio Then
      Begin
          fMensagem('ATENÇÃO!','Informe o código do operador!',['&O K']);
          Result := False;
      End
      Else If (Not objResumoDeCaixa.strTipoFechamento.Equals('C')) Or
              (Not objResumoDeCaixa.TipoSaldoCaixa.Equals('O')) Then
      Begin
        edtDesVendedor.Text := 'TODOS';

        If (Not strVenAnt.Equals(edtCodVendedor.Text)) Then
          pCarregaValores;
      End;
    End
    Else
    Begin
      pCarregaVendedor(edtCodVendedor.Text);
      If (qryCadOpe.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!','Esse operador não está cadastrado!',['&O K']);
        Result := False;
      End
      Else
      Begin
        If (Not objResumoDeCaixa.strTipoFechamento.Equals('C')) Then
        Begin
          edtGruGpo.Clear;
          edtDesGpo.Text := 'TODOS';
        End;

        edtGruGpo.Enabled := False;

        If blnBuscaPorChave Or (strVenAnt <> edtCodVendedor.Text) Then
          pCarregaValores;
      End;
    End;

    strVenAnt := edtCodVendedor.Text;
  End

  Else If (Sender = edtGruGpo) And blnBuscaPorChave And
          (Not FOperadorObrigatorio) And
          (Not objResumoDeCaixa.strTipoFechamento.Equals('C')) Then
  Begin
    If fEmptyStr(edtGruGpo.Text) Then
    Begin
      edtDesGpo.Text := 'TODOS';
      pCarregaValores;
    End
    Else
    Begin
      pCarregaGrupoOpe(edtGruGpo.Text);
      If (qryCadGpo.IsEmpty) Then
      Begin
        fMensagem('','Esse grupo não está cadastrado!',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtCodVendedor.Clear;
        edtDesVendedor.Text := 'TODOS';
        edtCodVendedor.Enabled := False;

        pCarregaValores;
      End;
    End;
  End

  {************************************}
  {* VALIDA PORTADOR                  *}
  {*********************************AF*}
  Else If (Sender = edtCodPorDin) And fEmptyStr(edtCodPorDin.Text) Then edtDinheiroTra.Text := '0,00'
  Else If (Sender = edtCodPorChv) And fEmptyStr(edtCodPorChv.Text) Then edtChqVistaTra.Text := '0,00'
  Else If (Sender = edtCodPorChp) And fEmptyStr(edtCodPorChp.Text) Then edtChqPreTra.Text := '0,00'
  Else If (Sender = edtCodPorCrt) And fEmptyStr(edtCodPorCrt.Text) Then edtCartaoTra.Text := '0,00'
  Else If (Sender = edtCodPorOrd) And fEmptyStr(edtCodPorOrd.Text) Then edtOrdPagTra.Text := '0,00'
  Else If (Sender = edtCodPorFin) And fEmptyStr(edtCodPorFin.Text) Then edtValFinTra.Text := '0,00'

  {************************************}
  {* VALIDA DINHEIRO                  *}
  {*********************************AF*}
  Else If (Sender = edtDinheiroTra) Then
  Begin

    If (fEmptyStr(edtDinheiroTra.Text)) Then
      edtDinheiroTra.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtDinheiroTra.Text) + IIf(blnTransferenciaMeioSeparada, fStrToFloat(edtDinheiroTra2.Text), 0), fStrToFloat(edtDinheiroAtu.Text), 'dinheiro', edtCodPorDin);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA CHEQUE A VISTA            *}
  {*********************************AF*}
  Else If (Sender = edtChqVistaTra) Then
  Begin

    If (fEmptyStr(edtChqVistaTra.Text)) Then
      edtChqVistaTra.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtChqVistaTra.Text) + IIf(blnTransferenciaMeioSeparada, fStrToFloat(edtChqVistaTra2.Text), 0), fStrToFloat(edtChqVistaAtu.Text), 'cheque a vista', edtCodPorChv);

    If Result Then
      pAtualizaValDig
    Else
    Begin
      blnFocus := False;
      If btnSelChAvi.Visible Then pSetFocus(btnSelChAvi);
    End;

  End

  {************************************}
  {* VALIDA CHEQUE A PRAZO            *}
  {*********************************AF*}
  Else If (Sender = edtChqPreTra) Then
  Begin

    If (fEmptyStr(edtChqPreTra.Text)) Then
      edtChqPreTra.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtChqPreTra.Text) + IIf(blnTransferenciaMeioSeparada, fStrToFloat(edtChqPreTra2.Text), 0), fStrToFloat(edtChqPreAtu.Text), 'cheque - pré', edtCodPorChp);

    If Result Then
      pAtualizaValDig
    Else
    Begin
      blnFocus := False;
      If btnSelChPre.Visible Then pSetFocus(btnSelChPre);
    End;

  End

  {************************************}
  {* VALIDA CARTÃO                    *}
  {*********************************AF*}
  Else If (Sender = edtCartaoTra) Then
  Begin

    If (fEmptyStr(edtCartaoTra.Text)) Then
      edtCartaoTra.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtCartaoTra.Text) + IIf(blnTransferenciaMeioSeparada, fStrToFloat(edtCartaoTra2.Text), 0), fStrToFloat(edtCartaoAtu.Text), 'cartão', edtCodPorCrt);

    If Result Then
      pAtualizaValDig
    Else
    Begin
      blnFocus := False;
      If btnSelCartao.Visible Then pSetFocus(btnSelCartao);
    End;

  End

  {************************************}
  {* VALIDA ORDEM DE PAGTO            *}
  {*********************************AF*}
  Else If (Sender = edtOrdPagTra) Then
  Begin

    If (fEmptyStr(edtOrdPagTra.Text)) Then
      edtOrdPagTra.Text := '0,00'
    Else
    Begin
      If Not chkPixAvulso.Checked Then
        Result := fValidaValorMod(fStrToFloat(edtOrdPagTra.Text) + IIf(blnTransferenciaMeioSeparada, fStrToFloat(edtOrdPagTra2.Text), 0), fStrToFloat(edtOrdPagAtu.Text), 'ordem de pagamento', edtCodPorOrd)
      Else
        Result := fValidaValorMod(fStrToFloat(edtOrdPagTra.Text) + IIf(blnTransferenciaMeioSeparada, fStrToFloat(edtOrdPagTra2.Text), 0), fStrToFloat(edtOrdPagAtu.Text), 'pix avulso', edtCodPorOrd);
    End;

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA FINANCIAMENTO             *}
  {*********************************LA*}
  Else If (Sender = edtValFinTra) Then
  Begin

    If (fEmptyStr(edtValFinTra.Text)) Then
      edtValFinTra.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtValFinTra.Text) + IIf(blnTransferenciaMeioSeparada, fStrToFloat(edtValFinTra2.Text), 0), fStrToFloat(edtValFinAtu.Text), 'financiamento', edtCodPorFin);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA DINHEIRO 2                *}
  {*********************************AF*}
  Else If (Sender = edtDinheiroTra2) Then
  Begin

    If (fEmptyStr(edtDinheiroTra2.Text)) Then
      edtDinheiroTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtDinheiroTra.Text) + fStrToFloat(edtDinheiroTra2.Text),fStrToFloat(edtDinheiroAtu.Text), 'dinheiro', edtCodPorDin);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA CHEQUE A VISTA 2          *}
  {*********************************AF*}
  Else If (Sender = edtChqVistaTra2) Then
  Begin

    If (fEmptyStr(edtChqVistaTra2.Text)) Then
      edtChqVistaTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtChqVistaTra.Text) + fStrToFloat(edtChqVistaTra2.Text),fStrToFloat(edtChqVistaAtu.Text), 'cheque a vista', edtCodPorChv);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA CHEQUE A PRAZO 2          *}
  {*********************************AF*}
  Else If (Sender = edtChqPreTra2) Then
  Begin

    If (fEmptyStr(edtChqPreTra2.Text)) Then
      edtChqPreTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtChqPreTra.Text) + fStrToFloat(edtChqPreTra2.Text),fStrToFloat(edtChqPreAtu.Text), 'cheque - pré', edtCodPorChp);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA CARTÃO 2                  *}
  {*********************************AF*}
  Else If (Sender = edtCartaoTra2) Then
  Begin

    If (fEmptyStr(edtCartaoTra2.Text)) Then
      edtCartaoTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtCartaoTra.Text) + fStrToFloat(edtCartaoTra2.Text),fStrToFloat(edtCartaoAtu.Text), 'cartão', edtCodPorCrt);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA ORDEM DE PAGAMENTO 2      *}
  {*********************************AF*}
  Else If (Sender = edtOrdPagTra2) Then
  Begin

    If (fEmptyStr(edtOrdPagTra2.Text)) Then
      edtOrdPagTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtOrdPagTra.Text) + fStrToFloat(edtOrdPagTra2.Text),fStrToFloat(edtOrdPagAtu.Text), 'ordem de pagamento', edtCodPorOrd);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA FINANCIAMENTO 2           *}
  {*********************************LA*}
  Else If (Sender = edtValFinTra2) Then
  Begin

    If (fEmptyStr(edtValFinTra2.Text)) Then
      edtValFinTra2.Text := '0,00'
    Else
      Result := fValidaValorMod(fStrToFloat(edtValFinTra.Text) + fStrToFloat(edtValFinTra2.Text),fStrToFloat(edtValFinAtu.Text), 'financiamento', edtCodPorFin);

    If Result Then pAtualizaValDig;
  End

  {************************************}
  {* VALIDA FUNDO DE CAIXA            *}
  {*********************************AJ*}
  Else If (Sender = edtFundoDeCaixaAtualizado) Then
  Begin

    If (Not pnlFundoDeCaixa.Visible) Or
       (fEmptyStr(edtFundoDeCaixaAtualizado.Text)) Then
      edtFundoDeCaixaAtualizado.Text := '0,00'
    Else
    Begin
      If fStrToFloat(edtFundoDeCaixaAtualizado.Text) < 0.00 Then
      Begin
        fMensagem('ATENÇÃO', 'O valor do fundo de caixa não pode ser menor que 0.', ['&OK']);
        Result := False;
      End
      Else If (fStrToFloat(edtFundoDeCaixaAtualizado.Text) <> 0) And
              (fStrToFloat(edtDinheiroTra.Text) = 0) Then
      Begin
        fMensagem('ATENÇÃO', 'O valor do fundo de caixa só poderá ser informado quando possuir transferência em dinheiro.', ['&OK']);
        Result := False;
      End;
    End;

    If Result Then pAtualizaValDig;
  End;


  If (Not Result) And blnFocus Then
  Begin
    pSetFocus(Sender);
    If (Sender Is TEditFocus) Then
      (Sender As TEditFocus).SelectAll;
  End;

end;

function TfrmRcxTrasfValores.fValidaPortadores: Boolean;
begin
  Result := fEdtCodPorExit(edtCodPorDin, edtDesPortadorDin, mtfDinheiro);

  if Result Then
    Result := fEdtCodPorExit(edtCodPorChv, edtDesPortadorChv, mtfChequeAVista);

  if Result Then
    Result := fEdtCodPorExit(edtCodPorChp, edtDesPortadorChp, mtfChequePre);

  if Result Then
    Result := fEdtCodPorExit(edtCodPorCrt, edtDesPortadorCrt, mtfCartao);

  if Result Then
    Result := fEdtCodPorExit(edtCodPorOrd, edtDesPortadorOrd, mtfOrdemDePagamento);

  if Result Then
    Result := fEdtCodPorExit(edtCodPorFin, edtDesPortadorFin, mtfFinanciamento);
end;

procedure TfrmRcxTrasfValores.FormShow(Sender: TObject);
  Var
    blnAltPtf: Boolean;
begin
  inherited;

  pnlSaldoNegativoOperador.Visible := False;
  pnlSaldoNegativoOperador.Visible := True;

  FTFVinculada := objResumoDeCaixa.TransferenciaVinculada;

  FOperadorObrigatorio := OperadorDeveSerObrigatorio;

  edtGruGpo.Enabled := Not FOperadorObrigatorio;

  If DeveCarregarETravarOperadorLogado Then
  Begin
    pCarregaVendedor(edtCodVendedor.Text);
    edtCodVendedor.Enabled := objResumoDeCaixa.strTipoFechamento.Equals('C');
    edtGruGpo.Enabled      := False;
  End;

  If objResumoDeCaixa.strTipoFechamento.Equals('C') Then
  Begin
    Label9.Caption := 'Caixa:';
    edtGruGpo.Text := strCodigoCaixa;
    edtDesGpo.Text := fCampoTabela('CAX_DESCRI',
                                   'CADCAX',
                                   ['CAX_CODCAX', 'CAX_CODEMP', 'CAX_STATUS'],
                                   [strCodigoCaixa, VS_strCodEmp, 'A']);

    btnAltSeqFec.Visible  := False;
    chkFechamento.Visible := False;
    edtGruGpo.Enabled     := False;
  End;

  pCarregaValores;

  {****************************************************}
  {* TRAZ COMO SUGESTÃO OS PORTADORES JÁ CONFIGURADOS *}
  {* EM CONFIGURAÇÕES DE RESUMO DE CAIXA              *}
  {** 20/03/2008 - 08:08 ***************************ER*}
  edtCodPorDin.Text      := fCfgSis('PORDIN');
  edtDesPortadorDin.Text := fRetNomPortador(edtCodPorDin.Text);
  edtCodPorChv.Text      := fCfgSis('PORCHV');
  edtDesPortadorChv.Text := fRetNomPortador(edtCodPorChv.Text);
  edtCodPorChp.Text      := fCfgSis('PORCHP');
  edtDesPortadorChp.Text := fRetNomPortador(edtCodPorChp.Text);
  edtCodPorCrt.Text      := fCfgSis('PORCRT');
  edtDesPortadorCrt.Text := fRetNomPortador(edtCodPorCrt.Text);
  edtCodPorOrd.Text      := fCfgSis('PORORD');
  edtDesPortadorOrd.Text := fRetNomPortador(edtCodPorOrd.Text);
  edtCodPorFin.Text      := fCfgSis('PORFIN');
  edtDesPortadorFin.Text := fRetNomPortador(edtCodPorFin.Text);

  blnAltPtf := fCfgSis('ALTPTF', varBoolean);
  edtCodPorDin.Enabled := blnAltPtf;
  edtCodPorChv.Enabled := blnAltPtf;
  edtCodPorChp.Enabled := blnAltPtf;
  edtCodPorCrt.Enabled := blnAltPtf;
  edtCodPorOrd.Enabled := blnAltPtf;
  edtCodPorFin.Enabled := blnAltPtf;

  If FTFVinculada Then
  Begin
    btnSelChAvi.Visible := True;
    btnSelChPre.Visible := True;
    btnSelCartao.Visible := True;
    edtChqVistaTra.Enabled := False;
    edtChqPreTra.Enabled := False;
    edtCartaoTra.Enabled := False;

    lblTransf1.Caption      := 'Vr.Transferência';
    lblTransf2.Visible      := False;
    edtDinheiroTra2.Visible := False;
    edtChqVistaTra2.Visible := False;
    edtChqPreTra2.Visible   := False;
    edtCartaoTra2.Visible   := False;
    edtOrdPagTra2.Visible   := False;
    edtValFinTra2.Visible   := False;
    edtTotalTra2.Visible    := False;

    chkPixAvulso.Left := edtOrdPagTra2.Left + 4;

    Self.Width := Self.Width - edtDinheiroTra2.Width;
  End
  Else
  Begin
    btnSelChAvi.Visible := False;
    btnSelChPre.Visible := False;
    btnSelCartao.Visible := False;

    edtDinheiroTra.Left := btnSelChAvi.Left;
    edtChqVistaTra.Left := btnSelChAvi.Left;
    edtChqPreTra.Left   := btnSelChAvi.Left;
    edtCartaoTra.Left   := btnSelChAvi.Left;
    edtOrdPagTra.Left   := btnSelChAvi.Left;
    edtValFinTra.Left   := btnSelChAvi.Left;
    edtTotalTra.Left    := btnSelChAvi.Left;
    lblTransf1.Left     := btnSelChAvi.Left;

    edtDinheiroTra2.Left := edtDinheiroTra.Left + edtDinheiroTra.Width + 1;
    edtChqVistaTra2.Left := edtDinheiroTra2.Left;
    edtChqPreTra2.Left   := edtDinheiroTra2.Left;
    edtCartaoTra2.Left   := edtDinheiroTra2.Left;
    edtOrdPagTra2.Left   := edtDinheiroTra2.Left;
    edtValFinTra2.Left   := edtDinheiroTra2.Left;
    edtTotalTra2.Left    := edtDinheiroTra2.Left;
    lblTransf2.Left      := edtDinheiroTra2.Left;

    Self.Width := Self.Width - btnSelChAvi.Width;

    If Not blnTransferenciaMeioSeparada Then
    Begin
      lblTransf1.Caption      := 'Vr.Transferência';
      lblTransf2.Visible      := False;
      edtDinheiroTra2.Visible := False;
      edtChqVistaTra2.Visible := False;
      edtChqPreTra2.Visible   := False;
      edtCartaoTra2.Visible   := False;
      edtOrdPagTra2.Visible   := False;
      edtValFinTra2.Visible   := False;
      edtTotalTra2.Visible    := False;

      chkPixAvulso.Left := edtOrdPagTra2.Left;

      Self.Width := Self.Width - edtDinheiroTra2.Width;
    End;

  End;

  pnlMensagem.Visible     := False;
  Self.Height := Self.Height - pnlMensagem.Height;
  If blnTransferenciaCega Then
  Begin
    edtDinheiroAtu.Visible := False;
    edtTotalAtu.Visible    := False;
    pnlMensagem.Visible    := True;

    Self.Height := Self.Height + pnlMensagem.Height;

    edtFundoDeCaixaAtualizado.ReadOnly    := False;
    edtFundoDeCaixaAtualizado.NormalColor := clWhite;
    edtFundoDeCaixaAtualizado.Color       := clWhite;
  End;

  pnlFundoDeCaixa.Visible := (objResumoDeCaixa.strTipoFechamento = 'C') And
                             (Not fCfgSis('FECZER', varBoolean));

  If Not pnlFundoDeCaixa.Visible Then
    Self.Height := Self.Height - pnlFundoDeCaixa.Height;

  If edtCodVendedor.CanFocus Then
    pSetFocus(edtCodVendedor)
  Else
  Begin
    If edtCodPorDin.CanFocus Then
      pSetFocus(edtCodPorDin)
    Else
      pSetFocus(edtDinheiroTra);
  End;
end;

procedure TfrmRcxTrasfValores.btnCancTranfClick(Sender: TObject);
  Var
    qryFech: TUniQuery;
    strSQL   : String;

    frmRcxCancTransfValores: TfrmRcxCancTransfValores;
begin
  inherited;

  If Not fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(strCodigoCaixa), True) Then
  Begin
    fMensagem('', 'Não será possível cancelar transferências pois o caixa está sendo fechado!', ['&Ok']);
    Exit;
  End;

  Try
    qryFech := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   MAX(RCX_DTACAD) AS DTAFEC ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADRCXX ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   RCX_ESPDOC = "FC" AND ';
    strSQL := strSQL + '   RCX_CODEMP = :CODEMP ';

    With qryFech Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
    End;

    pCriarFormularios(TfrmRcxCancTransfValores, frmRcxCancTransfValores);
    frmRcxCancTransfValores.strCodOpe := strCodOpe;
    frmRcxCancTransfValores.dtaDtaRcx := qryFech.FieldByName('DTAFEC').AsDateTime;

    frmRcxCancTransfValores.strCodigoCaixa   := strCodigoCaixa;
    frmRcxCancTransfValores.objResumoDeCaixa := objResumoDeCaixa;

    frmRcxCancTransfValores.ShowModal;
  Except
    On E: exception Do
      pMensagensErro(E.Message, '[TfrmRcxTrasfValores.btnCancTranfClick]');
  End;

  FreeAndNil(frmRcxCancTransfValores);
  FreeAndNil(qryFech);

  fLock_Unlock(objResumoDeCaixa.fRetornaTextoDaTravaDoFechamento(strCodigoCaixa), False);

  pCarregaValores;

end;

procedure TfrmRcxTrasfValores.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  FTransferenciaPixAvulso := chkPixAvulso.Checked;

  pAtualizaValDig;

  If fValidaPortadores And fVerificaCampos Then
  Begin

    If fltValTot > 9999999999.99 Then
    Begin
      fMensagem('ATENÇÃO', 'O valor digitado total para transferir é maior que o valor máximo permitido.' + #13 +
                           'Valor máximo permitido: 9.999.999.999,99', ['&Ok']);

      pSetFocus(edtDinheiroTra);
      Exit;
    End;

    If (Not blnTransferenciaCega) And (fltValTot < fltValDig) And
       (Not Concat(objResumoDeCaixa.strTipoFechamento, objResumoDeCaixa.TipoSaldoCaixa).Equals('CC')) Then
    Begin
      fMensagem('','Valor digitado está maior que o valor total!',['&OK']);
      pSetFocus(edtDinheiroTra);
    End

    Else If (fltValDig + IIf(blnTransferenciaMeioSeparada, fltValDi2, 0)) = 0 Then
    Begin
      fMensagem('','Valor digitado deve ser maior que zero!',['&OK']);
      pSetFocus(edtDinheiroTra);
    End

    Else
    Begin
      If (Concat(objResumoDeCaixa.strTipoFechamento, objResumoDeCaixa.TipoSaldoCaixa).Equals('CO')) And
         (Not strCodOpe.Equals(edtCodVendedor.Text)) Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Transferência de lançamentos feitos por outro operador (Resumo de Caixa)');

        objLiberacao.strDirAce := 'LIBLANCXOPE';
        objLiberacao.strMsgSen := 'Transferência de lançamentos feitos por outro operador (Resumo de Caixa)';
        objLiberacao.blnMosMen := True;
        objLiberacao.strCodOpe := strCodOpe;
        objLiberacao.strCodDig := strCodOpe;

        If Not objLiberacao.fLibera Then
          Exit;
      End;

      {*****************************************************}
      {* AQUI CHAMAVA A TELA INFORMAÇÕES CHEQUE A VISTA    *}
      {* REMOVI ESSA TELA DO PROJETO POIS ELA SÓ ERA USADA *}
      {* QUANDO A CONFIGURAÇÃO CFG_RCXTCC ESTVA = LIBERADA *}
      {* NÃO VINCULADA. SEGUNDO O RONALDO TODOS OS CLIENTES*}
      {* NA VERSÃO 379.48.02 DEVEM SE IMPLANTADOS COMO     *}
      {* VINCULADA AOS DOCUMENTOS                          *}
      {*REQ-29572-21/01/2015*****************************JU*}

      If fStrToFloat(edtDinheiroTra.Text) = 0 Then
        edtFundoDeCaixaAtualizado.Text := '0,00';

      Close;
      ModalResult := mrOk;

    End;

  End;

end;

procedure TfrmRcxTrasfValores.btnConsTranClick(Sender: TObject);
  Var
    frmRcxConsTransfValores: TfrmRcxConsTransfValores;
begin
  inherited;

  If (Not fVerificaAcessoSistema('CONTFV', strCodOpe)) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Consulta Transferências Pendentes (Resumo de Caixa)');

    objLiberacao.strDirAce := 'CONTFV';
    objLiberacao.strMsgSen := 'Transferências';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    If (Not objLiberacao.fLibera) Then
    Begin
      Exit;
    End;
  End;

  pCriarFormularios(TfrmRcxConsTransfValores, frmRcxConsTransfValores);
  frmRcxConsTransfValores.strCodigoCaixa    := strCodigoCaixa;
  frmRcxConsTransfValores.objResumoDeCaixa  := objResumoDeCaixa;
  frmRcxConsTransfValores.strCodigoOperador := strCodOpe;
  frmRcxConsTransfValores.ShowModal;
  FreeAndNil(frmRcxConsTransfValores);
end;

procedure TfrmRcxTrasfValores.btnSairClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  inherited;
end;

procedure TfrmRcxTrasfValores.edtCodPorDinExit(Sender: TObject);
begin
  inherited;
  fEdtCodPorExit(edtCodPorDin, edtDesPortadorDin, mtfDinheiro);
end;

procedure TfrmRcxTrasfValores.edtCodPorChvExit(Sender: TObject);
begin
  inherited;
  fEdtCodPorExit(edtCodPorChv, edtDesPortadorChv, mtfChequeAVista);
end;

procedure TfrmRcxTrasfValores.edtCodPorChpExit(Sender: TObject);
begin
  inherited;
  fEdtCodPorExit(edtCodPorChp, edtDesPortadorChp, mtfChequePre);
end;

procedure TfrmRcxTrasfValores.edtCodPorCrtExit(Sender: TObject);
begin
  inherited;
  fEdtCodPorExit(edtCodPorCrt, edtDesPortadorCrt, mtfCartao);
end;

procedure TfrmRcxTrasfValores.edtCodPorOrdExit(Sender: TObject);
begin
  inherited;
  fEdtCodPorExit(edtCodPorOrd, edtDesPortadorOrd, mtfOrdemDePagamento);
end;

procedure TfrmRcxTrasfValores.edtCodPorDinKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorDin, edtDesPortadorDin,Key);
end;

procedure TfrmRcxTrasfValores.edtCodPorFinExit(Sender: TObject);
begin
  inherited;
  fEdtCodPorExit(edtCodPorFin, edtDesPortadorFin, mtfFinanciamento);
end;

procedure TfrmRcxTrasfValores.edtCodPorFinKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  PEdtCodPorKeyPress(edtCodPorFin, edtDesPortadorFin,Key);
end;

procedure TfrmRcxTrasfValores.edtCodPorChvKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorChv, edtDesPortadorChv,Key);
end;

procedure TfrmRcxTrasfValores.edtCodPorChpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorChp, edtDesPortadorChp,Key);
end;

procedure TfrmRcxTrasfValores.edtCodPorCrtKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorCrt, edtDesPortadorCrt,Key);
end;

procedure TfrmRcxTrasfValores.edtCodPorOrdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  PEdtCodPorKeyPress(edtCodPorOrd, edtDesPortadorOrd,Key);
end;

procedure TfrmRcxTrasfValores.AjustaCamposDinheiroOrdemPagamentoSaldoInicial;
begin
  If Not Concat(objResumoDeCaixa.strTipoFechamento,
         objResumoDeCaixa.TipoSaldoCaixa).Equals('CC') Then
  Begin
    If Not FOperadorObrigatorio Then
      Exit;
  End;

  If fEmptyStr(edtCodVendedor.Text) Then
    Exit;

  If Not blnTransferenciaCega Then
  Begin
    If FSaldoFechamentoDinheiro > 0 Then
      edtDinheiroAtu.Text := FormatFloat(',0.00', fStrToFloat(edtDinheiroAtu.Text) +
                                                  FValorTransferenciaDinheiro);
  End;

  If Not chkPixAvulso.Checked Then
  Begin
    If FSaldoFechamentoOrdemPagamento > 0 Then
      edtOrdPagAtu.Text := FormatFloat(',0.00', fStrToFloat(edtOrdPagAtu.Text) +
                                                IIF(Not fEmptyStr(edtCodVendedor.Text), FValorTransferenciaOrdemPagamento, 0));

    FOrdemPagamento := fStrToFloat(edtOrdPagAtu.Text);
  End;

  If objResumoDeCaixa.strTipoFechamento <> 'C' Then
  Begin
    If edtCodVendedor.Text <> FOperadorFechamento Then
    Begin
      If Not blnTransferenciaCega Then
      Begin
        If FSaldoFechamentoDinheiro > 0 Then
          edtDinheiroAtu.Text := FormatFloat(',0.00', fStrToFloat(edtDinheiroAtu.Text) +
                                                      IIF(Not fEmptyStr(edtCodVendedor.Text), FSaldoFechamentoDinheiro, 0));
      End;

      If Not chkPixAvulso.Checked Then
      Begin
        If FSaldoFechamentoOrdemPagamento > 0 Then
          edtOrdPagAtu.Text := FormatFloat(',0.00', fStrToFloat(edtOrdPagAtu.Text) +
                                                    IIF(Not fEmptyStr(edtCodVendedor.Text), FSaldoFechamentoOrdemPagamento, 0));

        FOrdemPagamento := fStrToFloat(edtOrdPagAtu.Text);
      End;
    End;
  End;
end;

procedure TfrmRcxTrasfValores.btnAltSeqFecClick(Sender: TObject);
  Var
    intSqFcRx: Integer;
begin
  inherited;
  If Not btnAltSeqFec.Visible Then
    Exit;

  intSqFcRx := fCfgSisL('SQFCRX');
  If fDigQuantidade('Seq. Fec. Parcial', 'Seq. fechamento parcial: ', intSqFcRx, intSqFcRx) Then
  Begin
    fAtuCfgSis('SQFCRX', IntToStr(intSqFcRx));
  End;
end;

procedure TfrmRcxTrasfValores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F9:     btnAltSeqFec.Click;
    VK_F8:     btnCancTranf.Click;
    VK_F7:     btnConsTran.Click;
    VK_ESCAPE: btnSair.Click;
  End;
end;

procedure TfrmRcxTrasfValores.btnSelChAviClick(Sender: TObject);
Var
  fltTotChqAvi: Double;
  intRecNo: Integer;

  LfrmRcxTransfDocs: TfrmRcxTransfDocs;
begin
  inherited;

  If chkFechamento.Checked Then
    Exit;

  If Not OperadorValidoParaTransferir Then
    Exit;

  Try
    Try
      pCriarFormularios(TfrmRcxTransfDocs, LfrmRcxTransfDocs);
      LfrmRcxTransfDocs.strCodOpe := edtCodVendedor.Text;
      If (objResumoDeCaixa.strTipoFechamento <> 'C') Then
        LfrmRcxTransfDocs.strCodGpo := edtGruGpo.Text;
      LfrmRcxTransfDocs.strCodigoCaixa := strCodigoCaixa;
      LfrmRcxTransfDocs.objResumoDeCaixa := objResumoDeCaixa;
      LfrmRcxTransfDocs.Caption := 'Transferência de Valores - Cheque A Vista';
      LfrmRcxTransfDocs.strOpcao := 'CHA';
      LfrmRcxTransfDocs.edtTotSel.Text := edtChqVistaTra.Text;
      If Not cdsChqAVi.IsEmpty Then
      Begin
        cdsChqAVi.Filtered := False;
        LfrmRcxTransfDocs.cdsConsulta.Data := cdsChqAVi.Data;
      End;
      LfrmRcxTransfDocs.showModal;

      If LfrmRcxTransfDocs.blnConfirma Then
      Begin
        edtChqVistaTra.Text := FormatFloat('#,###0.00',LfrmRcxTransfDocs.fltTotSel);

        FAutoIncremsChequesAVista.Clear;
        FAutoIncremsChequesAVista.AddStrings(LfrmRcxTransfDocs.AutoIncremsDocumentos);

        LfrmRcxTransfDocs.cdsConsulta.First;
        fltTotChqAvi := 0;
        intRecNo  := LfrmRcxTransfDocs.cdsConsulta.RecNo;
        While Not LfrmRcxTransfDocs.cdsConsulta.Eof Do
        Begin
          If LfrmRcxTransfDocs.cdsConsulta.FieldByName('MARDES').AsString = 'M' Then
          Begin
            fltTotChqAvi := fltTotChqAvi + LfrmRcxTransfDocs.cdsConsulta.FieldByName('VALOR').AsFloat;
          End;

          LfrmRcxTransfDocs.cdsConsulta.Next;
        End;

        LfrmRcxTransfDocs.cdsConsulta.RecNo := intRecNo;

      {******************************************************************************
       * Foi alterado de fFormataFloat, para RoundTo, pois se estivesse configurado *
       * para uso de Sat ou com a configuração:                                     *
       * "CFG_RAABNT - UTILIZAR REGRAS DE ARREDONDAMENTO "ABNT NBR 5891:1977"       *
       * habilitada, a função fFormataFloat continuava devolvendo valores que       *
       * geravam divergência.                                                       *
       ***************************************************************KP**Req.98794**}
        If RoundTo(fltTotChqAvi, -2) <> RoundTo(LfrmRcxTransfDocs.fltTotSel, -2) Then
        Begin
          fMensagem('Aviso', 'O valor da transferência está diferente da soma dos documentos selecionados! Se o erro continuar entre em contato com a Citel!', ['&O k']);
          edtChqVistaTra.Text := '0,00';
        End
        Else
          cdsChqAVi.Data := LfrmRcxTransfDocs.cdsConsulta.Data;
      End;

      cdsChqAVi.Filtered := True;

    Except
      On E: Exception Do
      Begin
        edtChqVistaTra.Text := '0,00';
        pMensagensErro(E.Message, '[frmRcxTrasfValores.btnSelChAviClick]');
      End;
    End;
  Finally
    If Assigned(LfrmRcxTransfDocs) Then
      FreeAndNil(LfrmRcxTransfDocs);
  End;

  pAtualizaValDig;

  If edtCodPorChp.CanFocus Then
    pSetFocus(edtCodPorChp)
  Else
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmRcxTrasfValores.btnSelChPreClick(Sender: TObject);
var
  fltTotChqPre: Double;
  intRecNo: Integer;

  LfrmRcxTransfDocs: TfrmRcxTransfDocs;
begin
  inherited;

  If chkFechamento.Checked Then
    Exit;

  If Not OperadorValidoParaTransferir Then
    Exit;

  Try
    Try
      pCriarFormularios(TfrmRcxTransfDocs, LfrmRcxTransfDocs);
      LfrmRcxTransfDocs.strCodOpe := edtCodVendedor.Text;
      If (objResumoDeCaixa.strTipoFechamento <> 'C') Then
        LfrmRcxTransfDocs.strCodGpo := edtGruGpo.Text;
      LfrmRcxTransfDocs.strCodigoCaixa := strCodigoCaixa;
      LfrmRcxTransfDocs.objResumoDeCaixa := objResumoDeCaixa;
      LfrmRcxTransfDocs.Caption := 'Transferência de Valores - Cheque - Pré';
      LfrmRcxTransfDocs.strOpcao := 'CHP';
      LfrmRcxTransfDocs.edtTotSel.Text := edtChqPreTra.Text;
      If Not cdsChqPre.IsEmpty Then
      Begin
        cdsChqPre.Filtered := False;
        LfrmRcxTransfDocs.cdsConsulta.Data := cdsChqPre.Data;
      End;
      LfrmRcxTransfDocs.showModal;

      If LfrmRcxTransfDocs.blnConfirma Then
      Begin
        edtChqPreTra.Text := FormatFloat('#,###0.00',LfrmRcxTransfDocs.fltTotSel);

        FAutoIncremsChequesPre.Clear;
        FAutoIncremsChequesPre.AddStrings(LfrmRcxTransfDocs.AutoIncremsDocumentos);

        LfrmRcxTransfDocs.cdsConsulta.First;
        fltTotChqPre := 0;
        intRecNo  := LfrmRcxTransfDocs.cdsConsulta.RecNo;
        While Not LfrmRcxTransfDocs.cdsConsulta.Eof Do
        Begin
          If LfrmRcxTransfDocs.cdsConsulta.FieldByName('MARDES').AsString = 'M' Then
          Begin
            fltTotChqPre := fltTotChqPre + LfrmRcxTransfDocs.cdsConsulta.FieldByName('VALOR').AsFloat;
          End;

          LfrmRcxTransfDocs.cdsConsulta.Next;
        End;

        LfrmRcxTransfDocs.cdsConsulta.RecNo := intRecNo;

      {******************************************************************************
       * Foi alterado de fFormataFloat, para RoundTo, pois se estivesse configurado *
       * para uso de Sat ou com a configuração:                                     *
       * "CFG_RAABNT - UTILIZAR REGRAS DE ARREDONDAMENTO "ABNT NBR 5891:1977"       *
       * habilitada, a função fFormataFloat continuava devolvendo valores que       *
       * geravam divergência.                                                       *
       ***************************************************************KP**Req.98794**}
        If RoundTo(fltTotChqPre, -2) <> RoundTo(LfrmRcxTransfDocs.fltTotSel, -2) Then
        Begin
          fMensagem('Aviso', 'O valor da transferência está diferente da soma dos documentos selecionados! Se o erro continuar entre em contato com a Citel!', ['&O k']);
          edtChqPreTra.Text := '0,00';
        End
        Else
          cdsChqPre.Data := LfrmRcxTransfDocs.cdsConsulta.Data;
      End;

      cdsChqPre.Filtered := True;

    Except
      On E: Exception Do
      Begin
        edtChqPreTra.Text := '0,00';
        pMensagensErro(E.Message, '[frmRcxTrasfValores.btnSelChPreClick]');
      End;
    End;
  Finally
    If Assigned(LfrmRcxTransfDocs) Then
      FreeAndNil(LfrmRcxTransfDocs);
  End;

  pAtualizaValDig;

  If edtCodPorCrt.CanFocus Then
    pSetFocus(edtCodPorCrt)
  Else
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmRcxTrasfValores.CalculaValoresDinheiroOrdemPgtoInicial;
  Var
    LFechamento: TDataset;

    LTransferido: TUniQuery;
begin
  FSaldoFechamentoDinheiro := 0.00;
  FSaldoFechamentoOrdemPagamento := 0.00;
  FValorTransferenciaDinheiro := 0.00;
  FValorTransferenciaOrdemPagamento := 0.00;
  FValorTransferenciaOperadorDinheiro := 0.00;
  FValorTransferenciaOperadorOrdemPagamento := 0.00;

  If Not FOperadorObrigatorio Then
  Begin
    If Not Concat(objResumoDeCaixa.strTipoFechamento,
                  objResumoDeCaixa.TipoSaldoCaixa).Equals('CC') Then
      Exit;
  End;

  LFechamento := objResumoDeCaixa.fRetornaDadosUltimoFechamento(strCodigoCaixa,
                                                                VS_strCodEmp);

  FOperadorFechamento := LFechamento.FieldByName('RCX_CODOPE').AsString;

  FSaldoFechamentoDinheiro := fFormataFloat(LFechamento.FieldByName('RCX_DINREC').AsFloat, 2);
  FSaldoFechamentoOrdemPagamento := fFormataFloat(LFechamento.FieldByName('RCX_ORDREC').AsFloat, 2);

  LTransferido := fCriaQuery;

  Try
    LTransferido.SQL.Text := 'SELECT RCX_CODOPE, ' +
                             '       SUM(IF(RCX_CODOPE<>:OPEFEC, RCX_DINREC, IF(RCX_ESPDOC="TF", RCX_DINREC, 0))) AS RCX_DINREC, ' +
                             '       SUM(IF(RCX_RECPIX="N", IF(RCX_CODOPE<>:OPEFEC, RCX_ORDREC, IF(RCX_ESPDOC="TF", RCX_ORDREC, 0)), 0)) AS RCX_ORDREC ' +
                             'FROM CADRCXX ';

    If Not strCodigoCaixa.IsEmpty Then
      LTransferido.SQL.Add('WHERE RCX_DTACAD>=:DTACAD ' +
                           '  AND RCX_CODEMP=:CODEMP ' +
                           '  AND RCX_LANFEC="N" ' +
                           '  AND RCX_ESPDOC<>"FC" '+
                           '  AND RCX_CODCAX="' + strCodigoCaixa + '" ')
    Else
      LTransferido.SQL.Add('WHERE RCX_DTACAD>:DTACAD ' +
                           '  AND RCX_CODEMP=:CODEMP ' +
                           '  AND RCX_LANFEC="N" ' +
                           '  AND RCX_ESPDOC<>"FC" ');

    LTransferido.SQL.Add('GROUP BY RCX_CODOPE');

    LTransferido.ParamByName('DTACAD').AsDateTime := LFechamento.FieldByName('RCX_DTACAD').AsDateTime;
    LTransferido.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LTransferido.ParamByName('OPEFEC').AsString := FOperadorFechamento;

    LTransferido.Open;

    FValorTransferenciaDinheiro := 0.00;
    FValorTransferenciaOrdemPagamento := 0.00;
    FValorTransferenciaOperadorDinheiro := 0.00;
    FValorTransferenciaOperadorOrdemPagamento := 0.00;

    While Not LTransferido.Eof Do
    Begin
      If edtCodVendedor.Text = LTransferido.FieldByName('RCX_CODOPE').AsString Then
      Begin
        If fFormataFloat(LTransferido.FieldByName('RCX_DINREC').AsFloat, 2) < 0 Then
          FValorTransferenciaOperadorDinheiro := LTransferido.FieldByName('RCX_DINREC').AsFloat;

        If fFormataFloat(LTransferido.FieldByName('RCX_ORDREC').AsFloat, 2) < 0 Then
          FValorTransferenciaOperadorOrdemPagamento := LTransferido.FieldByName('RCX_ORDREC').AsFloat;

        LTransferido.Next;
        Continue;
      End;


      If fFormataFloat(LTransferido.FieldByName('RCX_DINREC').AsFloat, 2) < 0 Then
        FValorTransferenciaDinheiro := fFormataFloat(FValorTransferenciaDinheiro +
                                                     LTransferido.FieldByName('RCX_DINREC').AsFloat, 2);

      If fFormataFloat(LTransferido.FieldByName('RCX_ORDREC').AsFloat, 2) < 0 Then
        FValorTransferenciaOrdemPagamento := fFormataFloat(FValorTransferenciaOrdemPagamento +
                                                           LTransferido.FieldByName('RCX_ORDREC').AsFloat, 2);

      LTransferido.Next;
    End;

    If fEmptyStr(edtCodVendedor.Text) Then
     Exit;

    If (FOperadorFechamento <> edtCodVendedor.Text) Then
    Begin
      If Abs(FValorTransferenciaDinheiro + FValorTransferenciaOperadorDinheiro) >= FSaldoFechamentoDinheiro Then
        FValorTransferenciaDinheiro := (FSaldoFechamentoDinheiro + FValorTransferenciaOperadorDinheiro) * (-1);

      If Abs(FValorTransferenciaOrdemPagamento + FValorTransferenciaOperadorOrdemPagamento) >= FSaldoFechamentoOrdemPagamento Then
        FValorTransferenciaOrdemPagamento := (FSaldoFechamentoOrdemPagamento + FValorTransferenciaOperadorOrdemPagamento) * (-1);
    End;
  Finally
    FreeAndNil(LTransferido);
    FreeAndNil(LFechamento);
  End;
end;

procedure TfrmRcxTrasfValores.chkFechamentoClick(Sender: TObject);
begin
  inherited;
  If chkFechamento.Checked Then
  Begin
    edtChqVistaTra.Text  := '0,00';
    edtChqVistaTra2.Text := '0,00';
    edtChqPreTra.Text    := '0,00';
    edtChqPreTra2.Text   := '0,00';
    edtCartaoTra.Text    := '0,00';
    edtCartaoTra2.Text   := '0,00';
    edtOrdPagTra.Text    := '0,00';
    edtOrdPagTra2.Text   := '0,00';
    edtValFinTra.Text    := '0,00';
    edtValFinTra2.Text   := '0,00';

    If cdsChqAVi.Active Then cdsChqAVi.EmptyDataSet;
    If cdsChqPre.Active Then cdsChqPre.EmptyDataSet;
    If cdsCarCre.Active Then cdsCarCre.EmptyDataSet;

    FAutoIncremsCartoes.Clear;
    FAutoIncremsChequesAVista.Clear;
    FAutoIncremsChequesPre.Clear;

    pAtualizaValDig;
  End;

  edtChqVistaTra.Enabled  := (Not chkFechamento.Checked) And
                             (Not FTFVinculada);
  edtChqVistaTra2.Enabled := Not chkFechamento.Checked;
  edtChqPreTra.Enabled    := (Not chkFechamento.Checked) And
                             (Not FTFVinculada);
  edtChqPreTra2.Enabled   := Not chkFechamento.Checked;
  edtCartaoTra.Enabled    := (Not chkFechamento.Checked) And
                             (Not FTFVinculada);
  edtCartaoTra2.Enabled   := Not chkFechamento.Checked;
  edtOrdPagTra.Enabled    := Not chkFechamento.Checked;
  edtOrdPagTra2.Enabled   := Not chkFechamento.Checked;
  edtValFinTra.Enabled    := Not chkFechamento.Checked;
  edtValFinTra2.Enabled   := Not chkFechamento.Checked;
end;

procedure TfrmRcxTrasfValores.chkPixAvulsoClick(Sender: TObject);
begin
  inherited;
  edtOrdPagAtu.Text := FloatToStrF(FOrdemPagamento, ffFixed, 12, 2);
  If chkPixAvulso.Checked Then
    edtOrdPagAtu.Text := FloatToStrF(FPixAvulso, ffFixed, 12, 2);

  edtOrdPagTra.Text := '0,00';
  edtOrdPagTra2.Text := '0,00';

  pAtualizaValDig;

  fltValTot := fStrToFloat(edtDinheiroAtu.Text) +
               fStrToFloat(edtChqVistaAtu.Text) +
               fStrToFloat(edtChqPreAtu.Text) +
               fStrToFloat(edtCartaoAtu.Text) +
               fStrToFloat(EdtOrdPagAtu.Text) +
               fStrToFloat(EdtValFinAtu.Text);

  edtTotalAtu.Text := FloatToStrF(fltValTot,ffFixed,12,2);
end;

function TfrmRcxTrasfValores.DeveCarregarETravarOperadorLogado: Boolean;
begin
  Result := blnTransferenciaCega;

  If objResumoDeCaixa.strTipoFechamento.Equals('C') Then
  Begin
    If objResumoDeCaixa.TipoSaldoCaixa.Equals('O') Then
      Exit(True);
  End;

  If objResumoDeCaixa.OperadorTransferenciaDeveSerLogadoCaixa Then
    Exit(True);
end;

procedure TfrmRcxTrasfValores.btnSelCartaoClick(Sender: TObject);
var
  fltTotCar: Double;
  intRecNo: Integer;

  LfrmRcxTransfDocs: TfrmRcxTransfDocs;
begin
  inherited;

  If chkFechamento.Checked Then
    Exit;

  If Not OperadorValidoParaTransferir Then
    Exit;

  Try
    Try
      pCriarFormularios(TfrmRcxTransfDocs, LfrmRcxTransfDocs);
      LfrmRcxTransfDocs.strCodOpe := edtCodVendedor.Text;
      If (objResumoDeCaixa.strTipoFechamento <> 'C') Then
        LfrmRcxTransfDocs.strCodGpo := edtGruGpo.Text;
      LfrmRcxTransfDocs.strCodigoCaixa := strCodigoCaixa;
      LfrmRcxTransfDocs.objResumoDeCaixa := objResumoDeCaixa;
      LfrmRcxTransfDocs.Caption := 'Transferência de Valores - Cartão';
      LfrmRcxTransfDocs.strOpcao := 'CCA';
      LfrmRcxTransfDocs.edtTotSel.Text := edtCartaoTra.Text;
      If Not cdsCarCre.IsEmpty Then
      Begin
        cdsCarCre.Filtered := False;
        LfrmRcxTransfDocs.cdsConsulta.Data := cdsCarCre.Data;
      End;
      LfrmRcxTransfDocs.showModal;

      If LfrmRcxTransfDocs.blnConfirma Then
      Begin
        edtCartaoTra.Text := FormatFloat('#,###0.00',LfrmRcxTransfDocs.fltTotSel);

        FAutoIncremsCartoes.Clear;
        FAutoIncremsCartoes.AddStrings(LfrmRcxTransfDocs.AutoIncremsDocumentos);

        LfrmRcxTransfDocs.cdsConsulta.First;
        fltTotCar := 0;
        intRecNo  := LfrmRcxTransfDocs.cdsConsulta.RecNo;
        While Not LfrmRcxTransfDocs.cdsConsulta.Eof Do
        Begin
          If LfrmRcxTransfDocs.cdsConsulta.FieldByName('MARDES').AsString = 'M' Then
          Begin
            fltTotCar := fltTotCar + LfrmRcxTransfDocs.cdsConsulta.FieldByName('VALOR').Value;
          End;

          LfrmRcxTransfDocs.cdsConsulta.Next;
        End;

        LfrmRcxTransfDocs.cdsConsulta.RecNo := intRecNo;

      {******************************************************************************
       * Foi alterado de fFormataFloat, para RoundTo, pois se estivesse configurado *
       * para uso de Sat ou com a configuração:                                     *
       * "CFG_RAABNT - UTILIZAR REGRAS DE ARREDONDAMENTO "ABNT NBR 5891:1977"       *
       * habilitada, a função fFormataFloat continuava devolvendo valores que       *
       * geravam divergência.                                                       *
       ***************************************************************KP**Req.98794**}
        If RoundTo(fltTotCar, -2) <> RoundTo(LfrmRcxTransfDocs.fltTotSel, -2) Then
        Begin
          fMensagem('Aviso', 'O valor da transferência está diferente da soma dos documentos selecionados! Se o erro continuar entre em contato com a Citel!', ['&O k']);
          edtCartaoTra.Text := '0,00';
        End
        Else
          cdsCarCre.Data := LfrmRcxTransfDocs.cdsConsulta.Data;
      End;

      cdsCarCre.Filtered := True;

    Except
      On E: Exception Do
      Begin
        edtCartaoTra.Text := '0,00';
        pMensagensErro(E.Message, '[frmRcxTrasfValores.btnSelCartaoClick]');
      End;
    End;
  Finally
    If Assigned(LfrmRcxTransfDocs) Then
      FreeAndNil(LfrmRcxTransfDocs);
  End;

  pAtualizaValDig;

  If edtCodPorOrd.CanFocus Then
    pSetFocus(edtCodPorOrd)
  Else
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmRcxTrasfValores.FormCreate(Sender: TObject);
begin
  inherited;
  qryConPor := fCriaQuery(Self);
  qryCadOpe := fCriaQuery(Self);
  qryCadGpo := fCriaQuery(Self);
  objLiberacao := TLiberacao.Create;

  blnTransferenciaCega := fCfgSis('TRFCEG', varBoolean);

  blnTransferenciaMeioSeparada := fCfgSis('RCXTR2', varBoolean);

  strCodigoCaixa := '';

  FTransferenciaPixAvulso := False;

  FSaldoFechamentoDinheiro := 0.00;
  FSaldoFechamentoOrdemPagamento := 0.00;
  FValorTransferenciaDinheiro := 0.00;
  FValorTransferenciaOrdemPagamento := 0.00;

  FAutoIncremsCartoes := TStringList.Create;
  FAutoIncremsChequesAVista := TStringList.Create;
  FAutoIncremsChequesPre := TStringList.Create;
end;

procedure TfrmRcxTrasfValores.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  FreeAndNil(FAutoIncremsCartoes);
  FreeAndNil(FAutoIncremsChequesAVista);
  FreeAndNil(FAutoIncremsChequesPre);
  inherited;
end;

procedure TfrmRcxTrasfValores.edtCodVendedorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqOperador(Self, edtCodVendedor, edtDesVendedor, qryCadOpe, Key, arrSel)  then
    Begin
      If fValidaCampos(edtCodVendedor, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmRcxTrasfValores.pCarregaVendedor(strCodVen: String);
begin
  pPesquisaCadOpe(Nil, qryCadOpe, edtCodVendedor.Text);
  edtDesVendedor.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString;
end;

procedure TfrmRcxTrasfValores.pCarregaGrupoOpe(strCodGpo: String);
begin
  pPesquisaCadGpo(Nil, qryCadGpo, edtGruGpo.Text);
  edtDesGpo.Text := qryCadGpo.FieldByName('GPO_DESCRI').AsString;
end;

{***************************************}
{* VALIDA VALOR REFERENTE A MODALIDADE *}
{************************************AF*}
function TfrmRcxTrasfValores.fValidaValorMod(fltValDig, fltValAtu: Double; strModalidade: String; var edtPor: TEditFocus): Boolean;
Var
  strCampoRcx: String;
Begin
  Result := True;

  If fltValDig > 9999999999.99 Then
  Begin
    fMensagem('ATENÇÃO', 'O valor digitado para transferir na modalidade é maior que o valor máximo permitido.' + #13 +
                         'Valor máximo permitido: 9.999.999.999,99', ['&Ok']);

    Exit(False);
  End;

  If strModalidade = 'dinheiro' Then
    strCampoRcx := 'RCX_DINREC'
  Else If strModalidade = 'cheque a vista' Then
    strCampoRcx := 'RCX_CHQAVI'
  Else If strModalidade = 'cheque - pré' Then
    strCampoRcx := 'RCX_CHQPRE'
  Else If strModalidade = 'cartão' Then
    strCampoRcx := 'RCX_CARREC'
  Else If MatchStr(strModalidade, ['ordem de pagamento', 'pix avulso']) Then
    strCampoRcx := 'RCX_ORDREC'
  Else If strModalidade = 'financiamento' Then
    strCampoRcx := 'RCX_VALFIN';

  If (Not (AnsiLowerCase(strModalidade) = 'dinheiro') And (blnTransferenciaCega)) Or
     (Not (blnTransferenciaCega)) Then
  Begin
    If fltValDig > fltValAtu Then
    Begin
      If (fltValAtu >= 0) Or (Not Concat(objResumoDeCaixa.strTipoFechamento, objResumoDeCaixa.TipoSaldoCaixa).Equals('CC')) Then
      Begin
        fMensagem('','O valor da modalidade ' + strModalidade + ' não pode ser maior que o valor atual!',['&OK']);
        Result := False;
        Exit;
      End;
    End;
  End;

  If fltValDig < 0 Then
  Begin
    fMensagem('','O valor da modalidade ' + strModalidade + ' não pode ser menor que zero!',['&OK']);
    Result := False;
  End

  Else If (Not blnTransferenciaCega) And
          (fFormataFloat(fltValDig, 2) > fFormataFloat(objResumoDeCaixa.fRetornaSaldoCaixaCampo(strCampoRcx, strCodigoCaixa, '', '', strModalidade.Equals('pix avulso'), strModalidade.Equals('pix avulso')), 2)) Then
  Begin
    fMensagem('', 'Saldo em caixa insuficiente para transferência do valor informado na modalidade ' + strModalidade + '!', ['&Ok']);
    Result := False;
  End

  Else If fEmptyStr(edtPor.Text) And (fltValDig > 0) Then
  Begin
    fMensagem('', 'Não foi escolhido portador para ' + strModalidade + '. O valor de transferência deve ser zero!', ['&OK']);
    Result := False;
  End;

End;

function TfrmRcxTrasfValores.OperadorDeveSerObrigatorio: Boolean;
begin
  Result := False;

  If blnTransferenciaCega Then
    Exit(True);

  If objResumoDeCaixa.strTipoFechamento.Equals('C') Then
    Exit(objResumoDeCaixa.TipoSaldoCaixa.Equals('O'));

  If fCfgSis('OBROPT', VarBoolean) Then
    Exit(True);

  If objResumoDeCaixa.OperadorTransferenciaDeveSerLogadoCaixa Then
    Exit(True);
end;

function TfrmRcxTrasfValores.OperadorValidoParaTransferir: Boolean;
begin
  If FOperadorObrigatorio Then
  Begin
    If fEmptyStr(edtCodVendedor.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'É necessário informar o código do operador.', ['&Ok']);
      pSetFocus(edtCodVendedor);

      Exit(False);
    End;
  End;

  Result := fValidaCampos(edtCodVendedor, Not strVenAnt.Equals(edtCodVendedor.Text));
end;

procedure TfrmRcxTrasfValores.pCarregaValores;
  Var
    qryGen: TUniQuery;
    strSQL: String;
    fltSalFec: Double;
    dtaDtaFec: TDateTime;
Begin
  Try
    CalculaValoresDinheiroOrdemPgtoInicial;

    chkPixAvulso.Checked := False;

    qryGen := fCriaQuery;

    objResumoDeCaixa.fRetornaUltimoFechamento(fltSalFec, dtaDtaFec, strCodigoCaixa);

    strSQL := objResumoDeCaixa.fGetSQLTransfValores(edtGruGpo.Text,
                                                    edtCodVendedor.Text,
                                                    False,
                                                    strCodigoCaixa);

    qryGen.Close;
    qryGen.SQL.Text := strSQL;
    qryGen.ParamByName('DTACAD').AsDate   := dtaDtaFec;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.Open;

    edtDinheiroAtu.Text := FloatToStrF(qryGen.FieldByName('RCX_DINREC').AsFloat,ffFixed,12,2);
    edtChqVistaAtu.Text := FloatToStrF(qryGen.FieldByName('RCX_CHQAVI').AsFloat,ffFixed,12,2);
    edtChqPreAtu.Text   := FloatToStrF(qryGen.FieldByName('RCX_CHQPRE').AsFloat,ffFixed,12,2);
    edtCartaoAtu.Text   := FloatToStrF(qryGen.FieldByName('RCX_CARREC').AsFloat,ffFixed,12,2);
    edtValFinAtu.Text   := FloatToStrF(qryGen.FieldByName('RCX_VALFIN').AsFloat,ffFixed,12,2);

    FPixAvulso := objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_ORDREC',
                                                           strCodigoCaixa,
                                                           VS_strCodEmp,
                                                           edtCodVendedor.Text,
                                                           True,
                                                           True);

    FOrdemPagamento := qryGen.FieldByName('RCX_ORDREC').AsFloat - FPixAvulso;

    edtOrdPagAtu.Text   := FloatToStrF(FOrdemPagamento, ffFixed, 12, 2);

    qryGen.Close;

    If fEmptyStr(edtDinheiroAtu.Text) Then edtDinheiroAtu.Text := '0,00';
    If fEmptyStr(edtChqVistaAtu.Text) Then edtChqVistaAtu.Text := '0,00';
    If fEmptyStr(edtChqPreAtu.Text)   Then edtChqPreAtu.Text := '0,00';
    If fEmptyStr(edtCartaoAtu.Text)   Then edtCartaoAtu.Text := '0,00';
    If fEmptyStr(edtOrdPagAtu.Text)   Then edtOrdPagAtu.Text := '0,00';
    If fEmptyStr(edtValFinAtu.Text)   Then edtValFinAtu.Text := '0,00';

    AjustaCamposDinheiroOrdemPagamentoSaldoInicial;

    If FOrdemPagamento = 0 Then
      chkPixAvulso.Checked := FPixAvulso > 0;

    fltValTot := fStrToFloat(edtDinheiroAtu.Text) +
                 fStrToFloat(edtChqVistaAtu.Text) +
                 fStrToFloat(edtChqPreAtu.Text) +
                 fStrToFloat(edtCartaoAtu.Text) +
                 fStrToFloat(EdtOrdPagAtu.Text) +
                 fStrToFloat(EdtValFinAtu.Text);

    edtTotalAtu.Text := FloatToStrF(fltValTot,ffFixed,12,2);

    edtFundoDeCaixaAtualizado.Text := '0,00';
    If (Not blnTransferenciaCega) And
       (objResumoDeCaixa.strTipoFechamento = 'C') Then
      edtFundoDeCaixaAtualizado.Text := edtDinheiroAtu.Text;

    cdsChqAVi.Close;
    cdsChqPre.Close;
    cdsCarCre.Close;
    edtTotalTra.Text     := '0,00';
    edtDinheiroTra.Text  := '0,00';
    edtChqVistaTra.Text  := '0,00';
    edtChqPreTra.Text    := '0,00';
    edtCartaoTra.Text    := '0,00';
    edtOrdPagTra.Text    := '0,00';
    edtValFinTra.Text    := '0,00';
    edtTotalTra2.Text    := '0,00';
    edtDinheiroTra2.Text := '0,00';
    edtChqVistaTra2.Text := '0,00';
    edtChqPreTra2.Text   := '0,00';
    edtCartaoTra2.Text   := '0,00';
    edtOrdPagTra2.Text   := '0,00';
    edtValFinTra2.Text   := '0,00';

    FAutoIncremsCartoes.Clear;
    FAutoIncremsChequesAVista.Clear;
    FAutoIncremsChequesPre.Clear;

    ExibeMensagensFechamentoAnterior;

  Finally
    FreeAndNil(qryGen);
  End;

End;

procedure TfrmRcxTrasfValores.pEscapePressed;
begin

  If ActiveControl.Parent = pnlFundo Then
  Begin

    If edtCodVendedor.CanFocus Then pSetFocus(edtCodVendedor)
    Else pSetFocus(edtGruGpo);

  End
  Else
    inherited;

end;

procedure TfrmRcxTrasfValores.edtGruGpoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupo: TConsultasArray;

begin
  inherited;

  If fPesqGrupoOperador(Self, edtGruGpo, edtDesGpo, Nil, Key, arrGrupo) Then
  Begin
    If fValidaCampos(edtGruGpo, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRcxTrasfValores.ExibeMensagensFechamentoAnterior;
  Var
    LSaldoDinheiro,
    LSaldoOrdemPagamento: Double;
begin
  Self.Height := Self.Height - IIF(pnlMensagemSaldoDinheiro.Visible, pnlMensagemSaldoDinheiro.Height, 0);
  Self.Height := Self.Height - IIF(pnlMensagemSaldoOrdemPagamento.Visible, pnlMensagemSaldoOrdemPagamento.Height, 0);
  Self.Height := Self.Height - IIF(pnlSaldoNegativoOperador.Visible, pnlSaldoNegativoOperador.Height, 0);

  pnlMensagemSaldoDinheiro.Visible := False;
  pnlMensagemSaldoOrdemPagamento.Visible := False;
  pnlSaldoNegativoOperador.Visible := False;

  If Not Concat(objResumoDeCaixa.TipoSaldoCaixa,
                objResumoDeCaixa.strTipoFechamento).Equals('CC') Then
  Begin
    If Not FOperadorObrigatorio Then
      Exit;
  End;

  If fEmptyStr(edtCodVendedor.Text) Then
    Exit;

  If edtCodVendedor.Text = FOperadorFechamento Then
    Exit;

  LSaldoDinheiro := FSaldoFechamentoDinheiro + FValorTransferenciaDinheiro + FValorTransferenciaOperadorDinheiro;
  LSaldoOrdemPagamento := FSaldoFechamentoOrdemPagamento + FValorTransferenciaOrdemPagamento + FValorTransferenciaOperadorOrdemPagamento;

  If Not blnTransferenciaCega Then
  Begin
    If LSaldoDinheiro > 0 Then
    Begin
      pnlMensagemSaldoDinheiro.Visible := True;
      lblMensagemSaldoDinheiro.Caption := 'O saldo a transferir em Dinheiro possui ' +
                                          FormatFloat(',0.00', LSaldoDinheiro) +
                                          ' referente ao saldo do fechamento anterior, feito pelo operador ' +
                                          fRetNomeOperador(FOperadorFechamento) + '.';

      Self.Height := Self.Height + pnlMensagemSaldoDinheiro.Height;
    End;
  End;

  If LSaldoOrdemPagamento > 0 Then
  Begin
    pnlMensagemSaldoOrdemPagamento.Visible := True;
    lblMensagemSaldoOrdemPagamento.Caption := 'O saldo a transferir em Ordem Pagto possui ' +
                                              FormatFloat(',0.00', LSaldoOrdemPagamento) +
                                              ' referente ao saldo do fechamento anterior, feito pelo operador ' +
                                              fRetNomeOperador(FOperadorFechamento) + '.';

    Self.Height := Self.Height + pnlMensagemSaldoOrdemPagamento.Height;
  End;

  If Concat(objResumoDeCaixa.strTipoFechamento, objResumoDeCaixa.TipoSaldoCaixa).Equals('CC') Then
  Begin
    If Not fCfgSis('F11TFO', varBoolean) Then
      Exit;

    If fFormataFloat(fStrToFloat(edtOrdPagAtu.Text), 2) < 0.00 Then
    Begin
      pnlSaldoNegativoOperador.Visible := True;
      lblSaldoNegativoOperador.Caption := 'ATENÇÃO: O saldo a transferir em Ordem Pagto possui ' + FormatFloat(',0.00', fStrToFloat(edtOrdPagAtu.Text)) + '.' + #13 +
                                          'Isso ocorre pois está utilizando o tipo de saldo = Caixas e configurado para não realizar a transferência ' + #13 +
                                          'dos recebimentos em Ordem de Pagto de forma automática.' + #13 +
                                          'Assim, o operador selecionado pode ter realizado a transferência de valores recebidos por outros operadores.';

      Self.Height := Self.Height + pnlSaldoNegativoOperador.Height;

      pnlSaldoNegativoOperador.Visible := False;
      Self.Refresh;
      pnlSaldoNegativoOperador.Visible := True;
    End;
  End;
end;

procedure TfrmRcxTrasfValores.edtCodVendedorEnter(Sender: TObject);
begin
  inherited;

  strVenAnt := edtCodVendedor.Text;

  If Not FOperadorObrigatorio Then
  Begin
    If Not objResumoDeCaixa.strTipoFechamento.Equals('C') Then
    Begin
      edtGruGpo.Enabled := True;
      edtDesVendedor.Clear;
    End;
  End;

end;

procedure TfrmRcxTrasfValores.edtGruGpoEnter(Sender: TObject);
begin
  inherited;
  If objResumoDeCaixa.OperadorTransferenciaDeveSerLogadoCaixa Or (blnTransferenciaCega) Then
  Begin
    pCarregaVendedor(edtCodVendedor.Text);
    edtCodVendedor.Enabled := False;
    edtGruGpo.Enabled      := False;
  End;
  edtDesGpo.Clear;
end;

end.


