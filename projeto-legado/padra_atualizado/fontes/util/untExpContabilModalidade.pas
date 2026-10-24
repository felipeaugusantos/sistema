unit untExpContabilModalidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxDropDownEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxCalc,
  Uni, UniClientDataset;

type
  TModoTela = (mtVisualizacao, mtEdicao);

  TfrmExpContabilModalidade = class(TfrmPai)
    pnlFundo: TPanel;
    gridExp: TcxGridCitel;
    gridExpView: TcxGridDBTableViewCitel;
    gridExpLevel: TcxGridLevel;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    gridExpViewMODALI: TcxGridDBColumn;
    gridExpViewDESCRI: TcxGridDBColumn;
    gridExpViewCONCON: TcxGridDBColumn;
    dsDados: TDataSource;
    gridExpViewGRUPO_: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure gridExpViewEditValueChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FcdsDados: TUniClientDataset;
    FstrMinCodEmp: string;
    procedure pAjustaModoTela(const AModo: TModoTela);
    procedure pCriarDataset;
    procedure pCarregarDados;
    procedure pCarregarDadosDb;
    procedure pGravarDados;
  public
    { Public declarations }
  end;

  TExpContabilModalidade = record
    strModali: string;
    strDescri: string;
    intGrupo: Integer;
  end;

const
  GRUPOS_EXP_CONTABIL: array[0..2] of string = (
    'Plano de Contas para Recebimentos',
    'Plano de Contas para Juros e Descontos (Contas a Receber)',
    'Plano de Contas para Juros e Descontos (Contas a Pagar)'
  );

  MODALIDADES_EXP_CONTABIL: array[0..9] of TExpContabilModalidade = (
    (strModali: 'CTR_DINHEI'; strDescri: 'Conta Contábil para Recebimento em Dinheiro'           ; intGrupo: 0),
    (strModali: 'CTR_CARTAO'; strDescri: 'Conta Contábil para Recebimento em Cartão'             ; intGrupo: 0),
    (strModali: 'CTR_CHQAVI'; strDescri: 'Conta Contábil para Recebimento em Cheque à vista'     ; intGrupo: 0),
    (strModali: 'CTR_CHQPRE'; strDescri: 'Conta Contábil para Recebimento em Cheque pré'         ; intGrupo: 0),
    (strModali: 'CTR_ORDPAG'; strDescri: 'Conta Contábil para Recebimento em Ordem de Pagamento' ; intGrupo: 0),
    (strModali: 'CTR_PIXREC'; strDescri: 'Conta Contábil para Recebimento em Pix'                ; intGrupo: 0),
    (strModali: 'CTR_VALJUR'; strDescri: 'Conta Contábil para Juros Recebidos'                   ; intGrupo: 1),
    (strModali: 'CTR_VALDES'; strDescri: 'Conta Contábil para Descontos Concedidos'              ; intGrupo: 1),
    (strModali: 'CTP_VALJUR'; strDescri: 'Conta Contábil para Juros Pagos'                       ; intGrupo: 2),
    (strModali: 'CTP_VALDES'; strDescri: 'Conta Contábil para Descontos Obtidos'                 ; intGrupo: 2)
  );

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmExpContabilModalidade.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pAjustaModoTela(mtEdicao);
end;

procedure TfrmExpContabilModalidade.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregarDados;
  pAjustaModoTela(mtVisualizacao);
end;

procedure TfrmExpContabilModalidade.btnGravarClick(Sender: TObject);
begin
  inherited;
  pGravarDados;
  pAjustaModoTela(mtVisualizacao);
end;

procedure TfrmExpContabilModalidade.FormCreate(Sender: TObject);
begin
  inherited;
  FstrMinCodEmp := fCampoTabela('MIN(EMP_CODEMP)', 'CADEMP', [], [], False);
end;

procedure TfrmExpContabilModalidade.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FcdsDados) then
    FreeAndNil(FcdsDados);
end;

procedure TfrmExpContabilModalidade.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarDados;
  pAjustaModoTela(mtVisualizacao);
  pSetFocus(btnAlterar);
end;

procedure TfrmExpContabilModalidade.gridExpViewEditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
begin
  inherited;

  if Sender.Controller.EditingController.IsEditing then
  begin
    if Sender.Controller.EditingController.EditingItem = AItem then
    begin
      Sender.Controller.EditingController.Edit.PostEditValue;
    end;
  end;
end;

procedure TfrmExpContabilModalidade.pAjustaModoTela(const AModo: TModoTela);
begin
  gridExp.Enabled := (AModo = mtEdicao);
  btnAlterar.Enabled := (AModo = mtVisualizacao);
  btnGravar.Enabled := (AModo = mtEdicao);
  btnCancela.Enabled := (AModo = mtEdicao);
  btnSair.Enabled := (AModo = mtVisualizacao);

  if (AModo = mtEdicao) then
    pSetFocus(gridExp)
  else if (AModo = mtVisualizacao) then
    pSetFocus(btnSair)
end;

