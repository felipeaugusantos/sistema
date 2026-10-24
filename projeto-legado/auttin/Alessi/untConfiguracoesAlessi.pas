unit untConfiguracoesAlessi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, EditFocus, ComCtrls, Uni, untIConfTinta, untIConsultaTinta,
  untConfConsulta, StrUtils, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesAlessi = class(TfrmPai)
    pnlCabecalho: TPanel;
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    Label2: TLabel;
    Label20: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtTraAle: TEditFocus;
    edtFatAle: TEditFocus;
    edtNfmAle: TEditFocus;
    chkUsaAle: TCheckBox;
    tbsConfCampos: TTabSheet;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label22: TLabel;
    edtApreve: TEditFocus;
    edtPatAle: TFilenameEditFocus;
    rgImpressaoOrdemproducao: TRadioGroup;
    procedure btnGravarConfClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    stlValidadoresObrigatorio: TStringList;
    conf: IConfTinta;
    consulta: IConsultaTinta;
    frmConfConsultaAlessi: TfrmConfConsulta;
  private
    
    procedure ConstruirValidadoresObrigatorios;
    procedure CarregarConfiguracoes;
    procedure SalvarConfiguracoes;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  { Private declarations }

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesAlessi: TfrmConfiguracoesAlessi;

implementation

uses
    untCadUniLocalizador, untFuncTinta, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConfiguracoesAlessi.btnGravarConfClick(Sender: TObject);
begin
  if fVerificaCampos then
  begin
    if fMensagem('', 'Confirma Dados?', ['&Sim', '&Não']) = 1 then
    begin
      SalvarConfiguracoes;
      Close;
    end;
  end; 
  
end;

procedure TfrmConfiguracoesAlessi.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaAlessi.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesAlessi.CarregarConfiguracoes;
var
  intIndex: Integer;
begin
  Try
    conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'S');
    conf.pInsereCodigo('ALEPRE', 'Trava para valor de venda ALEPRE', '');
    conf.pInsereCodigo('ALEFAT', 'Fator da trava de preço', '');
    conf.pInsereCodigo('PROCOD', 'Próximo código da nova formula', '');
    conf.pInsereCodigo('ALEPAT', 'Path para os arquivos de formulas', '');
    conf.pInsereCodigo('UNIQUA', 'Unidade Geral Quarto', '');
    conf.pInsereCodigo('UNIGL',  'Unidade Geral Galão', '');
    conf.pInsereCodigo('UNILA',  'Unidade Geral Lata', '');
    conf.pInsereCodigo('UNIGELQT', 'Unidade Gel Quarto', '');
    conf.pInsereCodigo('UNIGELGL', 'Unidade Gel Galão', '');
    conf.pInsereCodigo('UNITXLA',  'Unidade Textura Lata', '');
    conf.pInsereCodigo('UNITXGL',  'Unidade Textura Galão', '');
    conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
    conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');
    conf.pInsereCodigo('UNIOPR', 'Unidade da Impressão de Ordem de Produção', '1');

  Except
    on E: Exception do
    begin
      fMensagem('ATENÇÃO', Format('Não foi possivel criar as configurações no banco, [%s: %s]', [E.ClassName, E.Message]), ['&OK']);
      Exit;
    end;
  End;

  Try
    chkUsaAle.Checked := conf.fGetBoolean('USATIN');
    edtTraAle.Text := conf.fGet('ALEPRE');
    edtFatAle.Text := FloatToStr(conf.fGetDouble('ALEFAT'));
    edtNfmAle.Text := conf.fGet('PROCOD');
    edtPatAle.Text := conf.fGet('ALEPAT');
    edtDesOpe.Text := FloatToStr(conf.fGetDouble('DESOPE'));
    edtApreve.Text := FloatToStr(conf.fGetDouble('APREVE'));
    rgImpressaoOrdemproducao.ItemIndex := conf.fGetInteger('UNIOPR') - 1;

    for intIndex := 0 to ComponentCount do
    begin
      Try
        if (Components[intIndex] is TEdit) then
          if Assigned((Components[intIndex] as TEdit).OnExit) then
            (Components[intIndex] as TEdit).OnExit(Components[intIndex])
      Except
      End;
    end;
  Except
    on E: Exception do
    begin
      fMensagem('ATENÇÃO', Format('Não foi possivel carregar as configurações do banco, [%s: %s]', [E.ClassName, E.Message]), ['&OK']);
      Exit;
    end;
  End;

