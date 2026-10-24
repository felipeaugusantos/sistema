unit untPermissaoAcessoAdicionarAutban;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, ExtCtrls, ComCtrls, DB, strUtils, StdCtrls, EditFocus,
  Mask, DBCtrls, CheckLst, Menus, Buttons, Uni, AppEvnts, cxGridDBTableView,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGrid,
  Datasnap.DBClient, cxGridCitel, System.ImageList, Vcl.ImgList, cxImageList, cxImageComboBox,
  cxContainer, dxGDIPlusClasses, cxGroupBox, cxGridDBDataDefinitions;

type
  TfrmPermissaoAcessoAdicionarAutban = class(TfrmPai)
    lblNomForm: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label2: TLabel;
    cxgSelecionarView: TcxGridDBTableViewCitel;
    cxgSelecionarLevel: TcxGridLevel;
    cxgSelecionar: TcxGridCitel;
    Panel1: TPanel;
    btnSelecionar: TBitBtnLocked;
    cdsSelecionar: TClientDataSet;
    cdsSelecionartipo: TStringField;
    cdsSelecionardescricao: TStringField;
    cdsSelecionarcodigo: TStringField;
    dtsSelecionar: TDataSource;
    cxgSelecionarViewtipo: TcxGridDBColumn;
    cxgSelecionarViewdescricao: TcxGridDBColumn;
    cxgSelecionarViewcodigo: TcxGridDBColumn;
    imgIcones: TcxImageList;
    Panel2: TPanel;
    cxGroupBox1: TcxGroupBox;
    Image1: TImage;
    edtPesquisar: TEdit;
    Label3: TLabel;
    Panel3: TPanel;
    btnCancelar: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    tmrPesquisar: TTimer;
    Styles: TcxStyleRepository;
    cxsFoco: TcxStyle;
    cxsSemFoco: TcxStyle;
    rdgFiltro: TRadioGroup;
    lblSelecionarTodos: TLabel;
    cxgSelecionados: TcxGridCitel;
    cxgSelecionadosView: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxgSelecionadosLevel: TcxGridLevel;
    cdsSelecionados: TClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    dtsSelecionados: TDataSource;
    lblDescricaoDireitoAcesso: TLabel;
    Panel4: TPanel;
    lblRemoverTodos: TLabel;
    btnRemover: TBitBtnLocked;
    cdsSelecionaropesenlib: TStringField;
    cdsSelecionadosopesenlib: TStringField;
    chkSenLib: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsSelecionarFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure cxgSelecionarViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure edtPesquisarChange(Sender: TObject);
    procedure tmrPesquisarTimer(Sender: TObject);
    procedure cxgTemPermissaoViewStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure rdgFiltroClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure cxgSelecionarViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure lblSelecionarTodosClick(Sender: TObject);
    procedure cxgSelecionarViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgSelecionadosViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lblRemoverTodosClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure cxgSelecionadosViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure edtPesquisarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtPesquisarEnter(Sender: TObject);
    procedure edtPesquisarExit(Sender: TObject);
    procedure cdsSelecionadosAfterScroll(DataSet: TDataSet);
    procedure chkSenLibClick(Sender: TObject);
  private
    { Private declarations }
    FConfirmou: Boolean;
    FQryOperadores: TUniQuery;
    FQryGrupos: TUniQuery;
    FTemPermissao: TDataSet;
    FFocarUsuario: Boolean;
    procedure CarregarOperadores;
    procedure CarregarGrupos;
    procedure SelecionarTodos;
    procedure SelecionarVarios;
    procedure RemoverTodos;
    procedure RemoverVarios;
    procedure FocoUsuarioLogado;
  public type
    Selecionado = record
      Tipo: String;
      Codigo: String;
      Descricao: String;
      OpeSenLib: String;
    end;
  protected
    function GetSelection(AController: TcxGridDBDataController): TArray<Selecionado>;
    function GetSelecionados: TArray<Selecionado>;
  public
    { Public declarations }
    class function Selecionar(ACaption: String; ATemPermissao: TDataSet = nil; AFocoUsuario: Boolean = False): TArray<Selecionado>;
  end;

