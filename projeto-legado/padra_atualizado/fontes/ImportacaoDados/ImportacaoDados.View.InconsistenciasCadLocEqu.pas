
unit ImportacaoDados.View.InconsistenciasCadLocEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxPC, cxProgressBar,
  ImportacaoDados.Interfaces, ImportacaoDados.Controller.CadLocEqu,
  DBAccess, Uni, Datasnap.DBClient, UniClientDataSet, ImportacaoDados.Model.CadLocEqu,
  untTypesSistema, DBGridCitel;

type
  TfrmInconsistenciasCadLocEqu = class(TfrmPaiConfirma)
    pcInconsistencias: TcxPageControl;
    tsInconsistencias: TcxTabSheet;
    cxGridCitelInconsistencias: TcxGridCitel;
    cxGridDBTableViewInconsistencias: TcxGridDBTableViewCitel;
    cxGridInconsistenciaTableViewLinha: TcxGridDBColumn;
    cxGridInconsistenciaTableViewColuna: TcxGridDBColumn;
    cxGridInconsistenciaTableViewCampo: TcxGridDBColumn;
    cxGridInconsistenciaTableViewDescricao: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    tsCadastrosGerados: TcxTabSheet;
    cxGridCamposImportados: TcxGridCitel;
    cxCamposImportadosTableView: TcxGridDBTableViewCitel;
    cxGridCadastroEql: TcxGridLevel;
    cdsInconsistencias: TUniClientDataSet;
    cdsInconsistenciasCOLUNA: TStringField;
    cdsInconsistenciasCAMPO: TStringField;
    cdsInconsistenciasINCONSISTENCIA: TStringField;
    cdsInconsistenciasNROLINHA: TIntegerField;
    dtsInconsistencias: TUniDataSource;
    cdsCadastros: TUniClientDataSet;
    dtsCadastros: TUniDataSource;
    cdsAcessorios: TUniClientDataSet;
    dtsAcessorios: TUniDataSource;
    cdsNegociacao: TUniClientDataSet;
    dtsNegociacao: TUniDataSource;
    cxGridCamposImportadosDBTableViewAcessorios: TcxGridDBTableViewCitel;
    cxGridCamposImportadosDBTableViewNegociacao: TcxGridDBTableViewCitel;
    cxGridAcessorios: TcxGridDBTableViewCitel;
    cxGridCamposImportadosLevel1: TcxGridLevel;
    cxGridCamposImportadosLevel2: TcxGridLevel;
    cxGridCamposImportadosLevel3: TcxGridLevel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxCamposImportadosTableViewEditKeyPress(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cdsCadastrosBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    ControllerCadLocEqu: TCadEquLocacaoController;
    blnHabilitaEdicao: Boolean;
    qryCadEqL: TUniQuery;
    arrProduto: TConsultasArray;

    procedure pCarregarListaInconsistencias;
    procedure pCarregaLinhasParaCadastro;
    procedure pCriarColunasModelo;
    procedure pCriarColunasCadEql;
    procedure pCriarColunasEqlAce;
    procedure pCriarColunasEqlNgn;
    function  fGerarCadastros: Boolean;
    function  fConfirmar(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fReprocessar(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fRetornaPesquisaCodIte(Key: Char; aEditValue: String): String;
    function  fValidarCampos: Boolean;
    function  fSetarCampo(Const aArray: TConsultasArray; Const strValorDefault: String): String;
    procedure pCarregarLinhasCadEql;
    procedure pCarregarLinhasEqlAce;
    procedure pCarregarLinhasEqlNgn;
    function fRetornaModeloTabela(const strNomTabela: String): IModeloArquivoImportacao;
  public
    { Public declarations }
    ObjImportaPlanilha: IImportaPlanilha;
    ObjModeloArquivo: IModeloArquivoImportacao;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untGravando, StrUtils;

{$R *.dfm}

procedure TfrmInconsistenciasCadLocEqu.btnConfirmaClick(Sender: TObject);
var
  frmAguarde: TfrmGravando;
begin
  inherited;

  Try
    TfrmGravando.fExecuta(fReprocessar, frmAguarde, 'Aguarde...Processando dados para importação', False);
    TfrmGravando.fExecuta(fConfirmar, frmAguarde, 'Aguarde...Gerando cadastro de Equipamentos de Locação', False);
  Finally
    pFreeAndNil(frmAguarde);
  End;

end;

procedure TfrmInconsistenciasCadLocEqu.cdsCadastrosBeforePost(
  DataSet: TDataSet);
begin

  If Not fValidarCampos Then
    Exit;

  inherited;

end;

procedure TfrmInconsistenciasCadLocEqu.cxCamposImportadosTableViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  Try
    If (AItem as TcxGridDBColumn).DataBinding.FieldName = cstCodIte Then
    Begin
      AEdit.EditValue := fRetornaPesquisaCodIte(Key, AItem.EditValue);
      AEdit.EditValue := EmptyStr;
    End;

    inherited;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmInconsistenciasCadLocEqu.cxCamposImportadosTableViewEditKeyPress]');
    End;
  End;
end;

function TfrmInconsistenciasCadLocEqu.fConfirmar(
  pgbStatus: TcxProgressBar): Boolean;
begin
  If ObjImportaPlanilha.Valida.Inconsistencias.Inconsistencias.Count > 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Na validação do arquivo foram encontrados registros com inconsistências. '+
                          'Por favor, verifique as inconsistências e se for necessário, ' +
                          'ajuste a planilha para uma nova importação', ['&Ok']);
    Result := False;
    ModalResult := mrNone;
    pcInconsistencias.ActivePageIndex := 0;
  End
  Else
  Begin
    Result := fGerarCadastros;
    If Not Result Then
      ModalResult := mrNone;
  End;
end;

function TfrmInconsistenciasCadLocEqu.fGerarCadastros: Boolean;
begin
  Result := ObjImportaPlanilha.fInserirCadastros;
  If Result Then
    pMensagemOk('Cadastros gerados com sucesso!')
  Else
    pMensagemOk('Cadastros não foram processados!')
end;

procedure TfrmInconsistenciasCadLocEqu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(qryCadEqL);
end;

procedure TfrmInconsistenciasCadLocEqu.FormCreate(Sender: TObject);
begin
  inherited;

  ControllerCadLocEqu := TCadEquLocacaoController.Create;

  blnHabilitaEdicao := False;
end;

procedure TfrmInconsistenciasCadLocEqu.FormShow(Sender: TObject);
begin
  inherited;

  Try
    cdsInconsistencias.CreateDataSet;

    pCarregaLinhasParaCadastro;
    If ObjImportaPlanilha.Valida.Inconsistencias.Inconsistencias.Count > 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Na validação do arquivo foram encontrados registros com inconsistências. '+
                            'Por favor, verifique as inconsistências e se for necessário, ' +
                            'ajuste a planilha para uma nova importação.', ['&Ok']);

      pCarregarListaInconsistencias;
      pcInconsistencias.ActivePageIndex := 0;
    End
    Else
      pcInconsistencias.ActivePageIndex := 1;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmInconsistenciasCadLocEqu.FormShow]');
    End;
  End;

