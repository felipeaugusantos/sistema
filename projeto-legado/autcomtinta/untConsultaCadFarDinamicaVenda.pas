unit untConsultaCadFarDinamicaVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB,
   Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, BitBtnLockedIncrem, MemDS, DBAccess,
  untConsultaCadFarDinamicaGeral;

type
  TfrmConsultaCadFarDinamicaVenda = class(TfrmConsultaCadFarDinamicaGeral)
    procedure btnExecutaTarefaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCadFarDinamicaVenda: TfrmConsultaCadFarDinamicaVenda;

implementation

uses untFuncoes, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaCadFarDinamicaVenda.btnExecutaTarefaClick(
  Sender: TObject);
begin
  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' 1 ' + VS_strCodEmp + ' TfrmCadFarNfm', False);
end;

end.
