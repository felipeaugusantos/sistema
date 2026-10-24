unit untFrameEdicaoChecklistGarantia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Data.DB,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, MemoFocus,
  Vcl.ExtCtrls, EditFocus, untCadCheckListValidacaoGarantia, untChkMerTypes, Uni;

type
  TfraEdicaoChecklistGarantia = class(TFrame, IFrameEditarChkMercadoriasView)
    pnlChkGarPrincipal: TPanel;
    lblTituloChecklist: TLabel;
    pnlChkGarPrincipal1: TPanel;
    lblChkGarDescri: TLabel;
    lblChkGarCodigo: TLabel;
    edtChkGarCodigo: TEditFocus;
    edtChkGarDescricao: TEditFocus;
    pnlChkGarPrincipal2: TPanel;
    Panel17: TPanel;
    rdgChkGarTipoVG: TRadioGroup;
    rdgChkGarTipoRE: TRadioGroup;
    pnlChkGarPrincipal2Dir: TPanel;
    lblChkGarCarateresMemo: TLabel;
    lblchkGarConteudo: TLabel;
    mmoChkGarConteudo: TMemoFocus;
    btnChkGarConfirmar: TBitBtnLocked;
    btnChkGarCancelar: TBitBtnLocked;
    procedure btnChkGarConfirmarClick(Sender: TObject);
    procedure mmoChkGarConteudoChange(Sender: TObject);
    procedure mmoChkGarConteudoKeyPress(Sender: TObject; var Key: Char);
    procedure edtChkGarCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnChkGarCancelarClick(Sender: TObject);
    procedure edtChkGarCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FQryItemChk: TUniQuery;
    FPermitirEdicao: boolean;
    FrecItemCklMer: TRecItemCheckListGarantia;

    [weak]
    FFrameChkGar: IFrameCheckList;
    [weak]
    FFrameChkTro: IFrameCheckList;

    FRetornarItemChecklistMercadoria: TEnviarItemChecklistMercadoria;

    procedure pAtualizarCheckListMercadoria;
    procedure pAtualizarContadorCaracteres;
    procedure pAtualizarRdgChkGarTipoRe;
    procedure pAtualizarRdgChkGarTipoVG;

    procedure pConfirmar;

    procedure pExibirRecTItemCheckListGarantia;

    procedure pLimpar;

    procedure pSetMaxLengthMmoChkGarConteudo(const intTamanho: Integer);
    procedure pSetrecItemCklMer(Const recItemCklMer: TRecItemCheckListGarantia);
    procedure pCriarQryPesq;
    function fPesquisarItemCheckList(const pCodigo: String): Boolean;
    { Private declarations }
  public
    Constructor Create(AOwner: TComponent);override;
    Destructor Destroy;override;
    procedure pEditarCheckList(precItemCklMer: TRecItemCheckListGarantia;
      pRetornarItemChecklistMercadoria: TEnviarItemChecklistMercadoria; blnPermitirEdicao: Boolean);
    procedure pSetFrameCheckList(pTipoCheckList: TTipoCheckList; pFrame: IFrameCheckList);
    function fValidaCampos(Sender: TWinControl): Boolean;
    procedure pHabilitarEdicao(const blnHabilitado: Boolean; blnLimpar: Boolean);

    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas;
{$R *.dfm}

{ TfraEdicaoChecklistGarantia }

procedure TfraEdicaoChecklistGarantia.btnChkGarCancelarClick(Sender: TObject);
begin
  FrecItemCklMer.pLimpar;
  pExibirRecTItemCheckListGarantia;
end;

procedure TfraEdicaoChecklistGarantia.btnChkGarConfirmarClick(Sender: TObject);
begin
  pConfirmar;
end;

constructor TfraEdicaoChecklistGarantia.Create(AOwner: TComponent);
begin
  FPermitirEdicao := True;
  inherited Create(AOwner);
  pLimpar;
  pCriarQryPesq;
end;

destructor TfraEdicaoChecklistGarantia.Destroy;
begin
  if Assigned(FQryItemChk) then
    FreeAndNil(FQryItemChk);
  inherited;
end;

procedure TfraEdicaoChecklistGarantia.edtChkGarCodigoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if fValidaCampos(edtChkGarCodigo) then
      pSetFocus(mmoChkGarConteudo);
  end;
end;

procedure TfraEdicaoChecklistGarantia.edtChkGarCodigoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrItem: TConsultasArray;
    strCodigo, strDescri: String;
    aForm: TForm;

