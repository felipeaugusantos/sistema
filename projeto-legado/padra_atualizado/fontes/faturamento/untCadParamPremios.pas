unit untCadParamPremios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBGridCitel, EditFocus, Vcl.ComCtrls, DBAccess, Uni, Datasnap.DBClient,
  UniClientDataSet, untParPreController, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;


Type
  TOpcao = (opInclusao, opAlteracao, opExclusao, opCancelamento);

Type
  TfrmCadParamPremios = class(TfrmPai)
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    cdsPremios: TUniClientDataSet;
    dtsPremios: TUniDataSource;
    cdsPremiosAUTOINCREM: TStringField;
    cdsPremiosPRE_CODEMP: TStringField;
    cdsPremiosPRE_VLRFAT: TFloatField;
    cdsPremiosPRE_METATI: TFloatField;
    cdsPremiosPRE_1CSABA: TFloatField;
    cdsPremiosPRE_1CSACI: TFloatField;
    cdsPremiosPRE_2CSACI: TFloatField;
    pnlFundo: TPanel;
    pnlCampos: TPanel;
    lblVlrFat: TLabel;
    edtVlrFat: TEditFocus;
    pnlGrid: TPanel;
    cxgPremios: TcxGrid;
    cxgPremiosView: TcxGridDBTableView;
    cxgPremiosViewVlrFat: TcxGridDBColumn;
    cxgPremiosView1CsAba: TcxGridDBColumn;
    cxgPremiosViewMetAti: TcxGridDBColumn;
    cxgPremiosView1CsAci: TcxGridDBColumn;
    cxgPremiosView2CsAci: TcxGridDBColumn;
    cxgPremiosLevel: TcxGridLevel;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    lbl1CsAba: TLabel;
    edt1CsAba: TEditFocus;
    lblMetAti: TLabel;
    edtMetAti: TEditFocus;
    lbl1CsAci: TLabel;
    edt1CsAci: TEditFocus;
    lbl2CsAci: TLabel;
    edt2CsAci: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cdsPremiosAfterOpen(DataSet: TDataSet);
    procedure cxgPremiosViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    objController: TParPreController;
    objOpcao: TOpcao;
    FParametrizacaoAtualizada: Boolean;

    procedure pBuscaDados;
    procedure pAjustaTela;
    function fExistemDados: Boolean;
    procedure pGravar;
    procedure pExcluir;
    function fConfirmaExclusao: Boolean;
    procedure pAjustaCamposNumericos;
    procedure pLimpaCampos;
    procedure pAjustaDadosCds;
    function fValidaItem: Boolean;
    function fValorJaInserido: Boolean;
    procedure pHabilitaDesabilitaCampos(blnHabilita: Boolean);
    procedure pIncluir;
    procedure pCancelar;
    procedure pAlterar;
    procedure pPreencheCampos;
    function fTrataAlteracaoCds: Boolean;
    function fRegistroSelecionado: Boolean;
    { Private declarations }
  public
    { Public declarations }
    property ParametrizacaoAtualizada: Boolean read FParametrizacaoAtualizada write FParametrizacaoAtualizada;
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untGravando;

{$R *.dfm}

procedure TfrmCadParamPremios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pAlterar;
end;

procedure TfrmCadParamPremios.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCancelar;
end;

procedure TfrmCadParamPremios.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pExcluir;
end;

procedure TfrmCadParamPremios.btnGravarClick(Sender: TObject);
begin
  inherited;
  pGravar;
end;

procedure TfrmCadParamPremios.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pIncluir;
end;

procedure TfrmCadParamPremios.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCadParamPremios.cdsPremiosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  pAjustaCamposNumericos;
end;

procedure TfrmCadParamPremios.cxgPremiosViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: Close;
  End;
end;

