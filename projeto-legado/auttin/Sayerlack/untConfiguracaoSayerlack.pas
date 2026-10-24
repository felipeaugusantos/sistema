unit untConfiguracaoSayerlack;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untAbstractConfiguracao, AppEvnts, Menus, StdCtrls, EditFocus,
  ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, Mask, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, FilenameEditFocus;

type
  TfrmConfiguracaoSayerlack = class(TfrmAbstractConfiguracao)
    lblArquivos: TLabel;
    edtArquivos: TFilenameEditFocus;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function fValidaArquivos: Boolean;
  protected
    procedure CarregarConfiguracoes; override;
    procedure SalvarConfiguracoes; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
  end;

var
  frmConfiguracaoSayerlack: TfrmConfiguracaoSayerlack;

implementation

uses
  untCadUniLocalizador, untFuncoesSimples, untFuncTinta;

{$R *.dfm}

{ TfrmAbstractConfiguracao1 }

procedure TfrmConfiguracaoSayerlack.CarregarConfiguracoes;
begin
  Try
    conf := fGetConfTinta('SAY');
    inherited CarregarConfiguracoes;
    conf.pInsereCodigo('SAYPAT', 'Arquivos para geração', '');
    edtArquivos.Text := conf.fGet('SAYPAT');

  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;
end;

constructor TfrmConfiguracaoSayerlack.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, 'SAY', 'Sayerlack');
end;

destructor TfrmConfiguracaoSayerlack.Destroy;
begin
  inherited Destroy;
end;

procedure TfrmConfiguracaoSayerlack.FormCreate(Sender: TObject);
begin
  inherited;
  edtArquivos.Dialog.Dialog.Filter := 'Arquivos Sayerlack (*.xls)|*.xls';
end;

function TfrmConfiguracaoSayerlack.fValidaArquivos: Boolean;
var
  strMensagem: string;
  strArquivo: string;
begin
  Result := True;
  strMensagem := '';
  for strArquivo in edtArquivos.Dialog.Dialog.Files do
  begin
    if not FileExists(strArquivo) then
    begin
      strMensagem := strMensagem + strArquivo + #13#10;
    end;
  end;

  if not fEmptyStr(strMensagem) then
  begin
    Result := False;
    strMensagem := #13#10 + Trim(strMensagem);
    fMensagem('ATENÇÃO', Format('Os arquivos abaixo não existem [%s]', [strMensagem]), ['OK']);
  end;
end;

function TfrmConfiguracaoSayerlack.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    Sender.Exit(Sender);

    if Sender = edtArquivos then
    begin
      if not fEmptyStr(edtArquivos.Text) then
      begin
        Result := fValidaArquivos;
      end;  
    end;  
         
  end;

  if not Result then
    pProcuraSetFocus(Sender);
end;

procedure TfrmConfiguracaoSayerlack.SalvarConfiguracoes;
begin
  Try
    inherited SalvarConfiguracoes;
    conf.pSet('SAYPAT', Trim(edtArquivos.Text));
  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;
end;

end.