implementation

uses untfuncoesSimples, untHighlightGrid;

{$R *.dfm}

Const
  INFO_PESQUISA = 'Ctrl+L Pesquisar';

  { TfrmPermissaoAcessoAdicionarAutban }

function TfrmPermissaoAcessoAdicionarAutban.GetSelecionados: TArray<Selecionado>;
begin
  SetLength(Result, cdsSelecionados.RecordCount);
  cdsSelecionados.First;
  While Not cdsSelecionados.Eof Do
  Begin
    Result[Pred(cdsSelecionados.RecNo)].Tipo := cdsSelecionados.FieldByName('tipo').AsString;
    Result[Pred(cdsSelecionados.RecNo)].Codigo := cdsSelecionados.FieldByName('codigo').AsString;
    Result[Pred(cdsSelecionados.RecNo)].Descricao := cdsSelecionados.FieldByName('descricao').AsString;
    Result[Pred(cdsSelecionados.RecNo)].OpeSenLib := cdsSelecionados.FieldByName('opesenlib').AsString;
    cdsSelecionados.Next;
  End;
  cdsSelecionados.First;
end;

function TfrmPermissaoAcessoAdicionarAutban.GetSelection(AController: TcxGridDBDataController): TArray<Selecionado>;
var
  I: Integer;
  LRowIndex: Integer;
  LRowInfo: TcxRowInfo;
begin
  SetLength(Result, AController.GetSelectedCount);

  For I := 0 To Pred(AController.GetSelectedCount) Do
  Begin
    LRowIndex := AController.GetSelectedRowIndex(I);
    LRowInfo := AController.GetRowInfo(LRowIndex);

    Result[I].Tipo := AController.Values[LRowInfo.RecordIndex, 0];
    Result[I].Codigo := AController.Values[LRowInfo.RecordIndex, 1];
    Result[I].Descricao := AController.Values[LRowInfo.RecordIndex, 2];
   // Result[I].OpeSenLib := AController.Values[LRowInfo.RecordIndex, 3];
  End;

  AController.ClearSelection;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.rdgFiltroClick(Sender: TObject);
begin
  inherited;
  edtPesquisar.Clear;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.RemoverTodos;
begin
  Try
    cdsSelecionados.DisableControls;
    cdsSelecionar.DisableControls;
    While Not cdsSelecionados.IsEmpty Do
    Begin
      btnRemover.Click;
      Application.ProcessMessages;
    End;
  Finally
    cdsSelecionados.EnableControls;
    cdsSelecionar.EnableControls;
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.RemoverVarios;
Var
  LSelecionado: TfrmPermissaoAcessoAdicionarAutban.Selecionado;
  LSelecionados: TArray<TfrmPermissaoAcessoAdicionarAutban.Selecionado>;
