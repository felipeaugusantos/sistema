unit untGNREDisponibilidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Navegador.Classes.TNavegador, Navegador.View.Help;

type
  TfrmGNREDisponibilidade = class(TfrmPai)
    pnlWebBrowser: TPanel;
    btnRecarregaPagina: TBitBtnLocked;
    lblMensagem: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRecarregaPaginaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FNavegador : TfrmNavegadorViewHelp;
    objNavegador : TNavegador;
  public
    { Public declarations }
    FURL: String;
    procedure pCriaNavegador;
  end;

  procedure pConsultaDisponibilidade(AURL: String);

var
  frmGNREDisponibilidade: TfrmGNREDisponibilidade;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmGNREDisponibilidade.FormCreate(Sender: TObject);
begin
  inherited;
  objNavegador := TNavegador.New;
  objNavegador.setParent(pnlWebBrowser);
end;

procedure TfrmGNREDisponibilidade.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objNavegador);
end;

procedure TfrmGNREDisponibilidade.FormShow(Sender: TObject);
begin
  inherited;

  If Not objNavegador.NavegadorAtivo Then
  Begin
    pCriaNavegador;
    Exit;
  End;

  If objNavegador.NavegadorAtivo Then
    objNavegador.Navigate(FURL);
end;

procedure pConsultaDisponibilidade(AURL: String);
Var
  frmGNREDisponibilidade: TfrmGNREDisponibilidade;
begin
  Try
    Try
      pCriarFormularios(TfrmGNREDisponibilidade, frmGNREDisponibilidade);
      frmGNREDisponibilidade.FURL := AURL;
      frmGNREDisponibilidade.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'');
    End;
  Finally
    pFreeAndNil(frmGNREDisponibilidade);
  End;
end;

procedure TfrmGNREDisponibilidade.pCriaNavegador;
begin
  pCriarFormularios(TfrmNavegadorViewHelp, FNavegador);
  FNavegador.Align := alClient;
  FNavegador.Dock(pnlWebBrowser, pnlWebBrowser.BoundsRect);
  FNavegador.show;
end;

procedure TfrmGNREDisponibilidade.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_F2 Then
    btnRecarregaPagina.Click;
end;

procedure TfrmGNREDisponibilidade.btnRecarregaPaginaClick(Sender: TObject);
begin
  inherited;

  If not Assigned(objNavegador) Then
    Exit;

  objNavegador.Reload;
end;

end.
