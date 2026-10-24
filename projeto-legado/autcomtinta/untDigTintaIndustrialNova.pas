unit untDigTintaIndustrialNova;

interface

uses
  SysUtils, Variants, Classes, Controls, Forms,
  untPai, StdCtrls, BitBtnLockedIncrem, ExtCtrls, EditFocus,
  untFormulaIndustrial, untFuncoesSimples, Uni, AppEvnts, Menus, Buttons,
  Windows, frxClass, frxExportCSVTestabilidade;

type

  TfrmDigTintaIndustrialNova = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    btnFormulacao: TBitBtnLocked;
    pnlTotais: TPanel;
    lblValorBase: TLabel;
    lblValorColorantes: TLabel;
    edtValBas: TEditFocus;
    edtValCol: TEditFocus;
    Label1: TLabel;
    edtValorFinal: TEditFocus;
    lblVolumeFinal: TLabel;
    edtVolumeFinal: TEditFocus;
    grpBase: TGroupBox;
    edtBasAtu: TEditFocus;
    edtDesBasAtu: TEditFocus;
    lblDescricaoAdicional: TLabel;
    edtDesAdi: TEditFocus;
    chkUsaCatalisador: TCheckBox;
    rgEmbalagens: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure chkUsaCatalisadorClick(Sender: TObject);
    procedure btnFormulacaoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure rgEmbalagensClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ValidarProduto();
    procedure CarregarEmbalagens;
    procedure AtualizarTitulo;
  protected
    formula: TFormulaIndustrial;
    dicEmbalagens: TDicionario;
    dicCodigosEmbalagens: TDicionario;
    dicProdutosBase: TDicionario;
    procedure AtualizarTela; virtual;
    procedure CarregarBase;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    const PERSONALIZADA: string = 'PERSONALIZADA';
    constructor Create(const AOwner: TComponent; const formula: TFormulaIndustrial); reintroduce;
    destructor Destroy; override;
    function GetCodigoEmbalagem(): string;
    { Public declarations }
  end;

var
  frmDigTintaIndustrialNova: TfrmDigTintaIndustrialNova;

implementation

uses
  untFormulacaoIndustrialNova, Data.DB;

{$R *.dfm}

{ TfrmDigTintaIndustrialNova }

procedure TfrmDigTintaIndustrialNova.AtualizarTela;
begin
  formula.ZerarPrecos;
  CarregarBase;
  formula.CalcularPrecos;

  if rgEmbalagens.ItemIndex <> rgEmbalagens.Items.IndexOf(PERSONALIZADA) then
  begin
    edtValBas.Text := FormatCurr('0.00', formula.PrecoVendaBase);
  end
  else
  begin
    edtValBas.Text := FormatCurr('0.00', formula.PrecoVendaEmbalagem);
  end;

  edtValCol.Text := FormatCurr('0.00', formula.PrecoVendaComponentes);
  edtValorFinal.Text := FormatCurr('0.00', formula.PrecoVenda);
  edtVolumeFinal.Text := FormatFloat('0.000', formula.VolumeFinal);
end;

procedure TfrmDigTintaIndustrialNova.AtualizarTitulo;
var
  strAtual: string;
begin
  for strAtual in rgEmbalagens.Items do
    Self.Caption := StringReplace(Self.Caption, strAtual, rgEmbalagens.Items[rgEmbalagens.ItemIndex], []);    
end;

procedure TfrmDigTintaIndustrialNova.btnConfirmaClick(Sender: TObject);
begin
  If Not fVerificaCampos Then
    Exit;

  if fStrToFloat(edtValorFinal.Text) <= 0 then
    Exit;

  ModalResult := mrOk;
end;

procedure TfrmDigTintaIndustrialNova.btnFormulacaoClick(Sender: TObject);
var
  frmFormulacao: TfrmFormulacaoIndustrialNova;
