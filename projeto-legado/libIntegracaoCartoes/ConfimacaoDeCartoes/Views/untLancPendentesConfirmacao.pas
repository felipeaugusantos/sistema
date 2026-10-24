unit untLancPendentesConfirmacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxTextEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxCurrencyEdit,
  cxCalendar,Uni, cxButtons,untConstantes, untFuncoesSimples, System.StrUtils,
  TipoConciliadora.Classes;

Type
  TLancamentoPendentes = Record
    DataTransacao: String;
    Estabelecimento: String;
  End;

type
  TfrmLancPendentesConfirmacao = class(TfrmPai)
    pnlFundo: TPanel;
    Panel1: TPanel;
    btnSairTela: TBitBtnLocked;
    FlowPanel1: TFlowPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlCaption: TPanel;
    lblTitulo: TLabel;
    cxGridLanPendentes: TcxGrid;
    cxGridDBTableViewLanPendentes: TcxGridDBTableView;
    cxGridDBTableViewLanPendentesESTABELECIMENTO: TcxGridDBColumn;
    cxGridDBTableViewLanPendentesQUANTIDADE: TcxGridDBColumn;
    cxGridDBTableViewLanPendentesTOTAL_BRUTO: TcxGridDBColumn;
    cxGridDBTableViewLanPendentesTOTAL_TAXA: TcxGridDBColumn;
    cxGridDBTableViewLanPendentesTOTAL_LIQUIDO: TcxGridDBColumn;
    cxGridLevel4: TcxGridLevel;
    cxGridDBTableViewLanPendentesDATA_TRANSACAO: TcxGridDBColumn;
    cxGridDBTableViewLanPendentesMARCADO: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle14: TcxStyle;
    cxStyle15: TcxStyle;
    cxStyle16: TcxStyle;
    cxStyleRepository2: TcxStyleRepository;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyleRepository3: TcxStyleRepository;
    cxStyle13: TcxStyle;
    procedure btnSairTelaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGridDBTableViewLanPendentesCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    FQueryLancamentoPendentes: TUniQuery;
    FDataSourceLancamentoPendentes: TDataSource;
    FConciliadora: String;
    FConfirma: Boolean;
    FTipoConciliadora: TTipoConciliadora;
    FCampoEstabelecimento: String;
    procedure CriarObjetosDeConsulta;
    function RetornaSQLLancamentoPendentes: String;
    procedure RealizarConsulta;
    procedure AjustaColunasGridLancPendentes;
    procedure AjustaLarguraColunas;
    procedure MarcarTodos;
    procedure DesmarcarTodos;
    function RetornaDadosLancamentosPendentes: TLancamentoPendentes;
    function TemLancamentoSelecionado: Boolean;
    function RetornaSubSelectCfgSis: String;
    procedure SetConciliadora(const Value: String);
    procedure SetTipoConciliadora(const Value: TTipoConciliadora);
  public
    { Public declarations }
    Property Conciliadora: String Read FConciliadora Write SetConciliadora;
    property TipoConciliadora: TTipoConciliadora read FTipoConciliadora write SetTipoConciliadora;
    Property LancamentosSelecionados: TLancamentoPendentes Read RetornaDadosLancamentosPendentes;
    Property Confirma: Boolean Read FConfirma;
  end;

implementation

{$R *.dfm}

uses untFuncoes;

procedure TfrmLancPendentesConfirmacao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not TemLancamentoSelecionado Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário selecionar ao menos um lançamento!', ['&Ok']);
    Exit;
  End;

  FConfirma := True;
  btnSair.Click;
end;

procedure TfrmLancPendentesConfirmacao.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  AguardeExecutarModalA(DesmarcarTodos,'Aguarde, Desmarcando todos...', '');
end;


procedure TfrmLancPendentesConfirmacao.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  AguardeExecutarModalA(MarcarTodos,'Aguarde, Marcando todos...', '');
end;

procedure TfrmLancPendentesConfirmacao.btnSairTelaClick(Sender: TObject);
begin
  inherited;
  btnSair.Click;
end;

