unit ImportacaoDados.View.EditorCamposModeloArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid,
  Vcl.Samples.Spin, strUtils, fs_iinterpreter, cxCheckBox, ImportacaoDados.Interfaces,
  Uni, untZClient, Datasnap.DBClient, UniClientDataSet, Vcl.ComCtrls;

type
  TfrmEditorCamposModeloArquivo = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxCampos: TcxGrid;
    cxCamposTableView: TcxGridDBTableView;
    cxCamposLvl: TcxGridLevel;
    dtsCampos: TDataSource;
    cxCamposCampo: TcxGridDBColumn;
    cxCamposColunaExcel: TcxGridDBColumn;
    edtDescricaoModelo: TEdit;
    Label1: TLabel;
    fsScript1: TfsScript;
    cxCamposObrigatorio: TcxGridDBColumn;
    cdsCamposArquivo: TUniClientDataSet;
    cdsCamposArquivoAUTOINCREM: TStringField;
    cdsCamposArquivoCMP_SEQARQ: TStringField;
    cdsCamposArquivoCMP_DESCAM: TStringField;
    cdsCamposArquivoCMP_OBRCAM: TStringField;
    cdsCamposArquivoCMP_TIPCAM: TStringField;
    cdsCamposArquivoCMP_NOMCAM: TStringField;
    cdsCamposArquivoCMP_COLCAM: TStringField;
    cdsCamposArquivoCMP_POSCAM: TIntegerField;
    cdsCamposArquivoCMP_CODCAM: TStringField;
    cdsCamposArquivoCMP_TAMCAM: TIntegerField;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cdsCamposArquivoBeforePost(DataSet: TDataSet);
    procedure cdsCamposArquivoPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }

    procedure pCarregaCampos;
    procedure pSetaCampos;
    function fSetaCampos: Boolean;
    function fPossuiColunasDuplicadas: Boolean;
  public
    ObjImportaPlanilha: IImportaPlanilha;
    ObjModeloArquivo: IModeloArquivoImportacao;
    ObjCampoArquivo: ICamposModeloArquivo;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmEditorCamposModeloArquivo.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  ObjModeloArquivo.Descricao := edtDescricaoModelo.Text;
end;

procedure TfrmEditorCamposModeloArquivo.cdsCamposArquivoBeforePost(
  DataSet: TDataSet);
begin
  If (DataSet.FieldByName('CMP_COLCAM').ASString = EmptyStr) Then
  Begin
     If (DataSet.FieldByName('CMP_OBRCAM').ASString = 'S') Then
     Begin
       DataSet.FieldByName('CMP_COLCAM').AsString := DataSet.FieldByName('CMP_COLCAM').OldValue;
       pMensagemOk('A coluna dos campos obrigatórios deverá ser informada.');
     End;
     Exit;
  End;

  If Not fVerificaSomenteLetra(Uppercase(DataSet.FieldByName('CMP_COLCAM').AsString)) Then
  Begin
    DataSet.FieldByName('CMP_COLCAM').AsString := DataSet.FieldByName('CMP_COLCAM').OldValue;
    pMensagemOk('Apenas letras são permitidas, pois este campo representa a coluna do Excel.');
    Exit;
  End;

  DataSet.FieldByName('CMP_COLCAM').AsString := AnsiUpperCase(DataSet.FieldByName('CMP_COLCAM').AsString);
  DataSet.FieldByName('CMP_TAMCAM').AsInteger:= Length(DataSet.FieldByName('CMP_COLCAM').AsString);


  inherited;
end;

procedure TfrmEditorCamposModeloArquivo.cdsCamposArquivoPostError(
  DataSet: TDataSet; E: EDatabaseError; var Action: TDataAction);
begin
  If not fEmptyStr(DataSet.FieldByName('CMP_COLCAM').AsString) then
  Begin
    If Pos('Key violation', E.Message) > 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Coluna duplicada. Verifique!', ['&Ok']);
      Action := daAbort;
      Exit;
    End;
  End;
end;

procedure TfrmEditorCamposModeloArquivo.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;

  If (ModalResult = mrOk) And (Not fSetaCampos) Then
  Begin
    CanClose := False;
  End
  Else
    CanClose := True;
end;

procedure TfrmEditorCamposModeloArquivo.FormCreate(Sender: TObject);
begin
  inherited;

  cdsCamposArquivo.IndexDefs.Add('IDX1','CMP_TAMCAM;CMP_COLCAM', []);
  cdsCamposArquivo.IndexFieldNames := 'CMP_POSCAM';
  cdsCamposArquivo.IndexName := 'IDX1';
  cdsCamposArquivo.CreateDataSet;
end;

procedure TfrmEditorCamposModeloArquivo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10 : btnConfirma.Click;
  End;

end;

