unit Contabilidade.View.ApuracaoLucroRealLalurLacsAlterar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxCalc, EditFocus,
  cxGroupBox, cxRadioGroup, Data.DB, MemDS, DBAccess, Uni,
  cxCurrencyEdit, CurrencyEditFocus, Contabilidade.Interfaces ;

type
  TfrmApuracaoLucroRealLalurLacsAlterar = class(TfrmPaiConfirmaContabilidade)
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    edtExercicio: TEditFocus;
    edtResultadoAntesCS: TCurrencyEditFocus;
    edtContribuicaoAntesLAIR: TCurrencyEditFocus;
    edtPeriodo: TcxComboBox;
    cxLabel4: TcxLabel;
    cxLabel5: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtExercicioExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtExercicioChange(Sender: TObject);
    procedure edtPeriodoPropertiesChange(Sender: TObject);
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FBlnExercicioAlterado: boolean ;
    FDataInicioApuracao : TDateTime ;
    FDataFinalApuracao : TDateTime ;
    FStrAutoInc : string ;
    FftForma: TFormaTributacao ;
    FecEncerramento: TEncerramentoContabil ;
    function fIndiceByPeriodo(const ADtaPeriodoInicial, ADtaPeriodoFinal: TDateTime): integer ;
    procedure pCalculaResultadoAntesContribuicaoSocial() ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure pAjustaDadosPeriodoParaEdicao(const ADtaPeriodoInicial, ADtaPeriodoFinal: TDateTime);
    property DataInicioApuracao: TDateTime read FDataInicioApuracao ;
    property DataFinalApuracao: TDateTime read FDataFinalApuracao ;
    property AutoInc: string read FStrAutoInc write FStrAutoInc ;
    property FormaTributacao: TFormaTributacao read FftForma ;
    property EncerramentoContabil:TEncerramentoContabil read FecEncerramento ;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, System.Generics.Collections, DateUtils,
     Contabilidade.Classes.ApuracaoLucroRealLalurLacs, untTypesSistema,
     untConsultas ;

{ TfrmApuracaoLucroRealLalurLacsAlterar }

procedure TfrmApuracaoLucroRealLalurLacsAlterar.btnConfirmaClick(
  Sender: TObject);
var
  LDictSelecionado: TDictionary<string, TDateTime> ;
begin
  if not fValidaCampos(edtExercicio) then
  begin
    exit ;
  end;

  if not fValidaCampos(edtPeriodo) then
  begin
    exit ;
  end;

  if not fValidaCampos(edtResultadoAntesCS) then
  begin
    exit ;
  end;

  if not fValidarExercicioInformado(edtExercicio.Text, edtEmpSel.Text, FftForma, FecEncerramento) then
    Exit ;

  if not fValidaCampos(edtEmpSel) then
  begin
    exit ;
  end;

  if FftForma = ftNada then
  begin
    fMensagem('ATENÇÃO!', 'Forma Tributação Inválida!', ['&Ok']);
    pSetFocus(edtExercicio) ;
    exit ;
  end;

  if FecEncerramento = ecNada then
  begin
    fMensagem('ATENÇÃO!', 'Encerramento Contábil Inválido!', ['&Ok']);
    pSetFocus(edtExercicio) ;
    exit ;
  end;

  LDictSelecionado := edtPeriodo.Properties.Items.Objects[edtPeriodo.ItemIndex] as TDictionary<string, TDateTime> ;

  FDataInicioApuracao := LDictSelecionado['inicio'] ;
  FDataFinalApuracao := LDictSelecionado['final'] ;

  if fPeriodoJaCadastrado(FStrAutoInc, edtEmpSel.Text, FDataFinalApuracao)  then
  begin
    fMensagem('ATENÇÃO!', 'Periodo já cadastrado!', ['&Ok']);
    pSetFocus(edtPeriodo) ;
    exit ;
  end;

  ModalResult := mrOK ;
  inherited;
end;

