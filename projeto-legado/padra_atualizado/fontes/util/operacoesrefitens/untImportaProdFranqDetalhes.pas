unit untImportaProdFranqDetalhes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass, UniClientDataSet, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, untTImportacaoFranquias, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, EditFocus, cxButtonEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmImpFranquiaDetalhe = class(TfrmPai)
    lblObs: TLabel;
    btnConfirma: TBitBtnLocked;
    grdDadosLvl1: TcxGridLevel;
    grdDadosDados: TcxGridDBTableViewCitel;
    grdDados: TcxGridCitel;
    pnlCabecalho: TPanel;
    lblDetalhes: TLabel;
    dtsDados: TDataSource;
    grdDadosDadosCODIGO: TcxGridDBColumn;
    grdDadosDadosDESCRI: TcxGridDBColumn;
    grdDadosDadosPESQUISA: TcxGridDBColumn;
    grdDadosDadosTIPOPE: TcxGridDBColumn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdDadosDadosEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure grdDadosDadosEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdDadosDadosTIPOPEGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
  private
    { Private declarations }
    cdsTemp: TUniClientDataSet;

    procedure pAjustarLayoutTela;
    procedure pInicializarGrid;
    procedure pEfetuarClickPesquisa(Var AItem: TcxCustomGridTableItem; strCodigo: String);
    procedure pLimparCampoCodAut(AItem: TcxCustomGridTableItem; strCodAut, strCodVel: String);
    procedure pConfirmarVinculos;
    function  fGetClientDataSet(tcTipoCad: TTipoCad): TClasseBase;
  public
    { Public declarations }
    tcTipoCad : TTipoCad;
    objImportacao: TImportacaoCadastros;
  end;

var
  frmImpFranquiaDetalhe: TfrmImpFranquiaDetalhe;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmImpFranquiaDetalhe.btnConfirmaClick(Sender: TObject);
  Var
    blnConfirma: Boolean;
begin
  inherited;

  blnConfirma := (fMensagem('CONFIRMAÇÃO!', 'Confirma relacionamentos dos cadastros?', ['&Sim', '&Não'], 2) = 1);

  If (blnConfirma) Then
    pConfirmarVinculos();

  btnSair.Click();
end;

procedure TfrmImpFranquiaDetalhe.btnSairClick(Sender: TObject);
begin
  inherited;

  Case (tcTipoCad) Of
    tcFornecedores:
      fGetClientDataSet(tcFornecedores).pDesfazerVinculosRegistroExistente('IMP_CODAUT', 'IMP_CODVEL', 'IMP_CODAUT');

    tcProduto:
      fGetClientDataSet(tcProduto).pDesfazerVinculosRegistroExistente('IMP_CODITE', 'IMP_CODVEL', 'IMP_CODAUT');

    tcDepartamento:
      fGetClientDataSet(tcDepartamento).pDesfazerVinculosRegistroExistente('DEP_CODIGO', 'DEP_CODVEL', 'DEP_CODAUT');

    tcLinhaGrupo:
      fGetClientDataSet(tcLinhaGrupo).pDesfazerVinculosRegistroExistente('GRU_CODGRU', 'GRU_CODVEL', 'GRU_CODAUT');

    tcMarca:
      fGetClientDataSet(tcMarca).pDesfazerVinculosRegistroExistente('MAR_CODMAR', 'MAR_CODVEL', 'MAR_CODAUT');

    tcUnidade:
      fGetClientDataSet(tcUnidade).pDesfazerVinculosRegistroExistente('UNI_CODUNI', 'UNI_CODVEL', 'UNI_CODAUT');

    tcGrupoProduto:
      fGetClientDataSet(tcGrupoProduto).pDesfazerVinculosRegistroExistente('PRD_CODGRU', 'PRD_CODVEL', 'PRD_CODAUT');

    tcAtividade:
      fGetClientDataSet(tcAtividade).pDesfazerVinculosRegistroExistente('ATI_CODATI', 'ATI_CODVEL', 'ATI_CODAUT');
  End;
end;

