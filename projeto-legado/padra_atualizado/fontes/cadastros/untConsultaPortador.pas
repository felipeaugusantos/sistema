unit untConsultaPortador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, ExtCtrls, DB, 
   Uni, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaPortador = class(TfrmConsultaComp)
    shpPorBai: TShape;
    lblPorPer: TLabel;
    Label3: TLabel;
    lblPorSPe: TLabel;
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaPortador: TfrmConsultaPortador;

implementation

uses untConsulta;

{$R *.dfm}

procedure TfrmConsultaPortador.dbgConsultaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
Var
  blnMarca: Boolean;
begin
  inherited;

  blnMarca := False;

  If (qryConsulta.FindField('PERBAI') <> nil) Then
  Begin
    If (qryConsulta.FieldByName('PERBAI').AsString = 'S') Then
      dbgConsulta.Canvas.Font.Color:= clBlue
    Else
      dbgConsulta.Canvas.Font.Color:= clRed;

    blnMarca := True;
  End;

  If (qryConsulta.FindField('MOVBAN') <> nil) Then
  Begin
    If (qryConsulta.FieldByName('MOVBAN').AsString = 'S') Then
      dbgConsulta.Canvas.Font.Color:= clBlue
    Else
      dbgConsulta.Canvas.Font.Color:= clRed;

    blnMarca := True;
  End;

  If blnMarca Then
    dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmConsultaPortador.pAtuIndice(intIndice: Integer);
begin
  inherited;

  If (qryConsulta.FindField('PERBAI') <> nil) Then
    qryConsulta.FieldByName('PERBAI').Visible := False;

  If (qryConsulta.FindField('MOVBAN') <> nil) Then
    qryConsulta.FieldByName('MOVBAN').Visible := False;

end;

procedure TfrmConsultaPortador.edtFiltro1Change(Sender: TObject);
begin
  inherited;

  If (qryConsulta.FindField('PERBAI') <> nil) Then
    qryConsulta.FieldByName('PERBAI').Visible := False;

  If (qryConsulta.FindField('MOVBAN') <> nil) Then
    qryConsulta.FieldByName('MOVBAN').Visible := False;

end;

procedure TfrmConsultaPortador.FormShow(Sender: TObject);
begin
  inherited;

  If (qryConsulta.FindField('PERBAI') <> nil) Then
    qryConsulta.FieldByName('PERBAI').Visible := False;

  If (qryConsulta.FindField('MOVBAN') <> nil) Then
    qryConsulta.FieldByName('MOVBAN').Visible := False;

end;

end.
