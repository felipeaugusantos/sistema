unit untBaixaCtpBusca;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiSimples, EditFocus, ComCtrls, Buttons,
  ExtCtrls, Menus, AppEvnts, BitBtnLockedIncrem, frxClass, System.SysUtils,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxCurrencyEdit,
  CurrencyEditFocus, Generics.Collections;

type
  TfrmBaixaCtpBusca = class(TfrmPaiSimples)
    edtNumDup: TEditFocus;
    Label1: TLabel;
    pnlFundo: TPanel;
    edtCodVel: TEditFocus;
    Label2: TLabel;
    edtValorTitulo: TCurrencyEditFocus;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  strict private
    type
      TobjFiltro = class
      private
        FstrCampo: string;
        FstrValor: string;
      public
       property strCampo: string read FstrCampo;
       property strValor: string read FstrValor;
       procedure Clear;
       constructor Create; reintroduce;
      end;
  public
    objFiltro: TobjFiltro;
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmBaixaCtpBusca }

procedure TfrmBaixaCtpBusca.FormCreate(Sender: TObject);
begin
  inherited;
  objFiltro := TobjFiltro.Create;
end;

procedure TfrmBaixaCtpBusca.FormDestroy(Sender: TObject);
begin
  inherited;
  objFiltro.Free;
end;

function TfrmBaixaCtpBusca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtValorTitulo) Then
    Begin
      objFiltro.clear;

      If Not fEmptyStr(edtCodVel.Text) Then
      Begin
        objFiltro.FstrCampo := 'CTP_CODVEL';
        objFiltro.FstrValor := edtCodVel.Text;
      End
      else If Not fEmptyStr(edtNumDup.Text) Then
      Begin
        objFiltro.FstrCampo := 'CTP_NUMDUP';
        objFiltro.FstrValor := edtNumDup.Text;
      End
      else If Not fEmptyStr(edtValorTitulo.Text) Then
      Begin
        objFiltro.FstrCampo := 'TOTDUP';
        objFiltro.FstrValor := FloatToStr(edtValorTitulo.Value);
      End;
      Self.ModalResult := mrOk;
    End
  End;
end;

{ TfrmBaixaCtpBusca.TobjFiltro }

procedure TfrmBaixaCtpBusca.TobjFiltro.Clear;
begin
  FstrCampo := '';
  FstrValor := '';
end;

constructor TfrmBaixaCtpBusca.TobjFiltro.Create;
begin
  inherited Create;
  Clear;
end;

end.