end;

function TfrmInconsistenciasCadLocEqu.fReprocessar(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Try
    cdsInconsistencias.Close;
    cdsInconsistencias.CreateDataSet;
    ObjImportaPlanilha.fAtualizarDadosImportados(cdsCadastros);
    Result := ObjImportaPlanilha.Valida.Inconsistencias.Inconsistencias.Count <= 0;

    pCarregarListaInconsistencias;
    pCarregaLinhasParaCadastro;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmInconsistenciasCadLocEqu.pReprocessar]');
    End;
  End;
end;

function TfrmInconsistenciasCadLocEqu.fRetornaModeloTabela(const strNomTabela: String): IModeloArquivoImportacao;
var
  intCnt: Integer;
begin
  For intCnt := 0 to ObjModeloArquivo.ListaModeloTabelas.Count -1 Do
  Begin
    If ObjModeloArquivo.ListaModeloTabelas[intCnt].strNomTabela = strNomTabela Then
    Begin
      Result := ObjModeloArquivo.ListaModeloTabelas[intCnt];
      Break;
    End;
  End;
end;

function TfrmInconsistenciasCadLocEqu.fRetornaPesquisaCodIte(Key: Char;
  aEditValue: String): String;
begin
  Result := aEditValue;

  If fPesqItem(conIteSimples, Self, Nil, Nil, Nil, Key, arrProduto, False, Nil, 'Consulta de Itens', '1') Then
  Begin
    If arrProduto <> Nil Then
      Result := arrProduto[0].strCodigo
  End;
