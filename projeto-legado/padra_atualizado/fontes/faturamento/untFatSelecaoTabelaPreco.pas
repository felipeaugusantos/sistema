unit untFatSelecaoTabelaPreco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmFatSelecaoTabelaPreco = class(TfrmPaiSimples)
    Panel1: TPanel;
    Panel2: TPanel;
    FlowPanel1: TFlowPanel;
    btnConfirmaDados: TBitBtnLocked;
    Label1: TLabel;
    cbbTabPre: TComboBox;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbTabPreKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatSelecaoTabelaPreco.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  if fEmptyStr(cbbTabPre.Text) then
  begin
    fMensagem('ATENÇÃO', 'Informe uma tabela de preço.', ['&Ok']);
    pSetFocus(cbbTabPre);
    Exit;
  end;
  ModalResult := mrOk;
end;

procedure TfrmFatSelecaoTabelaPreco.cbbTabPreKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatSelecaoTabelaPreco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if fEmptyStr(cbbTabPre.Text) then
    Action := caNone;
end;

procedure TfrmFatSelecaoTabelaPreco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  // #
end;

procedure TfrmFatSelecaoTabelaPreco.FormShow(Sender: TObject);
begin
  inherited;
  //pSetFocus(cbbTabPre);
  pSetFocus(btnConfirmaDados);
end;

end.
