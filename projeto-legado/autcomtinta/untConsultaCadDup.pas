unit untConsultaCadDup;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus;

type
  TfrmConsultaCadDup = class(TfrmConsultaComp)
  private
    { Private declarations }
  protected
  public
    { Public declarations }
  end;

var
  frmConsultaCadDup: TfrmConsultaCadDup;

implementation

uses untConsulta, untFuncoes, untFuncEspecificas, untFuncoesConsulta;

{$R *.dfm}

end.