begin
  frmFormulacao := nil;
  Try
    Try
      frmFormulacao := TfrmFormulacaoIndustrialNova.Create(Self, formula);
      frmFormulacao.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmFormulacao) then FreeAndNil(frmFormulacao);
  End;                              
end;

procedure TfrmDigTintaIndustrialNova.CarregarBase;
begin
  edtBasAtu.Text := formula.ItemBase;
  edtDesBasAtu.Text := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [formula.ItemBase]);
end;

procedure TfrmDigTintaIndustrialNova.CarregarEmbalagens;
var
  intCont: Integer;
begin
  dicEmbalagens.Limpar;
  rgEmbalagens.Items.Clear;
 

  formula.GetEmbalagensDisponivels(dicEmbalagens, dicCodigosEmbalagens, dicProdutosBase);

  for intCont := 0 to dicEmbalagens.Chaves.Count - 1 do
    rgEmbalagens.Items.Add(dicEmbalagens.Chaves[intCont]);    

  rgEmbalagens.Items.Add(PERSONALIZADA);
  rgEmbalagens.ItemIndex := rgEmbalagens.Items.IndexOf(formula.EmbalagemBase);
end;

procedure TfrmDigTintaIndustrialNova.chkUsaCatalisadorClick(Sender: TObject);
begin
  formula.UsaCatalisador := chkUsaCatalisador.Checked;
  AtualizarTela;
end;

constructor TfrmDigTintaIndustrialNova.Create(const AOwner: TComponent; const formula: TFormulaIndustrial);
begin
  inherited Create(AOwner);
  Self.formula := formula;
  Self.Caption := 'Fórmula - ' + formula.Descricao;
  Self.dicEmbalagens := TDicionario.Create;
  Self.dicCodigosEmbalagens := TDicionario.Create;
  Self.dicProdutosBase := TDicionario.Create;
  chkUsaCatalisador.Enabled := formula.TemCatalisador;
  if not formula.TemCatalisador then
    chkUsaCatalisador.Checked := False;
  
end;

destructor TfrmDigTintaIndustrialNova.Destroy;
begin
  if Assigned(dicEmbalagens) then FreeAndNil(dicEmbalagens);
  if Assigned(dicCodigosEmbalagens) then FreeAndNil(dicCodigosEmbalagens);
  if Assigned(dicProdutosBase) then FreeAndNil(dicProdutosBase);
  inherited;
end;

procedure TfrmDigTintaIndustrialNova.FormCreate(Sender: TObject);
begin
  inherited;
  If (fCfgSis('DIRFOR', varBoolean))  Then
    btnFormulacao.Visible :=  fVerificaAcessoSistema('DIRVISFOR');

end;

procedure TfrmDigTintaIndustrialNova.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If (ActiveControl Is TRadioButton) Or
                  (ActiveControl Is TComboBox) Then
                 SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigTintaIndustrialNova.FormShow(Sender: TObject);
begin
  inherited;
  formula.CarregarPrecos;
  formula.CarregarPrecosBases;
  formula.CarregarPrecosEmbalagem;
  CarregarEmbalagens;
  AtualizarTela;
  edtBasAtu.SelectAll;
  pSetFocus(edtBasAtu);
end;

