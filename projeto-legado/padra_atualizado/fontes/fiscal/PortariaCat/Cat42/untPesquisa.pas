unit untPesquisa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls, Buttons, DB, DBClient,
  Provider, Uni, Contnrs, untClassPanelCx, cxVGrid;

type
  TRecFiltro = Record
    strNomCam: String;
    varValor: Variant;
  End;

  TArrFiltro = Array Of TRecFiltro;

  TDefFiltro = Class(TObject)
  Private
    FRecNo,
    FIndRow : Integer;
    FChave  : String;
    FFiltros: TArrFiltro;
  Public
    Procedure pCarregaFiltros(cxgPesquisa: TcxVerticalGrid);
    Procedure pSalvaFiltros(cxgPesquisa: TcxVerticalGrid; intRecNo: Integer);

    property strChave:  String  Read FChave  Write FChave;
    property intRecNo:  Integer Read FRecNo  Write FRecNo;
    property intIndRow: Integer Read FIndRow Write FIndRow;
  End;

  TPesquisa = Class(TObject)
  Private
    FRecNo,
    FIndRow : Integer;
    FPosFil: Integer;
    FLisFil: TObjectList;
  Public
    constructor Create; Reintroduce;
    Destructor Destroy; override;

    Procedure pCarregaFiltros(arrFiltros: TarrFiltros; strChave: String; cxgPesquisa: TcxVerticalGrid; blnTestaFiltro: Boolean);
    Procedure pSalvaFiltros(cxgPesquisa: TcxVerticalGrid; intRecNo: Integer);
    Function fCarregaFiltrosParametros(arrFiltros: TarrFiltros; cxgPesquisa: TcxVerticalGrid): Boolean;

    property intRecNo: Integer Read FRecNo  Write FRecNo;
    property intIndRow: Integer Read FIndRow Write FIndRow;
  End;

