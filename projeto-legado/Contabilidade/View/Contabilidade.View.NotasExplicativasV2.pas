unit Contabilidade.View.NotasExplicativasV2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxTextEdit, cxButtonEdit, cxCalc, cxGridBandedTableView,
  cxGridDBBandedTableView, cxCheckBox, EditFocus, cxDropDownEdit, cxLabel,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxButtons, cxMaskEdit,
  cxSpinEdit, cxGroupBox, cxPC, MemoFocus, Vcl.DBCtrls, DBMemoFocus, Vcl.Mask,
  DBEditFocus, untTypesSistema, Datasnap.DBClient, UniClientDataSet, cxBlobEdit,
  cxProgressBar, cxMemo, cxDBEdit;

type
  TfrmNotasExplicativasV2 = class(TfrmPaiContabilidade)
    ControlePaginas: TcxPageControl;
    tsParametros: TcxTabSheet;
    gbBotoes: TcxGroupBox;
    btnIncluir: TcxButton;
    btnGravar: TcxButton;
    btnAlterar: TcxButton;
    btnExcluir: TcxButton;
    btnCancela: TcxButton;
    btnPesquisa: TcxButton;
    tsGeracao: TcxTabSheet;
    gbGeracao: TcxGroupBox;
    cxLabel1: TcxLabel;
    cxLabel2: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    edtNumeroLivro: TcxSpinEdit;
    edtNumeroPaginaInicial: TcxSpinEdit;
    btnGerarDados: TcxButton;
    btnAlterarDados: TcxButton;
    btnGravarDados: TcxButton;
    btnImprimir: TcxButton;
    GridGeracao: TcxGridCitel;
    GridGeracaoLevel: TcxGridLevel;
    gbBotoesGerar: TcxGroupBox;
    btnFecharGeracao: TcxButton;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    cxLabel7: TcxLabel;
    cxLabel8: TcxLabel;
    cxLabel9: TcxLabel;
    edtCodigo: TDBEditFocus;
    edtAnoIni: TDBEditFocus;
    edtAnoFin: TDBEditFocus;
    dsParametros: TDataSource;
    dsGerar: TDataSource;
    edtAnoExercicio: TEditFocus;
    GridGeracaoView: TcxGridDBTableView;
    GridGeracaoViewEXP_CODIGO: TcxGridDBColumn;
    GridGeracaoViewEXP_NOTEXP: TcxGridDBColumn;
    GridGeracaoViewEMP_CODEMP: TcxGridDBColumn;
    GridGeracaoViewEMP_NOMEMP: TcxGridDBColumn;
    edtNotaExplicativa: TcxDBMemo;
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure edtEmpSelKeyPress(Sender: TObject; var Key: Char);
    procedure btnGerarDadosClick(Sender: TObject);
    procedure btnAlterarDadosClick(Sender: TObject);
    procedure btnGravarDadosClick(Sender: TObject);
    procedure btnFecharGeracaoClick(Sender: TObject);
  private
    { Private declarations }
    FModoInsert: boolean;
    cdsParametros: TUniClientDataSet;
    cdsGerar: TUniClientDataSet;
    arrEmpSel: TConsultasArray;
    procedure pBotoesParametros(const AHabilitar: boolean);
    procedure pCarregaDadosParametros(const ACodigo: integer);
    function fGravarParametros: boolean;
    function fDeletarParametros: boolean;
    procedure pBotoesGerar(const AHabilitar:boolean);
    procedure pBotoesGerarNv2(const AHabilitar:boolean);
    function fGerarDados(pgbProgresso: TcxProgressBar):boolean ;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
      strTexto: String);
    function fIsAssignedProgresso(pgbProgresso: TcxProgressBar): boolean;
    function fEmpresasArrToList:TStringList ;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses Contabilidade.Classes.TNotasExplicativasV2, untFuncoesSimples,
     Contabilidade.Consultas, untConsultas, untFuncoesConsulta ;

procedure TfrmNotasExplicativasV2.btnAlterarClick(Sender: TObject);
begin
  inherited;
  if cdsParametros.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Nota explicativa não selecionada!' , ['&Ok']);
    exit ;
  end;
  cdsParametros.Edit ;
  pBotoesParametros(False) ;
  pSetFocus(edtCodigo);
end;

procedure TfrmNotasExplicativasV2.btnAlterarDadosClick(Sender: TObject);
begin
  inherited;

  if not Assigned(cdsGerar) then
  begin
    exit ;
  end;

  if cdsGerar.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Clique em gerar notas explicativas!' , ['&Ok']);
    exit ;
  end;

  pBotoesGerarNv2(False) ;
end;

procedure TfrmNotasExplicativasV2.btnCancelaClick(Sender: TObject);
begin
  inherited;
  FModoInsert := False ;
  cdsParametros.Cancel ;
  pBotoesParametros(True) ;