procedure TfrmLancPendentesConfirmacao.CriarObjetosDeConsulta;
begin
  FQueryLancamentoPendentes := untFuncoes.CriarQueryDLL;
  FQueryLancamentoPendentes.CachedUpdates := True;
  FQueryLancamentoPendentes.Options.SetFieldsReadOnly := False;
  FDataSourceLancamentoPendentes := TDataSource.Create(Nil);
  FDataSourceLancamentoPendentes.DataSet := FQueryLancamentoPendentes;
  cxGridDBTableViewLanPendentes.DataController.DataSource := FDataSourceLancamentoPendentes;
end;

procedure TfrmLancPendentesConfirmacao.cxGridDBTableViewLanPendentesCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If (Not AViewInfo.GridRecord.Focused) And
     (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := COR_ZEBRA;
  End;
end;

procedure TfrmLancPendentesConfirmacao.AjustaColunasGridLancPendentes;
begin
  Application.ProcessMessages;
  cxGridLanPendentes.BeginUpdate;
  Try
    If Not FDataSourceLancamentoPendentes.DataSet.IsEmpty Then
    Begin
      cxGridDBTableViewLanPendentesESTABELECIMENTO.GroupIndex := -1;
      cxGridDBTableViewLanPendentes.ApplyBestFit;
      cxGridDBTableViewLanPendentesESTABELECIMENTO.GroupIndex := 0;
      AjustaLarguraColunas;
    End;
  Finally
    cxGridLanPendentes.EndUpdate;
  End;
  Application.ProcessMessages;
end;

procedure TfrmLancPendentesConfirmacao.AjustaLarguraColunas;
  Var
    LLarguraTotalColunas: Integer;
    LDiferenca: Double;
begin

  LLarguraTotalColunas := (cxGridDBTableViewLanPendentesQUANTIDADE.Width    +
                           cxGridDBTableViewLanPendentesTOTAL_BRUTO.Width   +
                           cxGridDBTableViewLanPendentesTOTAL_TAXA.Width    +
                           cxGridDBTableViewLanPendentesTOTAL_LIQUIDO.Width +
                           cxGridDBTableViewLanPendentesDATA_TRANSACAO.Width);


  If (LLarguraTotalColunas < cxGridLanPendentes.Width) Then
  Begin
    LDiferenca := (cxGridLanPendentes.Width  - LLarguraTotalColunas) - 60;
    cxGridDBTableViewLanPendentesTOTAL_BRUTO.Width   := cxGridDBTableViewLanPendentesTOTAL_BRUTO.Width   + Trunc(LDiferenca / 3);
    cxGridDBTableViewLanPendentesTOTAL_TAXA.Width    := cxGridDBTableViewLanPendentesTOTAL_TAXA.Width    + Trunc(LDiferenca / 3);
    cxGridDBTableViewLanPendentesTOTAL_LIQUIDO.Width := cxGridDBTableViewLanPendentesTOTAL_LIQUIDO.Width + Trunc(LDiferenca / 3);
  End;

end;

procedure TfrmLancPendentesConfirmacao.FormCreate(Sender: TObject);
begin
  inherited;
  CriarObjetosDeConsulta;
  FConfirma := False;
  FCampoEstabelecimento := 'EXT_NUM_PV';
end;

procedure TfrmLancPendentesConfirmacao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FQueryLancamentoPendentes);
  FreeAndNil(FDataSourceLancamentoPendentes);
end;

procedure TfrmLancPendentesConfirmacao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F7:  btnMarcaTodosClick(Sender);
    VK_F8:  btnDesmarcaTodosClick(Sender);
    VK_F10: btnConfirmaClick(Sender);
  end;
end;

procedure TfrmLancPendentesConfirmacao.FormShow(Sender: TObject);
begin
  inherited;
  lblTitulo.Caption := lblTitulo.Caption + '('+ FConciliadora +')';
  RealizarConsulta;
end;

procedure TfrmLancPendentesConfirmacao.MarcarTodos;
  Var
    LRecNo : Integer;