type
  TfrmPesquisa = class(TForm)
    Panel5: TPanel;
    dbgPesq: TDBGrid;
    pnlBotoes: TPanel;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    Epesq: TEdit;
    Label1: TLabel;
    cdsTabela: TClientDataSet;
    dtsTabela: TDataSource;
    dspTabela: TDataSetProvider;
    lbxCampos: TListBox;
    Label2: TLabel;
    btnConfirma: TButton;
    btnSair: TButton;
    procedure rbCodigoClick(Sender: TObject);
    procedure rbSerieClick(Sender: TObject);
    procedure rbMarcaClick(Sender: TObject);
    procedure rbModeloClick(Sender: TObject);
    procedure rbDescricaoClick(Sender: TObject);
    procedure EpesqEnter(Sender: TObject);
    procedure EpesqChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EpesqExit(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EpesqKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgPesqKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    stlCamposindices: TStringList;
    stlIndDescr     : TStringList;

    dtsTabOrigem: Tdataset;
  end;

var
  objPesquisa: TPesquisa;
  frmPesquisa: TfrmPesquisa;

implementation

uses untFuncoes;


{$R *.dfm}

procedure TfrmPesquisa.rbCodigoClick(Sender: TObject);
begin
  cdsTabela.IndexFieldNames := cdsTabela.Fields[0].FieldName;
  cdsTabela.First;
  Epesq.SetFocus;
end;

procedure TfrmPesquisa.rbSerieClick(Sender: TObject);
begin
  cdsTabela.IndexFieldNames := cdsTabela.Fields[1].FieldName;
  cdsTabela.First;
  Epesq.SetFocus;
end;

procedure TfrmPesquisa.rbMarcaClick(Sender: TObject);
begin
  cdsTabela.IndexFieldNames := cdsTabela.Fields[2].FieldName;
  cdsTabela.First;
  Epesq.SetFocus;
end;

procedure TfrmPesquisa.rbModeloClick(Sender: TObject);
begin
  cdsTabela.IndexFieldNames := cdsTabela.Fields[3].FieldName;
  cdsTabela.First;
  Epesq.SetFocus;
end;

procedure TfrmPesquisa.rbDescricaoClick(Sender: TObject);
begin
  cdsTabela.IndexFieldNames := cdsTabela.Fields[4].FieldName;
  cdsTabela.First;
  Epesq.SetFocus;
end;

procedure TfrmPesquisa.EpesqEnter(Sender: TObject);
begin
  Epesq.Text := '';
  pnlInfo.Caption := 'Digite a pesquisa e tecle "Enter" para confirmar.';
end;

procedure TfrmPesquisa.EpesqChange(Sender: TObject);
begin
  if UpperCase(cdsTabela.IndexFieldNames) = cdsTabela.Fields[0].FieldName then
    cdsTabela.FindNearest([fStrZero(Epesq.Text,005)])
  else
    cdsTabela.FindNearest([Epesq.Text]);
end;

procedure TfrmPesquisa.FormCreate(Sender: TObject);
begin
  pnlNomeForm.Caption := Tform(Sender).Name;
  {********************************************************************}
  {* CRIA LISTAS PARA INDICES E DESCRICAO DE INDICES                  *}
  {****************************************************DEZ/2009***[AM]*}

  stlCamposIndices := TStringList.Create;
  stlIndDescr      := TStringList.Create;

end;

procedure TfrmPesquisa.EpesqExit(Sender: TObject);
begin
  pnlInfo.Caption := '';
end;

procedure TfrmPesquisa.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPesquisa.FormShow(Sender: TObject);
  Var i: integer;
begin
  Try
    dspTabela.DataSet := dtsTabOrigem;

    cdsTabela.FieldDefs.Clear;

    For i:=1 To stlCamposIndices.Count - 1 Do
    begin
      cdsTabela.FieldDefs.Add(stlCamposIndices[i],
                              dtsTabOrigem.FindField(stlCamposIndices[i]).DataType,
                              dtsTabOrigem.FindField(stlCamposIndices[i]).Size,
                              False );
    end;

    pnlInfo.Caption := 'Aguarde, abrindo arquivo...';
    Application.ProcessMessages;
    cdsTabela.Open;
    cdsTabela.IndexFieldNames := cdsTabela.Fields[0].FieldName;
    cdsTabela.First;
    Epesq.SetFocus;
    pnlInfo.Caption := '';
    Application.ProcessMessages;

  Except
    On E: EDatabaseError Do
    begin
      showMessage(E.Message);
    end;
    On E: Exception Do
    begin
      pMensagensErro(E.Message, '[Inserir Registro]');
    end;
  end;

end;

procedure TfrmPesquisa.EpesqKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnConfirmaClick(nil);
end;

procedure TfrmPesquisa.btnConfirmaClick(Sender: TObject);
begin
  btnSairClick(Nil);
end;

procedure TfrmPesquisa.dbgPesqKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnConfirmaClick(nil);
end;

{ TPesquisa }

constructor TPesquisa.Create;
begin
  Inherited Create;

  FLisFil := TObjectList.Create;
  FPosFil := -1;
end;

destructor TPesquisa.Destroy;
begin
  inherited;
  FreeAndNil(FLisFil);
end;

function TPesquisa.fCarregaFiltrosParametros(arrFiltros: TarrFiltros; cxgPesquisa: TcxVerticalGrid): Boolean;
  Var
    intContador,
    intFiltro: Integer;
Begin
  Result := False;

  If (Not Assigned(arrFiltros)) Or (Length(arrFiltros) = 0) Then
    Exit;

  For intContador := 1 To cxgPesquisa.Rows.Count - 1 Do
  Begin
    if Not cxgPesquisa.Rows[intContador].Visible then
      Break;

    For intFiltro := Low(arrFiltros) To High(arrFiltros) Do
    Begin
      If (arrFiltros[intFiltro].strNomCam = cxgPesquisa.Rows[intContador].Name) Then
      Begin
        Result := True;
        TcxEditorRow(cxgPesquisa.Rows[intContador]).Properties.Value := arrFiltros[intFiltro].strInfCam;
      End;
    End;

  End;
end;

procedure TPesquisa.pCarregaFiltros(arrFiltros: TarrFiltros; strChave: String; cxgPesquisa: TcxVerticalGrid; blnTestaFiltro: Boolean);
  Var
    intContador: Integer;
    objFiltro: TDefFiltro;
    blnAchou: Boolean;
Begin
  blnAchou := False;

  FIndRow := 1;
  FRecNo  := 1;

  For intContador := 0 To FLisFil.Count - 1 Do
  Begin
    objFiltro := TDefFiltro(FLisFil.Items[intContador]);

    If objFiltro.strChave = strChave then
    Begin
      FPosFil := intContador;

      If (Not blnTestaFiltro) Or
         ((Not Assigned(arrFiltros)) Or (Length(arrFiltros) = 0)) Then
        objFiltro.pCarregaFiltros(cxgPesquisa);

      FIndRow :=  objFiltro.intIndRow;
      FRecNo  :=  objFiltro.intRecNo;

      blnAchou := True;
      Break;
    End;

  End;

  If Not blnAchou Then
  Begin
    objFiltro          := TDefFiltro.Create;
    objFiltro.strChave := strChave;
    FPosFil            := FLisFil.Add(objFiltro);
  End;

end;

procedure TPesquisa.pSalvaFiltros(cxgPesquisa: TcxVerticalGrid; intRecNo: Integer);
  Var
    objFiltro: TDefFiltro;
Begin
  if FPosFil > -1 then
  Begin
    objFiltro := TDefFiltro(FLisFil.Items[FPosFil]);
    objFiltro.pSalvaFiltros(cxgPesquisa, intRecNo);
  End;
end;

{ TDefFiltro }

procedure TDefFiltro.pCarregaFiltros(cxgPesquisa: TcxVerticalGrid);
  Var
    intContador,
    intFiltro: Integer;
Begin

  For intContador := 1 To cxgPesquisa.Rows.Count - 1 Do
  Begin
    if Not cxgPesquisa.Rows[intContador].Visible then
      Break;

    For intFiltro := Low(FFiltros) To High(FFiltros) Do
    Begin
      If (FFiltros[intFiltro].strNomCam = cxgPesquisa.Rows[intContador].Name) Then
        TcxEditorRow(cxgPesquisa.Rows[intContador]).Properties.Value := FFiltros[intFiltro].varValor;
    End;

  End;

  If cxgPesquisa.Rows.Count > FIndRow Then
    cxgPesquisa.FocusRow(cxgPesquisa.Rows[FIndRow]);
end;

procedure TDefFiltro.pSalvaFiltros(cxgPesquisa: TcxVerticalGrid; intRecNo: Integer);
  Var
    intContador: Integer;
Begin
  FRecNo  := intRecNo;

  If Assigned(cxgPesquisa.FocusedRow) Then
    FIndRow := cxgPesquisa.FocusedRow.Index
  Else
    FIndRow := 1;

  SetLength(FFiltros, Pred(cxgPesquisa.Rows.Count));

  For intContador := 1 To cxgPesquisa.Rows.Count - 1 Do
  Begin
    FFiltros[Pred(intContador)].strNomCam := cxgPesquisa.Rows[intContador].Name;
    FFiltros[Pred(intContador)].varValor  := TcxEditorRow(cxgPesquisa.Rows[intContador]).Properties.Value;
  End;
end;

Initialization
  objPesquisa := TPesquisa.Create;
Finalization
  FreeAndNil(objPesquisa);

end.
