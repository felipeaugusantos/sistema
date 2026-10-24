unit untAjudaPorAbas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, dxBarBuiltInMenu, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPC, System.Generics.Collections;

type
  TPaginaAjuda = class
  private
    FTabSeet: TcxTabSheet;
    FLabel: TLabel;
    FMemo: TMemo;
  public
    constructor Create(ATabSeet: TcxTabSheet; ALabel: TLabel; AMemo: TMemo);
    function fSetaTituloGuia(strTexto: String): TPaginaAjuda;
    function fSetaTituloPagina(strTexto: String): TPaginaAjuda;
    function fAddLinhaTexto(strLinha: String): TPaginaAjuda;
    function fAddLinhas(stlLinhas: TStrings): TPaginaAjuda;
    function fSetaFonteLinhas(AFontName: String; AFontSize: Integer): TPaginaAjuda;
  End;

  TfrmAjudaPorAbas = class(TfrmPai)
    cxPageControl1: TcxPageControl;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FPaginas: TObjectList<TPaginaAjuda>;
    procedure pMemoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    function fAddPagina(): TPaginaAjuda;
  end;

implementation

{$R *.dfm}

{ TPaginaAjuda }

constructor TPaginaAjuda.Create(ATabSeet: TcxTabSheet; ALabel: TLabel;
  AMemo: TMemo);
begin
  inherited Create();

  FTabSeet := ATabSeet;
  FLabel   := ALabel;
  FMemo    := AMemo;
end;

function TPaginaAjuda.fAddLinhas(stlLinhas: TStrings): TPaginaAjuda;
begin
  FMemo.Lines.AddStrings(stlLinhas);
  Result := Self;
end;

function TPaginaAjuda.fAddLinhaTexto(strLinha: String): TPaginaAjuda;
begin
  FMemo.Lines.Add(strLinha);
  FMemo.Lines.Add('');
  Result := Self;
end;

function TPaginaAjuda.fSetaFonteLinhas(AFontName: String;
  AFontSize: Integer): TPaginaAjuda;
begin
  Result := Self;
  FMemo.Font.Name := AFontName;
  FMemo.Font.Size := AFontSize;
end;

function TPaginaAjuda.fSetaTituloGuia(strTexto: String): TPaginaAjuda;
begin
  FTabSeet.Caption := strTexto;
  Result := Self;
end;

function TPaginaAjuda.fSetaTituloPagina(strTexto: String): TPaginaAjuda;
begin
  FLabel.Caption := '  ' + strTexto;
  Result := Self;
end;

{ TfrmAjudaConfigCadProv }

function TfrmAjudaPorAbas.fAddPagina: TPaginaAjuda;
Var
  tbsNovaAba: TcxTabSheet;
  pnlTitulo, pnlTexto: TPanel;
  lblTitulo: TLabel;
  memTexto: TMemo;
begin
  tbsNovaAba := TcxTabSheet.Create(Self);
  tbsNovaAba.PageControl := cxPageControl1;

  pnlTitulo := TPanel.Create(Self);
  pnlTitulo.Parent := tbsNovaAba;
  pnlTitulo.Align := alTop;
  pnlTitulo.Height := 34;
  pnlTitulo.BevelOuter := bvNone;
  pnlTitulo.Color := clWhite;

  lblTitulo := TLabel.Create(Self);
  lblTitulo.Parent := pnlTitulo;
  lblTitulo.Align := alClient;
  lblTitulo.Font.Color := clNavy;
  lblTitulo.Font.Name := 'Tahoma';
  lblTitulo.Font.Size := 12;
  lblTitulo.Font.Style := [fsBold];
  lblTitulo.Layout := tlCenter;

  pnlTexto  := TPanel.Create(Self);
  pnlTexto.Parent := tbsNovaAba;
  pnlTexto.Align := alClient;
  pnlTexto.BevelOuter := bvNone;
  pnlTexto.Color := clWhite;

  memTexto  := TMemo.Create(Self);
  memTexto.Parent := pnlTexto;
  memTexto.Align := alClient;
  memTexto.AlignWithMargins := True;
  memTexto.Margins.Top := 0;
  memTexto.Margins.Left := 10;
  memTexto.Margins.Right := 10;
  memTexto.Margins.Bottom := 0;
  memTexto.BorderStyle := bsNone;
  memTexto.ReadOnly := True;
  memTexto.OnKeyDown := pMemoKeyDown;

  Result := TPaginaAjuda.Create(tbsNovaAba, lblTitulo, memTexto);

  FPaginas.Add(Result);
end;

procedure TfrmAjudaPorAbas.FormCreate(Sender: TObject);
begin
  inherited;
  FPaginas := TObjectList<TPaginaAjuda>.Create();
end;

procedure TfrmAjudaPorAbas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FPaginas);
end;

procedure TfrmAjudaPorAbas.FormShow(Sender: TObject);
begin
  inherited;
  cxPageControl1.ActivePageIndex := 0;
end;

procedure TfrmAjudaPorAbas.pMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnSair.Click;
end;

end.
