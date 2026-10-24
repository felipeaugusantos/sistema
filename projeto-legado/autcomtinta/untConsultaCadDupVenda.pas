unit untConsultaCadDupVenda;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus;

type
  TfrmConsultaCadDupVenda = class(TfrmConsultaComp)
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    { Public declarations }
  end;

var
  frmConsultaCadDupVenda: TfrmConsultaCadDupVenda;

implementation

uses untConsulta, untFuncoes, untFuncEspecificas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaCadDupVenda.btnExecutaTarefaClick(Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' ' + VS_strCodEmp + ' TfrmCadDupNovasFormulas', False);
end;

end.
