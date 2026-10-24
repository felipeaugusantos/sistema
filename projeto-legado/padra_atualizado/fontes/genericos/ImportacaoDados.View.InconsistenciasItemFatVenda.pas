unit ImportacaoDados.View.InconsistenciasItemFatVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, dxBarBuiltInMenu,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxPC, DBAccess, Uni,
  Datasnap.DBClient, UniClientDataSet, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls, BitBtnLockedIncrem,
  Vcl.ExtCtrls, ImportacaoDados.Interfaces, untTypesSistema, cxProgressBar,
  ImportacaoDados.Controller.ItemFatVenda, EditFocus;

type
  TfrmInconsistenciasItemFatVenda = class(TfrmPaiConfirma)
    cdsInconsistencias: TUniClientDataSet;
    cdsInconsistenciasCOLUNA: TStringField;
    cdsInconsistenciasCAMPO: TStringField;
    cdsInconsistenciasINCONSISTENCIA: TStringField;
    cdsInconsistenciasNROLINHA: TIntegerField;
    dtsInconsistencias: TUniDataSource;
    dtsCadastros: TUniDataSource;
    cdsCadastros: TUniClientDataSet;
    pcInconsistencias: TcxPageControl;
    tsInconsistencias: TcxTabSheet;
    cxGridInconsistencia: TcxGridCitel;
    cxGridInconsistenciaTableView: TcxGridDBTableViewCitel;
    cxGridInconsistenciaTableViewLinha: TcxGridDBColumn;
    cxGridInconsistenciaTableViewColuna: TcxGridDBColumn;
    cxGridInconsistenciaTableViewCampo: TcxGridDBColumn;
    cxGridInconsistenciaTableViewDescricao: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    tsCadastrosGerados: TcxTabSheet;
    cxGridCamposImportados: TcxGridCitel;
    cxCamposImportadosTableView: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
     function fValidarCampos: Boolean;
    procedure cdsCadastrosBeforePost(DataSet: TDataSet);
    procedure cxCamposImportadosTableViewEditKeyPress(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadIte,
    qryCadUni,
    qryCadEmp,
    qryCadLotArm,
    qryTabPre: TUniQuery;

    ControllerItemFatVenda: TItemFatVendaController;
    blnHabilitaEdicao: Boolean;

    arrProduto: TConsultasArray;
    arrUnidade: TConsultasArray;
    arrEmpresa: TConsultasArray;
    arrLotArm: TConsultasArray;
    arrTabPre: TConsultasArray;

    procedure pCarregarListaInconsistencias;
    procedure pCarregaLinhasParaCadastro;
    procedure pCriarColunasModelo;
    function fConfirmar(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fReprocessar(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fRetornaPesquisaProduto(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaUnidade(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaEmpresa(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaLotArm(Key: Char; aEditValue: String): String;
    function fSetarCampo(const aArray: TConsultasArray; const strValorDefault: String): String;
    function fRetornaValorCampos(strCampo : String) : String;
    function fRetornaValorArray(strCampo : String; arrayCampo : TConsultasArray ) : String;
    Procedure pAlimentarCamposFim(strCampo, strValor : String);
    function  fRetornaValorCamposFloat(strCampo : String) : Double;
    function  fRetornaValorCamposInteger(strCampo : String) : Integer;
    Procedure pAlimentarCamposFimFloat(strCampo : String; fltValor : Double);
    Procedure pAlimentarCamposFimInteger(strCampo : String; intValor : Integer);

  public
    { Public declarations }
    ObjInterfaceImportaPlanilha : IImportaPlanilha;
    ObjInterfaceModeloArquivo   : IModeloArquivoImportacao;
  end;

var
  frmInconsistenciasItemFatVenda: TfrmInconsistenciasItemFatVenda;

implementation

{$R *.dfm}

Uses untFuncoesSimples, untConsultas, untGravando, untCadCid, StrUtils;

procedure TfrmInconsistenciasItemFatVenda.pCarregarListaInconsistencias;
var
  intCnt: Integer;
begin
  cdsInconsistencias.DisableControls;
  Try
    Try
      cdsInconsistencias.IndexFieldNames := 'NROLINHA;COLUNA';
      For intCnt := ObjInterfaceImportaPlanilha.Valida.Inconsistencias.Inconsistencias.Count-1 DownTo 0 Do
      Begin
        cdsInconsistencias.Insert;
        cdsInconsistencias.FieldByName('NROLINHA').AsInteger := ObjInterfaceImportaPlanilha.Valida.Inconsistencias.Inconsistencias[intCnt].NumeroLinha;
        cdsInconsistencias.FieldByName('COLUNA').AsString := ObjInterfaceImportaPlanilha.Valida.Inconsistencias.Inconsistencias[intCnt].Coluna;
        cdsInconsistencias.FieldByName('CAMPO').AsString := ObjInterfaceImportaPlanilha.Valida.Inconsistencias.Inconsistencias[intCnt].Campo;
        cdsInconsistencias.FieldByName('INCONSISTENCIA').AsString := ObjInterfaceImportaPlanilha.Valida.Inconsistencias.Inconsistencias[intCnt].Descricao;
        cdsInconsistencias.Post;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmInconsistenciasImportacao.pCarregarListaInconsistencias]');
      End;
    End;
  Finally
    cdsInconsistencias.EnableControls
  End;
end;

procedure TfrmInconsistenciasItemFatVenda.pCarregaLinhasParaCadastro;
var
  intCnt, intCont, intTotal : Integer;
begin
  blnHabilitaEdicao := False;
  pCriarColunasModelo;
  cdsCadastros.DisableControls;
  Try
    Try
      For intCnt := ObjInterfaceImportaPlanilha.LinhasImportadas.Count-1 DownTo 0 Do
      Begin
        cdsCadastros.Insert;
        cdsCadastros.FieldByName('NROLINHA').AsInteger := ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].NumeroLinha;
        intCont  := 0;
        intTotal := 0;
        While intTotal <= ObjInterfaceModeloArquivo.Campos.Count - 1 Do
        Begin
          If not fEmptyStr(ObjInterfaceModeloArquivo.Campos[intCont].Coluna) Then
          Begin
            If ObjInterfaceModeloArquivo.Campos[intCont].NomeCampo = ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.NomeCampo  Then
            Begin
              If (ObjInterfaceModeloArquivo.Campos[intCont].TipoCampo = ftFloat) Then
              Begin
                Try
                  cdsCadastros.FieldByName(ObjInterfaceModeloArquivo.Campos[intCont].NomeCampo).AsFloat :=
                      IIF(fEmptyStr(ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo),0,
                      IIF(fEhLetra(ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo),0,ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo))
                Except
                  cdsCadastros.FieldByName(ObjInterfaceModeloArquivo.Campos[intCont].NomeCampo).AsFloat := 0.00;
                End;
              End


              Else If (ObjInterfaceModeloArquivo.Campos[intCont].TipoCampo = ftInteger) Then
              Begin
                Try
                  cdsCadastros.FieldByName(ObjInterfaceModeloArquivo.Campos[intCont].NomeCampo).AsInteger :=
                      IIF(fEmptyStr(ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo),0,
                      IIF(fEhLetra(ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo),0,ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo))
                Except
                  cdsCadastros.FieldByName(ObjInterfaceModeloArquivo.Campos[intCont].NomeCampo).AsInteger := 0;
                End;
              End
              Else
              Begin
                If (ObjInterfaceModeloArquivo.Campos[intCont].NomeCampo = cstDtaEntrega) And (not fEmptyStr(ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo)) Then
                Begin
                  Try
                    cdsCadastros.FieldByName(ObjInterfaceModeloArquivo.Campos[intCont].NomeCampo).AsString :=
                        FormatDateTime('dd/mm/yyy',StrToDateTime(fRetornaDataTratada(ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo)))
                  Except
                    cdsCadastros.FieldByName(ObjInterfaceModeloArquivo.Campos[intCont].NomeCampo).AsString := ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo;
                  End;
                End
                Else
                  cdsCadastros.FieldByName(ObjInterfaceModeloArquivo.Campos[intCont].NomeCampo).AsString :=
                      ObjInterfaceImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo;
              End;
              Inc(intCont);

            End;
          End;
          Inc(intTotal);
        End;
        cdsCadastros.Post;
      End;
      blnHabilitaEdicao := ObjInterfaceModeloArquivo.Campos.Count > 0;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmInconsistenciasImportacao.pCarregaLinhasParaCadastro]');
      End;
    End;
  Finally
    cdsCadastros.EnableControls;
  End;
end;

procedure TfrmInconsistenciasItemFatVenda.pCriarColunasModelo;
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
    For intCnt := 0 to ObjInterfaceModeloArquivo.Campos.Count-1 Do
    Begin
      If not fEmptyStr(ObjInterfaceModeloArquivo.Campos[intCnt].Coluna) Then
      Begin
        ObjInterfaceModeloArquivo.Campos[intCnt].Tamanho := IIF(ObjInterfaceModeloArquivo.Campos[intCnt].Tamanho < 0, 300, ObjInterfaceModeloArquivo.Campos[intCnt].Tamanho);
        Case ObjInterfaceModeloArquivo.Campos[intCnt].TipoCampo Of
          ftString  :
            cdsCadastros.FieldDefs.Add(ObjInterfaceModeloArquivo.Campos[intCnt].NomeCampo, ObjInterfaceModeloArquivo.Campos[intCnt].TipoCampo, ObjInterfaceModeloArquivo.Campos[intCnt].Tamanho);
          Else
            cdsCadastros.FieldDefs.Add(ObjInterfaceModeloArquivo.Campos[intCnt].NomeCampo, ObjInterfaceModeloArquivo.Campos[intCnt].TipoCampo);
        End;
      End;
    End;

    cdsCadastros.CreateDataSet;

    If cdsCadastros.FindField(cstQtdeItem) <> Nil Then
      TFloatField(cdsCadastros.FieldByName(cstQtdeItem)).DisplayFormat     := fMskDigitos(fCfgSis('DECQTD', varInteger));
    If cdsCadastros.FindField(cstVlrUnitItem) <> Nil Then
      TFloatField(cdsCadastros.FieldByName(cstVlrUnitItem)).DisplayFormat  := fMskDigitos(fCfgSis('DECUNI', varInteger));
    If cdsCadastros.FindField(cstVlrComDescon) <> Nil Then
      TFloatField(cdsCadastros.FieldByName(cstVlrComDescon)).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    If cdsCadastros.FindField(cstDescontoItem) <> Nil Then
      TFloatField(cdsCadastros.FieldByName(cstDescontoItem)).DisplayFormat := fMskDigitos(fCfgSis('DECDES', varInteger));

    cxCamposImportadosTableView.BeginUpdate;
    cxCamposImportadosTableView.DataController.CreateAllItems(True);
    cxCamposImportadosTableView.GetColumnByFieldName('NROLINHA').Caption := 'Linha';
    cxCamposImportadosTableView.GetColumnByFieldName('NROLINHA').Options.Editing := False;
    For intCnt := 0 To ObjInterfaceModeloArquivo.Campos.Count-1 Do
    Begin
      If not fEmptyStr(ObjInterfaceModeloArquivo.Campos[intCnt].Coluna) Then
        cxCamposImportadosTableView.GetColumnByFieldName(ObjInterfaceModeloArquivo.Campos[intCnt].NomeCampo).Caption := ObjInterfaceModeloArquivo.Campos[intCnt].Descricao;
    End;
    cxCamposImportadosTableView.EndUpdate;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmInconsistenciasImportacao.pCriarColunasModelo]');
    End;
  End;
end;

function TfrmInconsistenciasItemFatVenda.fConfirmar(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  Result := True;
  If ObjInterfaceImportaPlanilha.Valida.Inconsistencias.Inconsistencias.Count > 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Na validação do arquivo foram encontrados registros com inconsistências. '+
                          'Por favor, verifique as inconsistências e se for necessário, ' +
                          'ajuste a planilha para uma nova importação', ['&Ok']);
    Result := False;
    ModalResult := mrNone;
    pcInconsistencias.ActivePageIndex := 0;
  End
  Else
    ModalResult := mrOK;
end;

function TfrmInconsistenciasItemFatVenda.fReprocessar(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  Try
    cdsInconsistencias.Close;
    cdsInconsistencias.CreateDataSet;
    ObjInterfaceImportaPlanilha.fAtualizarDadosImportados(cdsCadastros);
    Result := ObjInterfaceImportaPlanilha.Valida.Inconsistencias.Inconsistencias.Count <= 0;

    pCarregarListaInconsistencias;
    pCarregaLinhasParaCadastro;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmInconsistenciasImportacao.pReprocessar]');
    End;
  End;
end;

function TfrmInconsistenciasItemFatVenda.fRetornaPesquisaProduto(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqItem(conIteSimples, Self, Nil, Nil, qryCadIte, Key, arrProduto, False) Then
  Begin
    Result := qryCadIte.FieldByName('ITE_CODITE').AsString;
  End;
End;

function TfrmInconsistenciasItemFatVenda.fRetornaPesquisaUnidade(Key: Char; aEditValue: String): String;
Var edtSigla : TEditFocus;
Begin
  Result := aEditValue;
  Try
    edtSigla :=  TEditFocus.Create(Self);

    If fPesqUnidade(Self, Nil, Nil, edtSigla, qryCadUni, Key, arrUnidade, False) Then
    Begin
      Result := qryCadUni.FieldByName('UNI_SIGUNI').AsString;
    End;
  Finally
    FreeAndNil(edtSigla);
  End;
End;

function TfrmInconsistenciasItemFatVenda.fRetornaPesquisaEmpresa(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqEmpresa(conEmpSimples, Self, Nil, Nil, qryCadEmp, Key, arrEmpresa, False) Then
  Begin
    Result := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
  End;
End;

function TfrmInconsistenciasItemFatVenda.fRetornaPesquisaLotArm(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqLoteFat(Self, Nil, fCfgSis('DECUNI'), cdsCadastros.FieldByName(cstCodItem).AsString, False, False,
                    qryCadLotArm, Key, arrLotArm, fRetornaValorCampos(cstEmpFat)) Then
  Begin
    Result := qryCadLotArm.FieldByName('LOT_NUMLOT').AsString;
  End;
End;

function TfrmInconsistenciasItemFatVenda.fSetarCampo(const aArray: TConsultasArray;
  const strValorDefault: String): String;
begin
  If aArray <> Nil Then
    Result := aArray[0].strCodigo
  Else
    Result := strValorDefault;
end;

function TfrmInconsistenciasItemFatVenda.fValidarCampos: Boolean;
begin
  Result := True;

  If Not blnHabilitaEdicao Then
    Exit;

  ControllerItemFatVenda.ItemFatVenda.CodItem       := fRetornaValorCampos(cstCodItem);
  ControllerItemFatVenda.ItemFatVenda.QtdeItem      := fRetornaValorCamposFloat(cstQtdeItem);
  ControllerItemFatVenda.ItemFatVenda.DestinoItem   := fRetornaValorCampos(cstDestinoItem);
  ControllerItemFatVenda.ItemFatVenda.VlrUnitItem   := fRetornaValorCamposFloat(cstVlrUnitItem);
  ControllerItemFatVenda.ItemFatVenda.VlrComDescon  := fRetornaValorCamposFloat(cstVlrComDescon);
  ControllerItemFatVenda.ItemFatVenda.DescontoItem  := fRetornaValorCamposFloat(cstDescontoItem);
  ControllerItemFatVenda.ItemFatVenda.TabPreCad     := fRetornaValorCampos(cstTabPreCad);
  ControllerItemFatVenda.ItemFatVenda.ComplItem     := fRetornaValorCampos(cstComplItem);
  ControllerItemFatVenda.ItemFatVenda.UnidadeItem   := fRetornaValorCampos(cstUnidadeItem);
  ControllerItemFatVenda.ItemFatVenda.EmpFat        := fRetornaValorCampos(cstEmpFat);
  ControllerItemFatVenda.ItemFatVenda.LoteArm       := fRetornaValorCampos(cstLoteArm);
  ControllerItemFatVenda.ItemFatVenda.LocRet        := fRetornaValorCampos(cstLocRet);
  ControllerItemFatVenda.ItemFatVenda.TpEntrega     := fRetornaValorCampos(cstTpEntrega);
  ControllerItemFatVenda.ItemFatVenda.Motivo        := fRetornaValorCampos(cstMotivo);
  ControllerItemFatVenda.ItemFatVenda.CliRetira     := fRetornaValorCampos(cstCliRetira);
  ControllerItemFatVenda.ItemFatVenda.DiasEntrega   := fRetornaValorCamposInteger(cstDiasEntrega);
  ControllerItemFatVenda.ItemFatVenda.strDtaEntrega := fRetornaValorCampos(cstDtaEntrega);
  ControllerItemFatVenda.ItemFatVenda.Pegou         := fRetornaValorCampos(cstPegou);
  ControllerItemFatVenda.ItemFatVenda.Brinde        := fRetornaValorCampos(cstBrinde);

  ControllerItemFatVenda.ItemFatVenda.CodItem       := fRetornaValorArray(cstCodItem,arrProduto);
  ControllerItemFatVenda.ItemFatVenda.TabPreCad     := fRetornaValorArray(cstTabPreCad,arrTabPre);
  ControllerItemFatVenda.ItemFatVenda.EmpFat        := fRetornaValorArray(cstEmpFat,arrEmpresa);
  ControllerItemFatVenda.ItemFatVenda.LoteArm       := fRetornaValorArray(cstLoteArm,arrLotArm);
  ControllerItemFatVenda.ItemFatVenda.UnidadeItem   := fRetornaValorArray(cstUnidadeItem,arrUnidade);

  Result := ControllerItemFatVenda.Validacao.Executar(True);

  If Result Then
  Begin
    pAlimentarCamposFim(cstCodItem, ControllerItemFatVenda.ItemFatVenda.CodItem);
    pAlimentarCamposFimFloat(cstQtdeItem, ControllerItemFatVenda.ItemFatVenda.QtdeItem);
    pAlimentarCamposFim(cstDestinoItem, ControllerItemFatVenda.ItemFatVenda.DestinoItem);
    pAlimentarCamposFimFloat(cstVlrUnitItem, ControllerItemFatVenda.ItemFatVenda.VlrUnitItem);
    pAlimentarCamposFimFloat(cstVlrComDescon, ControllerItemFatVenda.ItemFatVenda.VlrComDescon);
    pAlimentarCamposFimFloat(cstDescontoItem, ControllerItemFatVenda.ItemFatVenda.DescontoItem);
    pAlimentarCamposFim(cstTabPreCad, ControllerItemFatVenda.ItemFatVenda.TabPreCad);
    pAlimentarCamposFim(cstComplItem, ControllerItemFatVenda.ItemFatVenda.ComplItem);
    pAlimentarCamposFim(cstUnidadeItem, ControllerItemFatVenda.ItemFatVenda.UnidadeItem);
    pAlimentarCamposFim(cstEmpFat, ControllerItemFatVenda.ItemFatVenda.EmpFat);
    pAlimentarCamposFim(cstLoteArm, ControllerItemFatVenda.ItemFatVenda.LoteArm);
    pAlimentarCamposFim(cstLocRet, ControllerItemFatVenda.ItemFatVenda.LocRet);
    pAlimentarCamposFim(cstTpEntrega, ControllerItemFatVenda.ItemFatVenda.TpEntrega);
    pAlimentarCamposFim(cstMotivo, ControllerItemFatVenda.ItemFatVenda.Motivo);
    pAlimentarCamposFim(cstCliRetira, ControllerItemFatVenda.ItemFatVenda.CliRetira);
    pAlimentarCamposFimInteger(cstDiasEntrega, ControllerItemFatVenda.ItemFatVenda.DiasEntrega);
    pAlimentarCamposFim(cstDtaEntrega, ControllerItemFatVenda.ItemFatVenda.strDtaEntrega);
    pAlimentarCamposFim(cstPegou, ControllerItemFatVenda.ItemFatVenda.Pegou);
    pAlimentarCamposFim(cstBrinde, ControllerItemFatVenda.ItemFatVenda.Brinde);
  End;

  SetLength(arrProduto, 0);
  SetLength(arrTabPre, 0);
  SetLength(arrEmpresa, 0);
  SetLength(arrLotArm, 0);
  SetLength(arrUnidade, 0);
end;

procedure TfrmInconsistenciasItemFatVenda.btnConfirmaClick(Sender: TObject);
var
  frmAguarde: TfrmGravando;
begin
  inherited;

  Try
    TfrmGravando.fExecuta(fReprocessar, frmAguarde, 'Aguarde...Processando dados para importação', False);
    TfrmGravando.fExecuta(fConfirmar, frmAguarde, 'Aguarde...Gerando inserção dos Itens', False);
  Finally
    pFreeAndNil(frmAguarde);
  End;
end;

procedure TfrmInconsistenciasItemFatVenda.cdsCadastrosBeforePost(
  DataSet: TDataSet);
begin
  inherited;
  fValidarCampos;
end;

procedure TfrmInconsistenciasItemFatVenda.cxCamposImportadosTableViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  try

    If (AItem as TcxGridDBColumn).DataBinding.FieldName = cstCodItem Then
    Begin
      If fEntraCons(Key) Then
      Begin
        fRetornaPesquisaProduto(Key, AItem.EditValue);
        Key := #0;
        AEdit.EditValue := EmptyStr;
        AEdit.PostEditValue;
        Key := #0;
        Keybd_Event(VK_RETURN, 0, 0, 0);
      End;
    End;

    If (AItem as TcxGridDBColumn).DataBinding.FieldName = cstUnidadeItem Then
    Begin
      If fEntraCons(Key)  Then
      Begin
        fRetornaPesquisaUnidade(Key, AItem.EditValue);
        Key := #0;
        AEdit.EditValue := EmptyStr;
        AEdit.PostEditValue;
        Key := #0;
        Keybd_Event(VK_RETURN, 0, 0, 0);
      End;
    End;

    If (AItem as TcxGridDBColumn).DataBinding.FieldName = cstEmpFat Then
    Begin
      If fEntraCons(Key) Then
      Begin
        fRetornaPesquisaEmpresa(Key, AItem.EditValue);
        Key := #0;
        AEdit.EditValue := EmptyStr;
        AEdit.PostEditValue;
        Key := #0;
        Keybd_Event(VK_RETURN, 0, 0, 0);
      End;
    End;

    If (AItem as TcxGridDBColumn).DataBinding.FieldName = cstLoteArm Then
    Begin
      If fEntraCons(Key)  Then
      Begin
        fRetornaPesquisaLotArm(Key, AItem.EditValue);
        Key := #0;
        AEdit.EditValue := EmptyStr;
        AEdit.PostEditValue;
        Key := #0;
        Keybd_Event(VK_RETURN, 0, 0, 0);
      End;
    End;
    inherited;
  except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmInconsistenciasImportacao.cxCamposImportadosTableViewEditKeyPress]');
    End;
  end;
end;

procedure TfrmInconsistenciasItemFatVenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadIte);
  FreeAndNil(qryCadUni);
  FreeAndNil(qryCadEmp);
  FreeAndNil(qryCadLotArm);
  FreeAndNil(qryTabPre);
  FreeAndNil(ControllerItemFatVenda);
end;

procedure TfrmInconsistenciasItemFatVenda.FormCreate(Sender: TObject);
begin
  inherited;
  ControllerItemFatVenda := TItemFatVendaController.Create;

  qryCadIte := fCriaQuery(Self);
  qryCadIte.SQL.Add('SELECT * FROM CADITE WHERE FALSE');
  qryCadIte.Open;

  qryCadUni := fCriaQuery(Self);
  qryCadUni.SQL.Add('SELECT * FROM CADUNI WHERE FALSE');
  qryCadUni.Open;

  qryCadEmp := fCriaQuery(Self);
  qryCadEmp.SQL.Add('SELECT * FROM CADEMP WHERE FALSE');
  qryCadEmp.Open;

  qryCadLotArm := fCriaQuery(Self);
  If (fCfgSis('CTLEST') = 1) Then
    qryCadLotArm.SQL.Add('SELECT * FROM CADLOT WHERE FALSE')
  Else
    qryCadLotArm.SQL.Add('SELECT * FROM CADAMZ WHERE FALSE');
  qryCadLotArm.Open;

  qryTabPre := fCriaQuery(Self);
  qryTabPre.SQL.Add('SELECT * FROM TABPRE WHERE FALSE');
  qryTabPre.Open;

  blnHabilitaEdicao := False;
end;

procedure TfrmInconsistenciasItemFatVenda.FormShow(Sender: TObject);
begin
  inherited;
  cdsInconsistencias.CreateDataSet;

  pCarregaLinhasParaCadastro;
  If ObjInterfaceImportaPlanilha.Valida.Inconsistencias.Inconsistencias.Count > 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Na validação do arquivo foram encontrados registros com inconsistências. '+
                          'Por favor, verifique as inconsistências e se for necessário, ' +
                          'ajuste a planilha para uma nova importação.', ['&Ok']);

    pCarregarListaInconsistencias;
    pcInconsistencias.ActivePageIndex := 0;
  End
  Else
    pcInconsistencias.ActivePageIndex := 1;
end;

function TfrmInconsistenciasItemFatVenda.fRetornaValorCampos(strCampo : String) : String;
Begin
  If (cdsCadastros.FindField(strCampo) <> Nil) Then
    Result  := cdsCadastros.FieldByName(strCampo).AsString
  Else
    Result  := '';
End;

function TfrmInconsistenciasItemFatVenda.fRetornaValorCamposFloat(strCampo : String) : Double;
Begin
  If (cdsCadastros.FindField(strCampo) <> Nil) Then
    Result  := cdsCadastros.FieldByName(strCampo).asFloat
  Else
    Result  := 0;
End;

function TfrmInconsistenciasItemFatVenda.fRetornaValorCamposInteger(strCampo : String) : Integer;
Begin
  If (cdsCadastros.FindField(strCampo) <> Nil) Then
    Result  := cdsCadastros.FieldByName(strCampo).asInteger
  Else
    Result  := 0;
End;

function TfrmInconsistenciasItemFatVenda.fRetornaValorArray(strCampo : String; arrayCampo : TConsultasArray ) : String;
Begin
  If (cdsCadastros.FindField(strCampo) <> Nil) Then
    Result  := fSetarCampo(arrayCampo, cdsCadastros.FieldByName(strCampo).AsString)
  Else
    Result  := '';
End;

Procedure TfrmInconsistenciasItemFatVenda.pAlimentarCamposFim(strCampo, strValor : String);
Begin
  If (cdsCadastros.FindField(strCampo) <> Nil) Then
    cdsCadastros.FieldByName(strCampo).AsString  := strValor;
End;

Procedure TfrmInconsistenciasItemFatVenda.pAlimentarCamposFimFloat(strCampo : String; fltValor : Double);
Begin
  If (cdsCadastros.FindField(strCampo) <> Nil) Then
    cdsCadastros.FieldByName(strCampo).asFloat  := fltValor;
End;

Procedure TfrmInconsistenciasItemFatVenda.pAlimentarCamposFimInteger(strCampo : String; intValor : Integer);
Begin
  If (cdsCadastros.FindField(strCampo) <> Nil) Then
    cdsCadastros.FieldByName(strCampo).asInteger  := intValor;
End;



end.

