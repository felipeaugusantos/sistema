unit untFatMostraEstoqueEmp;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, DB,
  Grids, DBGridCitel, DBGrids, {Qt,} Menus, EditFocus, AppEvnts, BitBtnLockedIncrem,
  untPaiSimples;

type
  TfrmFatMostraEstoqueEmp = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    dbeEstoque: TDBGridCitel;
    pnlBotoesMostra: TPanel;
    edtItem: TEditFocus;
    btnFechar: TBitBtnLocked;
    procedure btnFecharClick(Sender: TObject);
    procedure dbeEstoqueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dtsEstLoj: TDataSource;
  end;

var
  frmFatMostraEstoqueEmp: TfrmFatMostraEstoqueEmp;

implementation


{$R *.dfm}

procedure TfrmFatMostraEstoqueEmp.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraEstoqueEmp.dbeEstoqueKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
  Begin
    btnFechar.Click;
  End;
end;

procedure TfrmFatMostraEstoqueEmp.FormCreate(Sender: TObject);
begin
  inherited;
  dtsEstLoj := TDataSource.Create(Self);
  dbeEstoque.DataSource := dtsEstLoj;
end;

end.
