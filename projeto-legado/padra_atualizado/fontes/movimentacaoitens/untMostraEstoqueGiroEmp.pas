unit untMostraEstoqueGiroEmp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Grids, DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus;

type
  TfrmMostraEstoqueGiroEmp = class(TfrmPai)
    pnlGiroMeses: TPanel;
    lblQtdM04: TLabel;
    dbeQtdM04: TDBEditFocus;
    lblQtdM05: TLabel;
    dbeQtdM05: TDBEditFocus;
    lblQtdM06: TLabel;
    dbeQtdM06: TDBEditFocus;
    lblQtdM07: TLabel;
    dbeQtdM07: TDBEditFocus;
    lblQtdM08: TLabel;
    dbeQtdM08: TDBEditFocus;
    lblQtdM09: TLabel;
    dbeQtdM09: TDBEditFocus;
    lblQtdM10: TLabel;
    dbeQtdM10: TDBEditFocus;
    lblQtdM11: TLabel;
    dbeQtdM11: TDBEditFocus;
    lblQtdM12: TLabel;
    dbeQtdM12: TDBEditFocus;
    Panel2: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtItem: TEditFocus;
    dbeEstoque: TDBGridCitel;
    Panel1: TPanel;
    Label2: TLabel;
    lblSaldo: TLabel;
    lblMes3: TLabel;
    lblMes2: TLabel;
    lblMes1: TLabel;
    lblMedia: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMostraEstoqueGiroEmp: TfrmMostraEstoqueGiroEmp;

implementation

{$R *.dfm}

procedure TfrmMostraEstoqueGiroEmp.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End;
end;

end.
