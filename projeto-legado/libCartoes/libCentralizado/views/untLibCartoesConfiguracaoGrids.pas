unit untLibCartoesConfiguracaoGrids;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Datasnap.DBClient, Data.DB, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls,

  frxClass, frxExportCSVTestabilidade, BitBtnLockedIncrem,  cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog,  cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid,
  UniClientDataSet,

  untLibCartoesPai, untTLibCartoesConfiguracaoGrids, untcxGridDBColumnHelper,
  untTLibCartoesFuncoes;

type
  TfrmConfiguracaoGrids = class(TfrmPai)
    pgcConfiguracaoGrids: TPageControl;
    tbsColunas: TTabSheet;
    pnlGrdCol: TPanel;
    grdColunas: TcxGridCitel;
    grdColunasDados: TcxGridDBTableViewCitel;
    grdColunasDadosEXIBIR: TcxGridDBColumn;
    grdColunasDadosCOLCAP: TcxGridDBColumn;
    grdColunasDadosORDCAM: TcxGridDBColumn;
    grdColunasDadosCOLNAM: TcxGridDBColumn;
    grdColunasLevel1: TcxGridLevel;
    pnlCfgCol: TPanel;
    btnUp: TSpeedButton;
    btnDown: TSpeedButton;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    pnlGrdAdt: TPanel;
    grdCamposVisualizacao: TcxGridCitel;
    grdCamposVisualizacaoDados: TcxGridDBTableViewCitel;
    grdCamposVisualizacaoLevel2: TcxGridLevel;
    btnGravar: TBitBtnLocked;
    btnPadroes: TBitBtnLocked;
    dtsConfiguracaoColunas: TDataSource;
    cdsConfiguracaoColunas: TUniClientDataSet;
    cdsConfiguracaoColunasEXIBIR: TStringField;
    cdsConfiguracaoColunasCOLCAP: TStringField;
    cdsConfiguracaoColunasCOLNAM: TStringField;
    cdsConfiguracaoColunasORDCAM: TIntegerField;
    cdsConfiguracaoColunasCOLTAM: TIntegerField;
    dtsVisualizacaoColunas: TDataSource;
    chkCamposOperador: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnPadroesClick(Sender: TObject);
    procedure grdColunasDadosEXIBIRPropertiesEditValueChanged(Sender: TObject);
    procedure grdCamposVisualizacaoDadosColumnPosChanged(
      Sender: TcxGridTableView; AColumn: TcxGridColumn);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FDatasetCampos: TDataset;

    FConfirmar,
    FFecharForm,
    FWidthAutomaticoCampos: Boolean;

    FChaveGrid: String;

    FConfiguracaoGrids: TConfiguracaoGrids;

    procedure IniciarDados;
    procedure SetConfirmar(const Value: Boolean);

    procedure AdicionarColunaExibicaoEOrdem(ArecColuna: TColunasGridCfg);
    procedure AdicionarColunaPreVisualizacao(AIndice: Integer; ArecColuna: TColunasGridCfg);
    procedure AjustaColunasDeExibicao;
    procedure VisibilidadeColuna;

    procedure MarcarColunasExibicao(AMarcar: Boolean);

    procedure AlteraOrdemColuna(AParaCima: Boolean);
    procedure IndexarColunasVisiveis;
    { Private declarations }
  public
    property DatasetCampos: TDataset read FDatasetCampos write FDatasetCampos;
    property ChaveGrid: String read FChaveGrid write FChaveGrid;
    property WidthAutomaticoCampos: Boolean read FWidthAutomaticoCampos write FWidthAutomaticoCampos;

    property ConfiguracaoGridsObj: TConfiguracaoGrids read FConfiguracaoGrids write FConfiguracaoGrids;

    property Confirmar: Boolean read FConfirmar write SetConfirmar;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmConfiguracaoGrids.AdicionarColunaExibicaoEOrdem(
  ArecColuna: TColunasGridCfg);
begin
  cdsConfiguracaoColunas.Append;
  cdsConfiguracaoColunas.FieldByName('EXIBIR').AsString  := TLibCartoesFuncoes.IIF(ArecColuna.Visible, 'S', 'N');
  cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger := ArecColuna.Indice + 1;
  cdsConfiguracaoColunas.FieldByName('COLCAP').AsString  := ArecColuna.Caption;
  cdsConfiguracaoColunas.FieldByName('COLNAM').AsString  := ArecColuna.FieldName;
  cdsConfiguracaoColunas.Post;

  cdsConfiguracaoColunas.First;