end;

procedure TfrmNotasExplicativasV2.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if cdsParametros.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Nota explicativa não selecionada!' , ['&Ok']);
    exit ;
  end;

  if fMensagem('ATENÇÃO!', 'Confirma a exclusão da nota explicativa?', ['&Sim', '&Não'], 1) = 2 then
  begin
    Exit;
  end;

  if not fDeletarParametros then
  begin
    exit ;
  end;

  pCarregaDadosParametros(-1) ;
end;

procedure TfrmNotasExplicativasV2.btnFecharGeracaoClick(Sender: TObject);
begin
  inherited;
  cdsGerar.EmptyDataSet ;
  pBotoesGerar(True) ;
  pSetFocus(edtAnoExercicio);
end;

procedure TfrmNotasExplicativasV2.btnGerarDadosClick(Sender: TObject);
begin
  inherited;
  ///valida as informações
  if strtointdef(edtAnoExercicio.Text,0) = 0 then
  begin
    fMensagem('ATENÇÃO!', 'Ano exercício não informado!' , ['&Ok']);
    pSetFocus(edtAnoExercicio);
    exit ;
  end;

  fValidaCampos(edtEmpSel) ;

  Try
    fChamaTelaGravando(fGerarDados) ;
  Except
    On E: Exception Do
    begin
      raise E ;
    end;
  End;

end;

procedure TfrmNotasExplicativasV2.btnGravarClick(Sender: TObject);
begin
  inherited;

  if strtointdef(trim(edtCodigo.Text),0) = 0 then
  begin
    fMensagem('ATENÇÃO!', 'Código não informado!' , ['&Ok']);
    pSetFocus(edtCodigo);
    exit ;
  end;

  if not fGravarParametros then
  begin
    exit ;
  end;
  FModoInsert := False ;
  pBotoesParametros(True) ;

end;

procedure TfrmNotasExplicativasV2.btnGravarDadosClick(Sender: TObject);
begin
  inherited;
  cdsGerar.Edit ;
  cdsGerar.Post ;
  pBotoesGerarNv2(True) ;
end;

procedure TfrmNotasExplicativasV2.btnIncluirClick(Sender: TObject);
begin
  inherited;
  FModoInsert := True ;
  cdsParametros.Append ;
  pBotoesParametros(False) ;
  pSetFocus(edtCodigo);
end;

procedure TfrmNotasExplicativasV2.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrPesq: TConsultasArray;
begin
  chrKey := '/';
  If fPesqNotaExplicativaV2(Self, Nil, Nil, Nil, chrKey, arrPesq, False) Then
  begin
    if Length(arrPesq) > 0 then
    begin
      pCarregaDadosParametros(strToint(arrPesq[0].strCodigo)) ;
      pSetFocus(btnAlterar);
    end;
  end;
end;

procedure TfrmNotasExplicativasV2.edtEmpSelKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpSel, edtNomEmpSel, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpSel) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmNotasExplicativasV2.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDadosParametros(-1) ;
  pBotoesParametros(True) ;
  pBotoesGerarNv2(True) ;
  ControlePaginas.ActivePageIndex := 0 ;
end;