end;

function TfrmInconsistenciasCadLocEqu.fSetarCampo(const aArray: TConsultasArray;
  const strValorDefault: String): String;
begin
  If aArray <> Nil Then
    Result := aArray[0].strCodigo
  Else
    Result := strValorDefault;
end;

function TfrmInconsistenciasCadLocEqu.fValidarCampos: Boolean;
begin
  Result := True;

  If Not blnHabilitaEdicao Then
    Exit;

  ControllerCadLocEqu.EquipamentoLocacao.CodigoItem := fSetarCampo(arrProduto, cdsCadastros.FieldByName(cstCodIte).AsString);

  Result := ControllerCadLocEqu.Validacao.fExecutar(True);

  If Result Then
  Begin
    cdsCadastros.FieldByName(cstCodIte).AsString := ControllerCadLocEqu.EquipamentoLocacao.CodigoItem;
  End;

  SetLength(arrProduto, 0);
end;

procedure TfrmInconsistenciasCadLocEqu.pCarregaLinhasParaCadastro;
begin
  pCriarColunasModelo;
  pCarregarLinhasCadEql;
  pCarregarLinhasEqlAce;
  pCarregarLinhasEqlNgn;
end;

procedure TfrmInconsistenciasCadLocEqu.pCarregarLinhasEqlAce;
var
  intCnt, intCont, intCount: Integer;
  FModeloTabela: IModeloArquivoImportacao;
begin
  blnHabilitaEdicao := False;
  cdsAcessorios.DisableControls;
  Try
    Try

      For intCnt := 0 to ObjModeloArquivo.ListaModeloTabelas.Count -1 Do
      Begin
        If ObjModeloArquivo.ListaModeloTabelas[intCnt].strNomTabela = cstTabAce Then
        Begin
          FModeloTabela := ObjModeloArquivo.ListaModeloTabelas[intCnt];
          Break;
        End;
      End;

      For intCnt := ObjImportaPlanilha.LinhasImportadas.Count-1 DownTo 0 Do
      Begin
        If ObjImportaPlanilha.LinhasImportadas[intCnt].strNomeTabela = cstTabAce Then
        Begin
          cdsAcessorios.Insert;
          cdsAcessorios.FieldByName('NROLINHA').AsInteger := ObjImportaPlanilha.LinhasImportadas[intCnt].NumeroLinha;
          For intCont := 0 To ObjImportaPlanilha.LinhasImportadas[intCnt].Campos.Count-1 Do
          Begin
            For intCount := 0 To FModeloTabela.Campos.Count-1 Do
            Begin
              If FModeloTabela.Campos[intCount].NomeCampo = ObjImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.NomeCampo  Then
              Begin
                Try
                   cdsAcessorios.FieldByName(FModeloTabela.Campos[intCount].NomeCampo).AsString :=
                     ObjImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo;
                Except

                End;
              End;
            End;
          End;
          cdsAcessorios.Post;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmInconsistenciasCadLocEqu.pCarregarLinhasEqlAce]');
      End;
    End;
  Finally
    cdsAcessorios.EnableControls;
    blnHabilitaEdicao := True;
  End;
end;

procedure TfrmInconsistenciasCadLocEqu.pCarregarLinhasEqlNgn;
var
  intCnt, intCont, intCount: Integer;
  FModeloTabela: IModeloArquivoImportacao;
