unit untDespAduaneiras;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus;

type
  TfrmDespAduaneiras = class(TfrmPaiConfirma)
    pnlDespesas: TPanel;
    pnlTotal: TPanel;
    lblDemurrage: TLabel;
    lblTaxa: TLabel;
    lblDespachante: TLabel;
    lblFrete: TLabel;
    lblOutrasDesp: TLabel;
    lblMulta: TLabel;
    lblFreteInterno: TLabel;
    lblF500: TLabel;
    lblDespAduaneiras: TLabel;
    lblTotal: TLabel;
    edtDemurrage: TEditFocus;
    edtTaxa: TEditFocus;
    edtDespachante: TEditFocus;
    edtFrete: TEditFocus;
    edtOutrasDesp: TEditFocus;
    edtMulta: TEditFocus;
    edtFreteInterno: TEditFocus;
    edtF500: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtDemurrageExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function fSomaDespesasAduaneiras: Double;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmDespAduaneiras }

procedure TfrmDespAduaneiras.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  if fVerificaCampos then
  begin
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmDespAduaneiras.edtDemurrageExit(Sender: TObject);
begin
  inherited;
  if fValidaCampos(TWinControl(Sender)) then
  begin
    lblTotal.Caption := 'R$: ' + FormatFloat('#,##0.00', fSomaDespesasAduaneiras);
  end;
end;

procedure TfrmDespAduaneiras.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDemurrage);
end;

function TfrmDespAduaneiras.fSomaDespesasAduaneiras: Double;
begin

  Result := StrToFloatDef(StringReplace(edtDemurrage.Text, '.', '', [rfReplaceAll]),0) +
            StrToFloatDef(StringReplace(edtTaxa.Text, '.', '', [rfReplaceAll]),0) +
            StrToFloatDef(StringReplace(edtDespachante.Text, '.', '', [rfReplaceAll]),0) +
            StrToFloatDef(StringReplace(edtFrete.Text, '.', '', [rfReplaceAll]),0) +
            StrToFloatDef(StringReplace(edtOutrasDesp.Text, '.', '', [rfReplaceAll]),0) +
            StrToFloatDef(StringReplace(edtMulta.Text, '.', '', [rfReplaceAll]),0) +
            StrToFloatDef(StringReplace(edtFreteInterno.Text, '.', '', [rfReplaceAll]),0) +
            StrToFloatDef(StringReplace(edtF500.Text, '.', '', [rfReplaceAll]),0);
end;

function TfrmDespAduaneiras.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    if (Sender = edtDemurrage) and (StrToFloatDef(edtDemurrage.Text,0) < 0) then
    begin
      fMensagem('','O valor de demurrage deve ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    end
    else
    if (Sender = edtTaxa) and (StrToFloatDef(edtTaxa.Text,0) < 0) then
    begin
      fMensagem('','O valor da taxa de armazenagem deve ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    end
    else
    if (Sender = edtDespachante) and (StrToFloatDef(edtDespachante.Text,0) < 0) then
    begin
      fMensagem('','O valor do despachante deve ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    end
    else
    if (Sender = edtFrete) and (StrToFloatDef(edtFrete.Text,0) < 0) then
    begin
      fMensagem('','O valor do frete deve ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    end
    else
    if (Sender = edtOutrasDesp) and (StrToFloatDef(edtOutrasDesp.Text,0) < 0) then
    begin
      fMensagem('','O valor de outras despesas deve ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    end
    else
    if (Sender = edtMulta) and (StrToFloatDef(edtMulta.Text,0) < 0) then
    begin
      fMensagem('','O valor da multa do setor aduaneiro deve ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    end
    else
    if (Sender = edtFreteInterno) and (StrToFloatDef(edtFreteInterno.Text,0) < 0) then
    begin
      fMensagem('','O valor do frete interno deve ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    end
    else
    if (Sender = edtF500) and (StrToFloatDef(edtF500.Text,0) < 0) then
    begin
      fMensagem('','O valor do F500 deve ser maior ou igual a zero!', ['&Ok']);
      Result := False;
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