begin
  LSelecionados := GetSelection(cxgSelecionadosView.DataController);

  For LSelecionado In LSelecionados Do
  Begin
    cdsSelecionar.AppendRecord([LSelecionado.Tipo, LSelecionado.Codigo, LSelecionado.Descricao, LSelecionado.OpeSenLib]);
    If cdsSelecionados.Locate('tipo;codigo', varArrayOf([LSelecionado.Tipo, LSelecionado.Codigo]), []) Then
      cdsSelecionados.Delete;
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.tmrPesquisarTimer(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  cdsSelecionar.Filtered := False;
  cdsSelecionar.Filtered := True;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  btnSair.Click;
  FConfirmou := True;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.btnRemoverClick(Sender: TObject);
begin
  inherited;
  If cdsSelecionados.IsEmpty Then
    Exit;

  Try
    If cxgSelecionadosView.DataController.GetSelectedCount > 1 Then
    Begin
      fExecutarModal(RemoverVarios, 'Removendo vários, Aguarde ...', '');
      Exit;
    End;

    cdsSelecionar.AppendRecord([cdsSelecionados.FieldByName('tipo').AsString,
                                cdsSelecionados.FieldByName('codigo').AsString,
                                cdsSelecionados.FieldByName('descricao').AsString,
                                cdsSelecionados.FieldByName('opesenlib').AsString]);

    cdsSelecionados.Delete;
  Finally
    btnConfirmar.Enabled := Not cdsSelecionados.IsEmpty;
    If cxgSelecionadosView.DataController.RecordCount = 0 Then
    Begin
      edtPesquisar.Clear;
      pSetFocus(edtPesquisar);
    End;
  End;

end;

procedure TfrmPermissaoAcessoAdicionarAutban.btnSelecionarClick(Sender: TObject);
begin
  inherited;
  If cdsSelecionar.IsEmpty Then
    Exit;

  Try
    If cxgSelecionarView.DataController.GetSelectedCount > 1 Then
    Begin
      fExecutarModal(SelecionarVarios, 'Selecionando vários, Aguarde ...', '');
      Exit;
    End;

    cdsSelecionados.AppendRecord([cdsSelecionar.FieldByName('tipo').AsString,
                                  cdsSelecionar.FieldByName('codigo').AsString,
                                  cdsSelecionar.FieldByName('descricao').AsString,
                                  'S']);

    cdsSelecionar.Delete;
  Finally
    btnConfirmar.Enabled := True;
    If cxgSelecionarView.DataController.RecordCount = 0 Then
    Begin
      edtPesquisar.Clear;
      pSetFocus(edtPesquisar);
    End;
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.CarregarGrupos;
begin
  FQryGrupos.Close;
  FQryGrupos.SQL.Text := 'SELECT * FROM CADGPO';
  FQryGrupos.Open;

  FQryGrupos.First;

  While Not FQryGrupos.Eof Do
  Begin
    If Not Assigned(FTemPermissao) Or Not FTemPermissao.Locate('tipo;codigo',
      varArrayOf(['GRU', FQryGrupos.FieldByName('GPO_CODGPO').AsString]), []) Then
    Begin
      cdsSelecionar.AppendRecord(['GRU', FQryGrupos.FieldByName('GPO_CODGPO').AsString,
        FQryGrupos.FieldByName('GPO_DESCRI').AsString]);
    End;
    FQryGrupos.Next;
  End;

  cdsSelecionar.First;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.CarregarOperadores;
begin
  FQryOperadores.Close;
  FQryOperadores.SQL.Text := 'SELECT * FROM CADOPE WHERE OPE_STATUS <> "I" ';
  FQryOperadores.Open;

  While Not FQryOperadores.Eof Do
  Begin
    If Not Assigned(FTemPermissao) Or Not FTemPermissao.Locate('tipo;codigo',
      varArrayOf(['OPE', FQryOperadores.FieldByName('OPE_CODOPE').AsString]), []) Then
    Begin
      cdsSelecionar.AppendRecord(['OPE', FQryOperadores.FieldByName('OPE_CODOPE').AsString,
        FQryOperadores.FieldByName('OPE_NOMOPE').AsString]);
    End;
    FQryOperadores.Next;
  End;

  cdsSelecionar.First;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.cdsSelecionadosAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  If (cdsSelecionados.Active) And (cdsSelecionados.RecordCount > 0) Then
    chkSenLib.Checked := cdsSelecionadosopesenlib.AsString.Equals('S');
end;

procedure TfrmPermissaoAcessoAdicionarAutban.cdsSelecionarFilterRecord(DataSet: TDataSet; var Accept: Boolean);
Var
  LPalavra: String;
  LPalavras: TStringList;
begin
  inherited;
  Accept := True;
  LPalavras := fGetPalavras(edtPesquisar);
  Try
    If edtPesquisar.Text <> INFO_PESQUISA Then
      For LPalavra In LPalavras Do
        Accept := Accept And fRemoveAcento(DataSet.FieldByName('codigo').AsString + ' ' +
          DataSet.FieldByName('descricao').AsString).ToUpper.Contains(fRemoveAcento(LPalavra).ToUpper);

    Case rdgFiltro.ItemIndex Of
      0:
        Accept := Accept And DataSet.FieldByName('tipo').AsString.Equals('OPE');
      1:
        Accept := Accept And DataSet.FieldByName('tipo').AsString.Equals('GRU');
    End;
  Finally
    FreeAndNil(LPalavras);
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.chkSenLibClick(Sender: TObject);
begin
  inherited;
  If (cdsSelecionados.Active) And (cdsSelecionados.RecordCount > 0) Then
  Begin
    cdsSelecionados.Edit;

    If chkSenLib.Checked Then
      cdsSelecionadosopesenlib.AsString := 'S'
    Else
      cdsSelecionadosopesenlib.AsString := 'N';

    cdsSelecionados.Post;
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.cxgSelecionadosViewCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
  inherited;
  btnRemover.Click;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.cxgSelecionadosViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE:
      pSetFocus(cxgSelecionar);
    VK_RETURN:
      btnRemover.Click;
    VK_SPACE:
      btnRemover.Click;
    VK_UP:
      If cxgSelecionadosView.DataController.RecNo <= 1 Then
        pSetFocus(edtPesquisar);
  End;

  If (Shift = ([ssCtrl])) And ((Key = Ord('l')) Or (Key = Ord('L'))) Then
  Begin
    pSetFocus(edtPesquisar);
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.cxgSelecionarViewCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
  var AHandled: Boolean);
