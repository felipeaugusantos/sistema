unit untConfiguracaoInternational;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untAbstractConfiguracao, AppEvnts, Menus, StdCtrls, EditFocus, ComCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls, Mask, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  FilenameEditFocus;

type
  TfrmConfiguracaoInternational = class(TfrmAbstractConfiguracao)
    lblArquivos: TLabel;
    edtArquivos: TFilenameEditFocus;
    rgImpressaoOrdemproducao: TRadioGroup;
    chkManual: TCheckBox;
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
  frmConfiguracaoInternational: TfrmConfiguracaoInternational;

implementation

uses
  untFuncoesSimples, untCadUniLocalizador, untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracaoInternational }

procedure TfrmConfiguracaoInternational.CarregarConfiguracoes;
begin
  Try
    conf := fGetConfTinta('INT');

    conf.pInsereCodigo('INTPAT', 'Arquivos para geração', '');


    rgImpressaoOrdemproducao.ItemIndex := conf.fGetInteger('UNIOPR') - 1;

    edtArquivos.Dialog.Dialog.Files.Text := conf.fGet('INTPAT');
    chkManual.Checked := conf.fGetBoolean('INTMAN');
    edtArquivos.Text  := conf.fGet('INTPAT');

    inherited CarregarConfiguracoes;
  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;
end;

constructor TfrmConfiguracaoInternational.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, 'INT', 'International');
end;

destructor TfrmConfiguracaoInternational.Destroy;
begin
  inherited;
end;

procedure TfrmConfiguracaoInternational.FormCreate(Sender: TObject);
begin
  inherited;

  conf     := fGetConfTinta('INT');
  consulta := fGetConsultaTinta('INT');

//  edtArquivos.Dialog.Dialog.Filter := 'Arquivos International (*.xls; *.xlsx)|*.xls;*.xlsx';
  edtArquivos.Dialog.Dialog.Filter := 'Arquivos International (*.accdb; *.mdb)|*.accdb;*.mdb';

  conf.pInsereCodigo('UNIOPR', 'Impressão da Ordem de Produção', '1');
  conf.pInsereCodigo('INTMAN', 'Máquina Manual', fArqIniTinta(0, 'International Imobiliaria', 'INTMAN', ''));

end;

function TfrmConfiguracaoInternational.fValidaArquivos: Boolean;
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

function TfrmConfiguracaoInternational.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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

procedure TfrmConfiguracaoInternational.SalvarConfiguracoes;
begin
  Try
    inherited SalvarConfiguracoes;
    conf.pSet('INTPAT', Trim(edtArquivos.Text));
    conf.pSetInteger('UNIOPR', rgImpressaoOrdemproducao.ItemIndex + 1);
    conf.pSetBoolean('INTMAN', chkManual.Checked);

  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;
end;

end.