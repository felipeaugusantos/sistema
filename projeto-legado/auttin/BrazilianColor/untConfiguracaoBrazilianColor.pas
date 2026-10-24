
unit untConfiguracaoBrazilianColor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untAbstractConfiguracaoAutomotiva, AppEvnts, Menus, StdCtrls, EditFocus,
  ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, Mask, StrUtils, FilenameEditFocus,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracaoBrazilianColor = class(TfrmAbstractConfiguracaoAutomotiva)
    lblArquivos: TLabel;
    grpEmbalagens: TGroupBox;
    lblEmbLitro: TLabel;
    edtCodEmbLit: TEditFocus;
    edtDesEmbLit: TEditFocus;
    lblEmbGal: TLabel;
    edtCodEmbGal: TEditFocus;
    edtDesEmbGal: TEditFocus;
    lblLata: TLabel;
    edtCodEmbLat: TEditFocus;
    edtDesEmbLat: TEditFocus;
    edtArquivos: TFilenameEditFocus;
    procedure edtCodEmbLitKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaArquivos: Boolean;
    procedure CarregarConfiguracoes; override;
    procedure SalvarConfiguracoes; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    constructor Create(AOwner: TComponent); reintroduce;
    { Public declarations }
  end;

var
  frmConfiguracaoBrazilianColor: TfrmConfiguracaoBrazilianColor;

implementation

uses untFuncoesSimples, untFuncTinta;

{$R *.dfm}

{ TfrmConfiguracaoBrazilianColor }

procedure TfrmConfiguracaoBrazilianColor.CarregarConfiguracoes;
begin
  Try
    inherited CarregarConfiguracoes;

    conf := fGetConfTinta('BZC');

    conf.pInsereCodigo('BZCPAT', 'Arquivo para geração', '');
    conf.pInsereCodigo('EMBLIT', 'Produto embalagem litro', '');
    conf.pInsereCodigo('EMBGAL', 'Produto embalagem galão', '');
    conf.pInsereCodigo('EMBLAT', 'Produto embalagem lata', '');

    chkUsaTin.Checked := conf.fGetBoolean('USATIN');
    edtTraTin.Text := conf.fGet('TRATIN');
    edtFatTin.Text := FormatFloat('0.00', conf.fGetDouble('FATTIN'));
    edtNfmTin.Text := fStrZero(conf.fGetInteger('PROCOD'), 5);
    chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
    edtDesOpe.Text := FormatFloat('0.00', conf.fGetDouble('DESOPE'));
    edtApreve.Text := FormatFloat('0.00', conf.fGetDouble('APREVE'));
    chkAcumuladoAbsoluto.Checked := IIF(conf.fGet('ACUABS') = '1', True, False);



    edtArquivos.Text := conf.fGet('BZCPAT');
    edtCodEmbLit.Text := conf.fGet('EMBLIT');
    edtCodEmbGal.Text := conf.fGet('EMBGAL');
    edtCodEmbLat.Text := conf.fGet('EMBLAT');
    edtCodProdut.Text := conf.fGet('CODPRO');
    edtTraTin.text    := conf.fGet('TRATIN');
    edtFatTin.Text    := conf.fGet('FATTIN');

  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;            
end;

constructor TfrmConfiguracaoBrazilianColor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, 'BZC', 'BrazilianColor Automotiva');
//  conf := fGetConfTinta('BZC');

end;

procedure TfrmConfiguracaoBrazilianColor.edtCodEmbLitKeyPress(Sender: TObject; var Key: Char);
var
  edtDesEdt: TEdit;
begin
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 6)));
    if Assigned(edtDesEdt) then
      pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracaoBrazilianColor.FormCreate(Sender: TObject);
begin
  inherited;
  edtArquivos.Dialog.Dialog.Filter := 'Arquivo BrazilianColor (*.mdb)|*.mdb';
end;

function TfrmConfiguracaoBrazilianColor.fValidaArquivos: Boolean;
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

function TfrmConfiguracaoBrazilianColor.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if Sender = edtCodEmbLit then
    begin
      edtDesEmbLit.Text := fRetNomProduto(edtCodEmbLit.Text);
      if not fEmptyStr(edtCodEmbLit.Text) then
      begin
        if fEmptyStr(edtDesEmbLit.Text) then
        begin
          fMensagem('ATENÇÃO', Format('O produto [%s] não está cadastrado!', [edtCodEmbLit.Text]), ['OK']);
          Result := False;
        end;  
        
      end;  
    end
    else if Sender = edtCodEmbGal then
    begin
      edtDesEmbGal.Text := fRetNomProduto(edtCodEmbGal.Text);
      if not fEmptyStr(edtCodEmbGal.Text) then
      begin
        if fEmptyStr(edtDesEmbGal.Text) then
        begin
          fMensagem('ATENÇÃO', Format('O produto [%s] não está cadastrado!', [edtCodEmbGal.Text]), ['OK']);
          Result := False;
        end;  
        
      end;  
    end
    else if Sender = edtCodEmbLat then
    begin
      edtDesEmbLat.Text := fRetNomProduto(edtCodEmbLat.Text);
      if not fEmptyStr(edtCodEmbLat.Text) then
      begin
        if fEmptyStr(edtDesEmbLat.Text) then
        begin
          fMensagem('ATENÇÃO', Format('O produto [%s] não está cadastrado!', [edtCodEmbLat.Text]), ['OK']);
          Result := False;
        end;

      end;
    end
    else if Sender = edtArquivos then
    begin
      Result := fValidaArquivos;
    end;

  end;

  if not Result then
    pProcuraSetFocus(Sender);
end;

procedure TfrmConfiguracaoBrazilianColor.SalvarConfiguracoes;
begin
  Try
    conf := fGetConfTinta('BZC');

    conf.pSet('BZCPAT', edtArquivos.Text);
    conf.pSet('EMBLIT', edtCodEmbLit.Text);
    conf.pSet('EMBGAL', edtCodEmbGal.Text);
    conf.pSet('EMBLAT', edtCodEmbLat.Text);
    conf.pSet('FATTIN', edtFatTin.Text   );
    conf.pSet('ACUABS', IIF(chkAcumuladoAbsoluto.Checked, '1', '2'));

    inherited SalvarConfiguracoes;
  Except
    on E: Exception do
    begin
      pMensagemOk(E.Message);
    end;
  End;
end;

end.
