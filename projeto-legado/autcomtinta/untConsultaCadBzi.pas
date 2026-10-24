unit untConsultaCadBzi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadBzi = class(TfrmConsultaComp)
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCadBzi: TfrmConsultaCadBzi;

implementation

uses untConsulta;

{$R *.dfm}

procedure TfrmConsultaCadBzi.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pAlinhaColunasNumericas;
end;

end.
