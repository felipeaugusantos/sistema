unit untConfiguracaoHydronorth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untAbstractConfiguracao, AppEvnts, Menus, StdCtrls, EditFocus, ComCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls, Mask, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  FilenameEditFocus;

type
  TfrmConfiguracaoHydronorth = class(TfrmAbstractConfiguracao)
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
  frmConfiguracaoHydronorth: TfrmConfiguracaoHydronorth;

implementation

uses
  untFuncoesSimples, untCadUniLocalizador, untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracaoHydronorth }

procedure TfrmConfiguracaoHydronorth.CarregarConfiguracoes;
begin
  Try
    conf := fGetConfTinta('HYD');

    conf.pInsereCodigo('HYDPAT', 'Arquivos para geração', '');

    //edtArquivos.Dialog.Dialog.Files.Text := conf.fGet('HYDPAT');

    inherited CarregarConfiguracoes;

    edtArquivos.Text := conf.fGet('HYDPAT');
  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;
end;

constructor TfrmConfiguracaoHydronorth.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, 'HYD', 'Hydronorth Imobiliária');
end;

destructor TfrmConfiguracaoHydronorth.Destroy;
begin
  inherited;
end;

procedure TfrmConfiguracaoHydronorth.FormCreate(Sender: TObject);
begin
  inherited;
  edtArquivos.Dialog.Dialog.Filter := 'Arquivos Hydronorth (*.xls; *.xlsx)|*.xls;*.xlsx';
end;

function TfrmConfiguracaoHydronorth.fValidaArquivos: Boolean;
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

function TfrmConfiguracaoHydronorth.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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

procedure TfrmConfiguracaoHydronorth.SalvarConfiguracoes;
begin
  Try
    inherited SalvarConfiguracoes;
    conf.pSet('HYDPAT', Trim(edtArquivos.Text));
  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;
end;

end.