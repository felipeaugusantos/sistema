unit untComissaoDepartamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  UniClientDataSet, DBAccess, Uni, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  EditFocus, untComDepController, untComDep, untDepTabController, untDepTab,
  ComboBoxFocus;

type
  TfrmComissaoDepartamento = class(TfrmPaiCad)
    pnlCabecalho: TPanel;
    pnlCamposItens: TPanel;
    pnlItens: TPanel;
    pnlLegendas: TPanel;
    cdsDepTab: TUniClientDataSet;
    dtsDepTab: TUniDataSource;
    dbgDepTab: TDBGridCitel;
    lblCodCom: TLabel;
    lblDesCom: TLabel;
    lblCodDep: TLabel;
    lblFatIni: TLabel;
    lblFatFin: TLabel;
    edtCodCom: TEditFocus;
    edtDesCom: TEditFocus;
    edtCodDep: TEditFocus;
    edtFatIni: TEditFocus;
    edtFatFin: TEditFocus;
    edtPerCom: TEditFocus;
    lblTabPre: TLabel;
    lblPerCom: TLabel;
    lblLegenda: TLabel;
    cdsDepTabDTB_CODTAB: TStringField;
    cdsDepTabDTB_PERCOM: TFloatField;
    cmbTabPre: TComboBoxFocus;
    cdsDepTabAUTOINCREM: TStringField;
    cdsDepTabDTB_CODCOM: TStringField;
    edtDesDep: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure dbgDepTabDblClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbgDepTabKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsDepTabAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    objComDepController: TComDepController;
    objDepTabController: TDepTabController;
    objComDep: TComDep;
    blnEdicaoItem: Boolean;
    procedure pPesquisaComissao;
    procedure pPreencheCamposCabecalho(objComDep: TComDep);
    procedure pCarregaTabelaDePreco;
    function fJaExisteTabelaPreco: Boolean;
    function fValidaItem: Boolean;
    procedure pInsereItem;
    procedure pPreencheCdsDepTab;
    function fValidaDados: Boolean;
    function fValidaCabecalhoInclusao: Boolean;
    function fValidaItens: Boolean;
    procedure pGravar;
    procedure pLimpaCamposItens;
    function fJaExisteFaixaDeFaturamento: Boolean;
    procedure pPreencheCodComItens;
    procedure pPreencheObjComDep;
    procedure pLimpaCampos;
    function fConfirmaExclusao: Boolean;
    procedure pExcluiRegistro;
    procedure pPreencheCamposEdicao;
    function fEscolheuRegistro: Boolean;
    function fComissaoAtualJaExistente: Boolean;
    function fCodigoJaCadastrado: Boolean;
  public
    { Public declarations }
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

uses
  untConsultas, untTypesSistema, untFuncoesSimples;

{$R *.dfm}

procedure TfrmComissaoDepartamento.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  pInsereItem;
  pLimpaCamposItens;
  pSetFocus(cmbTabPre);
end;

procedure TfrmComissaoDepartamento.btnAlterarClick(Sender: TObject);
begin
  If (Not fEscolheuRegistro) Then
    Exit;

  btnConfirmar.Enabled := True;
  dbgDepTab.Enabled := True;
  qryTabela.Edit;

  If blnChangeEnabledButton Then
    pOnStateChange;

  pEnabled(Self, True);
  edtCodCom.Enabled := False;
end;

procedure TfrmComissaoDepartamento.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

procedure TfrmComissaoDepartamento.btnExcluirClick(Sender: TObject);
begin
  If (Not fEscolheuRegistro) Then
    Exit;

  If (fConfirmaExclusao) Then
  Begin
    pExcluiRegistro;
    btnCancela.Click;
  End;
end;

procedure TfrmComissaoDepartamento.btnGravarClick(Sender: TObject);
begin
  If (fValidaDados) Then
  Begin
    pPreencheCodComItens;
    pPreencheObjComDep;
    pGravar;
    btnCancela.Click;
  End;
end;

procedure TfrmComissaoDepartamento.btnIncluirClick(Sender: TObject);
begin
  btnCancela.Click;
  inherited;
  btnConfirmar.Enabled := True;
  dbgDepTab.Enabled := True;
  edtCodCom.Enabled := True;
end;

procedure TfrmComissaoDepartamento.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  pPesquisaComissao;
end;

