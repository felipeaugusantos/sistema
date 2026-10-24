unit untConfiguracaoVelutex;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untAbstractConfiguracao, StdCtrls, Mask,
  StrUtils, AppEvnts, Menus, EditFocus, ComCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  FilenameEditFocus;

type
  TfrmConfiguracaoVelutex = class(TfrmAbstractConfiguracao)
    lblArquivos: TLabel;
    edtArquivos: TFilenameEditFocus;
    procedure edtArquivosKeyPress(Sender: TObject; var Key: Char);
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
  frmConfiguracaoVelutex: TfrmConfiguracaoVelutex;

implementation

uses untFuncoesSimples,untCadUniLocalizador, untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracaoVelutex }

procedure TfrmConfiguracaoVelutex.CarregarConfiguracoes;
begin
  Try
    conf := fGetConfTinta('VEL');
    inherited CarregarConfiguracoes;
    conf.pInsereCodigo('VELPAT', 'Arquivos para geração', '');

    edtArquivos.Dialog.Dialog.Files.Text := conf.fGet('VELPAT');
    edtArquivos.Text := conf.fGet('VELPAT');
  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;
end;

constructor TfrmConfiguracaoVelutex.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, 'VEL', 'Velutex Imobiliária');
end;

destructor TfrmConfiguracaoVelutex.Destroy;
begin
  inherited Destroy;
end;

procedure TfrmConfiguracaoVelutex.edtArquivosKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracaoVelutex.FormCreate(Sender: TObject);
begin
  inherited;
  edtArquivos.Dialog.Dialog.Filter := 'Arquivos Velutex (*.xlsx)|*.xlsx';
end;

function TfrmConfiguracaoVelutex.fValidaArquivos: Boolean;
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

function TfrmConfiguracaoVelutex.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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

procedure TfrmConfiguracaoVelutex.SalvarConfiguracoes;
begin
  Try
    inherited SalvarConfiguracoes;
    conf.pSet('VELPAT', Trim(edtArquivos.Dialog.Dialog.Files.Text));
  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;

end;

end.
