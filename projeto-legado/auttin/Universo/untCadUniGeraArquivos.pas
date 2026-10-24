unit untCadUniGeraArquivos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiGeraArq, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  Gauges, BitBtnLockedIncrem;

type
  TfrmCadUniGeraArquivos = class(TfrmPaiGeraArq)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadUniGeraArquivos: TfrmCadUniGeraArquivos;

implementation

uses untUniversoImobiliariaDinamica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadUniGeraArquivos.btnConfirmaGeracaoClick(Sender: TObject);
  Var
    universo: TUniversoImobiliariaDinamica;
begin
  Try
    btnConfirmaGeracao.Enabled := False;
    universo := TUniversoImobiliariaDinamica.Create(Self);
    universo.RegistraAcao := pRegistrAcao;
    universo.RegistraProgresso := pRegistraProgresso;

    If universo.fProcessaArquivos Then
      fMensagem('', 'Os arquivos foram gerados com sucesso!', ['OK']);

    btnConfirmaGeracao.Enabled := False;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadUniGeraArquivos.btnConfirmaGeracaoClick]');
    End;
  End;

  FreeAndNil(universo);
end;

procedure TfrmCadUniGeraArquivos.FormCreate(Sender: TObject);
begin
  inherited;
{  pRegistrAcao('Unidades');
  pRegistrAcao('  TT: 202,5 ML');
  pRegistrAcao('  QT: 810 ML');
  pRegistrAcao('  GL: 3200 ML');
  pRegistrAcao('  LA: 16200 ML');}
end;

end.
