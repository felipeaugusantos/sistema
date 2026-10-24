unit ImportacaoDados.View.InconsistenciasProspecto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxPC, ImportacaoDados.Interfaces,
  DBAccess, Uni, Datasnap.DBClient, UniClientDataSet, untTypesSistema, cxProgressBar,
  ImportacaoDados.Controller.Prospecto;


type
  TfrmInconsistenciasProspecto = class(TfrmPaiConfirma)
    pcInconsistencias: TcxPageControl;
    tsInconsistencias: TcxTabSheet;
    tsCadastrosGerados: TcxTabSheet;
    cxGridCitel2: TcxGridCitel;
    cxGridDBTableViewCitel2: TcxGridDBTableViewCitel;
    cxGridLevel2: TcxGridLevel;
    cxGridInconsistenciaTableViewLinha: TcxGridDBColumn;
    cxGridInconsistenciaTableViewColuna: TcxGridDBColumn;
    cxGridInconsistenciaTableViewCampo: TcxGridDBColumn;
    cxGridInconsistenciaTableViewDescricao: TcxGridDBColumn;
    cdsInconsistencias: TUniClientDataSet;
    dtsInconsistencias: TUniDataSource;
    cdsCadastros: TUniClientDataSet;
    dtsCadastros: TUniDataSource;
    cdsInconsistenciasCOLUNA: TStringField;
    cdsInconsistenciasCAMPO: TStringField;
    cdsInconsistenciasINCONSISTENCIA: TStringField;
    cdsInconsistenciasNROLINHA: TIntegerField;
    cxGridCamposImportados: TcxGridCitel;
    cxCamposImportadosTableView: TcxGridDBTableViewCitel;
    cxGridLevel1: TcxGridLevel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxCamposImportadosTableViewEditKeyPress(
      Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
      AEdit: TcxCustomEdit; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function fValidarCampos: Boolean;
    procedure cdsCadastrosBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    qryCadCid,
    qryCadOpe,
    qryCadAti,
    qryCadRed,
    qryCrmFre,
    qryCrmPor,
    qryCrmCat,
    qryCrmFai,
    qryCrmFor,
    qryCadReg: TUniQuery;

    ControllerProspecto: TProspectoController;
    blnHabilitaEdicao: Boolean;

    arrCidade: TConsultasArray;
    arrAtividade: TConsultasArray;
    arrVendedor: TConsultasArray;
    arrRedeLojas: TConsultasArray;
    arrCrmFre: TConsultasArray;
    arrCrmPor: TConsultasArray;
    arrCrmCat: TConsultasArray;
    arrCrmFai: TConsultasArray;
    arrFor: TConsultasArray;
    arrRepresentante: TConsultasArray;
    arrCodReg: TConsultasArray;

    strNumCep: string;

    procedure pCarregarListaInconsistencias;
    procedure pCarregaLinhasParaCadastro;
    procedure pCriarColunasModelo;
    function fGerarCadastros: Boolean;
    function fConfirmar(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fReprocessar(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fRetornaPesquisaCidade(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaAtividade(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaVendedor(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaRedeLojas(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaCrmFrequencia(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaCrmPorte(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaCrmCategoria(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaCrmFaixaEstimativa(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaCep(Key: Char; aEditValue: string): String;
    function fRetornaPesquisaCrmFornecedor(Key: Char; aEditValue: String): String;
    function fSetarCampo(Const aArray: TConsultasArray; Const strValorDefault: String): String;
    function fRetornaPesquisaRepresentante(Key: Char; aEditValue: String): String;
    function fRetornaPesquisaRegiao(Key: Char; aEditValue: String): String;
  public
    { Public declarations }
    ObjImportaPlanilha: IImportaPlanilha;
    ObjModeloArquivo: IModeloArquivoImportacao;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untGravando, untCadCid, StrUtils;

{$R *.dfm}

procedure TfrmInconsistenciasProspecto.btnConfirmaClick(Sender: TObject);
var
  frmAguarde: TfrmGravando;
begin
  inherited;

  Try
    TfrmGravando.fExecuta(fReprocessar, frmAguarde, 'Aguarde...Processando dados para importação', False);
    TfrmGravando.fExecuta(fConfirmar, frmAguarde, 'Aguarde...Gerando cadastro de prospectos', False);
  Finally
    pFreeAndNil(frmAguarde);
  End;

end;

function TfrmInconsistenciasProspecto.fRetornaPesquisaCidade(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqCidade(Self, Nil, Nil, Nil, qryCadCid, Key, arrCidade, False) Then
  Begin
    Result := qryCadCid.FieldByName('CID_CODCID').AsString;
  End;
End;

function TfrmInconsistenciasProspecto.fRetornaPesquisaAtividade(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqAtividade(Self, Nil, Nil, qryCadAti, Key, arrAtividade, False) Then
  Begin
    Result := qryCadAti.FieldByName('ATI_CODATI').AsString;
  End;
End;

function TfrmInconsistenciasProspecto.fRetornaPesquisaVendedor(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqOperador(Self, Nil, Nil, qryCadOpe, Key, arrVendedor, False)  Then
  Begin
    Result := qryCadOpe.FieldByName('OPE_CODOPE').AsString;
  End;
End;

function TfrmInconsistenciasProspecto.fSetarCampo(const aArray: TConsultasArray;
  const strValorDefault: String): String;
begin
  If aArray <> Nil Then
    Result := aArray[0].strCodigo
  Else
    Result := strValorDefault;
end;

function TfrmInconsistenciasProspecto.fValidarCampos: Boolean;
begin
  Result := True;

  If Not blnHabilitaEdicao Then
    Exit;

  ControllerProspecto.Prospecto.NomCid := cdsCadastros.FieldByName(cstNomCid).AsString;
  ControllerProspecto.Prospecto.NomVen := cdsCadastros.FieldByName(cstNomVen).AsString;
  ControllerProspecto.Prospecto.DesAti := cdsCadastros.FieldByName(cstDesAti).AsString;
  ControllerProspecto.Prospecto.DesRed := cdsCadastros.FieldByName(cstDesRed).AsString;
  ControllerProspecto.Prospecto.DesFre := cdsCadastros.FieldByName(cstDesFre).AsString;
  ControllerProspecto.Prospecto.Desfai := cdsCadastros.FieldByName(cstDesFai).AsString;
  ControllerProspecto.Prospecto.DesPor := cdsCadastros.FieldByName(cstDesPor).AsString;
  ControllerProspecto.Prospecto.DesCat := cdsCadastros.FieldByName(cstDesCat).AsString;
  ControllerProspecto.Prospecto.DesFor := cdsCadastros.FieldByName(cstDesFor).AsString;
  ControllerProspecto.Prospecto.NumCep := cdsCadastros.FieldByName(cstProCep).AsString;
  ControllerProspecto.Prospecto.NomRep := cdsCadastros.FieldByName(cstNomRep).AsString;
  ControllerProspecto.Prospecto.DesReg := cdsCadastros.FieldByName(cstDesReg).AsString;

  ControllerProspecto.Prospecto.CodCid := fSetarCampo(arrCidade, cdsCadastros.FieldByName(cstCodCid).AsString);
  ControllerProspecto.Prospecto.CodVen := fSetarCampo(arrVendedor, cdsCadastros.FieldByName(cstCodVen).AsString);
  ControllerProspecto.Prospecto.CodAti := fSetarCampo(arrAtividade, cdsCadastros.FieldByName(cstCodAti).AsString);
  ControllerProspecto.Prospecto.CodRed := fSetarCampo(arrRedeLojas, cdsCadastros.FieldByName(cstCodRed).AsString);
  ControllerProspecto.Prospecto.CrmFre := fSetarCampo(arrCrmFre, cdsCadastros.FieldByName(cstCrmFre).AsString);
  ControllerProspecto.Prospecto.CrmPor := fSetarCampo(arrCrmPor, cdsCadastros.FieldByName(cstCrmPor).AsString);
  ControllerProspecto.Prospecto.CrmCat := fSetarCampo(arrCrmCat, cdsCadastros.FieldByName(cstCrmCat).AsString);
  ControllerProspecto.Prospecto.CrmFai := fSetarCampo(arrCrmFai, cdsCadastros.FieldByName(cstCrmFai).AsString);
  ControllerProspecto.Prospecto.CrmFor := fSetarCampo(arrFor, cdsCadastros.FieldByName(cstCrmFor).AsString);
  ControllerProspecto.Prospecto.NumCep := IfThen(Not fEmptyStr(strNumCep), strNumCep, ControllerProspecto.Prospecto.NumCep);
  ControllerProspecto.Prospecto.CodRep := fSetarCampo(arrRepresentante, cdsCadastros.FieldByName(cstCodRep).AsString);
  ControllerProspecto.Prospecto.CodReg := fSetarCampo(arrCodReg, cdsCadastros.FieldByName(cstCodReg).AsString);

  Result := ControllerProspecto.Validacao.Executar(True);

  If Result Then
  Begin
    cdsCadastros.FieldByName(cstNomCid).AsString := ControllerProspecto.Prospecto.NomCid;
    cdsCadastros.FieldByName(cstCodCid).AsString := ControllerProspecto.Prospecto.CodCid;
    cdsCadastros.FieldByName(cstDesAti).AsString := ControllerProspecto.Prospecto.DesAti;
    cdsCadastros.FieldByName(cstCodAti).AsString := ControllerProspecto.Prospecto.CodAti;
    cdsCadastros.FieldByName(cstNomVen).AsString := ControllerProspecto.Prospecto.NomVen;
    cdsCadastros.FieldByName(cstCodVen).AsString := ControllerProspecto.Prospecto.CodVen;
    cdsCadastros.FieldByName(cstDesRed).AsString := ControllerProspecto.Prospecto.DesRed;
    cdsCadastros.FieldByName(cstCodRed).AsString := ControllerProspecto.Prospecto.CodRed;
    cdsCadastros.FieldByName(cstDesFre).AsString := ControllerProspecto.Prospecto.DesFre;
    cdsCadastros.FieldByName(cstCrmFre).AsString := ControllerProspecto.Prospecto.CrmFre;
    cdsCadastros.FieldByName(cstDesFai).AsString := ControllerProspecto.Prospecto.DesFai;
    cdsCadastros.FieldByName(cstCrmFai).AsString := ControllerProspecto.Prospecto.CrmFai;
    cdsCadastros.FieldByName(cstDesPor).AsString := ControllerProspecto.Prospecto.DesPor;
    cdsCadastros.FieldByName(cstCrmPor).AsString := ControllerProspecto.Prospecto.CrmPor;
    cdsCadastros.FieldByName(cstDesCat).AsString := ControllerProspecto.Prospecto.DesCat;
    cdsCadastros.FieldByName(cstCrmCat).AsString := ControllerProspecto.Prospecto.CrmCat;
    cdsCadastros.FieldByName(cstDesFor).AsString := ControllerProspecto.Prospecto.DesFor;
    cdsCadastros.FieldByName(cstCrmFor).AsString := ControllerProspecto.Prospecto.CrmFor;
    cdsCadastros.FieldByName(cstCodRep).AsString := ControllerProspecto.Prospecto.CodRep;
    cdsCadastros.FieldByName(cstNomRep).AsString := ControllerProspecto.Prospecto.NomRep;
    If fEmptyStr(cdsCadastros.FieldByName(cstEndere).AsString) Then
      If ControllerProspecto.Validacao.AtualizarEndereco Then
        cdsCadastros.FieldByName(cstEndere).AsString := ControllerProspecto.Prospecto.Endere;
    If fEmptyStr(cdsCadastros.FieldByName(cstBairro).AsString) Then
      If ControllerProspecto.Validacao.AtualizarEndereco Then
        cdsCadastros.FieldByName(cstBairro).AsString := ControllerProspecto.Prospecto.Bairro;
    If fEmptyStr(cdsCadastros.FieldByName(cstCodCid).AsString) Then
      If ControllerProspecto.Validacao.AtualizarEndereco Then
        cdsCadastros.FieldByName(cstCodCid).AsString := ControllerProspecto.Prospecto.CodCid;
    If fEmptyStr(cdsCadastros.FieldByName(cstNomCid).AsString) Then
      If ControllerProspecto.Validacao.AtualizarEndereco Then
        cdsCadastros.FieldByName(cstNomCid).AsString := ControllerProspecto.Prospecto.NomCid;
    cdsCadastros.FieldByName(cstCodReg).AsString := ControllerProspecto.Prospecto.CodReg;
    cdsCadastros.FieldByName(cstDesReg).AsString := ControllerProspecto.Prospecto.DesReg;
  End;

  strNumCep := EmptyStr;
  SetLength(arrCidade, 0);
  SetLength(arrAtividade, 0);
  SetLength(arrVendedor, 0);
  SetLength(arrRedeLojas, 0);
  SetLength(arrCrmFre, 0);
  SetLength(arrCrmPor, 0);
  SetLength(arrCrmCat, 0);
  SetLength(arrCrmFai, 0);
  SetLength(arrFor, 0);
  SetLength(arrRepresentante, 0);
  SetLength(arrCodReg, 0);
end;

function TfrmInconsistenciasProspecto.fRetornaPesquisaRedeLojas(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqRedeLojas(Self, Nil, Nil, qryCadRed, Key, arrRedeLojas, False) Then
  Begin
    Result := qryCadRed.FieldByName('RED_CODRED').AsString;
  End;
End;

function TfrmInconsistenciasProspecto.fRetornaPesquisaRegiao(Key: Char;
  aEditValue: String): String;
begin
  Result := aEditValue;

  If fPesqRegiao(Self, Nil, Nil, qryCadReg, Key, arrCodReg, False)  Then
  Begin
    Result := qryCadReg.FieldByName('REG_CODREG').AsString;
  End;
end;

function TfrmInconsistenciasProspecto.fRetornaPesquisaRepresentante(Key: Char;
  aEditValue: String): String;
begin
  Result := aEditValue;

  If fPesqOperador(Self, Nil, Nil, qryCadOpe, Key, arrRepresentante, False)  Then
  Begin
    Result := qryCadOpe.FieldByName('OPE_CODOPE').AsString;
  End;
end;

function TfrmInconsistenciasProspecto.fRetornaPesquisaCrmFrequencia(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqFrequenciaCRM(Self, Nil, Nil, qryCrmFre, Key, arrCrmFre, False) Then
  Begin
    Result := qryCrmFre.FieldByName('CRF_CODIGO').AsString;
  End;
End;

function TfrmInconsistenciasProspecto.fRetornaPesquisaCrmPorte(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If  fPesqPorteCRM(Self, Nil, Nil, qryCrmPor, Key, arrCrmPor, False) Then
  Begin
    Result := qryCrmPor.FieldByName('CRP_CODIGO').AsString;
  End;
End;

function TfrmInconsistenciasProspecto.fRetornaPesquisaCrmCategoria(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqCategoriaCRM(Self, Nil, Nil, qryCrmCat, Key, arrCrmCat, False) Then
  Begin
    Result := qryCrmCat.FieldByName('CAT_CODIGO').AsString;
  End;
End;

function TfrmInconsistenciasProspecto.fRetornaPesquisaCrmFaixaEstimativa(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqFaixaFaturamentoCRM(Self, Nil, Nil, qryCrmFai, Key, arrCrmFai, False) Then
  Begin
    Result := qryCrmFai.FieldByName('CRF_CODIGO').AsString;
  End;
End;

function TfrmInconsistenciasProspecto.fRetornaPesquisaCrmFornecedor(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If fPesqFornecedorAtualCRM(Self, Nil, Nil, qryCrmFor, Key, arrFor) Then
  Begin
    Result := qryCrmFor.FieldByName('CRF_CODIGO').AsString;
  End;
End;

function TfrmInconsistenciasProspecto.fRetornaPesquisaCep(Key: Char; aEditValue: String): String;
Begin
  Result := aEditValue;

  If Not fEntraCons(Key) Then
    Exit;

  If (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Result := fConsultarCep(Self, aEditValue, Nil);
  End;
End;

procedure TfrmInconsistenciasProspecto.cdsCadastrosBeforePost(
  DataSet: TDataSet);
begin
  inherited;

  fValidarCampos;
end;

procedure TfrmInconsistenciasProspecto.cxCamposImportadosTableViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin

  Try

    Case AnsiIndexStr(UpperCase((AItem as TcxGridDBColumn).DataBinding.FieldName), [cstCodCid,
                                                                                     cstCodAti,
                                                                                     cstCodVen,
                                                                                     cstCodRed,
                                                                                     cstCrmFre,
                                                                                     cstCrmPor,
                                                                                     cstCrmCat,
                                                                                     cstCrmFai,
                                                                                     cstCrmFor,
                                                                                     cstProCep,
                                                                                     cstCodRep,
                                                                                     cstCodReg
                                                                                     ]) Of
      0: Begin
           fRetornaPesquisaCidade(Key, AItem.EditValue);
           AEdit.EditValue := EmptyStr;
         End;
      1: Begin
           fRetornaPesquisaAtividade(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
         End;
      2: Begin
           fRetornaPesquisaVendedor(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
         End;
      3: Begin
           fRetornaPesquisaRedeLojas(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
         End;
      4: Begin
           fRetornaPesquisaCrmFrequencia(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
         End;
      5: Begin
           fRetornaPesquisaCrmPorte(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
         End;
      6: Begin
           fRetornaPesquisaCrmCategoria(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
         End;
      7: Begin
           fRetornaPesquisaCrmFaixaEstimativa(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
         End;
      8: Begin
           fRetornaPesquisaCrmFornecedor(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
         End;
      9: Begin
           strNumCep := fRetornaPesquisaCep(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
         End;
     10: Begin
           fRetornaPesquisaRepresentante(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
         End;
     11: Begin
           fRetornaPesquisaRegiao(Key, AItem.EditValue);
           AEdit.EditValue  :=  EmptyStr;
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

procedure TfrmInconsistenciasProspecto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(qryCadCid);
  FreeAndNil(qryCadOpe);
  FreeAndNil(qryCadAti);
  FreeAndNil(qryCadRed);
  FreeAndNil(qryCrmFre);
  FreeAndNil(qryCrmPor);
  FreeAndNil(qryCrmCat);
  FreeAndNil(qryCrmFai);
  FreeAndNil(qryCrmFor);
  FreeAndNil(ControllerProspecto);
  FreeAndNil(qryCadReg);
end;

procedure TfrmInconsistenciasProspecto.FormCreate(Sender: TObject);
begin
  inherited;

  ControllerProspecto := TProspectoController.Create;

  qryCadCid := fCriaQuery(Self);
  qryCadCid.SQL.Add('SELECT * FROM CADCID WHERE FALSE');
  qryCadCid.Open;

  qryCadOpe := fCriaQuery(Self);
  qryCadOpe.SQL.Add('SELECT * FROM CADOPE WHERE FALSE');
  qryCadOpe.Open;

  qryCadAti := fCriaQuery(Self);
  qryCadAti.SQL.Add('SELECT * FROM CADATI WHERE FALSE');
  qryCadAti.Open;

  qryCadRed := fCriaQuery(Self);
  qryCadRed.SQL.Add('SELECT * FROM CADRED WHERE FALSE');
  qryCadRed.Open;

  qryCrmFre := fCriaQuery(Self);
  qryCrmFre.SQL.Add('SELECT * FROM CRMFRE WHERE FALSE');
  qryCrmFre.Open;

  qryCrmPor := fCriaQuery(Self);
  qryCrmPor.SQL.Add('SELECT * FROM CRMPOR WHERE FALSE');
  qryCrmPor.Open;

  qryCrmCat := fCriaQuery(Self);
  qryCrmCat.SQL.Add('SELECT * FROM CRMCAT WHERE FALSE');
  qryCrmCat.Open;

  qryCrmFai := fCriaQuery(Self);
  qryCrmFai.SQL.Add('SELECT * FROM CRMFAI WHERE FALSE');
  qryCrmFai.Open;

  qryCrmFor := fCriaQuery(Self);
  qryCrmFor.SQL.Add('SELECT * FROM CRMFOR WHERE FALSE');
  qryCrmFor.Open;

  qryCadReg := fCriaQuery(Self);
  qryCadReg.SQL.Add('SELECT * FROM CADREG WHERE FALSE');
  qryCadReg.Open;

  blnHabilitaEdicao := False;

end;

procedure TfrmInconsistenciasProspecto.FormShow(Sender: TObject);
begin
  inherited;

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

end;

procedure TfrmInconsistenciasProspecto.pCriarColunasModelo;
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
      ObjModeloArquivo.Campos[intCnt].Tamanho := IIF(ObjModeloArquivo.Campos[intCnt].Tamanho < 0, 300, ObjModeloArquivo.Campos[intCnt].Tamanho);
      Case ObjModeloArquivo.Campos[intCnt].TipoCampo Of
        ftString  :  cdsCadastros.FieldDefs.Add(ObjModeloArquivo.Campos[intCnt].NomeCampo, ObjModeloArquivo.Campos[intCnt].TipoCampo, ObjModeloArquivo.Campos[intCnt].Tamanho)
        Else
          cdsCadastros.FieldDefs.Add(ObjModeloArquivo.Campos[intCnt].NomeCampo, ObjModeloArquivo.Campos[intCnt].TipoCampo);
      End;
    End;

    cdsCadastros.CreateDataSet;
    cxCamposImportadosTableView.BeginUpdate;
    cxCamposImportadosTableView.DataController.CreateAllItems(True);
    cxCamposImportadosTableView.GetColumnByFieldName('NROLINHA').Caption := 'Linha';
    cxCamposImportadosTableView.GetColumnByFieldName('NROLINHA').Options.Editing := False;
    For intCnt := 0 To ObjModeloArquivo.Campos.Count-1 Do
    Begin
      cxCamposImportadosTableView.GetColumnByFieldName(ObjModeloArquivo.Campos[intCnt].NomeCampo).Caption := ObjModeloArquivo.Campos[intCnt].Descricao;
    End;
    cxCamposImportadosTableView.EndUpdate;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmInconsistenciasImportacao.pCriarColunasModelo]');
    End;
  End;
end;

function TfrmInconsistenciasProspecto.fGerarCadastros: Boolean;
begin
  Result := ObjImportaPlanilha.fInserirCadastros;
  If Result Then
    pMensagemOk('Cadastros gerados com sucesso!')
  Else
    pMensagemOk('Cadastros não foram processados!')
end;

function TfrmInconsistenciasProspecto.fReprocessar(pgbStatus: TcxProgressBar = Nil): Boolean;
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
      pMensagensErro(E.Message,'[TfrmInconsistenciasImportacao.pReprocessar]');
    End;
  End;
end;

procedure TfrmInconsistenciasProspecto.pCarregaLinhasParaCadastro;
var
  intCnt, intCont: Integer;
begin
  blnHabilitaEdicao := False;
  pCriarColunasModelo;
  cdsCadastros.DisableControls;
  Try
    Try
      For intCnt := ObjImportaPlanilha.LinhasImportadas.Count-1 DownTo 0 Do
      Begin
        cdsCadastros.Insert;
        cdsCadastros.FieldByName('NROLINHA').AsInteger := ObjImportaPlanilha.LinhasImportadas[intCnt].NumeroLinha;
        For intCont := 0 to ObjModeloArquivo.Campos.Count-1 Do
        Begin
          If ObjModeloArquivo.Campos[intCont].NomeCampo = ObjImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.NomeCampo  Then
          Begin
            try
              cdsCadastros.FieldByName(ObjModeloArquivo.Campos[intCont].NomeCampo).AsString :=
                  ObjImportaPlanilha.LinhasImportadas[intCnt].Campos[intCont].Propriedades.Conteudo;
            except

            end;
          End;
        End;
        cdsCadastros.Post;
      End;
      blnHabilitaEdicao := ObjModeloArquivo.Campos.Count > 0;
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

procedure TfrmInconsistenciasProspecto.pCarregarListaInconsistencias;
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
        pMensagensErro(E.Message,'[TfrmInconsistenciasImportacao.pCarregarListaInconsistencias]');
      End;
    End;
  Finally
    cdsInconsistencias.EnableControls
  End;
end;

function TfrmInconsistenciasProspecto.fConfirmar(pgbStatus: TcxProgressBar = Nil): Boolean;
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

end.
