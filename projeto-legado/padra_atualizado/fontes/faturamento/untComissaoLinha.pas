unit untComissaoLinha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Data.DB, Datasnap.DBClient,
  UniClientDataSet, DBAccess, Uni, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  Vcl.StdCtrls, ComboBoxFocus, EditFocus, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem,
  Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, untLinMetController, untComLin,
  untComLinController, untTypesSistema;

type
  TfrmComissaoLinha = class(TfrmPaiCad)
    pnlCabecalho: TPanel;
    lblCodVen: TLabel;
    edtCodVen: TEditFocus;
    edtDesVen: TEditFocus;
    pnlCamposItens: TPanel;
    lblPerFat: TLabel;
    edtPerFat: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    pnlItens: TPanel;
    dbgLinMet: TDBGridCitel;
    pnlLegendas: TPanel;
    lblLegenda: TLabel;
    dtsLinMet: TUniDataSource;
    cdsLinMet: TUniClientDataSet;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    lblEmp: TLabel;
    edtPerMix: TEditFocus;
    lblPerMix: TLabel;
    edtPerMar: TEditFocus;
    lblPerMar: TLabel;
    lblLinha: TLabel;
    mskCodLin: TMaskEditFocus;
    edtDesLin: TEditFocus;
    lblVlrMet: TLabel;
    edtVlrMet: TEditFocus;
    cdsLinMetAUTOINCREM: TStringField;
    cdsLinMetLMT_CODLIN: TStringField;
    cdsLinMetLMT_VLRMET: TFloatField;
    cdsLinMetLMT_PERFAT: TFloatField;
    cdsLinMetLMT_PERMIX: TFloatField;
    cdsLinMetLMT_PERMAR: TFloatField;
    btnHeranca: TBitBtnLocked;
    cdsLinMetLMT_COMLIN: TStringField;
    lblPorcentagem: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    cdsLinMetLMT_DESLIN: TStringField;
    procedure mskCodLinKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure cdsLinMetAfterOpen(DataSet: TDataSet);
    procedure dbgLinMetDblClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgLinMetKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnHerancaClick(Sender: TObject);
    procedure mskCodLinExit(Sender: TObject);
    procedure cdsLinMetCalcFields(DataSet: TDataSet);
    procedure edtCodVenExit(Sender: TObject);
  private
    blnEdicaoItem: Boolean;
    arrLinhas: TConsultasArray;
    arrVendedor: TConsultasArray;
    objComLin: TComLin;
    objComLinController: TComLinController;
    objLinMetController: TLinMetController;

    function fComissaoAtualJaExistente: Boolean;
    function fConfirmaExclusao: Boolean;
    function fEscolheuRegistro: Boolean;
    function fJaExisteComissaoParaVendedorEmpresa: Boolean;
    function fLinhaJaInserida: Boolean;
    function fValidaCabecalhoInclusao: Boolean;
    function fValidaDados: Boolean;
    function fValidaItem: Boolean;
    function fValidaItens: Boolean;
    procedure pExcluiRegistro;
    function fGravar: Boolean;
    procedure pLimpaCampos;
    procedure pLimpaCamposItens;
    procedure pPesquisaComissao;
    procedure pPreencheCamposCabecalho(objComLin: TComLin);
    procedure pPreencheCamposEdicao;
    procedure pPreencheCdsLinMet;
    procedure pPreencheObjComLin(strCodVen: String);
    procedure pPreencheComLinItens(strAutInc: String);
    procedure pExecutaHeranca;
    procedure pLimpaDadosPessoaisHerdados;
    procedure pCarregaDadosHeranca(strCodVen: String);
    function fValidaCampoValor(strNome: String; edtCampo: TEditFocus): Boolean;
    function fValidaCamposNumericos: Boolean;
    function fLinhaFormatada(strCodLin: String): String;
    function fFormataCodigoLinha(strCodLin: String): String;
    { Private declarations }
  public
    { Public declarations }
  protected
    function  fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  end;

implementation

uses
  untConsultas, untFuncoesSimples, untHerancaOperador, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmComissaoLinha.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If (Not fValidaItem) Then
    Exit;

  pPreencheCdsLinMet;
  pLimpaCamposItens;
  pSetFocus(mskCodLin);
end;