function TfrmImpFranquiaDetalhe.fGetClientDataSet(tcTipoCad: TTipoCad): TClasseBase;
begin
  Result := nil;

  Case (tcTipoCad) Of
    tcFornecedores: Result := objImportacao.cdsImpFor;

    tcProduto: Result := objImportacao.cdsImpPro;

    tcDepartamento: Result := objImportacao.cdsCadDep;

    tcLinhaGrupo: Result := objImportacao.cdsCadGru;

    tcMarca: Result := objImportacao.cdsCadMar;

    tcUnidade: Result := objImportacao.cdsCadUni;

    tcGrupoProduto: Result := objImportacao.cdsGrpPrd;

    tcAtividade: Result := objImportacao.cdsCadAti;
  End;
end;

procedure TfrmImpFranquiaDetalhe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(cdsTemp);
end;

procedure TfrmImpFranquiaDetalhe.FormCreate(Sender: TObject);
begin
  inherited;

  tcTipoCad     := tcNenhum;
  cdsTemp       := nil;
  objImportacao := nil;
end;

procedure TfrmImpFranquiaDetalhe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
    btnSair.Click();

  If (Key = VK_F10) Then
    btnConfirma.Click();
end;

procedure TfrmImpFranquiaDetalhe.FormShow(Sender: TObject);
begin
  inherited;

  pAjustarLayoutTela();
end;

procedure TfrmImpFranquiaDetalhe.grdDadosDadosEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  If (AItem.Name = 'grdDadosDadosPESQUISA') And (Key = VK_DELETE) Then Begin
    pLimparCampoCodAut(AItem, AItem.GridView.Items[AItem.Index].EditValue, AItem.GridView.Items[AItem.Index + 1].EditValue);
  End;
end;

procedure TfrmImpFranquiaDetalhe.grdDadosDadosEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  Try
    If (AItem.Name = 'grdDadosDadosPESQUISA') And (Key = '/') Then Begin
      pEfetuarClickPesquisa(AItem, AItem.GridView.Items[AItem.Index + 1].EditValue);
      Key := #0;
    End;
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TfrmImpFranquiaDetalhe.grdDadosDadosEditKeyPress]');
  End;
end;

procedure TfrmImpFranquiaDetalhe.grdDadosDadosTIPOPEGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;

  If (AText = 'I') Then
    AText := 'Inclusão'
  Else If (AText = 'U') Then
    AText := 'Alteração'
  Else If (AText = 'D') Then
    AText := 'Exclusão';
end;

