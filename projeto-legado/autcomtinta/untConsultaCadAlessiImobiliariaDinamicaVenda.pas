unit untConsultaCadAlessiImobiliariaDinamicaVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB,  
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadAlessiImobiliariaDinamicaVenda = class(TfrmConsultaComp)
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCadAlessiImobiliariaDinamicaVenda: TfrmConsultaCadAlessiImobiliariaDinamicaVenda;

implementation

uses  untFuncoes, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaCadAlessiImobiliariaDinamicaVenda.btnExecutaTarefaClick(
  Sender: TObject);
begin
  inherited;
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadAleNovasFormulas', False);
end;

end.
