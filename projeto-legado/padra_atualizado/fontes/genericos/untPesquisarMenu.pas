unit untPesquisarMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, MMSystem, Registry, StrUtils, untFramePesquisarMenu;

type
  TfrmPesquisarMenu = class(TForm)
    lblRodape: TLabel;
    fraPesquisarMenu: TfraPesquisarMenu;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure pPesquisarMenus();
  end;

implementation

{$R *.dfm}

uses untPrincipal, untMenuSemaforo, untFuncoesSimples;

{ TfrmPesquisarMenu }

procedure TfrmPesquisarMenu.FormCreate(Sender: TObject);
begin
  fraPesquisarMenu.pSetaMenu(frmPrincipal.mnuAutcomK);
  fraPesquisarMenu.pMontarPesquisa;
  fraPesquisarMenu.pGeraPopUpRecentes;
  fraPesquisarMenu.pGeraPopUpFavoritos;
end;

procedure TfrmPesquisarMenu.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  fraPesquisarMenu.OnFormKeyDown(Sender, Key, Shift);

  If Key = VK_ESCAPE Then
    Close;
end;

procedure TfrmPesquisarMenu.FormResize(Sender: TObject);
begin
  fraPesquisarMenu.pAjustarPesquisa;
end;

class procedure TfrmPesquisarMenu.pPesquisarMenus;
  Var
    frmPesquisarMenu: TfrmPesquisarMenu;
    intSemaforoBkp: Integer;
begin
  intSemaforoBkp := TSemaforo.intSemaforo;
  pCriarFormularios(TfrmPesquisarMenu, frmPesquisarMenu);
  Try
    TSemaforo.intSemaforo := -1;
    frmPesquisarMenu.ShowModal;
  Finally
    TSemaforo.intSemaforo := intSemaforoBkp;
    pFreeAndNil(frmPesquisarMenu);
  End;
end;

procedure TfrmPesquisarMenu.FormActivate(Sender: TObject);
begin
  fraPesquisarMenu.pAjustarPesquisa;
end;

end.