end;

procedure TfrmConfiguracoesAlessi.ConstruirValidadoresObrigatorios;
begin
  stlValidadoresObrigatorio.AddObject('O Próximo código da nóva formula deve ser preenchido!', edtNfmAle);
  stlValidadoresObrigatorio.AddObject('A trava do valor de venda deve ser preenchida!', edtTraAle);
  stlValidadoresObrigatorio.AddObject('O valor da trava do valor de venda deve ser preenchido!', edtFatAle);
  stlValidadoresObrigatorio.AddObject('O valor da despesa operacional deve ser preenchido!', edtDesOpe);
  stlValidadoresObrigatorio.AddObject('O Acréscimo Adicional sobre Preço de Venda deve ser maior que Zero!', edtApreve);
end;

constructor TfrmConfiguracoesAlessi.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  stlValidadoresObrigatorio := TStringList.Create;
  ConstruirValidadoresObrigatorios;
  consulta := fGetConsultaTinta('ALE');
  conf := fGetConfTinta('ALE');
  frmConfConsultaAlessi := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  fStartTransaction;
  CarregarConfiguracoes;
end;

destructor TfrmConfiguracoesAlessi.Destroy;
begin
  fRollBack;
  if Assigned(stlValidadoresObrigatorio) then FreeAndNil(stlValidadoresObrigatorio);
  if Assigned(frmConfConsultaAlessi) then FreeAndNil(frmConfConsultaAlessi);  
  inherited Destroy;
end;

function TfrmConfiguracoesAlessi.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  intIndex: Integer;
begin
  Result := True;
  Try
    if (inherited fValidaCampos(Sender, blnBuscaPorChave)) then
    begin
      intIndex := stlValidadoresObrigatorio.IndexOfObject(Sender);
      if intIndex >= 0 then
      begin
        if fEmptyStr(TEdit(stlValidadoresObrigatorio.Objects[intIndex]).Text) then
        begin
          fMensagem('ATENÇÃO', stlValidadoresObrigatorio.Strings[intIndex], ['&OK']);
          Result := False;
        end
        else if (Sender = edtTraAle) then
        begin
          if not MatchText(edtTraAle.Text, ['VEN', 'CUS']) then
          begin
            fMensagem('ATENÇÃO', 'A Trava para o valor de venda deve ser VEN ou CUS', ['&OK']);
            Result := False;
          end;
        end
        else if (Sender = edtDesOpe) then
        begin
          if fStrToFloat(edtDesOpe.Text) < 0.0 then
          begin
            fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
            Result := False;
          end;
        end
        else if (Sender = edtApreve) then
        begin
          if fStrToFloat(edtApreve.Text) < 0.0 then
          begin
            fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
            Result := False;
          end;
        end;
      end
      else if (Sender = edtPatAle) then
      begin
        if not FileExists(AnsiReplaceStr(edtPatAle.Text, '"', '')) then
        begin
          fMensagem('ATENÇÃO', Format('Não foi possivel encontrar o arquivo: %s', [edtPatAle.Text]), ['&OK']);
          Result := False;
        end;
      end;
    end;
  Finally
    if not Result then
      pSetFocus(Sender);
  End;
end;

procedure TfrmConfiguracoesAlessi.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesAlessi.SalvarConfiguracoes;
begin
  Try
    conf.pSetBoolean('USATIN', chkUsaAle.Checked);
    conf.pSet('ALEPRE', edtTraAle.Text);
    conf.pSet('ALEPRE', edtTraAle.Text);
    conf.pSetDouble('ALEFAT', fStrToFloat(edtFatAle.Text));
    conf.pSet('PROCOD', edtNfmAle.Text);
    conf.pSet('ALEPAT', edtPatAle.Text);
    conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
    conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));
    conf.pSetInteger('UNIOPR', rgImpressaoOrdemproducao.ItemIndex + 1);

    frmConfConsultaAlessi.pSalvarConfs;
    fCommit;
  Except
    on E: Exception do
    begin
      fMensagem('ATENÇÃO', Format('Não foi possivel gravar as configurações no banco, [%s: %s]', [E.ClassName, E.Message]), ['&OK']);
      Exit;
    end;
  End;

end;

end.