procedure TfrmEditorCamposModeloArquivo.FormShow(Sender: TObject);
begin
  inherited;

  If Assigned(ObjModeloArquivo) Then
    edtDescricaoModelo.Text := ObjModeloArquivo.Descricao;

  If Assigned(ObjImportaPlanilha) Then
  Begin
    If ObjImportaPlanilha.EstadoTela = tpVisualizacao Then
      cxCamposTableView.OptionsData.Editing := False;

    pCarregaCampos;
  End;
end;

function TfrmEditorCamposModeloArquivo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Sender = edtDescricaoModelo Then
  Begin
    If fEmptyStr(edtDescricaoModelo.Text) Then
    Begin
      Result := False;
      pMensagemOk('A descrição do modelo deve ser preenchido.');
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmEditorCamposModeloArquivo.pCarregaCampos;
var
  intCont: Integer;
begin
  cdsCamposArquivo.EmptyDataSet;
  cdsCamposArquivo.Close;
  cdsCamposArquivo.Open;

  If ObjImportaPlanilha.EstadoTela = tpInsercao Then
  Begin
    ObjModeloArquivo.fCarregarCamposPadrao;
  End
  Else
    ObjModeloArquivo.fCarregarCampos;

  For  intCont := ObjModeloArquivo.Campos.Count -1 Downto 0 Do
  Begin
    cdsCamposArquivo.Insert;
    cdsCamposArquivo.FieldByName('AUTOINCREM').AsString := ObjModeloArquivo.Campos[intCont].AutInc;
    cdsCamposArquivo.FieldByName('CMP_CODCAM').AsString := ObjModeloArquivo.Campos[intCont].Codigo;
    cdsCamposArquivo.FieldByName('CMP_NOMCAM').AsString := ObjModeloArquivo.Campos[intCont].NomeCampo;
    cdsCamposArquivo.FieldByName('CMP_SEQARQ').AsString := ObjModeloArquivo.Campos[intCont].CodModelo;
    cdsCamposArquivo.FieldByName('CMP_DESCAM').AsString := ObjModeloArquivo.Campos[intCont].Descricao;
    cdsCamposArquivo.FieldByName('CMP_OBRCAM').AsString := ObjModeloArquivo.Campos[intCont].Obrigatorio;
    cdsCamposArquivo.FieldByName('CMP_POSCAM').AsInteger:= ObjModeloArquivo.Campos[intCont].Posicao;
    cdsCamposArquivo.FieldByName('CMP_COLCAM').AsString := ObjModeloArquivo.Campos[intCont].Coluna;
    cdsCamposArquivo.FieldByName('CMP_TAMCAM').AsInteger := Length(cdsCamposArquivo.FieldByName('CMP_COLCAM').AsString);
    cdsCamposArquivo.Post;
  End;

end;

procedure TfrmEditorCamposModeloArquivo.pSetaCampos;
var
  LIntCont: Integer;
  LPosicao: Integer;
begin

  LPosicao := 0;

  cdsCamposArquivo.DisableControls;
  try
    cdsCamposArquivo.First;
    While Not cdsCamposArquivo.Eof Do
    Begin
      For LIntCont := 0 to ObjModeloArquivo.Campos.Count-1 Do
      Begin
        If ObjModeloArquivo.Campos[LIntCont].NomeCampo = cdsCamposArquivo.FieldByName('CMP_NOMCAM').AsString Then
        Begin
          ObjModeloArquivo.Campos[LIntCont].Coluna := AnsiUpperCase( cdsCamposArquivo.FieldByName('CMP_COLCAM').AsString);
          ObjModeloArquivo.Campos[LIntCont].Posicao := LPosicao;
        End;
      End;

      Inc(LPosicao);
      cdsCamposArquivo.Next;
    End;
  Finally
    cdsCamposArquivo.EnableControls;
  End;
end;

function TfrmEditorCamposModeloArquivo.fPossuiColunasDuplicadas: Boolean;
var
  LDuplicados: TStringList;
begin
  Result := False;

  LDuplicados := TStringList.Create;
  LDuplicados.Sorted := True;

  cdsCamposArquivo.DisableControls;
  try
    cdsCamposArquivo.First;
    While Not cdsCamposArquivo.Eof Do
    Begin
      If ( LDuplicados.IndexOf(cdsCamposArquivo.FieldByName('CMP_COLCAM').AsString) <> -1 ) Then
      Begin
        Result := True;
        Break
      End
      Else
        LDuplicados.Add(cdsCamposArquivo.FieldByName('CMP_COLCAM').AsString);

      cdsCamposArquivo.Next;
    End;
  Finally
    cdsCamposArquivo.EnableControls;
    FreeAndNil(LDuplicados);
  End;
end;

function TfrmEditorCamposModeloArquivo.fSetaCampos: Boolean;
Begin
  Result := True;

  If fPossuiColunasDuplicadas Then
  Begin
    fMensagem('ATENÇÃO!', 'O Modelo possui colunas duplicadas. Verifique!', ['&Ok']);
    Exit(False);
  End;

  pSetaCampos;
End;

end.