procedure TfrmImpFranquiaDetalhe.pAjustarLayoutTela;
begin
  pInicializarGrid();

  Case (tcTipoCad) Of
    tcFornecedores:
      Begin
        Self.Caption := 'Importação de Novos Fornecedores da Franqueadora - Detalhes';
        lblDetalhes.Caption := 'Detalhe Cadastro de "FORNECEDORES"';

        grdDadosDadosPESQUISA.DataBinding.FieldName := 'IMP_CODAUT';
        grdDadosDadosCODIGO.DataBinding.FieldName   := 'IMP_CODVEL';
        grdDadosDadosDESCRI.DataBinding.FieldName   := 'IMP_NOMFOR';
        grdDadosDadosTIPOPE.DataBinding.FieldName   := 'IMP_TIPOPE';
      End;

    tcProduto:
      Begin
        Self.Caption := 'Importação de Novos Produtos da Franqueadora - Detalhes';
        lblDetalhes.Caption := 'Detalhe Cadastro de "PRODUTOS"';

        grdDadosDadosPESQUISA.DataBinding.FieldName := 'IMP_CODAUT';
        grdDadosDadosCODIGO.DataBinding.FieldName   := 'IMP_CODVEL';
        grdDadosDadosDESCRI.DataBinding.FieldName   := 'IMP_DESITE';
        grdDadosDadosTIPOPE.DataBinding.FieldName   := 'IMP_TIPOPE';
      End;

    tcDepartamento:
      Begin
        Self.Caption := 'Importação de Novos Departamentos da Franqueadora - Detalhes';
        lblDetalhes.Caption := 'Detalhe Cadastro de "DEPARTAMENTOS"';

        grdDadosDadosPESQUISA.DataBinding.FieldName := 'DEP_CODAUT';
        grdDadosDadosCODIGO.DataBinding.FieldName   := 'DEP_CODVEL';
        grdDadosDadosDESCRI.DataBinding.FieldName   := 'DEP_DESCRI';
        grdDadosDadosTIPOPE.Visible := False;
      End;

    tcLinhaGrupo:
      Begin
        Self.Caption := 'Importação de Novos Grupos/Linhas da Franqueadora - Detalhes';
        lblDetalhes.Caption := 'Detalhe Cadastro de "GRUPO/LINHAS"';

        grdDadosDadosPESQUISA.DataBinding.FieldName := 'GRU_CODAUT';
        grdDadosDadosCODIGO.DataBinding.FieldName   := 'GRU_CODVEL';
        grdDadosDadosDESCRI.DataBinding.FieldName   := 'GRU_DESGRU';
        grdDadosDadosTIPOPE.Visible := False;
      End;

    tcMarca:
      Begin
        Self.Caption := 'Importação de Novas Marcas da Franqueadora - Detalhes';
        lblDetalhes.Caption := 'Detalhe Cadastro de "MARCAS"';

        grdDadosDadosPESQUISA.DataBinding.FieldName := 'MAR_CODAUT';
        grdDadosDadosCODIGO.DataBinding.FieldName   := 'MAR_CODVEL';
        grdDadosDadosDESCRI.DataBinding.FieldName   := 'MAR_DESMAR';
        grdDadosDadosTIPOPE.Visible := False;
      End;

    tcUnidade:
      Begin
        Self.Caption := 'Importação de Novas Unidades da Franqueadora - Detalhes';
        lblDetalhes.Caption := 'Detalhe Cadastro de "UNIDADES"';

        grdDadosDadosPESQUISA.DataBinding.FieldName := 'UNI_CODAUT';
        grdDadosDadosCODIGO.DataBinding.FieldName   := 'UNI_CODVEL';
        grdDadosDadosDESCRI.DataBinding.FieldName   := 'UNI_DESUNI';
        grdDadosDadosTIPOPE.Visible := False;
      End;

    tcGrupoProduto:
      Begin
        Self.Caption := 'Importação de Novos Grupo de Produtos da Franqueadora - Detalhes';
        lblDetalhes.Caption := 'Detalhe Cadastro de "GRUPO DE PRODUTOS"';

        grdDadosDadosPESQUISA.DataBinding.FieldName := 'PRD_CODAUT';
        grdDadosDadosCODIGO.DataBinding.FieldName   := 'PRD_CODVEL';
        grdDadosDadosDESCRI.DataBinding.FieldName   := 'PRD_DESGRU';
        grdDadosDadosTIPOPE.Visible := False;
      End;

    tcAtividade:
      Begin
        Self.Caption := 'Importação de Novas Atividades da Franqueadora - Detalhes';
        lblDetalhes.Caption := 'Detalhe Cadastro de "ATIVIDADE"';

        grdDadosDadosPESQUISA.DataBinding.FieldName := 'ATI_CODAUT';
        grdDadosDadosCODIGO.DataBinding.FieldName   := 'ATI_CODVEL';
        grdDadosDadosDESCRI.DataBinding.FieldName   := 'ATI_DESATI';
        grdDadosDadosTIPOPE.Visible := False;
      End;

    Else Begin
      Self.Caption := 'Importação de Novos Produtos Franqueadora - Detalhes';
      lblDetalhes.Caption := 'Detalhe Cadastro de ""';
    End;
  End;
end;