begin
  aForm := Self.Owner as TForm;
  if fEntraCons(Key) then
  begin
    FrecItemCklMer.pLimpar;
    pExibirRecTItemCheckListGarantia;

    if fPesqCadCheckListValidacaoGarantia(aForm, strCodigo, strDescri, FQryItemChk, Key, arrItem) then
    begin
      edtchkGarCodigo.Text := strCodigo;
      if fValidaCampos(edtchkGarCodigo) then
        pSetFocus(mmoChkGarConteudo);
    end;
  end;
end;

function TfraEdicaoChecklistGarantia.fPesquisarItemCheckList(
  const pCodigo: String): Boolean;
begin

  if FQryItemChk.Active Then
    FQryItemChk.Close;
  Try

    FQryItemChk.Sql.Clear;
    FQryItemChk.Sql.Add('SELECT * FROM CADCVG WHERE CVG_CODIGO = :CODIGO ');
    FQryItemChk.ParamByName('CODIGO').AsString := pCodigo;
    FQryItemChk.Open;
    Result := Not FQryItemChk.IsEmpty;
  Except
    On E:Exception do
    begin
      Result := False;
      pMensagensErro(e.Message,'TfraEdicaoChecklistGarantia.fPesquisarItemCheckList');
    end;
  End;

end;

function TfraEdicaoChecklistGarantia.fValidaCampos(
  Sender: TWinControl): Boolean;
begin
  Result := True;
  if (Sender = edtChkGarCodigo) then
  begin
    FrecItemCklMer.pLimpar;
    if Not fEmptyStr(edtChkGarCodigo.Text) then
    begin
      if fPesquisarItemCheckList(edtChkGarCodigo.Text) then
      begin
        FrecItemCklMer.strAutoincrem := FQryItemChk.FieldByName('AUTOINCREM').AsString;
        FrecItemCklMer.strCodigo := FQryItemChk.FieldByName('CVG_CODIGO').AsString;
        FrecItemCklMer.strDescricao := FQryItemChk.FieldByName('CVG_DESCRI').AsString;
        FrecItemCklMer.enuChkList.pSetAsString(FQryItemChk.FieldByName('CVG_TIPOVG').AsString);
        FrecItemCklMer.enuResultado.pSetAsString(FQryItemChk.FieldByName('CVG_TIPORE').AsString);

        pExibirRecTItemCheckListGarantia;
      end
      else
      begin
        edtChkGarDescricao.Clear;
        mmoChkGarConteudo.Lines.Clear;
        rdgChkGarTipoVG.ItemIndex := -1;
        rdgChkGarTipoRE.ItemIndex := -1;
        Result := False;
        Exit;
      end;
    end;

  end;

end;

procedure TfraEdicaoChecklistGarantia.mmoChkGarConteudoChange(Sender: TObject);
begin
  pAtualizarContadorCaracteres;
end;

procedure TfraEdicaoChecklistGarantia.mmoChkGarConteudoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 Then
    if FrecItemCklMer.enuResultado in [TTipoResultado.LinhaUnica, TTipoResultado.NA] then
      Key := #0;
end;

procedure TfraEdicaoChecklistGarantia.pAtualizarCheckListMercadoria;
begin
  FrecItemCklMer.strConteudo := mmoChkGarConteudo.Texto;
  FrecItemCklMer.blnAssociado := True;
end;

procedure TfraEdicaoChecklistGarantia.pAtualizarContadorCaracteres;
  Var
    intDif: Integer;
begin
  intDif := mmoChkGarConteudo.MaxLength - Length(mmoChkGarConteudo.Texto);
  if IntDif < 0 then
    intDif := 0;
  lblChkGarCarateresMemo.Caption := Format('Caracteres restantes: %d',[intDif]);
end;

procedure TfraEdicaoChecklistGarantia.pAtualizarRdgChkGarTipoRe;
begin
  if FrecItemCklMer.enuResultado.fAsString = EmptyStr Then
    rdgChkGarTipoRE.ItemIndex := -1
  else
    rdgChkGarTipoRE.ItemIndex := Ord(FrecItemCklMer.enuResultado);
end;

procedure TfraEdicaoChecklistGarantia.pAtualizarRdgChkGarTipoVG;
begin
  if FrecItemCklMer.enuChkList.fAsString = EmptyStr then
    rdgChkGarTipoVG.ItemIndex := -1
  else
    rdgChkGarTipoVG.ItemIndex := Ord(FrecItemCklMer.enuChkList);
end;