begin
  Try
    LRecNo := 0;
    Try
      LRecNo := FQueryLancamentoPendentes.RecNo;
      FQueryLancamentoPendentes.DisableControls;
      FQueryLancamentoPendentes.First;

      While Not FQueryLancamentoPendentes.Eof Do
      Begin
        FQueryLancamentoPendentes.Edit;
        FQueryLancamentoPendentes.FieldByName('MARCADO').AsString := 'S';
        FQueryLancamentoPendentes.Post;

        FQueryLancamentoPendentes.Next;
        Application.ProcessMessages;
      End;

    Finally
      FQueryLancamentoPendentes.RecNo := LRecNo;
      FQueryLancamentoPendentes.EnableControls;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TfrmLancPendentesConfirmacao.DesmarcarTodos;
  Var
    LRecNo : Integer;
begin
  Try
    LRecNo := 0;
    Try
      LRecNo := FQueryLancamentoPendentes.RecNo;
      FQueryLancamentoPendentes.DisableControls;
      FQueryLancamentoPendentes.First;

      While Not FQueryLancamentoPendentes.Eof Do
      Begin
        FQueryLancamentoPendentes.Edit;
        FQueryLancamentoPendentes.FieldByName('MARCADO').AsString := 'N';
        FQueryLancamentoPendentes.Post;

        FQueryLancamentoPendentes.Next;
        Application.ProcessMessages;
      End;

    Finally
      FQueryLancamentoPendentes.RecNo := LRecNo;
      FQueryLancamentoPendentes.EnableControls;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TfrmLancPendentesConfirmacao.RealizarConsulta;
begin
  Try
    FQueryLancamentoPendentes.Close;
    FQueryLancamentoPendentes.SQL.Clear;
    FQueryLancamentoPendentes.SQL.Text := RetornaSQLLancamentoPendentes;
    FQueryLancamentoPendentes.ParamByName('NOMCON').AsString := FConciliadora;
    FQueryLancamentoPendentes.Open;

    AjustaColunasGridLancPendentes;
    cxGridDBTableViewLanPendentes.ViewData.Expand(True);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TfrmLancPendentesConfirmacao.RetornaDadosLancamentosPendentes: TLancamentoPendentes;
  Var
    LRecNo: Integer;
    LDataTransacao: String;
    LEstabelecimento: String;
begin
  Try
    If FQueryLancamentoPendentes.IsEmpty Then
      Exit;

    LRecNo := 0;
    Try
      LRecNo := FQueryLancamentoPendentes.RecNo;
      FQueryLancamentoPendentes.DisableControls;

      FQueryLancamentoPendentes.Filtered := False;
      FQueryLancamentoPendentes.Filter   := 'MARCADO = ' + QuotedStr('S');
      FQueryLancamentoPendentes.Filtered := True;
      FQueryLancamentoPendentes.First;

      While Not FQueryLancamentoPendentes.Eof Do
      Begin
        LDataTransacao := FormatDateTime('yyyy-mm-dd', FQueryLancamentoPendentes.FieldByName('DATA_TRANSACAO').AsDateTime);
        If Pos(LDataTransacao, Result.DataTransacao) <= 0 Then
          Result.DataTransacao := Result.DataTransacao + '"' + LDataTransacao + '",';

        LEstabelecimento := FQueryLancamentoPendentes.FieldByName('EXT_NUM_PV').AsString;
        If Pos(LEstabelecimento, Result.Estabelecimento) <= 0 Then
          Result.Estabelecimento := Result.Estabelecimento + '"' + LEstabelecimento + '",';

        FQueryLancamentoPendentes.Next;
        Application.ProcessMessages;
      End;

      Result.DataTransacao := LeftStr(Result.DataTransacao, Result.DataTransacao.Length - 1);
      Result.Estabelecimento := LeftStr(Result.Estabelecimento, Result.Estabelecimento.Length - 1);

    Finally
      FQueryLancamentoPendentes.Filtered := False;
      FQueryLancamentoPendentes.Filter   := '';
      FQueryLancamentoPendentes.RecNo := LRecNo;
      FQueryLancamentoPendentes.EnableControls;
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TfrmLancPendentesConfirmacao.RetornaSQLLancamentoPendentes: String;
begin
  Result :=   'SELECT                                 '+
              '   EXT_NUM_PV,                         '+
              '   CONCAT(                             '+
              '     IFNULL(                           '+
                      FCampoEstabelecimento + ','      +
              '       "000"),                         '+
              '     "-",                              '+
              '     IFNULL(                           '+
              '       EMP_NOMEMP,                     '+
              '       "NÃO EXISTE EMPRESA VINCULADA"  '+
              '     )                                 '+
              '   ) AS ESTABELECIMENTO,               '+
              '  EXT_DTACUP AS DATA_TRANSACAO,        '+
              '  COUNT(EXT_NUMNSU) AS QUANTIDADE,     '+
              '  SUM(EXT_VALBRU) AS TOTAL_BRUTO,      '+
              '  SUM(EXT_VALTAX) AS TOTAL_TAXA,       '+
              '  SUM(EXT_VALLIQ) AS TOTAL_LIQUIDO,    '+
              '  "N" AS MARCADO                       '+
              'FROM                                   '+
              '  EXTMCA                               '+
              '   LEFT JOIN                           '+
                      RetornaSubSelectCfgSis           +
              '     ON LOCATE(EXT_NUM_PV, SIS_VALCFG) > 0          '+
              '   LEFT JOIN CADEMP                    '+
              '     ON EMP_CODEMP = SIS_CODEMP        '+
              'WHERE EXT_NOMCON = :NOMCON             '+
              '  AND EXT_STATUS = "N"                 '+
              'GROUP BY EXT_NUM_PV,                   '+
              '  EXT_DTACUP                           ';

