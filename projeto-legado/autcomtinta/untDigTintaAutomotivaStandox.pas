unit untDigTintaAutomotivaStandox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaAutomotiva, AppEvnts, Menus, StdCtrls, ComboBoxFocus,
  EditFocus, ExtCtrls, Buttons, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmDigTintaAutomotivaStandox = class(TfrmDigTintaAutomotiva)
    rdgPorcDil: TRadioGroup;
    pnlMsgPercDiluicao: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    procedure cmbListaAdicionalChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdgModoVendaClick(Sender: TObject); override;
    procedure FormCreate(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure rdgPorcDilClick(Sender: TObject);
  private
    FstrDiluente: String;
    { Private declarations }
    procedure pRecalculaFormula();
    procedure SetstrDiluente(const Value: String);

    procedure pPercentualDilVisivel;
  protected
    function fAlturaPnlAdicional: Integer; override;
    function fAlturaConsEmb: Integer; override;
    function fAlturaTrocaEmb: Integer; override;
  public
    { Public declarations }
    property strDiluente: String read FstrDiluente write SetstrDiluente;    
  end;

var
  frmDigTintaAutomotivaStandox: TfrmDigTintaAutomotivaStandox;

implementation

{$R *.dfm}

uses untStandoxDinamica, untFuncEspecificas, untFuncoesGen, untFuncoesSimples;

procedure TfrmDigTintaAutomotivaStandox.btnConfirmaClick(Sender: TObject);
begin
  If rdgPorcDil.Visible Then
  Begin
    TFormulaStandox(objFormula).pReformulaNovo(cmbListaAdicional.Text, objFormula.intIdxPorDil);
    pAtualizaPrecos;
  End;

  inherited;
end;

procedure TfrmDigTintaAutomotivaStandox.btnFormulacaoClick(Sender: TObject);
begin
  If rdgPorcDil.Visible Then
  Begin
    TFormulaStandox(objFormula).pReformulaNovo(cmbListaAdicional.Text, rdgPorcDil.ItemIndex);
    pAtualizaPrecos;
  End;

  inherited;
end;

procedure TfrmDigTintaAutomotivaStandox.cmbListaAdicionalChange(
  Sender: TObject);
begin
  pRecalculaFormula;
  pAtualizaPrecos;
  inherited;
  pPercentualDilVisivel;
end;

function TfrmDigTintaAutomotivaStandox.fAlturaConsEmb: Integer;
begin
  Result := pnlConsEmb.Height;
end;

function TfrmDigTintaAutomotivaStandox.fAlturaPnlAdicional: Integer;
begin
  Result := pnlAdicional.Height;
end;

function TfrmDigTintaAutomotivaStandox.fAlturaTrocaEmb: Integer;
begin
  Result := pnlTrocaEmb.Height;
end;

procedure TfrmDigTintaAutomotivaStandox.FormCreate(Sender: TObject);
begin
  inherited;
  intAlturaOri := Self.Height;
  If (fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  fVerificaAcessoSistema('DIRVISFOR');
end;

procedure TfrmDigTintaAutomotivaStandox.FormShow(Sender: TObject);
  Var
    objFormulaStandox: TFormulaStandox;
begin
  inherited;
  objFormulaStandox := TFormulaStandox(objFormula);

  lblTipo.Visible := False;
  cmbTipoEmbalagem.Visible := False;
  cmbListaAdicional.ItemIndex := objFormulaStandox.intIndiceAdicional;

  If (rdgModoVenda.ItemIndex = 0) Then
  Begin
    pnlAdicional.Visible := False;
  End
  Else If (rdgModoVenda.ItemIndex = 1) Then
  Begin
    pnlAdicional.Visible := True;
  End;

  //SelectNext(ActiveControl, True, True);
 // SelectNext(ActiveControl, True, True);

end;

procedure TfrmDigTintaAutomotivaStandox.pPercentualDilVisivel;
begin
  rdgPorcDil.Visible := ((cmbListaAdicional.Text  = 'STBLCOATA')
                       Or (cmbListaAdicional.Text = 'STBLADJSL'));

  pnlMsgPercDiluicao.Visible := rdgPorcDil.Visible;
end;

procedure TfrmDigTintaAutomotivaStandox.pRecalculaFormula;
begin
  TFormulaStandox(objFormula).pReformulaNovo(cmbListaAdicional.Text);
//  objFormula.pCalcularPrecos;
end;

procedure TfrmDigTintaAutomotivaStandox.rdgModoVendaClick(Sender: TObject);
begin
//  inherited;

  Case rdgModoVenda.ItemIndex Of
    0: objFormula.mveModoVenda := mvConcentrado;
    Else
      objFormula.mveModoVenda := mvDiluido;
  End;

  If (rdgModoVenda.ItemIndex = 0) Then
  Begin
    pnlAdicional.Visible := False;
  End
  Else If (rdgModoVenda.ItemIndex = 1) Then
  Begin
    pnlAdicional.Visible := True;
  End;



  pPercentualDilVisivel;

  Self.Height := intAlturaOri;

  If Not pnlAdicional.Visible Then
    Self.Height := Self.Height - fAlturaPnlAdicional;

  If Not pnlConsEmb.Visible Then
    Self.Height := Self.Height - fAlturaConsEmb;

  If Not pnlTrocaEmb.Visible Then
    Self.Height := Self.Height - fAlturaTrocaEmb;

  pRecalculaFormula;
  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotivaStandox.rdgPorcDilClick(Sender: TObject);
begin
  inherited;

  objFormula.intIdxPorDil := rdgPorcDil.ItemIndex;

  TFormulaStandox(objFormula).pReformulaNovo(cmbListaAdicional.Text, objFormula.intIdxPorDil);
  pAtualizaPrecos;
end;

procedure TfrmDigTintaAutomotivaStandox.SetstrDiluente(const Value: String);
begin
  FstrDiluente := Value;
end;

end.
