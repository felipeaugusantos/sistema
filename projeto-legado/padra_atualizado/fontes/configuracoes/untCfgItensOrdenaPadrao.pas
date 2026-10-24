unit untCfgItensOrdenaPadrao;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls,
  Buttons, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Uni, UniDataSetProvider, UniClientDataSet, cxCheckBox, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider,
  StdCtrls, frxClass, frxExportCSVTestabilidade, cxButtons,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCfgItensOrdenaPadrao = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    dbgItensDBTableView1: TcxGridDBTableView;
    dbgItensLevel1: TcxGridLevel;
    dbgItens: TcxGrid;
    btnConfirma: TBitBtnLocked;
    BitBtn1: TBitBtnLocked;
    Panel1: TPanel;
    btnOrdCim: TBitBtnLocked;
    btnOrdBai: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOrdCimClick(Sender: TObject);
    procedure btnOrdBaiClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    cdsItensO : TUniClientDataSet;
    dtsItensO : TDataSource;
    stlName : TStringList;
    stlDataType  : TStringList;
    stlSize : TStringList;
    stlLabel : TStringList;
    function fCriarClientItens: TUniClientDataSet;
  public
    { Public declarations }
    strCampoCha : String; // Campo que armazena uma Chave descritiva
    strCampoSeq : String;// Campo que armazena a sequência na tabela
    procedure pAdicionarItem(strNome, strLabel: String; ftTipo: TFieldType; intTamanho: Integer = 0);
    procedure pIniciarDados;
    procedure pFinalizarDados;
    procedure pAdicionarDados(arrCampo, arrValor: Array Of String);
    procedure pAtualizarSeq(blnCima: Boolean);
    function fGetCopiaCds: TUniClientDataSet;
  end;

var
  frmCfgItensOrdenaPadrao: TfrmCfgItensOrdenaPadrao;

implementation

uses SysUtils, untFuncoesSimples, untTypesSistema;

{$R *.dfm}

{ TfrmCfgItensOrdenaPadrao }

procedure TfrmCfgItensOrdenaPadrao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfrmCfgItensOrdenaPadrao.btnOrdBaiClick(Sender: TObject);
begin
  inherited;
  pAtualizarSeq(False);
end;

procedure TfrmCfgItensOrdenaPadrao.btnOrdCimClick(Sender: TObject);
begin
  inherited;
  pAtualizarSeq(True);
end;

function TfrmCfgItensOrdenaPadrao.fCriarClientItens: TUniClientDataSet;
  Var
    intCnt : Integer;
    intSize : Integer;
begin
  Result := TUniClientDataSet.Create(nil);

  For intCnt := 0 To (stlName.Count-1) Do
  Begin
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name := stlName.Strings[intCnt];
      DataType := TFieldType(stlDataType.Objects[intCnt]);

      intSize := StrToIntDef(stlSize.Strings[intCnt], 0);
      If (intSize > 0) Then
        Size := intSize;

      Required := False;
    End;
  End;

  Result.CreateDataSet;

  For intCnt := 0 To (stlName.Count-1) Do
  Begin
    Result.FieldByName(stlName.Strings[intCnt]).DisplayLabel := stlLabel.Strings[intCnt];

    If TFieldType(stlDataType.Objects[intCnt]) = ftFloat Then
      TFloatField(Result.FieldByName(stlName.Strings[intCnt])).DisplayFormat := fDisplayFormat(2);
  End;
end;

function TfrmCfgItensOrdenaPadrao.fGetCopiaCds: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Nil);
  pCloneDataSet(Result, cdsItensO);
end;

procedure TfrmCfgItensOrdenaPadrao.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnConfirma);
end;

procedure TfrmCfgItensOrdenaPadrao.FormCreate(Sender: TObject);
begin
  inherited;
  stlName := TStringList.Create;
  stlSize := TStringList.Create;
  stlDataType := TStringList.Create;
  stlLabel := TStringList.Create;
end;

procedure TfrmCfgItensOrdenaPadrao.FormDestroy(Sender: TObject);
begin
  inherited;
  pFinalizarDados;

  FreeAndNil(stlName);
  FreeAndNil(stlSize);
  FreeAndNil(stlDataType);
  FreeAndNil(stlLabel);
end;