begin
  blnHabilitaEdicao := False;
  cdsNegociacao.DisableControls;
  Try
    Try

      For intCnt := 0 to ObjModeloArquivo.ListaModeloTabelas.Count -1 Do
      Begin
        If ObjModeloArquivo.ListaModeloTabelas[intCnt].strNomTabela = cstTabNeg Then
        Begin
          FModeloTabela := ObjModeloArquivo.ListaModeloTabelas[intCnt];
          Break;
        End;
      End;

      For intCnt := ObjImportaPlanilha.LinhasImportadas.Count-1 DownTo 0 Do
      Begin
        If ObjImportaPlanilha.LinhasImportadas[intCnt].strNomeTabela = cstTabNeg Then
        Begin
          cdsNegociacao.Insert;
          cdsNegociacao.FieldByName('NROLINHA').AsInteger := ObjImportaPlanilha.LinhasImportadas[intCnt].NumeroLinha;
          For intCont := 0 To ObjImportaPlanilha.LinhasImportadas[intCnt].Campos.Count-1 Do
          Begin
            For intCount := 0 To FModeloTabela.Campos.Count-1 Do
            Begin
              If FModeloTabela.Campos[intCount].NomeCampo = ObjImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.NomeCampo  Then
              Begin
                Try
                   cdsNegociacao.FieldByName(FModeloTabela.Campos[intCount].NomeCampo).AsString :=
                     ObjImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo;
                Except

                End;
              End;
            End;
          End;
          cdsNegociacao.Post;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmInconsistenciasCadLocEqu.pCarregarLinhasEqlNgn]');
      End;
    End;
  Finally
    cdsNegociacao.EnableControls;
    blnHabilitaEdicao := True;
  End;
end;

procedure TfrmInconsistenciasCadLocEqu.pCarregarLinhasCadEql;
var
  intCnt, intCont: Integer;
begin
  blnHabilitaEdicao := False;
  cdsCadastros.DisableControls;
  Try
    Try
      For intCnt := ObjImportaPlanilha.LinhasImportadas.Count-1 DownTo 0 Do
      Begin
        If ObjImportaPlanilha.LinhasImportadas[intCnt].blnTabelaPrincipal Then
        Begin
          cdsCadastros.Insert;
          cdsCadastros.FieldByName('NROLINHA').AsInteger := ObjImportaPlanilha.LinhasImportadas[intCnt].NumeroLinha;
          For intCont := 0 to ObjModeloArquivo.Campos.Count-1 Do
          Begin
            If (Not ObjModeloArquivo.Campos[intCont].blnTabela) Then
            Begin
              If ObjModeloArquivo.Campos[intCont].NomeCampo = ObjImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.NomeCampo  Then
              Begin
                Try
                  cdsCadastros.FieldByName(ObjModeloArquivo.Campos[intCont].NomeCampo).AsString :=
                      ObjImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo;

                Except

                End;
              End;
            End;
          End;
          cdsCadastros.Post;
        End;
      End;
      blnHabilitaEdicao := ObjModeloArquivo.Campos.Count > 0;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmInconsistenciasCadLocEqu.pCarregarLinhasCadEql]');
      End;
    End;
  Finally
    cdsCadastros.EnableControls;
  End;
end;

procedure TfrmInconsistenciasCadLocEqu.pCarregarListaInconsistencias;
var
  intCnt: Integer;
begin
  cdsInconsistencias.DisableControls;
  Try
    Try
      cdsInconsistencias.IndexFieldNames := 'NROLINHA;COLUNA';
      For intCnt := ObjImportaPlanilha.Valida.Inconsistencias.Inconsistencias.Count-1 DownTo 0 Do
      Begin
        cdsInconsistencias.Insert;
        cdsInconsistencias.FieldByName('NROLINHA').AsInteger := ObjImportaPlanilha.Valida.Inconsistencias.Inconsistencias[intCnt].NumeroLinha;
        cdsInconsistencias.FieldByName('COLUNA').AsString := ObjImportaPlanilha.Valida.Inconsistencias.Inconsistencias[intCnt].Coluna;
        cdsInconsistencias.FieldByName('CAMPO').AsString := ObjImportaPlanilha.Valida.Inconsistencias.Inconsistencias[intCnt].Campo;
        cdsInconsistencias.FieldByName('INCONSISTENCIA').AsString := ObjImportaPlanilha.Valida.Inconsistencias.Inconsistencias[intCnt].Descricao;
        cdsInconsistencias.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmInconsistenciasCadLocEqu.pCarregarListaInconsistencias]');
      End;
    End;
  Finally
    cdsInconsistencias.EnableControls
  End;