procedure TfrmDigTintaIndustrialNova.ValidarProduto();
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      if rgEmbalagens.ItemIndex = rgEmbalagens.Items.IndexOf(PERSONALIZADA) then
      begin
        Exit;
      end;

      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT  ' +
        '   UNI_SIGUNI ' +
        '   , ITE_ITEBAS  ' +
        ' FROM ' +
        '   CADITE I  ' +
        '   INNER JOIN ITEGER G  ' +
        '     ON I.ITE_CODITE = G.ITE_CODITE  ' +
        '   INNER JOIN CADUNI U  ' +
        '     ON I.ITE_CODUNI = U.UNI_CODUNI  ' +
        ' WHERE I.ITE_CODITE = :CODITE  ' +
        '   AND G.ITE_IMPLIS = "S"  ' +
        '   AND G.ITE_CODEMP = :CODEMP  ';

      qryGen.ParamByName('CODITE').AsString := edtBasAtu.Text;
      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.Open;

      if qryGen.IsEmpty then
        raise Exception.CreateFmt('Não foi possivel encontrar o produto %s! Verifique!', [edtBasAtu.Text]);

      if qryGen.FieldByName('ITE_ITEBAS').AsString <> 'S' then
        raise Exception.CreateFmt('O produto %s não é uma base! Verifique!', [edtBasAtu.Text]);

      If (Not fCfgSis('TRBAUD',varBoolean))
        and (qryGen.FieldByName('UNI_SIGUNI').AsString <> fRetSiglaUnidade(formula.Unidade)) Then
        raise Exception.CreateFmt('A unidade do produto %s (%s) não é a mesma unidade da fórmula (%s)! Verifique!', [
          edtBasAtu.Text, qryGen.FieldByName('UNI_SIGUNI').AsString,  fRetSiglaUnidade(formula.Unidade)]);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

function TfrmDigTintaIndustrialNova.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  if Result then
  begin
    if Sender = edtVolumeFinal then
    begin
      if fStrToFloat(edtVolumeFinal.Text) <= 0 then
      begin
        fMensagem('ATENÇÃO!', 'O volume deve ser maior que zero!', ['OK']);
        edtVolumeFinal.Text := FormatFloat('0.000', formula.VolumeOriginal);
        Result := False;
        Exit;
      end;

      formula.VolumeFinal := fStrToFloat(edtVolumeFinal.Text);
    end
    else if Sender = edtBasAtu then
    begin
      If (fEmptyStr(edtBasAtu.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      else
      begin
        try
          ValidarProduto;
        except
          on E: Exception do
          begin
            fMensagem('ATENÇÃO!', E.Message, ['OK']);
            Result := False;
          end;
        end;
      end;
      formula.ItemBase := edtBasAtu.Text;
    end;         

    AtualizarTela;
  end;

  if not Result then
    pSetFocus(Sender);

end;

function TfrmDigTintaIndustrialNova.GetCodigoEmbalagem(): string;
begin
  Result := IfNull(dicCodigosEmbalagens[rgEmbalagens.Items[rgEmbalagens.ItemIndex]], '');
  if fEmptyStr(Result) then
    Result := IfNull(dicCodigosEmbalagens[formula.EmbalagemBase], '') ;
end;

procedure TfrmDigTintaIndustrialNova.rgEmbalagensClick(Sender: TObject);
begin
  formula.Personalizada := rgEmbalagens.ItemIndex = rgEmbalagens.Items.IndexOf(PERSONALIZADA);

  edtVolumeFinal.Enabled :=  formula.Personalizada;
  edtVolumeFinal.ReadOnly :=  not formula.Personalizada;
  edtBasAtu.Visible := not formula.Personalizada;
  edtDesBasAtu.Visible := not formula.Personalizada;

  if (rgEmbalagens.ItemIndex <> rgEmbalagens.Items.IndexOf(PERSONALIZADA)) then
  begin
    formula.CodigoEmbalagemBase := dicCodigosEmbalagens[rgEmbalagens.Items[rgEmbalagens.ItemIndex]];
    formula.ItemBase := dicProdutosBase[rgEmbalagens.Items[rgEmbalagens.ItemIndex]];
    formula.VolumeFinal := dicEmbalagens[rgEmbalagens.Items[rgEmbalagens.ItemIndex]];
    lblValorBase.Caption := 'Valor da Base';
  end
  else
  begin
//    formula.ItemBase := formula.GetCodigoProdutoVendaEmbalagem;
    lblValorBase.Caption := 'Valor da Embalagem';
    SelectNext(rgEmbalagens, True, True);
  end;

  AtualizarTela;
  AtualizarTitulo; 
end;

end.