function TfrmNotasExplicativasV2.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  intIndex : integer ;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtEmpSel) Then
    Begin
      if fEmptyStr(edtEmpSel.Text) then
      begin
        SetLength(arrEmpSel,0) ;
        edtNomEmpSel.Clear;
        Result := True;
      end
      else
      Begin
        edtNomEmpSel.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpSel.Text], False);
        If (fEmptyStr(edtNomEmpSel.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        end
        else
        begin
          pDesmarcaLista(edtEmpSel, arrEmpSel);

          If Length(arrEmpSel) > 0 Then
          Begin
            For intIndex := Low(arrEmpSel) To High(arrEmpSel) Do
            Begin
              If Pos(arrEmpSel[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
              Begin
                edtNomEmpSel.Clear;
                fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrEmpSel[intIndex].strCodigo + '!', ['&Ok']);
                Result := False;
                Break;
              End;
            End;
          End
          Else If Not fEmptyStr(edtEmpSel.Text) Then
          Begin
            If Pos(edtEmpSel.Text, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              edtNomEmpSel.Clear;
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&OK']);
              Result := False;
            End;
          End;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmNotasExplicativasV2.pBotoesGerar(const AHabilitar: boolean);
begin
  btnGerarDados.Enabled := AHabilitar ;
  btnAlterarDados.Enabled := not AHabilitar ;
  btnGravarDados.Enabled := False ;
  btnImprimir.Enabled := not AHabilitar ;
  btnFecharGeracao.Enabled := not AHabilitar ;
  /////
  edtAnoExercicio.Enabled := AHabilitar ;
  edtEmpSel.Enabled := AHabilitar ;

end;

procedure TfrmNotasExplicativasV2.pBotoesGerarNv2(const AHabilitar: boolean);
begin
  btnAlterarDados.Enabled := AHabilitar ;
  btnGravarDados.Enabled := Not AHabilitar ;
  btnImprimir.Enabled := AHabilitar ;
  btnFecharGeracao.Enabled := AHabilitar ;
  TcxBlobEditProperties(GridGeracaoViewEXP_NOTEXP.Properties).ReadOnly := AHabilitar ;
end;

procedure TfrmNotasExplicativasV2.pBotoesParametros(
  const AHabilitar: boolean);
begin
  btnIncluir.Enabled  :=  AHabilitar ;
  btnGravar.Enabled   :=  not AHabilitar ;
  btnAlterar.Enabled  :=  AHabilitar ;
  btnExcluir.Enabled  :=  AHabilitar ;
  btnCancela.Enabled  :=  not AHabilitar ;
  btnPesquisa.Enabled :=  AHabilitar ;
end;

procedure TfrmNotasExplicativasV2.pCarregaDadosParametros(
  const ACodigo: integer);
begin

  dsParametros.Enabled := False ;
  dsParametros.DataSet := Nil ;

  TNotasExplicativasParametros.Carregar(ACodigo, cdsParametros) ;

  dsParametros.DataSet := cdsParametros ;
  dsParametros.Enabled := True ;

end;

procedure TfrmNotasExplicativasV2.pSetaTextoProgresso(
  pgbProgresso: TcxProgressBar; strTexto: String);
begin
  if fIsAssignedProgresso(pgbProgresso) then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strTexto;
    Application.ProcessMessages;
  End;
end;

function TfrmNotasExplicativasV2.fGerarDados(
  pgbProgresso: TcxProgressBar): boolean;
var
  objGerar : TNotasExplicativasGerar  ;
  lstEmpresas : TStringList ;
begin
  Result := True;
  pgbProgresso.Properties.Max := 1 ;
  pSetaTextoProgresso(pgbProgresso, 'Gerando Lançamentos: Notas Explicativas ' + edtAnoExercicio.Text);

  dsGerar.Enabled := False ;
  dsGerar.DataSet := Nil ;
  if Assigned(cdsGerar) then
  begin
    FreeAndNil(cdsGerar) ;
  end;


  lstEmpresas := fEmpresasArrToList ;
  objGerar := TNotasExplicativasGerar.Create  ;
  try
    objGerar.AnoExercicio := strtoint(edtAnoExercicio.Text) ;
    objGerar.Empresas.Assign(lstEmpresas);
    cdsGerar := objGerar.Processar ;
    if not Assigned(cdsGerar) then
    begin
      exit ;
    end;

    dsGerar.DataSet := cdsGerar ;
    dsGerar.Enabled := True ;

    pgbProgresso.Position := 1;
    Application.ProcessMessages;

  finally
    FreeAndNil(objGerar) ;
    FreeAndNil(lstEmpresas) ;
  end;
  pBotoesGerar(False) ;

end;

function TfrmNotasExplicativasV2.fGravarParametros: boolean;
begin
  result := TNotasExplicativasParametros.Gravar(cdsParametros, FModoInsert) ;
  if Result then
  begin
    pCarregaDadosParametros(edtCodigo.Field.AsInteger) ;
  end;
end;

function TfrmNotasExplicativasV2.fIsAssignedProgresso(
  pgbProgresso: TcxProgressBar): boolean;
begin
  result := false ;
  if not Assigned(pgbProgresso) then
    exit ;

  if not Assigned(GetParentForm(pgbProgresso).FindComponent('lblGravando')) then
    exit ;

  result := true ;
end;

function TfrmNotasExplicativasV2.fDeletarParametros: boolean;
begin
  result := TNotasExplicativasParametros.Deletar(edtCodigo.Field.AsInteger) ;
end;

function TfrmNotasExplicativasV2.fEmpresasArrToList: TStringList;
var
  intCnt : integer ;
begin
  result := TStringList.Create ;
  if Length(arrEmpSel) = 0 then
  begin
    if not fEmptyStr(edtEmpSel.Text) then
    begin
      SetLength(arrEmpSel, 0);
      SetLength(arrEmpSel, 1);
      arrEmpSel[0].strCodigo := edtEmpSel.Text ;
      result.Add(arrEmpSel[0].strCodigo) ;
    end;
  end
  else
  begin
    for intCnt := Low(arrEmpSel) to High(arrEmpSel) do
    begin
      result.Add(arrEmpSel[intCnt].strCodigo) ;
    end;
  end;
end;

end.