function TfrmComissaoDepartamento.fEscolheuRegistro: Boolean;
begin
  Result := False;

  If (Not fComissaoAtualJaExistente) Then
  Begin
    fMensagem('ATENÇÃO!', 'Favor escolher um registro para essa operação', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

procedure TfrmComissaoDepartamento.cdsDepTabAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(cdsDepTab.FieldByName('DTB_PERCOM')).DisplayFormat := '#,##0.00';
end;

procedure TfrmComissaoDepartamento.dbgDepTabDblClick(Sender: TObject);
begin
  inherited;
  pPreencheCamposEdicao;
end;

procedure TfrmComissaoDepartamento.dbgDepTabKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE:
      If btnGravar.Enabled Then
      Begin
        If (fConfirmaExclusao) Then
          cdsDepTab.Delete;
      End;
    VK_ESCAPE: btnCancela.Click;
  End;
end;

procedure TfrmComissaoDepartamento.pLimpaCamposItens;
begin
  cmbTabPre.ItemIndex := -1;
  edtPerCom.Text := '';
  blnEdicaoItem := False;
end;

function TfrmComissaoDepartamento.fConfirmaExclusao: Boolean;
begin
  Result := fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1;
end;

procedure TfrmComissaoDepartamento.pPreencheCamposEdicao;
begin
  If (cdsDepTab.RecordCount <= 0) Then
    Exit;

  cmbTabPre.ItemIndex := cdsDepTab.FieldByName('DTB_CODTAB').AsInteger - 1;
  edtPerCom.Text := cdsDepTab.FieldByName('DTB_PERCOM').AsString;

  pSetFocus(edtPerCom);
  blnEdicaoItem := True;
end;

procedure TfrmComissaoDepartamento.pLimpaCampos;
begin
  edtCodCom.Text := '';
  edtDesCom.Text := '';
  edtCodDep.Text := '';
  edtDesDep.Text := '';
  edtFatIni.Text := '';
  edtFatFin.Text := '';
  cdsDepTab.EmptyDataSet;
  objComDep := Nil;
  pLimpaCamposItens;
  btnConfirmar.Enabled := False;
  dbgDepTab.Enabled := False;
end;

procedure TfrmComissaoDepartamento.pInsereItem;
begin
  If (Not fValidaItem) Then
    Exit;

  pPreencheCdsDepTab;
end;

procedure TfrmComissaoDepartamento.pPreencheCdsDepTab;
begin
  If (blnEdicaoItem) Then
    cdsDepTab.Edit
  Else
    cdsDepTab.Append;

  cdsDepTab.FieldByName('DTB_CODTAB').AsString := cmbTabPre.Text;
  cdsDepTab.FieldByName('DTB_PERCOM').AsFloat := fStrToFloat(edtPerCom.Text);
  cdsDepTab.Post;
end;

function TfrmComissaoDepartamento.fValidaItem: Boolean;
begin
  Result := False;

  If (Not fValidaCampos(edtPerCom)) Then
    Exit;

  If (Not fValidaCampos(cmbTabPre)) Then
    Exit;

  If (Not blnEdicaoItem) And (fJaExisteTabelaPreco) Then
  Begin
    fMensagem('ATENÇÃO!', 'Tabela de preço já informada', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

function TfrmComissaoDepartamento.fJaExisteTabelaPreco: Boolean;
begin
  Result := (cdsDepTab.Locate('DTB_CODTAB', fStrToFloat(cmbTabPre.Text), []));
end;

procedure TfrmComissaoDepartamento.pCarregaTabelaDePreco;
  Var
    intCont: Integer;
begin
  cmbTabPre.Clear;

  For intCont := 1 To Length(VS_strTabVen) Do
  Begin
    If (VS_strTabVen[intCont] = 'S' ) Then
      cmbTabPre.Items.Add(intToStr(intCont));
  End;

  cmbTabPre.ItemIndex := -1;
end;

procedure TfrmComissaoDepartamento.pPesquisaComissao;
  Var
    arrComissao: TConsultasArray;
    strAutInc: String;
begin
  Try
    If fPesqComissaoDepartamento(Self, strAutInc, Nil, arrComissao, True) Then
    Begin
      objComDep := objComDepController.fBuscarPorAutoIncremento(strAutInc);

      pPreencheCamposCabecalho(objComDep);
      objDepTabController.pCarregaLista(objComDep.getCodCom, cdsDepTab);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmComissaoDepartamento.pPesquisaComissao]');
    End;
  End;
end;

procedure TfrmComissaoDepartamento.pPreencheCamposCabecalho(objComDep: TComDep);
begin
  edtCodCom.Text := objComDep.getCodCom;
  edtDesCom.Text := objComDep.getDesCom;
  edtCodDep.Text := objComDep.getCodDep;
  edtDesDep.Text := fRetDescDepartamento(edtCodDep.Text);
  edtFatIni.Text := FloatToStr(objComDep.getFatIni);
  edtFatFin.Text := FloatToStr(objComDep.getFatFin);
end;

procedure TfrmComissaoDepartamento.pPreencheObjComDep;
begin
  objComDep := objComDep.getInstance('', edtCodCom.Text, edtDesCom.Text, edtCodDep.Text,
    fStrToFloat(edtFatIni.Text), fStrToFloat(edtFatFin.Text));
end;

function TfrmComissaoDepartamento.fComissaoAtualJaExistente: Boolean;
begin
  Result := (objComDep <> Nil) And (Not fEmptyStr(objComDep.getAutInc));
end;

procedure TfrmComissaoDepartamento.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmComissaoDepartamento.FormCreate(Sender: TObject);
begin
  inherited;

  objComDepController := TComDepController.Create;
  objDepTabController := TDepTabController.Create;
  objComDep := Nil;
  blnEdicaoItem := False;
  pCarregaTabelaDePreco;
end;

procedure TfrmComissaoDepartamento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objComDepController);
  FreeAndNil(objDepTabController);
  FreeAndNil(objComDep);
