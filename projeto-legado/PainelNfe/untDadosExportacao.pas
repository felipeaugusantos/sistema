unit untDadosExportacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, EditFocus, Buttons, BitBtnLockedIncrem, ExtCtrls,
  ComboBoxFocus;

type
  TfrmDadosExportacao = class(TForm)
    pnlBotoes: TPanel;
    btnSair: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlIF: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtLoEmba: TEditFocus;
    edtLocDes: TEditFocus;
    cbbUFEmba: TComboBoxFocus;
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;    
  public
    { Public declarations }
  end;

var
  frmDadosExportacao: TfrmDadosExportacao;

implementation

uses untUtil;

{$R *.dfm}

procedure TfrmDadosExportacao.btnConfirmaClick(Sender: TObject);
begin
  If fValidaCampos(cbbUFEmba) And
     fValidaCampos(edtLoEmba) Then
    ModalResult := mrOk;
end;

procedure TfrmDadosExportacao.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDadosExportacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_RETURN Then
  Begin
    If fValidaCampos(ActiveControl) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmDadosExportacao.FormShow(Sender: TObject);
begin
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
