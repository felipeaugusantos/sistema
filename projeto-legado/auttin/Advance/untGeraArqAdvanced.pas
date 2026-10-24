unit untGeraArqAdvanced;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges;

type
  TfrmGeraArqAdvanced = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGeraArqAdvanced: TfrmGeraArqAdvanced;

implementation

uses untAdvancedIndustrialDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmGeraArqAdvanced.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    advanced: TAdvancedIndustrialDinamica;
begin
  Try
    advanced := TAdvancedIndustrialDinamica.Create(Self);
    advanced.RegistraAcao := pRegistrAcao;
    advanced.RegistraProgresso := pRegistraProgresso;

    advanced.pProcessaArquivos;
    
    fMensagem('', 'Os arquivos foram processados com sucesso!', ['OK']);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmGeraArqAdvanced.btnConfirmaGeracaoClick]');
    End;
  End;

  FreeAndNil(advanced);
end;

end.
