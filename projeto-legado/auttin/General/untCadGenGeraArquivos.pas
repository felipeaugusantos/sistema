unit untCadGenGeraArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadGenGeraArq = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadGenGeraArq: TfrmCadGenGeraArq;

implementation

uses untGeneral, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadGenGeraArq.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    general: TGeneral;
begin
  Try
    general := TGeneral.Create(Nil);
    general.RegistraAcao := pRegistrAcao;
    general.RegistraProgresso := pRegistraProgresso;

    If general.fProcessarArquivos Then
      fMensagem('', 'O arquivos foram processados com sucesso!', ['OK']);
  Except

  End;
end;

end.