end;

procedure TfrmInconsistenciasCadLocEqu.pCriarColunasEqlAce;
var
  cdsCampoTabAce: TFieldDef;
  intCnt,
  intCont: Integer;
  blnTabelaCarregada: Boolean;
  FModeloTabela: IModeloArquivoImportacao;
begin
  Try
    cdsAcessorios.Close;
    cdsAcessorios.FieldDefs.Clear;
    cdsCampoTabAce := cdsAcessorios.FieldDefs.AddFieldDef;
    cdsCampoTabAce.DataType  := ftInteger ;
    cdsCampoTabAce.Name := 'NROLINHA';
    cdsCampoTabAce.DisplayName := 'Linha';

    FModeloTabela := fRetornaModeloTabela(cstTabAce);

    blnTabelaCarregada := False;
    For intCnt := 0 to ObjModeloArquivo.Campos.Count-1 Do
    Begin
      If ObjModeloArquivo.Campos[intCnt].blnTabela And
         (Pos(cstTabAce, ObjModeloArquivo.Campos[intCnt].NomeCampo) > 0) And
         (Not blnTabelaCarregada) Then
      Begin
        For intCont := 0 To FModeloTabela.Campos.Count-1 Do
        Begin
          FModeloTabela.Campos[intCont].Tamanho := IIF(ObjModeloArquivo.Campos[intCont].Tamanho <= 0, 300, FModeloTabela.Campos[intCont].Tamanho);
          Case FModeloTabela.Campos[intCont].TipoCampo Of
            ftString  :  cdsAcessorios.FieldDefs.Add(FModeloTabela.Campos[intCont].NomeCampo, FModeloTabela.Campos[intCont].TipoCampo, FModeloTabela.Campos[intCont].Tamanho)
            Else
              cdsAcessorios.FieldDefs.Add(FModeloTabela.Campos[intCont].NomeCampo, FModeloTabela.Campos[intCont].TipoCampo);
          End;

          blnTabelaCarregada :=(intCont = (FModeloTabela.Campos.Count-1));
        End;
      End;
    End;

    cdsAcessorios.CreateDataSet;
    cxGridCamposImportadosDBTableViewAcessorios.BeginUpdate;
    cxGridCamposImportadosDBTableViewAcessorios.DataController.CreateAllItems(True);
    cxGridCamposImportadosDBTableViewAcessorios.GetColumnByFieldName('NROLINHA').Caption := 'Linha';
    cxGridCamposImportadosDBTableViewAcessorios.GetColumnByFieldName('NROLINHA').Options.Editing := False;

    blnTabelaCarregada := False;
    For intCnt := 0 To ObjModeloArquivo.Campos.Count-1 Do
    Begin
      If ObjModeloArquivo.Campos[intCnt].blnTabela And
         (Pos(cstTabAce, ObjModeloArquivo.Campos[intCnt].NomeCampo) > 0) And
         (Not blnTabelaCarregada)  Then
      Begin
        For intCont := 0 To FModeloTabela.Campos.Count-1 Do
        Begin
          cxGridCamposImportadosDBTableViewAcessorios.GetColumnByFieldName(FModeloTabela.Campos[intCont].NomeCampo).Caption := FModeloTabela.Campos[intCont].Descricao;
          blnTabelaCarregada :=(intCont = (FModeloTabela.Campos.Count-1));
          cxGridCamposImportadosDBTableViewAcessorios.GetColumnByFieldName(FModeloTabela.Campos[intCont].NomeCampo).Options.Editing := False;
          If FModeloTabela.Campos[intCont].blnPreAut Then
            cxGridCamposImportadosDBTableViewAcessorios.GetColumnByFieldName(FModeloTabela.Campos[intCont].NomeCampo).Visible := False;
        End;
      End;
    End;

    cxGridCamposImportadosDBTableViewAcessorios.DataController.DetailKeyFieldNames := 'NROLINHA';
    cxGridCamposImportadosDBTableViewAcessorios.DataController.KeyFieldNames := 'NROLINHA';
    cxGridCamposImportadosDBTableViewAcessorios.DataController.MasterKeyFieldNames := 'NROLINHA';

    cxGridCamposImportadosDBTableViewAcessorios.EndUpdate;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmInconsistenciasCadLocEqu.pCriarColunasAcessorios]');
    End;
  End;
