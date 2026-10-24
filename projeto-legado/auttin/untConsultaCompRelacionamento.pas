unit untConsultaCompRelacionamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCompRelacionamento = class(TfrmConsultaComp)
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FstrCampoRelacionamento: String;
    procedure SetstrCampoRelacionamento(const Value: String);
    { Private declarations }
  public
    { Public declarations }
  published
    property strCampoRelacionamento: String read FstrCampoRelacionamento write SetstrCampoRelacionamento;
  end;

var
  frmConsultaCompRelacionamento: TfrmConsultaCompRelacionamento;

implementation

uses untConsulta, untFuncoesSimples;

{$R *.dfm}

{ TfrmConsultaCompRelacionamento }

procedure TfrmConsultaCompRelacionamento.SetstrCampoRelacionamento(
  const Value: String);
begin
  FstrCampoRelacionamento := Value;
end;

procedure TfrmConsultaCompRelacionamento.dbgConsultaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    blnCondicao: Boolean;
begin
  inherited;

  If dbgConsulta.DataSource.DataSet.RecordCount > 0 Then
  Begin
    blnCondicao := dbgConsulta.DataSource.DataSet.FieldByName(FstrCampoRelacionamento).IsNull or
        fEmptyStr(dbgConsulta.DataSource.DataSet.FieldByName(FstrCampoRelacionamento).AsString);
        
    If blnCondicao Then
    Begin
      dbgConsulta.Canvas.Brush.Color := clRed;
      dbgConsulta.Canvas.FillRect(Rect);
      dbgConsulta.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    End;
  End;

end;

end.
