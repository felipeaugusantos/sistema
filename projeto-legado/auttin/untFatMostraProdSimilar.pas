unit untFatMostraProdSimilar;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, DB,
  Grids, DBGridCitel, DBGrids, {Qt,} Menus, EditFocus, AppEvnts, BitBtnLockedIncrem;

type
  TfrmFatMostraProdSimilar = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    dbeItens: TDBGridCitel;
    pnlBotoesMostra: TPanel;
    Label1: TLabel;
    edtItem: TEditFocus;
    btnFechar: TBitBtnLocked;
    procedure btnFecharClick(Sender: TObject);
    procedure dbeItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dtsProSim: TDataSource;
  end;

var
  frmFatMostraProdSimilar: TfrmFatMostraProdSimilar;

implementation

{$R *.dfm}

procedure TfrmFatMostraProdSimilar.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraProdSimilar.dbeItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
  Begin
    btnFechar.Click;
  End;
end;

procedure TfrmFatMostraProdSimilar.FormCreate(Sender: TObject);
begin
  inherited;
  dtsProSim := TDataSource.Create(Self);
  dbeItens.DataSource := dtsProSim;
end;

end.