end;

function TfrmLancPendentesConfirmacao.RetornaSubSelectCfgSis: String;
begin
  Result := '(                                                                  ' +
            '  SELECT                                                           ' +
            '    SIS_CODCFG,                                                    ' +
            '    SIS_VALCFG,                                                    ' +
            '    SIS_CODEMP                                                     ' +
            '  FROM                                                             ' +
            '    CFGSIS                                                         ' +
            '  WHERE                                                            ' +
            '    SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO", "CFG_PGMKEY")       ' +
            '    AND IFNULL(SIS_VALCFG, "") <> ""                               ' +
            '   GROUP BY SIS_VALCFG                                             ' +
            '   ORDER BY SIS_CODEMP                                             ' +
            ') AS CFGSIS                                                        ';
end;

procedure TfrmLancPendentesConfirmacao.SetConciliadora(const Value: String);
var
  LTipoConciliadora: TTipoConciliadora;
begin
  FConciliadora := Value;
  SetTipoConciliadora(LTipoConciliadora.FromString(FConciliadora));
end;

procedure TfrmLancPendentesConfirmacao.SetTipoConciliadora(
  const Value: TTipoConciliadora);
begin
  FTipoConciliadora := Value;
  case FTipoConciliadora of
    tcOperadora:
    begin
      FCampoEstabelecimento := 'EXT_NUM_PV';
    end;

    tcMarketPlace:
    begin
      FCampoEstabelecimento := 'EMP_CODEMP';
    end;
  end;
end;

function TfrmLancPendentesConfirmacao.TemLancamentoSelecionado: Boolean;
  Var
    LRecNo: Integer;
begin
  Result := False;

  Try
    If FQueryLancamentoPendentes.IsEmpty Then
      Exit;

    LRecNo := 0;

    Try
      LRecNo := FQueryLancamentoPendentes.RecNo;
      FQueryLancamentoPendentes.DisableControls;

      FQueryLancamentoPendentes.Filtered := False;
      FQueryLancamentoPendentes.Filter   := 'MARCADO = ' + QuotedStr('S');
      FQueryLancamentoPendentes.Filtered := True;

      If Not FQueryLancamentoPendentes.IsEmpty Then
        Result := True;

    Finally
      FQueryLancamentoPendentes.Filtered := False;
      FQueryLancamentoPendentes.Filter   := '';
      FQueryLancamentoPendentes.RecNo := LRecNo;
      FQueryLancamentoPendentes.EnableControls;
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

end.
