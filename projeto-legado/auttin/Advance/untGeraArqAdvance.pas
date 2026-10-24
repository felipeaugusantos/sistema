unit untGeraArqAdvance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges;

type
  TfrmGeraArqAdvance = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGeraArqAdvance: TfrmGeraArqAdvance;

implementation

uses untAdvanceIndustrialDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmGeraArqAdvance.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    advance: TAdvanceIndustrialDinamica;
begin
  Try
    advance := TAdvanceIndustrialDinamica.Create(Self);
    advance.RegistraAcao := pRegistrAcao;
    advance.RegistraProgresso := pRegistraProgresso;

    advance.pProcessaArquivos;
    
    fMensagem('', 'Os arquivos foram processados com sucesso!', ['OK']);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmGeraArqAdvance.btnConfirmaGeracaoClick]');
    End;
  End;

  FreeAndNil(advance);
end;

end.
