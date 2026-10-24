unit untImpEtiDespachoPorAmbiente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Datasnap.DBClient, UniClientDataSet;

type
  TfrmEtiDespachoPorAmbiente = class(TfrmPaiSimples)
    dbgDespachoPorAmbiente: TDBGridCitel;
    Panel1: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    cdsDespachoAmbiente: TUniClientDataSet;
    dtsDespachoAmbiente: TDataSource;
    cdsDespachoAmbienteAMBIENTE: TStringField;
    cdsDespachoAmbienteVOLUME: TIntegerField;
    TOTVOL: TAggregateField;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cdsDespachoAmbienteVOLUMEValidate(Sender: TField);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cdsDespachoAmbienteBeforeInsert(DataSet: TDataSet);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    strQtdVol: string;
    blnImprimir: Boolean;
  end;

var
  frmEtiDespachoPorAmbiente: TfrmEtiDespachoPorAmbiente;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmEtiDespachoPorAmbiente.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if cdsDespachoAmbiente.State in [dsEdit] then
    cdsDespachoAmbiente.Post;

  if ( TAggregateField(cdsDespachoAmbiente.FieldByName('TOTVOL')).Value > StrToInt( strQtdVol )) then
  begin
    fMensagem('ATENÇÃO!', 'Quantidade de volumes por ambiente maior que a quantidade de volumes definida!', ['&Ok']);
    Abort;
  end;
  if ( TAggregateField(cdsDespachoAmbiente.FieldByName('TOTVOL')).Value < StrToInt( strQtdVol )) then
  begin
    fMensagem('ATENÇÃO!', 'Quantidade de volumes por ambiente menor que a quantidade de volumes definida!', ['&Ok']);
    Abort;
  end;

  blnImprimir := True;
  Self.Close;

end;

procedure TfrmEtiDespachoPorAmbiente.btnSairClick(Sender: TObject);
begin
  inherited;
  blnImprimir := False;
  Self.Close;
end;

procedure TfrmEtiDespachoPorAmbiente.cdsDespachoAmbienteBeforeInsert(
  DataSet: TDataSet);
begin
  inherited;
  if dbgDespachoPorAmbiente.Focused then
    Abort;
end;

procedure TfrmEtiDespachoPorAmbiente.cdsDespachoAmbienteVOLUMEValidate(
  Sender: TField);
begin
  inherited;
  if (cdsDespachoAmbiente.FieldByName('VOLUME').asInteger = 0) then
    fMensagem('ATENÇÃO!', 'Quantidade de volumes não pode ser igual a zero!', ['&Ok']);
end;

procedure TfrmEtiDespachoPorAmbiente.FormActivate(Sender: TObject);
begin
  inherited;
  cdsDespachoAmbiente.Open;
end;

procedure TfrmEtiDespachoPorAmbiente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F10 then
  begin
    btnConfirma.Click;
  end
  else if Key = VK_ESCAPE then
  begin
    btnSair.Click
  end;
end;

procedure TfrmEtiDespachoPorAmbiente.FormShow(Sender: TObject);
begin
  inherited;
  if cdsDespachoAmbiente.Active then
    cdsDespachoAmbiente.First;
end;

end.