end;

procedure TfrmConfiguracaoGrids.AdicionarColunaPreVisualizacao(
  AIndice: Integer; ArecColuna: TColunasGridCfg);
begin
  grdCamposVisualizacaoDados.CreateColumn;
  grdCamposVisualizacaoDados.Columns[AIndice].DataBinding.FieldName := ArecColuna.FieldName;
  grdCamposVisualizacaoDados.Columns[AIndice].Caption := ArecColuna.Caption;
  grdCamposVisualizacaoDados.Columns[AIndice].Width := ArecColuna.Width;
  grdCamposVisualizacaoDados.Columns[AIndice].Visible := ArecColuna.Visible;
  grdCamposVisualizacaoDados.Columns[AIndice].DataBinding.Field.Alignment := ArecColuna.Alignment;
  grdCamposVisualizacaoDados.Columns[AIndice].HeaderAlignmentHorz := ArecColuna.Alignment;
  grdCamposVisualizacaoDados.Columns[AIndice].Options.Editing := False;
end;

procedure TfrmConfiguracaoGrids.AjustaColunasDeExibicao;
  Var
    LContador,
    LRegistroAtual: Integer;
begin
  LRegistroAtual := cdsConfiguracaoColunas.RecNo;
  cdsConfiguracaoColunas.DisableControls;

  Try
    for LContador := 0 To Pred(grdCamposVisualizacaoDados.ColumnCount) do
    begin
      if cdsConfiguracaoColunas.Locate('COLNAM', grdCamposVisualizacaoDados.Columns[LContador].DataBinding.FieldName, []) then
      begin
        cdsConfiguracaoColunas.Edit;
        cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger := LContador + 1;
        cdsConfiguracaoColunas.FieldByName('EXIBIR').AsString := TLibCartoesFuncoes.IIF(grdCamposVisualizacaoDados.Columns[LContador].Visible, 'S', 'N');
        cdsConfiguracaoColunas.Post;
      end;
    end;
  Finally
    cdsConfiguracaoColunas.RecNo := LRegistroAtual;
    cdsConfiguracaoColunas.EnableControls;
  End;
end;

procedure TfrmConfiguracaoGrids.AlteraOrdemColuna(AParaCima: Boolean);
  Var
    LNomeCampo: String;
begin
  If cdsConfiguracaoColunas.RecordCount < 2 Then
    Exit;

  If (cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger = 1) And (AParaCima) Then
    Exit;

  If (cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger = cdsConfiguracaoColunas.RecordCount) And (Not AParaCima) Then
    Exit;

  cdsConfiguracaoColunas.DisableControls;
  try
    LNomeCampo := cdsConfiguracaoColunas.FieldByName('COLNAM').AsString;

    if AParaCima then
    begin
      cdsConfiguracaoColunas.Prior;
      cdsConfiguracaoColunas.Edit;
      cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger := Succ(cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger);
      cdsConfiguracaoColunas.Post;

      if cdsConfiguracaoColunas.Locate('COLNAM', LNomeCampo, []) then
      begin
        cdsConfiguracaoColunas.Edit;
        cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger := Pred(cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger);
        cdsConfiguracaoColunas.Post;
      end;
    end
    Else
    begin
      cdsConfiguracaoColunas.Next;
      cdsConfiguracaoColunas.Edit;
      cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger := Pred(cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger);
      cdsConfiguracaoColunas.Post;

      if cdsConfiguracaoColunas.Locate('COLNAM', LNomeCampo, []) then
      begin
        cdsConfiguracaoColunas.Edit;
        cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger := Succ(cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger);
        cdsConfiguracaoColunas.Post;
      end;
    end;
  finally
    cdsConfiguracaoColunas.EnableControls;
  end;
end;

procedure TfrmConfiguracaoGrids.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  MarcarColunasExibicao(False);
  AjustaColunasDeExibicao;
end;

procedure TfrmConfiguracaoGrids.btnDownClick(Sender: TObject);
begin
  inherited;
  AlteraOrdemColuna(False);
  IndexarColunasVisiveis;
