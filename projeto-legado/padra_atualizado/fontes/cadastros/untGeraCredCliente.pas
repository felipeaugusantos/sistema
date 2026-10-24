unit untGeraCredCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, Menus, StdCtrls, Buttons, ExtCtrls, DB,
  UniClientDataSet, AppEvnts, DBCtrls, BitBtnLockedIncrem;

type
  TfrmGeraCredCliente = class(TfrmPai)
    dbgCredito: TDBGridCitel;
    cdsCredito: TUniClientDataSet;
    dtsCredito: TDataSource;
    cdsCreditoMARCA: TStringField;
    cdsCreditoDTAINI: TDateTimeField;
    cdsCreditoDTAFIN: TDateTimeField;
    cdsCreditoMETA: TFloatField;
    cdsCreditoFATURA: TFloatField;
    cdsCreditoDESCON: TFloatField;
    cdsCreditoCALC_CREDITO: TFloatField;
    cdsCreditoDTABAI: TDateTimeField;
    cdsCreditoGRUPO: TStringField;
    cdsCreditoFORNEC: TStringField;
    cdsCreditoTIPMET: TStringField;
    cdsCreditoLITRAGEM: TFloatField;
    pnlRodape: TPanel;
    dbtxtDESMAR: TDBText;
    btnConfirmar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsCreditoCalcFields(DataSet: TDataSet);
    procedure btnConfirmarClick(Sender: TObject);
    procedure dtsCreditoDataChange(Sender: TObject; Field: TField);
    procedure dbgCreditoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmGeraCredCliente: TfrmGeraCredCliente;

implementation

uses  untfuncoesSimples;

{$R *.dfm}

procedure TfrmGeraCredCliente.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCredito.CreateDataSet;
end;

procedure TfrmGeraCredCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  cdsCredito.Close;
end;

{*******************************************}
{* CALCULA CRÉDITO                         *}
{****************************************RL*}
procedure TfrmGeraCredCliente.cdsCreditoCalcFields(DataSet: TDataSet);
begin
  inherited;
  With DataSet Do
  Begin
    If (FieldByName('TIPMET').AsString = 'V') Then
    Begin
      If FieldByName('FATURA').AsFloat >= FieldByName('META').AsFloat Then
        FieldByName('CALC_CREDITO').AsFloat := FieldByName('FATURA').AsFloat * (FieldByName('DESCON').AsFloat / 100);
    End
    Else If (FieldByName('TIPMET').AsString = 'L') Then
    Begin
      If (FieldByName('LITRAGEM').AsFloat >= FieldByName('META').AsFloat) Then
        FieldByName('CALC_CREDITO').AsFloat := FieldByName('FATURA').AsFloat * (FieldByName('DESCON').AsFloat / 100);
    End;
  End;
end;

{*******************************************}
{* CONFIRMA GERAÇÃO DE CRÉDITO             *}
{****************************************RL*}
procedure TfrmGeraCredCliente.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Confirma a geração do crédito no valor de ' +
   FloatToStrF(cdsCredito.FieldByName('CALC_CREDITO').AsFloat, ffFixed, 12, 2), ['&Sim', '&Não']) = 1 Then
    ModalResult := mrOk
  Else
    ModalResult := mrNone;
end;

{*******************************************}
{* HABILITA/DESABILITA BOTÃO CONFIRMAR     *}
{****************************************RL*}
procedure TfrmGeraCredCliente.dtsCreditoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  If (cdsCredito.FieldByName('CALC_CREDITO').AsFloat > 0) Then
    btnConfirmar.Enabled := True;

  If Not cdsCredito.FieldByName('DTABAI').IsNull Then
    btnConfirmar.Enabled := False;
end;

procedure TfrmGeraCredCliente.dbgCreditoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Escape Then
    Close;
end;

procedure TfrmGeraCredCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) And (btnConfirmar.Enabled) Then
    btnConfirmar.Click;
end;

end.

