unit untConsultaRcxRom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB, Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons,
  Grids, DBGridCitel, DBGrids, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaRcxRom = class(TfrmConsultaComp)
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaRcxRom: TfrmConsultaRcxRom;

implementation

uses untConsulta;

{$R *.dfm}

procedure TfrmConsultaRcxRom.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  If qryConsulta.Active Then
  Begin
    qryConsulta.FieldByName('GER_NUMROM').Visible := False;
    qryConsulta.FieldByName('GER_NOMCON').Visible := False;
    qryConsulta.FieldByName('CLI_NOMCLI').Visible := False;
    qryConsulta.FieldByName('GER_ESPDOC').Visible := False;
    qryConsulta.FieldByName('GER_NUMDOC').Visible := False;
    qryConsulta.FieldByName('CID_NOMCID').Visible := False;
  End;
end;

procedure TfrmConsultaRcxRom.pAtuIndice(intIndice: Integer);
begin
  inherited;
  If qryConsulta.Active Then
  Begin
    qryConsulta.FieldByName('GER_NUMROM').Visible := False;
    qryConsulta.FieldByName('GER_NOMCON').Visible := False;
    qryConsulta.FieldByName('CLI_NOMCLI').Visible := False;
    qryConsulta.FieldByName('GER_ESPDOC').Visible := False;
    qryConsulta.FieldByName('GER_NUMDOC').Visible := False;
    qryConsulta.FieldByName('CID_NOMCID').Visible := False;
  End;
end;

procedure TfrmConsultaRcxRom.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If qryConsulta.Active Then
  Begin
    qryConsulta.FieldByName('GER_NUMROM').Visible := False;
    qryConsulta.FieldByName('GER_NOMCON').Visible := False;
    qryConsulta.FieldByName('CLI_NOMCLI').Visible := False;
    qryConsulta.FieldByName('GER_ESPDOC').Visible := False;
    qryConsulta.FieldByName('GER_NUMDOC').Visible := False;
    qryConsulta.FieldByName('CID_NOMCID').Visible := False;
  End;
end;

end.
