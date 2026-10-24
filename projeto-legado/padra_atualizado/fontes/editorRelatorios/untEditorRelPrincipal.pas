unit untEditorRelPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TfrmEditorRelPrincipal = class(TForm)
    mnuPrincipal: TMainMenu;
    mnuRelatorios: TMenuItem;
    mnuConsultas: TMenuItem;
    mnuModelos: TMenuItem;
    mnuAssuntos: TMenuItem;
    mnuSair: TMenuItem;
    mnuCadastrodeRelatorios: TMenuItem;
    RelatriosCustomizadosdoMenu1: TMenuItem;
    procedure mnuModelosClick(Sender: TObject);
    procedure mnuSairClick(Sender: TObject);
    procedure mnuCadastrodeRelatoriosClick(Sender: TObject);
    procedure RelatriosCustomizadosdoMenu1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

Uses
  untCadModelosRel, untCadRelatorios, untFuncoesSimples, untRelatorio, untPrincipal;

procedure TfrmEditorRelPrincipal.mnuCadastrodeRelatoriosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadRelatorios);
end;

procedure TfrmEditorRelPrincipal.mnuModelosClick(Sender: TObject);
begin
  pCriarForm(TfrmCadModelosRel);
end;

procedure TfrmEditorRelPrincipal.mnuSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmEditorRelPrincipal.RelatriosCustomizadosdoMenu1Click(
  Sender: TObject);
  Var
    objRelatorio: TRelatorio;
begin
  objRelatorio := TRelatorio.Create(Self, True, False, Nil);
  objRelatorio.pMostraRelatoriosMenu(frmPrincipal);
  FreeAndNil(objRelatorio);
end;

end.