end;

procedure TfrmConfiguracaoGrids.btnGravarClick(Sender: TObject);
  var
    LArrayColunas: TColunasGridCfgArray;
begin
  inherited;
  FConfirmar := False;

  If TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Deseja realmente confirmar as alterações para ' +
                          TLibCartoesFuncoes.IIF(chkCamposOperador.Checked, 'o operador atual?', 'a empresa atual?'),
               ['&Sim', 'Não'], 1) = 2 Then
    Exit;

  If FConfiguracaoGrids.ConfiguracaoOperador Then
  Begin
    If Not chkCamposOperador.Checked Then
    Begin
      If TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'O operador atual possui configuração personalizada para essa tela. ' +
                              'A gravação do modelo atual será feita para todos os operadores e, ' +
                              'a configuração personalizada do operador atual será excluída.' + #13 +
                              'Deseja realmente continuar?',
                   ['&Sim', '&Não'], 2) = 2 Then
        Exit;
    End;
  End;

  If Not cdsConfiguracaoColunas.Locate('EXIBIR', 'S', []) Then
  Begin
    If TLibCartoesFuncoes.fMensagem('ATENÇÃO', 'Se possuir configuração personalizada, essa será excluída e será utilizada ' +
                            'a configuração de campos padrão.' + #13 +
                            'Deseja realmente continuar?',
                 ['&Sim', '&Não'], 2) = 2 Then
      Exit;
  End;

  cdsConfiguracaoColunas.First;

  FConfiguracaoGrids.SalvarEstado(grdCamposVisualizacaoDados, LArrayColunas);
  FConfiguracaoGrids.GravarDados(LArrayColunas, chkCamposOperador.Checked);
  FConfirmar := True;
end;

procedure TfrmConfiguracaoGrids.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  MarcarColunasExibicao(True);
  AjustaColunasDeExibicao;
end;

procedure TfrmConfiguracaoGrids.btnPadroesClick(Sender: TObject);
begin
  inherited;
  FConfiguracaoGrids.SetarPadrao(grdCamposVisualizacaoDados);
  AjustaColunasDeExibicao;
end;

procedure TfrmConfiguracaoGrids.btnUpClick(Sender: TObject);
begin
  inherited;
  AlteraOrdemColuna(True);
  IndexarColunasVisiveis;
end;

procedure TfrmConfiguracaoGrids.FormCreate(Sender: TObject);
begin
  inherited;
  FConfirmar := False;

  FFecharForm := False;

  cdsConfiguracaoColunas.CreateDataSet;
  cdsConfiguracaoColunas.IndexFieldNames := 'ORDCAM';

  Self.WindowState := wsMaximized;
end;

procedure TfrmConfiguracaoGrids.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F6 Then
    btnMarcaTodos.Click
  Else If Key = VK_F7 Then
    btnDesmarcaTodos.Click;
end;

procedure TfrmConfiguracaoGrids.FormPaint(Sender: TObject);
begin
  inherited;
  If FFecharForm Then
    Self.Close;
end;

procedure TfrmConfiguracaoGrids.FormShow(Sender: TObject);
begin
  inherited;
  If Not Assigned(FDatasetCampos) Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO!', 'A configuração dos campos deve ser chamada sempre através de algum formulário!', ['&OK']);
    FFecharForm := True;

    Exit;
  End;

  If Not Assigned(FConfiguracaoGrids) Then
  Begin
    TLibCartoesFuncoes.fMensagem('ATENÇÃO!', 'O objeto de configuração dos campos deve ser iniciado através do formulário!', ['&OK']);
    FFecharForm := True;

    Exit;
  End;

  grdCamposVisualizacaoDados.OptionsView.ColumnAutoWidth := FWidthAutomaticoCampos;

  pgcConfiguracaoGrids.ActivePageIndex := 0;
  dtsVisualizacaoColunas.DataSet := FDataSetCampos;

  IniciarDados;
end;

procedure TfrmConfiguracaoGrids.grdCamposVisualizacaoDadosColumnPosChanged(
  Sender: TcxGridTableView; AColumn: TcxGridColumn);
begin
  inherited;
  AjustaColunasDeExibicao;
end;