procedure TfrmImpFranquiaDetalhe.pConfirmarVinculos;
begin
  Try
    fGetClientDataSet(tcTipoCad).Data := cdsTemp.Data;

    Case (tcTipoCad) Of
      tcFornecedores:
        fGetClientDataSet(tcFornecedores).pConfirmarVinculoRegistroExistente('IMP_CODAUT', 'IMP_CODVEL', 'IMP_CODAUT', 'FORNECEDOR');

      tcProduto:
        fGetClientDataSet(tcProduto).pConfirmarVinculoRegistroExistente('IMP_CODITE', 'IMP_CODVEL', 'IMP_CODAUT', 'PRODUTO');

      tcDepartamento:
        fGetClientDataSet(tcDepartamento).pConfirmarVinculoRegistroExistente('DEP_CODIGO', 'DEP_CODVEL', 'DEP_CODAUT', 'DEPARTAMENTO');

      tcLinhaGrupo:
        fGetClientDataSet(tcLinhaGrupo).pConfirmarVinculoRegistroExistente('GRU_CODGRU', 'GRU_CODVEL', 'GRU_CODAUT', 'LINHA/GRUPO');

      tcMarca:
        fGetClientDataSet(tcMarca).pConfirmarVinculoRegistroExistente('MAR_CODMAR', 'MAR_CODVEL', 'MAR_CODAUT', 'MARCA');

      tcUnidade:
        fGetClientDataSet(tcUnidade).pConfirmarVinculoRegistroExistente('UNI_CODUNI', 'UNI_CODVEL', 'UNI_CODAUT', 'UNIDADE');

      tcGrupoProduto:
        fGetClientDataSet(tcGrupoProduto).pConfirmarVinculoRegistroExistente('GRP_CODGRU', 'GRP_CODVEL', 'GRP_CODAUT', 'GRUPO DE PRODUTO');

      tcAtividade:
        fGetClientDataSet(tcAtividade).pConfirmarVinculoRegistroExistente('ATI_CODATI', 'ATI_CODVEL', 'ATI_CODAUT', 'ATIVIDADE');
    End;
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TfrmImpFranquiaDetalhe.pConfirmarVinculos]');
  End;
end;

procedure TfrmImpFranquiaDetalhe.pEfetuarClickPesquisa(Var AItem: TcxCustomGridTableItem; strCodigo: String);
  Var
    chrKey: Char;
    arrConsulta: TConsultasArray;
    edtCodigo: TCustomEdit;
    edtDescri: TEditFocus;

  procedure pAtualizarField; begin
    AItem.EditValue := edtCodigo.Text;

    If (AItem.Index + 1) < (AItem.GridView.ItemCount) then begin
      AItem.GridView.Items[AItem.Index].EditValue := edtCodigo.Text;
    end;
  end;

begin
  Try
    edtCodigo := TCustomEdit.Create(Self);
    edtDescri := TEditFocus.Create(Self);

    chrKey := '/';

    Case (tcTipoCad) Of
      tcFornecedores:
        Begin
          If fPesqFornecedor(conForSimples, Self, edtCodigo, edtDescri, Nil, chrKey, arrConsulta) Then Begin
            pAtualizarField();
            fGetClientDataSet(tcFornecedores).pVincularRegistroExistente(strCodigo, edtCodigo.Text,
              'IMP_CODVEL', 'IMP_CODAUT', 'FORNECEDOR');
          End;
        End;

      tcProduto:
        Begin
          If fPesqItem(conIteSimples, Self, edtCodigo, edtDescri, Nil, chrKey, arrConsulta) Then Begin
            pAtualizarField();
            fGetClientDataSet(tcProduto).pVincularRegistroExistente(strCodigo, edtCodigo.Text,
              'IMP_CODVEL', 'IMP_CODAUT', 'PRODUTO');
          End;
        End;

      tcDepartamento:
        Begin
          If fPesqDepartamento(Self, edtCodigo, edtDescri, Nil, chrKey, arrConsulta) Then Begin
            pAtualizarField();
            fGetClientDataSet(tcDepartamento).pVincularRegistroExistente(strCodigo, edtCodigo.Text,
              'DEP_CODVEL', 'DEP_CODAUT', 'DEPARTAMENTO');
          End;
        End;

      tcLinhaGrupo:
        Begin
          If fPesqGrupo(Self, edtCodigo, edtDescri, Nil, chrKey, arrConsulta) Then Begin
            pAtualizarField();
            fGetClientDataSet(tcLinhaGrupo).pVincularRegistroExistente(strCodigo, edtCodigo.Text,
              'GRU_CODVEL', 'GRU_CODAUT', 'LINHA/GRUPO');
          End;
        End;

      tcMarca:
        Begin
          If fPesqMarcas(Self, edtCodigo, edtDescri, Nil, chrKey, arrConsulta) Then Begin
            pAtualizarField();
            fGetClientDataSet(tcMarca).pVincularRegistroExistente(strCodigo, edtCodigo.Text,
              'MAR_CODVEL', 'MAR_CODAUT', 'MARCA');
          End;
        End;

      tcUnidade:
        Begin
          If fPesqUnidade(Self, edtCodigo, edtDescri, Nil, Nil, chrKey, arrConsulta) Then Begin
            pAtualizarField();
            fGetClientDataSet(tcUnidade).pVincularRegistroExistente(strCodigo, edtCodigo.Text,
              'UNI_CODVEL', 'UNI_CODAUT', 'UNIDADE');
          End;
        End;

      tcGrupoProduto:
        Begin
          If fPesqGrupoProduto(Self, edtCodigo, edtDescri, Nil, chrKey, arrConsulta) Then Begin
            pAtualizarField();
            fGetClientDataSet(tcGrupoProduto).pVincularRegistroExistente(strCodigo, edtCodigo.Text,
              'GRP_CODVEL', 'GRP_CODAUT', 'GRUPO DE PRODUTO');
          End;
        End;

      tcAtividade:
        Begin
          If fPesqAtividade(Self, edtCodigo, edtDescri, Nil, chrKey, arrConsulta) Then Begin
            pAtualizarField();
            fGetClientDataSet(tcAtividade).pVincularRegistroExistente(strCodigo, edtCodigo.Text,
              'ATI_CODVEL', 'ATI_CODAUT', 'ATIVIDADE');
          End;
        End;
    End;
  Finally
    FreeAndNil(edtCodigo);
    FreeAndNil(edtDescri);
  End;
