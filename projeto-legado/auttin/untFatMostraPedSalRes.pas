unit untFatMostraPedSalRes;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, DB,
  Grids, DBGridCitel, DBGrids, {Qt,} Menus, EditFocus, AppEvnts, BitBtnLockedIncrem;

type
  TfrmFatMostraPedSalRes = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    dbeItens: TDBGridCitel;
    pnlBotoesMostra: TPanel;
    edtItem: TEditFocus;
    btnFechar: TBitBtnLocked;
    procedure btnFecharClick(Sender: TObject);
    procedure dbeItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    dtsSalRes: TDataSource;
  end;

var
  frmFatMostraPedSalRes: TfrmFatMostraPedSalRes;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatMostraPedSalRes.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraPedSalRes.dbeItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
  Begin
    btnFechar.Click;
  End;
end;

procedure TfrmFatMostraPedSalRes.FormCreate(Sender: TObject);
begin
  inherited;
  dtsSalRes := TDataSource.Create(Self);
  dbeItens.DataSource := dtsSalRes;
end;

procedure TfrmFatMostraPedSalRes.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnFechar);
end;

end.