procedure TfrmApuracaoLucroRealLalurLacsAlterar.edtEmpSelKeyPress(
  Sender: TObject; var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmApuracaoLucroRealLalurLacsAlterar.edtExercicioChange(
  Sender: TObject);
begin
  inherited;
  FBlnExercicioAlterado := True ;
end;

procedure TfrmApuracaoLucroRealLalurLacsAlterar.edtExercicioExit(
  Sender: TObject);
begin
  inherited;
  if not FBlnExercicioAlterado then
  begin
    exit ;
  end;

  if not fEmptyStr(TEditFocus(Sender).Text) then
  begin
    if fValidarExercicioInformado(TEditFocus(Sender).Text, edtEmpSel.Text, FftForma, FecEncerramento) then
    begin
      ////cria o periodo de com o parametro.
      pAjustaPeriodoEncerramento(TEditFocus(Sender).Text, FecEncerramento, edtPeriodo) ;
    end
    else
      pLimparPeriodoEncerramento(edtPeriodo) ;
  end
  else
  begin
    pLimparPeriodoEncerramento(edtPeriodo) ;
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacsAlterar.edtPeriodoPropertiesChange(
  Sender: TObject);
begin
  inherited;
  FBlnExercicioAlterado := False ;
  pCalculaResultadoAntesContribuicaoSocial ;
end;

function TfrmApuracaoLucroRealLalurLacsAlterar.fIndiceByPeriodo(
  const ADtaPeriodoInicial, ADtaPeriodoFinal: TDateTime): integer;
var
  LDataInicioApuracao, LDataFinalApuracao: TDateTime ;
  LDictSelecionado: TDictionary<string, TDateTime> ;
  LIntCnt: integer ;
begin
  result := -1 ;
  for LIntCnt := 0 to edtPeriodo.Properties.Items.Count-1 do
  begin
    LDictSelecionado := edtPeriodo.Properties.Items.Objects[LIntCnt] as TDictionary<string, TDateTime> ;
    LDataInicioApuracao := LDictSelecionado['inicio'] ;
    LDataFinalApuracao := LDictSelecionado['final'] ;

    if (ADtaPeriodoInicial >= LDataInicioApuracao) and (ADtaPeriodoFinal <= LDataFinalApuracao) then
    begin
      result := LIntCnt ;
      break ;
    end;

  end;

end;

procedure TfrmApuracaoLucroRealLalurLacsAlterar.FormCreate(Sender: TObject);
begin
  inherited;
  FStrAutoInc := '' ;
  FBlnExercicioAlterado := False ;
  FftForma := ftNada ;
  FecEncerramento := ecNada ;
end;

procedure TfrmApuracaoLucroRealLalurLacsAlterar.FormDestroy(Sender: TObject);
begin
  inherited;
  pLimparPeriodoEncerramento(edtPeriodo) ;
end;

function TfrmApuracaoLucroRealLalurLacsAlterar.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtPeriodo) Then
    Begin
      if edtPeriodo.ItemIndex = -1 then
      begin
        fMensagem('ATENÇÃO!', 'Periodo não selecionado!', ['&Ok']);
        Result := false ;
      end;

    End
    else If (Sender = edtResultadoAntesCS) Then
    begin
      if edtResultadoAntesCS.Value = 0.00 then
      begin
        fMensagem('ATENÇÃO!', 'Resultado Antes da Contribuição Social não informada!', ['&Ok']);
        Result := False ;
      end;

    end
    else If (Sender = edtEmpSel) Then
    begin

      if not fEmptyStr(edtEmpSel.Text) then
      Begin
        edtNomEmpSel.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text], False);
        if fEmptyStr(edtNomEmpSel.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        edtNomEmpSel.Clear;
        edtEmpSel.Clear;
        fMensagem('ATENÇÃO!', 'Empresa deve ser preenchida!', ['&OK']);
        Result := False;
      End;
      pCalculaResultadoAntesContribuicaoSocial ;
    end
    else If (Sender = edtExercicio) Then
    begin
      if fEmptyStr(edtExercicio.text) then
      begin
        fMensagem('ATENÇÃO!', 'Exercício não informado!', ['&Ok']);
        Result := false ;
      end;

    end;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;


procedure TfrmApuracaoLucroRealLalurLacsAlterar.pAjustaDadosPeriodoParaEdicao(const ADtaPeriodoInicial, ADtaPeriodoFinal: TDateTime);
begin
  if fValidarExercicioInformado(edtExercicio.Text, edtEmpSel.Text, FftForma, FecEncerramento) then
  begin
    pAjustaPeriodoEncerramento(edtExercicio.Text, FecEncerramento, edtPeriodo) ;
    ////posiciona o indice do combobox de periodo
    edtPeriodo.ItemIndex := fIndiceByPeriodo(ADtaPeriodoInicial, ADtaPeriodoFinal) ;
    ///
  end ;
end;

procedure TfrmApuracaoLucroRealLalurLacsAlterar.pCalculaResultadoAntesContribuicaoSocial;
var
  LDataInicioApuracao, LDataFinalApuracao: TDateTime ;
  LDictSelecionado: TDictionary<string, TDateTime> ;
  LfltValor: Double ;
begin
  if not edtEmpSel.Enabled then
    Exit ;

  if fEmptyStr(edtEmpSel.Text) then
    Exit ;

  if edtPeriodo.ItemIndex = -1 then
    Exit ;

  LDictSelecionado := edtPeriodo.Properties.Items.Objects[edtPeriodo.ItemIndex] as TDictionary<string, TDateTime> ;
  LDataInicioApuracao := LDictSelecionado['inicio'] ;
  LDataFinalApuracao := LDictSelecionado['final'] ;

  LfltValor := fCarregaResultadoAntesContribuicaoSocial(edtEmpSel.Text, LDataInicioApuracao, LDataFinalApuracao) ;

  edtResultadoAntesCS.Value := LfltValor ;

end;

end.