begin
  inherited;
  btnSelecionar.Click;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.cxgSelecionarViewCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var
  LLista: TStringList;
  LArray: TArray<String>;
  I: Integer;
begin
  inherited;
  If (edtPesquisar.Text <> INFO_PESQUISA) And (AViewInfo.Item.Index <> cxgSelecionarViewtipo.Index) Then
  Begin
    LLista := fGetPalavras(edtPesquisar);
    Try
      SetLength(LArray, LLista.Count);
      For I := 0 To LLista.Count - 1 Do
        LArray[I] := LLista[I];
      pHighlightCxGrid(ACanvas, AViewInfo, LArray);
      ADone := LLista.Count > 0;
    Finally
      FreeAndNil(LLista);
    End;
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.cxgSelecionarViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE:
      btnCancelar.Click;
    VK_RETURN:
      btnSelecionar.Click;
    VK_SPACE:
      btnSelecionar.Click;
    VK_UP:
      If cxgSelecionarView.DataController.RecNo <= 1 Then
        pSetFocus(edtPesquisar);
  End;

  If (Shift = ([ssCtrl])) And ((Key = Ord('l')) Or (Key = Ord('L'))) Then
  Begin
    pSetFocus(edtPesquisar);
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.cxgTemPermissaoViewStylesGetContentStyle
  (Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
  var AStyle: TcxStyle);
begin
  inherited;
  If ARecord.Index = TcxGridDBTableView(Sender).DataController.FocusedRowIndex Then
    AStyle := cxsFoco
  Else
    AStyle := cxsSemFoco
end;

procedure TfrmPermissaoAcessoAdicionarAutban.SelecionarTodos;
begin
  Try
    cdsSelecionar.DisableControls;
    cdsSelecionados.DisableControls;
    While Not cdsSelecionar.IsEmpty Do
    Begin
      btnSelecionar.Click;
      Application.ProcessMessages;
    End;
  Finally
    cdsSelecionar.EnableControls;
    cdsSelecionados.EnableControls;
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.SelecionarVarios;
Var
  LSelecionado: TfrmPermissaoAcessoAdicionarAutban.Selecionado;
  LSelecionados: TArray<TfrmPermissaoAcessoAdicionarAutban.Selecionado>;
