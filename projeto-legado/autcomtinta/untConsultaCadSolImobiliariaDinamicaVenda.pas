unit untConsultaCadSolImobiliariaDinamicaVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadSolbrazImobiliariaVenda = class(TfrmConsultaComp)
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCadSolbrazImobiliariaVenda: TfrmConsultaCadSolbrazImobiliariaVenda;

implementation

uses untFuncoes, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaCadSolbrazImobiliariaVenda.btnExecutaTarefaClick(
  Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadSolNovasFormulas', False);
end;

end.