procedure TfrmExpContabilModalidade.pCarregarDados;
var
  LrecExp: TExpContabilModalidade;
  LintCount: integer;
begin
  if not Assigned(FcdsDados) then
    pCriarDataset;

  FcdsDados.DisableControls;
  FcdsDados.EmptyDataSet;

  for LintCount := Low(MODALIDADES_EXP_CONTABIL) to High(MODALIDADES_EXP_CONTABIL) do
  begin
    LrecExp := MODALIDADES_EXP_CONTABIL[LintCount];

    FcdsDados.Append;
    FcdsDados.FieldByName('MODALI').AsString := LrecExp.strModali;
    FcdsDados.FieldByName('CODEMP').AsString := FstrMinCodEmp;
    FcdsDados.FieldByName('DESCRI').AsString := LrecExp.strDescri;
    FcdsDados.FieldByName('CONCON').AsString := '';
    FcdsDados.FieldByName('GRUPO_').AsString := GRUPOS_EXP_CONTABIL[LrecExp.intGrupo];
    FcdsDados.Post;
  end;

  FcdsDados.First;
  pCarregarDadosDb;

  FcdsDados.EnableControls;
  FcdsDados.First;
end;

procedure TfrmExpContabilModalidade.pCarregarDadosDb;
var
  LqryDados: TUniQuery;
begin

  LqryDados := fCriaQuery(nil);
  try
    LqryDados.SQL.Text := 'SELECT * FROM EXP_CONTABIL_MODALIDADE ';
    LqryDados.Open;

    while not LqryDados.Eof do
    begin
      if not FcdsDados.FindKey([LqryDados.FieldByName('EXP_MODALI').AsString]) then
      begin
        FcdsDados.Append;
        FcdsDados.FieldByName('MODALI').AsString := LqryDados.FieldByName('EXP_MODALI').AsString;
        FcdsDados.FieldByName('DESCRI').AsString := '';
        FcdsDados.FieldByName('GRUPO_').AsString := '';
      end
      else
        FcdsDados.Edit;

      FcdsDados.FieldByName('CODEMP').AsString := LqryDados.FieldByName('EXP_CODEMP').AsString;
      FcdsDados.FieldByName('CONCON').AsString := LqryDados.FieldByName('EXP_CONCON').AsString;
      FcdsDados.Post;

      LqryDados.Next;
    end;
  finally
    FreeAndNil(LqryDados);
  end;
end;

procedure TfrmExpContabilModalidade.pCriarDataset;
var
  LField: TFieldDef;
begin
  FcdsDados := TUniClientDataset.Create(nil);

  LField := FcdsDados.FieldDefs.AddFieldDef;
  LField.Name := 'MODALI';
  LField.DataType := ftString;
  LField.Size := 20;

  LField := FcdsDados.FieldDefs.AddFieldDef;
  LField.Name := 'CODEMP';
  LField.DataType := ftString;
  LField.Size := 20;

  LField := FcdsDados.FieldDefs.AddFieldDef;
  LField.Name := 'DESCRI';
  LField.DataType := ftString;
  LField.Size := 64;

  LField := FcdsDados.FieldDefs.AddFieldDef;
  LField.Name := 'CONCON';
  LField.DataType := ftString;
  LField.Size := 20;

  LField := FcdsDados.FieldDefs.AddFieldDef;
  LField.Name := 'GRUPO_';
  LField.DataType := ftString;
  LField.Size := 64;

  FcdsDados.CreateDataSet;
  FcdsDados.IndexFieldNames := 'MODALI';
  FcdsDados.Open;

  dsDados.DataSet := FcdsDados;
end;

procedure TfrmExpContabilModalidade.pGravarDados;
var
  LqryDados: TUniQuery;
begin
  if not Assigned(FcdsDados) then
    Exit;

  FcdsDados.First;

  LqryDados := fCriaQuery(nil);
  try
    LqryDados.SQL.Text := 'REPLACE INTO EXP_CONTABIL_MODALIDADE (EXP_MODALI, EXP_CODEMP, EXP_CONCON) VALUES (:MODALI, :CODEMP, :CONCON) ';
    try
      fStartTransaction;
      while not FcdsDados.Eof do
      begin
        LqryDados.ParamByName('MODALI').AsString := FcdsDados.FieldByName('MODALI').AsString;
        LqryDados.ParamByName('CODEMP').AsString := FcdsDados.FieldByName('CODEMP').AsString;;

        if fEmptyStr(FcdsDados.FieldByName('CONCON').AsString) then
          LqryDados.ParamByName('CONCON').Clear
        else
          LqryDados.ParamByName('CONCON').AsString := FcdsDados.FieldByName('CONCON').AsString;

        LqryDados.ExecSQL;

        FcdsDados.Next;
      end;
      fCommit;
    except
      on E: Exception do
      begin
        fRollback;
        pMensagensErro(
          'Ocorreu um erro ao gravar os dados!' + #13 + E.Message,
          '[TfrmExpContabilModalidade.pGravarDados]');
        Exit;
      end;
    end;
  finally
    FreeandNil(LqryDados);
  end;
end;

end.