begin
  LSelecionados := GetSelection(cxgSelecionarView.DataController);

  For LSelecionado In LSelecionados Do
  Begin
    cdsSelecionados.AppendRecord([LSelecionado.Tipo, LSelecionado.Codigo, LSelecionado.Descricao, LSelecionado.OpeSenLib]);
    If cdsSelecionar.Locate('tipo;codigo', varArrayOf([LSelecionado.Tipo, LSelecionado.Codigo]), []) Then
      cdsSelecionar.Delete;
  End;
end;

class function TfrmPermissaoAcessoAdicionarAutban.Selecionar(ACaption: String; ATemPermissao: TDataSet = nil;
  AFocoUsuario: Boolean = False): TArray<Selecionado>;
Var
  LForm: TfrmPermissaoAcessoAdicionarAutban;
begin
  SetLength(Result, 0);
  pCriarFormularios(TfrmPermissaoAcessoAdicionarAutban, LForm);
  Try
    LForm.FTemPermissao := ATemPermissao;
    LForm.FFocarUsuario := AFocoUsuario;
    LForm.lblDescricaoDireitoAcesso.Caption := ACaption;
    LForm.ShowModal;
    If LForm.FConfirmou Then
      Result := LForm.GetSelecionados;
  Finally
    pFreeAndNil(LForm);
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.edtPesquisarChange(Sender: TObject);
begin
  inherited;
  tmrPesquisar.Enabled := False;
  tmrPesquisar.Enabled := True;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.edtPesquisarEnter(Sender: TObject);
begin
  inherited;
  If edtPesquisar.Text = INFO_PESQUISA Then
    edtPesquisar.Clear;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.edtPesquisarExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtPesquisar.Text) Then
    edtPesquisar.Text := INFO_PESQUISA;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.edtPesquisarKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_DOWN, VK_RETURN:
      Begin
        cxgSelecionarView.DataController.ClearSelection;
        cxgSelecionarView.DataController.GotoFirst;
        pSetFocus(cxgSelecionar);
      End;
  End;
end;


procedure TfrmPermissaoAcessoAdicionarAutban.FocoUsuarioLogado;
begin
  If FFocarUsuario Then
  Begin
    cxgSelecionarView.DataController.GoToLast;
    pSetFocus(cxgSelecionar);
    If cdsSelecionar.Locate('tipo;codigo', VarArrayOf(['OPE', strLoginUsuarioLogado]), []) Then
      Exit;
  End;
  pSetFocus(edtPesquisar);
  cxgSelecionarView.DataController.GoToFirst;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.FormActivate(Sender: TObject);
begin
  inherited;
  Self.Caption := 'Direitos de Acesso (Autban)';
end;

procedure TfrmPermissaoAcessoAdicionarAutban.FormCreate(Sender: TObject);
begin
  inherited;
  FQryOperadores := fCriaQuery(Self);
  FQryGrupos := fCriaQuery(Self);
  cdsSelecionar.CreateDataSet;
  cdsSelecionados.CreateDataSet;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE:
      btnCancelar.Click;
  End;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.FormShow(Sender: TObject);
begin
  inherited;
  Try
    cdsSelecionar.DisableControls;
    CarregarOperadores;
    CarregarGrupos;
  Finally
    cdsSelecionar.EnableControls;
  End;
  FocoUsuarioLogado;
end;

procedure TfrmPermissaoAcessoAdicionarAutban.lblRemoverTodosClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(RemoverTodos, 'Removendo todos, Aguarde ...', '');
end;

procedure TfrmPermissaoAcessoAdicionarAutban.lblSelecionarTodosClick(Sender: TObject);
begin
  inherited;
  fExecutarModal(SelecionarTodos, 'Selecionando todos, Aguarde ...', '');
end;

end.
