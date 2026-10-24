unit untDadosExportacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, ComboBoxFocus, EditFocus;

type
  TfrmDadosExportacao = class(TfrmPaiConfirma)
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtLoEmba: TEditFocus;
    edtLocDes: TEditFocus;
    cbbUFEmba: TComboBoxFocus;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDadosExportacao: TfrmDadosExportacao;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmDadosExportacao }

procedure TfrmDadosExportacao.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDadosExportacao.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
end;

function TfrmDadosExportacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Sender = cbbUFEmba Then
  Begin
    If fEmptyStr(cbbUFEmba.Text) Then
    Begin
      pMensagemOk('É necessário selecionar um Estado de Embarque ou de Transposição de Fronteira.');
      Result := False;
    End;
  End
  Else If Sender = edtLoEmba Then
  Begin
    If fEmptyStr(edtLoEmba.Text) Then
    Begin
      pMensagemOk('É necessário preencher o Local de Embarque ou de Transposição de Fronteira.');
      Result := False;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