procedure TfrmComissaoLinha.btnAlterarClick(Sender: TObject);
begin
  If (Not fEscolheuRegistro) Then
    Exit;

  btnConfirmar.Enabled := True;
  dbgLinMet.Enabled := True;
  qryTabela.Edit;

  If blnChangeEnabledButton Then
    pOnStateChange;

  pEnabled(Self, True);
  pSetFocus(dbgLinMet);
end;

procedure TfrmComissaoLinha.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;
end;

procedure TfrmComissaoLinha.btnExcluirClick(Sender: TObject);
begin
  If (Not fEscolheuRegistro) Then
    Exit;

  If (fConfirmaExclusao) Then
  Begin
    pExcluiRegistro;
    btnCancela.Click;
  End;
end;

procedure TfrmComissaoLinha.btnGravarClick(Sender: TObject);
  Var
    intIndex : Integer;
begin
  If (fValidaDados) Then
  Begin
    fStartTransaction;
    Try
      For intIndex := 0 To Pred(Length(arrVendedor)) Do
      Begin
        pPreencheObjComLin(arrVendedor[intIndex].strCodigo);
        If (Not fGravar) Then
        Begin
          fRollBack;
          Exit;
        End;

        objComLin := Nil;
      End;

      fCommit;

      fMensagem('ATENÇÃO!', 'Dados gravados com sucesso', ['&Ok']);
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmComissaoLinha.btnGravarClick]');
      End;
    End;
    btnCancela.Click;
  End;
end;

procedure TfrmComissaoLinha.btnHerancaClick(Sender: TObject);
begin
  inherited;
  pExecutaHeranca;
end;

procedure TfrmComissaoLinha.pExecutaHeranca;
  Var
    frmHeranca: TfrmHerancaOperador;
begin
  pCriarFormularios(TfrmHerancaOperador, frmHeranca);

  Try
    Try
      frmHeranca.Caption := 'Herança de Comissão por Linha do Produto';
      frmHeranca.lblOperador.Caption := 'Vendedor';

      If (frmHeranca.ShowModal = mrOk) Then
        pCarregaDadosHeranca(frmHeranca.getCodOpe);

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmComissaoLinha.pExecutaHeranca]');
    End;
  Finally
    pFreeAndNil(frmHeranca);
  End;
end;

procedure TfrmComissaoLinha.pCarregaDadosHeranca(strCodVen: String);
  Var
    objHeranca: TComLin;
