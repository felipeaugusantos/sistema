unit untConsultaCompCoralNfmBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,   Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCompCoralNfmBases = class(TfrmConsultaComp)
    lblInformacoes: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCompCoralNfmBases: TfrmConsultaCompCoralNfmBases;

implementation

{$R *.dfm}

end.
