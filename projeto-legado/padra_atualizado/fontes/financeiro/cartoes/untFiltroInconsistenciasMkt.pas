unit untFiltroInconsistenciasMkt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmFiltroInconsistenciasMkt = class(TfrmPai)
    btnImprimir: TBitBtnLocked;
    pnlOpcoes: TPanel;
    chkNaoEncontrados: TCheckBox;
    chkBaixados: TCheckBox;
    chkConciliadosZerado: TCheckBox;
    chkTaxasFreteInconsistentes: TCheckBox;
    chkListaArquivos: TCheckBox;
    chkValorBrutoDivergente: TCheckBox;
    chkCupomInconsistente: TCheckBox;
    rdgOrdenar: TRadioGroup;
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FOperadora: String;
    { Private declarations }
  public
    property Operadora: String read FOperadora write FOperadora;
    { Public declarations }
  end;

implementation
Uses untFuncoesSimples;
{$R *.dfm}

procedure TfrmFiltroInconsistenciasMkt.btnImprimirClick(Sender: TObject);
begin
  inherited;

  Close;
  Self.ModalResult := mrOK;
end;

procedure TfrmFiltroInconsistenciasMkt.btnSairClick(Sender: TObject);
begin
  If fMensagem('ATENÇÃO', 'Tem certeza que deseja cancelar a conciliação?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  inherited;

end;

procedure TfrmFiltroInconsistenciasMkt.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
  Begin
    Key := 0;
    btnSair.Click;
  End;

  inherited;

end;

procedure TfrmFiltroInconsistenciasMkt.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(chkNaoEncontrados);

  If FOperadora = 'MAGAZINE LUIZA' Then
  Begin
    chkTaxasFreteInconsistentes.Checked := False;
    chkCupomInconsistente.Visible := False;

    rdgOrdenar.Items[1] := 'Pedido/Parcela';
    rdgOrdenar.ItemIndex := 1;
  End;
end;

end.