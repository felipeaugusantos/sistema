unit untConsultaCadEucatexImobiliariaDinamicaVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadEucatexImobiliariaDinamicaVenda = class(TfrmConsultaComp)
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCadEucatexImobiliariaDinamicaVenda: TfrmConsultaCadEucatexImobiliariaDinamicaVenda;

implementation

uses  untFuncoes, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaCadEucatexImobiliariaDinamicaVenda.btnExecutaTarefaClick(
  Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadEucNovasFormulas', False);
end;

end.