procedure TfraEdicaoChecklistGarantia.pConfirmar;
begin
  pAtualizarChecklistMercadoria;

  if  (FrecItemCklMer.enuChkList = TTipoCheckList.Garantia) then
    FFrameChkGar.pInserirItem(FrecItemCklMer)
  else if (FrecItemCklMer.enuChkList = TTipoCheckList.Troca) then
    FFrameChkTro.pInserirItem(FrecItemCklMer);

  pLimpar;
end;

procedure TfraEdicaoChecklistGarantia.pEditarCheckList(precItemCklMer: TRecItemCheckListGarantia;
  pRetornarItemChecklistMercadoria: TEnviarItemChecklistMercadoria;  blnPermitirEdicao: Boolean);
begin
//  FPermitirEdicao := blnPermitirEdicao;

  pSetrecItemCklMer(precItemCklMer);
  FRetornarItemChecklistMercadoria := pRetornarItemChecklistMercadoria;
  pSetFocus(mmoChkGarConteudo);

end;

procedure TfraEdicaoChecklistGarantia.pExibirRecTItemCheckListGarantia;
begin
  edtChkGarCodigo.Text := FrecItemCklMer.strCodigo;
  edtChkGarDescricao.Text := FrecItemCklMer.strDescricao;
  pSetMaxLengthMmoChkGarConteudo(FrecItemCklMer.fTamanhoConteudo);
  mmoChkGarConteudo.Texto := FrecItemCklMer.strConteudo;

  pAtualizarRdgChkGarTipoVG;
  pAtualizarRdgChkGarTipoRe;

  edtChkGarCodigo.enabled := FPermitirEdicao;
  edtChkGarCodigo.ReadOnly := Not FPermitirEdicao;

  btnChkGarConfirmar.Enabled := FPermitirEdicao;
  btnChkGarCancelar.Enabled := FPermitirEdicao;
  mmoChkGarConteudo.Enabled := FPermitirEdicao;
end;

procedure TfraEdicaoChecklistGarantia.pHabilitarEdicao(
  const blnHabilitado: Boolean; blnLimpar: Boolean);
begin
    FPermitirEdicao := blnHabilitado;
    edtChkGarCodigo.Enabled := FPermitirEdicao;
    mmoChkGarConteudo.Enabled := FPermitirEdicao;
    btnChkGarConfirmar.Enabled := FPermitirEdicao;
    btnChkGarCancelar.Enabled := FPermitirEdicao;
end;

procedure TfraEdicaoChecklistGarantia.pLimpar;
begin
  FrecItemCklMer.pLimpar;
  pExibirRecTItemCheckListGarantia;
  FRetornarItemChecklistMercadoria := Nil;
end;

procedure TfraEdicaoChecklistGarantia.pSetFrameCheckList(pTipoCheckList: TTipoCheckList; pFrame: IFrameCheckList);
begin
  if  (pTipoCheckList = TTipoCheckList.Garantia) then
    FFrameChkGar := pFrame
  else if (pTipoCheckList = TTipoCheckList.Troca) then
    FFrameChkTro := pFrame;
end;

procedure TfraEdicaoChecklistGarantia.pSetMaxLengthMmoChkGarConteudo(const intTamanho: Integer);
begin
  mmoChkGarConteudo.Lines.Clear;
  mmoChkGarConteudo.MaxLength := intTamanho;
  pAtualizarContadorCaracteres;
  mmoChkGarConteudo.ReadOnly := mmoChkGarConteudo.MaxLength <= 0;
end;

procedure TfraEdicaoChecklistGarantia.pSetrecItemCklMer(const recItemCklMer: TRecItemCheckListGarantia);
begin
  FrecItemCklMer := recItemCklMer;
  pExibirRecTItemCheckListGarantia;
end;

procedure TfraEdicaoChecklistGarantia.pCriarQryPesq;
begin
  FQryItemChk  := fCriaQuery;
  FQryItemChk.SQL.Add('SELECT * FROM CADCVG WHERE FALSE');
  FQryItemChk.Open;

  FQryItemChk.FieldByName('CVG_CODIGO').DisplayLabel := 'Código';
  FQryItemChk.FieldbyName('CVG_DESCRI').DisplayLabel := 'Descrição';
  FQryItemChk.FieldbyName('CVG_TIPOVG').DisplayLabel := 'Tipo Checklist';
  FQryItemChk.FieldbyName('CVG_TIPORE').DisplayLabel := 'Tipo Resultado';


end;


end.
