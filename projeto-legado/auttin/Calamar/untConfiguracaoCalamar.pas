unit untConfiguracaoCalamar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untAbstractConfiguracao, AppEvnts, Menus, StdCtrls, EditFocus, ComCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls, Mask, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  FilenameEditFocus;

type
  TfrmConfiguracaoCalamar = class(TfrmAbstractConfiguracao)
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
    { Public declarations }
  end;

var
  frmConfiguracaoCalamar: TfrmConfiguracaoCalamar;

implementation

uses
  untFuncoesSimples, untCadUniLocalizador, untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracaoCalamar }

procedure TfrmConfiguracaoCalamar.CarregarConfiguracoes;
begin
  Try
    conf := fGetConfTinta('CAL');

    conf.pInsereCodigo('CALPAT', 'Arquivos para geração', '');

//    edtArquivos.Dialog.Dialog.Files.Text := conf.fGet('CALPAT');
    edtArquivos.Text := conf.fGet('CALPAT');
    edtTraTin.Text   := conf.fGet('TRATIN');
    edtArquivos.Text := conf.fGet('CALPAT');

    inherited CarregarConfiguracoes;
  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;
end;

constructor TfrmConfiguracaoCalamar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, 'CAL', 'Calamar');
end;

destructor TfrmConfiguracaoCalamar.Destroy;
begin
  inherited;
end;

procedure TfrmConfiguracaoCalamar.FormCreate(Sender: TObject);
begin
  inherited;
  edtArquivos.Dialog.Dialog.Filter := 'Arquivos Calamar (*.mdb)|*.mdb';
end;

function TfrmConfiguracaoCalamar.fValidaArquivos: Boolean;
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

function TfrmConfiguracaoCalamar.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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

procedure TfrmConfiguracaoCalamar.SalvarConfiguracoes;
begin
  Try
//    conf.pSet('CALPAT', Trim(edtArquivos.Dialog.Dialog.Files.Text));
    conf.pSet('CALPAT', edtArquivos.Text);
    inherited SalvarConfiguracoes;
  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;
end;

end.