end;

procedure TfrmImpFranquiaDetalhe.pInicializarGrid;
begin
  If (Not Assigned(cdsTemp)) Then
    cdsTemp := TUniClientDataSet.Create(Self);

  pCloneDataSet(cdsTemp, fGetClientDataSet(tcTipoCad));

  dtsDados.DataSet := cdsTemp;
end;

procedure TfrmImpFranquiaDetalhe.pLimparCampoCodAut(AItem: TcxCustomGridTableItem; strCodAut, strCodVel: String);
begin
  Try
    AItem.EditValue := '';

    If (AItem.Index + 1) < (AItem.GridView.ItemCount) then begin
      AItem.GridView.Items[AItem.Index].EditValue := '';
    end;

    Case (tcTipoCad) Of
      tcFornecedores:
        fGetClientDataSet(tcFornecedores).pLimparRegistroExistente(strCodVel, strCodAut,
          'IMP_CODVEL', 'IMP_CODAUT', 'FORNECEDOR');

      tcProduto:
        fGetClientDataSet(tcProduto).pLimparRegistroExistente(strCodVel, strCodAut,
          'IMP_CODVEL', 'IMP_CODAUT', 'PRODUTO');

      tcDepartamento:
        fGetClientDataSet(tcDepartamento).pLimparRegistroExistente(strCodVel, strCodAut,
          'DEP_CODVEL', 'DEP_CODAUT', 'DEPARTAMENTO');

      tcLinhaGrupo:
        fGetClientDataSet(tcLinhaGrupo).pLimparRegistroExistente(strCodVel, strCodAut,
          'GRU_CODVEL', 'GRU_CODAUT', 'LINHA/GRUPO');

      tcMarca:
        fGetClientDataSet(tcMarca).pLimparRegistroExistente(strCodVel, strCodAut,
          'MAR_CODVEL', 'MAR_CODAUT', 'MARCA');

      tcUnidade:
        fGetClientDataSet(tcUnidade).pLimparRegistroExistente(strCodVel, strCodAut,
          'UNI_CODVEL', 'UNI_CODAUT', 'UNIDADE');

      tcGrupoProduto:
        fGetClientDataSet(tcGrupoProduto).pLimparRegistroExistente(strCodVel, strCodAut,
          'GRP_CODVEL', 'GRP_CODAUT', 'GRUPO DE PRODUTO');

      tcAtividade:
        fGetClientDataSet(tcAtividade).pLimparRegistroExistente(strCodVel, strCodAut,
          'ATI_CODVEL', 'ATI_CODAUT', 'ATIVIDADE');
    End;

    SelectNext(ActiveControl, False, False);
  Except
    On E : Exception Do
		  pMensagensErro(E.Message, '[TfrmImpFranquiaDetalhe.pLimparCampoCodAut]');
  End;
end;

end.