procedure TfrmCfgItensOrdenaPadrao.pAdicionarDados(arrCampo, arrValor: Array Of String);
  Var
    intCnt : Integer;
begin
  If (Assigned(cdsItensO)) And (cdsItensO.Active) Then
  Begin
    With cdsItensO Do
    Begin
      Append;

      For intCnt := Low(arrCampo) To High(arrCampo) Do
      Begin
        If (FindField(arrCampo[intCnt]) <> Nil) Then
          FieldByName(arrCampo[intCnt]).AsString := arrValor[intCnt];
      End;

      Post;
    End;

    cdsItensO.IndexFieldNames := strCampoSeq;
  End;
end;

procedure TfrmCfgItensOrdenaPadrao.pAdicionarItem(strNome, strLabel: String;
  ftTipo: TFieldType; intTamanho: Integer);
begin
  stlName.Add(strNome);
  stlDataType.AddObject(strNome, TObject(ftTipo));
  stlSize.Add(IntToStr(intTamanho));
  stlLabel.Add(strLabel);
end;

procedure TfrmCfgItensOrdenaPadrao.pFinalizarDados;
begin
  If Assigned(cdsItensO) Then
  Begin
    cdsItensO.Close;
    FreeAndNil(cdsItensO);
  End;

  If Assigned(dtsItensO) Then
    FreeAndNil(dtsItensO);
end;

procedure TfrmCfgItensOrdenaPadrao.pIniciarDados;
begin
  If stlName.Count <= 0 Then
    Raise Exception.Create('Nenhuma item foi informado na tela de [Itens Ordena Padrão]');

  pFinalizarDados;

  cdsItensO := fCriarClientItens;
  dtsItensO := TDataSource.Create(Self);
  dtsItensO.DataSet := cdsItensO;
  dbgItensDBTableView1.DataController.DataSource := dtsItensO;

  dbgItensDBTableView1.DataController.CreateAllItems;
//  dbgItensDBTableView1.ApplyBestFit();
end;

procedure TfrmCfgItensOrdenaPadrao.pAtualizarSeq(blnCima: Boolean);
  Var
    prcScroll: TprcScroll;
    strDescri: String;
    stlListag: TStringList;
    blnAltera: Boolean;
    intCnt : Integer;

  function fIndiceAceitavel(intIndice: Integer): Boolean;
    Var
      intCount : Integer;
  begin
    intCount := stlListag.Count;
    Result := Not ((intIndice < 0) Or (intIndice >= intCount));
  end;

begin
  btnOrdCim.Enabled := False;
  btnOrdbai.Enabled := False;
  stlListag := TStringList.Create;
  strDescri := cdsItensO.FieldByName(strCampoCha).AsString;
  blnAltera := False;
  pDisableControls(cdsItensO, prcScroll);
  Try
    With cdsItensO Do
    Begin
      stlListag.Clear;

      First;
      While Not Eof Do
      Begin
        stlListag.Add(FieldByName(strCampoCha).AsString);
        Next;
      End;

      If (blnCima) And (fIndiceAceitavel(stlListag.IndexOf(strDescri)-1)) Then
      Begin
        stlListag.Exchange(stlListag.IndexOf(strDescri), stlListag.IndexOf(strDescri)-1);
        blnAltera := True;
      End
      Else If (Not blnCima) And (fIndiceAceitavel(stlListag.IndexOf(strDescri)+1)) Then
      Begin
        stlListag.Exchange(stlListag.IndexOf(strDescri), stlListag.IndexOf(strDescri)+1);
        blnAltera := True;
      End;

      If blnAltera Then
      Begin
        For intCnt := 0 To (stlListag.Count -1) Do
        Begin
          If cdsItensO.Locate(strCampoCha, stlListag.Strings[intCnt], []) Then
          Begin
            Edit;
            FieldByName(strCampoSeq).AsInteger := intCnt;
            Post;
          End;
        End;
      End;

      cdsItensO.Locate(strCampoCha, strDescri, []);
    End;
  Finally
    pEnableControls(cdsItensO, prcScroll);
    btnOrdCim.Enabled := True;
    btnOrdbai.Enabled := True;
  End;

  FreeAndNil(stlListag);

  cdsItensO.IndexFieldNames := strCampoSeq;
  pSetFocus(dbgItens);
end;

end.
