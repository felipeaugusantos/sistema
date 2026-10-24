unit untAgregados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.Grids, Vcl.DBGrids, System.UITypes,
  Vcl.StdCtrls, EditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Data.DB,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, untZClient,
  StrUtils, DbGridCitel;

type
  THackDBGrid = class(TDBGridCitel);

  TfrmAgregados = class(TfrmPaiSimples)
    dbeItens: TDBGridCitel;
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    shpPai: TShape;
    Label1: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  public
    strTabPre: String;
    blnFaturamento: Boolean;
    class Procedure pExibe(strCodAgr : String; strTabPre: String; blnFaturamento: Boolean);
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesRel, untFuncoesRel2;

{ TfrmAgregados }

procedure TfrmAgregados.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAgregados.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeItens);
end;

procedure TfrmAgregados.FormCreate(Sender: TObject);
begin
  inherited;
  strTabPre := '';
  blnFaturamento := False;
end;

procedure TfrmAgregados.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    Close;
end;

class procedure TfrmAgregados.pExibe(strCodAgr: String; strTabPre: String; blnFaturamento: Boolean);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(172, 7367, [],
                        ['TABPRE','CODEMP','CODAGR'],
                        [strTabPre,
                        VS_strCodEmp,
                        strCodAgr],
                        nil,
                        nil,
                        True);
  End;

end;

end.