end;

procedure TfrmInconsistenciasCadLocEqu.pCriarColunasCadEql;
var
  intCnt: Integer;
  cdsCampo: TFieldDef;
begin
  Try
    cdsCadastros.Close;
    cdsCadastros.FieldDefs.Clear;
    cdsCampo := cdsCadastros.FieldDefs.AddFieldDef;
    cdsCampo.DataType  := ftInteger ;
    cdsCampo.Name := 'NROLINHA';
    cdsCampo.DisplayName := 'Linha';

    For intCnt := 0 to ObjModeloArquivo.Campos.Count-1 Do
    Begin
      If Not ObjModeloArquivo.Campos[intCnt].blnTabela Then
      Begin
        ObjModeloArquivo.Campos[intCnt].Tamanho := IIF(ObjModeloArquivo.Campos[intCnt].Tamanho <= 0, 300, ObjModeloArquivo.Campos[intCnt].Tamanho);
        Case ObjModeloArquivo.Campos[intCnt].TipoCampo Of
          ftString  :  cdsCadastros.FieldDefs.Add(ObjModeloArquivo.Campos[intCnt].NomeCampo, ObjModeloArquivo.Campos[intCnt].TipoCampo, ObjModeloArquivo.Campos[intCnt].Tamanho)
          Else
            cdsCadastros.FieldDefs.Add(ObjModeloArquivo.Campos[intCnt].NomeCampo, ObjModeloArquivo.Campos[intCnt].TipoCampo);
        End;
      End;
    End;

    cdsCadastros.CreateDataSet;
    cxCamposImportadosTableView.BeginUpdate;
    cxCamposImportadosTableView.DataController.CreateAllItems(True);
    cxCamposImportadosTableView.GetColumnByFieldName('NROLINHA').Caption := 'Linha';
    cxCamposImportadosTableView.GetColumnByFieldName('NROLINHA').Options.Editing := False;

    For intCnt := 0 To ObjModeloArquivo.Campos.Count-1 Do
    Begin
      If Not ObjModeloArquivo.Campos[intCnt].blnTabela  Then
      Begin
        cxCamposImportadosTableView.GetColumnByFieldName(ObjModeloArquivo.Campos[intCnt].NomeCampo).Caption := ObjModeloArquivo.Campos[intCnt].Descricao;
      End;
    End;

    cxCamposImportadosTableView.EndUpdate;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmInconsistenciasCadLocEqu.pCriarColunasCadEql]');
    End;
  End;
end;

procedure TfrmInconsistenciasCadLocEqu.pCriarColunasModelo;
Begin
  pCriarColunasCadEql;
  pCriarColunasEqlAce;
  pCriarColunasEqlNgn;
End;

procedure TfrmInconsistenciasCadLocEqu.pCriarColunasEqlNgn;
var
  cdsCampoTabNeg: TFieldDef;
  intCnt,
  intCont: Integer;
  blnTabelaCarregada: Boolean;
  FModeloTabela: IModeloArquivoImportacao;
