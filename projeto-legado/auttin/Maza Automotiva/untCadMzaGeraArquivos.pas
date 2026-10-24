unit untCadMzaGeraArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadMzaGeraArq = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadMzaGeraArq: TfrmCadMzaGeraArq;

implementation

uses untMazaAutomotiva, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadMzaGeraArq.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    MazaAutomotiva: TMazaAutomotiva;
begin
  Try
    MazaAutomotiva := TMazaAutomotiva.Create(Nil);
    MazaAutomotiva.RegistraAcao := pRegistrAcao;
    MazaAutomotiva.RegistraProgresso := pRegistraProgresso;

    If MazaAutomotiva.fProcessarArquivos Then
      fMensagem('', 'O arquivos foram processados com sucesso!', ['OK']);
  Except

  End;
end;

end.
