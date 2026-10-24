unit untConfirmaTipoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, ComboBoxFocus;

type
  TfrmConfirmaTipoProduto = class(TfrmPaiConfirma)
    cmbTipProd: TComboBoxFocus;
    Label146: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    procedure pIndicaTipoProdutoSPED(strTipoProduto: String);
    { Private declarations }
  public
    class function fSelecionaTipoProduto(var strTipoProduto : String): Boolean;
    { Public declarations }
  end;

var
  frmConfirmaTipoProduto: TfrmConfirmaTipoProduto;

implementation

uses untConstantes, strUtils, untFuncoesGen, untTypesSistema;
{$R *.dfm}

procedure TfrmConfirmaTipoProduto.FormCreate(Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;
  cmbTipProd.Items.Clear;
  For intContador := Low(TIPO_PRODUTO_SPED) To High(TIPO_PRODUTO_SPED) Do
  Begin
    cmbTipProd.Items.Add(TIPO_PRODUTO_SPED[intContador][0] + ' - ' + TIPO_PRODUTO_SPED[intContador][1]);
  End;
  cmbTipProd.ItemIndex := 0;
end;

procedure TfrmConfirmaTipoProduto.pIndicaTipoProdutoSPED(strTipoProduto : String);
  Var
    intContador: Integer;
begin
  cmbTipProd.ItemIndex := 0;
  For intContador := 0 To cmbTipProd.Items.Count -1 Do
  Begin
    If AnsiStartsText(strTipoProduto, cmbTipProd.Items[intContador]) Then
    Begin
      cmbTipProd.ItemIndex := intContador;
      Break;
    End;
  End;
end;

class function TfrmConfirmaTipoProduto.fSelecionaTipoProduto(var strTipoProduto : String): Boolean;
Begin
  Try
    pCriarFormularios(TfrmConfirmaTipoProduto, frmConfirmaTipoProduto);
    frmConfirmaTipoProduto.pIndicaTipoProdutoSPED(strTipoProduto);

    Result := (frmConfirmaTipoProduto.ShowModal = mrOk);

    If (Result) Then
      strTipoProduto := LeftStr(frmConfirmaTipoProduto.cmbTipProd.Text, 2);;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fSelecionaTipoProduto]');
    End;
  End;

  pFreeAndNil(frmConfirmaTipoProduto);
end;

end.