procedure TfrmConfiguracaoGrids.grdColunasDadosEXIBIRPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  VisibilidadeColuna;
end;

procedure TfrmConfiguracaoGrids.IndexarColunasVisiveis;
  Var
    LColunaGrid: TcxGridDBColumn;

    LRegistroAtual: Integer;
begin
  cdsConfiguracaoColunas.DisableControls;
  LRegistroAtual := cdsConfiguracaoColunas.RecNo;

  try
    cdsConfiguracaoColunas.First;

    While Not cdsConfiguracaoColunas.Eof Do
    Begin
      LColunaGrid := TcxGridDBColumnHelper.fFindColumnByNameView(grdCamposVisualizacaoDados, cdsConfiguracaoColunas.FieldByName('COLNAM').AsString);

      if LColunaGrid <> Nil then
        LColunaGrid.Index := cdsConfiguracaoColunas.FieldByName('ORDCAM').AsInteger - 1;

      cdsConfiguracaoColunas.Next;
    End;

    cdsConfiguracaoColunas.First;
  finally
    cdsConfiguracaoColunas.RecNo := LRegistroAtual;
    cdsConfiguracaoColunas.EnableControls;
  end;
end;

procedure TfrmConfiguracaoGrids.IniciarDados;
  Var
    LContador: Integer;

    LrecColunaGrid: TColunasGridCfg;
begin
  dtsVisualizacaoColunas.DataSet.DisableControls;

  FConfiguracaoGrids.ChaveGrid := FChaveGrid;

  Try
    LContador := 0;
    For LrecColunaGrid In FConfiguracaoGrids.ColunasCfgOriginaisArray Do
    Begin
      AdicionarColunaExibicaoEOrdem(LrecColunaGrid);
      AdicionarColunaPreVisualizacao(LContador, LrecColunaGrid);

      Inc(LContador);
    end;

    FConfiguracaoGrids.SetarUltimosDadosCarregados(grdCamposVisualizacaoDados);
    AjustaColunasDeExibicao;

    cdsConfiguracaoColunas.First;

    If FDataSetCampos.IsEmpty Then
      TLibCartoesFuncoes.fMensagem('AVISO', 'Para melhor visualização do modelo, realize o filtro na tela anterior.', ['&Ok']);
  finally
    dtsVisualizacaoColunas.DataSet.EnableControls;

    chkCamposOperador.Checked := FConfiguracaoGrids.ConfiguracaoOperador;
  end;
end;

procedure TfrmConfiguracaoGrids.MarcarColunasExibicao(AMarcar: Boolean);
  Var
    LRegistroAtual: Integer;
begin
  cdsConfiguracaoColunas.DisableControls;
  LRegistroAtual := cdsConfiguracaoColunas.RecNo;

  Try
    cdsConfiguracaoColunas.First;

    While Not cdsConfiguracaoColunas.Eof Do
    Begin
      cdsConfiguracaoColunas.Edit;

      cdsConfiguracaoColunas.FieldByName('EXIBIR').AsString :=  'N';
      If AMarcar then
        cdsConfiguracaoColunas.FieldByName('EXIBIR').AsString :=  'S';

      cdsConfiguracaoColunas.Post;

      VisibilidadeColuna;

      cdsConfiguracaoColunas.Next;
    end;

    cdsConfiguracaoColunas.First;
  finally
    cdsConfiguracaoColunas.RecNo := LRegistroAtual;
    cdsConfiguracaoColunas.EnableControls;
  end;
end;

procedure TfrmConfiguracaoGrids.SetConfirmar(const Value: Boolean);
begin
  FConfirmar := Value;
end;

procedure TfrmConfiguracaoGrids.VisibilidadeColuna;
  Var
    LColunaGrid: TcxGridDBColumn;
begin
  inherited;

  If Not cdsConfiguracaoColunas.FieldByName('COLNAM').AsString.IsEmpty then
  Begin
    LColunaGrid := TcxGridDBColumnHelper.fFindColumnByNameView(grdCamposVisualizacaoDados, cdsConfiguracaoColunas.FieldByName('COLNAM').AsString);

    If LColunaGrid <> Nil Then
      LColunaGrid.Visible := cdsConfiguracaoColunas.FieldByName('EXIBIR').AsString.Equals('S');
  End;
end;

end.
