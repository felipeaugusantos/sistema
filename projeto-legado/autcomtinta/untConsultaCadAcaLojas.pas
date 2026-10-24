unit untConsultaCadAcaLojas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, DB,   Uni,
  BitBtnLockedIncrem, MemDS, DBAccess, frxClass, frxExportCSVTestabilidade;

type
  TfrmConsultaCadAcaLojas = class(TfrmPai)
    dbgSaldos: TDBGridCitel;
    dtsSaldos: TDataSource;
    qrySaldos: TUniQuery;
    procedure dbgSaldosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strCodAca: String;
    strCodEmp: String;
  end;

var
  frmConsultaCadAcaLojas: TfrmConsultaCadAcaLojas;

implementation

uses untModulo;

{$R *.dfm}

procedure TfrmConsultaCadAcaLojas.dbgSaldosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmConsultaCadAcaLojas.FormShow(Sender: TObject);
begin
  inherited;
  qrySaldos.Connection := frmModulo.GetCurrentConnection;
  qrySaldos.Close;
  qrySaldos.ParamByName('CODACA').AsString := strCodAca;
  qrySaldos.ParamByName('CODEMP').AsString := strCodEmp;
  qrySaldos.Open;

  TFloatField(qrySaldos.FieldByName('ACA_SALDOS')).DisplayFormat := '#,###0.000';
end;

end.