procedure TfrmCadParamPremios.pAjustaCamposNumericos;
begin
  TFloatField(cdsPremios.FieldByName('PRE_VLRFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPremios.FieldByName('PRE_METATI')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPremios.FieldByName('PRE_1CSABA')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPremios.FieldByName('PRE_1CSACI')).DisplayFormat := '#,##0.00';
  TFloatField(cdsPremios.FieldByName('PRE_2CSACI')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadParamPremios.pLimpaCampos;
begin
  edtVlrFat.Text := '0,00';
  edtMetAti.Text := '0,00';
  edt1CsAba.Text := '0,00';
  edt1CsAci.Text := '0,00';
  edt2CsAci.Text := '0,00';
end;

function TfrmCadParamPremios.fValidaItem: Boolean;
begin
  Result := False;

  If (fValorJaInserido) Then
  Begin
    fMensagem('ATENÇÃO!', 'Valor de Faturamento já informado', ['&Ok']);
    pSetFocus(edtVlrFat);
    Exit;
  End;

  If (Not fVerificaCampos) Then
    Exit;

  Result := True;
end;

function TfrmCadParamPremios.fValorJaInserido: Boolean;
  Var
    intRecNo: Integer;
begin
  Result := False;
  intRecNo := cdsPremios.RecNo;

  If (objOpcao = opAlteracao) And (cdsPremios.FieldByName('PRE_VLRFAT').AsFloat = fStrToFloat(edtVlrFat.Text)) Then
    Exit;

  If (Not cdsPremios.Locate('PRE_VLRFAT', fStrToFloat(edtVlrFat.Text), [])) Then
    Exit;

  cdsPremios.RecNo := intRecNo;
  Result := True;
end;

function TfrmCadParamPremios.fConfirmaExclusao: Boolean;
begin
  Result := fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1;
end;

procedure TfrmCadParamPremios.FormCreate(Sender: TObject);
begin
  inherited;
  objController := TParPreController.Create;
  TfrmGravando.fExecutarModal(pBuscaDados, 'Aguarde, Carregando dados...', '');
  pCancelar;
  FParametrizacaoAtualizada := False;
end;

procedure TfrmCadParamPremios.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objController);
end;

procedure TfrmCadParamPremios.pIncluir;
begin
  objOpcao := opInclusao;
  pAjustaTela;
end;

procedure TfrmCadParamPremios.pCancelar;
begin
  objOpcao := opCancelamento;
  pAjustaTela;
  cxgPremios.Enabled := True;
end;

procedure TfrmCadParamPremios.pAlterar;
begin
  If (Not fRegistroSelecionado) Then
    Exit;

  pPreencheCampos;
  objOpcao := opAlteracao;
  pAjustaTela;
  cxgPremios.Enabled := False;
end;

function TfrmCadParamPremios.fRegistroSelecionado: Boolean;
begin
  Result := False;

  If (cxgPremiosView.controller.SelectedRowCount <= 0) Then
  Begin
    fMensagem('', 'Selecione um registro para continuar', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

procedure TfrmCadParamPremios.pAjustaDadosCds;
begin
  Case (objOpcao) Of
    opAlteracao: cdsPremios.Edit;
    opInclusao: cdsPremios.Append;
  End;

  cdsPremios.FieldByName('PRE_CODEMP').AsString := VS_strCodEmp;
  cdsPremios.FieldByName('PRE_VLRFAT').AsFloat  := fStrToFloat(edtVlrFat.Text);
  cdsPremios.FieldByName('PRE_METATI').AsFloat  := fStrToFloat(edtMetAti.Text);
  cdsPremios.FieldByName('PRE_1CSABA').AsFloat  := fStrToFloat(edt1CsAba.Text);
  cdsPremios.FieldByName('PRE_1CSACI').AsFloat  := fStrToFloat(edt1CsAci.Text);
  cdsPremios.FieldByName('PRE_2CSACI').AsFloat  := fStrToFloat(edt2CsAci.Text);
  cdsPremios.Post;
end;

procedure TfrmCadParamPremios.pPreencheCampos;
begin
  edtVlrFat.Text := FloatToStr(cdsPremios.FieldByName('PRE_VLRFAT').AsFloat);
  edtMetAti.Text := FloatToStr(cdsPremios.FieldByName('PRE_METATI').AsFloat);
  edt1CsAba.Text := FloatToStr(cdsPremios.FieldByName('PRE_1CSABA').AsFloat);
  edt1CsAci.Text := FloatToStr(cdsPremios.FieldByName('PRE_1CSACI').AsFloat);
  edt2CsAci.Text := FloatToStr(cdsPremios.FieldByName('PRE_2CSACI').AsFloat);
end;

procedure TfrmCadParamPremios.pBuscaDados;
begin
  objController.pCarregaLista(VS_strCodEmp, cdsPremios);
end;

procedure TfrmCadParamPremios.pAjustaTela;
begin
  Case (objOpcao) Of
    opInclusao, opAlteracao:
    Begin
      btnIncluir.Enabled := False;
      btnExcluir.Enabled := False;
      btnAlterar.Enabled := False;
      btnCancela.Enabled := True;
      btnGravar.Enabled  := True;

      pHabilitaDesabilitaCampos(True);
      pSetFocus(edtVlrFat);
    End;
    opCancelamento:
    Begin
      btnIncluir.Enabled := True;
      btnExcluir.Enabled := True;
      btnAlterar.Enabled := True;
      btnCancela.Enabled := False;
      btnGravar.Enabled  := False;

      pHabilitaDesabilitaCampos(False);
      pLimpaCampos;
      pSetFocus(btnIncluir);
    End;
  End;
end;

procedure TfrmCadParamPremios.pHabilitaDesabilitaCampos(blnHabilita: Boolean);
begin
  edtVlrFat.Enabled := blnHabilita;
  edt1CsAba.Enabled := blnHabilita;
  edtMetAti.Enabled := blnHabilita;
  edt1CsAci.Enabled := blnHabilita;
  edt2CsAci.Enabled := blnHabilita;
end;

function TfrmCadParamPremios.fExistemDados: Boolean;
begin
  Result := (Not cdsPremios.IsEmpty) And (cdsPremios.RecordCount > 0);
end;

function TfrmCadParamPremios.fTrataAlteracaoCds: Boolean;
begin
  Result := False;

  If (objOpcao in [opCancelamento, opExclusao]) Then
    Exit(True);

  If (Not fValidaItem) Then
    Exit;

  pAjustaDadosCds;

  Result := True;
end;

procedure TfrmCadParamPremios.pGravar;
begin
  Try
    If (Not fTrataAlteracaoCds) Then
      Exit;

    If (Not fExistemDados) Then
    Begin
      fMensagem('', 'Não existem dados para gravação', ['&Ok']);
      Exit;
    End;

    If (Not objController.fGravarColecao(cdsPremios, VS_strCodEmp)) Then
      Exit;

    pCancelar;
    FParametrizacaoAtualizada := True;
    TfrmGravando.fExecutarModal(pBuscaDados, 'Aguarde, atualizando dados...', '');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pGravar]');
    End;
  End;
end;

procedure TfrmCadParamPremios.pExcluir;
begin
  If (Not fRegistroSelecionado) Or (Not fConfirmaExclusao) Then
    Exit;

  Try
    If (objController.fDeletar(cdsPremios.FieldByName('AUTOINCREM').AsString)) Then
      cdsPremios.Delete;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pExcluir]');
    End;
  End;
end;

function TfrmCadParamPremios.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtVlrFat) Then
    Begin
      If (fStrToFloat(edtVlrFat.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!','Valor de Faturamento deve ser maior que 0',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtMetAti) Then
    Begin
      If (fStrToFloat(edtMetAti.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!','Prêmio para Meta Atingida deve ser maior ou igual a 0',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edt1CsAba) Then
    Begin
      If (fStrToFloat(edt1CsAba.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!','Prêmio para 1 Casa Abaixo deve ser maior ou igual a 0',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edt1CsAci) Then
    Begin
      If (fStrToFloat(edt1CsAci.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!','Prêmio para Meta 1 Casa Acima deve ser maior ou igual a 0',['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edt2CsAci) Then
    Begin
      If (fStrToFloat(edt2CsAci.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!','Prêmio para Meta 2 Casas Acima deve ser maior ou igual a 0',['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
