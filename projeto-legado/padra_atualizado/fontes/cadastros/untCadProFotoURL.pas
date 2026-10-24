unit untCadProFotoURL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Spin,
  BitBtnLockedIncrem, OleCtrls, SHDocVw, frxClass, frxExportCSVTestabilidade,
  Navegador.Classes.TNavegador, Navegador.View.Help;

type
  TfrmCadProFotoURL = class(TfrmPai)
    pnlImage: TPanel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCliNavegador : TfrmNavegadorViewHelp;
    objNavegador : TNavegador;

    procedure pCriaCadCliNavegador;
  public
    { Public declarations }
    strImgProdutoURL: String;
  end;

  procedure pExibirImagemProdutoSite(strCodIte: String);  


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmCadProFotoURL.FormCreate(Sender: TObject);
begin
  inherited;
  objNavegador := TNavegador.New;
  objNavegador.setParent(pnlImage);
end;

procedure TfrmCadProFotoURL.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objNavegador);
end;

procedure TfrmCadProFotoURL.FormShow(Sender: TObject);
begin
  inherited;

  If Not objNavegador.NavegadorAtivo Then
  Begin
    pCriaCadCliNavegador;
    Exit;
  End;

  If objNavegador.NavegadorAtivo Then
    objNavegador.Navigate(strImgProdutoURL);
end;

procedure pExibirImagemProdutoSite(strCodIte: String);
  Var
    strURL: String;
    frmCadProFotoURL: TfrmCadProFotoURL;
begin
  If fEmptyStr(strCodIte) Then
  Begin
    pMensagemOk('O código do produto não foi informado!');
    Exit;
  End;

  strURL := fCampoTabela('ITE_URLIMG', 'DESSIT', ['ITE_CODITE'], [strCodIte]);

  If fEmptyStr(strURL) Then
  Begin
    pMensagemOk('A URL da imagem deste produto não foi cadastrada!');
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadProFotoURL, frmCadProFotoURL);
    frmCadProFotoURL.strImgProdutoURL := strURL;
    frmCadProFotoURL.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  pFreeAndNil(frmCadProFotoURL);
end;

procedure TfrmCadProFotoURL.pCriaCadCliNavegador;
begin
  pCriarFormularios(TfrmNavegadorViewHelp, FCliNavegador);
  FCliNavegador.Align := alClient;
  FCliNavegador.Dock(pnlImage, pnlImage.BoundsRect);
  FCliNavegador.show;
end;

end.
