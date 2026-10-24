unit untAbstractConfiguracao;

interface

uses
  SysUtils, Classes, Controls, Forms,
  untPai, StdCtrls, BitBtnLockedIncrem, 
  EditFocus, ComCtrls, untConfConsulta, untIConfTinta, untIConsultaTinta,
  AppEvnts, Menus, Buttons, ExtCtrls, StrUtils, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmAbstractConfiguracao = class(TfrmPai)
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    lblTrava: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtTraTin: TEditFocus;
    edtFatTin: TEditFocus;
    edtNfmTin: TEditFocus;
    chkUsaTin: TCheckBox;
    tbsConfCampos: TTabSheet;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    chkUsaFor: TCheckBox;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label22: TLabel;
    edtApreve: TEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  protected
    frmConfConsulta: TfrmConfConsulta;
    conf: IConfTinta;
    consulta: IConsultaTinta;
    procedure CarregarConfiguracoes; virtual;
    procedure SalvarConfiguracoes; virtual;
    procedure PreencheCampos; virtual;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; const strIdePro, strNomeTinta: string); reintroduce;
    destructor Destroy; override;
    { Public declarations }
  end;

  TCustomWinControl = class(TWinControl);
  TWinControlHelper = class helper for TWinControl
  public
    procedure Exit(Sender: TObject);
  end;

var
  frmAbstractConfiguracao: TfrmAbstractConfiguracao;

implementation

uses untFuncTinta, untFuncoesSimples;

{$R *.dfm}

procedure TfrmAbstractConfiguracao.btnGravarConfClick(Sender: TObject);
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


procedure TfrmAbstractConfiguracao.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsulta.pRestaurarPadrao;
end;

procedure TfrmAbstractConfiguracao.CarregarConfiguracoes;
begin
  Try
    conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', 'S');
    conf.pInsereCodigo('TRATIN', 'Trava para valor de venda', '');
    conf.pInsereCodigo('FATTIN', 'Fator da trava de preço', '');
    conf.pInsereCodigo('PROCOD', 'Próximo Código Novas Fórmulas', '1');
    conf.pInsereCodigo('USAFOR', 'Utilizar Formulação', 'S');
    conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
    conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  Except
    on E: Exception do
    begin
      raise Exception.Create(Format('Não foi possivel criar as configurações no banco, [%s: %s]', [E.ClassName, E.Message]));
    end;
  End;

  Try
    chkUsaTin.Checked := conf.fGetBoolean('USATIN');
    edtTraTin.Text := conf.fGet('TRATIN');
    edtFatTin.Text := FormatFloat('0.00', conf.fGetDouble('FATTIN'));
    edtNfmTin.Text := fStrZero(conf.fGetInteger('PROCOD'), 5);
    chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
    edtDesOpe.Text := FormatFloat('0.00', conf.fGetDouble('DESOPE'));
    edtApreve.Text := FormatFloat('0.00', conf.fGetDouble('APREVE'));

  Except
    on E: Exception do
    begin
      raise Exception.Create(Format('Não foi possivel carregar as configurações do banco, [%s: %s]', [E.ClassName, E.Message]));
    end;
  End;

end;

constructor TfrmAbstractConfiguracao.Create(AOwner: TComponent; const strIdePro, strNomeTinta: string);
begin
  inherited Create(AOwner);
  conf := fGetConfTinta(strIdePro);
  consulta := fGetConsultaTinta(strIdePro);
  frmConfConsulta := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  CarregarConfiguracoes;
  PreencheCampos;

  lblTrava.Caption := 'Trava para valor de venda (' + strIdePro + '_TRA):';
  Self.Caption := 'Configurações ' + strNomeTinta;
end;

destructor TfrmAbstractConfiguracao.Destroy;
begin
  if Assigned(frmConfConsulta) then FreeAndNil(frmConfConsulta);
  inherited;
end;

procedure TfrmAbstractConfiguracao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(chkUsaTin);
end;

function TfrmAbstractConfiguracao.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if inherited fValidaCampos(Sender, blnBuscaPorChave) then
  begin
    Sender.Exit(Sender);

    if Sender = edtFatTin then
    begin
      if fStrToFloat(edtFatTin.Text) <= 0 then
      begin
        fMensagem('ATENÇÃO', 'O Fator da Trava deve ser maior que Zero!', ['OK']);
        Result := False;
      end;
    end
    else if Sender = edtTraTin then
    begin
      if (fEmptyStr(edtTraTin.Text)) or (not MatchText(edtTraTin.Text, ['VEN', 'CUS'])) then
      begin
        fMensagem('ATENÇÃO', 'A trava deve ser "VEN" ou "CUS" !', ['OK']);
        Result := False;
      end;
    end

    else if (Sender = edtDesOpe) then
    begin
      if fEmptyStr(edtDesOpe.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end
      else if fStrToFloat(edtDesOpe.Text) < 0.0 then
      begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end;
    end

    else if (Sender = edtApreve) then
    begin
      if fEmptyStr(edtApreve.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end
      else if fStrToFloat(edtApreve.Text) < 0.0 then
      begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      end;
    end

  end;

  if not Result then
    pProcuraSetFocus(Sender);
end;

procedure TfrmAbstractConfiguracao.pgcDadosChange(Sender: TObject);
begin
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmAbstractConfiguracao.PreencheCampos;
var
  intCont: Integer;
begin
  for intCont := 0 to ComponentCount - 1 do
  begin
    if Components[intCont] is TWinControl then
      (Components[intCont] as TWinControl).Exit(Components[intCont] as TWinControl);
  end;
end;

procedure TfrmAbstractConfiguracao.SalvarConfiguracoes;
begin
  Try
    conf.pSetBoolean('USATIN', chkUsaTin.Checked);
    conf.pSet('TRATIN', edtTraTin.Text);
    conf.pSetDouble('FATTIN', fStrToFloat(edtFatTin.Text));
    conf.pSetInteger('PROCOD', StrToIntDef(edtNfmTin.Text, 1));
    conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
    conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
    conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));
    frmConfConsulta.pSalvarConfs;
  Except
    on E: Exception do
    begin
      raise Exception.Create(Format('Não foi possivel gravar as configurações no banco, [%s: %s]', [E.ClassName, E.Message]));
    end;
  End;

end;

{ TWinControlHelper }

procedure TWinControlHelper.Exit(Sender: TObject);
var
  pOnExit: TNotifyEvent;
begin
  pOnExit := TCustomWinControl(Self).OnExit;
  if Assigned(pOnExit) then
    pOnExit(Sender);
end;

end.
