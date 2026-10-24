unit Expedicao.View.frmSeparacaoAvulsaEnviarSeparador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem,
  untCadLote, Estoque.Lote.TCdsLoteQuantidade, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid,
  cxCurrencyEdit;

type
  TfrmSeparacaoAvulsaEnviarSeparador = class(TfrmPaiConfirma)
    pnlDados: TPanel;
    pnlSeparacao: TPanel;
    Label4: TLabel;
    edtCodigoSeparador: TEditFocus;
    edtNomeSeparador: TEditFocus;
    Label1: TLabel;
    edtDescricaoProduto: TEditFocus;
    edtCodigoProduto: TEditFocus;
    Label2: TLabel;
    edtQuantidade: TEditFocus;
    pnlLotes: TPanel;
    cxgLotesDBTBV: TcxGridDBTableViewCitel;
    cxgLotesLVL: TcxGridLevel;
    cxgLotes: TcxGridCitel;
    lblNumLot: TLabel;
    edtNumeroLote: TEditFocus;
    lblQuantidade: TLabel;
    edtQuantidadeLote: TEditFocus;
    btnAdicionarLote: TBitBtnLocked;
    btnExcluirLote: TBitBtnLocked;
    dtsLotes: TDataSource;
    cxgLotesNUMERO_LOTE: TcxGridDBColumn;
    cxgLotesQUANTIDADE: TcxGridDBColumn;
    procedure edtCodigoSeparadorKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumeroLoteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnAdicionarLoteClick(Sender: TObject);
    procedure btnExcluirLoteClick(Sender: TObject);
  private
    objCadLot : TCadLot;
    function fValidaLote: Boolean;
    function fValidaQuantidade(var fltQuantidade : Double): Boolean;
    { Private declarations }
  public
    strCodigoProduto : String;
    fltQuantidadeSolicitada : Double;
    cdsLotes : TCdsLoteQuantidade;
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

function TfrmSeparacaoAvulsaEnviarSeparador.fValidaLote() : Boolean;
begin
  Result := True;

  if fEmptyStr(edtNumeroLote.Text) then
  begin
    pMensagemOk('Informe o número do lote!');
    exit(False);
  end;

  if (edtNumeroLote.Text = 'A DEFINIR') then
  begin
    pMensagemOk('Não é possível informar o lote A DEFINIR');
    exit(False);
  end;

  if not objCadLot.fExisteLote(strCodigoProduto, VS_strCodEmp, edtNumeroLote.Text, False) then
  begin
    pMensagemOk('Lote não encontrado!');
    exit(False);
  end;

  if fEmptyStr(objCadLot.fLocalizacaoFisicaLote(strCodigoProduto, VS_strCodEmp, edtNumeroLote.Text)) then
  begin
    pMensagemOk('É necessário informar um lote com localização física!');
    exit(False);
  end;

end;

function TfrmSeparacaoAvulsaEnviarSeparador.fValidaQuantidade(var fltQuantidade : Double): Boolean;
var
  fltQuantidadeExistente : Double;
begin
  Result := True;

  if edtQuantidadeLote.Text = '' then
  begin
    pMensagemOk('Informe a quantidade!');
    exit(False);
  end;

  fltQuantidade := fStrToFloat(edtQuantidadeLote.Text);

  if fltQuantidade <= 0 then
  begin
    pMensagemOk('A quantidade deve ser maior que zero!');
    exit(False);
  end;

  fltQuantidadeExistente := 0;
  if cdsLotes.Locate('NUMERO_LOTE', edtNumeroLote.Text, []) then
    fltQuantidadeExistente := cdsLotes.FieldByName('QUANTIDADE').AsFloat;

  if (fltQuantidade - fltQuantidadeExistente + fDoubleAggregate(cdsLotes, 'QUANTIDADE_TOTAL') ) > fltQuantidadeSolicitada then
  begin
    pMensagemOk('A quantidade total separada deve ser igual a quantidade solicitada!');
    exit(False);
  end;

end;

procedure TfrmSeparacaoAvulsaEnviarSeparador.btnAdicionarLoteClick(Sender: TObject);
var
  fltQuantidade : Double;