end;

procedure TfrmComissaoDepartamento.FormShow(Sender: TObject);
begin
  strNomeTabela := 'COMDEP';
  strNomeCampo  := 'COM_CODCOM';
  qryTabela     := fCriaQuery(Self);
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := edtCodCom;
  inherited;
end;

procedure TfrmComissaoDepartamento.pInicializaIndices;
Begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
End;

function TfrmComissaoDepartamento.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodCom) Then
    Begin
      If (fEmptyStr(edtCodCom.Text)) And (edtCodCom.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtDesCom) Then
    Begin
      If fEmptyStr(edtDesCom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodDep) Then
    Begin
      If (fEmptyStr(edtCodDep.Text)) Then
      Begin
        edtDesDep.Text := '';
        fMensagem('ATENÇÃO!','O Código do Departamento deve ser preenchido',['&OK']);
        Result := False;
      End
      Else
      Begin
        edtDesDep.Text := fRetDescDepartamento(edtCodDep.Text);
        If fEmptyStr(edtDesDep.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse departamento não está cadastrado',['&OK']);
          Result := False;
        End
      End;
    End
    Else If (Sender = edtFatIni) Then
    Begin
      If (fStrToFloat(edtFatIni.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Faturamento Inicial deve ser maior que zero', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtFatFin) Then
    Begin
      If (fStrToFloat(edtFatFin.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Faturamento Final deve ser maior que zero', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatIni.Text) > fStrToFloat(edtFatFin.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Faturamento Final deve ser maior que o Faturamento Inicial', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtPerCom) Then
    Begin
      If (fStrToFloat(edtPerCom.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O % de Comissão deve ser maior ou igual a zero', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = cmbTabPre) Then
    Begin
      If (cmbTabPre.ItemIndex < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Tabela de Preço deve ser informada', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmComissaoDepartamento.fValidaDados: Boolean;
begin
  Result := False;

  If (Not fVerificaCampos) Then
    Exit;

  If (Not fValidaCabecalhoInclusao) Then
    Exit;

  If (Not fValidaItens) Then
    Exit;

  Result := True;
end;

function TfrmComissaoDepartamento.fValidaCabecalhoInclusao: Boolean;
begin
  Result := False;

  If (fComissaoAtualJaExistente) Then
    Exit(True);

  If (fCodigoJaCadastrado) Then
    Exit;

  If (fJaExisteFaixaDeFaturamento) Then
    Exit;

  Result := True;
end;

function TfrmComissaoDepartamento.fValidaItens: Boolean;
begin
  Result := False;

  If (cdsDepTab.RecordCount <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para prosseguir com a gravação, informe a(s) tabela(s) de preço(s)'+#13+
                          'com seu respectivo percentual de comissão', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

procedure TfrmComissaoDepartamento.pPreencheCodComItens;
begin
  cdsDepTab.First;

  While (Not cdsDepTab.Eof) Do
  Begin
    cdsDepTab.Edit;
    cdsDepTab.FieldByName('DTB_CODCOM').AsString := edtCodCom.Text;
    cdsDepTab.Post;
    cdsDepTab.Next;
  End;
end;

function TfrmComissaoDepartamento.fCodigoJaCadastrado: Boolean;
begin
  Result := True;

  Try
    If (objComDepController.fExisteCodigo(edtCodCom.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Já existe uma comissão com este código', ['&Ok']);
      pSetFocus(edtCodCom);
      Exit;
    End;

    Result := False;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmComissaoDepartamento.fCodigoJaCadastrado]');
    End;
  End;
end;

function TfrmComissaoDepartamento.fJaExisteFaixaDeFaturamento: Boolean;
begin
  Result := True;

  Try
    If (objComDepController.fExisteFaixaDeFaturamento(edtCodDep.Text,
      fStrToFloat(edtFatIni.Text), fStrToFloat(edtFatFin.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Já existe uma comissão com este departamento e faixa de faturamento', ['&Ok']);
      pSetFocus(edtCodDep);
      Exit;
    End;

    Result := False;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmComissaoDepartamento.fJaExisteFaixaDeFaturamento]');
    End;
  End;
end;

procedure TfrmComissaoDepartamento.pGravar;
  Var
    blnGravou: Boolean;
begin
  Try
    blnGravou := objComDepController.fGravar(objComDep) And
      objDepTabController.fGravar(cdsDepTab, objComDep.getCodCom);

    If (blnGravou) Then
      fMensagem('ATENÇÃO!', 'Dados gravados com sucesso', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmComissaoDepartamento.pGravar]');
    End;
  End;
end;

procedure TfrmComissaoDepartamento.pExcluiRegistro;
  Var
    blnExcluiu: Boolean;
begin
  Try
    blnExcluiu := (objDepTabController.fDeletarColecao(objComDep.getCodCom)) And
      (objComDepController.fDeletar(objComDep.getAutInc));

    If (blnExcluiu) Then
      fMensagem('ATENÇÃO!', 'Dados deletados com sucesso', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmComissaoDepartamento.pExcluiRegistro]');
    End;
  End;
end;

end.
