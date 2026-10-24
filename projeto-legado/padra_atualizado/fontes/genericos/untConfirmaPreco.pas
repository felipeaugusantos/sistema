unit untConfirmaPreco;

interface

uses
  Windows, Controls, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  ComboBoxFocus, BitBtnLockedIncrem, Classes, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmConfirmaPreco = class(TfrmPaiConfirma)
    Panel1: TPanel;
    rdgOpcao: TRadioGroup;
    gpbTabela: TGroupBox;
    Label1: TLabel;
    cbTabela: TComboBoxFocus;
    chkPrePro: TCheckBox;
    pnlLayDescri: TPanel;
    procedure rdgOpcaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    { Public declarations }
  end;

var
  frmConfirmaPreco: TfrmConfirmaPreco;

implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

function TfrmConfirmaPreco.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

  End;

  If Not Result Then
    pSetFocus(Sender);
    
end;


procedure TfrmConfirmaPreco.rdgOpcaoClick(Sender: TObject);
begin
  inherited;

  If (rdgOpcao.Items.Count > 1) Then
  Begin

    If (rdgOpcao.ItemIndex = 0) Then
    Begin
      Self.Height      := Self.Height - gpbTabela.Height;
      cbTabela.Visible := False;
      gpbTabela.Visible := False;

    End
    Else If (rdgOpcao.ItemIndex = 1) Then
    Begin
      Self.Height      := Self.Height + gpbTabela.Height;
      cbTabela.Visible := True;
      gpbTabela.Visible := True;
    End;
    
  End;
end;

procedure TfrmConfirmaPreco.FormCreate(Sender: TObject);
  Var
     VS_strTabPrc: String;
     intIndice: Integer;
begin
  inherited;
  VS_strTabPrc := fCfgSis('TABPRC');
  cbTabela.Clear;

  For intIndice := 1 To Length(Trim(VS_strTabPrc)) Do
  Begin

    If VS_strTabPrc[intIndice] = 'S' Then
    Begin

      If (intIndice = 1) Then
        cbTabela.Items.Add('Tabela- 1');
      If (intIndice = 2) Then
        cbTabela.Items.Add('Tabela- 2');
      If (intIndice = 3) Then
        cbTabela.Items.Add('Tabela- 3');
      If (intIndice = 4) Then
        cbTabela.Items.Add('Tabela- 4');
      If (intIndice = 5) Then
        cbTabela.Items.Add('Tabela- 5');
      If (intIndice = 6) Then
        cbTabela.Items.Add('Tabela- 6');
      If (intIndice = 7) Then
        cbTabela.Items.Add('Tabela- 7');

    End;

  End;



end;

procedure TfrmConfirmaPreco.FormShow(Sender: TObject);
begin
  inherited;

  rdgOpcao.ItemIndex := 0;
  cbTabela.ItemIndex := 0;

  Self.SelectNext(ActiveControl, True, True);
  pSetFocus(btnConfirma);

end;

end.