begin
  edtNumeroLote.Text := Trim(edtNumeroLote.Text);

  if not fValidaLote() then
  begin
    pSetFocus(edtNumeroLote);
    exit()
  end;

  if not fValidaQuantidade(fltQuantidade) then
  begin
    pSetFocus(edtQuantidadeLote);
    exit()
  end;

  if fRetornaSaldoDisponivel(strCodigoProduto, False, True, edtNumeroLote.Text) < fltQuantidadeSolicitada then
  begin
    pMensagemOk('O Lote não possui saldo disponível para a quantidade informada!');
    pSetFocus(edtNumeroLote);
    exit();
  end;

  if cdsLotes.Locate('NUMERO_LOTE', edtNumeroLote.Text, []) then
    cdsLotes.Edit
  else
  begin
    cdsLotes.Insert;
    cdsLotes.FieldByName('CODIGO_PRODUTO').AsString := strCodigoProduto;
    cdsLotes.FieldByName('NUMERO_LOTE').AsString := edtNumeroLote.Text;
  end;

  cdsLotes.FieldByName('QUANTIDADE').AsFloat := fltQuantidade;
  cdsLotes.Post;

  edtNumeroLote.Clear;
  edtQuantidadeLote.Text := '0,00';
  pSetFocus(edtNumeroLote);

end;

procedure TfrmSeparacaoAvulsaEnviarSeparador.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if fDoubleAggregate(cdsLotes, 'QUANTIDADE_TOTAL') <> fltQuantidadeSolicitada then
  begin
    pMensagemOk('A quantidade total separada deve ser igual a quantidade solicitada!');
    modalResult := mrNone;
  end;

end;

procedure TfrmSeparacaoAvulsaEnviarSeparador.btnExcluirLoteClick(Sender: TObject);
begin
  if not cdsLotes.isEmpty then
    cdsLotes.Delete;
end;

procedure TfrmSeparacaoAvulsaEnviarSeparador.edtCodigoSeparadorKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  if fEntraCons(Key) then
  begin
    If (fPesqOperador(Self, edtCodigoSeparador, edtNomeSeparador, nil, Key, arrSel)) Then
    Begin
      If fValidaCampos(edtCodigoSeparador, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end;

end;
procedure TfrmSeparacaoAvulsaEnviarSeparador.edtNumeroLoteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If objCadLot.fedtNumLotKeyPress(edtCodigoProduto.Text, Sender, Key, edtNumeroLote, Self, True, True) Then
  Begin
    If fValidaCampos(edtNumeroLote, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmSeparacaoAvulsaEnviarSeparador.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;

begin
  Result := True;

  try

    if Sender = edtCodigoSeparador then
    begin
      edtNomeSeparador.Text := fRetNomeOperador(edtCodigoSeparador.Text);
      if fEmptyStr(edtNomeSeparador.Text) then
      begin
        edtCodigoSeparador.Clear;
        pMensagemOk('Informe o separador!');
        exit(False);
      end;
    end;

  finally
    if not Result then
    begin
      blnMudarFoco := False;
      pSetFocus(Sender);
    end;
  end;

end;

procedure TfrmSeparacaoAvulsaEnviarSeparador.FormCreate(Sender: TObject);
begin
  inherited;
  objCadLot := TCadLot.Create(Self);
  cdsLotes := TCdsLoteQuantidade.Create(Self);
  dtsLotes.DataSet := cdsLotes;
  strCodigoProduto := '';
  fltQuantidadeSolicitada := 0;
  edtQuantidadeLote.Text := '0,00';
end;

procedure TfrmSeparacaoAvulsaEnviarSeparador.FormShow(Sender: TObject);
begin
  inherited;
  edtCodigoProduto.Text := strCodigoProduto;
  edtDescricaoProduto.Text := fRetNomProduto(strCodigoProduto);
  edtQuantidade.Text := FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), fltQuantidadeSolicitada);
  edtQuantidadeLote.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  (cxgLotesQUANTIDADE.Properties as TcxCurrencyEditProperties).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  (cxgLotesQUANTIDADE.Properties as TcxCurrencyEditProperties).DecimalPlaces := fCfgSis('DECUNI', varInteger);
  cxgLotesDBTBV.DataController.Summary.FooterSummaryItems[0].Format := fMskDigitos(fCfgSis('DECUNI', varInteger));
end;

end.