begin
  Try
    cdsNegociacao.Close;
    cdsNegociacao.FieldDefs.Clear;
    cdsCampoTabNeg := cdsNegociacao.FieldDefs.AddFieldDef;
    cdsCampoTabNeg.DataType  := ftInteger ;
    cdsCampoTabNeg.Name := 'NROLINHA';
    cdsCampoTabNeg.DisplayName := 'Linha';

    FModeloTabela := fRetornaModeloTabela(cstTabNeg);

    blnTabelaCarregada := False;
    For intCnt := 0 to ObjModeloArquivo.Campos.Count-1 Do
    Begin
      If ObjModeloArquivo.Campos[intCnt].blnTabela And
         (Pos(cstTabNeg, ObjModeloArquivo.Campos[intCnt].NomeCampo) > 0) And
         (Not blnTabelaCarregada) Then
      Begin
        For intCont := 0 To FModeloTabela.Campos.Count-1 Do
        Begin
          FModeloTabela.Campos[intCont].Tamanho := IIF(ObjModeloArquivo.Campos[intCont].Tamanho <= 0, 300, FModeloTabela.Campos[intCont].Tamanho);
          Case FModeloTabela.Campos[intCont].TipoCampo Of
            ftString  :  cdsNegociacao.FieldDefs.Add(FModeloTabela.Campos[intCont].NomeCampo, FModeloTabela.Campos[intCont].TipoCampo, FModeloTabela.Campos[intCont].Tamanho)
            Else
              cdsNegociacao.FieldDefs.Add(FModeloTabela.Campos[intCont].NomeCampo, FModeloTabela.Campos[intCont].TipoCampo);
          End;

          blnTabelaCarregada :=(intCont = (FModeloTabela.Campos.Count-1));
        End;
      End;
    End;

    cdsNegociacao.CreateDataSet;
    cxGridCamposImportadosDBTableViewNegociacao.BeginUpdate;
    cxGridCamposImportadosDBTableViewNegociacao.DataController.CreateAllItems(True);
    cxGridCamposImportadosDBTableViewNegociacao.GetColumnByFieldName('NROLINHA').Caption := 'Linha';
    cxGridCamposImportadosDBTableViewNegociacao.GetColumnByFieldName('NROLINHA').Options.Editing := False;

    blnTabelaCarregada := False;
    For intCnt := 0 To ObjModeloArquivo.Campos.Count-1 Do
    Begin
      If ObjModeloArquivo.Campos[intCnt].blnTabela And
         (Pos(cstTabNeg, ObjModeloArquivo.Campos[intCnt].NomeCampo) > 0) And
         (Not blnTabelaCarregada)  Then
      Begin
        For intCont := 0 To FModeloTabela.Campos.Count-1 Do
        Begin
          cxGridCamposImportadosDBTableViewNegociacao.GetColumnByFieldName(FModeloTabela.Campos[intCont].NomeCampo).Caption := FModeloTabela.Campos[intCont].Descricao;
          cxGridCamposImportadosDBTableViewNegociacao.GetColumnByFieldName(FModeloTabela.Campos[intCont].NomeCampo).Options.Editing := False;
          If FModeloTabela.Campos[intCont].blnPreAut Then
            cxGridCamposImportadosDBTableViewNegociacao.GetColumnByFieldName(FModeloTabela.Campos[intCont].NomeCampo).Visible := False;

          Case FModeloTabela.Campos[intCont].TipoCampo Of
            ftFloat: TFloatField(cdsNegociacao.FieldByName(FModeloTabela.Campos[intCont].NomeCampo)).DisplayFormat := '#,##0.00';
          End;

          blnTabelaCarregada :=(intCont = (FModeloTabela.Campos.Count-1));
        End;
      End;
    End;

    cxGridCamposImportadosDBTableViewNegociacao.DataController.DetailKeyFieldNames := 'NROLINHA';
    cxGridCamposImportadosDBTableViewNegociacao.DataController.KeyFieldNames := 'NROLINHA';
    cxGridCamposImportadosDBTableViewNegociacao.DataController.MasterKeyFieldNames  := 'NROLINHA';

    cxGridCamposImportadosDBTableViewNegociacao.EndUpdate;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmInconsistenciasCadLocEqu.pCriarColunasNegociacaoDiarias]');
    End;
  End;
end;

end.