begin
  Try
    objHeranca := objComLinController.fBuscaPorVendedorEmpresa(Vs_strCodEmp, strCodVen);

    If (Not Assigned(objHeranca)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não foi encontrada Comissão para este Vendedor', ['&Ok']);
      pSetFocus(edtCodVen);
      Exit;
    End;

    pPreencheCamposCabecalho(objHeranca);
    objLinMetController.pCarregaLista(objHeranca.getAutInc, cdsLinMet);
    pLimpaDadosPessoaisHerdados;
  Finally
    FreeAndNil(objHeranca);
  End;
end;

procedure TfrmComissaoLinha.pLimpaDadosPessoaisHerdados;
begin
  edtCodVen.Text := '';
  edtDesVen.Text := '';

  cdsLinMet.First;

  While (Not cdsLinMet.Eof) Do
  Begin
    cdsLinMet.Edit;
    cdsLinMet.FieldByName('LMT_COMLIN').AsString := '';
    cdsLinMet.FieldByName('AUTOINCREM').AsString := '';
    cdsLinMet.Post;
    cdsLinMet.Next;
  End;
end;

function TfrmComissaoLinha.fLinhaFormatada(strCodLin: String): String;
  Var
    strLinha: String;
begin
  strLinha := fFormataCodigoLinha(strCodLin);
  Result := strLinha + ' - ' + fRetNomeLinhaGrupo(strCodLin);
end;

function TfrmComissaoLinha.fFormataCodigoLinha(strCodLin: String): String;
begin
  Result := Format('%3.3s.%3.3s', [Copy(strCodLin, 1, 3), Copy(strCodLin, 4, 3)]);
end;

procedure TfrmComissaoLinha.btnIncluirClick(Sender: TObject);
begin
  btnCancela.Click;
  inherited;
  btnConfirmar.Enabled := True;
  dbgLinMet.Enabled := True;
  btnHeranca.Enabled := True;
end;

procedure TfrmComissaoLinha.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  pPesquisaComissao;
end;

function TfrmComissaoLinha.fEscolheuRegistro: Boolean;
begin
  Result := False;

  If (Not fComissaoAtualJaExistente) Then
  Begin
    fMensagem('ATENÇÃO!', 'Favor escolher um registro para essa operação', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

procedure TfrmComissaoLinha.cdsLinMetAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(cdsLinMet.FieldByName('LMT_PERFAT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsLinMet.FieldByName('LMT_PERMIX')).DisplayFormat := '#,##0.00';
  TFloatField(cdsLinMet.FieldByName('LMT_PERMAR')).DisplayFormat := '#,##0.00';
  TFloatField(cdsLinMet.FieldByName('LMT_VLRMET')).DisplayFormat := '#,##0.00';
end;

procedure TfrmComissaoLinha.cdsLinMetCalcFields(DataSet: TDataSet);
begin
  inherited;
  Try
    DataSet.FieldByName('LMT_DESLIN').AsString := fLinhaFormatada(DataSet.FieldByName('LMT_CODLIN').AsString);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmComissaoLinha.pPesquisaComissao]');
    End;
  End;
end;

procedure TfrmComissaoLinha.dbgLinMetDblClick(Sender: TObject);
begin
  inherited;
  pPreencheCamposEdicao;
end;

procedure TfrmComissaoLinha.dbgLinMetKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE:
      If btnGravar.Enabled Then
      Begin
        If (fConfirmaExclusao) Then
          cdsLinMet.Delete;
      End;
    VK_ESCAPE: btnCancela.Click;
    VK_RETURN: dbgLinMetDblClick(dbgLinMet);
  End;
end;

procedure TfrmComissaoLinha.pLimpaCamposItens;
begin
  mskCodLin.Text := '';
  edtDesLin.Text := '';
  edtPerFat.Text := '0,00';
  edtPerMix.Text := '0,00';
  edtPerMar.Text := '0,00';
  edtVlrMet.Text := '0,00';
  blnEdicaoItem := False;
  mskCodLin.Enabled := True;
  dbgLinMet.Enabled := True;
end;

function TfrmComissaoLinha.fConfirmaExclusao: Boolean;
begin
  Result := fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1;
end;

procedure TfrmComissaoLinha.pPreencheCamposEdicao;
begin
  If (cdsLinMet.RecordCount <= 0) Then
    Exit;

  mskCodLin.Text := cdsLinMet.FieldByName('LMT_CODLIN').AsString;
  edtDesLin.Text := fRetNomeLinhaGrupo(mskCodLin.Text);
  edtPerFat.Text := FormatFloat('#,##0.00', cdsLinMet.FieldByName('LMT_PERFAT').AsFloat);
  edtPerMix.Text := FormatFloat('#,##0.00', cdsLinMet.FieldByName('LMT_PERMIX').AsFloat);
  edtPerMar.Text := FormatFloat('#,##0.00', cdsLinMet.FieldByName('LMT_PERMAR').AsFloat);
  edtVlrMet.Text := FormatFloat('#,##0.00', cdsLinMet.FieldByName('LMT_VLRMET').AsFloat);

  pSetFocus(edtVlrMet);
  mskCodLin.Enabled := False;
  dbgLinMet.Enabled := False;
  blnEdicaoItem := True;
end;

procedure TfrmComissaoLinha.pLimpaCampos;
begin
  edtCodEmp.Text := '';
  edtDesEmp.Text := '';
  edtCodVen.Text := '';
  edtDesVen.Text := '';
  cdsLinMet.EmptyDataSet;
  objComLin := Nil;
  pLimpaCamposItens;
  btnConfirmar.Enabled := False;
  dbgLinMet.Enabled := False;
  btnHeranca.Enabled := False;
  mskCodLin.Enabled := False;
end;

procedure TfrmComissaoLinha.pPreencheCdsLinMet;
begin
  If (blnEdicaoItem) Then
    cdsLinMet.Edit
  Else
    cdsLinMet.Append;

  cdsLinMet.FieldByName('LMT_CODLIN').AsString := mskCodLin.Text;
  cdsLinMet.FieldByName('LMT_PERFAT').AsFloat  := fStrToFloat(edtPerFat.Text);
  cdsLinMet.FieldByName('LMT_PERMIX').AsFloat  := fStrToFloat(edtPerMix.Text);
  cdsLinMet.FieldByName('LMT_PERMAR').AsFloat  := fStrToFloat(edtPerMar.Text);
  cdsLinMet.FieldByName('LMT_VLRMET').AsFloat  := fStrToFloat(edtVlrMet.Text);

  cdsLinMet.Post;
end;

function TfrmComissaoLinha.fValidaItem: Boolean;
begin
  Result := False;

  If (Not blnEdicaoItem) And (fLinhaJaInserida) Then
  Begin
    fMensagem('ATENÇÃO!', 'Linha já informada', ['&Ok']);
    pSetFocus(mskCodLin);
    Exit;
  End;

  If (fEmptyStr(mskCodLin.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Linha deve ser informada', ['&Ok']);
    pSetFocus(mskCodLin);
    Exit;
  End;

  If (Not fValidaCamposNumericos) Then
    Exit;

  Result := True;
end;

function TfrmComissaoLinha.fValidaCamposNumericos: Boolean;
begin
  Result := False;

  If (Not fValidaCampoValor('% de Comissão de Faturamento', edtPerFat)) Then
    Exit;

  If (Not fValidaCampoValor('% de Comissão Mix', edtPerMix)) Then
    Exit;

  If (Not fValidaCampoValor('% de Comissão de Margem', edtPerMar)) Then
    Exit;

  If (Not fValidaCampoValor('Valor de Meta de Faturamento', edtVlrMet)) Then
    Exit;

  Result := True;
end;

function TfrmComissaoLinha.fValidaCampoValor(strNome: String; edtCampo: TEditFocus): Boolean;
begin
  Result := False;

  If (fStrToFloat(edtCampo.Text) < 0) Then
  Begin
    fMensagem('ATENÇÃO!', strNome + ' deve ser maior ou igual a zero', ['&Ok']);
    pSetFocus(edtCampo);
    Exit;
  End;

  Result := True;
end;

function TfrmComissaoLinha.fLinhaJaInserida: Boolean;
begin
  Result := (cdsLinMet.Locate('LMT_CODLIN', mskCodLin.Text, []));
end;

procedure TfrmComissaoLinha.pPesquisaComissao;
  Var
    arrComissao: TConsultasArray;
    strAutInc: String;
begin
  Try
    If fPesqComissaoLinha(Self, strAutInc, Nil, arrComissao, True) Then
    Begin
      objComLin := objComLinController.fBuscarPorAutoIncremento(strAutInc);

      pPreencheCamposCabecalho(objComLin);
      objLinMetController.pCarregaLista(strAutInc, cdsLinMet);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmComissaoLinha.pPesquisaComissao]');
    End;
  End;
end;

procedure TfrmComissaoLinha.pPreencheCamposCabecalho(objComLin: TComLin);
begin
  edtCodEmp.Text := objComLin.getCodEmp;
  edtDesEmp.Text := fRetNomeEmpresaSelec(objComLin.getCodEmp);
  edtCodVen.Text := objComLin.getCodVen;
  edtDesVen.Text := fRetNomVendRep(objComLin.getCodVen);
end;

procedure TfrmComissaoLinha.pPreencheObjComLin(strCodVen: String);
begin
  objComLin := objComLin.getInstance('', edtCodEmp.Text, strCodVen);
end;

function TfrmComissaoLinha.fComissaoAtualJaExistente: Boolean;
begin
  Result := (objComLin <> Nil) And (Not fEmptyStr(objComLin.getAutInc));
end;

procedure TfrmComissaoLinha.FormCreate(Sender: TObject);
begin
  inherited;
  objComLinController := TComLinController.Create;
  objLinMetController := TLinMetController.Create;
  objComLin := Nil;
  blnEdicaoItem := False;
end;

procedure TfrmComissaoLinha.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objComLinController);
  FreeAndNil(objLinMetController);
  FreeAndNil(objComLin);
end;

procedure TfrmComissaoLinha.FormShow(Sender: TObject);
begin
  strNomeTabela := 'COMLIN';
  strNomeCampo  := 'AUTOINCREM';
  qryTabela     := fCriaQuery(Self);
  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := edtCodEmp;
  inherited;
end;

procedure TfrmComissaoLinha.pInicializaIndices;
Begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;
End;

function TfrmComissaoLinha.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodEmp) Then
    Begin
      If (fEmptyStr(edtCodEmp.Text)) Then
      Begin
        edtDesEmp.Text := '';
        fMensagem('ATENÇÃO!','O Código da Empresa deve ser preenchido',['&OK']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Essa Empresa não está cadastrada',['&OK']);
          Result := False;
        End
      End;
    End
    Else If (Sender = edtCodVen) Then
    Begin
      If (fEmptyStr(edtCodVen.Text)) Then
      Begin
        edtDesVen.Text := '';
        fMensagem('ATENÇÃO!','O Código do Vendedor deve ser preenchido',['&OK']);
        Result := False;
      End
      Else
      If (Not SameText(edtCodVen.Text, '000')) Then
      Begin
        SetLength(arrVendedor, 0);
        edtDesVen.Text := fRetNomVendRep(edtCodVen.Text);
        If fEmptyStr(edtDesVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse Vendedor não está cadastrado',['&OK']);
          Result := False;
        End
        Else
        Begin
          SetLength(arrVendedor, 1);
          arrVendedor[0].strCodigo := edtCodVen.Text;
          arrVendedor[0].strDescri := edtDesVen.Text;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmComissaoLinha.fValidaDados: Boolean;
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

function TfrmComissaoLinha.fValidaCabecalhoInclusao: Boolean;
begin
  Result := False;

  If (fComissaoAtualJaExistente) Then
    Exit(True);

  If (fJaExisteComissaoParaVendedorEmpresa) Then
    Exit;

  Result := True;
end;

function TfrmComissaoLinha.fValidaItens: Boolean;
begin
  Result := False;

  If (cdsLinMet.RecordCount <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Para prosseguir com a gravação, deve ser informada ao menos uma Linha de Produto', ['&Ok']);
    Exit;
  End;

  Result := True;
end;

function TfrmComissaoLinha.fJaExisteComissaoParaVendedorEmpresa: Boolean;
  Var
    intIndex : Integer;
begin
  Result := True;

  Try
    For intIndex := 0 To Pred(Length(arrVendedor)) Do
    Begin
      If (objComLinController.fExisteComissaoParaVendedorEmpresa(edtCodEmp.Text, arrVendedor[intIndex].strCodigo)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe uma comissão com esta empresa o vendedor "'+arrVendedor[intIndex].strCodigo+'".', ['&Ok']);
        pSetFocus(edtCodEmp);
        Exit;
      End;
    End;

    Result := False;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmComissaoLinha.fJaExisteComissaoParaVendedorEmpresa]');
    End;
  End;
end;

procedure TfrmComissaoLinha.pPreencheComLinItens(strAutInc: String);
begin
  cdsLinMet.First;

  While (Not cdsLinMet.Eof) Do
  Begin
    cdsLinMet.Edit;
    cdsLinMet.FieldByName('LMT_COMLIN').AsString := strAutInc;
    cdsLinMet.Post;
    cdsLinMet.Next;
  End;
end;

function TfrmComissaoLinha.fGravar: Boolean;
  Var
    strAutInc: String;
begin
  Result := False;

  strAutInc := objComLinController.fGravar(objComLin);

  If (Not fEmptyStr(strAutInc)) Then
  Begin
    pPreencheComLinItens(strAutInc);
    Result := (objLinMetController.fGravar(cdsLinMet, strAutInc));
  End;
end;

procedure TfrmComissaoLinha.pExcluiRegistro;
  Var
    blnExcluiu: Boolean;
begin
  Try
    blnExcluiu := (objLinMetController.fDeletarColecao(objComLin.getAutInc)) And
      (objComLinController.fDeletar(objComLin.getAutInc));

    If (blnExcluiu) Then
      fMensagem('ATENÇÃO!', 'Dados deletados com sucesso', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmComissaoLinha.pExcluiRegistro]');
    End;
  End;
end;

procedure TfrmComissaoLinha.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmComissaoLinha.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtDesVen, arrVendedor, fRetNomVendRep, Nil, 'do vendedor', 3);
end;

procedure TfrmComissaoLinha.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtDesVen, nil, Key, arrVendedor, False) Then
  Begin
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmComissaoLinha.mskCodLinExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskCodLin, edtDesLin, arrLinhas, fRetNomeLinha, Nil, 'da linha', 6);
end;

procedure TfrmComissaoLinha.mskCodLinKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskCodLin, edtDesLin, Nil, Key, arrLinhas, True, False, False, True) Then
  Begin
    If fValidaCampos(mskCodLin, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

end.
