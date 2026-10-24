{***********************************************}
{* TECLAS DE ATALHO P/ TELA DE FRENTE DE CAIXA *}
{* DATA: 19/09/2011                            *}
{* AUTOR: ALEXANDRE OLIVEIRA FERRI             *}
{********************************************AF*}

unit untAjuda;

interface

uses
  Windows, Classes,
  untPai, Menus, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, Controls, StdCtrls, Buttons, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmAjuda = class(TfrmPai)
    Shape1: TShape;
    Panel8: TPanel;
    Panel11: TPanel;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel2: TPanel;
    pnlRetificarPreco: TPanel;
    Panel9: TPanel;
    Panel7: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses Graphics, Forms, untFuncoesSimples;

{$R *.dfm}

procedure TfrmAjuda.FormShow(Sender: TObject);
begin
  inherited;
  Self.Brush.Style := bsClear;
  pnlRetificarPreco.Visible := fCfgSis('RETPF3', VarBoolean);
  Panel6.Visible            := fCfgSis('DESF03',varBoolean);

  If Not pnlRetificarPreco.Visible Then
    Self.Height := Self.Height - pnlRetificarPreco.Height;
end;

procedure TfrmAjuda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = Vk_Escape Then
    Close;
    
end;

end.
